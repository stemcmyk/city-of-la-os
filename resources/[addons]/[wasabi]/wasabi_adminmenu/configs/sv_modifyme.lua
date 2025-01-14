-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end

-- Clear Inventory callback
lib.callback.register('wasabi_adminmenu:clearinv', function(source, target)
    local adminPerms = AdminPerms(source)
    if not adminPerms or not adminPerms?.open then return false end
    if wsb.framework == 'esx' then
        local xTarget = wsb.getPlayer(target)
        if not xTarget then return false end
        xTarget.setAccountMoney('money', 0)
        xTarget.setAccountMoney('black_money', 0)
        if Config.Inventory == 'mf' then
            exports['mf-inventory']:clearInventory(xTarget.identifier)
            exports['mf-inventory']:clearLoadout(xTarget.identifier)
        elseif Config.Inventory == 'esx' or Config.Inventory == 'cheeza' then
            for i = 1, #xTarget.inventory, 1 do
                if xTarget.inventory[i].count > 0 then
                    xTarget.removeInventoryItem(xTarget.inventory[i].name, xTarget.inventory[i].count)
                end
            end
        end
    elseif wsb.framework == 'qb' then
        local player = wsb.getPlayer(target)
        if not player then return false end
        player.Functions.ClearInventory()
        MySQL.Async.execute('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), player.PlayerData.citizenid })
    end
    if Config.Inventory == 'qs' then
        exports['qs-inventory']:ClearInventory(target, {})
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:ClearInventory(target)
    end
    return true
end)

-- Weather Sync Event
RegisterNetEvent('wasabi_adminmenu:weathersync', function(type)
    local adminPerms = AdminPerms(source)
    if not adminPerms or not adminPerms?.open then return false end
    if not Config.WeatherSystem then
        Weather = type
        TriggerClientEvent('wasabi_adminmenu:weathersync', -1, type)
    elseif Config.WeatherSystem == 'qb' then
        TriggerEvent('qb-weathersync:server:setWeather', type)
    elseif Config.WeatherSystem == 'vsync' then
        ExecuteCommand(('weather %s'):format(type))
    elseif Config.WeatherSystem == 'cd' then
        TriggerEvent('cd_easytime:ForceUpdate', { weather = type })
    elseif Config.WeatherSystem == 'custom' then
        -- Custom weather system can be added here
        -- type is the weather type
        -- Example: exports['myweather']:setWeather(type)


    end
    TriggerClientEvent('wasabi_bridge:notify', source, Strings.notify_weather,
        (Strings.notify_weather_desc:format(string.lower(type))), 'success', 'fa-check')
end)

-- Time Sync Event
RegisterNetEvent('wasabi_adminmenu:timesync', function(hour, minute)
    local adminPerms = AdminPerms(source)
    if not adminPerms or not adminPerms?.open then return false end
    if Config.WeatherSystem == 'qb' then
        TriggerEvent('qb-weathersync:server:setTime', hour, minute)
    elseif Config.WeatherSystem == 'vsync' then
        ExecuteCommand(('time %s %s'):format(hour, minute))
    elseif Config.WeatherSystem == 'cd' then
        TriggerEvent('cd_easytime:ForceUpdate', { hour = hour, minute = minute })
    elseif Config.WeatherSystem == 'custom' then
        -- Custom time system can be added here
        -- hour is the hour
        -- minute is the minute
        -- Example: exports['mytime']:setTime(hour, minute)



    end
    TriggerClientEvent('wasabi_bridge:notify', source, Strings.notify_time,
        (Strings.notify_time_desc:format(hour, minute)), 'success', 'fa-check')
end)
