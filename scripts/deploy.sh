#!/usr/bin/env bash
# Link (or copy) every addon under src/ into the WoW: Forever AddOns folder. Self-contained projects are found
# too: a top-level folder whose src/ holds <Project>.toc (KingsGambit/src/KingsGambit.toc) is an addon named after it.
# macOS and Linux counterpart of deploy.ps1: same config file, same modes.
#
#   scripts/deploy.sh                 symlink all addons under src/
#   scripts/deploy.sh --name MyAddon  only the named addon(s); repeatable
#   scripts/deploy.sh --copy          copy instead of link
#   scripts/deploy.sh --clean         remove the deployed link/copy
#
# Reads wow-dev.config.json, with wow-dev.config.local.json overriding any key.
# The default flavorDir is _forever_ (the released client; use _classic_beta_ for the beta).
# On a Mac, if the configured gamePath does not exist, /Applications/World of Warcraft is
# used when present; otherwise override it locally:
#   { "gamePath": "/Applications/World of Warcraft" }
# A symlink here plays the role the junction plays on Windows: the game reads
# your source live, so a Lua edit only needs /reload in game.
set -euo pipefail

repoRoot="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
srcDir="$repoRoot/src"
mode=link
names=()

while [ $# -gt 0 ]; do
	case "$1" in
		--copy) mode=copy ;;
		--clean) mode=clean ;;
		--name) [ $# -gt 1 ] || { echo "--name needs a value" >&2; exit 2; }; shift; names+=("$1") ;;
		-h|--help) sed -n '2,16p' "$0"; exit 0 ;;
		*) echo "unknown option: $1" >&2; exit 2 ;;
	esac
	shift
done

# --- Load config (base + local override) ---------------------------------------
# No hard dependency on python3: on macOS 12.3+ the python3 shim just triggers an
# Xcode Command Line Tools install prompt. Try, in order: osascript (always on macOS),
# jq, a python3 that really runs, then a plain sed lookup (flat string keys only,
# which is all the config uses).
baseCfg="$repoRoot/wow-dev.config.json"
localCfg="$repoRoot/wow-dev.config.local.json"
[ -f "$baseCfg" ] || { echo "Missing config: $baseCfg" >&2; exit 1; }

jxa='function run(a){var rd=function(p){var s=$.NSString.stringWithContentsOfFileEncodingError(p,$.NSUTF8StringEncoding,null);return s?JSON.parse(ObjC.unwrap(s)):null;};var c=rd(a[0])||{};var l=rd(a[1]);if(l){for(var k in l){c[k]=l[k];}}return c[a[2]]===undefined?"":String(c[a[2]]);}'

sedValue() { # sedValue <file> <key>: last "key": "value" in the file, if any
	[ -f "$1" ] || return 0
	sed -n 's/.*"'"$2"'"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$1" | tail -n 1
}

readConfig() {
	if [ "$(uname)" = "Darwin" ] && command -v osascript >/dev/null 2>&1; then
		osascript -l JavaScript -e "$jxa" "$baseCfg" "$localCfg" "$1" && return
	fi
	if command -v jq >/dev/null 2>&1; then
		local files=("$baseCfg"); [ -f "$localCfg" ] && files+=("$localCfg")
		jq -rs --arg k "$1" 'add | .[$k] // ""' "${files[@]}" && return
	fi
	if python3 -c 'import json' >/dev/null 2>&1; then
		python3 - "$baseCfg" "$localCfg" "$1" <<'PY' && return
import json, os, sys
base, local, key = sys.argv[1:4]
cfg = json.load(open(base))
if os.path.exists(local):
    cfg.update(json.load(open(local)))
print(cfg.get(key, ""))
PY
	fi
	local v; v="$(sedValue "$localCfg" "$1")"
	[ -n "$v" ] || v="$(sedValue "$baseCfg" "$1")"
	printf '%s\n' "$v"
}

gamePath="$(readConfig gamePath)"
flavorDir="$(readConfig flavorDir)"
if [ "$(uname)" = "Darwin" ] && [ ! -d "$gamePath" ] && [ -d "/Applications/World of Warcraft" ]; then
	gamePath="/Applications/World of Warcraft"
fi
addonsDir="$gamePath/$flavorDir/Interface/AddOns"
if [ ! -d "$addonsDir" ]; then
	echo "AddOns folder not found: $addonsDir" >&2
	if [ -d "$gamePath" ]; then
		echo "Game folders found under $gamePath that have an AddOns folder:" >&2
		for f in "$gamePath"/_*_/; do
			[ -d "${f}Interface/AddOns" ] && echo "  $(basename "$f")" >&2
		done
	fi
	echo "Set gamePath / flavorDir in wow-dev.config.local.json (the released Forever client is _forever_)." >&2
	exit 1
fi

# --- Select addons ------------------------------------------------------------
[ -d "$srcDir" ] || { echo "No src/ folder at $srcDir" >&2; exit 1; }
selected=()
candidates=()
for d in "$srcDir"/*/; do candidates+=("$(basename "$d")=${d%/}"); done
for p in "$repoRoot"/*/; do
	project="$(basename "$p")"
	[ "$project" = src ] && continue
	[ -f "$p/src/$project.toc" ] && candidates+=("$project=${p%/}/src")
done
for c in "${candidates[@]}"; do
	n="${c%%=*}"; d="${c#*=}"
	[ -d "$d" ] || continue
	if [ ${#names[@]} -gt 0 ]; then
		keep=0
		for want in "${names[@]}"; do [ "$want" = "$n" ] && keep=1; done
		[ $keep -eq 1 ] || continue
	fi
	selected+=("$n=$d")
done
[ ${#selected[@]} -gt 0 ] || { echo "No matching addons found under src/." >&2; exit 1; }

for s in "${selected[@]}"; do
	n="${s%%=*}"; target="${s#*=}"
	link="$addonsDir/$n"
	# Always remove any existing deployment first (link or copied folder).
	if [ -L "$link" ]; then
		rm "$link"                       # a link: remove the link only, never the target
	elif [ -e "$link" ]; then
		rm -rf "$link"
	fi
	case "$mode" in
		clean) echo "[clean]  $n" ;;
		copy)  cp -R "$target" "$link"; echo "[copy]   $n -> $link" ;;
		link)  ln -s "$target" "$link";  echo "[link]   $n -> $link" ;;
	esac
done

echo
echo "Done. AddOns folder: $addonsDir"
if [ "$mode" != clean ]; then
	echo "Tip: enable 'Load out of date AddOns' on the character select screen if anything is greyed out."
fi
