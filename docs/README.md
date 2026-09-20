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

## Output layout

```
docs/api/
├─ README.md          # index: every namespace with function/event/type counts
├─ C_UnitAuras.md     # one file per C_* namespace
├─ C_Spell.md
├─ ...
└─ GlobalFuncs.md     # non-namespaced global functions
```

Each function is documented as: description → `signature` → argument table →
returns table → an illustrative example call.

> Note: the client's docs provide signatures, types, and descriptions but not prose
> usage examples, so the example lines are auto-synthesized from each signature and
> meant as a starting point. Curate richer examples over time.
