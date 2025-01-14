local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local DEALERSHIP_WEBHOOK = GetConvar("dealership_webhook", nil)

local licenseTypes = {
    ["boat"] = "boatinglicense",
    ["car"] = "driverlicense"
}
-- Flattening the shop list
local vehicles = flattenShopList(Config.shop)
local hashedVehicles = flattenShopList(Config.shop, true)

exports("getVehicle", function (model) 
    return vehicles[model]
end)

exports("getVehicleByHash", function (model) 
    return hashedVehicles[model]
end)

RegisterNetEvent("stem_dealership:buy_vehicle")
AddEventHandler("stem_dealership:buy_vehicle", function (model, properties, vehicleName, uclVehicle, inUcl)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local supporterAccess = Player(xPlayer.source).state.supporterAccess

    if uclVehicle then
        uclVehicle = getUCLVehicle(uclVehicle)
        if (not uclVehicle) then return xPlayer.showNotification("This vehicle does not exist anymore") end
        local currentVehicle = MySQL.single.await("SELECT owner FROM owned_vehicles WHERE plate = @plate", {
            ["@plate"] = properties.plate
        })

        if (not inUcl and not exports.stem_common:tableContains(supporterAccess, "silver")) then
            return xPlayer.showNotification("You must have **Silver** supporter to be able to purchase vehicles outside of the UCL zone")
        end

        local owner = ESX.GetPlayerFromIdentifier(currentVehicle.owner)
        if (not owner) then return xPlayer.showNotification("The owner of the vehicle isn't available at the moment.") end


        if xPlayer.getAccount('bank').money >= tonumber(uclVehicle.price) then
            xPlayer.removeAccountMoney('bank', tonumber(uclVehicle.price))
            owner.addAccountMoney('bank', tonumber(uclVehicle.price))
            TriggerClientEvent('stem_dealership:vehicle_bought', -1, uclVehicle.vehicle, xPlayer.source)
            removeUCLVehicle(uclVehicle.vehicle)

            
            MySQL.Sync.execute("UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate", {
                ['@owner'] = xPlayer.identifier,
                ["@plate"] = properties.plate
            })

            if (DEALERSHIP_WEBHOOK) then
                exports.stem_discord:getUserDiscord(owner.source, function (ownerDiscordId)
                    exports.stem_discord:getUserDiscord(xPlayer.source, function (discordId)
                        exports.stem_discord:sendThroughWebhook({
                            webhook = DEALERSHIP_WEBHOOK,
                            params = {
                                username = "Vehicle Logs",
                                embeds = {
                                    {
                                        author = {
                                            name = "Player vehicle Sale"
                                        },
                                        title = "A player has bought another player's vehicle",
                                        description = string.format("**Buyer:** %s, <@!%s> **Seller:** %s, <@!%s>", xPlayer.getName(), discordId,  owner.getName(), ownerDiscordId),
                                        fields = {
                                            {
                                                name = "Vehicle",
                                                value = string.format("**%s** %s", vehicleName, model)
                                            },
                                            {
                                                name = "Price",
                                                value = string.format("```$ %s```", exports.stem_common:formatPrice(uclVehicle.price)),
                                                inline = true,
                                            },
                                            {
                                                name = "Plate",
                                                value = string.format("```%s```", properties.plate),
                                                inline = true,
                                            },
                                            {
                                                name = "New Balance",
                                                value = string.format("```$ %s```", exports.stem_common:formatPrice(xPlayer.getAccount('bank').money)),
                                            },
                                        },
                                        color = 37,
                                        footer = {
                                            text = xPlayer.identifier,
                                        },
                                    }
                                },
                            },
                        })
                    end)
                end)
            else
                print("No dealership_webhook found")
            end
    
            TriggerClientEvent("ox_lib:notify", src, {
                type = "success",
                description = 'You have bought a **'..vehicleName..'** with the plate **'..properties.plate..'**'
            })
            TriggerClientEvent("ox_lib:notify", owner.source, {
                type = "success",
                description = 'A player has bought your **'..vehicleName..'** for **$'..ESX.Math.GroupDigits(uclVehicle.price)..'**'
            })
        
        
            return
        else
            return xPlayer.showNotification("You do not have enough money", "error")
        end
    end

    local vehicle = vehicles[model]

    if (vehicle.supporter and (not supporterAccess or not exports.stem_common:tableContains(supporterAccess, vehicle.supporter))) then
        return xPlayer.showNotification(("You are not a **%s** supporter"):format((vehicle.supporter:gsub("^%l", string.upper))))
    end

    if (not licenseTypes[vehicle.type]) then 
        return print("invalid license type ", vehicle.type)
    end

    if (xPlayer.getInventoryItem(licenseTypes[vehicle.type]).count <= 0) then
        TriggerClientEvent("ox_lib:notify", src, {
            type = "error",
            description = "You must have a valid license on you to purchase a vehicle"
        })
        return
    end 

    if xPlayer.getAccount('bank').money >= tonumber(vehicle.price) then
        xPlayer.removeAccountMoney('bank', tonumber(vehicle.price))
        local plate = generateUniquePlate()
        
        properties.plate = plate
        properties.model = GetHashKey(model)

        MySQL.Sync.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename, model, stored, type) VALUES (@owner, @plate, @vehicle, @vehiclename, @model, @stored, @type)", {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = tostring(plate),
            ['@vehicle'] = json.encode(properties),
            ['@vehiclename'] = vehicleName,
            ["@model"] = model,
            ["@stored"] = "0",
            ["@type"] = vehicle.type or "car"
        })
        
        TriggerClientEvent('stem_dealership:spawn_vehicle', src, model, plate, properties)

        if (DEALERSHIP_WEBHOOK) then
            exports.stem_discord:getUserDiscord(xPlayer.source, function (discordId)
                exports.stem_discord:sendThroughWebhook({
                    webhook = DEALERSHIP_WEBHOOK,
                    params = {
                        username = "Vehicle Logs",
                        embeds = {
                            {
                                author = {
                                    name = "Vehicle Purchase"
                                },
                                title = "A player has bought a vehicle",
                                description = string.format("**Player:** %s, <@%s>", xPlayer.getName(), discordId),
                                fields = {
                                    {
                                        name = "Vehicle",
                                        value = string.format("**%s** %s", vehicleName, model)
                                    },
                                    {
                                        name = "Price",
                                        value = string.format("```$ %s```", exports.stem_common:formatPrice(vehicle.price)),
                                        inline = true,
                                    },
                                    {
                                        name = "Plate",
                                        value = string.format("```%s```", plate),
                                        inline = true,
                                    },
                                    {
                                        name = "New Balance",
                                        value = string.format("```$ %s```", exports.stem_common:formatPrice(xPlayer.getAccount('bank').money)),
                                    },
                                },
                                color = 37,
                                footer = {
                                    text = xPlayer.identifier,
                                },
                            }
                        },
                    },
                })
            end)
        else
            print("No dealership_webhook found")
        end

        TriggerClientEvent("ox_lib:notify", src, {
            type = "success",
            description = 'You have bought **'..model..'** with the plate **'..plate..'**'
        })
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "error",
            description = "You do not have enough money for this vehicle"
        })
    end
