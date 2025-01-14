houses = {}
loaded = promise.new()
local PUBLIC_HOUSING_REQUEST_WEBHOOK = GetConvar("public_housing_request_webhook", nil)
local ADMIN_HOUSING_REQUEST_WEBHOOK = GetConvar("admin_housing_request_webhook", nil)


-- Load ESX & DB
CreateThread(function()
    while MySQL == nil or ESX == nil do
        Wait(0)
    end
    LoadDatabase()
end)

LoadDatabase = function()
    local house_data = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM housing_data')
    if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
        print('Loaded ' .. #result .. ' houses from the database.')
    end
    for k,v in pairs(result) do
        houses[v.id] = CreateHouse(result[k])
    end
    loaded:resolve()
end

ESX.RegisterCommand("refreshHousing", {"admin"}, function (player) 
    LoadDatabase()
    SetTimeout(2000, function () 
        TriggerClientEvent("esx_housing:receiveData", -1, houses)
    end)
end, true)

FlashDatabase = function()
    if not restart then
        for k,v in pairs(houses) do
            if houses[v.id].updateDB == true then
                if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
                    print('Flashing house ID ' .. houses[v.id].id .. ' to database.')
                end
                -- Query
                MySQL.Sync.execute('UPDATE `housing_data` SET `data`=@data, `owner`=@owner, `keys`=@keys,`storage`=@storage,`extra_data`=@extra_data WHERE id=@id', {
                    ['@id'] = json.encode(houses[v.id].id),
                    ['@data'] = json.encode(houses[v.id].data),
                    ['@owner'] = json.encode(houses[v.id].owner),
                    ['@keys'] = json.encode(houses[v.id].keys),
                    ['@storage'] = json.encode(houses[v.id].storage),
                    ['@extra_data'] = json.encode(houses[v.id].extradata),
                })
                houses[v.id].updateDB = false
                if (houses[v.id].synced and houses[v.id].synced.resolve) then
                    houses[v.id].synced:resolve()
                end
            end
        end
    end
end

RegisterNetEvent("esx_housing:setGarage", function(houseId) 
    local player = ESX.GetPlayerFromId(source)
    local position = GetEntityCoords(GetPlayerPed(player.source))
    local heading = GetEntityHeading(GetPlayerPed(player.source))

    local players = houses[houseId].keys or {}
    table.insert(players, player.identifier)

    exports.lunar_garage:registerExternalGarages(
        {{
            id = "ext_garage_"..houseId,
            distance = 2,
            Visible = true,
            Type = 'car',
            Position = position,
            house = true,
            PedPosition = vector4(215.4677, -808.5453, 30.7597, 248.1795),
            SpawnPosition = vector4(position.x, position.y, position.z, heading),
            Users = players,
            Model = `s_m_m_armoured_01`
        }}
    )
    
    houses[houseId].data.garage_location = json.encode(vector4(position.x, position.y, position.z, heading))
    houses[houseId].updateDB = true
end)

-- Callbacks
ESX.RegisterServerCallback('esx_housing:ReceiveData', function(source, cb)
    Citizen.Await(loaded)
    
    cb(houses)
end)

ESX.RegisterServerCallback('esx_housing:ResetKeys', function(source,cb, house)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    if xPlayer.getIdentifier() == houses[house].owner then
        if xPlayer.getAccount('bank').money >= tonumber(Config.KeyResetPrice) then
            xPlayer.removeAccountMoney('bank', tonumber(Config.KeyResetPrice))
            houses[house].keys = {}
            houses[house].updateDB = true
            TriggerClientEvent('esx_housing:Sync', -1, houses[house])
            return cb(true)
        else
            return cb(false)
        end
    end
end)

ESX.RegisterServerCallback('esx_housing:SellHouse', function(source, cb, house)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    print(houses[house].owner, xPlayer.getIdentifier())
    if houses[house].owner == xPlayer.getIdentifier() then
        -- Kick instanced players from house
        houses[house].getInstancedMembers(function(license)
            local xPlayer = ESX.GetPlayerFromIdentifier(license)
            SetPlayerRoutingBucket(xPlayer.source, 0)
            if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
                print('Player ID: ' .. xSource .. ' is getting into dimension ' .. 0)

            end
            xPlayer.triggerEvent('esx_housing:leaveHouse')
        end, 'license')
        houses[house].reset()
        TriggerClientEvent('esx_housing:Sync', -1, houses[house])
        return cb(true)
    end
end)

ESX.RegisterServerCallback('esx_housing:BuyHouse', function(source, cb, house)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    if not houses[house].owner or houses[house].owner == ('' or "") then
        if xPlayer.getAccount('bank').money >= tonumber(houses[house].data.price) then
            xPlayer.removeAccountMoney('bank', tonumber(houses[house].data.price))
            houses[house].owner = xPlayer.getIdentifier()
            houses[house].extradata.lastTimestamp = os.time()
            houses[house].updateDB = true
            exports.ox_inventory:RegisterStash("playerhouse-" .. houses[house].id, "House Inventory", 250, 1000000, json.encode(houses[house].owner))
            
            TriggerClientEvent('esx_housing:Sync', -1, houses[house])
            return cb(true)
        end
    end
    return cb(false)
end)

ESX.RegisterServerCallback('esx_housing:GetInvites', function(source, cb, houseId)
    cb(houses[houseId].getPendingInvites())
end)

ESX.RegisterServerCallback('esx_housing:GetUserInventory', function(source, cb)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local inventory = xPlayer.getInventory()
    local money = xPlayer.getAccounts()
    local loadout = xPlayer.getLoadout()
    return cb(inventory, money, loadout)
end)

ESX.RegisterServerCallback('esx_housing:GetStorage', function(source, cb, houseId)
    local xSource = source
    storage = houses[houseId].storage
    elements = {}

    if storage['account'] then
        for k,v in pairs(storage['account']) do
            table.insert(elements, {item = v.name, label = v.item .. ' - '.. v.count..'$' , type = 'account', quantity = v.count, name = v.name})
        end
    end

    if storage['item'] then
        for k,v in pairs(storage['item']) do
            if v.count >= 1 then
                table.insert(elements, {item = v.name,  label = v.item .. ' - x' ..v.count, type = 'item', quantity = v.count, name = v.name})
            end
        end
    end

    if storage['weapon'] then
        for k,v in pairs(storage['weapon']) do
            table.insert(elements, {item = v.name, label = v.item .. ' - ' .. v.count .. Locales[Config.Locale]['bullets'], type = 'weapon', quantity = v.count, name = v.name})
        end
    end

    return cb(elements)
end)

ESX.RegisterServerCallback('esx_housing:createHouseMenu', function(source, cb)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local privilege = xPlayer.getGroup()
    return cb(privilege)
end)

ESX.RegisterServerCallback('esx_housing:NewHouse', function(source, cb, data)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local privilege = xPlayer.getGroup()
    if privilege == "mod" or privilege == "admin" or privilege == "superadmin" then
        if data["house_price"] and data["door_coords"] and data["interior_type"] then
            data = CreateNewHouse(data)
            cb(data)
        end
    end
end)

CreateNewHouse = function(data_rcv)
    data2 = {
        data = {
            door = data_rcv["door_coords"],
            price = data_rcv["house_price"],
            prop = data_rcv["interior_type"],
        },
        keys = {},
        storage = {},
        extradata = {},
        owner = data_rcv["owner"] or '',
    }
    if (data_rcv["interior_position"]) then
        data2.data.interior_position = data_rcv["interior_position"]
    end
    if (data_rcv["storage_position"]) then
        data2.data.storage_position = data_rcv["storage_position"]
    end

    MySQL.Sync.execute('INSERT INTO housing_data (data, owner) VALUES (@data, @owner)', {
        ['@data'] = json.encode(data2.data),
        ["@owner"] = data_rcv["owner"]
    })

    local result = MySQL.Sync.fetchAll("SELECT * FROM housing_data WHERE id=(SELECT max(id) FROM housing_data)")
    houses[result[1].id] = CreateHouse(result[1])
    if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
        print("A new house has been created ID " .. houses[result[1].id].id)
    end
    TriggerClientEvent("esx_housing:Sync", -1, houses[result[1].id])
    return houses[result[1].id]
end

-- Register Events
RegisterNetEvent('esx_housing:addItem', function(type, name, count, item, houseId)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local identifier = xPlayer.getIdentifier()
    if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
        print('Player ID: ' .. xSource .. ' is inserting item ' .. name .. ' x' .. count .. ' into house ' .. houses[houseId].id)
    end

    if houses[houseId].isInstanced(identifier) then
        -- houses[houseId].addItem(type, name, count, item)
        houses[houseId].addItem(function(result)
            if result then
                RemovePlayerItem(xSource, type, name, item, count)
            end
        end, type, name, count, item)
        houses[houseId].updateDB = true
    end

end)

RegisterNetEvent('esx_housing:removeItem', function(type, name, count, item, houseId)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local identifier = xPlayer.getIdentifier()
    if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
        print('Player ID: ' .. xSource .. ' is removing item ' .. name .. ' x' .. count .. ' into house ' .. houses[houseId].id)
    end
    if houses[houseId].isInstanced(identifier) then
        -- Add check count if
        if type == 'weapon' then
            if xPlayer.hasWeapon(name) then
                TriggerClientEvent('esx:showNotification', xSource, Locales[Config.Locale]['already_has_weapon'])
                return
            end
        end
        houses[houseId].removeItem(function(result)
            if result then
                AddPlayerItem(xSource, type, name, item, count)
            end

        end, type, name, count, item)
        houses[houseId].updateDB = true
    end

end)

AddPlayerItem = function(source, type, name, item, count)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    if type == 'account' then
        xPlayer.addAccountMoney(name, count)
    elseif type == 'item' then
        xPlayer.addInventoryItem(name, count)
    elseif type == 'weapon' then
        xPlayer.addWeapon(name, count)
    end
    Notification(xSource, 'withdraw', item, count)

end

RemovePlayerItem = function(source, type, name, item, count)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    if type == 'account' then
        xPlayer.removeAccountMoney(name, count)
    elseif type == 'item' then
        xPlayer.removeInventoryItem(name, count)
    elseif type == 'weapon' then
        xPlayer.removeWeapon(name)
    end
    Notification(xSource, 'deposit', item, count)
end

Notification = function(source, action, name, count)
    if action == 'deposit' then
        TriggerClientEvent('esx:showNotification', source, Locales[Config.Locale]['deposit_success'] .. name .. ' x' .. count)
    else
        TriggerClientEvent('esx:showNotification', source, Locales[Config.Locale]['withdraw_success'] .. name .. ' x' .. count)
    end
end

RegisterNetEvent('esx_housing:addKeys', function(house, id)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local identifier = xPlayer.getIdentifier()
    if houses[house].owner == identifier then
        if xPlayer.getAccount('bank').money >= tonumber(Config.KeyCreationPrice) then
            xPlayer.removeAccountMoney('bank', tonumber(Config.KeyCreationPrice))
            -- if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
            --     print('Giving keys to player ' .. id .. ' on house ' .. house.id)
            -- end
            local zPlayer = ESX.GetPlayerFromId(id)
            local zIdentifier = zPlayer.getIdentifier()
            houses[house].addKeys(zIdentifier)
        end
        TriggerClientEvent('esx_housing:Sync', -1, houses[house])
    end
end)

RegisterNetEvent('esx_housing:playerEnterHouse', function(houseId)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    houses[houseId].addInstancedMember(xPlayer.getIdentifier())
    houses[houseId].extradata.lastTimestamp = os.time()
    if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
        print('Player ID: ' .. xSource .. ' is getting into dimension ' .. houses[houseId].id)
    end
    if (houses[houseId].data.prop ~= "interior") then
        SetPlayerRoutingBucket(xSource, tonumber(houses[houseId].id))
        SetRoutingBucketPopulationEnabled(tonumber(houses[houseId].id), false)
    end
end)

RegisterNetEvent('esx_housing:playerExitHouse', function(houseId)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    houses[houseId].removeInstancedMember(xPlayer.getIdentifier())
    if Config.Debug and (Config.DebugLevel == 0 or Config.DebugLevel == 2) then
        print('Player ID: ' .. xSource .. ' is getting into dimension ' .. 0)
    end
    SetPlayerRoutingBucket(xSource, 0)
end)

RegisterNetEvent('esx_housing:AcceptInvite', function(houseId, playerId)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    if houses[houseId].owner == xPlayer.getIdentifier() then
        houses[houseId].acceptInvite(playerId)
    end
end)

local lastRang = {}
RegisterNetEvent('esx_housing:Ring', function(houseId)
    local xSource = source

    if (lastRang[xSource] and lastRang[xSource] < GetGameTimer() + 10 * 1000) then
        return TriggerClientEvent("esx:showNotification", xSource, "Stop ringing my doorbell so fast")
    end
    lastRang[xSource] = GetGameTimer()
 
    local house = houses[houseId]
    if house then
        house.addInvite(xSource)
        house.getInstancedMembers(function(license)
            local xPlayer = ESX.GetPlayerFromIdentifier(license)
            if (not xPlayer) then return end;
            xPlayer.triggerEvent('esx_housing:Ring', xSource)
        end, 'license')
    else
        error('Failed to ring house with ID:' .. houseId)
    end
end)

-- Thread to Sync Changes
CreateThread(function()
    Citizen.Await(loaded)
    while true do
        FlashDatabase()
        Wait(Config.DBSyncInterval * 60 * 1000)
    end
end)

-- House removal thread on start
CreateThread(function()
    Citizen.Await(loaded)
    if Config.HouseRemoval then
        for k,v in pairs(houses) do
            if (Config.HouseRemovalTypes[v.data.prop]) then 
                maxTime = os.time() + (Config.HouseRemovalTypes[v.data.prop].maxTime * 3600)
                if type(v.extradata.lastTimestamp) == 'number' then
                    if v.extradata.lastTimestamp >= maxTime then
                        houses[house].reset()
                    end
                end
            end
        end
    end
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if eventData.secondsRemaining == 60 then
		CreateThread(function()
			Wait(35000)
			FlashDatabase()
            restart = true
		end)
	end
end)

ESX.RegisterCommand("requesthouse", {"user", "admin"}, function (player) 
    local supporterAccess = Player(player.source).state.supporterAccess
    if (not exports.stem_common:tableContains(supporterAccess, "gold")) then return end
    local existingRequest = MySQL.single.await("SELECT * FROM stem_housingrequests WHERE identifier = @identifier AND NOT status = 2", {
        ["@identifier"] = player.identifier
    })
    if (existingRequest) then return player.showNotification("You already have a housing request") end
    
    local coords = GetEntityCoords(GetPlayerPed(player.source))
    coords = vector3(coords.x, coords.y, coords.z)
    local housingRequest = MySQL.insert.await("INSERT INTO stem_housingrequests (identifier, coords) VALUES (?, ?)", {
        player.identifier, json.encode(coords)
    })
    
    if (ADMIN_HOUSING_REQUEST_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = ADMIN_HOUSING_REQUEST_WEBHOOK,
                params = {
                    username = "New Housing Request",
                    content = ("New Housing Request From <@%s> | Housing Request ID: **%s**"):format(playerDiscord, housingRequest)
                },
                ignoreEnv = true
            })
        end)
    else
        print("No admin_housing_request_webhook found")
    end

    player.showNotification(("Housing request created with id: %s"):format(housingRequest))
