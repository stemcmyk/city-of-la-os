Config = {}

Config.MiningData = {
    itemName = "pickaxe",
    hits = 1
}

Config.RockModels = {
   [`prop_rock_2_a`] = true,
   [`prop_rock_2_c`] = true,
   [`prop_rock_2_d`] = true,
   [`prop_rock_2_f`] = true,
   [`prop_rock_2_g`] = true
}

Config.SmeltingOptions = {
    scrap_metal = {
        label = 'Scrap Metal',
        refineable = false,
        sellable = true,
        duration = nil,
    },
    stone = {
        label = 'Stone',
        refineable = false,
        sellable = true,
        duration = nil,
    },
    raw_copper = {
        label = 'Raw Copper',
        refineable = true,
        sellable = true,
        duration = 1000,
        output = "copper"
    },
    raw_iron = {
        label = 'Raw Iron',
        refineable = true,
        sellable = true,
        duration = 2000,
        output = "iron"
    },
    raw_steel = {
        label = 'Raw Steel',
        refineable = true,
        sellable = true,
        duration = 2000,
        output = "steel"
    },
    raw_silver = {
        label = 'Raw Silver',
        refineable = true,
        sellable = true,
        duration = 3000,
        output = "silver"
    },
    raw_gold = {
        label = 'Raw Gold',
        refineable = true,
        sellable = true,
        duration = 3000,
        output = "gold"
    },
}

Config.Smelting = {
    coords = vec3(1086.3845, -2003.6810, 30.9738),
    title = "Open Refinery",
    icon = "fa-solid fa-fire-burner",
    input = {
        refineTitle = 'Choose Material',
        refineSelectMaterial = 'Raw Material',
        refineSelectMaterialDesc = 'What do you want to refine?',
        refineSelectMaterialIcon = 'recycle',
        refineSelectQuantity = 'Quantity',
        refineSelectQuantityDesc = 'How many do you want to refine?',
        refineSelectQuantityIcon = 'hashtag',
    }
}

Config.MiningZones = {
    {coords = vector3(2950.73, 2792.25, 40.93), radius = 50, variant = "low", blipTitle = "Mining Zone"},
    {coords = vector3(-598.35, 2093.1, 131.59), radius = 15, variant = "high", blipTitle = "Mining Zone"},
}

Config.MiningVariants = {
    ["low"] = {
        { chance = 100, items = {
            "scrap_metal", 
            "stone", 
            "raw_copper"
        }},
        { chance = 50, items = {
            "raw_iron",
            "raw_steel",
            "raw_silver"
        }},
        { chance = 20, items = {
            "raw_silver",
        }},
        { chance = 5, items = {
            "raw_gold",  
        }}, 
        { chance = 1, items = {
            "diamond", 
            "emerald", 
        }}
    },
    ["high"] = {
        { chance = 100, items = {
            "scrap_metal", 
            "stone", 
            "raw_copper"
        }},
        { chance = 70, items = {
            "raw_iron",
            "raw_steel",
            "raw_silver"
        }},
        { chance = 50, items = {
            "raw_silver",
        }},
        { chance = 10, items = {
            "raw_gold",  
        }}, 
        { chance = 5, items = {
            "diamond", 
            "emerald", 
        }}
    }
}