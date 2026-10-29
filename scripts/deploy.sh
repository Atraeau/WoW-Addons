#!/usr/bin/env bash
# Link (or copy) every addon under src/ into the WoW: Forever AddOns folder.
# macOS and Linux counterpart of deploy.ps1: same config file, same modes.
#
#   scripts/deploy.sh                 symlink all addons under src/
#   scripts/deploy.sh --name MyAddon  only the named addon(s); repeatable
#   scripts/deploy.sh --copy          copy instead of link
#   scripts/deploy.sh --clean         remove the deployed link/copy
#
# Reads wow-dev.config.json, with wow-dev.config.local.json overriding any key.
# On a Mac the default gamePath is "/Applications/World of Warcraft", so a
# local override like this is usually all that is needed:
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
		--name) shift; names+=("$1") ;;
		-h|--help) sed -n '2,15p' "$0"; exit 0 ;;
		*) echo "unknown option: $1" >&2; exit 2 ;;
	esac
	shift
done

# --- Load config (base + local override), via python3 since macOS ships it ---
readConfig() {
	python3 - "$repoRoot/wow-dev.config.json" "$repoRoot/wow-dev.config.local.json" "$1" <<'PY'
import json, os, sys
base, local, key = sys.argv[1:4]
cfg = json.load(open(base))
if os.path.exists(local):
    cfg.update(json.load(open(local)))
print(cfg.get(key, ""))
PY
}
[ -f "$repoRoot/wow-dev.config.json" ] || { echo "Missing config: $repoRoot/wow-dev.config.json" >&2; exit 1; }
gamePath="$(readConfig gamePath)"
flavorDir="$(readConfig flavorDir)"
if [ "$(uname)" = "Darwin" ] && [ ! -d "$gamePath" ] && [ -d "/Applications/World of Warcraft" ]; then
	gamePath="/Applications/World of Warcraft"
fi
addonsDir="$gamePath/$flavorDir/Interface/AddOns"
if [ ! -d "$addonsDir" ]; then
	echo "AddOns folder not found: $addonsDir" >&2
	echo "Set gamePath / flavorDir in wow-dev.config.local.json." >&2
	exit 1
fi

# --- Select addons ------------------------------------------------------------
[ -d "$srcDir" ] || { echo "No src/ folder at $srcDir" >&2; exit 1; }
selected=()
for d in "$srcDir"/*/; do
	[ -d "$d" ] || continue
	n="$(basename "$d")"
	if [ ${#names[@]} -gt 0 ]; then
		keep=0
		for want in "${names[@]}"; do [ "$want" = "$n" ] && keep=1; done
		[ $keep -eq 1 ] || continue
	fi
	selected+=("$n")
done
[ ${#selected[@]} -gt 0 ] || { echo "No matching addons found under src/." >&2; exit 1; }

for n in "${selected[@]}"; do
	target="$srcDir/$n"
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
