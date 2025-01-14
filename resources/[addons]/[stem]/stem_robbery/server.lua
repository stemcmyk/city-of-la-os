local deadPeds = {}


RegisterServerEvent('loffe_robbery:pedDead')
AddEventHandler('loffe_robbery:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('loffe_robbery:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
        if not Config.Shops[store].robbed then
            for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
            TriggerClientEvent('loffe_robbery:resetStore', -1, store)
        end
    end
end)

RegisterServerEvent('loffe_robbery:cancel')
AddEventHandler('loffe_robbery:cancel', function(store)
    Config.Shops[store].cancelled = true;
end)

RegisterServerEvent('loffe_robbery:handsUp')
AddEventHandler('loffe_robbery:handsUp', function(store)
    TriggerClientEvent('loffe_robbery:handsUp', -1, store)
end)

local pickedNetIds = {}

RegisterServerEvent('loffe_robbery:pickUp')
AddEventHandler('loffe_robbery:pickUp', function(store, netId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (GlobalState.storeRobbery ~= store) then
        return exports.stem_discord:sendMessage({
            channelId = "1238450348545413242",
            content = string.format("Player ``%s | %s (%s)`` tried to pickup a robbery bag without matching store, **%s** ~= **%s**", xPlayer.source, GetPlayerName(xPlayer.source), xPlayer.identifier, GlobalState.storeRobbery, store)
        })
    end
    local randomAmount = math.random(Config.Shops[store].money[1], Config.Shops[store].money[2])
    xPlayer.addAccountMoney("black_money", randomAmount)
    exports["stem_gangsystem"]:addToPlayerStatistics(xPlayer.identifier, {
        dirty_earned = randomAmount,
    })
    TriggerClientEvent('esx:showNotification', source, Translation[Config.Locale]['cashrecieved'] .. ' ' .. randomAmount .. ' ' .. Translation[Config.Locale]['currency'])
    TriggerClientEvent('loffe_robbery:removePickup', -1, GetEntityCoords(GetPlayerPed(xPlayer.source)), netId)
    local ROBBERY_WEBHOOK = GetConvar("robbery_webhook", nil)

    if (ROBBERY_WEBHOOK) then
        exports.stem_discord:getUserDiscord(xPlayer.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = ROBBERY_WEBHOOK,
                params = {
                    username = "Store Robbery",
                    content = ([[
                        <@%s> ``%s`` **%s** robbed store ``%s (%s)`` for **%s**
                    ]]):format(
                        playerDiscord, xPlayer.identifier, xPlayer.name, Config.Shops[store].name, store, ESX.Math.GroupDigits(randomAmount)
                    ),
                },
                ignoreEnv = true,
            })
        end)
    else
        print("No robbery_webhook found")
    end
end)

ESX.RegisterServerCallback('loffe_robbery:canRob', function(source, cb, store)
    local player = ESX.GetPlayerFromId(source)
    local shop = Config.Shops[store]

    if (Config.DisallowedJobs[player.job.name]) then
        return cb("on_duty")
    end

    if (GlobalState.cooldown[shop.jurisdiction] > 0) then
        return cb("cooldown_active")
    end

    if (shop.jurisdiction == "lspd") then
        local cityPolice = (GlobalState.jobCount["lspd"] or 0) + (GlobalState.jobCount["lscso"] or 0)
        if cityPolice < shop.cops then
            print(("Not enough police for robbery: LSPD %s | LSSD %s | SAHP %s"):format(GlobalState.jobCount["lspd"], GlobalState.jobCount["lscso"], GlobalState.jobCount["sahp"]))
            return cb('no_cops')
        end
    else
        local countyPolice = (GlobalState.jobCount["sahp"] or 0)
        if countyPolice < shop.cops then
            print(("LSPD: %s | LSSD: %s | SAHP: %s"):format(GlobalState.jobCount["lspd"], GlobalState.jobCount["lscso"], GlobalState.jobCount["sahp"]))
            return cb('no_cops')
        end
    end


    if not Config.Shops[store].robbed and not deadPeds[store] then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(store, streetZone, netId)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local cooldown = GlobalState.cooldown[Config.Shops[store].jurisdiction]
    if (cooldown ~= 0) then 
        return exports.stem_discord:sendMessage({
            channelId = "1238450348545413242",
            content = string.format("Player ``%s | %s (%s)`` overwrote the cooldown of **%s**", player.source, GetPlayerName(player.source), player.identifier, cooldown)
        })
    end
    Config.Shops[store].robbed = true
    GlobalState.storeRobbery = store
    
    local newCooldown = GlobalState.cooldown
    newCooldown[Config.Shops[store].jurisdiction] = 20
    GlobalState.cooldown = newCooldown

    TriggerClientEvent("stem_robbery:updateStoreData", -1, store, Config.Shops[store])
    
    local dispatchData = {
        message = "Store Robbery",
        codeName = 'storerobbery',
        code = '10-90',
        icon = 'fas fa-store',
        priority = 2,
        coords = Config.Shops[store].coords,
        gender = player.get("sex") == "m" and "Male" or "Female",
        street = streetZone,
        -- camId = camId,
        alertTime = nil,
        jobs = { 'lspd', 'lscso', 'sahp' },
    }

    TriggerEvent('ps-dispatch:server:notify', dispatchData)
    
    TriggerClientEvent('loffe_robbery:rob', -1, store, player.source)
    Wait(30000)
    TriggerClientEvent('loffe_robbery:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    Config.Shops[store].robbed = false
    Config.Shops[store].cancelled = false
    TriggerClientEvent("stem_robbery:updateStoreData", -1, store, Config.Shops[store])
    for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    TriggerClientEvent('loffe_robbery:resetStore', -1, store)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('loffe_robbery:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(500)
    end
end)
