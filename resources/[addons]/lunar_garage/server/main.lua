-- Used to store vehicles that have been taken out
---@type table<string, number>
local activeVehicles = {}

lib.callback.register('lunar_garage:getOwnedVehicles', function(source, index, society)
    local player = Framework.getPlayerFromId(source)
    if not player then return end
    
    local garage = Config.Garages[index]

    if society then
        local vehicles = MySQL.query.await(Queries.getGarageSociety, {
            player:getJob(), garage.Type
        })

        for _, vehicle in ipairs(vehicles) do
            if vehicle.pound == 1 then
                vehicle.state = 'in_impound'
            elseif vehicle.stored == 1 or vehicle.stored == true then
                vehicle.state = 'in_garage'
            elseif activeVehicles[vehicle.plate] then
                local entity = activeVehicles[vehicle.plate]
                if not DoesEntityExist(entity) then
                    activeVehicles[vehicle.plate] = nil
                    vehicle.state = 'in_insurance'
                else
                    vehicle.state = 'out_garage'
                end
            else
                vehicle.state = 'in_insurance'
            end
        end

        return exports.stem_common:tableFilter(exports.stem_common:tableMap(vehicles, function (vehicle) 
            if (vehicle.status ~= 0) then
                return false
            end
            return vehicle
        end))
    else
        local vehicles = MySQL.query.await(Queries.getGarage, {
            player:getIdentifier(), garage.Type
        })

        for _, vehicle in ipairs(vehicles) do
            if vehicle.pound == 1 or vehicle.pound == true then
                vehicle.state = 'in_impound'
            elseif vehicle.stored == 1 or vehicle.stored == true then
                vehicle.state = 'in_garage'
            elseif activeVehicles[vehicle.plate] then
                local entity = activeVehicles[vehicle.plate]
                if not DoesEntityExist(entity) then
                    activeVehicles[vehicle.plate] = nil
                    vehicle.state = 'in_insurance'
                else
                    vehicle.state = 'out_garage'
                end
            else
                vehicle.state = 'in_insurance'
            end
        end

        return exports.stem_common:tableFilter(exports.stem_common:tableMap(vehicles, function (vehicle) 
            if (vehicle.status ~= 0) then
                return false
            end
            return vehicle
        end))
    end
end)

lib.callback.register('lunar_garage:getImpoundedVehicles', function(source, index, society)
    local player = Framework.getPlayerFromId(source)
    if not player then return end
    
    local impound = Config.Impounds[index]

    if society then
        local vehicles = MySQL.query.await(Queries.getImpoundSociety, {
            player:getJob(), impound.Type
        })

        local filtered = {}

        for _, vehicle in ipairs(vehicles) do
            local entity = activeVehicles[vehicle.plate]

            if not entity then
                table.insert(filtered, vehicle)
            elseif not DoesEntityExist(entity) then
                activeVehicles[vehicle.plate] = nil
                table.insert(filtered, vehicle)
            elseif GetVehiclePetrolTankHealth(entity) <= 0 or GetVehicleBodyHealth(entity) <= 0 then
                DeleteEntity(entity)
                activeVehicles[vehicle.plate] = nil
                table.insert(filtered, vehicle)
            end
        end

        return filtered
    else
        local vehicles = MySQL.query.await(Queries.getImpound, {
            player:getIdentifier(), impound.Type
        })

        local filtered = {}

        for _, vehicle in ipairs(vehicles) do
            local entity = activeVehicles[vehicle.plate]

            if not entity then
                table.insert(filtered, vehicle)
            elseif not DoesEntityExist(entity) then
                activeVehicles[vehicle.plate] = nil
                table.insert(filtered, vehicle)
            elseif GetVehiclePetrolTankHealth(entity) <= 0 or GetVehicleBodyHealth(entity) <= 0 then
                DeleteEntity(entity)
                activeVehicles[vehicle.plate] = nil
                table.insert(filtered, vehicle)
            end
        end

        return filtered
    end
end)

