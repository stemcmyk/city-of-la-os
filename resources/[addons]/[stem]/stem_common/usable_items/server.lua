local EVIDENCE_WEBHOOK = GetConvar("evidence_webhook", nil)



RegisterNetEvent("stem_common:usableItems:repairKitUsed")
AddEventHandler("stem_common:usableItems:repairKitUsed", function (vehicleNet) 
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if (player.getInventoryItem("fixkit").count >= 1) then
        player.removeInventoryItem("fixkit", 1
    )
        TriggerClientEvent("stem_common:usableItems:repairKitUsed", src, vehicleNet)
    end
end)

ESX.RegisterUsableItem("fixkit", function (source, item)
    TriggerClientEvent("stem_common:usable-items:onFixkit", source)
end)

-- Light Ballistic Vest

ESX.RegisterUsableItem("armor", function (source, item) 
    local player = ESX.GetPlayerFromId(source)
    player.removeInventoryItem("armor", 1)
    TriggerClientEvent("stem_common:usable-items:useArmor", source, true)
end)

-- Heavy Ballistic Vest

ESX.RegisterUsableItem("armor2", function (source, item) 
    local player = ESX.GetPlayerFromId(source)
    player.removeInventoryItem("armor2", 1)
    TriggerClientEvent("stem_common:usable-items:useArmor", source, false)
end)

exports("wepcleaningkit", function (status, itemData, data)
    local player = ESX.GetPlayerFromId(data.player.source)
    local currentWeapon = exports.ox_inventory:GetCurrentWeapon(player.source) 
    if (status == "usingItem" and not currentWeapon) then 
        player.showNotification("You need to be holding a weapon to use this.", "error")
        return false
    end 
    if (status == "usedItem" and currentWeapon) then
        exports.ox_inventory:SetDurability(player.source, currentWeapon.slot, 100)
        player.showNotification("You have repaired the weapon.", "success")
    end
end)

local playersHealing = {}

exports('usepainkillers', function(status, item, data, slot)
	local source = data.player.source
    if not playersHealing[source] and status == "usedItem" then
		local xPlayer = ESX.GetPlayerFromId(source)

		local slot = exports.ox_inventory:GetSlot(xPlayer.source, slot)
		local currentDurability = slot?.metadata?.durability or 0
		exports.ox_inventory:SetDurability(xPlayer.source, slot, currentDurability - 25)

		playersHealing[source] = true	

		TriggerClientEvent('stem_common:usePainkillers', xPlayer.source)

		playersHealing[source] = nil
	end
end)


local allowedTake = {
    ["lscso"] = 4,
    ["lspd"] = 4,
    ["sahp"] = 5,
}
local allowedPut = {
    ["lscso"] = 0,
    ["lspd"] = 0,
    ["sahp"] = 0,
}


function sendEvidenceWebhook(payload) 
    local player = ESX.GetPlayerFromId(payload.source)
    if (EVIDENCE_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = EVIDENCE_WEBHOOK,
                params = {
                    username = "Evidence",
                    content = (payload.fromType == "player" and [[
                        <@%s> ``%s`` **%s** put x%s **%s** into evidence
                    ]] or [[
                        <@%s> ``%s`` **%s** took x%s **%s** from evidence
                    ]]):format(
                        playerDiscord, player.identifier, player.name, payload.count, payload.fromSlot.name
                    ),
                },
                ignoreEnv = true,
            })
        end)
    else
        print("No evidence_webhook found")
    end
end 

exports.ox_inventory:registerHook('swapItems', function(payload)
    local player = ESX.GetPlayerFromId(payload.source)
    print(json.encode(payload))
    if (not allowedPut[player.job.name] or not allowedTake[player.job.name]) then return false end;
    if (payload.fromType == "player" and player.job.grade >= allowedPut[player.job.name]) then
        sendEvidenceWebhook(payload)
        return true
    end
    if (payload.fromType ~= "player" and player.job.grade >= allowedTake[player.job.name]) then
        sendEvidenceWebhook(payload)
        return true
    end
    return false
end, {
    inventoryFilter = {
        "^evidence-[%w]+"
    }
})

local removeOnSwitch = { 
    ["lscso"] = true,
    ["lspd"] = true,
    ["sahp"] = true,
    ["amr"] = true
 }

RegisterNetEvent("esx:setJob", function (source, newJob, lastJob) 
    if (not removeOnSwitch[newJob.name] and removeOnSwitch[lastJob.name]) then
        exports.ox_inventory:ClearInventory(source, { "phone", "driverlicense", "boatinglicense" })
    end
end)

exports.ox_inventory:registerHook('swapItems', function(payload)
    if (payload.fromType == "player" and payload.toType == "player") then
        return true
    end
    return false
end, {
    itemFilter = {
        money = true
    }
})


-- local  = {
--     ["radi"]
-- }