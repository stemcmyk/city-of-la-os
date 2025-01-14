config = {
    -- How often do we want to send updates to the clients show the blips have updated
    client_update_interval = 2500,
    -- How long should we wait before iterating on the next group
    -- This value should be nowhere close to the value above, and should be less then
    wait_between_group_in_thread = 100,
    -- Toggle showing your own blip on the map
    hide_own_blip = true,
    -- Should we debug?
    debug = false,
    -- This is where you can create custom blip types
    -- Colors - https://runtime.fivem.net/doc/natives/?_0x03D7FB09E75D6B7E
    customVehicleTypes = {
        [`hpbike`] = "bike",
        [`pbike`] = "bike",
        [`pbike`] = "bike",
        [`moto`] = "bike",
        [`lssdbike`] = "bike"
    },
    blip_types = {
        ["lspd"] = {
            _can_see = { "amr", "lsdot", "lscso", "sahp" },
            _color = 3,
            _type = 1,
            _scale = 0.7,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true,
            _vehicle_blip_cone = true,
            _vehicle_blip_type = 672,
            _vehicle_blip_scale = 0.7,
            _vehicle_siren_colors = { 38, 59 },
            display_type = 2,
        },
        ["sahp"] = {
            _can_see = { "lspd", "lscso", "amr", "lsdot" },
            _color = 28,
            _type = 1,
            _scale = 0.7,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true,
            _vehicle_blip_cone = true,
            _vehicle_blip_type = 672,
            _vehicle_blip_scale = 0.7,
            _vehicle_siren_colors = { 38, 59 },
            display_type = 2,
        },
        ["lscso"] = {
            _can_see = { "lspd", "sahp", "amr", "lsdot" },
            _color = 43,
            _type = 1,
            _scale = 0.7,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true,
            _vehicle_blip_cone = true,
            _vehicle_blip_type = 672,
            _vehicle_blip_scale = 0.7,
            _vehicle_siren_colors = { 38, 59 },
            display_type = 2,
        },
        ["ghost_leo"] = {
            _can_see = { "lspd", "sahp", "lscso", "amr", "lsdot" },
            _color = 0,
            _type = 484,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true,
            _vehicle_blip_cone = true,
            _vehicle_blip_type = 672,
            _vehicle_blip_scale = 0.7,
            _vehicle_siren_colors = { 38, 59 },
            display_type = 2,
        },
        ["amr"] = {
            -- _can_see means the members of this group will be able to see
            -- both "doc" and "ems"
            _can_see = { "lsfd", "lspd", "lscso", "sahp" },
            -- These settings will take default options, unless specified per group
            _color = 1,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false
        },
        ["lsfd"] = {
            -- _can_see means the members of this group will be able to see
            -- both "doc" and "ems"
            _can_see = { "amr", "lspd", "lscso", "sahp" },
            -- These settings will take default options, unless specified per group
            _color = 1,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false
        },
        ["lsdot"] = {
            -- _can_see means the members of this group will be able to see
            -- both "doc" and "ems"
            _can_see = {},
            -- These settings will take default options, unless specified per group
            _color = 17,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true
        },
        ["taxi"] = {
            -- _can_see means the members of this group will be able to see
            -- both "doc" and "ems"
            _can_see = {},
            -- These settings will take default options, unless specified per group
            _color = 5,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = true
        },
        ["burgershot"] = {
            _can_see = {},
            _color = 10,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true
        },
        ["casino"] = {
            _can_see = {},
            _color = 2,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true
        },
        ["dispatch"] = {
            _can_see = { "lspd", "sahp", "lscso", "amr", "lsdot", "taxi" },
            _color = 0,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true
        },
        ["upnatom"] = {
            _can_see = {},
            _color = 5,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true
        },
        ['cinema'] = {
            _can_see = {},
            _color = 0,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true
        },
        ['assassin'] = {
            _can_see = { 'assassin_target' },
            _color = 0,
            _type = 1,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true,
            display_type = 0,
        },
        ['assassin_target'] = {
            _can_see = {},
            _color = 1,
            _type = 433,
            _scale = 0.5,
            _alpha = 255,
            _show_off_screen = true,
            _show_local_direction = true,
            display_type = 2
        }
    },
    -- Default settings for a group when one can not be found in the predefined list
    -- These options will be used when creating a "custom blip channel"
    default_type = {
        _color = 0,
        _type = 1,
        _scale = 0.67,
        _alpha = 255,
        _show_off_screen = false,
        _show_local_direction = false,
        _boat_blip_type = 427,
        _heli_blip_type = 422,
        _bike_blip_type = 226
    }
}
