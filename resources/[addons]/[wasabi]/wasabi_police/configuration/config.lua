-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local seconds, minutes = 1000, 60000

local lspdBaseWeapons = {
    ['armour'] = { label = 'Bulletproof Vest', multiple = false, price = false }, 

    ["radio"] = { label = "Radio", multiple = false, price = false},
    ['WEAPON_NIGHTSTICK'] = { label = 'Night Stick', multiple = false, price = false },
    ['WEAPON_FLASHLIGHT'] = { label = 'Flashlight', multiple = false, price = false },
    
    ['WEAPON_GLOCK19GEN4'] = { label = 'Glock 19 Gen4', multiple = false, price = false }, 
    ['ammo-9'] = { label = '9mm Ammo', multiple = true, price = false }, 
    
    ["WEAPON_STUNGUN"] = { label = "Stun Gun", multiple = false, price = false},
    ["ammo-stungun"] = { label = "Stun Cartridge", multiple = true, price = false},
    
    ["WEAPON_CARBINERIFLE"] = { label = "Assault Rifle", multiple = false, price = false},
    ["ammo-rifle"] = { label = "5.56mm Rifle Ammo", multiple = true, price = false},
}

local lspdSergeantWeapons = {
    ['WEAPON_PROLASER4'] = { label = 'Prolaser 4 Radar Gun', multiple = false, price = false },

    ["WEAPON_COMBATSHOTGUN"] = { label = "Benelli M1014", multiple = false, price = false},
    ["ammo-shotgun"] = { label = "Shotgun Ammo", multiple = true, price = false},
    
    ["WEAPON_SMG"] = { label = "SMG", multiple = false, price = false},
    ["at_flashlight"] = { label = "Weapon Flashlight", multiple = false, price = false},
    ["at_scope_macro"] = { label = "Macro Scope", multiple = false, price = false},
    ["at_suppressor_light"] = { label = "Supressor", multiple = false, price = false},

}
local lspdCaptainWeapons = {
    ['WEAPON_HEAVYSNIPER'] = { label = 'M110', multiple = false, price = false },
    ['WEAPON_HEAVYSNIPER_MK2'] = { label = 'G28', multiple = false, price = false },

    ["ammo-sniper"] = { label = "7.62x51 Sniper Ammo", multiple = true, price = false}
}


local lspdBaseCars = {
    -- Job grade as table name
    ['pdbike'] = {         -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Police Bicycle',
        category = 'land', -- Options are 'land' and 'air'
    },                    -- Job grade as table name
    ['lapd2'] = {         -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2016 Ford Explorer',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lapd20sl'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2020 Ford Explorer',
        category = 'land', -- Options are 'land' and 'air'
    },
}

local lspdOfficerCars = {
    ['15pdfpiss'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2015 Ford Taurus',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['moto'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Police Bike',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lapd10'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Charger',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lapd08'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2008 Chevy Tahoe',
        category = 'land', -- Options are 'land' and 'air'
    },
}