end, false, {{help = 'Request a house location or a new house location'}})

ESX.RegisterCommand("viewhousingrequest", {"user", "admin"}, function (player, args) 
    local existingRequest = MySQL.single.await("SELECT * FROM stem_housingrequests WHERE id = @id AND NOT status = 2", {
        ["@id"] = args.id,
    })
    if (not existingRequest) then return print("invalid housing request") end
    if (not Player(player.source).state.isStaff) then return player.showNotification("You do not have the permissions for this") end
    
    Player(player.source).state.currentlyViewingHousingReuest = existingRequest
    TriggerClientEvent("esx_housing:viewHousingRequest", player.source, existingRequest)
end, false, {
    help = "View a housing request",
    validate = true,
    arguments = {
        { name = 'id', help = 'Id', type = 'number' },
    }
})

ESX.RegisterServerCallback("esx_housing:getHouses", function (source, cb)
    local request = (Player(source).state.currentlyViewingHousingReuest)
    if (not request) then return end

    local houses = MySQL.query.await(("SELECT * FROM housing_data WHERE owner LIKE '%"..request.identifier.."%'"), {
        ["@identifier"] = request.identifier
    })

    return cb(exports.stem_common:tableMap(houses, function (house) 
        house.data = json.decode(house.data)
        return house
    end))
end)

