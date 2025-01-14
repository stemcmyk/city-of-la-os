MySQL.ready(function ( ) 
    Citizen.CreateThread(function () 

        
        local beanMachine = Business:new({
            bossGrade = "owner",
            label = "Bean Machine",
            name = "beanmachine",
            blip = {
                Color = 5,
                Sprite = 106,
                Name = "Bean Machine",
                Size = 0.9
            },
            coords = vector3(-625.78, 232.82, 81.88)
        })
        beanMachine:createRegister({
            coords = vector3(-634.40, 235.19, 82.13)
        })
        beanMachine:addBossMenu(vector3(-630.61, 228.62, 83.07 - 1))

        beanMachine:createProcess("grind", {
            coords = vector3(-636.06, 236.39, 82.3),
            standCoords = vector4(-636.0, 236.01, 81.89, 18.59),
            size = 0.2,
            anim = {
                clip = "inspecting_high_idle_01_inspector",
                dict = "anim_heist@arcade_combined@"
            }, 
            options = {
                {
                    title = "Grind Coffee",
                    icon = "fa-solid fa-mortar-pestle",
                    progressLabel = "Grinding Coffee",
                    inputItems = {
                        { name = "coffee_beans", amount = 1 },
                    },
                    outputItems = {
                        { name = "coffee_grounds", amount = 16 },
                    }
                }
            },
        })

        beanMachine:createProcess("brew", {
            coords = vector3(-635.56, 236.47, 82.3),
            standCoords = vector4(-635.53, 236.0, 81.88, 357.18),
            size = 0.4,
            anim = {
                clip = "inspecting_high_idle_01_inspector",
                dict = "anim_heist@arcade_combined@"
            },
            options = {
                {
                    title = "Brew High Noon",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing High Noon",
                    inputItems = {
                        { name = "coffee_grounds", amount = 6 },
                        { name = "milk", amount = 0.20 },
                        { name = "syrup", amount = 0.10 },
                    },
                    outputItems = {
                        { name = "highnoon", amount = 1 },
                    }
                },
                {
                    title = "Brew Speedball",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Speedball",
                    inputItems = {
                        { name = "coffee_grounds", amount = 3 },
                        { name = "syrup", amount = 0.10 },
                        { name = "caramel_syrup", amount = 0.20 },
                    },
                    outputItems = {
                        { name = "speedball", amount = 1 },
                    }
                },
                {
                    title = "Brew Gunkacchino",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Gunkacchino",
                    inputItems = {
                        { name = "coffee_grounds", amount = 2 },
                        { name = "milk", amount = 0.05 },
                        { name = "syrup", amount = 0.05 },
                        { name = "caramel_syrup", amount = 0.10 },
                    },
                    outputItems = {
                        { name = "gunkacchino", amount = 1 },
                    }
                },
                {
                    title = "Brew Bratte",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Bratte",
                    inputItems = {
                        { name = "coffee_grounds", amount = 2 },
                        { name = "syrup", amount = 0.10 },
                        { name = "caramel_syrup", amount = 0.10 },
                    },
                    outputItems = {
                        { name = "bratte", amount = 1 },
                    }
                },
                {
                    title = "Brew Flusher",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Flusher",
                    inputItems = {
                        { name = "coffee_grounds", amount = 2 },
                        { name = "caramel_syrup", amount = 0.20 },
                        { name = "food_oil", amount = 0.10 },
                    },
                    outputItems = {
                        { name = "flusher", amount = 1 },
                    }
                },
                {
                    title = "Brew Big Caffeagra",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Caffeagra",
                    inputItems = {
                        { name = "coffee_grounds", amount = 6 },
                        { name = "caramel_syrup", amount = 0.10 },
                        { name = "food_oil", amount = 0.05 },
                        { name = "milk", amount = 0.05 },
                    },
                    outputItems = {
                        { name = "caffeagra", amount = 1 },
                    }
                },
                {
                    title = "Brew Big Fruit",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Big Fruit",
                    inputItems = {
                        { name = "coffee_grounds", amount = 1 },
                        { name = "caramel_syrup", amount = 0.10 },
                        { name = "food_oil", amount = 0.05 },
                        { name = "blended_fruits", amount = 0.20 },
                    },
                    outputItems = {
                        { name = "bigfruit", amount = 1 },
                    }
                },
                {
                    title = "Brew Mr. Beany",
                    icon = "fa-solid fa-mug-hot",
                    progressLabel = "Brewing Mr. Beany",
                    inputItems = {
                        { name = "coffee_grounds", amount = 4 },
                        { name = "caramel_syrup", amount = 0.05 },
                        { name = "syrup", amount = 0.05 },
                        { name = "milk", amount = 0.10 },
                    },
                    outputItems = {
                        { name = "beany", amount = 1 },
                    }
                },
            },
        })

        beanMachine:createInventory({
            coords = vector3(-635.6, 233.0, 81.78),
            id = "refrigerator",
            name = "Bean Machine Refridgerator",
            icon = "fa-solid fa-box-open",
            size = 100000,
            slots = 50
        })
    end)
end)