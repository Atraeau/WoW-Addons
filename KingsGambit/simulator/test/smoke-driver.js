// Drives the simulator page like a person would, inside the page (so it runs unchanged in a browser pane or under
// Playwright: see smoke.mjs). It is ONE async function expression, evaluated as `(<this file>)()`; it returns
// { problems: [...], played: [...] } and never throws, so the runner can print every problem at once.
//
// What it checks: every training scenario loads, can be played to the confirm button as a learner who passes on
// everything, and the three "fix a mistake" lessons can be finished with the Corrections card and then match the
// lesson. The page's own errors (uncaught exceptions) are collected too.
async () => {
  const problems = [];
  const played = [];
  const errors = [];
  window.addEventListener("error", (e) => errors.push(String(e.message)));
  window.addEventListener("unhandledrejection", (e) => errors.push("unhandled: " + String(e.reason)));
  window.confirm = () => true;
  window.prompt = () => "smoke test";

  const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
  const fire = (b) => b.dispatchEvent(new PointerEvent("pointerdown", { bubbles: true }));
  const buttons = () => [...document.querySelectorAll("button")];
  const btn = (act, text) => buttons().find((b) => b.dataset.act === act && (!text || b.textContent.includes(text)));
  const byText = (text) => buttons().find((b) => b.textContent.trim() === text);
  const waitFor = async (fn, ms) => {
    const end = Date.now() + ms;
    while (Date.now() < end) {
      const v = fn();
      if (v) return v;
      await sleep(100);
    }
    return null;
  };
  const headings = () => [...document.querySelectorAll("h2")].map((h) => h.textContent.trim());
  const fixRow = (member, item) =>
    [...document.querySelectorAll(".fixrow")].find((r) => r.innerText.includes(member) && r.innerText.includes(item));
  const choose = async (row, name) => {
    const sel = row.querySelector("select");
    sel.value = name;
    sel.dispatchEvent(new Event("change", { bubbles: true }));
    await sleep(150);
  };

  // The corrections a lesson asks for, by scenario title.
  const FIXES = {
    "Fixing a mistake": async () => fire(btn("fixUndo")),
    "The item went to someone else": async () => {
      await choose(fixRow("Brann", "Gauntlets of Might"), "Dara");
      fire(fixRow("Brann", "Gauntlets of Might").querySelector("[data-act=fixTrade]"));
    },
    "The item went to someone else, after a big hand-out": async () => {
      await choose(fixRow("Brann", "Brutality Blade"), "Hale");
      fire(fixRow("Brann", "Brutality Blade").querySelector("[data-act=fixTrade]"));
    },
  };

  const titles = buttons().filter((b) => b.dataset.act === "scenario").map((b) => b.textContent.trim());
  if (titles.length < 11) problems.push("expected at least 11 scenario buttons, found " + titles.length);

  for (const title of titles) {
    const before = errors.length;
    const where = "[" + title + "] ";
    const open = btn("scenario", title);
    if (!open) { problems.push(where + "no button"); continue; }
    fire(open);
    await sleep(400);
    if (!/Training|training/.test(document.body.innerText)) problems.push(where + "the lesson did not open");
    // a night (not a lesson) has its own flow: opening it without errors is the check
    if (/night$/.test(title)) {
      played.push(title + ": opened");
      if (errors.length > before) problems.push(where + errors.slice(before).join("; "));
      continue;
    }
    const passAll = byText("Pass on everything");
    if (passAll) fire(passAll);
    const fast = btn("speed", "16x");
    if (fast) fire(fast);
    const start = btn("toggle", "Start");
    if (start) fire(start);
    // play on until the confirm button: a learner who is offered a leftover or a gift declines
    const confirm = await waitFor(() => {
      const c = btn("confirm");
      if (c) return c;
      const d = btn("decline");
      if (d) fire(d);
      const w = btn("withdraw") || btn("giveUp");
      if (w) fire(w);
      return null;
    }, 30000);
    if (!confirm) {
      problems.push(where + "never reached the confirm button");
      continue;
    }
    fire(confirm);
    const done = await waitFor(() => headings().some((h) => /Matches the lesson|Different from the lesson|Your turn to fix it/.test(h)), 10000);
    if (!done) { problems.push(where + "no verdict or to-do after confirming"); continue; }
    if (FIXES[title]) {
      if (!headings().includes("Your turn to fix it")) problems.push(where + "expected a step left to do before the fix");
      try { await FIXES[title](); } catch (e) { problems.push(where + "the fix failed: " + e.message); }
      const ok = await waitFor(() => headings().includes("Matches the lesson"), 5000);
      if (!ok) problems.push(where + "after the correction the lesson does not match: " + headings().join(" | "));
    }
    played.push(title + ": " + headings().filter((h) => /lesson|fix/i.test(h)).join(", "));
    if (errors.length > before) problems.push(where + errors.slice(before).join("; "));
  }
  return { problems, played, errors };
}
