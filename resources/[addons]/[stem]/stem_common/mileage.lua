Config_Mileage = {
    ConversionFactor = GetConvarInt("mileage_conversionFactor", 20), -- From inferior units to something that makes sense
    Vehicles = {}
}

AddEventHandler(
    "gameEventTriggered",
    function(event, data)
        if event ~= "CEventNetworkPlayerEnteredVehicle" then
            return
        end

        local player, vehicle = data[1], data[2]
        if player ~= PlayerId() then
            return
        end

        if not NetworkGetEntityIsNetworked(vehicle) then
            return
        end

        local popType = GetEntityPopulationType(vehicle)
        if popType ~= 6 and popType ~= 7 then
            return
        end

        local vehClass = GetVehicleClass(vehicle)
        if vehClass > 12 then -- Exclude cycles, boats, helis, planes, service, emergency, etc.
            return
        end

        local maxTime = GetGameTimer() + 5000
        while Entity(vehicle).state.odometer == nil and GetGameTimer() < maxTime do
            if not DoesEntityExist(vehicle) or GetPedInVehicleSeat(vehicle, -1) ~= plyPed or IsEntityDead(plyPed) then
                break
            end
            Wait(0)
        end

        if Entity(vehicle).state.odometer == nil then
            Entity(vehicle).state:set("odometer", 0.0, true)
        end

        local model = GetEntityModel(vehicle)
        if IsThisModelACar(model) then
            local _, startingMileage = StatGetFloat(GetHashKey("MP0_DIST_DRIVING_CAR"), 0)

            local plyPed = PlayerPedId()
            local oldMileage = startingMileage
            while DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == plyPed and not IsEntityDead(plyPed) do
                local _, curMileage = StatGetFloat(GetHashKey("MP0_DIST_DRIVING_CAR"), 0)

                if curMileage - oldMileage > 16.0 then
                    local newMileage = Entity(vehicle).state.odometer + (curMileage - oldMileage)
                    Entity(vehicle).state:set("odometer", newMileage, true)
                    oldMileage = curMileage
                end
                Wait(1000)
            end
        elseif IsThisModelABike(model) then
            local _, startingMileage = StatGetFloat(GetHashKey("MP0_DIST_DRIVING_BIKE"), 0)

            local plyPed = PlayerPedId()
            local oldMileage = startingMileage
            while DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == plyPed and not IsEntityDead(plyPed) do
                local _, curMileage = StatGetFloat(GetHashKey("MP0_DIST_DRIVING_BIKE"), 0)

                if curMileage - oldMileage > 16.0 then
                    local newMileage = Entity(vehicle).state.odometer + (curMileage - oldMileage)
                    Entity(vehicle).state:set("odometer", newMileage, true)
                    oldMileage = curMileage
                end
                Wait(1000)
            end
        end
    end
)

AddEventHandler(
    "baseevents:leftVehicle",
    function(vehicle, seat, model, netID)
    end
)
