RegisterNetEvent("stem_common:usable-items:useArmor")
AddEventHandler(
    "stem_common:usable-items:useArmor",
    function(useState)
        local playerPed = GetPlayerPed(-1)
        local oldDrawable = GetPedDrawableVariation(playerPed, 9)
        local oldTexture = GetPedTextureVariation(playerPed, 9)
        if oldDrawable > 0 then
            SetPedComponentVariation(playerPed, 9, 0, 0, 0)
        end
        local label = ""
        if GetPedArmour(playerPed) > 0 then
            label = "Replacing Ballistic Vest"
        else
            label = "Putting on Ballistic Vest"
        end

         Citizen.CreateThread(function() lib.progressCircle({
            duration = 4500,
            label = label,
            disable = {
                car = true
            }
        }) end)

        RequestAnimDict("switch@franklin@getting_ready")
        while not HasAnimDictLoaded("switch@franklin@getting_ready") do
            Citizen.Wait(0)
        end

        RequestAnimDict("anim@heists@money_grab@duffel")
        while not HasAnimDictLoaded("anim@heists@money_grab@duffel") do
            Citizen.Wait(0)
        end

        LocalPlayer.state:set(
            "propData",
            {
                model = GetHashKey("prop_bodyarmour_03"),
                boneIndex = 11347,
                offset = vector3(0, 0, 0),
                rotation = vector3(0, 0, 0),
                rotationOrder = 2
            },
            true
        )

        TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@duffel", "exit", 8.0, 8.0, -1, 48, 0, false, false, false)

        Citizen.Wait(2000)
        ClearPedTasks(PlayerPedId())

        TaskPlayAnim(PlayerPedId(), "switch@franklin@getting_ready", "002334_02_fras_v2_11_getting_dressed_exit", 8.0,
            8.0, -1, 48, 0, false, false, false)

        Citizen.SetTimeout(
            1250,
            function()
                LocalPlayer.state:set("propData", nil, true)

                if oldDrawable > 0 then
                    SetPedComponentVariation(playerPed, 9, oldDrawable, oldTexture, 0)
                end
            end
        )

        Citizen.Wait(2500)
        ClearPedTasks(PlayerPedId())
        local job = LocalPlayer.state.job?.name
        if job ~= 'lspd' and job ~= 'sahp' and job ~= 'lscso' then
            return
        end

        if useState then
            SetPedArmour(playerPed, 50)
        else
            AddArmourToPed(playerPed, 100)
            SetPedArmour(playerPed, 100)
        end

        
        lib.notify({
            description = "Ballistic vest applied",
        })
    end
)

RegisterNetEvent("stem_common:usable-items:onFixkit")
AddEventHandler(
    "stem_common:usable-items:onFixkit",
    function()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            local vehicle = nil

            local closestDist = 5.0
            local closestVeh = nil
            local vehPool = GetGamePool("CVehicle")
            for i = 1, #vehPool do
                local veh = vehPool[i]
                if DoesEntityExist(veh) then
                    local dist = #(coords - GetEntityCoords(veh))
                    if dist < closestDist then
                        closestDist = dist
                        closestVeh = veh
                    end
                end
            end
            vehicle = closestVeh

            if DoesEntityExist(vehicle) then
                if Entity(vehicle).state.kq_wheeldamage_broken then
                    lib.notify({
                        type = "error",
                        title = "Cannot Repair",
                        description = "This vehicle has missing vehicles and cannot be repaired",
                        position = "top"
                    })
                    return
                end

                local offset = GetOffsetFromEntityInWorldCoords(vehicle, 0, 3.0, 0)

                local heading = GetEntityHeading(vehicle) + 180.0
                if heading > 360.0 then
                    heading = heading - 360.0
                end

                LocalPlayer.state.blockClearTasks = true

                TaskGoStraightToCoord(playerPed, offset, 1.0, 20000, heading, 0.05)
                Citizen.Wait(5000)

                -- SetVehicleDoorOpen(vehicle, 4, false, false)
                
                local veh = NetToVeh(VehToNet(vehicle))
                if DoesEntityExist(veh) then
                    SetVehicleDoorOpen(veh, 4, false, false)
                end
                
                local oldFuel = exports["esx-sna-fuel"]:GetFuel(vehicle) or 100


                ESX.ShowHelpNotification("Press ~INPUT_VEH_DUCK~ to cancel.")
                if lib.progressCircle({
                    duration  = 20000,
                    label = "Repairing Vehicle",
                    anim = {
                        scenario = "PROP_HUMAN_BUM_BIN"
                    },
                    disable = {
                        car = true,
                        move = true,
                    },
                    canCancel = true,
                }) then 
                    ClearPedTasks(playerPed)
                    LocalPlayer.state.blockClearTasks = false
                    TriggerServerEvent("stem_common:usableItems:repairKitUsed", VehToNet(vehicle))

                    Citizen.SetTimeout(
                        1000,
                        function()
                            exports["esx-sna-fuel"]:SetFuel(vehicle, oldFuel)
                        end
                    )
                else
                    lib.notify({description = "Repair cancelled."})
                    ClearPedTasks(playerPed)
                    ClearAllHelpMessages()
                    LocalPlayer.state.blockClearTasks = false
                end
            end
        end
    end
)

RegisterNetEvent("stem_common:usableItems:repairKitUsed")
AddEventHandler(
    "stem_common:usableItems:repairKitUsed",
    function(vehNetId)
        if NetworkDoesEntityExistWithNetworkId(vehNetId) then
            local vehicle = NetToVeh(vehNetId)
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleDoorShut(vehicle, 4, false)
        end
    end
)

local waves = 10

RegisterNetEvent("stem_common:usePainkillers", function () 
    local maxHealth = GetEntityMaxHealth(PlayerPedId())

    lib.notify({ description = 'You feel better already' })
    for i = 1, waves, 1 do
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 10)
        LocalPlayer.state.invBusy = false
        LocalPlayer.state.blockClearTasks = false
        LocalPlayer.state.invHotkeys = true
        Wait(2000)
    end
end)