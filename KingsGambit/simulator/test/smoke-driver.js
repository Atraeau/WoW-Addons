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
  // Native dialogs answer "no" at once in some browsers (an embedded one, or a page with dialogs blocked): the page must
  // not depend on them. Any use of one fails the lesson, so a button that asks "are you sure?" has to use the page's own.
  window.confirm = () => false;
  window.prompt = () => null;
  const answerModal = () => {
    const ok = document.querySelector(".modal [data-modal=ok]");
    if (!ok) return false;
    const field = document.querySelector(".modal input");
    if (field) field.value = "smoke test";
    ok.click();
    return true;
  };

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
    "Fixing a mistake": async () => { fire(btn("fixUndo")); await sleep(200); if (!answerModal()) throw new Error("no confirmation dialog appeared"); },
    "The item went to someone else": async () => {
      await choose(fixRow("Brann", "Gauntlets of Might"), "Dara");
      fire(fixRow("Brann", "Gauntlets of Might").querySelector("[data-act=fixTrade]"));
      await sleep(200);
      if (!answerModal()) throw new Error("no reason dialog appeared");
    },
    "The item went to someone else, after a big hand-out": async () => {
      await choose(fixRow("Brann", "Brutality Blade"), "Hale");
      fire(fixRow("Brann", "Brutality Blade").querySelector("[data-act=fixTrade]"));
      await sleep(200);
      if (!answerModal()) throw new Error("no reason dialog appeared");
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
      answerModal();
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
  // A bot as the Master Looter: you play a raider, the session confirms itself, and you ask for corrections instead of
  // making them. Ask for a regret-trade of the winner's item and expect the bot to answer.
  {
    const where = "[a bot is the Master Looter] ";
    const before = errors.length;
    fire(btn("scenario", "The first drop"));
    await sleep(400);
    const sel = document.querySelector("#mlSel");
    if (!sel) {
      problems.push(where + "no Master Looter selector");
    } else {
      sel.value = "Aldric";
      sel.dispatchEvent(new Event("change", { bubbles: true }));
      fire(btn("setMl"));
      await sleep(400);
      const passAll = byText("Pass on everything");
      if (passAll) fire(passAll);
      const fast = btn("speed", "16x");
      if (fast) fire(fast);
      const start = btn("toggle", "Start");
      if (start) fire(start);
      const card = await waitFor(() => [...document.querySelectorAll(".card")].find((c) => /Ask the Master Looter/.test(c.textContent)), 30000);
      if (!card) {
        problems.push(where + "never offered the Ask the Master Looter card: " + headings().join(" | "));
      } else {
        const row = card.querySelector(".fixrow");
        const who = row.querySelector("b").textContent;
        const other = [...row.querySelector("select").options].map((o) => o.value).find((v) => v && v !== who);
        await choose(row, other);
        const trade = [...document.querySelectorAll(".card")].find((c) => /Ask the Master Looter/.test(c.textContent)).querySelector("[data-act=askTrade]");
        fire(trade);
        await sleep(200);
        if (!answerModal()) problems.push(where + "no reason dialog appeared");
        const answered = await waitFor(() => /Aldric (accepted|declined)/.test(document.body.innerText), 5000);
        if (!answered) problems.push(where + "the bot Master Looter did not answer the request");
        else played.push("a bot is the Master Looter: asked for a regret-trade of " + who + "'s item, " + (/Aldric accepted/.test(document.body.innerText) ? "accepted" : "declined"));
      }
    }
    if (errors.length > before) problems.push(where + errors.slice(before).join("; "));
  }
  // The sync lab: every scripted check must pass (they judge themselves: see lab_check in api.lua)
  {
    const where = "[sync lab] ";
    const before = errors.length;
    fire(btn("tab", "Sync lab"));
    await sleep(500);
    const ids = buttons().filter((b) => b.dataset.act === "lab-check").map((b) => b.dataset.a);
    if (ids.length < 5) problems.push(where + "expected at least 5 checks, found " + ids.length);
    for (const id of ids) {
      fire(buttons().find((b) => b.dataset.act === "lab-check" && b.dataset.a === id));
      await sleep(300);
      const card = [...document.querySelectorAll("#lab .card")].find((c) => /^(Passed|Failed)/.test(c.querySelector("h2") ? c.querySelector("h2").textContent : ""));
      if (!card) { problems.push(where + id + ": no result shown"); continue; }
      const title = card.querySelector("h2").textContent;
      if (!/^Passed/.test(title)) problems.push(where + id + ": " + card.innerText.replace(/\n+/g, " | ").slice(0, 500));
      else played.push("sync lab, " + title);
    }
    if (errors.length > before) problems.push(where + errors.slice(before).join("; "));
  }
  return { problems, played, errors };
}
