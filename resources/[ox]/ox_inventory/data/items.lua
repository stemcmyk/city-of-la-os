local burger

return {
	
	["leather_boar_bad"] = {
		label = "Bad boar leather",
		weight = 1000,
		stack = true,
		close = true,
	},

	["leather_boar_good"] = {
		label = "Good boar leather",
		weight = 1000,
		stack = true,
		close = true,
	},

	["leather_boar_perfect"] = {
		label = "Perfect boar leather",
		weight = 1000,
		stack = true,
		close = true,
	},


	["leather_coyote_bad"] = {
		label = "Bad coyote leather",
		weight = 1000,
		stack = true,
		close = true,
	},

	["leather_coyote_good"] = {
		label = "Good coyote leather",
		weight = 1000,
		stack = true,
		close = true,
	},

	["leather_coyote_perfect"] = {
		label = "Perfect coyote leather",
		weight = 1000,
		stack = true,
		close = true,
	},
	
	['animal_tracker'] = {
		label = 'Animal Tracker',
		weight = 200,
		allowArmed = true,
		stack = false,
	},
	['campfire'] = {
		label = 'Campfire',
		weight = 200,
		allowArmed = true,
		stack = false,
	},
	
	['huntingbait'] = {
		label = 'Hunting Bait',
		weight = 100,
		allowArmed = true,
	},
	
	['cooked_meat'] = {
		label = 'Cooked Meat',
		weight = 200,
	},
	['raw_meat'] = {
		label = 'Raw Meat',
		weight = 200,
	},
	
	['skin_deer_ruined'] = {
		label = 'Tattered Deer Pelt',
		weight = 200,
		stack = false,
	},
	['skin_deer_low'] = {
		label = 'Worn Deer Pelt',
		weight = 200,
	},
	['skin_deer_medium'] = {
		label = 'Supple Deer Pelt',
		weight = 200,
	},
	['skin_deer_good'] = {
		label = 'Prime Deer Pelt',
		weight = 200,
	},
	['skin_deer_perfect'] = {
		label = 'Flawless Deer Pelt',
		weight = 200,
	},
	
	['deer_horn'] = {
		label = 'Deer Horn',
		weight = 1000,
	},
	

	["cookedhotdog"] = {
		label = "Cooked Hot Dog",
		weight = 200,
		stack = true,
		close = true,
	},


	["tripleburger"] = {
		label = "Triple Burger",
		weight = 350,
		stack = true,
		close = true,
	},

	["triplemelt"] = {
		label = "Bacon Cheese Triple Melt",
		weight = 250,
		stack = true,
		close = true,
	},

	["rawdog"] = {
		label = "Raw Hot Dog",
		weight = 200,
		stack = true,
		close = true,
	},
	["chilidog"] = {
		label = "Chili Hot Dog",
		weight = 200,
		stack = true,
		close = true,
	},

	["fountain_sprunk"] = {
		label = "Fountain Drink - Sprunk",
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_juice01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a **Fountain Drink**'
		},
		stack = true,
		close = true,
	},

	["fountain_ecola"] = {
		label = "Fountain Drink - ECola",
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_juice01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a **Fountain Drink**'
		},
		stack = true,
		close = true,
	},

	["fountain_water"] = {
		label = "Fountain Drink - Water",
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_juice01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a **Fountain Drink** '
		},
		stack = true,
		close = true,
	},



	["fountaindrink"] = {
		label = "Fountain Drink",
		weight = 250,
		stack = true,
		close = true,
	},
	["jumboshake"] = {
		label = "Jumbo Shake",
		weight = 250,
		stack = true,
		close = true,
	},
	["atomic_burger"] = {
		label = "Mr. Atom",
		weight = 200,
		stack = true,
		close = true,
	},

	["atomic_cake"] = {
		label = "Atomic Cupcake",
		weight = 50,
		stack = true,
		close = true,
	},

	["atomic_fries"] = {
		label = "Atomic Fries",
		weight = 100,
		client = {
			status = { hunger = 75000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_food_chips`, pos = vec3(0.01, -0.01, -0.05), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You are some Atomic Fries'
		},
		stack = true,
		close = true,
	},

	["atomic_peach_dessert"] = {
		label = "Peach Dessert",
		weight = 50,
		stack = true,
		close = true,
	},

	["atomic_tots"] = {
		label = "Tater Tots",
		client = {
			status = { hunger = 75000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_food_chips`, pos = vec3(0.01, -0.01, -0.05), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You are some Atomic Tater Tots'
		},
		weight = 100,
		stack = true,
		close = true,
	},

	["atomic_toy_chicken"] = {
		label = "Chicken Little",
		weight = 150,
		stack = true,
		close = true,
	},

	["atomic_toy_willie"] = {
		label = "Willie",
		weight = 150,
		stack = true,
		close = true,
	},

	
	['atmhacker'] = {
		label = 'ATM Hacker',
		weight = 750,
        description = 'Use for malicious activities..',
	},
	
	['bankhacker'] = {
		label = 'Bank Hacker',
		weight = 250,
        description = 'Use for malicious activities..',
	},


	["rod"] = {
		label = "Fishing rod",
		weight= 400,
		stack = true,
		close = true
	},
	["pike"] = {
		label = "Pike",
		weight= 250,
		stack = true,
		close = true
	},
	["bream"] = {
		label = "Bream",
		weight= 250,
		stack = true,
		close = true
	},
	["pike_berch"] = {
		label = "Pike Berch",
		weight= 250,
		stack = true,
		close = true
	},
	["salmon"] = {
		label = "Salmon",
		weight= 250,
		stack = true,
		close = true
	},
	["trout"] = {
		label = "Trout",
		weight= 250,
		stack = true,
		close = true
	},
	["cod"] = {
		label = "Cod",
		weight= 250,
		stack = true,
		close = true
	},
	["herring"] = {
		label = "Herring",
		weight= 250,
		stack = true,
		close = true
	},
	["tuna"] = {
		label = "Tuna",
		weight= 250,
		stack = true,
		close = true
	},

	["coffee_beans"] = {
		label = "Coffee Beans",
		weight = 2000,
		stack = true,
		close = true,
	},
	
	["coffee_grounds"] = {
		label = "Coffee Grounds",
		weight = 100,
		stack = true,
		close = true,
	},

	["milk"] = {
		label = "Milk",
		weight = 500,
		consume = 0.20,
		stack = true,
		close = true,
	},

	["blended_fruits"] = {
		label = "Blended Fruits",
		weight = 500,
		consume = 0.20,
		stack = true,
		close = true,
	},

	["caramel_syrup"] = {
		label = "Caramel Syrup",
		weight = 200,
		consume = 0.10,
		stack = true,
		close = true,
	},

	["food_oil"] = {
		label = "Food Oil",
		weight = 200,
		consume = 0.10,
		stack = true,
		close = true,
	},

	["syrup"] = {
		label = "Sugar Syrup",
		weight = 200,
		consume = 0.10,
		stack = true,
		close = true,
	},
	
	["gunkacchino"] = {
		label = "Gunkacchino",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},

	["highnoon"] = {
		label = "High Noon",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a High Noon'
		}
	},

	["speedball"] = {
		label = "Speedball",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},

	["bratte"] = {
		label = "Bratte",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},

	["flusher"] = {
		label = "Flusher",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},

	["caffeagra"] = {
		label = "Caffeagra",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},

	["beany"] = {
		label = "Mr. Beany",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},

	["bigfruit"] = {
		label = "Big Fruit",
		weight = 250,
		stack = true,
		close = true,
		client = {
			status = { thirst = 500000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a Gunkacchino'
		}
	},


	["bagel"] = {
		label = "Bagel",
		weight = 500,
		stack = true,
		close = true,
	},

	["bec"] = {
		label = "Bacon Egg Cheese Croissant",
		weight = 500,
		stack = true,
		close = true,
	},

	["sprinkledonut"] = {
		label = "Sprinkled Donut",
		weight = 250,
		stack = true,
		close = true,
	},

	["bun"] = {
		label = "Potato Bun",
		weight = 10,
		stack = true,
		close = true,
	},

	["cookedmeat"] = {
		label = "Burger Patty - Cooked",
		weight = 10,
		stack = true,
		close = true,
	},

	["meat"] = {
		label = "Raw Meat",
		weight = 10,
		stack = true,
		close = true,
	},
	
	["bshot_6lb_burger"] = {
		label = "BurgerShot 6lb. Burger",
		weight = 350,
		stack = true,
		close = true,
	},

	["bshot_chicken_wrap"] = {
		label = "BurgerShot Chicken Wrap",
		weight = 250,
		stack = true,
		close = true,
	},

	["bshot_double_shot_burger"] = {
		label = "BurgerShot Double Shot Burger",
		weight = 250,
		stack = true,
		close = true,
	},

	["bshot_fries"] = {
		label = "BurgerShot Fries",
		weight = 100,
		client = {
			status = { hunger = 75000 },
			anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = `prop_food_chips`, pos = vec3(0.01, -0.01, -0.05), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You are some BurgerShot Fries'
		},
		stack = true,
		close = true,
	},

	["bshot_glorious_burger"] = {
		label = "BurgerShot Glorious Burger",
		weight = 250,
		stack = true,
		close = true,
	},

	["bshot_goat_cheese_wrap"] = {
		label = "BurgerShot Goat Cheese Wrap",
		weight = 250,
		stack = true,
		close = true,
	},

	["bshot_prickly_burger"] = {
		label = "BurgerShot Prickly Burger",
		weight = 200,
		stack = true,
		close = true,
	},

	["bshot_simply_burger"] = {
		label = "BurgerShot Simply Burger",
		weight = 200,
		stack = true,
		close = true,
	},

	["bshot_soda"] = {
		label = "BurgerShot Soda",
		weight = 100,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_bs_juice02`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a Burgershot Soda'
		},
		stack = true,
		close = true,
	},
	
	["heartstopper"] = {
		label = "Heartstopper",
		weight = 100,
		stack = true,
		close = true,
	},

	["bleeder"] = {
		label = "Bleeder",
		weight = 100,
		stack = true,
		close = true,
	},

	["moneyshot"] = {
		label = "Moneyshot",
		weight = 100,
		stack = true,
		close = true,
	},

	["torpedo"] = {
		label = "Torpedo",
		weight = 100,
		stack = true,
		close = true,
	},


	["meal1"] = {
		label = "Moneyshot Meal",
		weight = 250,
		stack = true,
	},

	
	["meal2"] = {
		label = "Bleeder Meal",
		weight = 250,
		stack = true,
	},

	["meal3"] = {
		label = "Heartstopper Meal",
		weight = 250,
		stack = true,
	},

	["meal4"] = {
		label = "Torpedo Meal",
		weight = 250,
		stack = true,
	},
	

	["club_soda"] = {
		label = "Club soda",
		weight = 10,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		},
		stack = true,
		close = true,
	},
	["rimjob"] = {
		label = "Rim Job",
		weight = 100,
		stack = true,
		close = true,
	},

	["orangotang_icecream"] = {
		label = "Orang-O-Tang Icecream",
		weight = 100,
		stack = true,
		close = true,
	},


	["meteorite_icecream"] = {
		label = "Meteorite Icecream",
		weight = 100,
		stack = true,
		close = true,
	},


	["cocacola"] = {
		label = "Can of Soda",
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		},
		weight = 100,
		stack = true,
		close = true,
	},

	["creampie"] = {
		label = "Cream Pie",
		weight = 100,
		stack = true,
		close = true,
	},


	["impotentrage"] = {
		label = "Impotent Rage",
		weight = 100,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_energy_drink`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank a refreshing Impotent Rage'
		},
		stack = true,
		close = true,
	},
	["potatoe"] = {
		label = "Potato",
		weight = 10,
		stack = true,
		close = true,
	},

	["beer"] = {
		label = "Beer",
		weight = 100,
		stack = true,
		close = true,
	},

	["hookies_calamari"] = {
		label = "Calamari Basket",
		weight = 500,
		stack = true,
		close = true,
	},

	["hookies_crabcakes"] = {
		label = "Crabcakes",
		weight = 500,
		stack = true,
		close = true,
	},

	["hookies_fishchips"] = {
		label = "Fish & Chips",
		weight = 500,
		stack = true,
		close = true,
	},

	["hookies_fries"] = {
		label = "Sweet Potato Fries",
		weight = 250,
		stack = true,
		close = true,
	},

	["hookies_lobsterroll"] = {
		label = "Lobster Roll",
		weight = 500,
		stack = true,
		close = true,
	},

	["hookies_scallops"] = {
		label = "Scallop Basket",
		weight = 500,
		stack = true,
		close = true,
	},

	["hookies_shrimpbasket"] = {
		label = "Shrimp Basket",
		weight = 500,
		stack = true,
		close = true,
	},

	["hotdog"] = {
		label = "Hotdog",
		weight = 10,
		stack = true,
		close = true,
	},

	["ice"] = {
		label = "Ice",
		weight = 10,
		stack = true,
		close = true,
	},

	["sticky_note"] = {
		label = "Sticky Note",
		weight = 10,
		stack = false,
		close = true,
		description = 'Looks like a phone number for an unknown contact. Probably should use this at a payphone.'
	},

	['medikit'] = { -- Make sure not already a medikit
		label = 'Medikit',
		weight = 165,
		stack = true,
		close = true,
	},

	["licenseplate"] = {
		label = 'License Plate',
		weight = 500,
		stack = true,
		close = true,
	},
	["ring"] = {
		label = 'Ring',
		weight = 100,
		stack = true,
		close = true,
	},
	["pearlearring"] = {
		label = "Pearl",
		weight= 50,
		stack = true,
		close = true
	},
	['detector'] = { -- Make sure not already a medikit
		label = 'Metal Detector',
		weight = 1500,
		stack = false,
		close = true,
	},

	['xphone'] = {
		label = 'xPhone',
		weight = 185,
		stack = false
	},
	['pickaxe'] = {
		label = 'Pickaxe',
		weight = 325,
		stack = true,	
		decay = true -- This is a feature that deletes the item when durability reaches 0 (ox_inventory v2.31.0 or later)
	},

	["wepcleaningkit"] = {
		label = "Weapon Cleaning Kit",
		weight = 1133,
		stack = true,
		decay = true,
		close = true,
		description = "Used to restore weapon durability.",
		consume = 0.2,
		allowArmed = true,
		client = {
			disable = {
				move = true,
				car = true,
				combat = true
			},
			anim = {
				dict = "anim@amb@machinery@weapon_test@",
				clip = "base_amy_skater_01"
			},
			usetime = 15000
		},
		server = {
			export = 'stem_common.wepcleaningkit'
		},
	},

	['metal'] = {
		label = 'Metal',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['rope'] = {
		label = 'Rope',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['shovel'] = {
		label = 'Shovel',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	-- Weed

		["weed_packaged"] = {
			label = "Packaged Weed",
			weight = 1000,
			stack = true,
			close = true,
		},

		["weed_untrimmed"] = {
			label = "Untrimmed Weed",
			weight = 100,
			stack = true,
			close = true,
		},

		["joint"] = {
			label = "Joint",
			weight = 10,
			stack = true,
			close = true
		},

	-- Cocaine

		["cocaine_cut"] = {
			label = "Cut Cocaine",
			weight = 1000,
			stack = true,
			close = true,
		},

		["cocaine_packaged"] = {
			label = "Packaged Cocaine",
			weight = 1000,
			stack = true,
			close = true,
		},

		["cocaine_uncut"] = {
			label = "Uncut Cocaine",
			weight = 200,
			stack = true,
			close = true,
		},

	-- Methamphetamine Ingredients
	
		["pos_terminal"] = {
			label = "Payment Terminal",
			weight = 250,
			stack = true,
			close = true
		},

		["driverlicense"] = {
			label = "Driver's License",
			weight = 10,
			stack = true,
			close = true,
		},
		["boatinglicense"] = {
			label = "Boating License",
			weight = 10,
			stack = true,
			close = true,
		},

		["dhm-ammonia"] = {
			label = "Ammonia",
			weight = 50,
			stack = true,
			close = true,
		},

		["dhm-phosphorus"] = {
			label = "Phosphorus",
			weight = 50,
			stack = true,
			close = true,
		},

		["dhm-ephedrine"] = {
			label = "Ephedrine",
			weight = 50,
			stack = true,
			close = true,
		},

		["dhm-iodine"] = {
			label = "Iodine",
			weight = 50,
			stack = true,
			close = true,
		},
		
		["dhm-lithium"] = {
			label = "Lithium",
			weight = 50,
			stack = true,
			close = true,
		},

		["dhm-jerry"] = {
			label = "Empty Gas Can",
			weight = 250,
			stack = true,
			close = true,
		},

		["dhm-bag"] = {
			label = "Ziplock Bag",
			weight = 10,
			stack = true,
			close = true,
		},

		["dhm-pseudoephedrine"] = {
			label = "Pseudoephedrine",
			weight = 50,
			stack = true,
			close = true,
		},

		["dhm-waterpack"] = {
			label = "Water Cooler Jug",
			weight = 1500,
			stack = true,
			close = true,
		},

	-- Methamphetamine Products
	
		["dhm-meth"] = {
			label = "Crystal Meth",
			weight = 100,
			stack = true,
			close = true,
		},

		["dhm-methmix"] = {
			label = "Mixed Meth Chemicals",
			weight = 500,
			stack = true,
			close = true,
		},
		
		["dhm-pmeth"] = {
			label = "Bag of Meth",
			weight = 100,
			stack = true,
			close = true,
		},


['scrap_metal'] = {
    label = 'Scrap Metal',
    weight = 280,
    stack = true,
},

['stone'] = {
    label = 'Stone',
    weight = 265,
    stack = true,
},

['raw_copper'] = {
    label = 'Raw Copper',
    weight = 245,
    stack = true,
},

['raw_iron'] = {
    label = 'Raw Iron',
    weight = 225,
    stack = true,
},

['raw_steel'] = {
    label = 'Raw Steel',
    weight = 210,
    stack = true,
},

['raw_silver'] = {
    label = 'Raw Silver',
    weight = 190,
    stack = true,
},

['raw_gold'] = {
    label = 'Raw Gold',
    weight = 190,
    stack = true,
},

['raw_diamond'] = {
    label = 'Raw Diamond',
    weight = 165,
    stack = true,
},

['raw_emerald'] = {
    label = 'Raw Emerald',
    weight = 140,
    stack = true,
},

['copper'] = {
    label = 'Copper',
    weight = 225,
    stack = true,
},
['steel'] = {
    label = 'Steel',
    weight = 190,
    stack = true,
},

['silver'] = {
    label = 'Silver',
    weight = 175,
    stack = true,
},

['gold'] = {
    label = 'Gold',
    weight = 155,
    stack = true,
},

['diamond'] = {
    label = 'Diamond',
    weight = 140,
    stack = true,
},

['emerald'] = {
    label = 'Emerald',
    weight = 125,
    stack = true,
},

	['medbag'] = {
		label = 'Medical Bag',
		weight = 165,
		stack = false,
		close = true,
	},
	
	['tweezers'] = {
		label = 'Tweezers',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['suturekit'] = {
		label = 'Suture Kit',
		weight = 15,
		stack = true,
		close = true,
	},
	
	['icepack'] = {
		label = 'Ice Pack',
		weight = 29,
		stack = true,
		close = true,
	},
	
	['burncream'] = {
		label = 'Burn Cream',
		weight = 19,
		stack = true,
		close = true,
	},
	
	['defib'] = {
		label = 'Defibrillator',
		weight = 225,
		stack = false,
		close = true,
	},
	
	['sedative'] = {
		label = 'Sedative',
		weight = 15,
		stack = true,
		close = true,
	},
	
	['morphine30'] = {
		label = 'Morphine 30MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['morphine15'] = {
		label = 'Morphine 15MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['perc30'] = {
		label = 'Percocet 30MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['perc10'] = {
		label = 'Percocet 10MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['perc5'] = {
		label = 'Percocet 5MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['vic10'] = {
		label = 'Vicodin 10MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	['vic5'] = {
		label = 'Vicodin 5MG',
		weight = 2,
		stack = true,
		close = true,
	},
	
	["casino_chips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_comp_chips"] = {
		label = "Complimentary Casino Chips",
		weight = 0,
		stack = true,
		close = true,
	},

	['recoveredbullet'] = {
		label = 'Recovered Bullet',
		weight = 1,
		stack = true,
		close = false,
	},
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 75000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = false, car = true, combat = true },
			usetime = 2500,
		}
	},

	['painkillers'] = {
		label = 'Painkillers',
		weight = 250,
		stack = true,
		allowArmed = true,
		consume = 0.25,
		client = {
			anim = { dict = 'mp_suicide', clip = 'pill', duration = 2000 },
			disable = { move = true, car = true, combat = true },
			usetime = 3000
		},
		server = {
			export = 'stem_common.usepainkillers'
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		client = {
			image = 'card_id.png'
		}
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = true,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 100,
		stack = true,
		close = true,
	},

	["repairkit"] = {
		label = "Repair Kit",
		weight = 1000,
		stack = true,
		close = true,
	},

	
	["armor"] = {
		label = "Light Ballistic Vest",
		weight = 750,
		stack = true,
		close = true,
	},

	["armor2"] = {
		label = "Heavy Ballistic Vest",
		weight = 1500,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},


	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	["contract"] = {
		label = "Contract",
		weight = 100,
		stack = true,
		close = true,
	},
}