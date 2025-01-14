Config = {}

Config.usedCarLots = {
    ["paleto"] = {
        zone = {
            vector3(67.02, 6414.79, 31.37),
            vector3(109.75, 6375.33, 31.27),
            vector3(68.11, 6355.75, 31.23),
            vector3(56.32, 6342.82, 31.23),
            vector3(-11.57, 6303.66, 31.38),
            vector3(-25.13, 6322.31, 31.38),
            vector3(66.71, 6415.26, 31.39)
        }
    },
    ["sandy"] = {
        zone = {
            vector3(1208.78, 2694.25, 37.82),
            vector3(1209.15, 2726.61, 38.0),
            vector3(1237.55, 2726.01, 38.0),
            vector3(1251.28, 2720.66, 38.0),
            vector3(1251.57, 2695.55, 37.99)
        }
    }
}

Config.stores = {
    {
        id = "pdm",
        label = "Premium Deluxe Motorsport",
        type = "car",
        previewLocation = vector4(-45.63, -1097.8, 26.42 - 1, 249.04),
        disabledVehicleGenerationArea = {
            vector3(-51.42, -1088.62, 26.42), vector3(-35.34, -1108.53, 26.42)
        },
        testLocation = vec4(-75.94, -1100.14, 26.19, 164.26),
        purchasePoint = vec3(-31.18, -1089.21, 26.02),
        conciere = {
            location = vec4(-55.83, -1097.77, 25.44, 4.3),
            model = "a_f_y_femaleagent",
            animation = {
                name = "base_amanda", 
                dict = "timetable@reunited@ig_10"
            },
        },
    }, 
    {
        id = "boatshop",
        label = "Boat Shop",
        type = "boat",
        previewLocation = vector4(-819.46, -1446.14, -0.16, 349.69),
        testLocation = vector4(-819.46, -1446.14, -0.16, 349.69),
        purchasePoint =  vector4(-819.46, -1446.14, -0.16, 349.69),
        blip = {
            sprite = 427,
        },
        conciere = {
            location = vector4(-801.2, -1341.65, 5.15 - 1, 349.66),
            model = "a_f_y_femaleagent",
            animation = {
                name = "idle_a",
                dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a"
            }
        }
    }
}