local lspdSergeantCars = {  
    ['moto'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Police Bike',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['86399'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2004 Ford Crown Vic (Patrol Unit)',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['11pdcvpi'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Ford Crown Vic',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['2015polstang'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2015 Ford Mustang GT',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lspdunm'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2018 Dodge Charger UM',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lspdmav'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'LSPD Maverick Heli',
        category = 'air', -- Options are 'land' and 'air'
    },
    ["lasdfpiu"] = {
        label = "2013 Ford Explorer UM",         
        category = "land"
    },
    ["lasdtaurus"] = {
        label = "2018 Ford Taurus UM",           
        category = "land"
    },
    ['14pdcharger'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2014 Charger',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lapdm'] = {         -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'BMW Bike',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['uctaxi'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Taxi UM',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['f250s'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Ford F250',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['lapd16'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = '2016 Ford Explorer UM',
        category = 'land', -- Options are 'land' and 'air'
    },
    ['hellcatred'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Dodge Hellcat UM',
        category = 'land', -- Options are 'land' and 'air'
    },
}
local lspdLieutenantCars = {
    ["srtrango"] = {
        label = "Dodge Rango SRT",
        category = "land"
    },
    ['sbearcat'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
        label = 'Bearcat',
        category = 'land', -- Options are 'land' and 'air'
    },
}


local sahpBaseWeapons = {
    ['armour'] = { label = 'Bulletproof Vest', multiple = false, price = false },

    ["radio"] = { label = "Radio", multiple = false, price = false},
    ['WEAPON_NIGHTSTICK'] = { label = 'Night Stick', multiple = false, price = false },
    ['WEAPON_FLASHLIGHT'] = { label = 'Flashlight', multiple = false, price = false },

    ['WEAPON_USP'] = { label = 'Pistol', multiple = false, price = false }, 
    ['ammo-45'] = { label = '9mm Pistol Ammo', multiple = true, price = false }, 
     
    ["WEAPON_STUNGUN"] = { label = "Stun Gun", multiple = false, price = false},
    ["ammo-stungun"] = { label = "Stun Cartridge", multiple = true, price = false},
    
    ["WEAPON_CARBINERIFLE"] = { label = "Assault Rifle", multiple = false, price = false},
    ["ammo-rifle"] = { label = "5.56mm Rifle Ammo", multiple = true, price = false},
}

local sahpTrooperTwoUpWeapons = {
    ['WEAPON_PROLASER4'] = { label = 'Prolaser 4 Radar Gun', multiple = false, price = false },

    ["WEAPON_COMBATSHOTGUN"] = { label = "Benelli M1014", multiple = false, price = false},
    ["ammo-shotgun"] = { label = "Shotgun Ammo", multiple = true, price = false},
    
    ["WEAPON_SMG"] = { label = "SMG", multiple = false, price = false},
    ["at_flashlight"] = { label = "Weapon Flashlight", multiple = false, price = false},
    ["at_scope_macro"] = { label = "Macro Scope", multiple = false, price = false},
    ["at_suppressor_light"] = { label = "Supressor", multiple = false, price = false},
}

local lscsoBaseCars = {
    ["pbike"] = {
        label = "Police Bicycle",        
        category = "land"
    },
    ["lasd12"] = {
        label = "2013 Ford Explorer",   
        category = "land"
    },
    -- ["lasd13"] = {
    --     label = "2016 Ford Explorer",   
    --     category = "land"
    -- },
    ["LASDCVPI1"] = {
        label = "2011 Ford Crown Vic 1",
        category = "land"
    },
    ["LASDCVPI2"] = {
        label = "2011 Ford Crown Vic 2",
        category = "land"
    },
    ["LASDCVPI3"] = {
        label = "2011 Ford Crown Vic 3",
        category = "land"
    },
    ["lssdfpisi"] = {
        label = "2015 Ford Taurus",     
        category = "land"
    },
}

local lscsoDeputyTwoCars = exports.stem_common:tableMerge(lscsoBaseCars, {
    ["lasd11"] = {
        label = "2016 Chevy Tahoe",
        category = "land"
    },
    ["lasdchgr2"] = {
        label = "2014 Dodge Charger",        
        category = "land"
    },
    ["lssdbike"] = {
        label = "LSSD Police Motorcycle",        
        category = "land"
    },
})

local lscsoDeputyThreeCars = exports.stem_common:tableMerge(lscsoDeputyTwoCars, {
    ["ucvan"] = {
        label = "Dodge Grand Caravan UM",
        category = "land"
    },
    ["lasdsap"] = {
        label = "2011 Ford Crown Vic UM",        
        category = "land"
    },
    ["lasdtaurus"] = {
        label = "2018 Ford Taurus UM",           
        category = "land"
    },
    ["lssdmav"] = {
        label = "Sheriff Helicopter",
        category = "air"
    }
})

local lscsoSergeantCars = exports.stem_common:tableMerge(lscsoDeputyThreeCars, {
    ["lasd11"] = {
        label = "2016 Chevy Tahoe",              
        category = "land"
    },
    ["lasdchgr"] = {
        label = "2014 Dodge Charger CVE",        
        category = "land"
    },
    ["lasdchgr2"] = {
        label = "2014 Dodge Charger",        
        category = "land"
    },
    ["lasdfpiu"] = {
        label = "2013 Ford Explorer UM",         
        category = "land"
    },
    ["evchgr"] = {
        label = "EVOC/PIT Training Vehicle",
        category = "land"
    },
})

Config = {}

Config.jobMenu = 'F6'          -- Default job menu key
Config.useTarget = true        -- Enable target for police functions (Supports qtarget, qb-target, and ox_target)
Config.MobileMenu = {          -- THIS WILL USE A OX_LIB MENU RATHER THAN OX_LIB CONTEXT MENU!
    enabled = false,           -- Use a mobile menu from ox_lib rather than context? (Use arrow keys to navigate menu rather than mouse)
    position =
    'bottom-right'             -- Choose where menu is positioned. Options : 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right'
}
Config.UseRadialMenu = false   -- Enable use of radial menu built in to ox_lib? (REQUIRES OX_LIB 3.0 OR HIGHER - Editable in client/radial.lua)

Config.customCarlock = true   -- If you use wasabi_carlock OR qb-carlock set to true(Add your own carlock system in client/cl_customize.lua)
Config.billingSystem = false   -- Current options: 'esx' (For esx_billing) / 'qb' (QBCore) / 'okok' (For okokBilling) (Easy to add more/fully customize in client/cl_customize.lua)

Config.OldQBManagement = false -- If you use older qb-management

Config.AdvancedParking = false -- Delete vehicles with their exports(Script named advanced parking)
Config.Jail = {
    enabled = false,           -- Enable jail feature?
    input = true,              -- Enable input? Some needs it
    jail = 'custom',                 -- Current options: 'qb' (For qb-prison) / 'rcore' (For rcore-prison) / 'tk_jail' (For tk_jail) / 'hd_jail' (For hd_jail) / 'myPrison' (For myPrison) / 'qalle-jail' (For qalle-jail) / 'plouffe ' (For Plouffe Jail) / 'mx' (For mxJail) / 'custom' (For custom)
}
-- NOTE: If using qb-prison, you must make one small change to qb-prison.
-- SEE https://docs.wasabiscripts.com/scripts/wasabi_police/customizations#qb-prison-integration

Config.inventory =
'ox'                             -- NEEDED FOR SEARCHING PLAYERS - Current options: 'ox' (For ox_inventory) / 'qb' (For QbCore Inventory) / 'mf' (For mf inventory) / 'qs' (For qs_inventory) / 'cheeza' (For cheeza_inventory) / 'custom' (Custom can be added in client/cl_customize.lua)
Config.searchPlayers = true-- Allow police jobs to search players (Must set correct inventory above)
Config.weaponsAsItems = true     -- (If you're unsure leave as true!)This is typically for older ESX and inventories that still use weapons as weapons and not items

Config.spikeStripsEnabled = true -- Enable functionality of spike strips (Disable if you use difference script for spike strips)


--[[ These resources can trigger:
    wasabi_police:handcuffPlayer
    wasabi_police:escortPlayer
    wasabi_police:inVehiclePlayer
    wasabi_police:outVehiclePlayer
]]

Config.AllowedResources = {
    'qb-core',
    'qb-radialmenu', -- For civilians to be able to use radial menu features(Already had compatibility without edit)
    "pixel_antiCL"
}

Config.AllowedJobs = { -- THIS HAS NOTHING TO DO with Config.policeJobs, only with triggering events above
    --'bloods'
}

Config.GrantWeaponLicenses = {
    enabled = true,          -- If you want police to have option to grant/revoke weapons licenses
    license_name = 'weapon', -- Name of license
    minGrade = 0,            -- Min grade to use this function
    menuPosition =
    'bottom-right'           -- Choose where menu of player select is positioned. Options : 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right'
}

Config.GSR = {                 -- Gunshot residue settings
    enabled = true,           -- Enabled?
    cleanInWater = true,       -- Can clean GSR while in water?
    timeToClean = 5 * seconds, -- How long to clean GSR in water if enabled
    autoClean = 600,           -- (IN SECONDS)How long before residue clears itself? Set to false if undesired to auto clean GSR
    command = 'gsr'            -- Command for testing for GSR? Set to false if undesired
}

Config.tackle = {
    enabled = true,    -- Enable tackle?
    policeOnly = true, -- Police jobs only use tackle?
    hotkey = 'G'       -- What key to press while sprinting to start tackle of target
}

Config.escort = {
    stophotkey = "R"
}

Config.handcuff = {                             -- Config in regards to cuffing
    defaultCuff = 'soft',                       -- Default cuff type (Options: 'soft' / 'hard') Changing this will be the default hotkey cuff type
    persistentCuff = false,                      -- Verify player's cuffed status during login(Requires any qb-core and esx 1.9.1+)
    timer = 20 * minutes,                       -- Time before player is automatically unrestrained(Set to false if not desired)
    hotkey = 'J',                               -- What key to press to handcuff people(Set to false for no hotkey)
    skilledEscape = {
        enabled = true,                         -- Allow criminal to simulate resisting by giving them a chance to break free from cuffs via skill check
        difficulty = { 'medium', 'easy', 'hard' } -- Options: 'easy' / 'medium' / 'hard' (Can be stringed along as they are in config)
    },
    cuffItem = {                                -- Have handcuffs as usable item? (ITEM NAME MUST BE IN ITEMS / YOU MUST ADD YOURSELF)
        enabled = false,                        -- Enable a handcuff usable item?? Must be in items table/database with name defined below
        required = true,                        -- Requires handcuff item to be in inventory when any handcuff function is used
        item = 'handcuffs'                      -- Item name (DONT FORGET to make sure its in your items)
    },
    lockpicking = {                             -- Lockpicking someone else out of handcuffs
        enabled = false,                        -- Enable handcuffs to be able to be lockpicked off(MUST HAVE LOCKPICK ITEM IN ITEMS)
        item = 'lockpick',
        breakChance = 50,                       -- Chance of lockpick breaking if failed (Set to 100 for 100% or 0 for never breaking)
        difficulty = { 'easy', 'medium', 'medium' } -- Options: 'easy' / 'medium' / 'hard' (Can be stringed along as they are in config)
    }
}

Config.policeJobs = { -- Police jobs
    'lspd',
    "sahp",
    "lscso"
    --    'sheriff'
}

Config.GPSBlips = {  -- Warning: May experience high usage when at high player count. Possibly turn up refreshrate as remedy!
    enabled = false, -- Enabled?
    refreshrate = 5, -- In Seconds Note: it could impact the server performance
    item = false,    -- Item required? Note: You have to use it then
    blip = {
        sprite = 1,
        color = 1,
        scale = 1.0,
        short = false,
    }
}

Config.Props = { -- What props are avaliable in the "Place Objects" section of the job menu

    {
        title = 'Barrier',             -- Label
        description = '',              -- Description (optional)
        model = `prop_barrier_work05`, -- Prop name within `
        groups = {                     -- ['job_name'] = min_rank
            ['lspd'] = 0,
            ['sahp'] = 0,
            ['lscso'] = 0
            --            ['sheriff'] = 0,
        }
    },
    {
        title = 'Barricade',
        description = '',
        model = `prop_mp_barrier_01`,
        groups = {
            ['lspd'] = 0,
            ['sahp'] = 0,
            ['lscso'] = 0
            --            ['sheriff'] = 0,
        }
    },
    {
        title = 'Traffic Cones',
        description = '',
        model = `prop_roadcone02a`,
        groups = {
            ['lspd'] = 0,
            ['sahp'] = 0,
            ['lscso'] = 0
            --            ['sheriff'] = 0,
        }
    },
    {
        title = 'Spike Strip',
        description = '',
        model = `p_ld_stinger_s`,
        groups = {
            ['lspd'] = 0,
            ['sahp'] = 0,
            ['lscso'] = 0
            --            ['sheriff'] = 0,
        }
    },

}

Config.Locations = {
    LSPD = {
        blip = {
            enabled = true,
            coords = vec3(464.57, -992.0, 30.69),
            sprite = 60,
            color = 29,
            scale = 1.0,
            string = 'Mission Row PD'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for each e.x. offpolice for police offsheriff for sheriff AND have grades for each pd grade - QBCORE REQUIRES NOTHING)
            jobLock = 'lspd',                    -- This must be set to which job will be utilizing (ESX MUST HAVE OFF DUTY JOB / GRADES FOR THIS - ex. offpolice or offsheriff)
            coords = vec3(464.87, -977.37, 30.69), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(464.87, -977.37, 30.69),
                heading = 91.06,
                width = 2.0,
                length = 1.0,
                minZ = 30.69 - 0.9,
                maxZ = 30.69 + 0.9
            }
        },

        bossMenu = {
            enabled = true,                        -- Enable boss menu?
            jobLock = 'lspd',                    -- Lock to specific police job? Set to false if not desired
            coords = vector3(462.4, -1007.48, 35.93), -- Location of boss menu (If not using target)
            label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            distance = 3.0,                        -- Distance to allow access/prompt with text UI (If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Access Boss Menu',
                coords = vec3(460.64, -985.64, 30.73),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 30.73 - 0.9,
                maxZ = 30.73 + 0.9
            }
        },
        armoury = {
            enabled = false,                                                                 -- Set to false if you don't want to use
            coords = vec3(454.05, -979.97, 30.69 - 0.9),                                    -- Coords of armoury
            heading = 90.8,                                                                -- Heading of armoury NPC
            ped = 's_f_y_cop_01',
            label = '[E] - Access Armoury',                                                 -- String of text ui
            jobLock = false,                                                             -- Allow only one of Config.policeJob listings / Set to false if allow all Config.policeJobs
            weapons = {
                [0] = exports.stem_common:tableMerge(lspdBaseWeapons),
                [1] = exports.stem_common:tableMerge(lspdBaseWeapons),
                [2] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [3] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [4] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [5] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [6] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [7] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [8] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [9] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [10] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [11] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons, lspdCaptainWeapons),
                [12] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons, lspdCaptainWeapons),
                [13] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons, lspdCaptainWeapons),
                [14] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons, lspdCaptainWeapons),
            }
        },

        cloakroom = {
            enabled = true,                        -- WILL NOT SHOW IN QBCORE INSTEAD USE QB-CLOTHING CONFIG! Set to false if you don't want to use (Compatible with esx_skin & wasabi fivem-appearance fork)
            jobLock = 'lspd',                    -- Allow only one of Config.policeJob listings / Set to false if allow all Config.policeJobs
            coords = vec3(462.36, -999.62, 30.69), -- Coords of cloakroom
            label = '[E] - Change Clothes',        -- String of text ui of cloakroom
            range = 2.0,                           -- Range away from coords you can use.
            uniforms = {                           -- Uniform choices
                -- [1] = {                            -- Order it will display
                --     label = 'Patrol',              -- Name of outfit that will display in menu
                --     minGrade = 0,                  -- Min grade level that can access? Set to 0 or false for everyone to use
                --     male = {                       -- Male variation
                --         clothing = {
                --             -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                --             -- https://docs.fivem.net/natives/?_0xD4F7B05C
                --             { component = 11, drawable = 5,  texture = 2 }, -- Torso
                --             { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                --             { component = 4,  drawable = 6,  texture = 1 }, -- Pants
                --             { component = 6,  drawable = 16, texture = 7 }, -- Shoes
                --             { component = 3,  drawable = 5,  texture = 0 }, -- Arms
                --         },
                --         props = {
                --             -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                --             -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                --             --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                --         }
                --     },
                --     female = {
                --         clothing = {
                --             -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                --             -- https://docs.fivem.net/natives/?_0xD4F7B05C
                --             { component = 11, drawable = 4,  texture = 0 }, -- Torso
                --             { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                --             { component = 4,  drawable = 25, texture = 0 }, -- Pants
                --             { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                --             { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                --         },
                --         props = {
                --             -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                --             -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                --             --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                --         }
                --     }
                -- },
                -- [2] = {              -- Order it will display
                --     label = 'Chief', -- Name of outfit that will display in menu
                --     minGrade = 0,    -- Min grade level that can access? Set to 0 or false for everyone to use
                --     male = {         -- Male variation
                --         clothing = {
                --             -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                --             -- https://docs.fivem.net/natives/?_0xD4F7B05C
                --             { component = 11, drawable = 15, texture = 0 }, -- Torso
                --             { component = 8,  drawable = 58, texture = 0 }, -- Shirt
                --             { component = 4,  drawable = 35, texture = 0 }, -- Pants
                --             { component = 6,  drawable = 24, texture = 0 }, -- Shoes
                --             { component = 3,  drawable = 15, texture = 0 }, -- Arms
                --         },
                --         props = {
                --             -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                --             -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                --             --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                --         }
                --     },
                --     female = {
                --         clothing = {
                --             -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                --             -- https://docs.fivem.net/natives/?_0xD4F7B05C
                --             { component = 11, drawable = 4,  texture = 0 }, -- Torso
                --             { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                --             { component = 4,  drawable = 25, texture = 0 }, -- Pants
                --             { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                --             { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                --         },
                --         props = {
                --             -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                --             -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                --             --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                --         }
                --     }
                -- },
                -- [3] = {              -- Order it will display
                --     label = 'Chief', -- Name of outfit that will display in menu
                --     minGrade = 0,    -- Min grade level that can access? Set to 0 or false for everyone to use
                --     male = {         -- Male variation
                --         clothing = {
                --             -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                --             -- https://docs.fivem.net/natives/?_0xD4F7B05C
                --             { component = 11, drawable = 15, texture = 0 }, -- Torso
                --             { component = 8,  drawable = 58, texture = 0 }, -- Shirt
                --             { component = 4,  drawable = 35, texture = 0 }, -- Pants
                --             { component = 6,  drawable = 24, texture = 0 }, -- Shoes
                --             { component = 3,  drawable = 15, texture = 0 }, -- Arms
                --         },
                --         props = {
                --             -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                --             -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                --             --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                --         }
                --     },
                --     female = {
                --         clothing = {
                --             -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                --             -- https://docs.fivem.net/natives/?_0xD4F7B05C
                --             { component = 11, drawable = 4,  texture = 0 }, -- Torso
                --             { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                --             { component = 4,  drawable = 25, texture = 0 }, -- Pants
                --             { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                --             { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                --         },
                --         props = {
                --             -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                --             -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                --             --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                --         }
                --     }
                -- },
            }
        },

        personalLocker = {                        -- Personal Locker. Only supports qb-inventory / qs-inventory (ox_inventory has this feature built-in)
            enabled = false,                      -- Enable personal locker for this station?
            jobLock = 'lspd',                   -- Job lock?
            coords = vec3(462.64, -995.88, 30.69), -- Area to prompt personal locker
            range = 2.0,                          -- Range it will prompt from coords above
            label = '[E] - Access Personal Locker',
            target = {
                enabled = false, -- If enabled, the location above will be obsolete
                label = 'Access Boss Menu',
                coords = vec3(462.64, -995.88, 30.69),
                heading = 354.94,
                width = 2.0,
                length = 1.0,
                minZ = 30.69 - 0.9,
                maxZ = 30.69 + 0.9
            }
        },


        vehicles = {                                   -- Vehicle Garage
            enabled = true,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            jobLock = false,                        -- Job lock? or access to all police jobs by using false
            zone = {
                coords = vector3(454.54, -1019.64, 28.36), -- Area to prompt vehicle garage
                range = 5.5,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            spawn = {
                land = {
                    coords = vector3(454.54, -1019.64, 28.36), -- Coords of where land vehicle spawn/return
                    heading =  86.01
                },
                air = {
                    coords = vec3(449.3, -981.32, 43.69), -- Coords of where air vehicles spawn/return
                    heading = 269.45
                }
            },
            options = {
                [0] = {                    -- Job grade as table name
                    ['pdbike'] = {         -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Police Bicycle',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                },
                [1] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars),
                [2] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, {                -- Job grade as table name
                    ['14pdcharger'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = '2014 Charger',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                }),
                [3] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, {                -- Job grade as table name
                    ['lapdm'] = {         -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'BMW Bike',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                }),
                [4] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [5] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [6] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [7] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [8] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [9] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [10] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [11] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [12] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [13] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
                [14] = exports.stem_common:tableMerge(lspdBaseCars, lspdOfficerCars, lspdSergeantCars, lspdLieutenantCars),
            }
        }
    },
    LSCSO = {
        blip = {
            enabled = true,
            coords = vector3(369.36, -1602.37, 29.29),
            sprite = 60,
            color = 11,
            scale = 1.0,
            string = 'Davis PD'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for each e.x. offpolice for police offsheriff for sheriff AND have grades for each pd grade - QBCORE REQUIRES NOTHING)
            jobLock = 'lscso',                    -- This must be set to which job will be utilizing (ESX MUST HAVE OFF DUTY JOB / GRADES FOR THIS - ex. offpolice or offsheriff)
            coords = vec3(464.87, -977.37, 30.69), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(464.87, -977.37, 30.69),
                heading = 91.06,
                width = 2.0,
                length = 1.0,
                minZ = 30.69 - 0.9,
                maxZ = 30.69 + 0.9
            }
        },

        bossMenu = {
            enabled = true,                        -- Enable boss menu?
            jobLock = 'lscso',                    -- Lock to specific police job? Set to false if not desired
            coords = vector3(462.4, -1007.48, 35.93), -- Location of boss menu (If not using target)
            label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            distance = 3.0,                        -- Distance to allow access/prompt with text UI (If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Access Boss Menu',
                coords = vec3(460.64, -985.64, 30.73),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 30.73 - 0.9,
                maxZ = 30.73 + 0.9
            }
        },
        armoury = {
            enabled = false,                                                                -- Set to false if you don't want to use
            coords = vec3(365.57, -1609.61, 29.29 - 0.9),                                    -- Coords of armoury
            heading = 352.86,                                                                -- Heading of armoury NPC
            ped = 's_f_y_cop_01',
            label = '[E] - Access Armoury',                                                 -- String of text ui
            jobLock = false,                                                             -- Allow only one of Config.policeJob listings / Set to false if allow all Config.policeJobs
            weapons = {
                [0] = exports.stem_common:tableMerge(lspdBaseWeapons),
                [1] = exports.stem_common:tableMerge(lspdBaseWeapons),
                [2] = exports.stem_common:tableMerge(lspdBaseWeapons),
                [3] = exports.stem_common:tableMerge(lspdBaseWeapons),
                [4] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [5] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [6] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [7] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [8] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [9] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [10] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [11] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [12] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [13] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
                [14] = exports.stem_common:tableMerge(lspdBaseWeapons, lspdSergeantWeapons),
            }
        },

        cloakroom = {
            enabled = true,                        -- WILL NOT SHOW IN QBCORE INSTEAD USE QB-CLOTHING CONFIG! Set to false if you don't want to use (Compatible with esx_skin & wasabi fivem-appearance fork)
            jobLock = 'lscso',                    -- Allow only one of Config.policeJob listings / Set to false if allow all Config.policeJobs
            coords = vector3(368.48, -1602.63, 29.29), -- Coords of cloakroom
            label = '[E] - Change Clothes',        -- String of text ui of cloakroom
            range = 2.0,                           -- Range away from coords you can use.
            uniforms = {                           -- Uniform choices
            }
        },

        personalLocker = {                        -- Personal Locker. Only supports qb-inventory / qs-inventory (ox_inventory has this feature built-in)
            enabled = false,                      -- Enable personal locker for this station?
            jobLock = 'lscso',                   -- Job lock?
            coords = vec3(462.64, -995.88, 30.69), -- Area to prompt personal locker
            range = 2.0,                          -- Range it will prompt from coords above
            label = '[E] - Access Personal Locker',
            target = {
                enabled = false, -- If enabled, the location above will be obsolete
                label = 'Access Boss Menu',
                coords = vec3(462.64, -995.88, 30.69),
                heading = 354.94,
                width = 2.0,
                length = 1.0,
                minZ = 30.69 - 0.9,
                maxZ = 30.69 + 0.9
            }
        },


        vehicles = {                                   -- Vehicle Garage
            enabled = true,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            jobLock = false,                        -- Job lock? or access to all police jobs by using false
            zone = {
                coords = vector3(378.59, -1629.55, 28.46), -- Area to prompt vehicle garage
                range = 5.5,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            spawn = {
                land = {
                    coords = vector3(378.59, -1629.55, 28.46), -- Coords of where land vehicle spawn/return
                    heading =  318.55
                },
                air = {
                    coords = vector3(362.82, -1598.28, 36.95), -- Coords of where air vehicles spawn/return
                    heading = 319.66
                }
            },
            options = {
                [0] = {},
                [1] = exports.stem_common:tableMerge(lscsoBaseCars),
                [2] = exports.stem_common:tableMerge(lscsoDeputyTwoCars),
                [3] = exports.stem_common:tableMerge(lscsoDeputyThreeCars),
                [4] = exports.stem_common:tableMerge(lscsoSergeantCars),
                [5] = exports.stem_common:tableMerge(lscsoSergeantCars, {
                    ['uctaxi'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Taxi UM',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['f250s'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Ford F250',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ["srtrango"] = {
                        label = "Dodge Rango SRT",
                        category = "land"
                    }
                }),
                [6] = exports.stem_common:tableMerge(lscsoSergeantCars, {
                    ["hpun"] = {
                        label = "Dodge Charger UM",         
                        category = "land"
                    },
                    ['uctaxi'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Taxi UM',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['f250s'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Ford F250',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ["srtrango"] = {
                        label = "Dodge Rango SRT",
                        category = "land"
                    }
                }),
                [7] = exports.stem_common:tableMerge(lscsoSergeantCars, {
                    ["hpun"] = {
                        label = "Dodge Charger UM",         
                        category = "land"
                    },
                    ['uctaxi'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Taxi UM',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['f250s'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Ford F250',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ["srtrango"] = {
                        label = "Dodge Rango SRT",
                        category = "land"
                    }
                }),
            }
        }
    },
    SAHP = {
        blip = {
            enabled = true,
            coords = vec3(1548.53, 819.47, 77.66),
            sprite = 60,
            color = 28,
            scale = 1.0,
            string = 'Tatavian Highway PD'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for each e.x. offpolice for police offsheriff for sheriff AND have grades for each pd grade - QBCORE REQUIRES NOTHING)
            jobLock = 'sahp',                    -- This must be set to which job will be utilizing (ESX MUST HAVE OFF DUTY JOB / GRADES FOR THIS - ex. offpolice or offsheriff)
            coords = vec3(464.87, -977.37, 30.69), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(464.87, -977.37, 30.69),
                heading = 91.06,
                width = 2.0,
                length = 1.0,
                minZ = 30.69 - 0.9,
                maxZ = 30.69 + 0.9
            }
        },

        bossMenu = {
            enabled = true,                        -- Enable boss menu?
            jobLock = 'sahp',                    -- Lock to specific police job? Set to false if not desired
            coords = vector3(1539.98, 815.45, 82.61), -- Location of boss menu (If not using target)
            label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            distance = 3.0,                        -- Distance to allow access/prompt with text UI (If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Access Boss Menu',
                coords = vec3(460.64, -985.64, 30.73),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 30.73 - 0.9,
                maxZ = 30.73 + 0.9
            }
        },
        armoury = {
            enabled = false,                                                                 -- Set to false if you don't want to use
            coords = vector3(1550.06, 838.88, 77.66 - 1),                                    -- Coords of armoury
            heading = 141.15,                                                                -- Heading of armoury NPC
            range = 6,
            ped = 's_f_y_cop_01',
            label = '[E] - Access Armoury',                                                 -- String of text ui
            jobLock = false,                                                             -- Allow only one of Config.policeJob listings / Set to false if allow all Config.policeJobs
            weapons = {
                [0] = exports.stem_common:tableMerge(sahpBaseWeapons),
                [1] = exports.stem_common:tableMerge(sahpBaseWeapons),
                [2] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons),
                [3] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons),
                [4] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons),
                [5] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons),
                [6] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons),
                [7] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons),
                [8] = exports.stem_common:tableMerge(sahpBaseWeapons, sahpTrooperTwoUpWeapons)
            }
        },

        cloakroom = {
            enabled = true,                        -- WILL NOT SHOW IN QBCORE INSTEAD USE QB-CLOTHING CONFIG! Set to false if you don't want to use (Compatible with esx_skin & wasabi fivem-appearance fork)
            jobLock = 'sahp',                    -- Allow only one of Config.policeJob listings / Set to false if allow all Config.policeJobs
            coords = vec3(462.36, -999.62, 30.69), -- Coords of cloakroom
            label = '[E] - Change Clothes',        -- String of text ui of cloakroom
            range = 2.0,                           -- Range away from coords you can use.
            uniforms = {                           -- Uniform choices
                [1] = {                            -- Order it will display
                    label = 'Patrol',              -- Name of outfit that will display in menu
                    minGrade = 0,                  -- Min grade level that can access? Set to 0 or false for everyone to use
                    male = {                       -- Male variation
                        clothing = {
                            -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                            -- https://docs.fivem.net/natives/?_0xD4F7B05C
                            { component = 11, drawable = 5,  texture = 2 }, -- Torso
                            { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                            { component = 4,  drawable = 6,  texture = 1 }, -- Pants
                            { component = 6,  drawable = 16, texture = 7 }, -- Shoes
                            { component = 3,  drawable = 5,  texture = 0 }, -- Arms
                        },
                        props = {
                            -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                            -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                            --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                        }
                    },
                    female = {
                        clothing = {
                            -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                            -- https://docs.fivem.net/natives/?_0xD4F7B05C
                            { component = 11, drawable = 4,  texture = 0 }, -- Torso
                            { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                            { component = 4,  drawable = 25, texture = 0 }, -- Pants
                            { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                            { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                        },
                        props = {
                            -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                            -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                            --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                        }
                    }
                },
                [2] = {              -- Order it will display
                    label = 'Chief', -- Name of outfit that will display in menu
                    minGrade = 0,    -- Min grade level that can access? Set to 0 or false for everyone to use
                    male = {         -- Male variation
                        clothing = {
                            -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                            -- https://docs.fivem.net/natives/?_0xD4F7B05C
                            { component = 11, drawable = 15, texture = 0 }, -- Torso
                            { component = 8,  drawable = 58, texture = 0 }, -- Shirt
                            { component = 4,  drawable = 35, texture = 0 }, -- Pants
                            { component = 6,  drawable = 24, texture = 0 }, -- Shoes
                            { component = 3,  drawable = 15, texture = 0 }, -- Arms
                        },
                        props = {
                            -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                            -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                            --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                        }
                    },
                    female = {
                        clothing = {
                            -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                            -- https://docs.fivem.net/natives/?_0xD4F7B05C
                            { component = 11, drawable = 4,  texture = 0 }, -- Torso
                            { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                            { component = 4,  drawable = 25, texture = 0 }, -- Pants
                            { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                            { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                        },
                        props = {
                            -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                            -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                            --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                        }
                    }
                },
                [3] = {              -- Order it will display
                    label = 'Chief', -- Name of outfit that will display in menu
                    minGrade = 0,    -- Min grade level that can access? Set to 0 or false for everyone to use
                    male = {         -- Male variation
                        clothing = {
                            -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                            -- https://docs.fivem.net/natives/?_0xD4F7B05C
                            { component = 11, drawable = 15, texture = 0 }, -- Torso
                            { component = 8,  drawable = 58, texture = 0 }, -- Shirt
                            { component = 4,  drawable = 35, texture = 0 }, -- Pants
                            { component = 6,  drawable = 24, texture = 0 }, -- Shoes
                            { component = 3,  drawable = 15, texture = 0 }, -- Arms
                        },
                        props = {
                            -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                            -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                            --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                        }
                    },
                    female = {
                        clothing = {
                            -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                            -- https://docs.fivem.net/natives/?_0xD4F7B05C
                            { component = 11, drawable = 4,  texture = 0 }, -- Torso
                            { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                            { component = 4,  drawable = 25, texture = 0 }, -- Pants
                            { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                            { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                        },
                        props = {
                            -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
                            -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

                            --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                        }
                    }
                },
            }
        },

        personalLocker = {                        -- Personal Locker. Only supports qb-inventory / qs-inventory (ox_inventory has this feature built-in)
            enabled = false,                      -- Enable personal locker for this station?
            jobLock = 'sahp',                   -- Job lock?
            coords = vec3(462.64, -995.88, 30.69), -- Area to prompt personal locker
            range = 2.0,                          -- Range it will prompt from coords above
            label = '[E] - Access Personal Locker',
            target = {
                enabled = false, -- If enabled, the location above will be obsolete
                label = 'Access Boss Menu',
                coords = vec3(462.64, -995.88, 30.69),
                heading = 354.94,
                width = 2.0,
                length = 1.0,
                minZ = 30.69 - 0.9,
                maxZ = 30.69 + 0.9
            }
        },


        vehicles = {                                   -- Vehicle Garage
            enabled = true,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            jobLock = false,                        -- Job lock? or access to all police jobs by using false
            zone = {
                coords = vector3(1558.67, 820.98, 77.14), -- Area to prompt vehicle garage
                range = 5.5,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            spawn = {
                land = {
                    coords = vector3(1558.65, 821.54, 77.14), -- Coords of where land vehicle spawn/return
                    heading = 188.51
                },
                air = {
                    coords = vector3(1564.43, 844.03, 77.14), -- Coords of where air vehicles spawn/return
                    heading = 237.94
                }
            },
            options = {
                [0] = {
                },

                [1] = {                
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },  
                },  
                [2] = {                
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },           
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },           
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },           
                },
                [3] = {                
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },         
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },                
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    },
                },
                [4] = {                
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },        
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },         
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    },
                },
                [5] = {              
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },        
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },         
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    }, 
                },
                [6] = {              
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },        
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },         
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    },
                    ['hwaymav'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'LSPD Maverick Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                },
                [7] = {              
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },        
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },         
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    },         
                    ['hpun'] = {        
                        label = 'Dodge Charger Unmarked',
                        category = 'land', 
                    }, 
                    ['hwaymav'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'LSPD Maverick Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                },
                [8] = {              
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },        
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },         
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    },         
                    ['hpun'] = {        
                        label = 'Dodge Charger Unmarked',
                        category = 'land', 
                    },
                    ['hwaymav'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'LSPD Maverick Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                },
                [9] = {              
                    ['sahp2'] = {        
                        label = '2020 Dodge Charger',
                        category = 'land', 
                    },       
                    ['sahp2s'] = {        
                        label = '2020 Dodge Charger ST',
                        category = 'land', 
                    },       
                    ['chp3'] = {        
                        label = '2013 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp4'] = {        
                        label = '2016 Ford Explorer',
                        category = 'land', 
                    },       
                    ['sahp6'] = {        
                        label = '2020 Chevy Tahoe',
                        category = 'land', 
                    },       
                    ['hp7'] = {        
                        label = '2020 Ford Explorer',
                        category = 'land', 
                    },        
                    ['hp6'] = {        
                        label = '2018 Dodge RAM',
                        category = 'land', 
                    },        
                    ['hpbike'] = {        
                        label = '2014 BMW R 1200RT',
                        category = 'land', 
                    },         
                    ['hphellcat'] = {        
                        label = '2018 Dodge Charger SRT Hellcat',
                        category = 'land', 
                    },         
                    ['hpun'] = {        
                        label = 'Dodge Charger Unmarked',
                        category = 'land', 
                    },
                    ['hwaymav'] = {        -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'LSPD Maverick Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                },
            }
        }
    },
}
