MySQL.ready(function ( ) 
    Citizen.CreateThread(function () 
    
        
        local upnatom = Business:new({
            bossGrade = "owner",
            label = "Up'n'Atom",
            name = "upnatom",
            blip = {
                Color = 6,
                Sprite = 76,
                Name = "Up'n'Atom",
                Size = 0.9
            },
            coords = vector3(84.28, 284.97, 110.23)
        })
        upnatom:createRegister({
            coords = vector3(91.99, 284.48, 110.7)
        })
        upnatom:createRegister({
            coords = vector3(89.68, 285.22, 110.7)
        })
        upnatom:addBossMenu(vector3(94.26, 284.63, 110.92 - 1))
        
        local fryOptions = {
            {
                title = "Fry Fries",
                icon = "fa-solid fa-temperature-high",
                progressLabel = "Frying Fries",
                inputItems = {
                    { name = "potatoe", amount = 1 },
                },
                outputItems = {
                    { name = "atomic_fries", amount = 2 },
                }
            },
            {
                title = "Fry Tater Tots",
                icon = "fa-solid fa-temperature-high",
                progressLabel = "Frying Tater Tots",
                inputItems = {
                    { name = "potatoe", amount = 1 },
                },
                outputItems = {
                    { name = "atomic_tots", amount = 2 },
                }
            }
        }

        upnatom:createProcess("fry:1", {
            coords = vector3(88.25, 292.05, 110.1),
            standCoords = vector4(89.01, 291.79, 110.23 - 1, 68.98),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = fryOptions
        })

        upnatom:createProcess("fry:2", {
            coords = vector3(87.91, 291.23, 110.1),
            standCoords = vector4(88.71, 290.97, 110.23 - 1, 77.67),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = fryOptions
        })
        
        local cookOptions = {
            {
                title = "Cook Meat",
                icon = "fa-solid fa-fire-burner",
                progressLabel = "Cooking Meat",
                inputItems = {
                    { name = "meat", amount = 1 },
                },
                outputItems = {
                    { name = "cookedmeat", amount = 2 },
                }
            },
            {
                title = "Cook Hot Dog",
                icon = "fa-solid fa-fire-burner",
                progressLabel = "Cooking Hot Dog",
                inputItems = {
                    { name = "rawdog", amount = 1 },
                },
                outputItems = {
                    { name = "cookedhotdog", amount = 1 },
                }
            }
        }

        upnatom:createProcess("cook:1", {
            coords = vector3(88.65, 293.35, 110.3),
            standCoords = vector4(89.36, 293.13, 110.23 - 1, 63.88),
            radius = 0.3,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = cookOptions
        })

        upnatom:createProcess("cook:2", {
            coords = vector3(88.94, 294.19, 110.3),
            standCoords = vector4(89.64, 293.91, 110.23 - 1, 70.11),
            radius = 0.3,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = cookOptions
        })

        local pourOptions = {
            {
                title = "Pour Fountain Drink: Sprunk",
                icon = "fa-solid fa-mug-hot",
                progressLabel = "Pouring Fountain Drink_ Sprunk",
                inputItems = {},
                outputItems = {
                    { name = "fountain_sprunk", amount = 1 },
                }
            },
            {
                title = "Pour Fountain Drink: ECola",
                icon = "fa-solid fa-mug-hot",
                progressLabel = "Pouring Fountain Drink: ECola",
                inputItems = {},
                outputItems = {
                    { name = "fountain_ecola", amount = 1 },
                }
            },
            {
                title = "Pour Fountain Drink: Water",
                icon = "fa-solid fa-mug-hot",
                progressLabel = "Pouring Fountain Drink: Water",
                inputItems = {},
                outputItems = {
                    { name = "fountain_water", amount = 1 },
                }
            },
            {
                title = "Pour Jumbo Shake",
                icon = "fa-solid fa-mug-hot",
                progressLabel = "Pouring Jumbo Shake",
                inputItems = {},
                outputItems = {
                    { name = "jumboshake", amount = 1 },
                }
            }
        }

        upnatom:createProcess("pour:1", {
            coords = vector3(97.23, 293.54, 110.2),
            standCoords = vector4(96.5, 293.74, 110.23 - 1, 260.56),
            radius = 0.6,
            anim = {
                clip = "inspecting_high_idle_01_inspector",
                dict = "anim_heist@arcade_combined@"
            },
            options = pourOptions
        })
        
        upnatom:createInventory({
            coords = vector3(90.7, 288.78, 109.89 + 0.4),
            radius = 0.7,
            id = "quick:1",
            name = "Quick Food Storage",
            icon = "fa-solid fa-box-open",
            size = 5000,
            slots = 25
        })
        upnatom:createInventory({
            coords = vector3(90.03, 290.46, 109.89 + 0.4),
            radius = 1.2,
            id = "refridgerator",
            name = "Refridgerator",
            icon = "fa-solid fa-box-open",
            size = 120000,
            slots = 25
        })

        
        local packOption = {
            {
                title = "Make Triple Melt",
                icon = "fa-solid fa-burger",
                progressLabel = "Making Triple Melt",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 2 },
                },
                outputItems = {
                    { name = "triplemelt", amount = 1 },
                }
            },
            {
                title = "Make Triple Burger",
                icon = "fa-solid fa-burger",
                progressLabel = "Making Triple Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 3 },
                },
                outputItems = {
                    { name = "tripleburger", amount = 1 },
                }
            },
            {
                title = "Make Chili Dog",
                icon = "fa-solid fa-hotdog",
                progressLabel = "Making Chili Dog",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedhotdog", amount = 1 },
                },
                outputItems = {
                    { name = "chilidog", amount = 1 },
                }
            },
            {
                title = "Make Atomic Burger",
                icon = "fa-solid fa-atom",
                progressLabel = "Making Atomic Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 1 },
                },
                outputItems = {
                    { name = "atomic_burger", amount = 1 },
                }
            },
        }
        

        upnatom:createProcess("pack:1", {
            coords = vector3(96.58, 292.1, 110.0),
            standCoords = vector4(95.89, 292.35, 110.23 - 1, 249.18),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BUM_BIN"
            }, 
            options = packOption
        })
        

        local burgerProp = "prop_cs_burger_01"
        local burgerAnim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}}
        
        local foodItems = {
            ["triplemelt"] = {type = "food", amount = 300000, prop = burgerProp, anim = burgerAnim},
            ["tripleburger"] = {type = "food", amount = 400000, prop = burgerProp, anim = burgerAnim},
            ["chilidog"] = {type = "food", amount = 500000, prop = burgerProp, anim = burgerAnim},
            ["atomic_burger"] = {type = "food", amount = 600000, prop = burgerProp, anim = burgerAnim},

            ["atomic_cake"] = {type = "food", amount = 100000,  anim = burgerAnim},
            ["atomic_peach_dessert"] = {type = "food", amount = 100000,  anim = burgerAnim},
        }

        for key, value in pairs(foodItems) do
            ESX.RegisterUsableItem(key, function(source)
                local xPlayer = ESX.GetPlayerFromId(source)
                xPlayer.removeInventoryItem(key,1)
                local label = ESX.GetItemLabel(key)

                if value.type == "food" then
                    TriggerClientEvent("esx_status:add", xPlayer.source, "hunger", value.amount)
                    TriggerClientEvent('esx_basicneeds:onUse', xPlayer.source, value.type, value.prop, value.anim)
                    xPlayer.showNotification(("You ate a **%s**"): format(label))
                elseif value.type == "drink" then
                    TriggerClientEvent("esx_status:add", xPlayer.source, "thirst", value.amount)
                    TriggerClientEvent('esx_basicneeds:onUse', xPlayer.source, value.type, value.prop, value.anim)
                    xPlayer.showNotification(("You drank a **%s**"): format(label))
                else
                    print(string.format('^1[ERROR]^0 %s has no correct type defined.', k))
                end
            end)
        end
    end)
end)