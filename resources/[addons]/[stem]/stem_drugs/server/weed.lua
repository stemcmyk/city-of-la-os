-- Distance Checks

-- Items: weed_packaged, weed_untrimmed

-- ESX Callback (stem_drugs:weed:canRoll)
-- NetEvent (stem_drugs:weed:makeJoint)

local weedForJoint = 2
local weedForPackage = 10
local items = Config.Weed.Items


ESX.RegisterServerCallback("stem_drugs:weed:carry", function (source, cb, item ,quantity) 
	local player = ESX.GetPlayerFromId(source)
	
	local canCarry = player.canCarryItem(item, quantity)
	if (not canCarry) then TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NoSpace, type = "error" }) end
	
	cb(canCarry)
end)

RegisterNetEvent("stem_drugs:weed:pick")
AddEventHandler("stem_drugs:weed:pick", function () 
	local player = ESX.GetPlayerFromId(source)
	
	local distance = exports.stem_common:getDistanceToCoord(source, Config.Weed.Field.coords)
	if (distance >= 10)  then
		return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:weed:pick",
			reason = "Player was too far away from weed picking zone.",
			metadata = {
				distance = distance
			}
		})
	end

	local canCarry = player.canCarryItem(items.bud, 1)
	if (not canCarry) then TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NoSpace, type = "error" }) end
	
	player.addInventoryItem(items.bud, 1)
end)

ESX.RegisterServerCallback("stem_drugs:weed:canRoll", function (source, cb) 
	local player = ESX.GetPlayerFromId(source)

	local item = player.hasItem(items.bud)
	
	local hasBuds = item and item.count >= weedForJoint
	local canSwap = player.canSwapItem(items.bud, weedForJoint, items.joint, 1)

	if (not hasBuds) then 
		TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NotEnoughUntrim, type = "error" })
	elseif (not canSwap) then
		TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NoSpace, type = "error" })
	end

	cb(canSwap and hasBuds)	
end)

RegisterNetEvent("stem_drugs:weed:makeJoint")
AddEventHandler("stem_drugs:weed:makeJoint", function () 
	local src = source
	local player = ESX.GetPlayerFromId(source)

	local distance = exports.stem_common:getDistanceToCoord(source, Config.Weed.Package)
	if (distance >= 5) then
		return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:weed:makeJoint",
			reason = "Player was too far away from weed table.",
			metadata = {
				distance = distance
			}
		})
	end

	local canSwap = player.canSwapItem(items.bud, weedForJoint, items.joint, 1)
	if (not canSwap) then TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NoSpace, type = "error" }) end;

	player.removeInventoryItem(items.bud, weedForJoint)
	player.addInventoryItem(items.joint, 1)
end)

ESX.RegisterServerCallback("stem_drugs:weed:canPackage", function (source, cb) 
	local player = ESX.GetPlayerFromId(source)

	local item = player.hasItem(items.bud)
	
	local hasBuds = item and item.count >= weedForPackage
	local canSwap = player.canSwapItem(items.bud, weedForPackage, items.package, 1)

	if (not hasBuds) then 
		TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NotEnoughUntrim, type = "error" })
	elseif (not canSwap) then
		TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NoSpace, type = "error" })
	end
	
	cb(canSwap and hasBuds)	

end)

RegisterNetEvent("stem_drugs:weed:packageWeed")
AddEventHandler("stem_drugs:weed:packageWeed", function () 
	local src = source
	local player = ESX.GetPlayerFromId(source)

	local distance = exports.stem_common:getDistanceToCoord(source, Config.Weed.Package)
	if (distance >= 5) then
		return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:weed:packageWeed",
			reason = "Player was too far away from weed table.",
			metadata = {
				distance = distance
			}
		})
	end

	local canSwap = player.canSwapItem(items.bud, weedForPackage, items.package, 1)
	if (not canSwap) then TriggerClientEvent('ox_lib:notify', source, { description = Config.Weed.Locale.NoSpace, type = "error" }) end;

	player.removeInventoryItem(items.bud, weedForPackage)
	player.addInventoryItem(items.package, 1)
end)

-- -- Not necessary?
-- ESX Callback (stem_drugs:weed:quantity, item)
-- NetEvent (stem_drugs:weed:dry)
