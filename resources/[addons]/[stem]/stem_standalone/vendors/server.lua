local vendorsData = {}
local itemsByItemName = {}
local VENDOR_LOGS_WEBHOOK = GetConvar("vendor_logs_webhook", nil)

for k, v in pairs(Config_vendors.vendors) do
    vendorsData[v.id] = {
        data = v,
        items = exports.stem_common:tableMap(v.items, function (item)
            item.price = exports.stem_common:fluctuatePrice(item.price, math.ceil(item.price * 0.50))
            itemsByItemName[item.itemName] = item
            return item
        end),
        coords = v.coords
    }
end

function getAvailableItems (source, vendor) 
    local player = ESX.GetPlayerFromId(source)
    if (not vendorsData[vendor]) then return nil end
    local availableItems = exports.stem_common:tableFilter(exports.stem_common:tableMap(vendorsData[vendor].items, function (item)
        local invItem = player.hasItem(item.itemName)
        if (not invItem) then return print ("item missing "..item.itemName) end
        item.label = invItem.label
        if (item.type == "buy") then return item end
        if (invItem.count >= 1) then 
            item.count = invItem.count
            return item
         end
        return false
    end))
    return availableItems
end 

ESX.RegisterServerCallback("stem_standalone:vendors:getItems", function (source, cb, vendor) 
    local availableItems = getAvailableItems(source, vendor)
    if (not availableItems) then return cb(nil) end
    return cb(availableItems, vendorsData[vendor].data)
end)

ESX.RegisterServerCallback("stem_standalone:vendors:sellItem", function (source, cb, vendor, itemName, count, location) 
    local player = ESX.GetPlayerFromId(source)
    local item = player.hasItem(itemName)
    if (item.count < count) then
        return player.showNotification("You don't have enough items for this sale", "error")
    end
    local vendorItem = itemsByItemName[itemName]
    if (not vendorItem.price) then
        return player.showNotification("This item cannot be sold here", "error")
    end
    local coords = location and vendorsData[vendor].coords[location] or vendorsData[vendor].coords  
    local distance = exports.stem_common:getDistanceToCoord(source, coords)
    if (distance > 10) then
        return exports.stem_discord:sendMessage({
            channelId = "1238450348545413242",
            content = string.format("Player ``%s | %s (%s)`` sell an item in the vendor from way to far away, current: **%s** max: **%s**", player.source, GetPlayerName(player.source), player.identifier, distance, 10)
        })
    end

    local totalSalePrice = vendorItem.price * count
    player.removeInventoryItem(itemName, count)
    player.addAccountMoney("bank", totalSalePrice)

    player.showNotification(string.format("We've deposited **$%s** to your bank for the sale of **%sx %s**", ESX.Math.GroupDigits(totalSalePrice), count, item.label))


    if (VENDOR_LOGS_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = VENDOR_LOGS_WEBHOOK,
                params = {
                    username = "Vendor Logs",
                    content = ([[
                        <@%s> ``%s`` **%s** sold **%sx %s** for **$%s**
                    ]]):format(
                        playerDiscord, player.identifier, player.name, ESX.Math.GroupDigits(count), itemName, ESX.Math.GroupDigits(count)
                    ),
                },
                ignoreEnv = true,
            })
        end)
    else
        print("No vendor_logs_webhook found")
    end

    local availableItems = getAvailableItems(source, vendor)
    if (#availableItems > 0) then
        return cb(true)
    end

    
    return cb(false)
end)


ESX.RegisterServerCallback("stem_standalone:vendors:purchaseItem", function (source, cb, vendor, itemName, count) 
    local player = ESX.GetPlayerFromId(source)

    local item = player.hasItem(itemName)
    local vendorItem = itemsByItemName[itemName]
    if (not vendorItem?.price) then
        return player.showNotification("This item cannot be purchased here", "error")
    end
    
    local distance = exports.stem_common:getDistanceToCoord(source, vendorsData[vendor].coords)
    if (distance > 10) then
        return exports.stem_discord:sendMessage({
            channelId = "1238450348545413242",
            content = string.format("Player ``%s | %s (%s)`` sell an item in the vendor from way to far away, current: **%s** max: **%s**", player.source, GetPlayerName(player.source), player.identifier, distance, 10)
        })
    end

    if (not player.canCarryItem(itemName, count)) then
        cb(true)
        return player.showNotification("You do not have enough space for this")
    end

    if (player.getAccount("bank").money < count) then
        cb(true)
        return player.showNotification("You do not have enough money for this")
    end
    
    local totalSalePrice = vendorItem.price * count
    player.addInventoryItem(itemName, count)
    player.removeAccountMoney("bank", totalSalePrice)

    player.showNotification(string.format("You have paid **$%s** for x%s **%s**", ESX.Math.GroupDigits(totalSalePrice), item.label, count))

    
    if (VENDOR_LOGS_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = VENDOR_LOGS_WEBHOOK,
                params = {
                    username = "Vendor Logs",
                    content = ([[
                        <@%s> ``%s`` **%s** purchased **%sx %s** for **$%s**
                    ]]):format(
                        playerDiscord, player.identifier, player.name, ESX.Math.GroupDigits(count), itemName, ESX.Math.GroupDigits(count)
                    ),
                },
                ignoreEnv = true,
            })
        end)
    else
        print("No vendor_logs_webhook found")
    end

    local availableItems = getAvailableItems(source, vendor)
    if (#availableItems > 0) then
        return cb(true)
    end
    return cb(false)
end)

