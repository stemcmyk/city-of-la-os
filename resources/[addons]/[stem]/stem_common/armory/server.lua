RegisterNetEvent("stem_common:armory:open", function (data) 
    exports.ox_inventory:openShop(source, {
        type = "PoliceArmoury",
        id = 1,
    })
end)

local pdLockedWeapons = {}
for key, value in pairs(Config_armory.armory) do
    if (not value.nonPD) then
        pdLockedWeapons[value.name] = value
    end
end

Citizen.CreateThread(function ( )
    exports.ox_inventory:RegisterShop("PoliceArmoury", {
        name = 'Police Armoury',
        groups = Config_armory.jobs,
        inventory = Config_armory.armory, 
        -- locations = Config_armory.locations
    })
end)


-- If PD, stop all weapon transfers from to all inventories except emergency vehicles and other pd
-- If Not PD, stop all weapon transfers from emergency vehicles

exports.ox_inventory:registerHook('swapItems', function(payload, entity, two)
    local player = ESX.GetPlayerFromId(payload.source)

    if (not pdLockedWeapons[payload.fromSlot.name]) then
        return true;
    end

    if (payload.toType == "policeevidence") then
        return true
    end
    
    if (payload.fromSlot.metadata and payload.fromSlot.metadata.serial and string.find(payload.fromSlot.metadata.serial, "POL")) then
	    if (payload.toType == "player" and payload.fromInventory == payload.toInventory) then return true  end
        TriggerClientEvent("stem_common:armory:removeArmor", player.source)
        
        return false
    end

    return true
end)
