-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
Config = {}
------------------------------------------------------------------------------
-- Text UI's, notifications, frameworks, and other integrations can be made --
-- via dependency "wasabi_bridge" in the "customize" directory!             --
------------------------------------------------------------------------------

Config.MenuPosition = 'top-right' -- Menu position when open (Options: 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right')
Config.OpenKey = 'F9' -- Default key for opening admin menu
Config.TogglePlayerIDsKey = '9' -- Default key for toggling player IDs above heads
Config.UsingVehicleKeys = 'qb' -- Supported options: 'wasabi' for wasabi_carlock / 'qb' for qb-vehiclekeys / 'jaksam' for jacksam_carlock / 'custom' for custom in modifyme.lua -- Set to false if not needed
Config.SkinMenu = 'esx_skin' -- 'esx_skin' = ESX Skin / 'qb' = qb-clothing / 'fivem-appearance' = FiveM appearance / 'custom' = custom in modifyme.lua
Config.FuelSystem = 'false' -- Supported options: 'ox' - ox_fuel/ 'legacyfuel' - LegacyFuel / false - anything else
Config.Inventory = 'ox' -- Current options: 'ox' (For ox_inventory) / 'qb' (For qb-inventory) 'mf' (For mf inventory) / 'qs' (For qs_inventory) / 'cheeza' (for chezza inventory) -- false for none (Can be edited in modifyme.lua)
Config.SpeedMeasurement = 'mph' -- Options: 'mph' or 'kmh'

Config.AdminPerms = { -- Different ways of defining who has permission to access and utilize the admin menu
    UserGroups = {
        enabled = true, -- Enable usergroups from framework (Esx/QBCore), example/common groups below by default.
        groups = {
            -- Customize and add more like example of 'mod'
            ['admin'] = { -- Group name
                ban = true, -- Ability to ban
                kick = true, -- Ability to kick
                teleport = true, -- Ability to bring/goto players
                zones = true, -- Ability to utilize the zones system
                money = true, -- Ability to give money
                items = true, -- Ability to give items
                vehicles = true, -- Ability to use vehicle functions
                revive = true, -- Ability to revive others and themselves
                heal = true, -- Ability to heal others and themselves
                skin = true, -- Ability to open skin menu and give it to others
                invisible = true, -- Ability to toggle invisibility
                godmode = true, -- Ability to toggle god mode
                setped = true, -- Ability to set peds in the menu
                noclip = true, -- Ability to use no clip functions
                inventory = true, -- Access / clear inventories
                spectate = true, -- Ability to spectate via player options
            },
            ['god'] = { 
                allPerms = true, -- allPerms can be defined to grant all perms at once
            },
--          ['mod'] = { 
--              ban = true,
--              kick = true,
--              teleport = true, 
--          },
        }
    },
    
----------------------------------------------
--------------- Ace Permissions  -------------
----------------------------------------------
    AcePerms = {
        enabled = true, -- Enable ace perms?
        -- Players with any of these perms will gain access to menu, but will be restricted in regards to features
        -- below, and allPerms is unrestricted.
        allPerms = 'wasabi.adminmenu.allow', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.allow allow 
        -- allPerms: Enable all permissions within admin menu
        ban = 'wasabi.adminmenu.ban', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.ban allow 
        -- ban: Enable all ban functions
        kick = 'wasabi.adminmenu.kick', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.kick allow 
        -- kick: Enable all kick functions
        teleport = 'wasabi.adminmenu.teleport', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.teleport allow 
        -- teleport: Enable goto/bring player functions
        zones = 'wasabi.adminmenu.zones', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.zones allow 
        -- zones: enable access to zones system
        money = 'wasabi.adminmenu.money', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.money allow
        -- money: Enable all money related functions
        items = 'wasabi.adminmenu.items', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.items allow 
        -- items: Ability to give items from menu
        vehicles = 'wasabi.adminmenu.vehicles', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.vehicles allow 
        -- vehicles: Enable vehicle related functions
        revive = 'wasabi.adminmenu.revive', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.revive allow 
        -- revive: Allows revive functions
        heal = 'wasabi.adminmenu.heal', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.heal allow 
        -- heal: Enable heal related functions
        skin = 'wasabi.adminmenu.skin', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.skin allow 
        -- skin: Enable skin menu related functions
        invisible = 'wasabi.adminmenu.invisible', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.invisible allow 
        -- invisible: Enable toggle being invisible
        godmode = 'wasabi.adminmenu.godmode', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.godmode allow 
        -- invisible: Enable toggle godmode
        setped = 'wasabi.adminmenu.setped', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.setped allow 
        -- setped: Enable setting ped from menu
        noclip = 'wasabi.adminmenu.noclip', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.noclip allow 
        -- noclip: Enable toggle being no clip
        inventory = 'wasabi.adminmenu.inventory', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.inventory allow 
        -- inventory: Enable inventory related functions
        spectate = 'wasabi.adminmenu.spectate', -- Example in server.cfg: add_ace group.admin wasabi.adminmenu.spectate allow 
        -- spectate: Enable spectate ability within player options

    } 
}


--- Commands
Config.Commands = {
    Ban = { 
        enabled = false, -- Enable ban command?
        command = 'ban' -- Command (Default: 'ban')
        -- Example: /ban ID_HERE OPTIONAL_REASON_HERE
        -- Indefinite ban. Use menu for temporary ban
    },
    Kick = {
        enabled = false, -- Enable kick command?
        command = 'kick' -- Command (Default: 'kick')
        -- Example: /kick ID_HERE OPTIONAL_REASON_HERE
    },
    NoClip = {
        enabled = false, -- Enable noclip command?
        command = 'noclip' -- Command (Default: 'noclip')
        -- Example: /noclip
    },
    SearchInv = {
        enabled = false, -- Enable searchinv command?
        command = 'searchinv' -- Command (Default: 'searchinv')
        -- MUST HAVE Config.Inventory CONFIGURED TO PROPER INVENTORY!
        -- Example: /searchinv ID_HERE (Opens target inventory)
    },
    ClearInv = {
        enabled = false, -- Enable clearinv command?
        command = 'clearinv' -- Command (Default: 'clearinv')
        -- MUST HAVE Config.Inventory CONFIGURED TO PROPER INVENTORY!
        -- Example: /clearinv ID_HERE (Clears target inventory)
    },
    SkinMenu = {
        enabled = false, -- Enable skinmenu command?
        command = 'skinmenu' -- Command (Default: 'skinmenu')
        -- MUST HAVE Config.SkinMenu CONFIGURED TO PROPER SKIN / CLOTHING SCRIPT
        -- Example: /skinmenu ID_HERE (Opens skin menu on target's screen)
    },
    GoTo = {
        enabled = false, -- Enable /goto ID command?
        -- Already in ESX by default (QBCore only)
        command = 'goto'
    },
    Bring = {
        enabled = false, -- Enable /bring ID command?
        -- Already in ESX by default (QBCore only)
        command = 'bring'
    },
}

--- WEATHER SETTING OPTIONS
Config.WeatherSystem = 'qb' -- Supported options: 
                            -- 'qb' for qb-weathersync / 'cd' for cd_easytime / 'vsync' (Set to this if unsure?) for vSync / 'custom' for custom in sv_modifyme.lua 
                            -- Set to false no weather system

Config.Weathers = {
    {label = 'Clear Skies', value = 'CLEAR'},
    {label = 'Extra Sunny', value = 'EXTRASUNNY'},
    {label = 'Cloudy', value = 'CLOUDS'},
    {label = 'Foggy', value = 'FOGGY'},
    {label = 'Thunder', value = 'THUNDER'},
    {label = 'Rainy', value = 'RAIN'},
    {label = 'Halloween', value = 'HALLOWEEN'},
    {label = 'Snow Light', value = 'SNOWLIGHT'},
    {label = 'XMAS', value = 'XMAS'}
}

--- BAN SETTING OPTIONS
Config.Ban = { -- value is ban time in hours
    {label = '2 Hours', value = 2},
    {label = '24 Hours', value = 24},
    {label = '1 Week', value = 168},
    {label = 'Permanent', value = 'perm'}
}

--- JOB ANNOUNCEMENT OPTIONS
Config.Jobs = { -- label value is for how it is displayed in the menu. name must be exact as in your jobs database/table
    { label = 'LSPD', name = 'lspd' },
    { label = 'LSCSO', name = 'LSCSO' },
    { label = 'SAHP', name = 'sahp' },
    { label = 'AMR', name = 'amr' },
}

--- NO CLIP OPTIONS
Config.Noclip = {
     FirstPersonWhileNoclip = true,
     DefaultSpeed = 1.0,
     MaxSpeed = 12.0,
     Controls = {
         DecreaseSpeed = 14, -- Mouse wheel down
         IncreaseSpeed = 15, -- Mouse wheel up
         MoveFoward = 32, -- W
         MoveBackward = 33, -- S
         MoveLeft = 34, -- A
         MoveRight = 35, -- D
         MoveUp = 44, -- Q
         MoveDown = 46, -- E
     },
     Particle = {
         Fxname = 'core',
         Effectname = 'ent_dst_elec_fire_sp'
     }
}

---- SPECTATE RELATED OPTIONS

Config.Spectate = {
    Screenshot = {
        Enabled = true, -- toggle on or off
        Button = 191, -- Enter
    },
     Revive = {
        Enabled = true, -- toggle on or off
        Button = 29, -- B
     },
     Kick = {
        Enabled = true, -- toggle on or off
        Button = 47, -- G
     }
}

---- VEHICLE RELATED OPTIONS
Config.VehicleColors = { --- https://pastebin.com/pwHci0xK
    { label = 'Red', value = 27 },
    { label = 'Black', value = 0 },
    { label = 'Sunset Red', value = 33 },
    { label = 'Hot Pink', value = 135 },
    { label = 'Salmon Pink', value = 136 },
    { label = 'Dark Green', value = 49 },
    { label = 'Surf Blue', value = 68 },
    { label = 'Woodbeech Brown', value = 102 },
    { label = 'Cast Iron Silver', value = 10 },
    { label = 'Ice White', value = 111 },
    { label = 'Cream', value = 107 },
    { label = 'Frost White', value = 112 }
}


Config.TorqueMultiplier = { --- https://docs.fivem.net/natives/?_0xB59E4BD37AE292DB
    { label = 'Off', value = 1.0 },
    { label = '25%', value = 4.0 },
    { label = '50%', value = 8.0 },
    { label = '75%', value = 10.0 },
    { label = '100%', value = 100.0 }
}
