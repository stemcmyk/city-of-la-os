local kmh = 3.6
local mph = 2.236936
local DEBUG = false
---------------------------------------------------------------------------------------------------------------------------------------------------------------

Config = {}

Config.debug = false --- Enable debugging messages

Config.ghostedEntitiesAlpha = 100

Config.afkDropMessage = "You got kicked from the server for: AFK in safe zone." --- Message sent when player is disconnected because AFK
Config.afkNotifyTimes = {2, 3, 6, 10}

---Function triggered when the player holds a weapon and he must be disarmed
Config.disarmPlayer = function()
    -- Uncomment the system you want to use. If you use the ox inventory uncomment the event, otherwise uncomment the GTA default system.

    TriggerEvent("ox_inventory:disarm", true) -- ox_inventory
    SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true) -- default system
end

---Zones types
Config.Types = {
    ['hospital'] = {
        logJoinAndExit = true,

        player = {
            areaNotify = true,
            disableShoot = true,
            disableWeapons = true,
            disableIdleCam = true,
            makeInvincible = true,
        },

        ped = {
            newEntitiesRefreshRate = 250,
            makeInvincible = true,
            disableEvents = true,
        },

        disableJobs = {
            "lspd", "sahp", "lscso", "amr", "doj"   
        }
    },
    ['gunstore'] = {
        logJoinAndExit = true,

        player = {
            areaNotify = true,
            disableShoot = true,
            disableWeapons = true,
            disableIdleCam = true,
            makeInvincible = true,
        },

        ped = {
            newEntitiesRefreshRate = 250,
            makeInvincible = true,
            disableEvents = true,
        },
        
        disableJobs = {
            "lspd", "sahp", "lscso", "amr", "doj"   
        }
    },
    ['lscustoms'] = {
        logJoinAndExit = true,

        player = {
            areaNotify = true,
            disableShoot = true,
            disableWeapons = true,
            disableIdleCam = true,
            makeInvincible = true,
        },

        ped = {
            newEntitiesRefreshRate = 250,
            makeInvincible = true,
            disableEvents = true,
        },
    }
}


---Locations of the zones
Config.Zones = {
    ['Pillbox'] = {
        type = "hospital",
        debug = DEBUG,

        blip = {
            label = "Safe zone",
            display = 4,
            id = 461,
            color = 2,
            scale = 0,
            radius = true,
            radiusColor = 2,
            radiusAlpha = 125
        },

        sphere = {
            coords = vector3(321.24, -595.53, 43.28),
            radius = 75.0,
        }
    },
    ['Sandy'] = {
        type = "hospital",
        debug = DEBUG,

        blip = {
            label = "Safe zone",
            display = 4,
            id = 461,
            color = 2,
            scale = 0,
            radius = true,
            radiusColor = 2,
            radiusAlpha = 125
        },

        sphere = {
            coords = vector3(1836.42, 3678.4, 34.28),
            radius = 50.0,
        }
    },
    ['Paleto'] = {
        type = "hospital",
        debug = DEBUG,

        blip = {
            label = "Safe zone",
            display = 4,
            id = 461,
            color = 2,
            scale = 0,
            radius = true,
            radiusColor = 2,
            radiusAlpha = 125
        },

        sphere = {
            coords = vector3(-251.79, 6324.18, 33.48),
            radius = 50.0,
        }
    },
    ['Zonah'] = {
        type = "hospital",
        debug = DEBUG,

        blip = {
            label = "Safe zone",
            display = 4,
            id = 461,
            color = 2,
            scale = 0,
            radius = true,
            radiusColor = 2,
            radiusAlpha = 125
        },

        sphere = {
            coords = vector3(-442.99, -322.24, 34.91),
            radius = 50.0,
        }
    },
}

local gunStores = {
    vec3(-662.180, -934.961, 21.829),
    vec3(810.25, -2157.60, 29.62),
    vec3(1693.44, 3760.16, 34.71),
    vec3(252.63, -50.00, 69.94),
    vec3(23.68, -1106.46, 29.91),
    vec3(2567.69, 294.38, 108.73),
    vec3(-1117.58, 2698.61, 18.55),
    vec3(842.44, -1033.42, 28.19),
    vec3(-330.24, 6083.88, 31.45),
}

for key, value in pairs(gunStores) do
    Config.Zones["GunStore-" .. key] = {
        type = "gunstore",
        debug = DEBUG,

        blip = {
            label = "Safe zone",
            display = 4,
            id = 461,
            color = 2,
            scale = 0,
            radius = true,
            radiusColor = 2,
            radiusAlpha = 125
        },

        sphere = {
            coords = value,
            radius = 22.5,
        }
    }
end

local lscustoms = {
    vec3(-337.3863, -136.9247, 38.5737),
    vec3(-1155.536, -2007.183, 12.744),
    vec3(731.8163, -1088.822,  21.733),
    vec3(1175.04, 2640.216, 37.32177),
    vec3(110.8406, 6626.568,  31.787),
    vec3(-1326.3679199219,  -2428.171875, 13.945176124573),
    vec3(3716.2805175781, 5669.7690429688, 7.4187960624695),
}

for key, value in pairs(lscustoms) do
    Config.Zones["LSCustoms-" .. key] = {
        type = "lscustoms",
        debug = DEBUG,

        blip = {
            label = "Safe zone",
            display = 4,
            id = 461,
            color = 17,
            scale = 0,
            radius = true,
            radiusColor = 17,
            radiusAlpha = 125
        },

        sphere = {
            coords = value,
            radius = 25.0,
        }
    }
end