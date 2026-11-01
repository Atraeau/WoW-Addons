-- Tests for scripts/build-addons.lua, against the addons in scripts/fixtures/build-addons/src.
-- Usage (from the repository root):  lua scripts/test-build-addons.lua
local OUT = "scripts/fixtures/build-addons/out"
local windows = package.config:sub(1, 1) == "\\"
local LUA = (arg and arg[-1]) or "lua" -- the interpreter running this test

local function run(args)
    local cmd = LUA .. " scripts/build-addons.lua --src scripts/fixtures/build-addons/src --out " .. OUT .. " " .. args .. " 2>&1"
    local p = assert(io.popen(cmd))
    local text = p:read("a")
    local ok = p:close()
    return text, ok
end

local failures = 0
local function check(cond, what, detail)
    if cond then print("  ok   " .. what) else failures = failures + 1; print("  FAIL " .. what .. (detail and ("\n       " .. detail) or "")) end
end

local function shipped(text, addon)
    local set = {}
    for line in text:gmatch("[^\r\n]+") do
        local a, rel = line:match("^FILE (%S+) (.+)$")
        if a == addon then set[rel] = true end
    end
    return set
end
local function same(set, list)
    local want, n = {}, 0
    for _, rel in ipairs(list) do want[rel] = true; n = n + 1 end
    for rel in pairs(set) do if not want[rel] then return false, "unexpected: " .. rel end end
    for rel in pairs(want) do if not set[rel] then return false, "missing: " .. rel end end
    return true
end
local function read(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local s = f:read("a"); f:close(); return s
end

print("build-addons")
local out, ok = run("--files --check")
check(ok, "the fixtures build and pass --check", out)

local demo = shipped(out, "Demo")
local good, why = same(demo, {
    "Demo.toc", "Demo_Camelot.toc",           -- both TOC files
    "Main.lua", "UI.xml", "Sub/Helper.lua",   -- listed by the TOC (comment, blank line and [condition] handled)
    "Extra.lua",                              -- <Script> in the XML
    "Sub/More.xml", "Sub/More.lua",           -- <Include>, and that file's <Script> relative to it
    "Media/icon.tga",                         -- named by its game path in Lua, with the extension found
    "LICENSE.txt",                            -- a license beside the TOC
    "Media/extra.txt",                        -- build.lua asked for it
})
check(good, "Demo ships exactly what its TOC, XML, asset references, license and build.lua name", why)
check(not demo["Orphan.lua"] and not demo["tests/test_demo.lua"] and not demo["docs/notes.md"], "unlisted Lua, tests and docs do not ship")
check(out:find("Orphan.lua is not loaded by any TOC", 1, true), "an unlisted Lua file is reported, not silently dropped")
check(out:find("Media/missing", 1, true), "an asset named in code that does not exist is reported")

local rooted = shipped(out, "Rooted")
good, why = same(rooted, { "Rooted.toc", "Core.lua" })
check(good, "with build.lua root = src, only that folder ships (tests and README stay out)", why)

out, ok = run("--files --build 42 --name Demo")
check(ok and out:find("BUILT Demo 1.2.42", 1, true), "--build stamps the version: the TOC version plus the build number", out)
local toc = read(OUT .. "/Demo/Demo.toc") or ""
check(toc:find("## Version: 1.2.42", 1, true) and toc:find("## Title: Demo", 1, true), "the built TOC carries the stamped version and keeps its other lines")
check((read("scripts/fixtures/build-addons/src/Demo/Demo.toc") or ""):find("## Version: 1.2\n", 1, true), "the source TOC is untouched")

out = run("--list --releasable")
check(out:find("Demo", 1, true) and not out:find("Rooted", 1, true), "--list --releasable leaves out an addon with release = false", out)
out = run("--list")
check(out:find("Demo", 1, true) and out:find("Rooted", 1, true), "--list shows every addon", out)

-- a listed file that is missing is an error, and nothing is built for that addon
local bad = "scripts/fixtures/build-addons/src/Demo/Demo.toc"
local original = read(bad)
local f = assert(io.open(bad, "wb")); f:write(original .. "Nope.lua\n"); f:close()
out, ok = run("--name Demo")
f = assert(io.open(bad, "wb")); f:write(original); f:close()
check(not ok and out:find("Nope.lua is listed by Demo.toc but does not exist", 1, true), "a file the TOC lists but that is missing fails the build", out)

if windows then os.execute('rmdir /s /q "scripts\\fixtures\\build-addons\\out" 2>nul') else os.execute("rm -rf scripts/fixtures/build-addons/out") end
if failures > 0 then print(failures .. " failed"); os.exit(1) end
print("all passed")
