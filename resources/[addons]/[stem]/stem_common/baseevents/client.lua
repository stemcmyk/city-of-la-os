local base_isInVehicle = false
local base_isEnteringVehicle = false
local base_currentVehicle = 0
local base_currentSeat = 0

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            if not base_isInVehicle and not IsPlayerDead(PlayerId()) then
                if DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not base_isEnteringVehicle then
                    -- TriggerServerEvent('baseevents:enteringVehicle', vehicle, seat, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), netId)
                    -- trying to enter a vehicle!
                    local vehicle = GetVehiclePedIsTryingToEnter(ped)
                    local seat = GetSeatPedIsTryingToEnter(ped)
                    local netId = VehToNet(vehicle)
                    base_isEnteringVehicle = true
                elseif
                    not DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not IsPedInAnyVehicle(ped, true) and
                        base_isEnteringVehicle
                 then
                    -- vehicle entering aborted
                    -- TriggerServerEvent('baseevents:enteringAborted')
                    base_isEnteringVehicle = false
                elseif IsPedInAnyVehicle(ped, false) then
                    -- suddenly appeared in a vehicle, possible teleport
                    base_isEnteringVehicle = false
                    base_isInVehicle = true
                    base_currentVehicle = GetVehiclePedIsUsing(ped)
                    base_currentSeat = GetPedVehicleSeat(ped)
                    local model = GetEntityModel(base_currentVehicle)
                    local name = GetDisplayNameFromVehicleModel()
                    local netId = VehToNet(base_currentVehicle)
                    TriggerEvent(
                        "baseevents:enteredVehicle",
                        base_currentVehicle,
                        base_currentSeat,
                        GetEntityModel(base_currentVehicle),
                        netId
                    )
                -- TriggerServerEvent('baseevents:enteredVehicle', base_currentVehicle, base_currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(base_currentVehicle)), netId)
                end
            elseif base_isInVehicle then
                if not IsPedInAnyVehicle(ped, false) or IsPlayerDead(PlayerId()) then
                    -- bye, vehicle
                    local model = GetEntityModel(base_currentVehicle)
                    local name = GetDisplayNameFromVehicleModel()
                    local netId = VehToNet(base_currentVehicle)
                    TriggerEvent(
                        "baseevents:leftVehicle",
                        base_currentVehicle,
                        base_currentSeat,
                        GetEntityModel(base_currentVehicle),
                        netId
                    )
                    SetTimeout(0, function ()
                        TriggerEvent('ox_inventory:disarm', true)
                    end)
                    -- TriggerServerEvent('baseevents:leftVehicle', base_currentVehicle, base_currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(base_currentVehicle)), netId)
                    base_isInVehicle = false
                    base_currentVehicle = 0
                    base_currentSeat = 0
                end
            end
            Citizen.Wait(50)
        end
    end
)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i = -2, GetVehicleMaxNumberOfPassengers(vehicle) do
        if (GetPedInVehicleSeat(vehicle, i) == ped) then
            return i
        end
    end
    return -2
end

AddEventHandler("onResourceStop", function (resource) 
    print("Kill resource "..resource)
    TriggerServerEvent("stem_common:resourceStop", resource)
end)