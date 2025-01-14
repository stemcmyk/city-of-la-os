local ZoneMembers = { }
local ZoneTimers = { }
local ActiveWars = { }

ESX.RegisterServerCallback('liljay282-gangs:isZoneClaimed', function(source, cb, name)
    local zoneDB = SQL.Execute('SELECT * FROM zones WHERE name = ?', { name })[1]
    if zoneDB then
        cb(true, GetGangData(zoneDB.gang))
    else
        cb(false, { })
    end
end)

RegisterServerEvent('liljay282-gangs:abandonTerritory', function(zone)
    local src = source
    local playerGang = GetPlayerGang(src)
    SQL.Execute('DELETE FROM zones WHERE name = ? AND gang = ?', { zone.name, playerGang.name })
    RequestGangUpdate(src)
    TriggerClientEvent('liljay282-gangs:createZones', -1)
end)

local function IsZoneClaimed(zone)
    local zoneDB = SQL.Execute('SELECT * FROM zones WHERE name = ?', { zone })[1]
    return zoneDB
end

local function ClaimZone(zone)
    local counters = { }
    local lastCounter = nil
    local winner = nil
    if next(ZoneMembers[zone]) == nil then return end
    for key, player in pairs(ZoneMembers[zone]) do
        if not counters[player.gang.name] then
            counters[player.gang.name] = 1
        else
            counters[player.gang.name] = counters[player.gang.name] + 1
        end
    end
    for key, counter in pairs(counters) do
        if not lastCounter then
            lastCounter = counter
            winner = key
        else
            if counter > lastCounter then
                winner = key
            end
        end
    end
    SQL.Execute('INSERT INTO zones (name, gang) VALUES (?, ?)', { zone, winner })
    TriggerClientEvent('liljay282-gangs:createZones', -1)
end

local function StartZoneClaim(zone)
    print('Zone Claim')
    ZoneTimers[zone] = 5
    CreateThread(function()
        while true do
            ZoneTimers[zone] = ZoneTimers[zone] - 1
            TriggerClientEvent('liljay282-gangs:updateTimer', -1, ZoneTimers[zone])
            if ZoneTimers[zone] == 0 then
                ClaimZone(zone)
                TriggerClientEvent('liljay282-gangs:hideTimer', -1)
                ZoneTimers[zone] = nil
                break
            end
            Wait(1000)
        end
    end)
end

local function WarClaimFinished(playerGang, zone)
    local counters = { }
    local lastCounter = nil
    local winner = nil
    if next(ZoneMembers[zone]) == nil then return end
    for key, player in pairs(ZoneMembers[zone]) do
        if not counters[player.gang.name] then
            counters[player.gang.name] = 1
        else
            counters[player.gang.name] = counters[player.gang.name] + 1
        end
    end
    for key, counter in pairs(counters) do
        if not lastCounter then
            lastCounter = counter
            winner = key
        else
            if counter > lastCounter then
                winner = key
            end
        end
    end
    if winner == playerGang then
        SQL.Execute('DELETE FROM zones WHERE name = ?', { zone })
    end
    TriggerClientEvent('liljay282-gangs:createZones', -1)
end

local function StartWarClaim(playerGang, zone)
    print('War Claim')
    ZoneTimers[zone] = 5
    CreateThread(function()
        while true do
            ZoneTimers[zone] = ZoneTimers[zone] - 1
            TriggerClientEvent('liljay282-gangs:updateTimer', -1, ZoneTimers[zone])
            if ZoneTimers[zone] == 0 then
                WarClaimFinished(playerGang, zone)
                TriggerClientEvent('liljay282-gangs:hideTimer', -1)
                ZoneTimers[zone] = nil
                break
            end
            Wait(1000)
        end
    end)
end

local function CanStartWarClaim(gang, zone)
    if not ActiveWars[gang] then return false end
    local zoneDB = SQL.Execute('SELECT * FROM zones WHERE name = ?', { zone })[1]
    if zoneDB.gang == gang then return false end
    if zoneDB.gang == ActiveWars[gang].name then
        return true
    end
    return false
end

RegisterServerEvent('liljay282-gangs:enterZone', function(zone)
    local src = source
    if not ZoneMembers[zone] then ZoneMembers[zone] = { } end
    ZoneMembers[zone][src] = { inZone = true, gang = GetPlayerGang(src) }
    local playerGang = GetPlayerGang(src)
    local counter = 0
    for key, player in pairs(ZoneMembers[zone]) do
        if player.inZone and player.gang.name == playerGang.name then
            counter = counter + 1
        end
    end
    if counter >= 2 and not IsZoneClaimed(zone) and not ZoneTimers[zone] then
        StartZoneClaim(zone)
    end
    if counter >= 2 and IsZoneClaimed(zone) and CanStartWarClaim(playerGang.name, zone) and not ZoneTimers[zone] then
        StartWarClaim(playerGang.name, zone)
    end
end)

RegisterServerEvent('liljay282-gangs:leaveZone', function(zone)
    local src = source
    if ZoneMembers[zone] and ZoneMembers[zone][src] then
        ZoneMembers[zone][src] = nil
    end
end)

RegisterServerEvent('liljay282-gangs:showWarMessage', function()
    local src = source
    local playerGang = GetPlayerGang(src)
    if ActiveWars[playerGang.name] then
        TriggerClientEvent('liljay282-gangs:showWarMessage', src, ActiveWars[playerGang.name].label)
    end
end)

RegisterServerEvent('liljay282-gangs:declareWar', function(gang)
    local src = source
    local playerGang = GetPlayerGang(src)
    gang.label = GetGangConfig(gang.name).Label
    playerGang.label = GetGangConfig(playerGang.name).Label
    if playerGang.money >= 15000 then
        if ActiveWars[playerGang.name] then return end
        SQL.Execute('UPDATE gangs SET money = ? WHERE name = ?', { playerGang.money - 15000, playerGang.name })
        ActiveWars[playerGang.name] = gang
        ActiveWars[gang.name] = playerGang
        RequestGangUpdate(src)
        TriggerClientEvent('liljay282-gangs:warNotificationInit', -1)
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0 },
            multiline = true,
            args = { 'Gang Wars', ('%s has declared war against %s'):format(playerGang.label, gang.label) }
        })
        SendToDiscord(playerGang.label, gang.label)
    end
end)

RegisterServerEvent('liljay282-gangs:removeDead', function(zone)
    local src = source
    if ZoneMembers[zone] and ZoneMembers[zone][src] then
        ZoneMembers[zone][src] = nil
    end
end)