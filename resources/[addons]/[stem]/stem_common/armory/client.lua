local objects = {}

Citizen.CreateThread(function ( )
    for key, value in pairs(Config_armory.locations) do
        exports.ox_target:addBoxZone({
            size = vector3(1, 2, 1),
            coords = value,
            options = {{
                name = "armory",
                onSelect = function ()
                    exports.ox_inventory:openInventory('shop', { id = key, type = "PoliceArmoury" })
                end,
                icon = 'fa-solid fa-gun',
                label = "Open Armory",
                distance = 4,
                groups = Config_armory.jobs
            }}
        })
    end
end)

RegisterNetEvent("stem_common:armory:removeArmor", function () 
    LocalPlayer.state:set("propData", nil, true)
    SetPedComponentVariation(PlayerPedId(), 9, oldDrawable, oldTexture, 0)
    SetPedArmour(PlayerPedId(), 100)
end)