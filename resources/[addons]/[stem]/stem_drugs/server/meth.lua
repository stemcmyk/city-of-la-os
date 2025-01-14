-- Meth Ingredients: dhm-ammonia, dhm-bag, dhm-ephedrine, dhm-iodine, dhm-jerry, dhm-lithium, dhm-phosphorus, dhm-pseudoephedrine, dhm-waterpack
-- Meth Product: dhm-meth, dhm-pmeth, dhm-methmix

local mixItems = {
    ["dhm-ammonia"] = 1,
    ["dhm-ephedrine"] = 1,
    ["dhm-iodine"] = 1,
    ["dhm-lithium"] = 1,
    ["dhm-phosphorus"] = 1,
    ["dhm-pseudoephedrine"] = 1
}

local cookItems = {
    ["dhm-methmix"] = 1,
    ["dhm-jerry"] = true,
    ["dhm-waterpack"] = true
}

local packItems = {
    ["dhm-bag"] = 1,
    ["dhm-meth"] = 1
}

-- ESX Callback (stem_drugs:meth:busy, stage: number)
local stagesStatus = {}

ESX.RegisterServerCallback("stem_drugs:meth:busy", function (source, cb, stage)
    return cb(stagesStatus[stage])
end)

RegisterNetEvent("stem_drugs:meth:busy", function (status, stage) 
    stagesStatus[stage] = status
end)

function checkMissingItems(source, items)
    local player = ESX.GetPlayerFromId(source)

    local missingItems = false
    for key, value in pairs(items) do
        local item = player.hasItem(key)
        if (not item) then return print(("invalid item %s"):format(key)) end
        if (item.count < (value == true and 1 or value)) then
            missingItems = true
            if (value == true) then
                player.showNotification(("You are missing a **%s**"):format(item.label))
            else
                player.showNotification(("You are missing **%s** **%s**"):format(value - item.count, item.label))
            end
        end
    end

    return missingItems
 end

ESX.RegisterServerCallback("stem_drugs:meth:mixmix", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)

    local missingItems = checkMissingItems(player.source, mixItems)
    if (missingItems) then return cb(false) end

    Player(player.source).state.methTimer = GetGameTimer()
    return cb(true)
end)

RegisterNetEvent("stem_drugs:meth:mix", function () 
    local player = ESX.GetPlayerFromId(source)

	local distance = exports.stem_common:getDistanceToCoord(player.source, Config.Meth.MethMix.coords)
	if (distance >= 5) then
		return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:meth:mix",
			reason = "Player was too far away from meth table.",
			metadata = {
				distance = distance
			}
		})
	end

    if (not Player(player.source).state.methTimer or Player(player.source).state.methTimer + Config.Meth.MixTime > GetGameTimer()) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:meth:mix",
			reason = "Player messed with the timing system",
			metadata = {
                startTime = Player(player.source).state.methTimer,
                expectedMinTime = Player(player.source).state.methTimer + Config.Meth.MixTime,
                currentTime = GetGameTimer()
			}
		})
    end

    local missingItems = checkMissingItems(player.source, mixItems)
    if (missingItems) then return end

    for index, value in pairs(mixItems) do
        if (value ~= true) then
            player.removeInventoryItem(index, value)
        end
    end

    Player(player.source).state.methTimer = nil
    player.addInventoryItem("dhm-methmix")
end)

ESX.RegisterServerCallback("stem_drugs:meth:chemical", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)

    local missingItems = checkMissingItems(player.source, cookItems)
    if (missingItems) then return cb(false) end

    Player(player.source).state.methTimer = GetGameTimer()
    return cb(true)
end)

RegisterNetEvent("stem_drugs:meth:cook", function () 
    local player = ESX.GetPlayerFromId(source)

	local distance = exports.stem_common:getDistanceToCoord(player.source, Config.Meth.Chemical.coords)
	if (distance >= 5) then
		return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:meth:mix",
			reason = "Player was too far away from meth table.",
			metadata = {
				distance = distance
			}
		})
	end

    local cookTime = 0;
    for key, value in pairs(Config.Meth.CookTime) do
        cookTime = cookTime + value
    end

    if (not Player(player.source).state.methTimer or Player(player.source).state.methTimer + (cookTime - 2500) > GetGameTimer()) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:meth:cook",
			reason = "Player messed with the timing system",
			metadata = {
                startTime = Player(player.source).state.methTimer,
                expectedMinTime = Player(player.source).state.methTimer + cookTime,
                currentTime = GetGameTimer()
			}
		})
    end

    local missingItems = checkMissingItems(player.source, cookItems)
    if (missingItems) then return end

    for index, value in pairs(cookItems) do
        if (value ~= true) then
            player.removeInventoryItem(index, value)
        end
    end

    Player(player.source).state.methTimer = nil
    player.addInventoryItem("dhm-meth")
end)


ESX.RegisterServerCallback("stem_drugs:meth:pack", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)

    local missingItems = checkMissingItems(player.source, packItems)
    if (missingItems) then return cb(false) end

    Player(player.source).state.methTimer = GetGameTimer()
    return cb(true)
end)

RegisterNetEvent("stem_drugs:meth:pack", function () 
    local player = ESX.GetPlayerFromId(source)

	local distance = exports.stem_common:getDistanceToCoord(player.source, Config.Meth.PackageMeth.coords)
	if (distance >= 5) then
		return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:meth:pack",
			reason = "Player was too far away from meth table.",
			metadata = {
				distance = distance
			}
		})
	end

    if (not Player(player.source).state.methTimer or Player(player.source).state.methTimer + (Config.Meth.PackTime) > GetGameTimer()) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:meth:cook",
			reason = "Player messed with the timing system",
			metadata = {
                startTime = Player(player.source).state.methTimer,
                expectedMinTime = Player(player.source).state.methTimer + Config.Meth.PackTime,
                currentTime = GetGameTimer()
			}
		})
    end

    local missingItems = checkMissingItems(player.source, packItems)
    if (missingItems) then return end

    for index, value in pairs(packItems) do
        if (value ~= true) then
            player.removeInventoryItem(index, value)
        end
    end

    Player(player.source).state.methTimer = nil
    player.addInventoryItem("dhm-pmeth")
end)

RegisterNetEvent("stem_drugs:meth:steam", function () 
    TriggerClientEvent("stem_drugs:meth:steam", -1)
end)


