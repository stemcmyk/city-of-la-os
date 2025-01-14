Config_Slots = {}

Config_Slots.ItemName = "chips" -- The chip item in DB

Config_Slots.PrintClient = false -- Print on client's console the spins in case of object bug
Config_Slots.Offset = true -- Add 30% propability to stop the spins in wrong position

Config_Slots.HideUI = true
Config_Slots.HideUIEvent = "pma-voice:toggleui"
Config_Slots.ShowUIEvent = "pma-voice:toggleui"

Config_Slots.Mult = {
	-- Multipliers based on GTA:ONLINE
	["1"] = 25,
	["2"] = 50,
	["3"] = 75,
	["4"] = 100,
	["5"] = 250,
	["6"] = 500,
	["7"] = 1000
}

Config_Slots.Slots = {
	[1] = {name = 'Diamond Miner', pos = vec3(967.651489, 56.780041, 79.996796), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[2] = {name = 'Diamond Miner', pos = vec3(985.454651, 34.135567, 79.970657), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[3] = {name = 'Diamond Miner', pos = vec3(974.310303, 35.296814, 79.994438), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[4] = {name = 'Diamond Miner', pos = vec3(980.583313, 46.017925, 79.994438), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[5] = {name = 'Diamond Miner', pos = vec3(963.372131, 35.407356, 79.990387), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[6] = {name = 'Diamond Miner', pos = vec3(967.211243, 57.055077, 79.997025), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[7] = {name = 'Diamond Miner', pos = vec3(982.999512, 42.489819, 79.994438), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[8] = {name = 'Diamond Miner', pos = vec3(958.075012, 58.042412, 79.996994), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[9] = {name = 'Diamond Miner', pos = vec3(978.867188, 36.068512, 79.994438), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[10] = {name = 'Diamond Miner', pos = vec3(967.072693, 38.971836, 79.987061), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[11] = {name = 'Diamond Miner', pos = vec3(953.170837, 51.511631, 79.995941), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[12] = {name = 'Diamond Miner', pos = vec3(957.973083, 55.529278, 79.988983), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},
	[13] = {name = 'Diamond Miner', pos = vec3(953.819458, 57.304287, 79.981407), bet = 25, prop = 'vw_prop_casino_slot_07a', prop1 = 'vw_prop_casino_slot_07a_reels', prop2 = 'vw_prop_casino_slot_07b_reels'	},

	[14] = {name = 'Deity of The Sun', pos = vec3(985.507019, 35.593266, 79.969376), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[15] = {name = 'Deity of The Sun', pos = vec3(980.011841, 47.298409, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[16] = {name = 'Deity of The Sun', pos = vec3(982.199158, 41.373844, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[17] = {name = 'Deity of The Sun', pos = vec3(989.898621, 41.216156, 79.996368), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[18] = {name = 'Deity of The Sun', pos = vec3(978.090210, 26.445480, 79.996368), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[19] = {name = 'Deity of The Sun', pos = vec3(965.056213, 34.355038, 79.985413), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[20] = {name = 'Deity of The Sun', pos = vec3(978.933777, 36.864388, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[21] = {name = 'Deity of The Sun', pos = vec3(973.738770, 36.577305, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[22] = {name = 'Deity of The Sun', pos = vec3(957.460999, 58.426075, 79.996994), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[23] = {name = 'Deity of The Sun', pos = vec3(953.017029, 56.020168, 79.985199), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[24] = {name = 'Deity of The Sun', pos = vec3(953.769287, 51.137688, 79.994911), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},
	[25] = {name = 'Deity of The Sun', pos = vec3(956.807800, 53.590446, 79.983315), bet = 10, prop = 'vw_prop_casino_slot_05a', prop1 = 'vw_prop_casino_slot_05a_reels', prop2 = 'vw_prop_casino_slot_05b_reels'},

	[26] = {name = 'Twilight Knife', pos = vec3(985.385315, 34.866543, 79.970268), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[27] = {name = 'Twilight Knife', pos = vec3(979.211426, 46.182434, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[28] = {name = 'Twilight Knife', pos = vec3(967.914551, 58.180248, 79.993698), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[29] = {name = 'Twilight Knife', pos = vec3(964.497253, 34.704327, 79.987061), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[30] = {name = 'Twilight Knife', pos = vec3(973.005066, 36.257160, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[31] = {name = 'Twilight Knife', pos = vec3(968.350159, 57.907612, 79.994499), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[32] = {name = 'Twilight Knife', pos = vec3(983.571045, 41.209335, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[33] = {name = 'Twilight Knife', pos = vec3(979.667542, 37.184486, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[34] = {name = 'Twilight Knife', pos = vec3(967.508301, 38.699203, 79.987862), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[35] = {name = 'Twilight Knife', pos = vec3(956.020264, 52.280151, 79.979485), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[36] = {name = 'Twilight Knife', pos = vec3(952.217529, 54.740784, 79.988983), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[37] = {name = 'Twilight Knife', pos = vec3(956.853882, 58.805462, 79.996994), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},
	[38] = {name = 'Twilight Knife', pos = vec3(952.571533, 51.886127, 79.996994), bet = 10, prop = 'vw_prop_casino_slot_06a', prop1 = 'vw_prop_casino_slot_06a_reels', prop2 = 'vw_prop_casino_slot_06b_reels'},

	[39] = {name = 'Republican Space Rangers', pos = vec3(986.269348, 36.831924, 79.966370), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},
	[40] = {name = 'Republican Space Rangers', pos = vec3(973.564880, 34.982811, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},
	[41] = {name = 'Republican Space Rangers', pos = vec3(979.425415, 27.013876, 79.992340), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},
	[42] = {name = 'Republican Space Rangers', pos = vec3(962.255615, 36.105045, 79.993683), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},
	[43] = {name = 'Republican Space Rangers', pos = vec3(989.106995, 42.432472, 79.992340), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},
	[44] = {name = 'Republican Space Rangers', pos = vec3(980.293579, 36.689678, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},
	[45] = {name = 'Republican Space Rangers', pos = vec3(956.415649, 52.938099, 79.981407), bet = 10, prop = 'vw_prop_casino_slot_03a', prop1 = 'vw_prop_casino_slot_03a_reels', prop2 = 'vw_prop_casino_slot_03b_reels'},

	[46] = {name = 'Fame or Shame', pos = vec3(978.710876, 26.818045, 79.994408), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[47] = {name = 'Fame or Shame', pos = vec3(982.265869, 42.169674, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[48] = {name = 'Fame or Shame', pos = vec3(962.814331, 35.755898, 79.992035), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[49] = {name = 'Fame or Shame', pos = vec3(985.812927, 36.257877, 79.968033), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[50] = {name = 'Fame or Shame', pos = vec3(972.938416, 35.461330, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[51] = {name = 'Fame or Shame', pos = vec3(989.423828, 41.762829, 79.994408), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[52] = {name = 'Fame or Shame', pos = vec3(966.369385, 37.846661, 79.990387), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[53] = {name = 'Fame or Shame', pos = vec3(966.809631, 37.571621, 79.990158), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[54] = {name = 'Fame or Shame', pos = vec3(980.239075, 35.904007, 79.994438), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'},
	[55] = {name = 'Fame or Shame', pos = vec3(957.195496, 54.236031, 79.985199), bet = 10, prop = 'vw_prop_casino_slot_04a', prop1 = 'vw_prop_casino_slot_04a_reels', prop2 = 'vw_prop_casino_slot_04b_reels'}
}

Config_Slots.Wins = {
	-- DO NOT TOUCH IT
	[1] = "2",
	[2] = "3",
	[3] = "6",
	[4] = "2",
	[5] = "4",
	[6] = "1",
	[7] = "6",
	[8] = "5",
	[9] = "2",
	[10] = "1",
	[11] = "3",
	[12] = "6",
	[13] = "7",
	[14] = "1",
	[15] = "4",
	[16] = "5"
}

Config_Slots.Audio = {
	["vw_prop_casino_slot_07a"] = "dlc_vw_casino_slot_machine_td_player_sounds",
	["vw_prop_casino_slot_06a"] = "dlc_vw_casino_slot_machine_kd_player_sounds",
	["vw_prop_casino_slot_05a"] = "dlc_vw_casino_slot_machine_ds_player_sounds",
	["vw_prop_casino_slot_04a"] = "dlc_vw_casino_slot_machine_fs_player_sounds",
	["vw_prop_casino_slot_03a"] = "dlc_vw_casino_slot_machine_rsr_player_sounds"
}
