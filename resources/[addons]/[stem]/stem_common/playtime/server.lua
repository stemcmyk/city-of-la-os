RegisterNetEvent("esx:playerLoaded", function (source, player) 
    Player(source).state.loadedTime = os.time()
    local currentPlaytime = player.getMeta("playtime") 
    Player(source).state.playTime = tonumber(currentPlaytime or 0)
end)

lib.cron.new("* * * * *", function ()
    local currentTime = os.time()
    for key, value in pairs(GetActivePlayers()) do
        local player = ESX.GetPlayerFromId(value)
        if (not Player(value).state.loadedTime or Player(value).state.loadedTime >= currentTime + 5 * 60 * 1000) then
            return
        end

        local newPlaytime = (tonumber(player.getMeta("playtime") or (5 * 1000))) + 60 * 1000
        player.setMeta("playtime", newPlaytime)
        Player(value).state.playTime = newPlaytime

        if (not Player(value).state.combatDisabled) then
            return 
        end

        local newCombatDisable = Player(value).state.combatDisabled - 60 * 1000

        if (newCombatDisable < 0) then
            return
        end

        Player(value).state.combatDisabled = newCombatDisable
        player.setMeta("combatDisabled", Player(value).state.combatDisabled)
    end
end)

ESX.RegisterCommand("resetplaytime", {"admin"}, function (player, args)
    local player = ESX.GetPlayerFromId(args.playerId)
    if (not args.playerId or not player) then return end
    player.setMeta("playtime", 0)
    Player(player.source).state.playTime = 0
    
end, true, {
	help = "Resets the playtime for a player",
	arguments = {
		{ name = 'playerId', help = 'The player id', type = 'number' }
	} 
})