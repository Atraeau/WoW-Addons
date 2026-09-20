# Category rules for the API doc generator.
# The first group whose pattern matches a namespace wins (order matters).
# Matching is case-insensitive substring, tested against the name with a leading
# "C_" stripped (e.g. "C_UnitAuras" -> "unitauras"). Anything unmatched lands in
# "Miscellaneous". Reorder/edit freely, then re-run generate-api-docs.ps1.
@{ Categories = @(
    @{ Group = 'Professions & Crafting'; Match = @('profession','tradeskill','craftingorder','crafting','recipe','profspec','trainer','skillinfo') },
    @{ Group = 'Auction, Mail & Trade';  Match = @('auction','mail','merchant','blackmarket','wowtoken','guildbank','trade','catalogshop','catalog') },
    @{ Group = 'Items & Inventory';      Match = @('item','container','bag','bank','inventory','equipment','transmog','appearance','wardrobe','azerite','gem','socket','currency','loot','void','warband','reagent','dye') },
    @{ Group = 'Spells, Auras & Talents'; Match = @('spell','aura','cooldown','talent','traits','traitconfig','soulbind','glyph','specialization','artifact') },
    @{ Group = 'Units, Combat & PvP';    Match = @('unit','threat','combatlog','combat','lossofcontrol','pvp','arena','honor','battlefield','battleground','brawl','duel','death','resurrect','encounter','bossbanner','raidlock','deadlydebuff','vehicle','totem','summon','roleset') },
    @{ Group = 'Player & Character';     Match = @('player','paperdoll','mentorship','classtrial','classcolor','creatureinfo','modelinfo','levellink','levelsquish','chromietime','alliedraces','barbershop') },
    @{ Group = 'Pets, Mounts & Collections'; Match = @('mount','battlepet','petjournal','pet','toybox','toy','collection','heirloom','stable') },
    @{ Group = 'Quests & Campaigns';     Match = @('quest','campaign','gossip','adventure','delve','questline','playerchoice','loretext') },
    @{ Group = 'Housing';                Match = @('housing','house','neighborhood','decor','blueprint') },
    @{ Group = 'Map, Instances & World'; Match = @('map','zone','area','poi','vignette','taxi','flight','navigation','waypoint','supertrack','worldstate','scenario','instance','dungeon','mythic','keystone','challengemode','encounterjournal','worldquest','garrison','island','invasion','warfront','torghast','fogofwar','weather','worldsafeloc') },
    @{ Group = 'Guild, Social & Chat';   Match = @('guild','club','communities','chat','social','friend','bnet','battlenet','whisper','party','group','raid','voice','report','calendar','ping','lfg','recruit','contribution','recentallies') },
    @{ Group = 'Achievements & Progression'; Match = @('achievement','reputation','majorfaction','renown','paragon','perks','title','covenant','anima','ardenweald','research','contenttracking','weeklyreward','reward','season','expansion') },
    @{ Group = 'UI Widgets & Frames';    Match = @('simple','frameapi','framescript','framemanager','genericwidget','uiwidget','widget','font','texture','gamecursor','durationtextbinding','frame') },
    @{ Group = 'UI Systems & Input';     Match = @('cvar','keybind','binding','macro','actionbar','tooltip','cursor','editmode','edit','nameplate','minimap','coloroverride','accessibility','gamepad','console','kiosk','glue','movie','cinematic','screenshot','sound','animation','uierror','alert','eventtoast','loadingscreen','endofmatch','autocomplete','inputinterface','limitedinput','input','videooptions','camera','screen','gameui','gameerror','talkinghead','splashscreen','uiaction','uifile') },
    @{ Group = 'AddOns & Scripting';     Match = @('addon','script','luaevent','eventtrace','eventutil','debug','timer','callback','configurationwarning','slash') },
    @{ Group = 'Store, Account & Services'; Match = @('store','account','battlepay','purchase','subscription','gamerule','gamemode','restriction','contentpush','commentator','spectator','lobby','matchmaker') },
    @{ Group = 'Core & Shared Libraries'; Match = @('math','string','table','os','bit','coroutine','util','formatter','numeric','abbreviat','encoding','locale','intl','localization','color','duration','curve','url','platform','datetime','dateandtime') },
    @{ Group = 'System & Config';        Match = @('system','gametime','setting','perf','telemetry','tutorial','help','feedback','seasons','engine','memory','clientscene','client','gameenvironment','manifest','browser','photo','discord','pony','macoptions','restrictedaction','build','immersive','incomingsummon','externalevent','liveevent','eventscheduler','behavioral','gmticket','model','streaming','secret','secure','parental','survey','blizzcon','log') }
) }
