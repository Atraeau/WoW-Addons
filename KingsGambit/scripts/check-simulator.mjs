// Syntax-checks every JavaScript <script> in the built simulator page (the Lua ones are checked by the engine's own
// tests). Catches a quote mismatch in the page template before it reaches the live page.
// Usage (from the KingsGambit folder):  node scripts/check-simulator.mjs [simulator/index.html]
import { readFileSync } from "node:fs";
import vm from "node:vm";

const file = process.argv[2] || "simulator/index.html";
const html = readFileSync(file, "utf8");
let checked = 0;
let bad = 0;
for (const m of html.matchAll(/<script(\s[^>]*)?>([\s\S]*?)<\/script>/g)) {
  const type = ((m[1] || "").match(/type\s*=\s*["']([^"']*)["']/) || [])[1];
  if (type && type !== "text/javascript") continue; // e.g. application/lua
  checked++;
  const startLine = html.slice(0, m.index).split("\n").length - 1;
  try {
    new vm.Script(m[2], { filename: file, lineOffset: startLine });
  } catch (e) {
    bad++;
    console.error(`${file}: script #${checked} (starts at line ${startLine + 1}): ${e.message}`);
    console.error(String(e.stack).split("\n").slice(0, 4).join("\n"));
  }
}
if (checked === 0) {
  console.error(`${file}: no JavaScript <script> found: is this the built page?`);
  process.exit(1);
}
console.log(`${file}: ${checked} script(s) parse${bad ? `, ${bad} FAILED` : " cleanly"}`);
process.exit(bad ? 1 : 0);
