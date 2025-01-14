Config                            = {}
Config.Locale = GetConvar('esx:locale', 'en')

Config.Controls = {
	mechanicMenu = "F6",
	toggleNPCJob = "F7"
}

Config.DrawDistance               = 10.0 -- How close you need to be in order for the markers to be drawn (in GTA units).
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo',
	'sultan',
	'baller3'
}

Config.Zones = {

	MechanicActions = {
		Pos = {x = -221.51, y = -1179.92, z = 22.03},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = 27
	},
	Garage = {
		-- Get raw materials to make repair kits
		Pos = {x = 1178.39, y = 2646.83, z = 0.0},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = 1
	},
	Craft = {
		-- Craft repair kits
		Pos = {x = 1175.03, y = 2635.9, z = 0.0},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = 1
	},
	VehicleSpawnPoint = {
		Pos = {x = -198.47, y = -1183.04, z = 23.12},
		Heading = 270.12,
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	VehicleDeleter = {
		Pos = {x = -176.79, y = -1179.76, z = 22.26},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 0, b = 0},
		Type = 27
	},
	VehicleDelivery = {
		Pos = {x = -382.925, y = -133.748, z = -37.685},
		Size = {x = 20.0, y = 20.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
	},
}
