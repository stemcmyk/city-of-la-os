RegisterNetEvent("stem_foodchains:fetchBusinesses", function (id) 
    local businesses = fetchBusinesses()
    TriggerClientEvent("stem_foodchains:setupBusinesses", source, businesses[id])
end)

RegisterNetEvent("stem_foodchains:clientAwake", function () 
    local businesses = fetchBusinesses()

    local publicBusinesses = {}

    for key, value in pairs(businesses) do
        table.insert(publicBusinesses, {
            name = value.businessInformation.name,
            coords = value.businessInformation.coords,
            blip = value.businessInformation.blip
        })
    end

    TriggerClientEvent("stem_foodchains:setupPublic", source, publicBusinesses)
end)

function checkProcessInput(player, items) 
    local inputs = exports.stem_common:tableMap(items, function (item) 
        local inventoryItem = exports.ox_inventory:GetItem(player.source, item.name, nil, false)
        local inventoryItemBackup = player.hasItem(item.name)
        if (not inventoryItem) then
            if (not inventoryItemBackup) then return print("item missing " .. item.name) end
            return {
                label = inventoryItemBackup.label,
                total = item.amount,
                amount = item.amount,
                totalWeight = 0,
            }
        end
        return {
            label = inventoryItem.label, 
            total = item.amount, 
            amount = item.amount - inventoryItem.count, 
            totalWeight = item.amount * inventoryItem.weight
        } 
    end)

    local isMissing = false
    for key, value in pairs(inputs) do
        if (value.amount > 0) then
            player.showNotification(("You are missing **x%s** %s"):format(math.ceil(value.amount), value.label), "error")
            isMissing = true
        end
    end
    if (isMissing) then return false end

    return true
end

function checkProcessOutput(player, items)
    local totalItemsWeight = 0;
    for key, fItem in pairs(items) do
        local item = exports.ox_inventory:GetItem(player.source, fItem.name, nil, false)
        if (not item) then return print("invalid item ".. fItem.name) end
        totalItemsWeight = totalItemsWeight + item.weight
    end
    
    local inventoryLeft = player.getMaxWeight() - player.getWeight() - totalItemsWeight
    if (inventoryLeft <= 0) then
        player.showNotification("You cannot carry the output", "error") 
        return false
    end

    return true
end

function checkProcessItems(player, process) 
    if not checkProcessInput(player, process.inputItems) then return false end
    if not checkProcessOutput(player, process.outputItems) then return false end
    return true
end

local activeProcesses = {}

ESX.RegisterServerCallback("stem_foodchains:beginProcess", function (source, cb, business, process, index)
    local processOption = fetchProcess(business, process).options[index]
    local player = ESX.GetPlayerFromId(source)
    local processId = ("%s:%s"):format(business, process)

    if not processOption then 
        player.showNotification("This is not functioning", "error")
        return cb(false) 
    end

    if activeProcesses[processId] then
        player.showNotification("This is already in use", "error")
        return cb(false)
    end

    if not checkProcessItems(player, processOption) then return cb(false) end

    for key, input in pairs(processOption.inputItems) do
        if (input.amount < 1) then
            local slotId = exports.ox_inventory:GetSlotIdWithItem(player.source, input.name)
            local slot = exports.ox_inventory:GetSlot(player.source, slotId)
            local newDurability = (slot?.metadata?.durability or 100) - input.amount * 100
            exports.ox_inventory:SetDurability(player.source, slotId, newDurability)
            if newDurability <= 0 then
                exports.ox_inventory:RemoveItem(player.source, input.name, 1, nil, slot)
            end
        else
            player.removeInventoryItem(input.name, input.amount)
        end
    end

    activeProcesses[processId] = processOption
    Player(player.source).state.process = processId
    Player(player.source).state.processStart = GetGameTimer()

    cb(true)
end)

RegisterNetEvent("stem_foodchains:finishProcess", function (state) 
    local player = ESX.GetPlayerFromId(source)

    local currentProcessId = Player(player.source).state.process
    local processStart = Player(player.source).state.processStart

    Player(player.source).state.processStart = nil
    Player(player.source).state.process = nil

    if (not currentProcessId or not activeProcesses[currentProcessId]) then
        return player.showNotification("This is not functioning", "error")
    end

    local processOption = activeProcesses[currentProcessId]
    activeProcesses[currentProcessId] = false

    print(processStart, GetGameTimer())

    if (GetGameTimer() < processStart + (processOption.waitTime or 7000)) then 
        return
    end

    if (not state) then
        return player.showNotification("You cancelled the process.", "warning")
    end

    if not checkProcessOutput(player, processOption.outputItems) then return end

    for key, output in pairs(processOption.outputItems) do
        player.addInventoryItem(output.name, output.amount)
    end
end)