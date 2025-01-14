if (not GlobalState.docket) then GlobalState.docket = {} end

local COURT_WEBHOOK = GetConvar("court_webhook", nil)
local CIVIL_WEBHOOK = GetConvar("civil_webhook", nil)

function removeFromDocket(player) 
    local docket = exports.stem_common:tableFilter(exports.stem_common:tableMap(GlobalState.docket, function (docketItem)
        if (docketItem.playerId == player) then return false end
        return docketItem
    end))
    GlobalState.docket = docket
end

ESX.RegisterServerCallback("stem_doj:fetchDocket", function (source, cb)
    local player = ESX.GetPlayerFromId(source)
    if (player.job.name ~= "doj") then
        return
    end
    return cb(exports.stem_common:tableMap(GlobalState.docket, function (docketItem)
        docketItem.time = os.date('%H:%M', docketItem.time)
        return docketItem
    end))
end)
ESX.RegisterServerCallback("stem_doj:getNearbyPlayers", function (source, cb, players)
    local player = ESX.GetPlayerFromId(source)
    if (player.job.name ~= "doj") then
        return
    end
    return cb(exports.stem_common:tableMap(players, function (player) 
        local player = ESX.GetPlayerFromId(player)
        return {
            playerName = player.name,
            playerId = player.source,
        }
    end))
end)

ESX.RegisterServerCallback("stem_doj:dismissCharge", function(source, cb, id)  
    local player = ESX.GetPlayerFromId(source)
    local charge = MySQL.single.await("SELECT * FROM criminal_billing WHERE id = @id", {
        ["@id"] = id
    })
    print(charge.amount)
    if (not charge) then
        return player.showNotification("This charge doesn't exist")
    end
    local target = ESX.GetPlayerFromIdentifier(charge.identifier)
    if (not target) then
        return player.showNotification("This player isn't online")
    end
    
    local result = MySQL.query.await([[DELETE FROM criminal_billing WHERE id = @id]], { ["@id"] = id})
    if (not result) then return player.showNotification("Unable to remove charge") end
    
    target.showNotification(("You were cleared of charge **%s**"):format(charge.label))

    
    if (COURT_WEBHOOK) then
        exports.stem_discord:sendThroughWebhook({
            webhook = COURT_WEBHOOK,
            params = {
                username = "Court Activity",
                content = ("``%s`` **%s** dismissed **%s** - #%s ``%s``"):format(player.job.grade_label, player.name, target.name, id, charge.label),
            },
            ignoreEnv = true,
        })
    else
        print("No court_webhook found")
    end

    return cb(result)
end)

