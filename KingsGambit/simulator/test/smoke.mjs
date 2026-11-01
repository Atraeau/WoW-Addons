// Opens the built simulator page in headless Chromium and plays every lesson (see smoke-driver.js).
// Usage (from the KingsGambit folder; needs `npm install playwright` and `npx playwright install chromium`):
//   node simulator/test/smoke.mjs [simulator/index.html]
import { readFileSync } from "node:fs";
import { createServer } from "node:http";
import { resolve, dirname } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { chromium } from "playwright";

const here = dirname(fileURLToPath(import.meta.url));
const page_ = resolve(process.argv[2] || resolve(here, "..", "index.html"));
const driver = readFileSync(resolve(here, "smoke-driver.js"), "utf8");

// The page is served the way a slow connection delivers it: in pieces, with gaps. A page that only starts when its whole
// text arrives at once (opening the file locally) passed this test once and was broken on the live site.
const html = readFileSync(page_);
const server = createServer(async (req, res) => {
  res.writeHead(200, { "content-type": "text/html; charset=utf-8" });
  for (let i = 0; i < html.length; i += 40000) {
    res.write(html.subarray(i, i + 40000));
    await new Promise((r) => setTimeout(r, 25));
  }
  res.end();
});
await new Promise((r) => server.listen(0, "127.0.0.1", r));
const url = `http://127.0.0.1:${server.address().port}/`;

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1280, height: 900 } });
const errors = [];
page.on("pageerror", (e) => errors.push("page error: " + e.message));
page.on("console", (m) => { if (m.type() === "error") errors.push("console: " + m.text()); });

await page.goto(url);
await page.waitForSelector("button[data-act=scenario]", { timeout: 60000 });
const result = await page.evaluate(`(${driver})()`);

// and from a local file, where it arrives all at once
const local = await browser.newPage();
local.on("pageerror", (e) => errors.push("file page error: " + e.message));
await local.goto(pathToFileURL(page_).href);
await local.waitForSelector("button[data-act=scenario]", { timeout: 60000 });
await browser.close();
server.close();

for (const line of result.played) console.log("  played  " + line);
const problems = [...result.problems, ...errors];
if (problems.length) {
  for (const p of problems) console.error("  PROBLEM " + p);
  process.exit(1);
}
console.log(`simulator smoke test: ${result.played.length} lessons and nights, no problems`);
