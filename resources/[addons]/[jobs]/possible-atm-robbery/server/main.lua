local config = require('shared.config')
local ox_inventory = exports.ox_inventory
local ROBBERY_WEBHOOK = GetConvar("robbery_webhook", nil)

local cashA = config.MinReward
local cashB = config.MaxReward

if config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif config.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
end

local robbedEntities = {}

RegisterNetEvent("possible-atm-robbery:server:startHack", function (netId) 
    local player = ESX.GetPlayerFromId(source)
    print( robbedEntities[netId], os.time())
    if (robbedEntities[netId] and robbedEntities[netId] > os.time()) then 
        return player.showNotification("This ATM has been robbed too recently")
    end

    local jurisdiction = (GetEntityCoords(GetPlayerPed(player.source)).y) > 700 and "sahp" or "lspd"

    if (GlobalState.cooldown[jurisdiction] > 0) then
        return player.showNotification("There is a currently a cooldown")
    end

    Player(player.source).state.atmRobbery = true 

    TriggerClientEvent("possible-atm-robbery:client:startHack", player.source, netId)
end)

RegisterNetEvent("possible-atm-robbery:server:cancelHack", function (netId) 
    local player = ESX.GetPlayerFromId(source)

    Player(player.source).state.atmRobbery = false
end)


RegisterServerEvent('possible-atm-robbery:server:giveReward', function(netId)
    local src = source
    local reward = math.random(cashA, cashB)
    if config.InventoryType == "qb-inventory" then    
        local Player = QBCore.Functions.GetPlayer(src)
        local markedBillsBagsAmount = math.random(3,5) -- Range of marked bills bags for the player to randomly recieve
        local markedBillsBagsWorth = {
            worth = math.random(cashA, cashB)
        }
        if Player.Functions.RemoveItem(config.RequiredItem, 1) then
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[config.RequiredItem], "remove", 1)
        end
        if config.Cash then
            Player.Functions.AddMoney('cash', reward)
            TriggerClientEvent('QBCore:Notify', src, 'You have received $'..reward..' in cash', 'success')
        else
            Player.Functions.AddItem(config.DirtyCashType, markedBillsBagsAmount, false, markedBillsBagsWorth)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
        end
    elseif config.InventoryType == "ox_inventory" then
        if not netId or not (Player(src).state.atmRobbery ~= netId) then 
            return TriggerEvent("stem_ac:player:sus", {
                source = src, 
                event = 'possible-atm-robbery:server:giveReward',
                reason = "Player never started a robbery",
                metadata = {
                    atmRobbery = Player(src).state.atmRobbery,
                    netId = netId
                }
            })
        end
        local player = ESX.GetPlayerFromId(src)
        if (player.hasItem(config.RequiredItem).count < 1) then
            return 
        end
        ox_inventory:RemoveItem(src, config.RequiredItem, 1)
        ox_inventory:AddItem(src, config.CashItem, reward)
        robbedEntities[netId] = os.time() + 30 * 60 * 1000
        if (ROBBERY_WEBHOOK) then
            exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
                exports.stem_discord:sendThroughWebhook({
                    webhook = ROBBERY_WEBHOOK,
                    params = {
                        username = "ATM Robbery",
                        content = ([[
                            <@%s> ``%s (%s)`` **%s** was paid **$%s** for robbing an atm 
                        ]]):format(
                            playerDiscord, player.name, GetPlayerName(player.source), player.identifier, reward
                        ),
                    },
                    ignoreEnv = true,
                })
            end)
        else
            print("No robbery_webhook found")
        end
        local jurisdiction = (GetEntityCoords(GetPlayerPed(player.source)).y) > 700 and "sahp" or "lspd"

        if (GlobalState.cooldown[jurisdiction] >= 5) then
            return
        end

        GlobalState.cooldown[jurisdiction] = 5
    end
    
    -- if config.PossibleTerritories and config.Framework == "qb" then
    --     TriggerEvent('possible-atm-robbery:server:rewardGangInfluence')
    -- elseif config.PossibleTerritories and config.Framework == "esx" then
    --     TriggerEvent('possible-atm-robbery:server:rewardGangInfluence')
    -- end 

    -- if config.PossibleGangLevel and config.Framework == "qb" then
    --     TriggerEvent('possible-atm-robbery:server:rewardGangXP')
    -- elseif config.PossibleGangLevel and config.Framework == "esx" then
    --     TriggerEvent('possible-atm-robbery:server:rewardGangXP')
    -- end
end)

-- RegisterServerEvent('possible-atm-robbery:server:rewardGangInfluence', function()
--     if config.Framework == "qb" then
--         local src = source
--         local player = QBCore.Functions.GetPlayer(src)
--         if not player then return end
--         local gangID = Player.PlayerData.gang.name
        
--         local territoryName = exports['possible-territories']:GetPlayerTerritory(src)
--         if not territoryName then return end

--         local influence = 10 -- Influence Gained Per hack
--         local cashAmount = 30 -- Amount added to stash per completion, regardless of who completes
--         exports['possible-territories']:AddCashToSafe(territoryName, cashAmount)
--         exports['possible-territories']:UpdateInfluenceForGangInTerritory(territoryName, gangID, influence)
--     elseif config.Framework == "esx" then
--         local source = source
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if not xPlayer then return end
--         local gangID = xPlayer.job.name

--         local territoryName = exports['possible-territories']:GetPlayerTerritory(source)
--         if not territoryName then return end

--         local influence = 10 -- Influence Gained Per hack
--         local cashAmount = 30 -- Amount added to stash per completion, regardless of who completes
--         exports['possible-territories']:AddCashToSafe(territoryName, cashAmount)
--         exports['possible-territories']:UpdateInfluenceForGangInTerritory(territoryName, gangID, influence)
--     end
-- end) 

-- RegisterServerEvent('possible-atm-robbery:server:rewardGangXP', function()
--     if config.Framework == "qb" then
--         local src = source
--         local Player = QBCore.Functions.GetPlayer(src)
--         local gangName = Player.PlayerData.gang.name

--     if gangName ~= "none" then
--         exports['possible-gang-levels']:AddGangXPForPlayer(src, gangName, 5) -- Replace with the amount of XP to give
--     end
--     elseif config.Framework == "esx" then
--         local source = source
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if not xPlayer then return end
--         local gangName = xPlayer.job.name

--         exports['possible-gang-levels']:AddGangXPForPlayer(src, gangName, 5) -- Replace with the amount of XP to give
--     end
-- end) 