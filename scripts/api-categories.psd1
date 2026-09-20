# Category rules for the API doc generator.
# The first group whose pattern matches a namespace wins (order matters).
# Matching is case-insensitive substring, tested against the name with a leading
# "C_" stripped (e.g. "C_UnitAuras" -> "unitauras"). Anything unmatched lands in
# "Miscellaneous". Reorder/edit freely, then re-run generate-api-docs.ps1.
@{ Categories = @(
    @{ Group = 'Professions & Crafting'; Match = @('profession','tradeskill','craftingorder','crafting','recipe','profspec') },
    @{ Group = 'Auction, Mail & Trade';  Match = @('auction','mail','merchant','blackmarket','wowtoken','guildbank','trade','catalogshop','catalog') },
    @{ Group = 'Items & Inventory';      Match = @('item','container','bag','bank','inventory','equipment','transmog','appearance','wardrobe','azerite','gem','socket','currency','loot','void','warband','reagent','dye') },
    @{ Group = 'Spells, Auras & Talents'; Match = @('spell','aura','cooldown','talent','traits','soulbind','glyph','specialization','artifact') },
    @{ Group = 'Units, Combat & PvP';    Match = @('unit','threat','combatlog','combat','lossofcontrol','pvp','arena','honor','battlefield','battleground','brawl','duel','death','resurrect','encounter','bossbanner','raidlock','deadlydebuff') },
    @{ Group = 'Player & Character';     Match = @('player','paperdoll','mentorship','classtrial','classcolor','creatureinfo','modelinfo','levellink','levelsquish','chromietime','alliedraces','barbershop') },
    @{ Group = 'Pets, Mounts & Collections'; Match = @('mount','battlepet','petjournal','pet','toybox','toy','collection','heirloom') },
    @{ Group = 'Quests & Campaigns';     Match = @('quest','campaign','gossip','adventure','delve','questline','playerchoice') },
    @{ Group = 'Housing';                Match = @('housing','house','neighborhood','decor','blueprint') },
    @{ Group = 'Map, Instances & World'; Match = @('map','zone','area','poi','vignette','taxi','flight','navigation','waypoint','supertrack','worldstate','scenario','instance','dungeon','mythic','keystone','challengemode','encounterjournal','worldquest','garrison','island','invasion','warfront','torghast','fogofwar') },
    @{ Group = 'Guild, Social & Chat';   Match = @('guild','club','communities','chat','social','friend','bnet','battlenet','whisper','party','group','raid','voice','report','calendar','ping','lfg','recruit','contribution') },
    @{ Group = 'Achievements & Progression'; Match = @('achievement','reputation','majorfaction','renown','paragon','perks','title','covenant','anima','ardenweald','research','contenttracking') },
    @{ Group = 'UI, Frames & Input';     Match = @('cvar','keybind','binding','macro','actionbar','tooltip','cursor','editmode','edit','uiwidget','widget','nameplate','unitframe','statusbar','minimap','coloroverride','accessibility','gamepad','console','kiosk','glue','movie','cinematic','screenshot','sound','texture','animation','font','uierror','alert','frame','eventtoast','loadingscreen','endofmatch','autocomplete','inputinterface','limitedinput') },
    @{ Group = 'AddOns & Scripting';     Match = @('addon','script','luaevent','eventtrace','eventutil','debug','timer','callback','configurationwarning') },
    @{ Group = 'Store, Account & Services'; Match = @('store','account','battlepay','purchase','subscription','gamerule','gamemode','restriction','contentpush','commentator','spectator','lobby','matchmaker') },
    @{ Group = 'System & Config';        Match = @('system','encoding','gametime','datetime','setting','perf','telemetry','tutorial','help','feedback','seasons','engine','memory','clientscene','gameenvironment','util','locale','intl','platform','log','color','duration','curve','manifest','browser','photo','discord','pony','macoptions','restrictedaction','build','abbreviat','immersive','incomingsummon','externalevent','liveevent','eventscheduler','behavioral','gmticket','model') }
) }
