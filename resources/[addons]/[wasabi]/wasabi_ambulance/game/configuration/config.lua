-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

local seconds, minutes = 1000, 60000
Config = {}

-------------------------------------------------------------------
-- TO MODIFY NOTIFICATIONS TO YOUR OWN CUSTOM NOTIFICATIONS:-------
------ Navigate to wasabi_bridge/customize/cl_customize.lua -------
-------------------------------------------------------------------
Config.CheckForUpdates = true -- Check for updates? Who would not want to know updates!?

-- Language Options are
-- 'en' (English)
-- 'fr' (French)
-- 'cn' (Chinese Simplified)
-- 'tw' (Chinese Traditional)
-- 'de' (German)
-- 'it' (Italian)
-- 'jp' (Japanese)
-- 'ko' (Korean)
-- 'pl' (Polish)
-- 'pt' (Portuguese)
-- 'es' (Spanish)
-- 'hi' (Hindi)
-- 'nl' (Dutch)
-- 'da' (Danish)
-- 'cs' (Czech)
-- If you would like us to add a language, join our discord and create a ticket!
-- All locale strings can be found in /game/configuration/locales/
Config.Language = 'en'
Config.UIColor = 'red'           -- Can be 'red', 'blue', or a hex '#FF0000'
Config.DeathScreenEffects = true -- Enable screen effects while dead (for applicable death screens)

-- Which style do you want to use for death UI?(Current options: 1, 2, 3, 4, 5)
-- Check docs for examples of all types! https://docs.wasabiscripts.com
Config.DeathScreenType = 5
-- If you want to use the previous death screen(Draw text, not recommended) see docs

Config.ambulanceJobs = { -- Jobs that are considered ambulance jobs (If unsure, likely leave the way it is)
    'amr',         -- You must have a job with this name registered
    --'emt',             -- They will be treated just like EMS (Job menu, loctions access, etc)
    --'doctor',
    --'fire',
}

Config.MuteDeadPlayers = false -- If a player is dead, should he be muted?

-- Logs
Config.DeathLogs = false  -- Enable death logs via Discord webhook?(Set up in configuration/deathlogs.lua)
Config.ReviveLogs = false -- Enable admin revive logs via Discord webhook? (Linked specifically to admin revives / will not log ALL revives)
Config.LogIPs = false     -- If Config.DeathLogs/Config.ReviveLogs enabled, do you want to logs IP addresses as well?

-- Stretcher Settings
Config.EnableStretcher = false -- Enable stretcher system?
Config.StretcherProp = 'wasabi_stretcher'
Config.StretcherKey = 38      -- Key to place the stretcher on the ground


Config.BagProp = `xm_prop_x17_bag_med_01a`
Config.UseRadialMenu = false             -- Enable use of radial menu built in to ox_lib? (REQUIRES OX_LIB 3.0 OR HIGHER - Editable in client/radial.lua)
Config.EnableAnimReset = false           -- If your death animation does not run correctly, then enable this
Config.MobileMenu = {                    -- Enabling this will use ox_lib menu rather than ox_lib context menu!
    enabled = false,                     -- Use a mobile menu from ox_lib rather than context? (Use arrow keys to navigate menu rather than mouse)
    position =
    'bottom-right'                       -- Choose where menu is positioned. Options : 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right'
}
Config.ProgressCircle = true             -- Set to false to use a progress bar, set to true for progress circle(For checking in, diagnosing, etc)
Config.ProgressCircleLocation = 'bottom' -- Where you want the progress circle located (if enabled)
-- Choices: 'bottom' and 'middle'

Config.policeCanTreat = {
    enabled = true, -- Police can treat patients?
    jobs = {        -- Police / other jobs
        'lspd',
        'sahp',
        'lscso',
    }
}

-- Enabled keys while dead and while on stretcher
-- https://docs.fivem.net/docs/game-references/controls/
Config.EnabledKeys = {
    dead = { -- while dead
        1,   -- Camera Pan(Mouse)
        2,   -- Camera Tilt(Mouse)
        38,  -- E Key
        46,  -- E Key
        47,  -- G Key
        245, -- T Key
        --249 -- N Key (default key to speak while dead)
    },

    stretcher = { -- while alive on stretcher
        1,        -- Camera Pan(Mouse)
        2,        -- Camera Tilt(Mouse)
        245,      -- T Key
        249       -- N Key (default key to speak while dead)
    }
}

