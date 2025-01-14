local purgeEnd = 1720605600
-- GlobalState.purgeActive = os.time() < purgeEnd
GlobalState.purgeActive = false 

RegisterNetEvent("shit_purge:isActive", function ()
    if (GlobalState.purgeActive) then
        TriggerClientEvent("shit_purge:EASNotification", source)
    end
end)

RegisterNetEvent("esx:playerLoaded", function (source, player) 
    if (GlobalState.purgeActive) then
        if (not player.hasItem("WEAPON_FIREWORK") or player.hasItem("WEAPON_FIREWORK").count <= 0) then
            player.addInventoryItem("WEAPON_FIREWORK", 1)
            player.addInventoryItem("AMMO-FIREWORK", 10)
        end
    end
end)

exports.ox_inventory:registerHook('swapItems', function(payload, entity, two)
    if (payload.fromSlot.name == "WEAPON_FIREWORK" and GlobalState.purgeActive) then
        if (payload.toType == "player" and payload.fromInventory == payload.toInventory) then return true  end
        return false
    end
    return true
end)