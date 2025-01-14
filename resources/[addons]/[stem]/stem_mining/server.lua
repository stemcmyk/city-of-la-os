local objectsInUse = {}

ESX.RegisterServerCallback("stem_mining:beginMiningRock", function (source, cb, obj)
    Player(source).state.currentlyMiningRock = obj
    cb(true)
end)

RegisterNetEvent("stem_mining:finishMiningRock", function (state, obj, zone)
    local player = ESX.GetPlayerFromId(source) 

    if (obj ~= Player(source).state.currentlyMiningRock) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_mining:finishMiningRock",
			reason = "Invalid rock mine",
			metadata = {
                paramRock = obj,
                playrRock = Player(source).state.currentlyMiningRock
			}
		})
    end

    ESX.TriggerClientCallback(player.source, "stem_mining:getNetEntityModel", function (model) 
        if not Config.RockModels[model] then
            return TriggerEvent("stem_ac:player:sus", {
                source = player.source, 
                event = "stem_mining:finishMiningRock",
                reason = "Invalid rock mined",
                metadata = {
                    paramRock = obj,
                    model = model
                }
            })
        end

        local zone = Config.MiningZones[zone]
        
        if (exports.stem_common:getDistanceToCoord(player.source, zone.coords) > zone.radius) then 
            return TriggerEvent("stem_ac:player:sus", {
                source = player.source, 
                event = "stem_mining:finishMiningRock",
                reason = "Invalid distance to zone",
                metadata = {
                    distance = exports.stem_common:getDistanceToCoord(player.source, zone.coords),
                    zoneRadius = zone.radius
                }
            })
        end

        local zoneItems = Config.MiningVariants[zone.variant]

        local item = getRandomItem(zoneItems)
        player.addInventoryItem(item, math.random(1, 2))
    end, obj)
end)

function getRandomItem(itemTable)
    local randomNumber = math.random() * 100
    for key, data in next, exports.stem_common:tableReverse(itemTable) do
        if randomNumber <= data.chance then
            local randomIndex = math.random(1, #data.items)
            return data.items[randomIndex]
        end
    end
    return nil
end

RegisterNetEvent("stem_mining:finishSmelting", function () 
    Player(source).state.miningSmelting = false
end)

ESX.RegisterServerCallback("stem_mining:beginSmelting", function (source, cb, item) 
    local refineingItem = Config.SmeltingOptions[item]
    local player = ESX.GetPlayerFromId(source)

    local amount = player.hasItem(item).count

    if (amount <= 0) then
        player.showNotification(("You are missing **1x %s**"):format(player.hasItem(item).label))
        return cb(false)
    end

    Player(player.source).state.miningSmelting = true
    Citizen.CreateThread(function ()
        for i = 1, amount, 1 do
            Wait(refineingItem.duration)
            if (not Player(player.source).state.miningSmelting) then return player.showNotification(("You've refined **%sx %s**"):format(i, player.hasItem(item).label)) end
            local count = player.hasItem(item).count
            if (count <= 0) then return end
            player.removeInventoryItem(item, 1)
            player.addInventoryItem(refineingItem.output)
        end

        player.showNotification(("You've refined **%sx %s**"):format(amount, player.hasItem(item).label))
    end)
    return cb(true, refineingItem.duration * amount)
    
end)