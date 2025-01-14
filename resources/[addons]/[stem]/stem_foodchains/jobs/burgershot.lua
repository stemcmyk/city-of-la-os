MySQL.ready(function ( ) 
    Citizen.CreateThread(function () 
    
        
        local burgerShot = Business:new({
            bossGrade = "owner",
            label = "Burgershot",
            name = "burgershot",
            blip = {
                Color = 6,
                Sprite = 106,
                Name = "Burgershot",
                Size = 0.9
            },
            coords = vector3(-1191.61, -889.69, 14.0)
        })
        burgerShot:createRegister({
            coords = vector3(-1193.44, -895.24, 13.3 + 0.9)
        })
        burgerShot:createRegister({
            coords = vector3(-1194.69, -893.32, 13.26 + 0.9)
        })
        burgerShot:createRegister({
            coords = vector3(-1195.96, -891.3, 13.23 + 0.95)
        })
        burgerShot:addBossMenu(vector3(-1191.65, -897.22, 15.16 - 1))
        
        local fryOptions = {
            {
                title = "Fry Fries",
                icon = "fa-solid fa-temperature-high",
                progressLabel = "Frying Fries",
                inputItems = {
                    { name = "potatoe", amount = 1 },
                },
                outputItems = {
                    { name = "bshot_fries", amount = 2 },
                }
            }
        }

        burgerShot:createProcess("fry:1", {
            coords = vector3(-1201.2, -899.79, 13.80),
            standCoords = vector4(-1200.73, -899.42, 14.0 - 1, 122.72),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = fryOptions
        })

        burgerShot:createProcess("fry:2", {
            coords = vector3(-1201.65, -899.09, 13.80),
            standCoords = vector4(-1201.19, -898.72, 14.0 - 1, 122.51),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = fryOptions
        })
        
        burgerShot:createProcess("fry:3", {
            coords = vector3(-1202.11, -898.38, 13.47 + 0.3),
            standCoords = vector4(-1201.55, -898.01, 14.0 - 1, 123.85),
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
            }
        }

        burgerShot:createProcess("cook:1", {
            coords = vector3(-1200.35, -901.29, 14.10),
            standCoords = vector4(-1199.72, -900.88, 14.0 - 1, 120.38),
            radius = 0.3,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = cookOptions
        })

        burgerShot:createProcess("cook:2", {
            coords = vector3(-1200.72, -900.68, 14.10),
            standCoords = vector4(-1200.14, -900.27, 14.0 - 1, 122.63),
            radius = 0.3,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = cookOptions
        })
        
        burgerShot:createProcess("cook:3", {
            coords = vector3(-1202.71, -897.58, 14.10),
            standCoords = vector4(-1202.15, -897.29, 14.0 - 1, 128.25),
            radius = 0.3,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = cookOptions
        })

        burgerShot:createProcess("cook:4", {
            coords = vector3(-1203.14, -896.96, 14.10),
            standCoords = vector4(-1202.58, -896.65, 14.0 - 1, 122.51),
            radius = 0.3,
            anim = {
                scenario = "PROP_HUMAN_BBQ"
            }, 
            options = cookOptions
        })


        local pourOptions = {
            {
                title = "Pour Burgershot Soda",
                icon = "fa-solid fa-mug-hot",
                progressLabel = "Pouring Burgershot Soda",
                inputItems = {},
                outputItems = {
                    { name = "bshot_soda", amount = 1 },
                }
            }
        }

        burgerShot:createProcess("pour:1", {
            coords = vector3(-1199.29, -895.97, 14.09 + 0.3),
            standCoords = vector4(-1198.59, -895.68, 14.0 - 1, 123.12),
            radius = 0.6,
            anim = {
                clip = "inspecting_high_idle_01_inspector",
                dict = "anim_heist@arcade_combined@"
            },
            options = pourOptions
        })

        burgerShot:createProcess("pour:2", {
            coords = vector3(-1200.0, -895.16, 14.09 + 0.3),
            standCoords = vector4(-1199.22, -894.76, 14.0 - 1, 121.07),
            radius = 0.6,
            anim = {
                clip = "inspecting_high_idle_01_inspector",
                dict = "anim_heist@arcade_combined@"
            },
            options = pourOptions
        })

        
        burgerShot:createInventory({
            coords = vector3(-1196.92, -895.69, 13.49 + 0.4),
            radius = 0.7,
            id = "quick:1",
            name = "Quick Food Storage",
            icon = "fa-solid fa-box-open",
            size = 5000,
            slots = 25
        })
        burgerShot:createInventory({
            coords = vector3(-1197.76, -894.32, 13.5 + 0.4),
            radius = 0.7,
            id = "quick:2",
            name = "Quick Food Storage",
            icon = "fa-solid fa-box-open",
            size = 5000,
            slots = 25
        })
        burgerShot:createInventory({
            coords = vector3(-1198.49, -893.04, 13.48 + 0.4),
            radius = 0.7,
            id = "quick:3",
            name = "Quick Food Storage",
            icon = "fa-solid fa-box-open",
            size = 5000,
            slots = 25
        })
        burgerShot:createInventory({
            coords = vector3(-1205.23, -893.81, 13.7),
            radius = 1.2,
            id = "refridgerator",
            name = "Refridgerator",
            icon = "fa-solid fa-box-open",
            size = 120000,
            slots = 25
        })

        local mealOptions = {
            {
                title = "Make Moneyshot Meal",
                icon = "fa-solid fa-utensils",
                progressLabel = "Making Moneyshot Meal",
                inputItems = {
                    { name = "moneyshot", amount = 1 },
                    { name = "bshot_fries", amount = 1 },
                    { name = "bshot_soda", amount = 1 },
                },
                outputItems = {
                    { name = "meal1", amount = 1 },
                }
            },
            {
                title = "Make Bleeder Meal",
                icon = "fa-solid fa-utensils",
                progressLabel = "Making Bleeder Meal",
                inputItems = {
                    { name = "bleeder", amount = 1 },
                    { name = "bshot_fries", amount = 1 },
                    { name = "bshot_soda", amount = 1 },
                },
                outputItems = {
                    { name = "meal2", amount = 1 },
                }
            },
            {
                title = "Make Heartstopper Meal",
                icon = "fa-solid fa-utensils",
                progressLabel = "Making Heartstopper Meal",
                inputItems = {
                    { name = "heartstopper", amount = 1 },
                    { name = "bshot_fries", amount = 1 },
                    { name = "bshot_soda", amount = 1 },
                },
                outputItems = {
                    { name = "meal3", amount = 1 },
                }
            },
            {
                title = "Make Torpedo Meal",
                icon = "fa-solid fa-utensils",
                progressLabel = "Making Torpedo Meal",
                inputItems = {
                    { name = "torpedo", amount = 1 },
                    { name = "bshot_fries", amount = 1 },
                    { name = "bshot_soda", amount = 1 },
                },
                outputItems = {
                    { name = "meal4", amount = 1 },
                }
            },
        }
        
        local burgerOptions = {
            {
                title = "Make Moneyshot",
                icon = "fa-solid fa-money-bill-1",
                progressLabel = "Makin Moneyshot",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 1 },
                },
                outputItems = {
                    { name = "moneyshot", amount = 1 },
                }
            },
            {
                title = "Make Bleeder",
                icon = "fa-solid fa-droplet",
                progressLabel = "Making Bleeder",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 2 },
                },
                outputItems = {
                    { name = "bleeder", amount = 1 },
                }
            },
            {
                title = "Make Heartstopper",
                icon = "fa-solid fa-heart",
                progressLabel = "Making Heartstopper",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 3 },
                },
                outputItems = {
                    { name = "heartstopper", amount = 1 },
                }
            },
            {
                title = "Make Torpedo",
                icon = "fa-solid fa-burger",
                progressLabel = "Making Torpedo",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 4 },
                },
                outputItems = {
                    { name = "torpedo", amount = 1 },
                }
            },
            {
                title = "Make Double Shot Burger",
                icon = "fa-solid fa-angles-down",
                progressLabel = "Making Double Shot Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 2 },
                },
                outputItems = {
                    { name = "bshot_double_shot_burger", amount = 1 },
                }
            },
            {
                title = "Make 6lb Burger",
                icon = "fa-solid fa-wheelchair-move",
                progressLabel = "Making 6lb Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 6 },
                },
                outputItems = {
                    { name = "bshot_6lb_burger", amount = 1 },
                }
            },
            {
                title = "Make Glorious Burger",
                icon = "fa-solid fa-burger",
                progressLabel = "Making Glorious Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 3 },
                },
                outputItems = {
                    { name = "bshot_glorious_burger", amount = 1 },
                }
            },
            {
                title = "Make Simply Burger",
                icon = "fa-solid fa-burger",
                progressLabel = "Making Simply Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 1 },
                },
                outputItems = {
                    { name = "bshot_simply_burger", amount = 1 },
                }
            },
            {
                title = "Make Prickly Burger",
                icon = "fa-solid fa-burger",
                progressLabel = "Making Prickly Burger",
                inputItems = {
                    { name = "bun", amount = 1 },
                    { name = "cookedmeat", amount = 1 },
                },
                outputItems = {
                    { name = "bshot_prickly_burger", amount = 1 },
                }
            },
        }
        
        local packOption = exports.stem_common:tableMerge(burgerOptions, mealOptions)

        burgerShot:createProcess("pack:1", {
            coords = vector3(-1198.02, -897.64, 14.10),
            standCoords = vector4(-1197.71, -897.4, 14.0 - 1, 125.99),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BUM_BIN"
            }, 
            options = packOption
        })
        
        burgerShot:createProcess("pack:2", {
            coords = vector3(-1199.11, -898.39, 14.10),
            standCoords = vector4(-1199.46, -898.65, 14.0 - 1, 305.54),
            radius = 0.5,
            anim = {
                scenario = "PROP_HUMAN_BUM_BIN"
            }, 
            options = packOption
        })

        local convertItems = {
            ["meal1"] = {
                "moneyshot",
                "bshot_fries",
                "bshot_soda",
            },
            ["meal2"] = {
                "bleeder",
                "bshot_fries",
                "bshot_soda",
            },
            ["meal3"] = {
                "heartstopper",
                "bshot_fries",
                "bshot_soda",
            },
            ["meal4"] = {
                "torpedo",
                "bshot_fries",
                "bshot_soda",
            },
        }

        for key, value in pairs(convertItems) do
            ESX.RegisterUsableItem(key, function (source) 
                local player = ESX.GetPlayerFromId(source)
                if (player.hasItem(key).count > 0) then
                    player.removeInventoryItem(key, 1)
                    for index, value in ipairs(value) do
                        player.addInventoryItem(value, 1)
                    end
                end
            end)
        end

        local burgerProp = "prop_cs_burger_01"
        local burgerAnim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}}
        
        local foodItems = {
            ["moneyshot"] = {type = "food", amount = 300000, prop = burgerProp, anim = burgerAnim},
            ["bleeder"] = {type = "food", amount = 400000, prop = burgerProp, anim = burgerAnim},
            ["heartstopper"] = {type = "food", amount = 500000, prop = burgerProp, anim = burgerAnim},
            ["torpedo"] = {type = "food", amount = 600000, prop = burgerProp, anim = burgerAnim},
            ["bshot_double_shot_burger"] = {type = "food", amount = 400000, prop = burgerProp, anim = burgerAnim},
            ["bshot_6lb_burger"] = {type = "food", amount = 900000, prop = burgerProp, anim = burgerAnim},
            ["bshot_glorious_burger"] = {type = "food", amount = 500000, prop = burgerProp, anim = burgerAnim},
            ["bshot_simply_burger"] = {type = "food", amount = 300000, prop = burgerProp, anim = burgerAnim},
            ["bshot_prickly_burger"] = {type = "food", amount = 300000, prop = burgerProp, anim = burgerAnim},
            ["bshot_fries"] = {type = "food", amount = 125000, prop = "prop_food_chips", anim = burgerAnim},

            ["creampie"] = {type = "food", amount = 100000,  anim = burgerAnim},
            ["rimjob"] = {type = "food", prop = "prop_donut_02", amount = 100000,  anim = burgerAnim},
            ["meteorite_icecream"] = {type = "food", amount = 100000,  anim = burgerAnim},
            ["orangotang_icecream"] = {type = "food", amount = 100000, anim = burgerAnim},
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