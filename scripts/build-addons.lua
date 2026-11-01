-- Build every addon under src/ into AddOns/<Addon>/: exactly the files the WoW client loads, and nothing else.
--
--   src/<Addon>/   everything about an addon: game code, tests, simulator, docs, tools (all of it is source)
--   AddOns/<Addon>/ the build: what the client reads. Mirrors the game's Interface/AddOns folder.
--
-- What ships is worked out from the addon's own TOC files, not from a list that can drift:
--   * the TOC files themselves (<Addon>.toc and <Addon>_<flavor>.toc);
--   * every file those list, following XML <Script file=> and <Include file=> into the files they pull in;
--   * assets the shipped Lua and XML name by their full game path (Interface\AddOns\<Addon>\...);
--   * a LICENSE / COPYING file next to the TOC, if there is one;
--   * anything the addon's optional build.lua asks for (below).
-- Files are copied byte for byte (no concatenating or minifying), so a Lua error in the game names the same file and line
-- as the source.
--
-- src/<Addon>/build.lua (optional) returns a table:
--   root  = "src"                folder, inside src/<Addon>, that holds the TOC files and is shipped as the addon (default ".")
--   extra = { "Media", "x.txt" } more files or folders to ship, relative to root
--   release = false              never publish this addon as a release (examples and dev tools); it still builds and deploys
--
-- Usage (from the repository root):
--   lua scripts/build-addons.lua [options]
--     --name A,B      only these addons
--     --out DIR       where to build (default AddOns)
--     --src DIR       where the addons are (default src)
--     --build N       stamp "## Version: <TOC version>.N" into the built TOC files (CI passes its run number)
--     --zip DIR       also write DIR/<Addon>-<version>.zip, with the addon folder at the top (what CurseForge takes)
--     --check         verify the build (nothing unexpected shipped, every listed file present); exit 1 on a problem
--     --files         also print "FILE <Addon> <path>" for every shipped file
--     --list          print the addon names and stop (with --releasable: only those CI publishes releases for)
-- A line "BUILT <Addon> <version> <zip or ->" is printed per addon, for scripts to read.
local sep = package.config:sub(1, 1)
local windows = sep == "\\"

---------------------------------------------------------------- files and folders
local function q(p) return '"' .. p .. '"' end
local function native(p) return windows and (p:gsub("/", "\\")) or p end