Config.shop = {
    ["car"] = {
        {
            type = "category",
            label = "Supporter",
            id = "supporter",
            color = "#fff",
            icon = "fa-solid fa-hand-holding-dollar",
            items = {
                {
                    type = "category",
                    label = "Emerald",
                    id = "emerald",
                    icon = "fa-solid fa-gem",
                    color = "#00ffaa"
                },
                {
                    type = "category",
                    label = "Diamond",
                    id = "diamond",
                    icon = "fa-regular fa-gem",
                    color = "#1aa3ff",
                },
                {
                    type = "category",
                    label = "Gold",
                    id = "gold",
                    icon = "fa-solid fa-ring",
                    color = "#fff200"
                },
                {
                    type = "category",
                    label = "Silver",
                    id = "silver",
                    color = "#a1acb8"
                },
                {
                    type = "category",
                    label = "Bronze",
                    id = "bronze",
                    color = "#382706"
                },
            }
        },
        {
            type = "category",
            label = "Luxury",
            id = "luxury",
            icon = "fa-solid fa-dollar-sign",
            items = {
                {
                    type = "category",
                    label = "Rolls Royce",
                    id = "rr",
                    items = {
                        { label = "Rolls Royce Wraith", price = 300000, model = "wraith" }
                    }
                },
                {
                    type = "category",
                    label = "Maserati",
                    id = "maserati",
                    items = {
                        {
                            label = "Maserati Grand Turismo",
                            model = "mqgts",
                            price = 110000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Bentley",
                    id = "bentley",
                    items = {
                        {
                            label = "Bentley Continental 2017",
                            model = "ben17",
                            supporter = "silver",
                            price = 250000
                        },
                        {
                            label = "Bentley Bentayga Hybrid",
                            model = "bigjozza_hybrid",
                            price = 230000
                        },
                    }
                },
            }
        },
        {
            type = "category",
            label = "Muscle",
            id = "Muscle",
            items = {
                {
                    type = "category",
                    label = "Dodge",
                    id = "dodge",
                    items = {
                        { label = "Dodge Challenger Hellcat WB", price = 125000, model = "ch21", supporter = "gold" },
                        { label = "Dodge Challenger Redeye", price = 275000, model = "redeye" },
                        { label = "1969 Dodge Charger", price = 75000, model = "69charger", supporter = "silver" },
                        { label = "2015 Dodge Charger Hellcat", price = 255000, model = "hellcat15", supporter = "gold" },
                        { label = "2012 Dodge Charger", price = 35000, model = "12charger" },
                        { label = "2015 Dodge Charger Hellcat", price = 255000, model = "hellcat15", supporter = "gold" }
                    }
                },
                {
                    type = "category",
                    label = "Ford",
                    id = "ford",
                    items = {
                        {
                            label = "Ford Mustang GT5",
                            model = "smgt5",
                            price = 70000
                        },
                    }
                },
            }
        },
        {
            type = "category",
            label = "Sports",
            id = "sports",
            icon = "a-solid fa-gauge",
            items = {
                {
                    type = "category",
                    label = "Audi",
                    id = "audi",
                    items = {
                        {
                            label = "Audi R8 2020",
                            model = "r820",
                            supporter = "silver",
                            price = 220000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Lotus",
                    id = "lotus",
                    items = {
                        {
                            label = "Lotus Evija",
                            model = "evija",
                            supporter = "gold",
                            price = 250000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Chevrolet",
                    id = "chevrolet",
                    items = {
                        {
                            label = "2016 Camaro",
                            model = "ss16",
                            supporter = "silver",
                            price = 60000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Acura",
                    id = "Acura",
                    items = {
                        {
                            label = "Acura NSX",
                            model = "aimgainnsx",
                            supporter = "silver",
                            price = 155000
                        },
                        {
                            label = "Acura Legend Hellcat Swap",
                            model = "kklegend",
                            price = 175000
                        }
                    }
                },
                {
                    type = "category",
                    label = "Subaru",
                    id = "subaru",
                    items = {
                        {
                            label = "Subaru Impreza",
                            model = "sultanrs2",
                            price = 50000
                        },
                        {
                            label = "2019 Subaru WRX",
                            model = "wrx19",
                            price = 125000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Cadillac",
                    id = "cadillac",
                    items = {
                        {
                            label = "Drag CTS-V",
                            model = "kev",
                            price = 185000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Lexus",
                    id = "lexus",
                    items = {
                        {
                            label = "2010 Lexus LFA",
                            model = "lfa",
                            price = 215000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Mazda",
                    id = "mazda",
                    items = {
                        {
                            label = "Mazda RX7",
                            model = "fd3s",
                            price = 75000
                        },
                        {
                            label = "Mazda RX7 F&F",
                            model = "rx7v",
                            price = 105000
                        }
                    }
                },
                {
                    type = "category",
                    label = "Porsche",
                    id = "porsche",
                    items = {
                        {
                            label = "Porsche Turbo S",
                            model = "turs21",
                            price = 170000
                        },
                        {
                            label = "Porsche GT3",
                            model = "pgt322",
                            supporter = "gold",
                            price = 290000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Mitsubishi",
                    id = "mitsubishi",
                    items = {
                        {
                            label = "Mitsubishi Lancer Evolution X",
                            model = "esnevox",
                            price = 50000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Honda",
                    id = "honda",
                    items = {
                        {
                            label = "Honda Civic Type-R 2018",
                            model = "fk8",
                            price = 60000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Toyota",
                    id = "toyota",
                    items = {
                        {
                            label = "Toyota GT-86",
                            model = "gt86",
                            price = 30000
                        },
                        {
                            label = "1998 Toyota Supra",
                            model = "a80",
                            price = 330000
                        },
                        {
                            label = "2019 Toyota Supra GR",
                            model = "supra19",
                            price = 75000
                        }
                    }
                },
                {
                    type = "category",
                    label = "Nissan",
                    id = "nissan",
                    items = {
                        {
                            label = "Nissan GTR R35 WB",
                            model = "gtrpit",
                            price = 250000,
                            supporter = "diamond"
                        },
                        {
                            label = "2024 Nissan Nismo",
                            model = "nznismo",
                            price = 150000,
                            supporter = "silver"
                        },
                        {
                            label = "Nissan R34 Skyline",
                            model = "skyline",
                            price = 125000,
                        },
                    }
                },
                {
                    type = "category",
                    label = "BMW",
                    id = "bmw",
                    items = {
                        {
                            label = "BMW M3 G80",
                            model = "m3g80",
                            price = 180000
                        },
                        {
                            label = "BMW E34",
                            model = "bmwe34",
                            price = 40000
                        },
                        {
                            label = "BMW M5 E60 ",
                            model = "m5e60",
                            price = 70000
                        },
                        {
                            label = "BMW M5 F90 ",
                            model = "m5f90",
                            supporter = "gold",
                            price = 120000
                        },
                        {
                            label = "BMW M5 E39 ",
                            model = "bmwe39",
                            supporter = "silver",
                            price = 60000
                        },
                        {
                            label = "BMW I8 2015",
                            model = "i8",
                            price = 160000
                        },
                        {
                            label = "BMW M8 Coup",
                            model = "bmwm8",
                            supporter = "gold",
                            price = 120000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Mercedes",
                    id = "mercedes",
                    items = {
                        {
                            label = "2015 AMG GTR",
                            model = "amggtr",
                            supporter = "gold",
                            price = 190000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Corvette",
                    id = "corvette",
                    items = {
                        {
                            label = "Xeigen Widebody C8 Daytona",
                            model = "c8daytona",
                            price = 145000
                        },
                        {
                            label = "Corvette ZR1 Demon Swap",
                            model = "corvettezr1",
                            price = 350000
                        },
                        {
                            label = "Corvette Stingray Widebody",
                            model = "stingraywb",
                            price = 175000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Lexus",
                    id = "lexus",
                    items = {
                        {
                            label = "Lexus LFA",
                            model = "lfa",
                            price = 190000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Tesla",
                    id = "tesla",
                    items = {
                        {
                            label = "Tesla Roadster 2020",
                            model = "tr22",
                            supporter = "silver",
                            price = 260000
                        },
                    }
                },
            }
        },
        {
            type = "category",
            label = "SUVs",
            id = "suvs",
            items = {
                {
                    type = "category",
                    label = "Mercedes",
                    id = "mercedes",
                    items = {
                        {
                            label = "G63",
                            model = "g632019",
                            price = 150000
                        },
                        {
                            label = "G65 AMG",
                            model = "g65amg",
                            supporter = "gold",
                            price = 130000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Range Rover",
                    id = "range rover",
                    items = {
                        {
                            label = "Range Rover Evoque",
                            model = "evoque",
                            price = 40000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Toyota",
                    id = "toyota",
                    items = {
                        {
                            label = "Toyota Fortuner",
                            model = "fortuner",
                            price = 30000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Lexus",
                    id = "lexus",
                    items = {
                        {
                            label = "Lexus SC300",
                            model = "gcfreesc300",
                            price = 37000
                        },
                        {
                            label = "Lexus LX600",
                            model = "moolx600",
                            price = 40000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Dodge",
                    id = "dodge",
                    items = {
                        {
                            label = "2018 Dodge Durango SRT",
                            model = "durango",
                            price = 115000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Ford",
                    id = "ford",
                    items = {
                        {
                            label = "2021 Ford Bronco",
                            model = "broncog",
                            price = 65000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Lamborghini",
                    id = "lamborghini",
                    items = {
                        {
                            label = "Lamborghini Urus",
                            model = "urusperf23",
                            price = 210000
                        },
                    }
                },
    
            }
        },
        {
            type = "category",
            label = "Sedans",
            id = "sedans",
            items = {
                {
                    type = "category",
                    label = "Volvo",
                    id = "volvo",
                    items = {
                        {
                            label = "Volvo 850r",
                            model = "volvo850r",
                            price = 35000
                        },
                        {
                            label = "Volvo 142",
                            model = "volvo142",
                            price = 15000
                        },
                        {
                            label = "Volvo 145",
                            model = "volvo145",
                            price = 20000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Fiat",
                    id = "fiat",
                    items = {
                        {label = "Fiat 500", model = "fiat500", price = 8000 }
                    }
                },
                {
                    type = "category",
                    label = "Tesla",
                    id = "tesla",
                    items = {
                        {label = "Tesla Prior Design", model = "teslapd", price = 78000 }
                    }
                },
                {
                    type = "category",
                    label = "Mini Cooper",
                    id = "mini cooper",
                    items = {
                        {label = "Mini Cooper", model = "mr53", price = 18000 }
                    }
                },
                {
                    type = "category",
                    label = "Toyota",
                    id = "toyota",
                    items = {
                        {
                            label = "Toyota Camry",
                            model = "cmr11",
                            price = 15000
                        }
                    }
                },
                {
                    type = "category",
                    label = "Dodge",
                    id = "dodge",
                    items = {
                        {
                            label = "Dode Charger 2016",
                            model = "16charger",
                            price = 120000
                        }
                    }
                },
                {
                    type = "category",
                    label = "Chrysler",
                    id = "chrysler",
                    items = {
                        {label = "Chrysler 300 SRT", model = "300srt8", price = 30000 }
                    }
                },
                {
                    type = "category",
                    label = "Ford",
                    id = "ford",
                    items = {
                        {label = "Ford Fiesta", model = "fiestarb", price = 45000 },
                        {label = "Ford Crown Vic", model = "vic11", price = 15000 }
                    }
                },
                {
                    type = "category",
                    label = "Audi",
                    id = "audi",
                    items = {
                        {
                            label = "Audi RS6",
                            model = "rs615",
                            price = 150000
                        },
                        {
                            label = "Audi RS7 Sportback (C8) 2020",
                            model = "rs7c8",
                            supporter = "silver",
                            price = 190000 
                        }, 
                        {
                            label = "Audi RSQ8M", 
                            model = "rsq8m", 
                            price = 110000 
                        }
                    }
                },
                {
                    type = "category",
                    label = "Mercedes",
                    id = "mercedes",
                    items = {
                        {
                            label = "Mercedes Benz S W223 B50",
                            model = "w223b50",
                            supporter = "gold",
                            price = 190000
                        },
                        {
                            label = "Mercedes-AMG E63 S 4Matic+ 2018",
                            model = "e63s",
                            supporter = "gold",
                            price = 140000
                        },
                        {
                            label = "Mercedes-Benz AMG GT63 2018",
                            model = "amggt63",
                            price = 230000
                        },
                        {
                            label = "Mercedes-Benz E55 AMG",
                            model = "benze55",
                            price = 120000
                        },
                    }
                },
            }
        },
        {
           type = "category",
           label = "Super",
           id = "super",
           icon = "fa-solid fa-gauge-high",
           items = {
                {
                    type = "category",
                    label = "Mclaren",
                    id = "mclaren",
                    items = {
                        {
                            label = "Mclaren 675 LT",
                            model = "675lt",
                            price = 360000
                        },
                        {
                            label = "Mclaren 765 LT",
                            model = "765lt",
                            supporter = "silver",
                            price = 420000
                        },
                        {
                            label = "Mclaren 720 S",
                            model = "720s",
                            supporter = "gold",
                            price = 540000
                        },
                    }
                },
                {
                    type = "category",
                    label = "Lamborghini",
                    id = "lamborghini",
                    items = {
                        {
                            label = "Lamborghini Huracan",
                            model = "tecnicatdb",
                            price = 300000
                        },
                        {
                            label = "Lamborghini Essenza",
                            model = "essenzatdb",
                            price = 650000
                        },
                    }
                },
                {
                    label = "Bugatti Chiron 17",
                    model = "chiron17",
                    supporter = "diamond",
                    price = 540000
                },
                {
                    label = "Bugatti Bolide",
                    model = "bolide",
                    supporter = "diamond",
                    price = 1000000
                },
                {
                    label = "Ferrari SF90",
                    model = "sf90s",
                    price = 420000
                },
            }
        },
        {
            type = "category",
            label = "Trucks",
            id = "truck",
            icon = "fa-solid fa-gauge-high",
            items = {
                {
                    type = "category",
                    label = "Dodge",
                    id = "dodge",
                    items = {
                        {
                            label = "Dodge Ram Dually",
                            model = "2ndgendually",
                            price = 25000
                        },
                        {
                            label = "Dodge Ram SRT10",
                            model = "03ramk",
                            price = 35000
                        },
                        {
                            label = "Dodge Ram TRX",
                            model = "trx",
                            price = 75000
                        }
                    }
                },
                {
                    type = "category",
                    label = "Ford",
                    id = "ford",
                    items = {
                        {
                            label = "2019 Ford Raptor",
                            model = "19raptor",
                            price = 55000
                        }
                    }
                },
                {
                    type = "category",
                    label = "GMC",
                    id = "gmc",
                    items = {
                        {
                                label = "GMC Sierra",
                                model = "gmcat4",
                                price = 35000
                        }
                    }
                }
            }
        },
        {
           type = "category",
           label = "Bikes",
           id = "bikes",
           icon = "fa-solid fa-motorcycle",
           items = {
                {
                    label = "Kawasaki Ninja ZX10R KRT",
                    model = "10r24nbrt",
                    supporter = "gold",
                    price = 75000
                },
                {
                    label = "Kawasaki Ninja H2",
                    model = "ninjah2",
                    price = 50000
                },
                {
                    label = "KTM RC 390 2021",
                    model = "390b21",
                    supporter = "gold",
                    price = 55000
                },
                {
                    label = "Yamaha R1",
                    model = "r1",
                    price = 45000
                },
                {
                    label = "Kawasaki Ninja H2",
                    model = "ninjah2",
                    price = 50000
                }
            }
        },
    },
    ["boat"] = {
        {
            type = "category",
            label = "Speedboats",
            id = "speedboats",
            icon = "fa-solid fa-anchor",
            items = {
                
                {
                    label = "Dinghy",
                    model = "dinghy",
                    price = 75000
                },
                {
                    label = "Jetmax",
                    model = "jetmax",
                    price = 100000
                },
                {
                    label = "Marquis",
                    model = "marquis",
                    price = 50000
                },
                {
                    label = "Patrol Boat",
                    model = "patrolboat",
                    price = 50000
                }
            }
        }
    }
}