-- Ambulances and their offsets for placing stretcher within vehicle
Config.AmbulanceOffsets = {
    ['ambulance'] = {            -- Vehicle model name
        trunkAsBackDoor = false, -- If the back doors are the trunk, if they are doors then set as false
        --    pos = { x = -0.26, y = -1.3, z = 0.3 }, -- Offset position
        --    rot = { x = -1.3, y = 0.0, z = 360.0 } -- Rotation
        pos = { x = 0.15, y = -3.0, z = 0.00 },
        rot = { x = -1.3, y = 0.0, z = 90.0 }
    },

    ['20ramambo'] = {           -- Rednecks generic 2020 ambulance
        trunkAsBackDoor = true, -- If the back doors are the trunk, if they are doors then set as false
        pos = { x = 0.0, y = -3.0, z = 1.0 },
        rot = { x = -1.3, y = 0.0, z = 360.0 }
    },

    ['ec135'] = {
        trunkAsBackDoor = false, -- If the back doors are the trunk, if they are doors then set as false
        pos = { x = -0.26, y = -0.6, z = -0.1 },
        rot = { x = -1.3, y = 0.0, z = 360.0 }
    }
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

-- Position for the draw Text while you are dead
--[[Config.MessagePosition = {
    respawn = { x = 0.5, y = 0.8 },
    bleedout = { x = 0.5, y = 0.8 },
    distress = { x = 0.5, y = 0.86 },
}]]
-- This is obsolete now, if you wish to use 3D text while dead still, see https://docs.wasabiscripts.com

-- Dead animation
Config.DeathAnimation = {
    anim = 'mini@cpr@char_b@cpr_def',
    lib = 'cpr_pumpchest_idle'
}

-- Knockout Feature (If you want players to be knocked out)
Config.KnockoutFeature = {
    enabled = false,           -- Enable knockout features? (player's can knock eachother out using fist fighting)
    healthForKnockout = 150,   -- At what HP will player knockout from fist fighting
    fistDamageModifier = 0.25, -- How much damage will fist cause? (1.0 is default, 0.5 is half as strong, etc)
    duration = 7 * seconds     -- Time to be knocked out when occurs?
}

-- Last Stand (2 Stage death)
Config.LastStand = false                -- Enable a 2 stage death. Where initially you can crawl around(Similiar to qb-ambulancejob)
Config.DisableLastStandCrawl = false   -- Disable crawling within last stand
Config.LastStandTickTime = 5 * seconds -- Everytime this time passes while in last stand, a random amount(8-15) amount of
-- health will be deducted to similuate bleeding out

-- Live injury
Config.EnableLiveInjury = false                             -- Enable live injury system?

Config.DamageDetectThreshold = { armour = 5, health = 10 } -- Damage threshold to detect injury (Default: {armour = 5, health = 10})

Config.BleedMultiplier = {
    shot = 2,    -- How much blood rate to loose when shot
    stabbed = 2, -- How much blood rate to loose when stabbed
    beat = 0,    -- How much blood rate to loose when beat
    burned = 0,  -- How much blood rate to loose when burned
}

Config.BypassInjuryWeapons = { -- Hashes placed in this table will bypass injury reasons
    `WEAPON_UNARMED`,
    `WEAPON_STUNGUN`,
    `WEAPON_DROWNING`,
    `WEAPON_DROWNING_IN_VEHICLE`,
    --  `WEAPON_FALL`,
}


Config.InjuryNotification = true                 -- Enable injury notification?
Config.InjuryNotificationFrequency = 1 * minutes -- How often to notify player of injury

Config.DisableNoJumpInjury = false               -- Disable when being injured that you cant job on occasion
Config.EnablePainPills = true                    -- Enable pain pills? Used to aliviate injurys temporarily

Config.PainPills = {                             -- Add more as you please. The level field simulates the severity of the narcodic; exceed 10 and it could be deadly
    --  ['ITEM_NAME'] = { label = 'ITEM_LABEL', duration = SECONDS }
    ['morphine30'] = { label = 'Morphine 30MG', duration = 120, level = 9 },
    ['morphine15'] = { label = 'Morphine 15MG', duration = 50, level = 5 },
    ['perc30'] = { label = 'Percocet 30MG', duration = 60, level = 6 },
    ['perc10'] = { label = 'Percocet 10MG', duration = 45, level = 4 },
    ['perc5'] = { label = 'Percocet 5MG', duration = 30, level = 2 },
    ['vic10'] = { label = 'Vicodin 10MG', duration = 40, level = 3 },
    ['vic5'] = { label = 'Vicodin 5MG', duration = 20, level = 2 },

}

-- 3rd party scripts
Config.wasabi_crutch = { -- If you use wasabi_crutch:
    ------------------------------------------------------
    --             If you use wasabi_crutch             --
    -- https://store.wasabiscripts.com/category/2080869 --
    ------------------------------------------------------

    -- Crutch Settings
    crutchInMedbag = { -- Enabled? Item name? REQUIRES WASABI_CRUTCH
        enabled = false,
        item = 'crutch'
    },
    crutchInJobMenu = false, -- Crutch menu accessible from job menu if true. REQUIRES WASABI_CRUTCH
    crutchOnCheckIn = {      -- Place crutch for certain amount of time if they visit the hospital or bleedout REQUIRES WASABI_CRUTCH
        enabled = false,     -- Requires wasabi_crutch
        duration = 3         -- How long stuck with crutch after check-in(In minutes)
    },
    -- Chair settings
    chairInMedbag = { -- Enabled? Item name? REQUIRES WASABI_CRUTCH
        enabled = false,
        item = 'wheelchair'
    },
    chairInJobMenu = false -- Chair menu accessible from job menu if true. REQUIRES WASABI_CRUTCH
}

Config.EnviPrescriptions = {
    ---------------------------------------------------
    --       If you use Envi Prescriptions:          --
    -- https://envi-scripts.tebex.io/package/5604452 --
    ---------------------------------------------------
    enabled = false, -- Enable to add option for prescriptions to job menu
    minRank = 1      -- Minimum job level/grade to have this option available
}

Config.phoneDistress = false        -- Options: 'gks' (GKS Phone - ESX ONLY) / 'qs' (qs-smartphone) / 'd-p' (d-phone) / 'lb' (lb-phone) WILL REPLACE BUILT IN DISPATCH WITH PHONE DISPATCH / Add additonal dispatch in client/cl_customize.lua
Config.customCarlock = true        -- If you use wasabi_carlock OR qb-carlock(Or want to add your own key system to wasabi_bridge/customize/cl_customize.lua)
Config.MythicHospital = false       -- If you use that old injury script by mythic. (Added per request to reset injuries on respawn)
Config.AdvancedParking = false      -- If you use AdvancedParking (Deletes vehicles with their exports)
Config.FuelSystem = false           -- 'legacy' (LegacyFuel) / 'ox' (ox_fuel) / 'default'

Config.jobMenu = 'F6'               -- Default job menu key
Config.billingSystem = false        -- Current options: 'esx' (For esx_billing) / 'qb' (For qbcore users) 'okok' (For okokBilling) / 'pefcl' (For NPWD billing system) (Easy to add more in editable client - SET TO false IF UNDESIRED) or of course false to disable
Config.targetSystem = true          -- Target system for targetting players, medbags, and stretcher(If disabled with replace with menus/3D text) (Compatible out of the box with qTarget, qb-target, and ox_target)

Config.RespawnTimer = GlobalState.purgeActive and 0.25 * minutes or 5 * minutes   -- Time before optional respawn
Config.BleedoutTimer = 20 * minutes -- Time before it forces respawn

Config.removeItemsOnDeath = true   -- Must have Config.Inventory set properly
Config.Inventory =
'ox'                                --Options include: 'ox' - (ox_inventory) / 'qb' - (QBCore qb-inventory) 'mf' - (mf-inventory) / 'qs' (qs-inventory) / 'esx' (default esx) / 'other' (whatever else can customize in client/cl_customize.lua)

Config.AntiCombatLog = {            --  When enabled will kill player who logged out while dead
    enabled = true,                 --  enabled?
    notification = {
        enabled = true,             -- enabled notify of wrong-doings??
        title = 'Logged While Dead',
        desc = 'You last left dead and now have returned dead'
    }
}

Config.CompleteDeath = { --DOES NOT APPLY TO QBCORE --  When enabled players can no longer use their character after x deaths
    --DOES NOT APPLY TO QBCORE --  ONLY SUPPORTS esx_multicharacter / You can edit it in server/sv_customize.lua
    enabled = false,     -- enabled?
    maxDeaths = 100,     -- Max 255
}

Config.Bandages = {
    enabled = false,       -- Useable bandages? (Leave false if ox_inventory because they're built in)
    item = 'bandage',      -- YOU MUST ADD THIS ITEM TO YOUR ITEMS, IT DOES NOT COME IN INSTALLATION(COMES WITH QBCORE BY DEFAULT AS ITEM)
    hpRegen = 30,          -- Percentage of health it replenishes (30% by default)
    healBleed = false,     -- Heal bleed that is inflicted by injury system? (Requires injury system enabled)
    duration = 7 * seconds -- Time to use
}

Config.EMSItems = {
    revive = {
        item = 'defib', -- Item used for reviving
        remove = false  -- Remove item when using?
    },
    heal = {
        item = 'medikit',       -- Item used for healing
        duration = 5 * seconds, -- Time to use
        healBleed = true,       -- Heal bleed?
        remove = true           -- Remove item when using?
    },
    sedate = {
        item = 'sedative',      -- Item used to sedate players temporarily
        duration = 8 * seconds, -- Time sedative effects last
        remove = true           -- Remove item when using?
    },
    medbag = 'medbag',          -- Medbag item name used for getting supplies to treat patient
}

Config.ReviveRewards = {
    enabled = true,           -- Enable cash rewards for reviving
    paymentAccount = 'money', -- If you have old ESX 1.1 you may need to switch to 'cash'
    no_injury = 4000,         -- If above enabled, how much reward for fully treated patient with no injury in diagnosis
    burned = 3000,            -- How much if player is burned and revived without being treated
    beat = 2500,              -- So on, so forth
    stabbed = 2000,
    bleedout = 2000,          -- NEW
    shot = 1500,
}

Config.ReviveHealth = { -- How much health to deduct for those revived without proper treatment
    shot = 60,          -- Ex. If player is shot and revived without having the gunshots treated; they will respond with 60 health removed
    stabbed = 50,
    beat = 40,
    burned = 20
}

Config.TreatmentTime = 9 * seconds -- Time to perform treatment
Config.DiagnoseTime = 7 * seconds  -- Time to diagnose patient

Config.TreatmentItems = {
    shot = 'tweezers',
    stabbed = 'suturekit',
    beat = 'icepack',
    burned = 'burncream'
}

Config.lowHealthAlert = {
    enabled = false,
    health = 140, -- Notify when at HP (200 full health / 100 is death)
    notification = {
        title = 'ATTENTION',
        description = 'You are in bad health. You should see a doctor soon!'
    }
}

Config.EnableStandaloneCheckIns = false -- Enable stand-alone check-in locations? For grandmas, prisons, whatever
Config.StandaloneCheckIns = {
    Prison = {                                        -- Example, QB Prison check-in
        Ped = 's_m_m_scientist_01',                   -- Check in ped
        Coords = vec3(1729.03, 2563.33, 45.56 - 0.9), -- Coords of ped
        Distance = 4.85,                              -- Distance to show textUI (If target is not enabled below)
        Heading = 181.42,                             -- Heading of ped
        Cost = 5,                                     -- Cost of using hospital check-in. Set to false for free
        Duration = 15 * seconds,                      -- Time it takes to spend in hospital bed
        PayAccount = 'bank',                          -- Account dead player pays from to check-in
        Label = '[E] - Check In',                     -- label of text UI if target is not enabled below
        HotKey = 38,                                  -- Default: 38 (E) (If target below is not enabled)
        Target = {
            enabled = true,                           -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
            label = 'Check In',
            coords = vec3(1729.03, 2563.33, 45.56),
            heading = 63.26,
            distance = 5.0,
            width = 2.0,
            length = 1.0,
            minZ = 43.28 - 0.9,
            maxZ = 43.28 + 0.9
        },
        DisableHospitalBeds = true,                                                          -- Disable hospital beds for check-in at this location?(Player will spend Duration checking in before respawning in RespawnNoBedLocation coords when set to true)
        RespawnNoBedLocation = { coords = vec3(1729.03, 2563.33, 45.56), heading = 339.02 }, -- Coords and heading of where to spawn player if DisableHospitalBeds is set to true or beds full
        HospitalBeds = {
            --              { coords = vec3(332.62, -587.17, 42.84+0.3), heading = 160.0 },
            { coords = vec3(317.67, -585.37, 42.84 + 0.3), heading = 160.0 },
        }
    },
}
Config.Locations = {
    Zonah = {
        RespawnPoint = { -- When player dies and bleeds out; they will revive at nearest hospital; Define the coords of this hospital here.
            coords = vector3(-458.79, -283.96, 34.91),
            heading = 349.99,
            -- Even if you have useCheckInInstead to true, you must still define these coords for finding closest hospital
            -- If you want to use check-in instead of respawning at this location(Otherwise will just spawn at the coords above)
            useCheckInInstead = true
        },

        Blip = {
            Enabled = true,
            Coords = vector3(-442.99, -322.24, 34.91),
            Sprite = 61,
            Color = 2,
            Scale = 1.0,
            String = 'Mt Zonah Hospital'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for Config.ambulanceJob with same grades - example in main _install_first directory)
            coords = vec3(334.75, -580.24, 43.28), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(334.75, -580.24, 43.28),
                heading = 337.07,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },

        PersonalLocker = {
            enabled = false,                        -- Enable personal locker(stash) - THIS IS CURRENTLY ONLY AVALIABLE IN QB-INVENTORY
            coords = vector3(316.83, -600.81, 43.29),   -- Location of where to access personal locker (If target is disabled)
            label = '[E] - Access Personal Locker', -- Text to display(If not using target)
            distance = 1.5,                         -- Distance to display text UI(If not using target)
            target = {
                enabled = true,                    -- If enabled, the location and distance above will be obsolete
                label = 'Access Locker',
                coords = vec3(316.83, -600.81, 43.29),
                heading = 70.18,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },


        BossMenu = {
            Enabled = false,                        -- Enabled boss menu?
            Coords = vector3(305.02, -598.33, 43.29), -- Location of boss menu (If not using target)
            Label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            Distance = 2.5,                        -- Distance to allow access/prompt with text UI (If not using target)
            Target = {
                enabled = false,                   -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Access Boss Menu',
                coords = vec3(335.59, -594.33, 43.21),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 43.21 - 0.9,
                maxZ = 43.21 + 0.9
            }
        },
        CheckIn = {                                     -- Hospital check-in
            Enabled = true,                              -- Enable ped and check-in area?
            Ped = 's_m_m_scientist_01',                  -- Check in ped
            Coords = vec3(-435.38, -324.02, 34.91- 0.9), -- Coords of ped
            Distance = 6,                             -- Distance to show textUI (If target is not enabled below)
            Heading = 160.51,                             -- Heading of ped
            Cost = false,                                -- Cost of using hospital check-in. Set to false for free
            Duration = 15 * seconds,                     -- Time it takes to spend in hospital bed
            MaxOnDuty = false,                               -- If this amount or less you can use, otherwise it will tell you that EMS is avaliable(Set to false to always enable check-in)
            PayAccount = 'bank',                         -- Account dead player pays from to check-in
            Label = '[E] - Check In',                    -- label of text UI if target is not enabled below
            HotKey = 38,                                 -- Default: 38 (E) (If target below is not enabled)
            Target = {
                enabled = true,                          -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Check In',
                coords = vec3(-435.38, -324.02, 34.91),
                heading = 63.26,
                distance = 6,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            },
            DisableHospitalBeds = false,                                              -- Disable hospital beds for check-in at this location?(Player will spend Duration checking in before respawning in RespawnNoBedLocation when set to true)
            RespawnNoBedLocation = { coords = vector3(-458.95, -283.59, 34.91), heading = 3199.88 }, -- Coords and heading of where to spawn player if DisableHospitalBeds is set to true or beds are full
            HospitalBeds = {
                { coords = vec3(-460.31, -288.47, 35.83 - 1), heading = 200.17 },
                { coords = vec3(455.1, -286.15, 35.83 - 1), heading = 199.65 },
                { coords = vec3(-458.9, -279.74, 35.84 - 1), heading = 22.43 },
                { coords = vec3(-462.7, -281.38, 35.84 - 1), heading = 26.29 },
                -- { coords = vec3(354.41, -577.61, 44.21 - 1.3), heading = 339.54 },
                -- { coords = vec3(351.84, -577.07, 44.21 - 1.3), heading = 339.54 },
                -- { coords = vec3(349.58, -575.93, 44.21 - 1.3), heading = 339.54 },

                -- { coords = vec3(319.41, -581.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(314.47, -584.2, 42.84 + 0.3),  heading = 160.0 },
                -- { coords = vec3(313.93, -579.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(311.06, -582.96, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(307.72, -581.75, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(309.35, -577.38, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(361.36, -581.3, 42.83 + 0.3),  heading = 250.0 },
                -- { coords = vec3(359.54, -586.23, 42.84 + 0.3), heading = 250.0 },
                -- { coords = vec3(354.44, -600.19, 42.85 + 0.3), heading = 250.0 },
                -- { coords = vec3(324.26, -582.8, 42.84 + 0.3),  heading = 340.0 },
                -- Stock qb-ambulance hospital bed coords:
                --                { coords = vec3(353.1, -584.6, 43.11), heading = 152.08 },
                --                { coords = vec3(356.79, -585.86, 43.11), heading = 152.08 },
                --                { coords = vec3(354.12, -593.12, 43.1), heading = 336.32 },
                --                { coords = vec3(350.79, -591.8, 43.1), heading = 336.32 },
                --                { coords = vec3(346.99, -590.48, 43.1), heading = 336.32 },
                --                { coords = vec3(360.32, -587.19, 43.02), heading = 152.08 },
                --                { coords = vec3(349.82, -583.33, 43.02), heading = 152.08 },
                --                { coords = vec3(326.98, -576.17, 43.02), heading = 152.08 }
            }

        },
        Cloakroom = {
            Enabled = false,
            Coords = vector3(298.85, -598.26, 43.28), -- Coords of cloakroom
            Label = '[E] - Change Clothes',     -- String of text ui of cloakroom
            HotKey = 38,                        -- Default: 38 (E)
            Range = 1.5,                        -- Range away from coords you can use.
            Uniforms = {                        -- Uniform choices
            }
        },

        MedicalSupplies = {                                                     -- EMS Shop for supplies
            Enabled = false,                                                 -- If set to false, rest of this table do not matter
            Ped = 's_m_m_doctor_01',                                            -- Ped to target
            Coords = vec3(303.1, -595.94, 43.28 - 0.95),                       -- Coords of ped/target
            Heading = 160.09,                                                    -- Heading of ped
            Supplies = {                                                        -- Supplies
                { item = 'radio',    label = 'Radio', price = false },
                -- { item = 'bandage',    label = 'Bandage', price = false },
                -- { item = 'medbag',     label = 'Medical Bag',   price = false  }, -- Pretty self explanatory, price may be set to 'false' to make free
                -- { item = 'medikit',    label = 'First-Aid Kit', price = false },
                -- { item = 'defib',    label = 'Defib Kit', price = false },
                -- { item = 'burncream',    label = 'Burn Cream', price = false },
                -- { item = 'icepack',    label = 'Ice Pack', price = false },
                -- { item = 'suturekit',    label = 'Suture Kit', price = false },
                -- { item = 'tweezers',    label = 'Tweezers', price = false },
                -- { item = 'morphine30', label = 'Morphine 30MG', price = false },
                -- { item = 'morphine10', label = 'Morphine 10MG', price = false },
                -- { item = 'perc30',     label = 'Percocet 30MG', price = false },
                -- { item = 'perc10',     label = 'Percocet 10MG', price = false },
                -- { item = 'perc5',      label = 'Percocet 5MG',  price = false },
                -- { item = 'vic10',      label = 'Vicodin 10MG',  price = false },
                -- { item = 'vic5',       label = 'Vicodin 5MG',   price = false },
            }
        },

        Vehicles = {                                   -- Vehicle Garage
            Enabled = true,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            Zone = {
                coords = vector3(-487.73, -347.78, 34.5), -- Area to prompt vehicle garage
                range = 2,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            Spawn = {
                land = {
                    coords = vector4(-487.2, -342.93, 34.36, 263.95),
                    heading = 263.95
                }
            },
            Options = {
                [0] = {},

                [1] = {
                    ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'E450 Ambulance',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Stretcher',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                },

                [2] = {
                    ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'E450 Ambulance',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['sprinter1'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Sprinter',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['sprinter2'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Sprinter 2',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['amrheli'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'AMR Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                    ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Stretcher',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                }
            }
        },
    },
    Paleto = {
        RespawnPoint = { -- When player dies and bleeds out; they will revive at nearest hospital; Define the coords of this hospital here.
            coords = vector3(-251.28, 6316.91, 32.43),
            heading = 316.65,
            -- Even if you have useCheckInInstead to true, you must still define these coords for finding closest hospital
            -- If you want to use check-in instead of respawning at this location(Otherwise will just spawn at the coords above)
            useCheckInInstead = true
        },

        Blip = {
            Enabled = true,
            Coords = vector3(-251.79, 6324.18, 33.48),
            Sprite = 61,
            Color = 2,
            Scale = 1.0,
            String = 'Paleto Bay Hospital'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for Config.ambulanceJob with same grades - example in main _install_first directory)
            coords = vec3(334.75, -580.24, 43.28), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(334.75, -580.24, 43.28),
                heading = 337.07,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },

        PersonalLocker = {
            enabled = false,                        -- Enable personal locker(stash) - THIS IS CURRENTLY ONLY AVALIABLE IN QB-INVENTORY
            coords = vector3(316.83, -600.81, 43.29),   -- Location of where to access personal locker (If target is disabled)
            label = '[E] - Access Personal Locker', -- Text to display(If not using target)
            distance = 1.5,                         -- Distance to display text UI(If not using target)
            target = {
                enabled = true,                    -- If enabled, the location and distance above will be obsolete
                label = 'Access Locker',
                coords = vec3(316.83, -600.81, 43.29),
                heading = 70.18,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },


        BossMenu = {
            Enabled = false,                        -- Enabled boss menu?
            Coords = vector3(305.02, -598.33, 43.29), -- Location of boss menu (If not using target)
            Label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            Distance = 2.5,                        -- Distance to allow access/prompt with text UI (If not using target)
            Target = {
                enabled = false,                   -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Access Boss Menu',
                coords = vec3(335.59, -594.33, 43.21),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 43.21 - 0.9,
                maxZ = 43.21 + 0.9
            }
        },
        CheckIn = {                                     -- Hospital check-in
            Enabled = true,                              -- Enable ped and check-in area?
            Ped = 's_m_m_scientist_01',                  -- Check in ped
            Coords = vec3(-256.26, 6331.15, 32.43- 0.9), -- Coords of ped
            Distance = 6,                             -- Distance to show textUI (If target is not enabled below)
            Heading = 320.04,                             -- Heading of ped
            Cost = false,                                -- Cost of using hospital check-in. Set to false for free
            Duration = 15 * seconds,                     -- Time it takes to spend in hospital bed
            MaxOnDuty = false,                               -- If this amount or less you can use, otherwise it will tell you that EMS is avaliable(Set to false to always enable check-in)
            PayAccount = 'bank',                         -- Account dead player pays from to check-in
            Label = '[E] - Check In',                    -- label of text UI if target is not enabled below
            HotKey = 38,                                 -- Default: 38 (E) (If target below is not enabled)
            Target = {
                enabled = true,                          -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Check In',
                coords = vec3(-256.26, 6331.15, 32.43),
                heading = 63.26,
                distance = 6,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            },
            DisableHospitalBeds = false,                                              -- Disable hospital beds for check-in at this location?(Player will spend Duration checking in before respawning in RespawnNoBedLocation when set to true)
            RespawnNoBedLocation = { coords = vector3(-458.95, -283.59, 34.91), heading = 3199.88 }, -- Coords and heading of where to spawn player if DisableHospitalBeds is set to true or beds are full
            HospitalBeds = {
                { coords = vec3(-254.46, 6313.78, 33.34 - 1), heading = 133.36  },
                { coords = vec3(-256.04, 6315.61, 33.34 - 1), heading = 133.36 },
                { coords = vec3(-247.11, 6317.89, 33.344 - 1), heading =  314.15  },
                { coords = vec3(-252.16, 6323.2, 33.34 - 1), heading = 314.15  },
                -- { coords = vec3(354.41, -577.61, 44.21 - 1.3), heading = 339.54 },
                -- { coords = vec3(351.84, -577.07, 44.21 - 1.3), heading = 339.54 },
                -- { coords = vec3(349.58, -575.93, 44.21 - 1.3), heading = 339.54 },

                -- { coords = vec3(319.41, -581.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(314.47, -584.2, 42.84 + 0.3),  heading = 160.0 },
                -- { coords = vec3(313.93, -579.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(311.06, -582.96, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(307.72, -581.75, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(309.35, -577.38, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(361.36, -581.3, 42.83 + 0.3),  heading = 250.0 },
                -- { coords = vec3(359.54, -586.23, 42.84 + 0.3), heading = 250.0 },
                -- { coords = vec3(354.44, -600.19, 42.85 + 0.3), heading = 250.0 },
                -- { coords = vec3(324.26, -582.8, 42.84 + 0.3),  heading = 340.0 },
                -- Stock qb-ambulance hospital bed coords:
                --                { coords = vec3(353.1, -584.6, 43.11), heading = 152.08 },
                --                { coords = vec3(356.79, -585.86, 43.11), heading = 152.08 },
                --                { coords = vec3(354.12, -593.12, 43.1), heading = 336.32 },
                --                { coords = vec3(350.79, -591.8, 43.1), heading = 336.32 },
                --                { coords = vec3(346.99, -590.48, 43.1), heading = 336.32 },
                --                { coords = vec3(360.32, -587.19, 43.02), heading = 152.08 },
                --                { coords = vec3(349.82, -583.33, 43.02), heading = 152.08 },
                --                { coords = vec3(326.98, -576.17, 43.02), heading = 152.08 }
            }

        },
        Cloakroom = {
            Enabled = false,
            Coords = vector3(298.85, -598.26, 43.28), -- Coords of cloakroom
            Label = '[E] - Change Clothes',     -- String of text ui of cloakroom
            HotKey = 38,                        -- Default: 38 (E)
            Range = 1.5,                        -- Range away from coords you can use.
            Uniforms = {                        -- Uniform choices
            }
        },

        MedicalSupplies = {                                                     -- EMS Shop for supplies
            Enabled = false,                                                 -- If set to false, rest of this table do not matter
            Ped = 's_m_m_doctor_01',                                            -- Ped to target
            Coords = vec3(303.1, -595.94, 43.28 - 0.95),                       -- Coords of ped/target
            Heading = 160.09,                                                    -- Heading of ped
            Supplies = {                                                        -- Supplies
                { item = 'radio',    label = 'Radio', price = false },
                -- { item = 'bandage',    label = 'Bandage', price = false },
                -- { item = 'medbag',     label = 'Medical Bag',   price = false  }, -- Pretty self explanatory, price may be set to 'false' to make free
                -- { item = 'medikit',    label = 'First-Aid Kit', price = false },
                -- { item = 'defib',    label = 'Defib Kit', price = false },
                -- { item = 'burncream',    label = 'Burn Cream', price = false },
                -- { item = 'icepack',    label = 'Ice Pack', price = false },
                -- { item = 'suturekit',    label = 'Suture Kit', price = false },
                -- { item = 'tweezers',    label = 'Tweezers', price = false },
                -- { item = 'morphine30', label = 'Morphine 30MG', price = false },
                -- { item = 'morphine10', label = 'Morphine 10MG', price = false },
                -- { item = 'perc30',     label = 'Percocet 30MG', price = false },
                -- { item = 'perc10',     label = 'Percocet 10MG', price = false },
                -- { item = 'perc5',      label = 'Percocet 5MG',  price = false },
                -- { item = 'vic10',      label = 'Vicodin 10MG',  price = false },
                -- { item = 'vic5',       label = 'Vicodin 5MG',   price = false },
            }
        },

        Vehicles = {                                   -- Vehicle Garage
            Enabled = false,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            Zone = {
                coords = vector3(332.98, -576.79, 28.8), -- Area to prompt vehicle garage
                range = 2,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            Spawn = {
                land = {
                    coords = vector3(332.98, -576.79, 28.8),
                    heading = 341.48
                },
                air = {
                    coords = vec3(351.24, -587.67, 74.55),
                    heading = 289.29
                }
            },
            Options = {
                [0] = {},

                [1] = {
                    ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'E450 Ambulance',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Stretcher',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                },

                [2] = {
                    ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'E450 Ambulance',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['sprinter1'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Sprinter',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['sprinter2'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Sprinter 2',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['amrheli'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'AMR Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                    ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Stretcher',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                }
            }
        },
    },
    Pillbox = {
        RespawnPoint = { -- When player dies and bleeds out; they will revive at nearest hospital; Define the coords of this hospital here.
            coords = vector3(316.4, -581.84, 43.28),
            heading = 349.99,
            -- Even if you have useCheckInInstead to true, you must still define these coords for finding closest hospital
            -- If you want to use check-in instead of respawning at this location(Otherwise will just spawn at the coords above)
            useCheckInInstead = true
        },

        Blip = {
            Enabled = true,
            Coords = vec3(324.15, -583.14, 44.20),
            Sprite = 61,
            Color = 2,
            Scale = 1.0,
            String = 'Pillbox Hospital'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for Config.ambulanceJob with same grades - example in main _install_first directory)
            coords = vec3(334.75, -580.24, 43.28), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(334.75, -580.24, 43.28),
                heading = 337.07,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },

        PersonalLocker = {
            enabled = true,                        -- Enable personal locker(stash) - THIS IS CURRENTLY ONLY AVALIABLE IN QB-INVENTORY
            coords = vector3(316.83, -600.81, 43.29),   -- Location of where to access personal locker (If target is disabled)
            label = '[E] - Access Personal Locker', -- Text to display(If not using target)
            distance = 1.5,                         -- Distance to display text UI(If not using target)
            target = {
                enabled = true,                    -- If enabled, the location and distance above will be obsolete
                label = 'Access Locker',
                coords = vec3(316.83, -600.81, 43.29),
                heading = 70.18,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },


        BossMenu = {
            Enabled = true,                        -- Enabled boss menu?
            Coords = vector3(305.02, -598.33, 43.29), -- Location of boss menu (If not using target)
            Label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            Distance = 2.5,                        -- Distance to allow access/prompt with text UI (If not using target)
            Target = {
                enabled = false,                   -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Access Boss Menu',
                coords = vec3(335.59, -594.33, 43.21),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 43.21 - 0.9,
                maxZ = 43.21 + 0.9
            }
        },
        CheckIn = {                                     -- Hospital check-in
            Enabled = true,                              -- Enable ped and check-in area?
            Ped = 's_m_m_scientist_01',                  -- Check in ped
            Coords = vec3(311.48, -594.16, 43.28 - 0.9), -- Coords of ped
            Distance = 4.85,                             -- Distance to show textUI (If target is not enabled below)
            Heading = 345.32,                             -- Heading of ped
            Cost = false,                                -- Cost of using hospital check-in. Set to false for free
            Duration = 15 * seconds,                     -- Time it takes to spend in hospital bed
            MaxOnDuty = false,                               -- If this amount or less you can use, otherwise it will tell you that EMS is avaliable(Set to false to always enable check-in)
            PayAccount = 'bank',                         -- Account dead player pays from to check-in
            Label = '[E] - Check In',                    -- label of text UI if target is not enabled below
            HotKey = 38,                                 -- Default: 38 (E) (If target below is not enabled)
            Target = {
                enabled = true,                          -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Check In',
                coords = vec3(311.48, -594.16, 43.28),
                heading = 63.26,
                distance = 5.0,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            },
            DisableHospitalBeds = false,                                              -- Disable hospital beds for check-in at this location?(Player will spend Duration checking in before respawning in RespawnNoBedLocation when set to true)
            RespawnNoBedLocation = { coords = vec3(316.66, -581.3, 43.28), heading = 339.02 }, -- Coords and heading of where to spawn player if DisableHospitalBeds is set to true or beds are full
            HospitalBeds = {
                { coords = vec3(314.6, -584.11, 44.2 - 1), heading = 154.04 },
                { coords = vec3(311.12, -582.82, 44.2 - 1), heading = 154.04 },
                { coords = vec3(319.42, -581.04, 44.2 - 1), heading = 338.15 },
                { coords = vec3(313.99, -579.01, 44.2 - 1), heading = 339.72 },
                -- { coords = vec3(354.41, -577.61, 44.21 - 1.3), heading = 339.54 },
                -- { coords = vec3(351.84, -577.07, 44.21 - 1.3), heading = 339.54 },
                -- { coords = vec3(349.58, -575.93, 44.21 - 1.3), heading = 339.54 },

                -- { coords = vec3(319.41, -581.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(314.47, -584.2, 42.84 + 0.3),  heading = 160.0 },
                -- { coords = vec3(313.93, -579.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(311.06, -582.96, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(307.72, -581.75, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(309.35, -577.38, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(361.36, -581.3, 42.83 + 0.3),  heading = 250.0 },
                -- { coords = vec3(359.54, -586.23, 42.84 + 0.3), heading = 250.0 },
                -- { coords = vec3(354.44, -600.19, 42.85 + 0.3), heading = 250.0 },
                -- { coords = vec3(324.26, -582.8, 42.84 + 0.3),  heading = 340.0 },
                -- Stock qb-ambulance hospital bed coords:
                --                { coords = vec3(353.1, -584.6, 43.11), heading = 152.08 },
                --                { coords = vec3(356.79, -585.86, 43.11), heading = 152.08 },
                --                { coords = vec3(354.12, -593.12, 43.1), heading = 336.32 },
                --                { coords = vec3(350.79, -591.8, 43.1), heading = 336.32 },
                --                { coords = vec3(346.99, -590.48, 43.1), heading = 336.32 },
                --                { coords = vec3(360.32, -587.19, 43.02), heading = 152.08 },
                --                { coords = vec3(349.82, -583.33, 43.02), heading = 152.08 },
                --                { coords = vec3(326.98, -576.17, 43.02), heading = 152.08 }
            }

        },
        Cloakroom = {
            Enabled = true,
            Coords = vector3(298.85, -598.26, 43.28), -- Coords of cloakroom
            Label = '[E] - Change Clothes',     -- String of text ui of cloakroom
            HotKey = 38,                        -- Default: 38 (E)
            Range = 1.5,                        -- Range away from coords you can use.
            Uniforms = {                        -- Uniform choices
            }
        },

        MedicalSupplies = {                                                     -- EMS Shop for supplies
            Enabled = true,                                                 -- If set to false, rest of this table do not matter
            Ped = 's_m_m_doctor_01',                                            -- Ped to target
            Coords = vec3(303.1, -595.94, 43.28 - 0.95),                       -- Coords of ped/target
            Heading = 160.09,                                                    -- Heading of ped
            Supplies = {                                                        -- Supplies
                { item = 'radio',    label = 'Radio', price = false },
                -- { item = 'bandage',    label = 'Bandage', price = false },
                -- { item = 'medbag',     label = 'Medical Bag',   price = false  }, -- Pretty self explanatory, price may be set to 'false' to make free
                -- { item = 'medikit',    label = 'First-Aid Kit', price = false },
                -- { item = 'defib',    label = 'Defib Kit', price = false },
                -- { item = 'burncream',    label = 'Burn Cream', price = false },
                -- { item = 'icepack',    label = 'Ice Pack', price = false },
                -- { item = 'suturekit',    label = 'Suture Kit', price = false },
                -- { item = 'tweezers',    label = 'Tweezers', price = false },
                -- { item = 'morphine30', label = 'Morphine 30MG', price = false },
                -- { item = 'morphine10', label = 'Morphine 10MG', price = false },
                -- { item = 'perc30',     label = 'Percocet 30MG', price = false },
                -- { item = 'perc10',     label = 'Percocet 10MG', price = false },
                -- { item = 'perc5',      label = 'Percocet 5MG',  price = false },
                -- { item = 'vic10',      label = 'Vicodin 10MG',  price = false },
                -- { item = 'vic5',       label = 'Vicodin 5MG',   price = false },
            }
        },

        Vehicles = {                                   -- Vehicle Garage
            Enabled = true,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            Zone = {
                coords = vector3(332.98, -576.79, 28.8), -- Area to prompt vehicle garage
                range = 2,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            Spawn = {
                land = {
                    coords = vector3(332.98, -576.79, 28.8),
                    heading = 341.48
                },
                air = {
                    coords = vec3(351.24, -587.67, 74.55),
                    heading = 289.29
                }
            },
            Options = {
                [0] = {
                },

                [1] = {
                    ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'E450 Ambulance',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Stretcher',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                },

                [2] = {
                    ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'E450 Ambulance',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['sprinter1'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Sprinter',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['sprinter2'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Sprinter 2',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                    ['amrheli'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'AMR Heli',
                        category = 'air', -- Options are 'land' and 'air'
                    },
                    ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
                        label = 'Stretcher',
                        category = 'land', -- Options are 'land' and 'air'
                    },
                }
            }
        },
    },
    -- PillboxLower = {
    --     RespawnPoint = { -- When player dies and bleeds out; they will revive at nearest hospital; Define the coords of this hospital here.
    --         coords = vector3(316.4, -581.84, 43.28),
    --         heading = 349.99,
    --         -- Even if you have useCheckInInstead to true, you must still define these coords for finding closest hospital
    --         -- If you want to use check-in instead of respawning at this location(Otherwise will just spawn at the coords above)
    --         useCheckInInstead = false
    --     },

    --     Blip = {
    --         Enabled = true,
    --         Coords = vec3(324.15, -583.14, 44.20),
    --         Sprite = 61,
    --         Color = 2,
    --         Scale = 1.0,
    --         String = 'Pillbox Hospital'
    --     },

    --     clockInAndOut = {
    --         enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for Config.ambulanceJob with same grades - example in main _install_first directory)
    --         coords = vec3(334.75, -580.24, 43.28), -- Location of where to go on and off duty(If not using target)
    --         label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
    --         distance = 3.0,                        -- Distance to display text UI(If not using target)
    --         target = {
    --             enabled = false,                   -- If enabled, the location and distance above will be obsolete
    --             label = 'Go On/Off Duty',
    --             coords = vec3(334.75, -580.24, 43.28),
    --             heading = 337.07,
    --             width = 2.0,
    --             length = 1.0,
    --             minZ = 43.28 - 0.9,
    --             maxZ = 43.28 + 0.9
    --         }
    --     },

    --     PersonalLocker = {
    --         enabled = true,                        -- Enable personal locker(stash) - THIS IS CURRENTLY ONLY AVALIABLE IN QB-INVENTORY
    --         coords = vector3(316.83, -600.81, 43.29),   -- Location of where to access personal locker (If target is disabled)
    --         label = '[E] - Access Personal Locker', -- Text to display(If not using target)
    --         distance = 1.5,                         -- Distance to display text UI(If not using target)
    --         target = {
    --             enabled = true,                    -- If enabled, the location and distance above will be obsolete
    --             label = 'Access Locker',
    --             coords = vec3(316.83, -600.81, 43.29),
    --             heading = 70.18,
    --             width = 2.0,
    --             length = 1.0,
    --             minZ = 43.28 - 0.9,
    --             maxZ = 43.28 + 0.9
    --         }
    --     },


    --     BossMenu = {
    --         Enabled = true,                        -- Enabled boss menu?
    --         Coords = vector3(305.02, -598.33, 43.29), -- Location of boss menu (If not using target)
    --         Label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
    --         Distance = 2.5,                        -- Distance to allow access/prompt with text UI (If not using target)
    --         Target = {
    --             enabled = false,                   -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
    --             label = 'Access Boss Menu',
    --             coords = vec3(335.59, -594.33, 43.21),
    --             heading = 269.85,
    --             width = 2.0,
    --             length = 1.0,
    --             minZ = 43.21 - 0.9,
    --             maxZ = 43.21 + 0.9
    --         }
    --     },
    --     CheckIn = {                                     -- Hospital check-in
    --         Enabled = true,                              -- Enable ped and check-in area?
    --         Ped = 's_m_m_scientist_01',                  -- Check in ped
    --         Coords = vector3(349.52, -587.79, 28.8 - 0.9), -- Coords of ped
    --         Distance = 4.85,                             -- Distance to show textUI (If target is not enabled below)
    --         Heading = 252,                             -- Heading of ped
    --         Cost = false,                                -- Cost of using hospital check-in. Set to false for free
    --         Duration = 15 * seconds,                     -- Time it takes to spend in hospital bed
    --         MaxOnDuty = 3,                               -- If this amount or less you can use, otherwise it will tell you that EMS is avaliable(Set to false to always enable check-in)
    --         PayAccount = 'bank',                         -- Account dead player pays from to check-in
    --         Label = '[E] - Check In',                    -- label of text UI if target is not enabled below
    --         HotKey = 38,                                 -- Default: 38 (E) (If target below is not enabled)
    --         Target = {
    --             enabled = true,                          -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
    --             label = 'Check In',
    --             coords = vec3(349.52, -587.79, 28.8),
    --             heading = 63.26,
    --             distance = 5.0,
    --             width = 2.0,
    --             length = 1.0,
    --             minZ = 43.28 - 0.9,
    --             maxZ = 43.28 + 0.9
    --         },
    --         DisableHospitalBeds = false,                                              -- Disable hospital beds for check-in at this location?(Player will spend Duration checking in before respawning in RespawnNoBedLocation when set to true)
    --         RespawnNoBedLocation = { coords = vector3(364.46, -580.75, 43.28), heading = 339.02 }, -- Coords and heading of where to spawn player if DisableHospitalBeds is set to true or beds are full
    --         HospitalBeds = {
    --             { coords = vector3(366.53, -581.63, 44.21 - 1.4), heading = 245.58 },
    --             { coords = vector3(359.52, -586.21, 44.2 - 1.4), heading = 249.86 },
    --             { coords = vector3(361.39, -581.33, 44.19 - 1.4), heading = 249.43 },
    --             { coords = vector3(354.44, -600.2, 44.22 - 1.4), heading = 249.95 },
    --         }

    --     },
    --     Cloakroom = {
    --         Enabled = false,
    --         Coords = vector3(298.85, -598.26, 43.28), -- Coords of cloakroom
    --         Label = '[E] - Change Clothes',     -- String of text ui of cloakroom
    --         HotKey = 38,                        -- Default: 38 (E)
    --         Range = 1.5,                        -- Range away from coords you can use.
    --         Uniforms = {                        -- Uniform choices
    --             [1] = {                         -- Order it will display
    --                 label = 'Medic',            -- Name of outfit that will display in menu
    --                 minGrade = 0,               -- Min grade level that can access? Set to 0 or false for everyone to use
    --                 male = {                    -- Male variation
    --                     clothing = {
    --                         -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
    --                         -- https://docs.fivem.net/natives/?_0xD4F7B05C
    --                         { component = 11, drawable = 15, texture = 0 }, -- Torso
    --                         { component = 8,  drawable = 58, texture = 0 }, -- Shirt
    --                         { component = 4,  drawable = 35, texture = 0 }, -- Pants
    --                         { component = 6,  drawable = 24, texture = 0 }, -- Shoes
    --                         { component = 3,  drawable = 15, texture = 0 }, -- Arms
    --                     },
    --                     props = {
    --                         -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
    --                         -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

    --                         --    { component = 0, drawable = 0, texture = 0 }, -- Hats
    --                     }
    --                 },
    --                 female = {
    --                     clothing = {
    --                         -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
    --                         -- https://docs.fivem.net/natives/?_0xD4F7B05C
    --                         { component = 11, drawable = 15, texture = 0 }, -- Torso
    --                         { component = 8,  drawable = 58, texture = 0 }, -- Shirt
    --                         { component = 4,  drawable = 35, texture = 0 }, -- Pants
    --                         { component = 6,  drawable = 24, texture = 0 }, -- Shoes
    --                         { component = 3,  drawable = 15, texture = 0 }, -- Arms
    --                     },
    --                     props = {
    --                         -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
    --                         -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

    --                         --    { component = 0, drawable = 0, texture = 0 }, -- Hats
    --                     }
    --                 }
    --             },
    --             [2] = {
    --                 label = 'Doctor',
    --                 minGrade = 1, -- Min grade level that can access? Set to 0 or false for everyone to use
    --                 male = {
    --                     clothing = {
    --                         -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
    --                         -- https://docs.fivem.net/natives/?_0xD4F7B05C
    --                         { component = 11, drawable = 15, texture = 0 }, -- Torso
    --                         { component = 8,  drawable = 58, texture = 0 }, -- Shirt
    --                         { component = 4,  drawable = 35, texture = 0 }, -- Pants
    --                         { component = 6,  drawable = 24, texture = 0 }, -- Shoes
    --                         { component = 3,  drawable = 15, texture = 0 }, -- Arms
    --                     },
    --                     props = {
    --                         -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
    --                         -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

    --                         --    { component = 0, drawable = 0, texture = 0 }, -- Hats
    --                     }
    --                 },
    --                 female = {
    --                     clothing = {
    --                         -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
    --                         -- https://docs.fivem.net/natives/?_0xD4F7B05C
    --                         { component = 11, drawable = 15, texture = 0 }, -- Torso
    --                         { component = 8,  drawable = 58, texture = 0 }, -- Shirt
    --                         { component = 4,  drawable = 35, texture = 0 }, -- Pants
    --                         { component = 6,  drawable = 24, texture = 0 }, -- Shoes
    --                         { component = 3,  drawable = 15, texture = 0 }, -- Arms
    --                     },
    --                     props = {
    --                         -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets
    --                         -- https://docs.fivem.net/natives/?_0x93376B65A266EB5F

    --                         --    { component = 0, drawable = 0, texture = 0 }, -- Hats
    --                     }
    --                 }
    --             },
    --         }
    --     },

    --     MedicalSupplies = {                                                     -- EMS Shop for supplies
    --         Enabled = false,                                                 -- If set to false, rest of this table do not matter
    --         Ped = 's_m_m_doctor_01',                                            -- Ped to target
    --         Coords = vec3(303.1, -595.94, 43.28 - 0.95),                       -- Coords of ped/target
    --         Heading = 160.09,                                                    -- Heading of ped
    --         Supplies = {                                                        -- Supplies
    --         }
    --     },

    --     Vehicles = {                                   -- Vehicle Garage
    --         Enabled = true,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
    --         Zone = {
    --             coords = vector3(332.98, -576.79, 28.8), -- Area to prompt vehicle garage
    --             range = 2,                           -- Range it will prompt from coords above
    --             label = '[E] - Access Garage',
    --             return_label = '[E] - Return Vehicle'
    --         },
    --         Spawn = {
    --             land = {
    --                 coords = vector3(332.98, -576.79, 28.8),
    --                 heading = 341.48
    --             },
    --             air = {
    --                 coords = vec3(351.24, -587.67, 74.55),
    --                 heading = 289.29
    --             }
    --         },
    --         Options = {
    --             [0] = {
    --             },

    --             [1] = {
    --                 ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'E450 Ambulance',
    --                     category = 'land', -- Options are 'land' and 'air'
    --                 },
    --                 ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'E450 Ambulance',
    --                     category = 'land', -- Options are 'land' and 'air'
    --                 },
    --             },

    --             [2] = {
    --                 ['e450ambo'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'E450 Ambulance',
    --                     category = 'land', -- Options are 'land' and 'air'
    --                 },
    --                 ['sprinter1'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'Sprinter',
    --                     category = 'land', -- Options are 'land' and 'air'
    --                 },
    --                 ['sprinter2'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'Sprinter 2',
    --                     category = 'land', -- Options are 'land' and 'air'
    --                 },
    --                 ['amrheli'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'AMR Heli',
    --                     category = 'air', -- Options are 'land' and 'air'
    --                 },
    --                 ['stretcher'] = {      -- Car/Helicopter/Vehicle Spawn Code/Model Name
    --                     label = 'Stretcher',
    --                     category = 'land', -- Options are 'land' and 'air'
    --                 },
    --             }
    --         }
    --     },
    -- },
    Sandy = {
        RespawnPoint = { -- When player dies and bleeds out; they will revive at nearest hospital; Define the coords of this hospital here.
            coords = vector3(1827.4, 3680.31, 34.28),
            heading = 332.22,
            -- Even if you have useCheckInInstead to true, you must still define these coords for finding closest hospital
            -- If you want to use check-in instead of respawning at this location(Otherwise will just spawn at the coords above)
            useCheckInInstead = true
        },

        Blip = {
            Enabled = true,
            Coords = vector3(1836.33, 3677.98, 34.28),
            Sprite = 61,
            Color = 2,
            Scale = 1.0,
            String = 'Pillbox Hospital'
        },

        clockInAndOut = {
            enabled = false,                       -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for Config.ambulanceJob with same grades - example in main _install_first directory)
            coords = vec3(334.75, -580.24, 43.28), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty',        -- Text to display(If not using target)
            distance = 3.0,                        -- Distance to display text UI(If not using target)
            target = {
                enabled = false,                   -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(334.75, -580.24, 43.28),
                heading = 337.07,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },

        PersonalLocker = {
            enabled = false,                        -- Enable personal locker(stash) - THIS IS CURRENTLY ONLY AVALIABLE IN QB-INVENTORY
            coords = vector3(316.83, -600.81, 43.29),   -- Location of where to access personal locker (If target is disabled)
            label = '[E] - Access Personal Locker', -- Text to display(If not using target)
            distance = 1.5,                         -- Distance to display text UI(If not using target)
            target = {
                enabled = true,                    -- If enabled, the location and distance above will be obsolete
                label = 'Access Locker',
                coords = vec3(316.83, -600.81, 43.29),
                heading = 70.18,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            }
        },


        BossMenu = {
            Enabled = false,                        -- Enabled boss menu?
            Coords = vector3(305.02, -598.33, 43.29), -- Location of boss menu (If not using target)
            Label = '[E] - Access Boss Menu',      -- Text UI label string (If not using target)
            Distance = 2.5,                        -- Distance to allow access/prompt with text UI (If not using target)
            Target = {
                enabled = false,                   -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Access Boss Menu',
                coords = vec3(335.59, -594.33, 43.21),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 43.21 - 0.9,
                maxZ = 43.21 + 0.9
            }
        },

        CheckIn = {                                     -- Hospital check-in
            Enabled = true,     
            Ped = 's_m_m_scientist_01',                  -- Check in ped
            Coords = vector3(1832.29, 3677.18, 34.28 - 1), -- Coords of ped
            Distance = 4.85,                             -- Distance to show textUI (If target is not enabled below)
            Heading = 307.52,                             -- Heading of ped
            Cost = false,                                -- Cost of using hospital check-in. Set to false for free
            Duration = 15 * seconds,                     -- Time it takes to spend in hospital bed
            MaxOnDuty = false,                               -- If this amount or less you can use, otherwise it will tell you that EMS is avaliable(Set to false to always enable check-in)
            PayAccount = 'bank',                         -- Account dead player pays from to check-in
            Label = '[E] - Check In',                    -- label of text UI if target is not enabled below
            HotKey = 38,                                 -- Default: 38 (E) (If target below is not enabled)
            Target = {
                enabled = true,                          -- Enable Target? (Can be customized in wasabi_bridge/customize/cl_customize.lua the target system)
                label = 'Check In',
                coords = vector3(1832.29, 3677.18, 34.28),
                heading = 63.26,
                distance = 5.0,
                width = 2.0,
                length = 1.0,
                minZ = 43.28 - 0.9,
                maxZ = 43.28 + 0.9
            },
            DisableHospitalBeds = false,                                              -- Disable hospital beds for check-in at this location?(Player will spend Duration checking in before respawning in RespawnNoBedLocation when set to true)
            RespawnNoBedLocation = { coords = vec3(316.66, -581.3, 43.28), heading = 339.02 }, -- Coords and heading of where to spawn player if DisableHospitalBeds is set to true or beds are full
            HospitalBeds = {
                { coords = vector3(1828.11, 3683.1, 35.18 - 0.8), heading = 28.68 },
                { coords = vector3(1825.04, 3681.34, 35.18 - 0.8), heading = 155.63 },
                -- { coords = vec3(319.41, -581.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(314.47, -584.2, 42.84 + 0.3),  heading = 160.0 },
                -- { coords = vec3(313.93, -579.04, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(311.06, -582.96, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(307.72, -581.75, 42.84 + 0.3), heading = 160.0 },
                -- { coords = vec3(309.35, -577.38, 42.84 + 0.3), heading = 340.0 },
                -- { coords = vec3(361.36, -581.3, 42.83 + 0.3),  heading = 250.0 },
                -- { coords = vec3(359.54, -586.23, 42.84 + 0.3), heading = 250.0 },
                -- { coords = vec3(354.44, -600.19, 42.85 + 0.3), heading = 250.0 },
                -- { coords = vec3(324.26, -582.8, 42.84 + 0.3),  heading = 340.0 },
                -- Stock qb-ambulance hospital bed coords:
                --                { coords = vec3(353.1, -584.6, 43.11), heading = 152.08 },
                --                { coords = vec3(356.79, -585.86, 43.11), heading = 152.08 },
                --                { coords = vec3(354.12, -593.12, 43.1), heading = 336.32 },
                --                { coords = vec3(350.79, -591.8, 43.1), heading = 336.32 },
                --                { coords = vec3(346.99, -590.48, 43.1), heading = 336.32 },
                --                { coords = vec3(360.32, -587.19, 43.02), heading = 152.08 },
                --                { coords = vec3(349.82, -583.33, 43.02), heading = 152.08 },
                --                { coords = vec3(326.98, -576.17, 43.02), heading = 152.08 }
            }

        },
        Cloakroom = {
            Enabled = false,
            Coords = vector3(314.21, -603.25, 43.29), -- Coords of cloakroom
            Label = '[E] - Change Clothes',     -- String of text ui of cloakroom
            HotKey = 38,                        -- Default: 38 (E)
            Range = 1.5,                        -- Range away from coords you can use.
            Uniforms = {
            }
        },

        MedicalSupplies = {                                                     -- EMS Shop for supplies
            Enabled = false,                                                     -- If set to false, rest of this table do not matter
            Ped = 's_m_m_doctor_01',                                            -- Ped to target
            Coords = vec3(316.09, -605.27, 43.29 - 0.95),                       -- Coords of ped/target
            Heading = 23.09,                                                    -- Heading of ped
            Supplies = {
            }
        },

        Vehicles = {                                   -- Vehicle Garage
            Enabled = false,                            -- Enable? False if you have you're own way for medics to obtain vehicles.
            Zone = {
                coords = vector3(325.01, -570.3, 28.88), -- Area to prompt vehicle garage
                range = 2,                           -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            Spawn = {
                land = {
                    coords = vector3(325.84, -566.89, 28.81),
                    heading = 68.43
                },
                air = {
                    coords = vec3(351.24, -587.67, 74.55),
                    heading = 289.29
                }
            },
            Options = {
            }
        },
    },
}

--[[ IMPORTANT THIS COULD BREAK SOMETHING ]]
-- Config.DisableDeathAnimation = false -- Really, really, REALLY do not recommend setting this to true and it was added per reques