end)


function getLetterAtPosition(string, pos)
    return string:sub(pos, pos)
end

function generatePlate()
    local letters = getLetterAtPosition(alphabet,math.random(1, 27)) .. getLetterAtPosition(alphabet,math.random(1, 27))  .. getLetterAtPosition(alphabet,math.random(1,27)) 
    local numbers = math.random(1, 9) .. math.random(1, 9) .. math.random(1, 9)
    return letters .. " " .. numbers
end

function generateUniquePlate()
     local plate = generatePlate()
     local response = MySQL.query.await("SELECT plate FROM owned_vehicles WHERE plate = ?", {plate})
     if #response ~= 0 then return generateUniquePlate() end
     return plate
end

local bucketInstances = {}

function assignABucketToPlayer(source)
    local bucketId = #bucketInstances + 1

    -- print(string.format("Creating bucket %s for %s (%s)", bucketId, GetPlayerName(source), source))

    bucketInstances[bucketId] = source

    SetPlayerRoutingBucket(
        source, 
        bucketId
    )
    SetRoutingBucketPopulationEnabled(bucketId, false)
end

function returnPlayerToMainBucket(source)
    local bucketId = GetPlayerRoutingBucket(source)
    -- print(string.format("Deactivating bucket %s", bucketId))

    bucketInstances[bucketId] = nil;

    SetPlayerRoutingBucket(source, 0)
end

ESX.RegisterServerCallback("stem_dealership:assignBucket", function (source, cb) 
    assignABucketToPlayer(source)
    cb(true)
end)


ESX.RegisterServerCallback("stem_dealership:clearBucket", function (source, cb)   
    returnPlayerToMainBucket(source)
    cb(true)
end)

AddEventHandler("onResourceStop", function (resourceName) 
    for index, source in ipairs(bucketInstances) do
        returnPlayerToMainBucket(source) 
    end
end)


local freeCar = "smgt5"

ESX.RegisterCommand("getFreeCar", "user", function (player) 
    if (GetConvar("environment") ~= "production") then
        MySQL.Async.fetchAll("SELECT COUNT(*) FROM owned_vehicles WHERE owner = @identifier", {
            ["@identifier"] = player.identifier
        }, function (result) 
            if (result[1]["COUNT(*)"] >= 1) then
                return player.showNotification("This offer is only available to people with no vehicles! Sorry :/", "error")
            end

            local plate = generateUniquePlate()
            ESX.TriggerClientCallback(player.source, "stem-dealership:spawnTemporaryCar", function(netId, esxProperties, properties, name)

                esxProperties.plate = plate
            
                MySQL.Sync.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename, model, stored) VALUES (@owner, @plate, @vehicle, @vehiclename, @model, @stored)", {
                    ['@owner'] = player.identifier,
                    ['@plate'] = tostring(plate),
                    ['@vehicle'] = json.encode(esxProperties),
                    ['@vehiclename'] = freeCar,
                    ["@model"] = freeCar,
                    ["@stored"] = "1"
                })
                TriggerEvent("lunar_garage:saveVehicle", properties, netId)


                exports.stem_discord:getUserDiscord(player.source, function (discordId)
                    exports.stem_discord:sendMessage({
                        channelId = "1229804464781656165", 
                        embeds = {
                            {
                                author = {
                                    name = "Free Vehicle Claim"
                                },
                                title = "A player has claimed a free vehicle",
                                description = string.format("**Player:** %s, <@!%s>", player.getName(), discordId),
                                fields = {
                                    {
                                        name = "Vehicle",
                                        value = string.format("**%s** %s", name, freeCar)
                                    },
                                    {
                                        name = "Plate",
                                        value = string.format("```%s```", plate),
                                        inline = true,
                                    }
                                },
                                color = 37,
                                footer = {
                                    text = player.identifier,
                                },
                            }
                        },
                        addTimestamp = true,
                    })
                end)

                TriggerClientEvent("ox_lib:notify", player.source, {
                    type = "success",
                    description = 'You have been given a free **'..name..'** with the plate **'..plate..'**'
                })
            end, freeCar, plate)
        end)
    end 
end, false, {
    help = "Get a free car!"
})