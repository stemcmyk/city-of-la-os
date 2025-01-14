Config = {
    FrameWork = {
        FRAMEWORK = "ESX", --ESX/QBCORE/CUSTOM
        -- If you use CUSTOM, then you need to edit the framework/custom files

        ESX_RESOURCE_NAME = "es_extended",
        ESX_SHARED_OBJECT = "esx:getSharedObject",

        QBCORE_RESOURCE_NAME = "qb-core",
        QBCORE_SHARED_OBJECT = "QBCore:GetObject"
    },
    Main = {
        QuickTeleportLocations = {
            -- They will be added to the menu so you can quick TP the players
            ["Legion Square"] = vector4(195.15, -933.92, 30.69, 324.96),
            ["Mission Row P.D"] = vector4(434.46, -981.87, 30.71, 93.62),
        },
        Binds = {
            -- See https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            NoClip = "F11",
            TeleportToMarker = "F12",
            OpenMenu = "F9", -- Left Alt by default
        },
        Commands = {
            -- Make sure you don't already have the same commands name in your server
            CreateReport = "report",
            Ban = "ban",
            Unban = "unban",
            Kick = "kick",
            AddWarn = "warn",
            RemoveWarn = "removewarn",
            GoTo = "goto",
            Bring = "bring",
            BringBack = "bringback",
            DM = "dm",
            ServerAnnounce = "announce",
            Screenshot = "screenshot",
        },
        CustomButtons = {
            ["Self"] = {
                --{
                --    ButtonName = "",
                --    Action = function(playerId)
                --    end,
                --},
            },
            ["Players"] = {},
            ["Server"] = {},
            ["Visuals"] = {},
        }
    },
    Permissions = {
        -- Make sure you added the permissions to your players according to their rank
        -- FORMAT: add_ace <identifier> "WaveAdmin.<rank>" allow
        -- EXAMPLE:
        -- add_ace identifier.license:xxx "WaveAdmin.owner" allow
        -- add_ace identifier.steam:xxx "WaveAdmin.admin" allow
        -- add_ace identifier.discord:xxx "WaveAdmin.mod" allow
        -- add_ace group.admin "WaveAdmin.admin" allow
        -- add_ace group.mod "WaveAdmin.mod" allow

        RANKS = {
            -- Add as many groups as you want here after adding perms to them in your server.cfg
            -- WARNING: The order must be from lowest to highest rank
            "helper",
            "mod",
            "admin",
            "superadmin",
            "god",
            "_dev",
            "owner",
        },
        PRIVILEGES = {
            -- FORMAT: <Permission> = <MinimumRankAllowed>
            -- This means that if your rank is or is higher than the one specified, the privilege will be granted.
            ["Teleport"] = "helper",
            ["NoClip"] = "helper",
            ["Heal"] = "helper",
            ["FlipVehicle"] = "helper",
            ["RefuelVehicle"] = "helper",
            ["ManageReports"] = "helper",
            ["DM"] = "mod",
            ["ManageWarns"] = "mod",
            ["Freeze"] = "mod",
            ["Screenshot"] = "mod",
            ["SpawnVehicle"] = "mod",
            ["DeleteVehicle"] = "mod",
            ["RepairVehicle"] = "mod",
            ["Revive"] = "mod",
            ["GodMode"] = "mod",
            ["Invisible"] = "mod",
            ["ESP"] = "mod",
            ["Announce"] = "admin",
            ["Kick"] = "admin",
            ["Ban"] = "admin",
            ["Unban"] = "admin",
            ["SetJob"] = "admin",
            ["GiveItems"] = "admin",
            ["ManageMoney"] = "admin",
            ["ManageWorld"] = "admin",
            ["SetPedModel"] = "admin",
            ["GiveArmour"] = "admin",
            ["GiveWeapon"] = "admin",
            ["RefillAmmo"] = "admin",
            ["SetWeaponTint"] = "admin",
            ["SetWeaponComponent"] = "admin",
            ["InfiniteStamina"] = "admin",
            ["NoRagdoll"] = "admin",
            ["NoCollisions"] = "admin",
            ["Skin"] = "admin",
            ["Wipe"] = "admin",
            ["ClearInventory"] = "admin",
            ["CustomizeVehicle"] = "god",
            ["FastRun"] = "god",
            ["VehicleSpeed"] = "god",
            ["WeaponDamageBoost"] = "god",
            ["Troll"] = "god",
            ["SetGroup"] = "god",
        }
    }
}