RegisterNetEvent("esx_housing:housingStatus", function (status, data) 
    local player = ESX.GetPlayerFromId(source)
    local request = (Player(player.source).state.currentlyViewingHousingReuest)
    if (not request) then return print("invalid request") end
    
    local result = MySQL.single.await("SELECT job, firstname, lastname, last_seen, discord_ids FROM users WHERE identifier = @player", {
        ["@player"] = request.identifier
    })

    if (not result) then return print ("invalid player") end

    local discordPings = ""
    if (result.discord_ids) then
        for key, value in pairs(json.decode(result.discord_ids)) do
            discordPings = discordPings .. ("<@%s>"):format(value)
        end
    end

    if (status) then
        CreateNewHouse({
            door_coords = json.decode(request.coords),
            house_price = 0,
            interior_type = data,
            owner = '"'..request.identifier..'"'
        })
        MySQL.query.await("DELETE FROM stem_housingrequests WHERE id = @id", {["@id"] = request.id})

        TriggerClientEvent("esx_housing:hidehousingrequest", player.source)
        LoadDatabase()
        TriggerClientEvent("esx_housing:receiveData", -1, houses)

        if (ADMIN_HOUSING_REQUEST_WEBHOOK) then
            exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
                exports.stem_discord:sendThroughWebhook({
                    webhook = ADMIN_HOUSING_REQUEST_WEBHOOK,
                    params = {
                        username = "New Housing Request",
                        content = ("<@%s> Approved housing request **%s** from %s and set interior to ``%s``"):format(playerDiscord, request.id, discordPings, data)
                    },
                    ignoreEnv = true
                })
            end)
        else
            print("No admin_housing_request_webhook found")
        end
        if (PUBLIC_HOUSING_REQUEST_WEBHOOK) then
            exports.stem_discord:sendThroughWebhook({
                webhook = PUBLIC_HOUSING_REQUEST_WEBHOOK,
                params = {
                    username = "New Housing Request",
                    content = ("%s Your housing request has been approved"):format(discordPings)
                },
                ignoreEnv = true
            })
        else
            print("No public_housing_request_webhook found")
        end
    else
        MySQL.query.await("DELETE FROM stem_housingrequests WHERE id = @id", {["@id"] = request.id})
        
        TriggerClientEvent("esx_housing:hidehousingrequest", player.source)

        if (ADMIN_HOUSING_REQUEST_WEBHOOK) then
            exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
                exports.stem_discord:sendThroughWebhook({
                    webhook = ADMIN_HOUSING_REQUEST_WEBHOOK,
                    params = {
                        username = "New Housing Request",
                        content = ("<@%s> Declined housing request **%s** from %s because ``%s``"):format(playerDiscord, request.id, discordPings, data)
                    },
                    ignoreEnv = true
                })
            end)
        else
            print("No admin_housing_request_webhook found")
        end
        if (PUBLIC_HOUSING_REQUEST_WEBHOOK) then
            exports.stem_discord:sendThroughWebhook({
                webhook = PUBLIC_HOUSING_REQUEST_WEBHOOK,
                params = {
                    username = "New Housing Request",
                    content = ("%s Your housing request has been disapproved for the reason ``%s``. Please fly back in and select a more suitable spot"):format(discordPings, data)
                },
                ignoreEnv = true
            })
        else
            print("No public_housing_request_webhook found")
        end
    end
