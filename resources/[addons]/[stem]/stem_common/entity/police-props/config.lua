Config_PoliceSlingedWeapons = {
    [`WEAPON_CARBINERIFLE`] = {
        event = "police:rackRifle",
        model = {
            hash = GetHashKey("w_ar_carbinerifle"),
            boneIndex = 24816,
            offset = vector3(0.08, 0.22, -0.04),
            rotation = vector3(0.0, -15.0, 175.0)
        },
        magazine = {
            hash = GetHashKey("w_ar_carbinerifle_mag1"),
            offset = vector3(0.04, 0.0, 0.0),
            rotation = vector3(180.0, 180.0, 180.0)
        }
    },
    [`WEAPON_PUMPSHOTGUN`] = {
        event = "police:rackShotgun",
        model = {
            hash = GetHashKey("w_sg_pumpshotgun"),
            boneIndex = 24816,
            offset = vector3(0.08, 0.22, -0.04),
            rotation = vector3(0.0, -15.0, 175.0)
        },
        flashlight = {
            hash = GetHashKey("w_at_ar_flsh"),
            offset = vector3(0.1925, -0.0258, 0.04),
            rotation = vector3(0, 0, 0)
        }
    },
    [`WEAPON_GRENADELAUNCHER`] = {
        event = "police:rackLauncher",
        model = {
            hash = GetHashKey("w_lr_grenadelauncher"),
            boneIndex = 24816,
            offset = vector3(0.08, -0.22, -0.04),
            rotation = vector3(0.0, -15.0, 175.0)
        }
    },
    [`WEAPON_MP5`] = {
        event = "police:rackMP5",
        model = {
            hash = GetHashKey("w_mp5"),
            boneIndex = 24816,
            offset = vector3(0.08, 0.22, -0.04),
            rotation = vector3(0.0, -15.0, 175.0)
        },
        magazine = {
            hash = GetHashKey("w_mp5_mag1"),
            offset = vector3(0.1150, 0.0, 0.019),
            rotation = vector3(180.0, 170.0, 180.0)
        },
        scope = {
            hash = GetHashKey("w_mp5_macro_2"),
            offset = vector3(0.042, 0.0, 0.08),
            rotation = vector3(0, 0, 0)
        },
        flashlight = {
            hash = GetHashKey("w_mp5_flsh"),
            offset = vector3(0.1925, -0.0258, 0.04),
            rotation = vector3(0, 0, 0)
        },
        suppressor = {
            hash = GetHashKey("w_mp5_supp"),
            offset = vector3(0.2868, 0.0, 0.04),
            rotation = vector3(0, 0, 0)
        }
    },
    [`WEAPON_MK18`] = {
        event = "police:rackMK18",
        model = {
            hash = GetHashKey("w_mp5"),
            boneIndex = 24816,
            offset = vector3(0.08, 0.22, -0.04),
            rotation = vector3(0.0, -15.0, 175.0)
        },
        modular = true,
        flashlights = {
            GetHashKey("mk18_flash1"),
            GetHashKey("mk18_flash2"),
            GetHashKey("mk18_flash3"),
            GetHashKey("mk18_flash4"),
            GetHashKey("mk18_flash5"),
            GetHashKey("mk18_flash6"),
            GetHashKey("mk18_flash7")
        },
        frames = {
            GetHashKey("mk18_frame1"),
            GetHashKey("mk18_frame2"),
            GetHashKey("mk18_frame3")
        },
        grips = {
            GetHashKey("mk18_grip1"),
            GetHashKey("mk18_grip2"),
            GetHashKey("mk18_grip3"),
            GetHashKey("mk18_grip4"),
            GetHashKey("mk18_grip5")
        },
        magazines = {
            GetHashKey("mk18_mag1"),
            GetHashKey("mk18_mag2"),
            GetHashKey("mk18_mag3"),
            GetHashKey("mk18_mag4"),
            GetHashKey("mk18_mag5"),
            GetHashKey("mk18_mag6"),
            GetHashKey("mk18_mag7")
        },
        stocks = {
            GetHashKey("mk18_stock1"),
            GetHashKey("mk18_stock2"),
            GetHashKey("mk18_stock3"),
            GetHashKey("mk18_stock4"),
            GetHashKey("mk18_stock5"),
            GetHashKey("mk18_stock6"),
            GetHashKey("mk18_stock7"),
            GetHashKey("mk18_stock8"),
            GetHashKey("mk18_stock9")
        },
        scopes = {
            GetHashKey("mk18_scope1"),
            GetHashKey("mk18_scope2"),
            GetHashKey("mk18_scope3"),
            GetHashKey("mk18_scope4"),
            GetHashKey("mk18_scope5"),
            GetHashKey("mk18_scope6"),
            GetHashKey("mk18_scope7"),
            GetHashKey("mk18_scope8"),
            GetHashKey("mk18_scope9")
        },
        suppressors = {
            GetHashKey("mk18_suppressor1"),
            GetHashKey("mk18_suppressor2"),
            GetHashKey("mk18_suppressor3"),
            GetHashKey("mk18_suppressor4"),
            GetHashKey("mk18_suppressor5"),
            GetHashKey("mk18_suppressor6")
        }
    },
    [`WEAPON_FM1_M16A4`] = {
        event = "police:rackM16",
        model = {
            hash = GetHashKey("fm1_m16a4"),
            boneIndex = 24816,
            offset = vector3(0.02, 0.22, -0.04),
            rotation = vector3(0.0, -10.0, 175.0)
        },
        magazine = {
            hash = GetHashKey("fmliteclip_01"),
            offset = vector3(0.04, 0.0, 0.0),
            rotation = vector3(180.0, 180.0, 180.0)
        },
        scope = {
            hash = GetHashKey("fmlitescope_01"),
            offset = vector3(0.026, 0.0, 0.04),
            rotation = vector3(0, 0, 0)
        }
    }
}
