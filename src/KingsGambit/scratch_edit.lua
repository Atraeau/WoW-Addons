local h=assert(io.open("simulator/test/smoke.mjs","rb")); local s=h:read("*a"); h:close()
local function rep(a,b) local i,j=s:find(a,1,true); assert(i,a); s=s:sub(1,i-1)..b..s:sub(j+1) end
rep([[const browser = await chromium.launch();]], [[// On a machine that has Chrome or Edge, set KG_BROWSER to its path instead of downloading Playwright's own Chromium.
const browser = await chromium.launch(process.env.KG_BROWSER ? { executablePath: process.env.KG_BROWSER } : {});]])
rep([[//   node simulator/test/smoke.mjs [simulator/index.html]]], [[//   node simulator/test/smoke.mjs [simulator/index.html]
// With Chrome already installed, skip the browser download:  KG_BROWSER="C:\Program Files\Google\Chrome\Application\chrome.exe" node simulator/test/smoke.mjs]])
h=assert(io.open("simulator/test/smoke.mjs","wb")); h:write(s); h:close()