end)

RegisterNetEvent("esx_housing:replaceHouse", function (id) 
    local player = ESX.GetPlayerFromId(source)

    local request = (Player(player.source).state.currentlyViewingHousingReuest)
    if (not request) then return end
    
    local house = MySQL.single.await(("SELECT * FROM housing_data WHERE owner LIKE '%"..request.identifier.."%' and id = @id"), {
        ["@identifier"] = request.identifier,
        ["@id"] = id
    })
    if (not house) then return player.showNotification("Invalid house") end
    house.data = json.decode(house.data)
    house.data.door = json.decode(request.coords)
    house.data.garage_location = nil

    
    local result = MySQL.single.await("SELECT job, firstname, lastname, last_seen, discord_ids FROM users WHERE identifier = @player", {
        ["@player"] = request.identifier
    })

    if (not result) then return print ("invalid player") end

    local discordPings = ""
    if (result.discord_ids) then
        for key, value in pairs(json.decode(result.discord_ids)) do
            discordPings = discordPings .. ("<@%s>"):format(value)
        end
    end

    
    if (ADMIN_HOUSING_REQUEST_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = ADMIN_HOUSING_REQUEST_WEBHOOK,
                params = {
                    username = "New Housing Request",
                    content = ("Housing request relocation approved | Housing Request ID: **%s**"):format(request.id)
                },
                ignoreEnv = true
            })
        end)
    else
        print("No admin_housing_request_webhook found")
    end
    if (PUBLIC_HOUSING_REQUEST_WEBHOOK) then
        exports.stem_discord:sendThroughWebhook({
            webhook = PUBLIC_HOUSING_REQUEST_WEBHOOK,
            params = {
                username = "New Housing Request",
                content = ("%s Your housing relocation has been approved"):format(discordPings)
            },
            ignoreEnv = true
        })
    else
        print("No public_housing_request_webhook found")
    end

    local transactions = {
        {
            query = "DELETE FROM stem_housingrequests WHERE id = @id",
            parameters = {
                ["@id"] = request.id
            },
        }, 
        {
            query = "UPDATE housing_data SET data = @data WHERE id = @id", 
            parameters = {
                ["@data"] = json.encode(house.data),
                ["@id"] = id
            }
        }
    }

    TriggerClientEvent("esx_housing:hidehousingrequest", player.source)
    MySQL.transaction(transactions)
    LoadDatabase()
    TriggerClientEvent("esx_housing:receiveData", -1, houses)
end)