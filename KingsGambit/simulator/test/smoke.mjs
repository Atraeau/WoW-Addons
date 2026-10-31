// Opens the built simulator page in headless Chromium and plays every lesson (see smoke-driver.js).
// Usage (from the KingsGambit folder; needs `npm install playwright` and `npx playwright install chromium`):
//   node simulator/test/smoke.mjs [simulator/index.html]
import { readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { chromium } from "playwright";

const here = dirname(fileURLToPath(import.meta.url));
const page_ = resolve(process.argv[2] || resolve(here, "..", "index.html"));
const driver = readFileSync(resolve(here, "smoke-driver.js"), "utf8");

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1280, height: 900 } });
const errors = [];
page.on("pageerror", (e) => errors.push("page error: " + e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push("console: " + m.text()); });

await page.goto(pathToFileURL(page_).href);
await page.waitForSelector("button[data-act=scenario]", { timeout: 60000 });
const result = await page.evaluate(`(${driver})()`);
await browser.close();

for (const line of result.played) console.log("  played  " + line);
const problems = [...result.problems, ...errors];
if (problems.length) {
  for (const p of problems) console.error("  PROBLEM " + p);
  process.exit(1);
}
console.log(`simulator smoke test: ${result.played.length} lessons and nights, no problems`);
