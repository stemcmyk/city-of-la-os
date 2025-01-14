-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end

-- Customize the way it pulls user identification info?
lib.callback.register('wasabi_police:checkPlayerId', function(source, target)
    local data = wsb.getPlayerIdentity(target)
    return data
end)

--Death check
deathCheck = function(serverId)
    local player = wsb.getPlayer(serverId)
    if not player then return end
    local state = Player(serverId).state
    return state.dead or
    state.isDead or
    player?.PlayerData?.metadata?['isdead'] or
    false
end

lib.callback.register('wasabi_police:revokeLicense', function(_source, id, license)
    if not wsb.hasLicense(id, license) then return false end
    wsb.revokeLicense(id, license)
    return true
end)

if wsb.framework == 'qb' then
    lib.callback.register('wasabi_police:isPlayerDead', function(source, id)
        local player = wsb.getPlayer(id)
        if not player then return end
        return player.PlayerData.metadata['isdead']
    end)
end

if wsb.framework == 'esx' then
    CreateThread(function()
        for i=1, #Config.policeJobs do
            TriggerEvent('esx_society:registerSociety', Config.policeJobs[i], Config.policeJobs[i], 'society_'..Config.policeJobs[i], 'society_'..Config.policeJobs[i], 'society_'..Config.policeJobs[i], {type = 'public'})
        end
    end)

    -- RegisterNetEvent("esx:onPlayerSpawn", function ()
    --     local src = source;
    --     local player = wsb.getPlayer(src)
    --     MySQL.Async.fetchScalar("SELECT metadata FROM users WHERE identifier = @identifier", {
    --         ["@identifier"] = player.identifier
    --     }, function (result) 
    --         local isHandCuffed = json.decode(result).ishandcuffed;
    --         print(isHandCuffed, result.isHandCuffed)
    --         if (not isHandCuffed or isHandCuffed == 0) then
    --             TriggerClientEvent("wasabi_police:uncuff", src)
    --         end
    --     end)
    -- end)

    wsb.getCore().RegisterCommand("uncuff", {"lspd", "sahp"}, function (xPlayer, args, showError)
        if (not args.id) then args.id = xPlayer.source end
        TriggerClientEvent("wasabi_police:uncuff", args.id)
    end, true, {
            help = "Uncuffs a player by id",
            arguments = {
                name = "id",
                help = "Player Id",
                type = "number"
            }
        })

    -- wsb.getCore().RegisterCommand("cuff", {"lspd", "sahp"}, function (xPlayer, args, showError)
    --     print(args.id)
    --     if (not xPlayer or not args.id ) then return print("no self or target") end
    --     if (not args.id) then args.id = xPlayer.source end
    --     TriggerClientEvent("wasabi_police:cuff", args.id)
    -- end, true, {
    --         help = "Cuffs a player by id",
    --         arguments = {
    --             name = "id",
    --             help = "Player Id",
    --             type = "number"
    --         }
    --     })
end

lib.callback.register('wasabi_police:getIdentifier', function(source, target)
    if not wsb.getPlayer(target) then return false end
    return wsb.getIdentifier(target)
end)
