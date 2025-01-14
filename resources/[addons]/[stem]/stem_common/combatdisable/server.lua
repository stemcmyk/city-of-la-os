RegisterNetEvent("esx:playerLoaded", function (source) 
    local player = ESX.GetPlayerFromId(source)
    local combatDisabled = player.getMeta("combatDisabled") 
    if not combatDisabled then return end
    if (combatDisabled) then
        Player(player.source).state.combatDisabled = combatDisabled
    end 
end)

function issueCombatDisable(identifier, timeHours)
    local player = ESX.GetPlayerFromIdentifier(identifier)
    if (player) then
        Player(player.source).state.combatDisabled = nil
        Player(player.source).state.combatDisabled = (timeHours * 60 * 60) * 1000
        player.setMeta("combatDisabled", (timeHours * 60 * 60) * 1000)
        
        return Player(player.source).state.combatDisabled, true
    end

    local player = MySQL.single.await("SELECT metadata FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
    if (not player) then return nil end

    if (not player.metadata) then
        player.metadata = {}
    else
        player.metadata = json.decode(player.metadata)    
    end

    player.metadata["combatDisabled"] = timeHours * 60 * 60 * 1000

    MySQL.query.await("UPDATE users SET metadata = @metadata WHERE identifier = @identifier", {
        ["@identifier"] = identifier,
        ["@metadata"] = json.encode(player.metadata)
    })

    return timeHours * 60 * 60 * 1000, false
end

function clearCombatDisable(identifier)
    local player = ESX.GetPlayerFromIdentifier(identifier)
    if (player) then
        Player(player.source).state.combatDisabled = nil
        player.setMeta("combatDisabled", 0)
        return true
    end

    local player = MySQL.single.await("SELECT metadata FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
    if (not player) then return nil end

    if (not player.metadata) then
        player.metadata = {}
    else
        player.metadata = json.decode(player.metadata)    
    end

    player.metadata["combatDisabled"] = 0
    
    MySQL.query.await("UPDATE users SET metadata = @metadata WHERE identifier = @identifier", {
        ["@identifier"] = identifier,
        ["@metadata"] = json.encode(player.metadata)
    })

    return true
end


function fetchCombatDisable(identifier)
    local player = ESX.GetPlayerFromIdentifier(identifier)
    if (player) then
        return Player(player.source).state.combatDisabled , true
    end

    local player = MySQL.single.await("SELECT metadata FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
    if (not player) then return nil end

    if (not player.metadata) then
        player.metadata = {}
    else
        player.metadata = json.decode(player.metadata)    
    end

    return player.metadata.combatDisabled or 0, false
end


ESX.RegisterCommand("combatdisable", {"admin"}, function (player, args)
    if not args.player then return print("Invalid Player") end
    issueCombatDisable(args.player.identifier, args.hours)
end, true, {
    help = "Issue combat disabling",
    validate = true, arguments = {
        { name = 'player', help = 'The player id', type = 'player' },
        { name = 'hours', help = 'Hours', type = 'number' }
    }
})

ESX.RegisterCommand("clearcombatdisable", {"admin"}, function (player, args)
    if not args.player then return print("Invalid Player") end
    clearCombatDisable(args.player.identifier)
end, true, {
    help = "Issue combat disabling",
    validate = true, arguments = {
        { name = 'player', help = 'The player id', type = 'player' },
    }
})