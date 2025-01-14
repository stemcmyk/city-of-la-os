local SpeedLimitEnabled = true
local UIOpen = false

RegisterNetEvent(
    "919-speedlimit:client:ToggleSpeedLimit",
    function(toggle)
        if toggle then
            SendNUIMessage({action = "show"})
            UIOpen = true
            SpeedLimitEnabled = true
        else
            SendNUIMessage({action = "hide"})
            UIOpen = false
            SpeedLimitEnabled = false
        end
    end
)

-- AddEventHandler(
--     "baseevents:enteredVehicle",
--     function(vehicle, seat, model, netID)
--     end
-- )

AddEventHandler(
    "baseevents:leftVehicle",
    function(vehicle, seat, model, netID)
        if SpeedLimitEnabled and UIOpen then
            SendNUIMessage({action = "hide"})
            UIOpen = false
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1000)

            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local model = GetEntityModel(veh)

            local allowDraw = true

            if veh ~= 0 then
                allowDraw =
                    not IsThisModelABoat(model) and not IsThisModelABicycle(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and
                    not IsThisModelAJetski(model)
            end
            

            if IsPedInAnyVehicle(PlayerPedId()) and not IsPauseMenuActive() and allowDraw then
                if SpeedLimitEnabled and not UIOpen and not LocalPlayer.state.hudHidden then
                    SetScriptGfxAlign(string.byte("L"), string.byte("B"))
                    local minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
                    ResetScriptGfxAlign()
                    local w, h = GetActiveScreenResolution()

                    SetScriptGfxAlign(string.byte("L"), string.byte("B"))
                    minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045 + 0.150, 0.002 + (-0.188888))
                    ResetScriptGfxAlign()

                    SendNUIMessage({action = "show", x = (1 - minimapTopX + 0.005) * 100, y = minimapTopY * 100})
                    UIOpen = true
                elseif SpeedLimitEnabled and UIOpen then
                    local speed = GetSpeedLimit()
                    if (not LocalPlayer.state.hudHidden) then
                        if speed then
                            SendNUIMessage({action = "setlimit", speed = speed})
                        end
                    else
                        SendNUIMessage({action = "hide"})
                        UIOpen = false
                    end
                end
            else
                if SpeedLimitEnabled and UIOpen then
                    SendNUIMessage({action = "hide"})
                    UIOpen = false
                end
            end
        end
    end
)

function GetSpeedLimit()
    local coords = GetEntityCoords(PlayerPedId())
    return Config.SpeedLimits[GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))]
end

exports("GetCurrentSpeedLimit", GetSpeedLimit)
