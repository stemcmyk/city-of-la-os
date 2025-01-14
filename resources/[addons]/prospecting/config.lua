-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

Config = {}

Config.Core = "ESX" -- ESX or QBCore
Config.PlayerLoadedEvent = "esx:playerLoaded" -- esx:playerLoaded || QBCore:Client:OnPlayerLoaded

Config.ShowBlip = true -- show blip on map

Config.Chances = {
    ["common"] = 100, -- 100%
    ["uncommon"] = 40, -- 100%
    ["rare"] = 20, -- 15%
    ["epic"] = 10, -- 5%
    ["legendary"] = 5, -- 5%
}
Config.ShowDrawMaker = true -- show draw marker on in game while prospecting
Config.DetectorItem = "detector"

Config.Zones = {
    [1] = {coords = vector3(1434.54, 1414.45, 105.73), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [2] = {coords = vector3(1615.378, 2095.902, 85.007), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [3] = {coords = vector3(-9.76, 2506.95, 92.83), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [4] = {coords =vector3(-2255.09, 2416.64, 7.74), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [5] = {coords = vector3(277.43, 4399.65, 47.79), data = "loc1", zoneSize = 100, zoneLocations = 20},
    
    [6] = {coords =vector3(2564.18, 1134.39, 58.32), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [7] = {coords = vector3(3537.67, 4659.98, 39.75), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [8] = {coords =vector3(-924.49, 5499.54, 8.32), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [9] = {coords = vector3(92.62, 6926.41, 20.01), data = "loc1", zoneSize = 100, zoneLocations = 20},
    [10] = {coords =vector3(610.85, 3066.11, 42.51), data = "loc1", zoneSize = 100, zoneLocations = 20},
}

Config.DefaultItems = {
    [1] = {name = "raw_copper", min = 5, max = 10},
} -- will be selected if you dont put the common, rare and epic items in the config

Config.Items = {
    ["loc1"] = {
        ["common"] = {
            [1] = {name = "raw_copper", min = 5, max = 10},
            [2] = {name = "scrap_metal", min = 5, max = 10},
        },
        ["uncommon"] = {
            [1] = {name = "licenseplate", min = 1, max = 3},
        },
        ["rare"] = {
            [1] = {name = "phone", min = 1, max = 1},
            [2] = {name = "ring", min = 1, max = 1},
        },
        ["epic"] = {
            [1] = {name = "WEAPON_DOUBLEACTION", min = 1, max = 1},
            [2] = {name = "gold", min = 5, max = 9},
        },
        ["legendary"] = {
            [1] = {name = "WEAPON_MUSKET", min = 1, max = 1},
        }
    },
}
