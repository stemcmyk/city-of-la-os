Config = {}

-- # By how many services a player's community service gets extended if he tries to escape
Config.ServiceExtensionOnEscape = 2

-- # Don't change this unless you know what you are doing.
Config.StartLocation = vector4(1742.12, 2525.23, 45.56, 292.89)

-- # Don't change this unless you know what you are doing.
Config.ReleaseLocation = vector4(1847.36, 2586.04, 45.67, 265.53)

-- # Don't change this unless you know what you are doing.
Config.ServiceLocations = {
	{type = 'sweep', coords = vector4(1726.32, 2525.98, 45.56 - 1, 132.25)},
	{type = 'sweep', coords = vector4(1722.52, 2542.29, 45.56- 1, 10.41)},
	{type = 'sweep', coords = vector4(1715.95, 2561.33, 45.56- 1, 85.37)},
	{type = 'sweep', coords = vector4(1705.75, 2529.5, 45.56- 1, 189.61)},
	{type = 'sweep', coords = vector4(1710.95, 2517.82, 45.56- 1, 253.96)},
	{type = 'sweep', coords = vector4(1746.78, 2514.94, 45.56- 1, 258.99)},
	{type = 'sweep', coords = vector4(1717.91, 2511.57, 45.56- 1, 325.36)}
}

Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 146, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 119, ['pants_1']  = 3,
			['pants_2']  = 7,   ['shoes_1']  = 12,
			['shoes_2']  = 12,  ['chain_1']  = 0,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 120,  ['pants_1'] = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}