ESX.RegisterServerCallback("stem_doj:findGuilty", function(source, cb, id)  
    local player = ESX.GetPlayerFromId(source)
    local charge = MySQL.single.await("SELECT * FROM criminal_billing WHERE id = @id", {
        ["@id"] = id
    })
    if (not charge) then
        return player.showNotification("This charge doesn't exist", "error")
    end
    local target = ESX.GetPlayerFromIdentifier(charge.identifier)
    if (not target) then
        return player.showNotification("This player isn't online", "error")
    end

    if (target.getAccount("bank").money < charge.amount) then 
        return player.showNotification("This person does not have enough money to pay this charge", "error")
    end
    
    target.removeAccountMoney("bank", charge.amount)
    exports["stem_gangsystem"]:addToPlayerStatistics(target.identifier, {
        fines_paid = charge.amount,
    })
    
    local result = MySQL.query.await([[
        UPDATE criminal_billing 
        SET 
            plea_entered = @plea_entered, 
            plea_entered_date = @plea_entered_date, 
            expunge_date = @expunge_date
        WHERE 
            identifier = @identifier 
            AND 
            id = @id
        ]], 
        {
            ["@plea_entered"] = 3,
            ["@plea_entered_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time()),
            ["@expunge_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time() + 60 * 60 * 24 * 7),
            ["@identifier"] = target.identifier,
            ["@id"] = id
        }
    )
    if (not result) then return player.showNotification("Unable to charge person") end

    target.showNotification(("You were charged with **%s** with a **$%s** fine"):format(charge.label, ESX.Math.GroupDigits(charge.amount)))

    if (CIVIL_WEBHOOK) then
        exports.stem_discord:sendThroughWebhook({
            webhook = CIVIL_WEBHOOK,
            params = {
                username = "Court Activity",
                content = ("``%s`` **%s** convicted **%s** - #%s ``%s``"):format(player.job.grade_label, player.name, target.name, id, charge.label),
            },
            ignoreEnv = true,
        })
    else
        print("No civil_webhook found")
    end
    return cb(result)
         
end)

ESX.RegisterServerCallback("stem_doj:getVehicles", function(source, cb, player)
    local target = ESX.GetPlayerFromId(player)  
    local player = ESX.GetPlayerFromId(source)  
    if (player.job.name ~= "doj") then
        return
    end

    local vehicles = MySQL.query.await("SELECT * FROM owned_vehicles WHERE owner = @identifier", {
        ["@identifier"] = target.identifier
    })
    
    cb(exports.stem_common:tableMap(vehicles, function (vehicle) 
        local vehShopData = exports.stem_dealership:getVehicle(vehicle.model)
        vehicle.price = vehShopData and math.ceil(vehShopData.price * 0.75)
        return vehicle
    end))
end)

ESX.RegisterServerCallback("noire_doj:fetchCriminalCode", function (source, cb)
    
end)

RegisterNetEvent("stem_doj:jailPlayer", function (playerId, months)
    local player = ESX.GetPlayerFromId(source)
    if player.job.name ~= "doj" then
        return player.showNotification("You do not have permission to do this")
    end
    removeFromDocket(playerId)
    exports.pickle_prisons:JailPlayer(player.source, playerId, months)
end)

RegisterNetEvent("stem_doj:releasePlayer", function (playerId)
    local player = ESX.GetPlayerFromId(source)
    if player.job.name ~= "doj" then
        return player.showNotification("You do not have permission to do this")
    end
    removeFromDocket(playerId)
    TriggerClientEvent("stem_doj:releasePlayer", playerId)
end)

RegisterNetEvent("stem_doj:seizeVehicle", function (plate)
    local player = ESX.GetPlayerFromId(source)
    if player.job.name ~= "doj" then
        return player.showNotification("You do not have permission to do this")
    end
    local vehicle = MySQL.query.await("SELECT * FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = plate
    })

    if (not vehicle) then
        return player.showNotification("Vehicle does not exist")
    end

    local target = ESX.GetPlayerFromIdentifier(vehicle.owner)
    if (not target) then
        return player.showNotification("This player isn't online", "error")
    end

    local vehShopData = exports.stem_dealership:getVehicle(vehicle.model)

    local vehicle = MySQL.query.await("UPDATE owned_vehicles SET status = FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = plate
    })
    
    local npwdPlayerData = exports.npwd.getPlayerData({ identifier = target.identifier })
    exports.npwd:emitMessage({
        senderNumber = "DOJ",
        targetNumber = npwdPlayerData.phoneNumber,
        message = ('Your vehicle has been seized.\nVehicle: %s\nPlate:'):format(vehShopData.label or vehicle.model, plate),
        embed = {
            phoneNumber = "DOJ"
        }
    })


    if (COURT_WEBHOOK) then
        exports.stem_discord:sendThroughWebhook({
            webhook = COURT_WEBHOOK,
            params = {
                username = "Court Activity",
                content = ("``%s`` **%s** force liquidated a(n) ``%s``. Plate: **%s** Owner: **%s** Value: **%s**"):format(player.job.grade_label, player.name, vehShopData.label or vehicle.model, plate, target.name, sellPrice),
            },
            ignoreEnv = true,
        })
    else
        print("No court_webhook found")
    end
end)

RegisterNetEvent("stem_doj:returnVehicle", function (plate)
    local player = ESX.GetPlayerFromId(source)
    if player.job.name ~= "doj" then
        return player.showNotification("You do not have permission to do this")
    end
    
end)

