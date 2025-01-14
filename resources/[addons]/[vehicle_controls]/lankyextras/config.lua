-- config.lua

Config = {}

Config.Locations = {
    {name = 'LSPD Extras', job = {'lspd', "lscso", "sahp"}, coords = vector4(463.42, -1019.46, 27.63, 91.23), radius = 25.0, menuName = 'LSPD Extras'},
    {name = 'LSSD Extras', job = {'lspd', "lscso", "sahp"}, coords = vector4(378.59, -1629.54, 28.98, 318.54), radius = 20.0, menuName = 'LSSD Extras'},
    {name = 'SAHP Extras', job = {'lspd', "lscso", "sahp"}, coords = vector3(1558.87, 821.15, 77.14), radius = 20.0, menuName = 'SAHP Extras'}
}

Config.Keys = {key2 = 29} -- Default key: B (used in combination with left shift)

Config.Command = 'extras' -- Command used to open menu if controls are not functioning

Config.AdminCommand = 'adminextras' -- Admin command to open the extras menu from anywhere
Config.AdminGroup = 'admin' -- Group that is allowed to use the command

-- Alignment of the menu: 'left' or 'right'
Config.MenuAlignment = 'left' -- Default: 'right'
