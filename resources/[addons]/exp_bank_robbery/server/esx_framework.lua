
local ROBBERY_WEBHOOK = GetConvar("robbery_webhook", nil)
if GetResourceState("es_extended") == "started" then
    print("^5Starting with ESX^0")
    -- ESX = nil
    -- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
    function GiveGrabbedCash(player_src, event)
        local xPlayer = ESX.GetPlayerFromId(player_src)
        xPlayer.addAccountMoney('black_money', event.earnings)
    end
    
    RegisterNetEvent("exp_bank_robbery:SendPoliceAlert")
    AddEventHandler("exp_bank_robbery:SendPoliceAlert", function(coords)
        for _, server_id in ipairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(server_id)
            if xPlayer.getJob().name == "lspd" then
                xPlayer.triggerEvent("exp_bank_robbery:ShowPoliceAlert", coords)
            end
        end
    end)
    
    function DoesPlayerHaveItem(player_src, item)
        return ESX.GetPlayerFromId(player_src).getInventoryItem(item).count > 0
    end
    
    function DiscordLog(player_src, event)
        local xPlayer = ESX.GetPlayerFromId(player_src)
        exports.stem_discord:getUserDiscord(xPlayer.source, function (playerDiscord) 
            local message =  ([[
                <@%s> ``%s`` **%s** triggered banking event ``%s`` (id: **%s**)
            ]]):format(
                playerDiscord, xPlayer.identifier, xPlayer.name, event.name, event.id
            )
            if (event.name == "cash") then
                message =  ([[
                    <@%s> ``%s`` **%s** was paid **$%s** from a banking heist (bank id: **%s**) (table id: **%s**)
                ]]):format(
                    playerDiscord, xPlayer.identifier, xPlayer.name, event.earnings, event.bank_id, event.id
                )
            end
            if (event.name == "reset") then
                message =  ([[
                    Bank **%s** has been reset
                ]]):format(
                     event.id
                )
            end

            if (ROBBERY_WEBHOOK) then
                exports.stem_discord:sendThroughWebhook({
                    webhook = ROBBERY_WEBHOOK,
                    params = {
                        username = "Bank Robbery",
                        content = message,
                    },
                    ignoreEnv = true,
                })
            else
                print("No robbery_webhook found")
            end
        end)
    end
    
    function GetPoliceCount()
        local players = ESX.GetPlayers()
        local count = 0
    
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player.job.name == 'lspd' then
                count = count + 1
            end
        end
    
        return count
    end
end