RegisterNetEvent("stem_doj:forceLiquidate", function (plate)
    local player = ESX.GetPlayerFromId(source)
    if player.job.name ~= "doj" then
        return player.showNotification("You do not have permission to do this")
    end
    
    local vehicle = MySQL.single.await("SELECT * FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = plate
    })

    if (not vehicle) then
        return player.showNotification("Vehicle does not exist")
    end

    local target = ESX.GetPlayerFromIdentifier(vehicle.owner)
    if (not target) then
        return player.showNotification("This player isn't online", "error")
    end

    local vehShopData = exports.stem_dealership:getVehicle(vehicle.model)
    local sellPrice = vehShopData and math.ceil(vehShopData.price * 0.75)

    local vehicle = MySQL.query.await("DELETE FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = plate
    })
    target.addAccountMoney("bank", sellPrice)

    local npwdPlayerData = exports.npwd:getPlayerData({ identifier = target.identifier })
    exports.npwd:emitMessage({
        senderNumber = "411",
        targetNumber = npwdPlayerData.phoneNumber,
        message = ('Your vehicle has been liquidated. Vehicle: %s Plate:%s'):format(vehShopData.label or vehicle.model or "Some vehicle", plate),
        embed = {

            phoneNumber = "411"
        }
    })

    if (CIVIL_WEBHOOK) then
        exports.stem_discord:sendThroughWebhook({
            webhook = CIVIL_WEBHOOK,
            params = {
                username = "Court Activity",
                content = ("``%s`` **%s** force liquidated a(n) ``%s``. Plate: **%s** Owner: **%s** Value: **%s**"):format(player.job.grade_label, player.name, vehShopData.label or vehicle.model, plate, target.name, sellPrice),
            },
            ignoreEnv = true,
        })
    else
        print("No civil_webhook found")
    end
end)

RegisterNetEvent("stem_doj:svAddToDocket", function (cell)
    local player = ESX.GetPlayerFromId(source)
    local docket = GlobalState.docket
    table.insert(docket, {
        cell = cell,
        playerName = player.name,
        playerId = player.source,
        index = #docket,
        time = os.time()
    })
    GlobalState.docket = docket
end)

RegisterNetEvent("stem_doj:svAlertCourt", function (cell)
    print(cell)
    local player = ESX.GetPlayerFromId(source)
    for key, source in pairs(GetActivePlayers()) do
        local player = ESX.GetPlayerFromId(source)
        if (player.job.name == "doj" ) then
            player.showHelpNotification(string.format("~b~%s~w~ has been transported to cell ~r~%s~w~", player.name, cell), false, true, 10000)
        end
    end
end)

RegisterNetEvent("stem_doj:checkFlight", function (isPrison)
    local player = ESX.GetPlayerFromId(source)
    local currentDateExpired =  os.date('%Y-%m-%d %H:%M:%S', os.time() - 60 * 60 * 24 * 2) -- 2 days expiry date
    local expiredCharges = MySQL.query.await([[
        SELECT * FROM criminal_billing 
        WHERE 
            identifier = @identifier AND 
            issue_date < @expiry_date AND
            (plea_entered = 1 OR plea_entered = 2)
        ORDER BY issue_date DESC
        ]], {
            ["@identifier"] = player.identifier,
            ["@expiry_date"] = currentDateExpired
        })

    for key, value in next, exports.stem_common:tableReverse(expiredCharges) do
        if (value.plea_entered > 0 and value.plea_entered < 3) then
            if (isPrison) then exports.pickle_prisons:UnjailPlayer(player.source, false, true) end
            return TriggerClientEvent("stem_doj:courtLogin", player.source, isPrison)
        end
    end
    if (isPrison) then 
        exports.pickle_prisons:UnjailPlayer(player.source, false, true) 
        return TriggerClientEvent("stem_doj:courtLogin", player.source, isPrison)
    end
end)

