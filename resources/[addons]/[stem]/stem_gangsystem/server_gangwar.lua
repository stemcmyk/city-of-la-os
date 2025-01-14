local GANGWAR_INTERFEERANCE_WEBHOOK = GetConvar("gangwar_interfeerance_webhook", nil)

function fetchCurrentGangwar(cb)
    MySQL.Async.fetchSingle("SELECT * FROM stem_gangwar WHERE status = 1 ORDER BY created_at DESC", function (result) 
        cb(result)
    end)
end

function fetchLastGangwar(cb)
    MySQL.Async.fetchSingle("SELECT * FROM stem_gangwar ORDER BY created_at DESC", function (result) 
        cb(result)
    end) 
end

function payPeopleEvenOffline(gangs, total) 
    print("paying out gang payout to", json.encode(gangs))
    MySQL.Async.fetchAll("SELECT player FROM stem_gangmembers WHERE gang in (?) AND grade = 3", { gangs }, function (results) 
        MySQL.Async.fetchAll("SELECT accounts, identifier, firstname, lastname FROM users WHERE identifier in (?)", { exports.stem_common:tableMap(results, function(item) return item.player end) }, function (result)
            local splitMoney = total / #result
            local queries = {}
            for key, value in pairs(result) do
                local player = ESX.GetPlayerFromIdentifier(value.identifier)
                if (not player and value.accounts) then
                    local accounts = json.decode(value.accounts)
                    if (accounts.black_money) then 
                        local newMoney = accounts.black_money + splitMoney
                        print(string.format("stem_gangsystem: updating offline user %s's dirty money from %s to %s", value.firstname .. " " .. value.lastname, accounts.black_money, newMoney))
                        accounts.black_money = newMoney
                    end
                    table.insert(queries, {query = ("UPDATE users SET accounts = @newAccounts WHERE identifier = @identifier"), parameters = {
                        ["@newAccounts"] = json.encode(accounts),
                        ["@identifier"] = value.identifier,
                    }})
                elseif (player) then
                    player.addAccountMoney("black_money", splitMoney)
                    player.showNotification(string.format("You've earned $%s (1/%s) from the gang war", ESX.Math.GroupDigits(splitMoney), #result), "success")
                    print(string.format("stem_gangsystem: paying online user %s's dirty money %s", value.firstname .. " " .. value.lastname, splitMoney))
                else
                    print(("gangwar payout | invalid player found: %s"):format(value.identifier))
                end
            end
            
    
            if (#queries > 0) then 
                MySQL.transaction(queries)
            end
        end)
    end)
end

function runPayout(currentWar) 
    local mostKills = currentWar.creator_kills > currentWar.versus_kills and currentWar.creator_kills or currentWar.versus_kills
    local total = (mostKills * math.round(currentWar.start_price * 0.10)) + currentWar.start_price
    if (currentWar.creator_kills == currentWar.versus_kills) then
        return payPeopleEvenOffline({currentWar.gang, currentWar.versus}, total)
    end
    local winner = (currentWar.creator_kills > currentWar.versus_kills) and currentWar.gang or currentWar.versus
    payPeopleEvenOffline({winner}, total) 
end

function createCurrentWarDiscordEmbeds(currentWar)
    
    local mostKills = currentWar.creator_kills > currentWar.versus_kills and currentWar.creator_kills or currentWar.versus_kills
    local total = (mostKills * math.round(currentWar.start_price * 0.10)) + currentWar.start_price
    return {
        {
            author = {
                name = "Gang War"
            },
            title = string.format("%s vs %s", string.upper(currentWar.gang), string.upper(currentWar.versus)),
            description = string.format("Gang War Status: **%s**", currentWar.status == 1 and "Active" or "Finished"),
            fields = {
                {
                    name = string.upper(currentWar.gang) .. " Kills",
                    value = currentWar.creator_kills,
                    inline = true,
                },
                {
                    name = string.upper(currentWar.versus) .. " Kills",
                    value = currentWar.versus_kills,
                    inline = true,
                },
                {
                    name = "Total Payout",
                    value = string.format("```$ %s```", ESX.Math.GroupDigits(total)),
                    inline = false,
                }
            },
            color = 37,
        }
    }
end

function refreshGangWarDiscordMessage(currentWar) 
    if (not currentWar.discord_message_id) then
        return exports.stem_discord:sendMessage({
            channelId = "1236885170838310922", 
            embeds = createCurrentWarDiscordEmbeds(currentWar),
            addTimestamp = true,
        }, function(message)
            MySQL.Async.execute("UPDATE stem_gangwar SET discord_message_id = @messageId WHERE id = @gangWarId", {
                ["messageId"] = message.id,
                ["gangWarId"] = currentWar.id,
            })
        end)
    end
    exports.stem_discord:updateEmbed({
        channelId = "1236885170838310922", 
        messageId = currentWar.discord_message_id,
        embeds = createCurrentWarDiscordEmbeds(currentWar),
        addTimestamp = true,
    })
    
end


function refreshGangWar()
    fetchCurrentGangwar(function (currentWar)
        local isFinished = false
        local hideBlips = false
        if (not currentWar) then 
            GlobalState.gangWar = false; 

            for key, value in pairs(GetActivePlayers()) do
                if (Player(value).state.gangWar) then
                    Player(value).state.gangWar = nil
                end
            end
            
            return
        end
        local timeRunning = os.time() -  (currentWar.created_at / 1000)
        if (timeRunning > Config.gangWarMaxTime) then
            isFinished = true;
            currentWar.status = 0;
            finishGangWar(currentWar)
        else
            GlobalState.gangWar = true
        end
        if (timeRunning >Config.hideBlipsTime) then
            hideBlips = true
        end
        

        local playersApartOfWar = exports.stem_common:tableFilter(exports.stem_common:tableMap(GetActivePlayers(), function(playerId) 
            local nPlayer = ESX.GetPlayerFromId(playerId)
            if (nPlayer and (nPlayer.job.name == currentWar.gang or nPlayer.job.name == currentWar.versus)) then
                return {
                    id = nPlayer.source,
                    gang = nPlayer.job.name,
                    active = not (hideBlips or isFinished),
                    coords = GetEntityCoords(GetPlayerPed(nPlayer.source))
                }
            end
            return false;
        end))


        for key, value in pairs(playersApartOfWar) do
            Player(value.id).state.gangWar = not isFinished and { display = string.format("%s vs %s", string.upper(currentWar.gang), string.upper(currentWar.versus))} or nil

            local playerTable = exports.stem_common:tableMap(playersApartOfWar, function (player) 
                if (player.id == value.id) then return false end
                player.enemy = value.gang ~= player.gang
                return player
            end)
            TriggerClientEvent("stem_gangsystem:warUpdate", value.id, exports.stem_common:tableFilter(playerTable), currentWar.creator_mug)
        end
        
        refreshGangWarDiscordMessage(currentWar)
    end)
end

ESX.RegisterServerCallback("stem_gangsystem:declareWar", function (source, cb, gang) 
    local player = ESX.GetPlayerFromId(source)

    getGangWarStatistics(player.job.name, function (result)
        local netProfit = ((result?.dirty_earned or 0) * 0.25) - (result?.dirty_spent or 0)
        local minNetProfit = netProfit < 0 and 0 or netProfit

        local gangWarPrice = math.ceil(minNetProfit * 0.10) + GlobalState.MinGangwarPrice

        if (player.getAccount("black_money").money < gangWarPrice) then
            player.showNotification("You do not have enough dirty for this gang war")
            return cb(false)
        end        

        fetchGangMember(player.identifier, function (gangResult) 
            if (not gangResult or gangResult.grade <= 1) then
                player.showNotification("You don't have the right   s to start a gang war.", "error")
                cb(false)
                return 
            end

            fetchLastGangwar(function (lastGangWarResult) 
                local lastCreated = lastGangWarResult and lastGangWarResult.created_at or 0
                local timeSinceLast = os.time() -  (lastCreated / 1000)
                if (timeSinceLast <= Config.cooldownPeriod) then return player.showNotification(("Next gangwar can be started in %min, please wait."):format(timeSinceLast / 60 / 60), "error") end 
                fetchCurrentGangwar(function (gangWarResult)
                    if (gangWarResult) then
                        cb(false) 
                        player.showNotification("There is already a gang war active.", "error")
                     end
                    MySQL.Async.execute("INSERT INTO stem_gangwar (gang, versus, created_at, start_price) VALUES (@creator, @versus, @created_at, @start_price)", {
                        ["@creator"] = gangResult.gang,
                        ["@versus"] = gang,
                        ["@created_at"] = os.date('%Y-%m-%d %H:%M:%S', os.time()),
                        ["@start_price"] = gangWarPrice
                    }, function (result) 
                        if (result ~= 1) then return player.showNotification("There was an error starting this war", "error") end;
                        player.removeAccountMoney("black_money", gangWarPrice)
                        player.showNotification("Gang War Started", "success")
                        refreshGangWar(true)
                        GlobalState.gangWar = true
                        cb(true)
                    end)
                end)        
            end)
        end)
    end)
end)



function checkInterfeering(killer, player, gang, cb)
    ESX.TriggerClientCallback(killer.source, "stem_gangsystem:isInGangWarZone", function (result)
        print("inGangwarZone")
        if (not result) then return cb(false) end;

        if (killer.job.name ~= gang.gang or killer.job.name ~= gang.versus) then
            if (player.job.name == gang.gang or player.job.name == gang.versus) then 
                TriggerClientEvent("esx:killPlayer", killer.source)
                killer.showNotification("You are interfeering with an active gang war.")
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end

function updateGangWarKills(gangWarResult, creator, cb)
    local key = creator and "creator_kills" or "versus_kills"
    local newKills = (gangWarResult[key] or 0) + 1
    MySQL.Async.execute(string.format("UPDATE stem_gangwar SET %s = @newKills WHERE id = @gangId", key), {
        ["@gangId"] = gangWarResult.id,
        ["@newKills"] = newKills
    }, cb)
end

function sendDiscordKill(killer, player, data)
    ESX.TriggerClientCallback(killer.source, "stem_gangsystem:getKillInfo", function (killerResult) 
        local stringName = ("**(%s) %s**")
        
        local killerText = string.format(stringName, string.upper(killer.job.name), killer.name)
        local playerText = string.format(stringName, string.upper(player.job.name), player.name)

        local distance = exports.stem_common:getDistanceToCoord(killer.source, GetEntityCoords(GetPlayerPed(player.source)))
        
        local killText = string.format("%s Killed %s using a ``%s (%s)`` from **%s**m away", killerText, playerText, killerResult.weaponModel, data.deathCause, math.round(distance))
        if (killerResult.killerInVeh) then
            killText = string.format("%s Drive-By Killed %s using a ``%s`` in a ``%s`` from **%sm** away", killerText, playerText, killerResult.weaponModel, killerResult.killerVehName, math.round(distance))
        end

        local GANGWAR_KILLS_WEBHOOK = GetConvar("gangwar_kills_webhook", nil)

        if (GANGWAR_KILLS_WEBHOOK) then
            return exports.stem_discord:sendThroughWebhook({
                webhook = GANGWAR_KILLS_WEBHOOK, 
                params = {
                    username = "Gang War Kills",
                    content = killText
                }
            })
        else
            print("No gangwar_kills_webhook found")
        end
    end, data)
end

RegisterNetEvent("stem_common:nlr:registerDeath", function (src) 
    local source = src or source
    if (not source) then return print("no nlr source") end
    
    Player(source).state.hasRespawned = true
end)

RegisterNetEvent("esx:onPlayerDeath", function (data)
    if (not GlobalState.gangWar) then return end
    print(("Registering gangwar kill: %s killed %s"):format(data.killerServerId, source))
    if (data.killerServerId == -1) then return end;

     local killer = ESX.GetPlayerFromId(data.killerServerId)
     if (not killer) then return print(("no killer found for id: %s"):format(source)) end
     local player = ESX.GetPlayerFromId(source)

     if (Player(player.source).state.hasRespawned == false) then
        return print("hasRespawned == false")
     end

     fetchCurrentGangwar(function (gangWarResult) 
        print("gangwar response type: ", type(gangWarResult))
        if (not gangWarResult) then
            return print("no gangwar result")
        end;
        
        ESX.TriggerClientCallback(killer.source, "stem_gangsystem:isInGangWarZone", function (result)
            if (not result) then return print("not in gangwar zone") end
            
            if (killer.job.name == gangWarResult.gang and player.job.name == gangWarResult.versus) then
                updateGangWarKills(gangWarResult, true, function (result) 
                    if (not result) then return print("failed to update gangwar kills") end
                    sendDiscordKill(killer, player, data)
                    exports["stem_gangsystem"]:addToPlayerStatistics(killer.identifier, {
                        war_kills = 1,
                    })
                end)
                Player(player.source).state.hasRespawned = false
                return
            end

            if (killer.job.name == gangWarResult.versus and player.job.name == gangWarResult.gang) then
                updateGangWarKills(gangWarResult, false, function (result) 
                    if (not result) then return end
                    sendDiscordKill(killer, player, data)
                    exports["stem_gangsystem"]:addToPlayerStatistics(killer.identifier, {
                        war_kills = 1,
                    })
                end)
                Player(player.source).state.hasRespawned = false
                return
            end
            

            if (GANGWAR_INTERFEERANCE_WEBHOOK) then
                exports.stem_discord:sendThroughWebhook({
                    webhook = GANGWAR_INTERFEERANCE_WEBHOOK, 
                    params = {
                        username = "Gang War Interfeerance",
                        content = ("``%s`` **%s** %s (%s) interfeered with ``%s`` %s (%s) during gangwar"):format(
                            killer.identifier, 
                            killer.job.name,
                            GetPlayerName(killer.source),
                            player.identifier, 
                            player.job.name,
                            GetPlayerName(player.source)
                        )
                    }
                })
            else
                print("No gangwar_interfeerance_webhook found")
            end
        end)
    end)
end)

SetInterval(function ()
    refreshGangWar(false)
end, 5000)


function finishGangWar(currentWar) 
    MySQL.Async.execute("UPDATE stem_gangwar SET status = 0 WHERE id = @gangWarId", {
        ["@gangWarId"] = currentWar.id
    }, function (result) 
        if (result ~= 1) then return end;
        
        for key, value in pairs(GetActivePlayers()) do
            local player = ESX.GetPlayerFromId(value)
            if (Player(player.source)?.state?.gangWar) then
                player.showNotification("Gang War Ended")
            end
        end
        
        GlobalState.gangWar = false

        currentWar.status = 0
        refreshGangWarDiscordMessage(currentWar)
        runPayout(currentWar)
    end)
end

ESX.RegisterCommand("endgangwar", { "admin" }, function (player) 
    fetchCurrentGangwar(function (currentWar) 
        if (not currentWar) then return end
        finishGangWar(currentWar) 
    end)
end, true)