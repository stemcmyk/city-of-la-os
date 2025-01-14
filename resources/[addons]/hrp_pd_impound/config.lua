Config 					= {}


Config.NoPlateColumn = false
Config.DOTPercentage = 0.2

Config.Impound 			= {
	Name = "PDM",
	RetrieveLocation = {X = -191.93, Y = -1163.37, Z = 23.67},
	StoreLocations = {
		{x = -239.32, y = -1183.54, z = 23.04},
		{x = -141.59, y = -1173.26, z = 23.77}
	},
	SpawnLocations = {
		{x = -234.38, y = -1255.67, z = 29.88, h = 92.86}
	},
	AdminTerminalLocations = {
		{x = -184.21, y = -1166.56, z = 23.67}
	}
}

Config.Rules = {
	maxWeeks = 0,
	maxDays = 6,
	maxHours = 24,
	minFee = 100,
	maxFee = 5000,
	minReasonLength = 10
}

Config.WaitTime = 250