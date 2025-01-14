Config_armory = {}

Config_armory.jobs = {["lspd"] = 0, ["sahp"] = 0, ["lscso"] = 0}
Config_armory.locations = {
    vector3(452.92, -980.03, 30.54 + 0.3),
    vector3(364.91, -1599.26, 24.82),
    vector3(1549.6, 838.08, 77.03 + 0.7),
}

Config_armory.armory = {
    { name = 'ammo-stungun', price = 0, },
    { name = 'ammo-9', price = 0, nonPD = true },
    { name = 'ammo-45', price = 0, nonPD = true },
    { name = 'ammo-rifle', price = 0, nonPD = true  },
    { name = 'ammo-shotgun', price = 0, nonPD = true  },
    { name = 'WEAPON_FLASHLIGHT', price = 0, nonPD = true  },
    { name = 'WEAPON_NIGHTSTICK', price = 0 },
    { name = 'WEAPON_G17', price = 0, metadata = { registered = true, serial = 'POL' } },
    { name = 'WEAPON_USP', price = 0, metadata = { registered = true, serial = 'POL' } },
    { name = 'WEAPON_CARBINERIFLE', price = 0, metadata = { registered = true, serial = 'POL' } },
    { name = 'WEAPON_COMBATSHOTGUN', price = 0, metadata = { registered = true, serial = 'POL' } },
    { name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} },
    { name = 'WEAPON_PROLASER4', price = 0, metadata = { registered = true, serial = 'POL'}, grade = 1 },
    { name = 'mm_g17_flash1', price = 0, grade = 0},
    { name = 'mm_g17_slide8', price = 0, grade = 0},
    { name = 'at_flashlight', price = 0, grade = 0},
    { name = 'WEAPON_MP5', price = 0, metadata = { registered = true, serial = 'POL' }, civ = true, grade = 4 },

    { name = 'mm_g17_flash1', price = 0, grade = 1},
    { name = 'at_scope_macro', price = 0, grade = 1},
    { name = 'at_suppressor_light', price = 0, grade = 1},
    { name = 'WEAPON_FLARE', price = 0 },
    -- { name = 'cone', price = 0 },
    -- { name = 'spikestrip', price = 0 },
    { name = 'radio', price = 0, nonPD = true },
    { name = 'armor2', price = 0, metadata = { serial = "POL" }},
    -- { name = 'binoculars', price = 0 },
    -- { name = 'gsr_test_kit', price = 0 },
    { name = 'ammo-sniper', price = 0, grade = 11  },
    { name = 'WEAPON_HEAVYSNIPER', price = 0, metadata = { registered = true, serial = 'POL' }, grade = 11 },
}