lib.callback.register('lunar_garage:takeOutVehicle', function(source, index, plate, type)
    local player = Framework.getPlayerFromId(source)
    if not player then return end

    local vehicle = MySQL.single.await(Queries.getStoredVehicle, {
        player:getIdentifier(), player:getJob(), plate, 1
    })

    if vehicle then
        MySQL.update.await(Queries.setStoredVehicle, { 0, plate })
        local garage = Config.Garages[index]
        local coords = garage.SpawnPosition
        local props = json.decode(vehicle.mods or vehicle.vehicle)
        local entity = Utils.createVehicle(props.model, coords, type)

        if entity == 0 then return end

        while NetworkGetEntityOwner(entity) == -1 do Wait(0) end

        local netId, owner = NetworkGetNetworkIdFromEntity(entity), NetworkGetEntityOwner(entity)
        
        TriggerClientEvent('lunar_garage:setVehicleProperties', owner, netId, props)

        activeVehicles[plate] = entity

        return netId
    end
end)

function updateGarageIfExists(garage)
    for key, value in pairs(Config.Garages) do
        if (value.id == garage.id) then
            Config.Garages[key] = garage
            return true
        end
    end
    return false
end

function registerExternalGarages(garages)
    for key, extGarage in next, garages do
        if (not updateGarageIfExists(extGarage)) then
            table.insert(Config.Garages, extGarage)
        end
    end
    TriggerClientEvent("lunar_garage:updateGarages", -1, Config.Garages)
end

exports("registerExternalGarages", registerExternalGarages)

RegisterNetEvent("lunar_garage:fetchGarages", function ()
    TriggerClientEvent("lunar_garage:updateGarages", -1, Config.Garages)
end)

RegisterNetEvent("esx:playerJoined", function (source)
    TriggerClientEvent("lunar_garage:updateGarages", source, Config.Garages)
end)

function saveVehicle(source, props, netId) 
    local player = Framework.getPlayerFromId(source)
    if not player then return end

    local vehicle = MySQL.single.await(Queries.getOwnedVehicle, {
        player:getIdentifier(), player:getJob(), props.plate
    })
    
    if vehicle then
        local oldProps = json.decode(vehicle.mods or vehicle.vehicle)

        if props.model ~= oldProps.model then
            return false
        end

        MySQL.update.await(Queries.setStoredVehicle, { 1, props.plate })
        MySQL.update.await(Queries.setVehicleProps, { json.encode(props), props.plate })

        SetTimeout(500, function()
            local vehicle = NetworkGetEntityFromNetworkId(netId)
            
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
            end
        end)

        activeVehicles[props.plate] = nil;

        return true
    end
    
    return false
end
lib.callback.register('lunar_garage:saveVehicle',saveVehicle)

RegisterNetEvent("lunar_garage:saveVehicle")
AddEventHandler("lunar_garage:saveVehicle", saveVehicle)

lib.callback.register('lunar_garage:retrieveVehicle', function(source, index, plate, type)
    if activeVehicles[plate] then return end

    local player = Framework.getPlayerFromId(source)
    if not player then return end

    local vehicle = MySQL.single.await(Queries.getOwnedVehicle, {
        player:getIdentifier(), player:getJob(), plate
    })

    if vehicle then
        if player:getAccountMoney('bank') < Config.ImpoundPrice then return false end

        player:removeAccountMoney('bank', Config.ImpoundPrice)

        local impound = Config.Impounds[index]
        local coords = impound.SpawnPosition
        local props = json.decode(vehicle.mods or vehicle.vehicle)
        local entity = Utils.createVehicle(props.model, coords, type)

        if entity == 0 then return end

        while NetworkGetEntityOwner(entity) == -1 do Wait(0) end

        local netId, owner = NetworkGetNetworkIdFromEntity(entity), NetworkGetEntityOwner(entity)
        
        TriggerClientEvent('lunar_garage:setVehicleProperties', owner, netId, props)

        activeVehicles[props.plate] = entity

        return true, netId
    end

    return false
end)



lib.callback.register("lunar_garage:payForRepair", function (source, price) 
    local player = Framework.getPlayerFromId(source)
    if not player then return false end

    if (player:getAccountMoney('bank') < price) then
        return false
    end

    player:removeAccountMoney("bank", price)
    return true
end)

function getVehicleCoords(source, plate)
    local entity = activeVehicles[plate]

    if not entity then return end

    return GetEntityCoords(entity)
end

function getVehicle(source, plate)
    local entity = activeVehicles[plate]

    if not entity then return end

    return entity
end

lib.callback.register('lunar_garage:getVehicleCoords', getVehicleCoords)

exports("getVehicleCoords", getVehicleCoords)
exports("getVehicle", getVehicle)