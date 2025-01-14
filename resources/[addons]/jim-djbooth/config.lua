print("^2Jim^7-^2DJBooth ^7v^41^7.^43^7.^42 ^2by ^1Jimathy^7")

Config = {
	Lan = "en",
	Debug = false, -- Set to true to show target locations

	Core = "esx",
	Menu = "ox",
	Notify = "ox",

	Locations = {
		{ -- Vanilla Unicorn DJ Booth
			jobs = {"vu"}, -- Set this to required job role
			enableBooth = true, -- option to disable rather than deleting code
			DefaultVolume = 0.1, -- 0.01 is lowest, 1.0 is max
			radius = 30, -- The radius of the sound from the booth
			coords = vec3(120.0, -1281.72, 29.48), -- Where the booth is located
		},
		{ -- Vanilla Unicorn DJ Booth
			users = {"char1:d6462cdfead82709a715f1fa29c41947dd13dd45", "char1:6ec69833dc2c79348ff8b0def4060690ca7bb568", "char1:ESX-DEBUG-LICENCE-1" }, -- Set this to required job role
			enableBooth = true, -- option to disable rather than deleting code
			DefaultVolume = 0.1, -- 0.01 is lowest, 1.0 is max
			radius = 60, -- The radius of the sound from the booth
			coords = vector3(-1473.79, 160.19, 55.63), -- Where the booth is located
		}
		
	},
}

Loc = {}