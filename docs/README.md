# WoW: Forever API documentation

A Markdown reference for the **confirmed** modern WoW API surface — generated from the
running client's own `APIDocumentation` (the data behind the in-game `/api` command),
so it reflects exactly what this client (build/interface) actually supports rather than
any external assumption.

## How to (re)generate

1. **Export from the client** — in game, with the `WowApiExport` addon enabled:
   ```
   /apiexport      (it also runs automatically on login)
   /reload         (SavedVariables only flush to disk on reload/logout)
   ```
   This writes `WTF/Account/<acct>/SavedVariables/WowApiExport.lua`, containing a
   base64-encoded JSON payload (`WowApiExportB64`) plus a human-readable Lua table.

2. **Generate the Markdown** — from the repo root:
   ```powershell
   .\scripts\generate-api-docs.ps1
   ```
   It auto-locates the newest `WowApiExport.lua`, decodes the payload, and writes one
   file per namespace into [`docs/api/`](api/) plus an index.

## Editor autocomplete (Lua Language Server)

`scripts/generate-lua-definitions.ps1` turns the same dump into
[`types/WowForeverAPI.lua`](../types/WowForeverAPI.lua) — LuaCATS annotations for every
function (typed params/returns), enum (`Enum.*` tables), and struct (`@class`). The Lua
Language Server picks it up via `Lua.workspace.library` in `.vscode/settings.json`, so
completion and hover in `src/` match this client exactly. Regenerate after a client update.

## Output layout

Namespaces are grouped into category folders (rules in
[`scripts/api-categories.psd1`](../scripts/api-categories.psd1) — edit and regenerate to
re-shape the grouping):

```
docs/api/
├─ README.md                       # top index: groups with counts
├─ Spells-Auras-Talents/
│  ├─ README.md                    # group index: its namespaces
│  ├─ C_Spell.md                   # one file per C_* namespace
│  └─ ...
├─ Items-Inventory/
│  └─ ...
└─ Miscellaneous/                  # anything the rules didn't match
```

Each namespace page has a breadcrumb back to its group and the top index. Each function
is documented as: description → `signature` → argument table → returns table → example.

## Examples

Each function shows an example call:

- **Curated** — hand-written, runnable snippets for common functions, kept in
  [`scripts/api-examples.psd1`](../scripts/api-examples.psd1) keyed by `Namespace.Function`
  (or bare `Function` for globals). Add entries there to grow coverage; the generator
  warns about keys that don't match a documented function.
- **Auto-generated** — for everything else, synthesized from the signature. These are
  labelled *(auto-generated from the signature — illustrative)* and use realistic values
  where possible (e.g. real `Enum.<Type>.<Value>` constants for enum arguments,
  `"player"` for unit tokens).
