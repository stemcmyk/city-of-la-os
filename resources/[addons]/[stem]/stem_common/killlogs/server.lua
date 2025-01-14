GlobalState.serverBootTime = os.time()
kills = {}

local PLAYER_DEATH_WEBHOOK = GetConvar("job_payout_webhook", nil)


-- victimCoords = { x = ESX.Math.Round(victimCoords.x, 1), y = ESX.Math.Round(victimCoords.y, 1), z = ESX.Math.Round(victimCoords.z, 1) },
-- killerCoords = { x = ESX.Math.Round(killerCoords.x, 1), y = ESX.Math.Round(killerCoords.y, 1), z = ESX.Math.Round(killerCoords.z, 1) },

-- killedByPlayer = true,
-- deathCause = deathCause,
-- distance = ESX.Math.Round(distance, 1),

RegisterNetEvent("esx:onPlayerDeath", function (data)
    local player = ESX.GetPlayerFromId(source)
    local playerInventory = exports.ox_inventory:GetInventoryItems(player.source)

    local killId = #kills + 1
    kills[killId] = {
        inv = playerInventory,
        data = data,
    }

    local serverUrl = GetConvar("environment", "local") == "production" and "city-of-la.com:30120" or "localhost:30120"

    local killDataURL = ("http://%s/restfx/killdata/?killId=%s&serverBootTime=%s"):format(serverUrl, killId, GlobalState.serverBootTime)

    if (PLAYER_DEATH_WEBHOOK) then
        exports.stem_discord:getUserDiscord(source, function (playerDiscordId) 
            if (not data.killedByPlayer) then
                    return exports.stem_discord:sendThroughWebhook({
                        webhook = PLAYER_DEATH_WEBHOOK, 
                        params = {
                            username = "Kill Logs",
                            content = ("<@%s> ``%s`` (%s:%s) **%s**  died - **Reason**: %s\n%s"):format(playerDiscordId, player.source, player.job.name, player.job.grade, GetPlayerName(player.source), data.deathCause, killDataURL)
                        },
                        ignoreEnv = true
                    })
            end
    
            local killer = ESX.GetPlayerFromId(data.killerServerId)
    
            ESX.TriggerClientCallback(killer.source, "stem_gangsystem:isInGangWarZone", function (result)
                exports.stem_discord:getUserDiscord(killer.source, function (killerDiscordId) 
                    return exports.stem_discord:sendThroughWebhook({
                        webhook = PLAYER_DEATH_WEBHOOK, 
                        params = {
                            username = "Kill Logs",
                            content = ("<@%s> ``%s`` (%s:%s) **%s** died from <@%s> ``%s`` (%s:%s) **%s** - **Reason:** %s - **Distance:** %s - **Inside GangWar:** %s\n%s"):format(playerDiscordId, player.source, player.job.name, player.job.grade, GetPlayerName(player.source), killerDiscordId, killer.source, killer.job.name, killer.job.grade, GetPlayerName(killer.source), data.deathCause, data.distance, result and GlobalState.gangWar, killDataURL),
                        },
                        ignoreEnv = true
                    })
                end)
            end)
        end)
    else
        print("No player_death_webhook found")
    end
end)