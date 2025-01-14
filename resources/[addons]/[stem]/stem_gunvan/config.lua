Config = {}

Config.DrawDistance = 25
Config.Size = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color = { r = 255, g = 35, b = 35 }
Config.Type = 25

Config.Locale = "en"

Config.LicenseEnable = true -- only turn this on if you are using esx_license
Config.LicensePrice = 1000

Config.Zones = {
	GunShop = {
		Legal = true,
		Items = {},
		Locations = {
			-- AMMU-NATION WITH RANGE
			vector4(23.3396, -1105.384, 28.797, 142.4851),
			vector4(811.77, -2159.54, 28.62, 0.77),
			-- REGULAR AMMU-NATION
			vector4(-332.79, 6084.34, 30.45, 223.63),
			vector4(254.75, -49.32, 68.94, 69.42),
			vector4(-1120.41, 2699.11, 17.55, 218.31),
			vector4(-663.20, -933.32, 20.83, 177.84),
			vector4(2569.31, 292.19, 107.73, 1.31),
			vector4(843.77, -1035.67, 27.19, 358.45),
			vector4(-1303.35, -392.97, 35.7, 74.68),
			vector4(1692.54, 3761.85, 33.71, 225.44)
		}
	},
	BlackWeashop = {
		Legal = false,
		Items = {},
		Locations = {}
	}
}

Config.PoliceJobs = {
	["lspd"] = true,
	["sahp"] = true,
	["lscso"] = true
}