local function readFile(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local s = f:read("a")
    f:close()
    return s
end

local function popenLines(cmd)
    local p = assert(io.popen(cmd))
    local out = {}
    for line in p:lines() do
        line = line:gsub("\r$", "")
        if line ~= "" then out[#out + 1] = line end
    end
    p:close()
    return out
end

local function mkdirs(dir)
    if dir == "" or dir == "." then return end
    if windows then os.execute("mkdir " .. q(native(dir)) .. " 2>nul") else os.execute("mkdir -p " .. q(dir)) end
end
local function removeTree(dir)
    if windows then os.execute("if exist " .. q(native(dir)) .. " rmdir /s /q " .. q(native(dir))) else os.execute("rm -rf " .. q(dir)) end
end
local function dirOf(path) return path:match("^(.*)/[^/]*$") or "" end

local function writeFile(path, data)
    mkdirs(dirOf(path))
    local f = assert(io.open(path, "wb"), "cannot write " .. path)
    f:write(data)
    f:close()
end

-- Subfolders of dir (names only).
local function listDirs(dir)
    if windows then return popenLines("dir /b /ad " .. q(native(dir)) .. " 2>nul") end
    return popenLines("ls -1 -p " .. q(dir) .. " 2>/dev/null | grep '/$' | sed 's#/$##'")
end

-- Every file under dir, as paths relative to it (forward slashes), sorted.
local function listFiles(dir)
    local out = {}
    if windows then
        local base = popenLines("cd /d " .. q(native(dir)) .. " 2>nul && cd")[1]
        if not base then return out end
        for _, abs in ipairs(popenLines("dir /b /s /a-d " .. q(native(dir)) .. " 2>nul")) do
            if abs:sub(1, #base + 1):lower() == (base .. "\\"):lower() then out[#out + 1] = (abs:sub(#base + 2):gsub("\\", "/")) end
        end
    else
        out = popenLines("cd " .. q(dir) .. " 2>/dev/null && find . -type f | sed 's#^\\./##'")
    end
    table.sort(out)
    return out
end

local function exists(path)
    local f = io.open(path, "rb")
    if not f then return false end
    local ok = f:read(0) ~= nil or f:seek("end") ~= nil -- a folder opens on Linux but can't be read
    f:close()
    return ok
end

-- a/b/../c -> a/c
local function normalize(path)
    local parts = {}
    for part in path:gmatch("[^/]+") do
        if part == ".." and #parts > 0 and parts[#parts] ~= ".." then parts[#parts] = nil
        elseif part ~= "." then parts[#parts + 1] = part end
    end
    return table.concat(parts, "/")
end

---------------------------------------------------------------- reading an addon
-- The file names in a TOC (comment and blank lines skipped, "[Condition]" suffixes dropped).
local function tocFiles(text)
    local out = {}
    for line in text:gmatch("[^\r\n]+") do
        line = line:gsub("^%s+", ""):gsub("%s+$", "")
        if line ~= "" and line:sub(1, 1) ~= "#" then
            line = line:gsub("%s*%[[^%]]*%]%s*$", "")
            out[#out + 1] = (line:gsub("\\", "/"))
        end
    end
    return out
end

local function tocField(text, key)
    return text:match("\n##%s*" .. key .. "%s*:%s*([^\r\n]*)") or text:match("^##%s*" .. key .. "%s*:%s*([^\r\n]*)")
end

local function loadSettings(addonDir)
    local chunk = loadfile(addonDir .. "/build.lua")
    local s = chunk and chunk() or {}
    return { root = s.root or ".", extra = s.extra or {}, release = s.release ~= false }
end

-- Work out what ships. Returns { files = { [relpath] = true }, order = { relpath... }, tocs = { relpath... }, warnings = { ... },
-- problems = { ... } } with paths relative to the shipped root.
local function plan(name, addonDir, settings)
    local root = normalize(addonDir .. "/" .. settings.root)
    local files, order, warnings, problems = {}, {}, {}, {}
    local function add(rel)
        if not files[rel] then files[rel] = true; order[#order + 1] = rel end
    end
    local function need(rel, why)
        if exists(root .. "/" .. rel) then add(rel); return true end
        problems[#problems + 1] = ("%s: %s is listed by %s but does not exist"):format(name, rel, why)
        return false
    end

    -- the TOC files: <Name>.toc and <Name>_<flavor>.toc
    local tocs = {}
    for _, rel in ipairs(listFiles(root)) do
        if not rel:find("/", 1, true) and rel:match("^" .. name:gsub("%p", "%%%0") .. "[_%.]") and rel:lower():match("%.toc$") then tocs[#tocs + 1] = rel end
    end
    if #tocs == 0 then problems[#problems + 1] = name .. ": no " .. name .. ".toc in " .. root end
    local texts = {}
    for _, rel in ipairs(tocs) do add(rel); texts[rel] = readFile(root .. "/" .. rel) end

    -- everything the TOCs list, following XML includes
    local function follow(rel, why)
        if not need(rel, why) then return end
        if rel:lower():match("%.xml$") then
            local xml = readFile(root .. "/" .. rel) or ""
            for tag, ref in xml:gmatch('<(%a+)%s[^>]-file%s*=%s*"([^"]+)"') do
                if tag == "Script" or tag == "Include" then
                    ref = ref:gsub("\\", "/")
                    local nested = normalize(dirOf(rel) .. "/" .. ref)
                    if not exists(root .. "/" .. nested) then nested = normalize(ref) end -- some clients resolve from the addon folder
                    if not files[nested] then follow(nested, rel) end
                end
            end
        end
    end
    for _, tocRel in ipairs(tocs) do
        for _, rel in ipairs(tocFiles(texts[tocRel])) do follow(normalize(rel), tocRel) end
    end

    -- assets that shipped Lua and XML name by their full game path
    local ASSET_EXT = { "", ".tga", ".blp", ".ogg", ".mp3", ".wav", ".ttf", ".png" }
    local scanned = {}
    for _, rel in ipairs(order) do
        if rel:lower():match("%.lua$") or rel:lower():match("%.xml$") then scanned[#scanned + 1] = rel end
    end
    for _, rel in ipairs(scanned) do
        local text = readFile(root .. "/" .. rel) or ""
        for ref in text:gmatch("[Ii]nterface[\\/]+[Aa]dd[Oo]ns[\\/]+" .. name:gsub("%p", "%%%0") .. "[\\/]+([%w_%-%./\\ ]+)") do
            ref = normalize((ref:gsub("[\\/]+", "/")):gsub("%s+$", ""))
            local found
            for _, ext in ipairs(ASSET_EXT) do
                if exists(root .. "/" .. ref .. ext) then add(ref .. ext); found = true; break end
            end
            if not found and not ref:match("/$") then warnings[#warnings + 1] = ("%s: %s names %s, which does not exist"):format(name, rel, ref) end
        end
    end

    -- a license next to the TOC, then what build.lua asks for
    for _, rel in ipairs(listFiles(root)) do
        if not rel:find("/", 1, true) and rel:lower():match("^license") or rel:lower():match("^copying") then add(rel) end
    end
    for _, extra in ipairs(settings.extra) do
        local rel = normalize(extra)
        if exists(root .. "/" .. rel) then add(rel)
        else
            local under = listFiles(root .. "/" .. rel)
            if #under == 0 then problems[#problems + 1] = ("%s: build.lua extra %s does not exist"):format(name, extra) end
            for _, f in ipairs(under) do add(rel .. "/" .. f) end
        end
    end

    -- Lua files next to the shipped ones that nothing loads: probably forgotten from the TOC
    for _, rel in ipairs(listFiles(root)) do
        if rel:lower():match("%.lua$") and not files[rel] and not rel:match("^build%.lua$") then
            local top = rel:match("^([^/]+)/")
            if not top or not ({ tests = 1, tools = 1, simulator = 1, docs = 1, scripts = 1, archive = 1, test = 1, spec = 1 })[top] then
                warnings[#warnings + 1] = ("%s: %s is not loaded by any TOC, so it is not shipped"):format(name, rel)
            end
        end
    end
    return { root = root, files = files, order = order, tocs = tocs, texts = texts, warnings = warnings, problems = problems }
end

---------------------------------------------------------------- building
local opts = { out = "AddOns", src = "src", names = nil, build = nil, zip = nil, check = false, list = false, files = false, releasable = false }
do
    local i = 1
    while i <= #arg do
        local a = arg[i]
        if a == "--out" then opts.out = arg[i + 1]; i = i + 1
        elseif a == "--src" then opts.src = arg[i + 1]; i = i + 1
        elseif a == "--build" then opts.build = arg[i + 1]; i = i + 1
        elseif a == "--zip" then opts.zip = arg[i + 1]; i = i + 1
        elseif a == "--name" then
            opts.names = {}
            for n in arg[i + 1]:gmatch("[^,]+") do opts.names[n] = true end
            i = i + 1
        elseif a == "--check" then opts.check = true
        elseif a == "--list" then opts.list = true
        elseif a == "--files" then opts.files = true
        elseif a == "--releasable" then opts.releasable = true
        else io.stderr:write("unknown option: " .. a .. "\n"); os.exit(2) end
        i = i + 1
    end
end

local addons = listDirs(opts.src)
table.sort(addons)
if opts.list then
    for _, n in ipairs(addons) do
        if not opts.releasable or loadSettings(opts.src .. "/" .. n).release then print(n) end
    end
    os.exit(0)
end

local failed = false
local built = 0
for _, name in ipairs(addons) do
    if not opts.names or opts.names[name] then
        local addonDir = opts.src .. "/" .. name
        local settings = loadSettings(addonDir)
        local p = plan(name, addonDir, settings)
        for _, w in ipairs(p.warnings) do io.stderr:write("warning: " .. w .. "\n") end
        for _, e in ipairs(p.problems) do io.stderr:write("ERROR: " .. e .. "\n"); failed = true end
        if #p.problems == 0 then
            local dest = opts.out .. "/" .. name
            removeTree(dest)
            local baseVersion = tocField(p.texts[p.tocs[1]], "Version") or "0"
            local version = opts.build and (baseVersion .. "." .. opts.build) or baseVersion
            table.sort(p.order)
            for _, rel in ipairs(p.order) do
                local data = readFile(p.root .. "/" .. rel)
                if opts.build and p.texts[rel] then
                    data = data:gsub("(\n?##%s*Version%s*:)[^\r\n]*", "%1 " .. version, 1)
                end
                writeFile(dest .. "/" .. rel, data)
            end
            if opts.check then
                -- what was built is exactly the plan: nothing stale, nothing missing
                local onDisk = listFiles(dest)
                local seen = {}
                for _, rel in ipairs(onDisk) do
                    seen[rel] = true
                    if not p.files[rel] then io.stderr:write(("ERROR: %s: %s was built but is not in the plan\n"):format(name, rel)); failed = true end
                end
                for rel in pairs(p.files) do
                    if not seen[rel] then io.stderr:write(("ERROR: %s: %s should have been built\n"):format(name, rel)); failed = true end
                end
                for _, tocRel in ipairs(p.tocs) do
                    local text = readFile(dest .. "/" .. tocRel) or ""
                    if not text:match("##%s*Interface%s*:%s*%d+") then io.stderr:write(("ERROR: %s: %s has no '## Interface:' line\n"):format(name, tocRel)); failed = true end
                    if not text:match("##%s*Title%s*:") then io.stderr:write(("ERROR: %s: %s has no '## Title:' line\n"):format(name, tocRel)); failed = true end
                end
                for _, rel in ipairs(onDisk) do
                    local top = rel:match("^([^/]+)/")
                    if top and ({ tests = 1, docs = 1, simulator = 1, tools = 1, scripts = 1, archive = 1 })[top:lower()] then
                        io.stderr:write(("ERROR: %s: %s must not ship (it is development-only)\n"):format(name, rel)); failed = true
                    end
                end
            end
            local zip = "-"
            if opts.zip then
                mkdirs(opts.zip)
                zip = opts.zip .. "/" .. name .. "-" .. version .. ".zip"
                os.remove(zip)
                local cmd
                if windows then
                    cmd = "tar -a -c -f " .. q(native(zip)) .. " -C " .. q(native(opts.out)) .. " " .. q(name)
                else
                    -- zip runs inside the output folder so the addon folder is at the top of the archive
                    local abs = zip:sub(1, 1) == "/" and zip or (popenLines("pwd")[1] .. "/" .. zip)
                    cmd = "cd " .. q(opts.out) .. " && zip -q -r " .. q(abs) .. " " .. q(name)
                end
                if not os.execute(cmd) then io.stderr:write("ERROR: could not write " .. zip .. "\n"); failed = true end
            end
            if opts.files then for _, rel in ipairs(p.order) do print(("FILE %s %s"):format(name, rel)) end end
            print(("BUILT %s %s %s (%d files)"):format(name, version, zip, #p.order))
            built = built + 1
        end
    end
end
if built == 0 and not failed then io.stderr:write("nothing was built\n"); failed = true end
os.exit(failed and 1 or 0)
