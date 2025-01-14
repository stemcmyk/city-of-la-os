function fetchPlayer(playerIdentifier)
    local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if (player) then
        local result = MySQL.single.await("SELECT last_seen FROM users WHERE identifier = @player", {
            ["@player"] = playerIdentifier
        })
        player.last_seen = result.last_seen
        return player
    end
	local result = MySQL.single.await("SELECT job, firstname, lastname, last_seen FROM users WHERE identifier = @player", {
        ["@player"] = playerIdentifier
	})
	if (not result) then return nil end
	return {
		name = result.firstname .. " " .. result.lastname,
		offline = true,
	}
end

RegisterNetEvent("stem_casino:cashierVIPWithdraw", function (amount) 
    local player = ESX.GetPlayerFromId(source)
    
    if player.getAccount("bank").money < amount then
        return player.showNotification("You do not have enough money for this")
    end

	local society = exports.esx_society:GetSociety("casino")

    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        if not account then return end
        account.addMoney(amount)
        player.removeAccountMoney("bank", amount)
        player.addInventoryItem("casino_chips", amount)
        
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = WEBHOOK,
                params = {
                    username = "",
                    content = ("<@%s> ``%s (%s)`` withdrew **$%s** from the casino"):format(playerDiscord, player.name, GetPlayerName(player.source), ESX.Math.GroupDigits(amount))
                }
            })
        end)
    end)
end)

RegisterNetEvent("stem_casino:cashierVIPDeposit", function (amount) 
    local player = ESX.GetPlayerFromId(source)

    amount = tonumber(amount)
    

    if (player.hasItem("casino_chips").count < amount) then
        return player.showNotification("You do not have enough chips for this")
    end
    
	local society = exports.esx_society:GetSociety("casino")


    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        if not account then return end
        if (account.money >= amount) then
            account.removeMoney(amount * 0.95)
            player.addAccountMoney("bank", amount)
            player.removeInventoryItem("casino_chips", amount)
            
            exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
                exports.stem_discord:sendThroughWebhook({
                    webhook = WEBHOOK,
                    params = {
                        username = "Society",
                        content = ("<@%s> ``%s (%s)`` deposited **$%s** into the casino"):format(playerDiscord, player.name, GetPlayerName(player.source), ESX.Math.GroupDigits(amount))
                    }
                })
            end)
        else
            player.showNotification("The casino has ran out of money.")
        end
    end)
end)

RegisterNetEvent("stem_casino:throwOut", function (playerId)
    local player = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(playerId)

    if (player.job.name ~= "casino") then
        return player.showNotification("You cannot do this")
    end

    TriggerClientEvent("stem_casino:throwOut", target.source)
end)

RegisterNetEvent("stem_casino:blacklist", function (playerId)
    local player = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(playerId)

    if (player.job.name ~= "casino") then
        return player.showNotification("You cannot do this")
    end
    
    MySQL.insert.await("INSERT INTO stem_casinoblacklist SET identifier = @identifier, date_blacklisted = @date_blacklisted", {
        ["@identifier"] = target.identifier,
        ["@date_blacklisted"] = os.date('%Y-%m-%d %H:%M:%S', os.time())
    })

    Player(target.source).state.casinoBlacklisted = true
    TriggerClientEvent("stem_casino:throwOut", target.source)
end)

RegisterNetEvent("stem_casino:removeBlacklistByIdentifier", function (identifier)
    local player = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(identifier)

    if (player.job.name ~= "casino") then
        return player.showNotification("You cannot do this")
    end
    
    if (target) then
        Player(target.identifier).state.casinoBlacklisted = false
    end
    MySQL.query.await("DELETE FROM stem_casinoblacklist WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
end)

AddEventHandler("esx:playerJoined", function (source, player) 
    local response = MySQL.query.await("SELECT * FROm stem_casinoblacklist WHERE identifier = @identifier", {
        ["@identifier"] = player.identifier
    })
    if (response) then Player(player.source).state.casinoBlacklisted = true end;
end)

RegisterNetEvent("stem_casino:viewBlacklist", function ()
    local player = ESX.GetPlayerFromId(source)

    if (player.job.name ~= "casino") then
        return player.showNotification("You cannot do this")
    end

    local response = MySQL.query.await("SELECT * FROM stem_casinoblacklist")

    TriggerClientEvent("stem_casino:viewBlacklist", player.source, exports.stem_common:tableMap(response, function (blacklist) 
        blacklist.date_blacklisted = os.date('%Y-%m-%d %H:%M', blacklist.date_blacklisted)
        blacklist.name = fetchPlayer(blacklist.identifier).name
        return blacklist
    end))
end)

RegisterNetEvent("stem_casino:callPolice", function ()
    TriggerClientEvent('ps-dispatch:client:sendEmergencyMsg', source, "Casino is in need of assistance", "911", false)
end)


MySQL.ready(function ( )
    Citizen.CreateThread(function () 
        exports.esx_society:registerSociety('casino', 'casino', 'society_casino', 'society_casino', 'society_casino', { type = 'private' })
        exports.esx_society:setBossGradeName("owner")
    end)
end)
