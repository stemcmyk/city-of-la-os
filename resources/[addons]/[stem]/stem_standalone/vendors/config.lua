Config_vendors = {}

Config_vendors.vendors = {
    {
        id = "pawnshop",
        name = "Pawn Shop",
        icon = "fa-solid fa-gem",
        model = `a_m_m_hasjew_01`,
        coords = vector4(1697.77, 3784.33, 34.71 - 1, 213.4),
        items = {
            {
                itemName = "ring",
                type = "sell",
                price = 500,
            },
            {
                itemName = "gold",
                type = "sell",
                price = 150
            },
            {
                itemName = "emerald",
                type = "sell",
                price = 250
            },
            {
                itemName = "diamond",
                type = "sell",
                price = 350
            }
        },
        blip = {
            sprite = 500,
            color = 13,
            scale = 0.8,
        }
    },
    {
        id = "scrapyard",
        name = "Scrap Yard",
        icon = "fa-solid fa-recycle",
        model = `s_m_m_ccrew_01`,
        coords = vector4(2340.88, 3126.44, 48.21 - 1, 353.35),
        items = {
            {
                itemName = "scrap_metal",
                type = "sell",
                price = 25,
            },
            {
                itemName = "raw_copper",
                type = "sell",
                price = 35,
            },
            {
                itemName = "licenseplate",
                type = "sell",
                price = 200,
            },
            {
                itemName = "stone",
                type = "sell",
                price = 10
            },
            {
                itemName = "silver",
                type = "sell",
                price = 70
            },
            {
                itemName = "steel",
                type = "sell",
                price = 80
            },
            {
                itemName = "iron",
                type = "sell",
                price = 60
            },
            {
                itemName = "copper",
                type = "sell",
                price = 30
            }
        },
        blip = {
            sprite = 467,
            color = 21,
            scale = 0.6,
        }
    },
    {
        id = "mamasgrocery",
        name = "Mama's Grocery",
        icon = "fa-solid fa-cubes-stacked",
        model = `cs_guadalope`,
        coords = vector4(388.29, -731.76, 29.29 - 1, 178.81),
        items = {
            {
                itemName = "coffee_beans",
                groups = { "beanmachine" },
                type = "buy",
                price = 400,
            },
            {
                itemName = "milk",
                groups = { "beanmachine" },
                type = "buy",
                price = 100,
            },
            {
                itemName = "syrup",
                groups = { "beanmachine" },
                type = "buy",
                price = 300,
            },
            {
                itemName = "caramel_syrup",
                groups = { "beanmachine" },
                type = "buy",
                price = 350,
            },
            {
                itemName = "food_oil",
                groups = { "beanmachine" },
                type = "buy",
                price = 150,
            },
            {
                itemName = "blended_fruits",
                groups = { "beanmachine"},
                type = "buy",
                price = 200
            },
            {
                itemName = "impotentrage",
                groups = { "burgershot"},
                type = "buy",
                price = 100
            },
            {
                itemName = "rimjob",
                groups = { "burgershot"},
                type = "buy",
                price = 150
            },
            {
                itemName = "creampie",
                groups = { "burgershot"},
                type = "buy",
                price = 50
            },
            {
                itemName = "orangotang_icecream",
                groups = { "burgershot"},
                type = "buy",
                price = 50
            },
            {
                itemName = "meteorite_icecream",
                groups = { "burgershot"},
                type = "buy",
                price = 50
            },
            {
                itemName = "meat",
                groups = { "burgershot", "upnatom" },
                type = "buy",
                price = 150
            },
            {
                itemName = "rawdog",
                groups = { "upnatom" },
                type = "buy",
                price = 100
            },
            {
                itemName = "bun",
                groups = { "burgershot", "upnatom"},
                type = "buy",
                price = 100
            },
            {
                itemName = "potatoe",
                groups = { "burgershot", "upnatom"},
                type = "buy",
                price = 120
            },
            {
                itemName = "atomic_cake",
                groups = {  "upnatom"},
                type = "buy",
                price = 300
            },
            {
                itemName = "atomic_peach_dessert",
                groups = { "upnatom"},
                type = "buy",
                price = 400
            },
            {
                itemName = "raw_meat",
                type = "sell",
                price = 20
            },
        },
        blip = {
            sprite = 78,
            color = 1,
            scale = 0.7,
        }
    },
    {
        id = "fishmarket",
        name = "Fishing Market",
        icon = "fa-solid fa-fish",
        model = `s_m_m_linecook`,
        coords = vector4(-1845.12, -1195.52, 19.18 - 1, 149.12),
        items = {
            {
                itemName = "pike", 
                price = 12 * 6,
                type = "sell",
            },
            
            {
                itemName = "bream", 
                price = 8 * 6,
                type = "sell",
            },
            {
                itemName = "pike_berch", 
                price = 20 * 6,
                type = "sell",
            },
            {
                itemName = "salmon", 
                price = 19 * 6,
                type = "sell",
            },
            {
                itemName = "trout", 
                price = 17 * 6,
                type = "sell",
            },
            {
                itemName = "herring", 
                price = 10 * 6,
                type = "sell",
            },
            {
                itemName = "cod", 
                price = 7 * 6,
                type = "sell",
            },
            {
                itemName = "tuna", 
                price = 14 * 6,
                type = "sell",
            },
            {
                itemName = "rod", 
                price = 350,
                type = "buy",
            },
        },
        blip = {
            sprite = 356,
            color = 83,
            scale = 0.7,
        }
    },
    {
        id = "huntingmarket",
        name = "Hunting Market",
        icon = "fa-solid fa-fish",
        model = `s_m_m_linecook`,
        coords = vector4(-675.2, 5834.5, 17.33 - 1, 49.82),
        items = {
            {
                itemName = "skin_deer_ruined",
                price = 150,
                type = "sell",
            },
            {
                itemName = "skin_deer_low",
                price = 350,
                type = "sell",
            },
            {
                itemName = "skin_deer_medium",
                price = 550,
                type = "sell",
            },
            {
                itemName = "skin_deer_good",
                price = 900,
                type = "sell",
            },
            {
                itemName = "skin_deer_perfect",
                price = 1500,
                type = "sell",
            },
            {
                itemName = "leather_boar_bad",
                price = 400,
                type = "sell",
            },
            {
                itemName = "leather_boar_good",
                price = 700,
                type = "sell",
            },
            {
                itemName = "leather_boar_perfect",
                price = 1200,
                type = "sell",
            },
            {
                itemName = "leather_coyote_bad",
                price = 250,
                type = "sell",
            },
            {
                itemName = "leather_coyote_good",
                price = 500,
                type = "sell",
            },
            {
                itemName = "leather_coyote_perfect",
                price = 950,
                type = "sell",
            },
        },
        blip = {
            sprite = 586,
            color = 83,
            scale = 0.7,
        }
    },
}