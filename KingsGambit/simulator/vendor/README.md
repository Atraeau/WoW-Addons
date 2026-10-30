# Vendored: fengari-web 0.1.4

[fengari](https://fengari.io) is a Lua VM written in JavaScript (a port of Lua 5.3). The simulator page inlines this
file so it works with no network and no CDN. It is MIT-licensed (Copyright Benoit Giannangeli and Daurnimator).

- Source: `https://cdn.jsdelivr.net/npm/fengari-web@0.1.4/dist/fengari-web.js`
- Verified byte-for-byte against the integrity hash the page used to pin from the CDN:
  `sha384-aqYZ5bBpWDOXcXQUTRXOLnaFjrqrMw1BiHjk/1cz75A3ytQtdNkW1QfTe7kTlLR6`
- To check it again: `openssl dgst -sha384 -binary fengari-web.js | openssl base64 -A`

Do not edit it. To upgrade, replace the file, update the version and hash here, and rebuild the page
(`lua scripts/build-simulator.lua`).
