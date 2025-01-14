


RegisterNetEvent("stem_common:stats:dbSave", function ( ) 
    local player = ESX.GetPlayerFromId(source)
    while not player do
        Wait(100)
    end
    
    local stats = Player(player.source).state.stats

    local stats = {
        dist_running = stats.dist_running,
        exercises_completed = stats.exercises_completed,
        stealth_kills = stats.stealth_kills
    }
    
    local fetch = [[
        UPDATE
            users
        SET
            stats = @stats
        WHERE
            identifier = @identifier
    ]]

    MySQL.Async.fetchScalar(fetch, {
        ["@identifier"] = player.identifier,
        ["@stats"] = json.encode(stats)
    })
end)

local function loadStats(source)
    local player = ESX.GetPlayerFromId(source)
    while not player do
        Wait(100)
    end
    
    local fetch = [[
        SELECT
            stats
        FROM
            users
        WHERE
            identifier = @identifier
    ]]

    MySQL.Async.fetchScalar(fetch, {
        ["@identifier"] = player.identifier
    }, function(stats)
        if stats ~= nil and #stats ~= 0 and json.decode(stats).dist_running then
            TriggerClientEvent("stem_common:stats:playerLoaded", player.source, json.decode(stats))
        else
            TriggerClientEvent("stem_common:stats:playerLoaded", player.source, Config_base_stats)
        end
    end)
end

RegisterNetEvent("esx:playerLoaded", function (playerId) 
    loadStats(playerId)
end)

RegisterCommand("loadStats", function (source) 
    loadStats(source)
end, true)