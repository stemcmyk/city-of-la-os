local webhook = ""
function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
end

function getCombatLog(identifier) 
   return MySQL.scalar.await("SELECT departement FROM stem_combatlog WHERE identifier = @identifier", { ["@identifier"] = identifier}) 
end

function setCombatLog(identifier, departement)
   return MySQL.insert.await("INSERT INTO stem_combatlog (identifier, departement) VALUES (@identifier, @departement)", { ["@identifier"] = identifier, ["@departement"] = departement}) 
end

function clearCombatLog(identifier)
    return MySQL.query.await("DELETE from stem_combatlog WHERE identifier = @identifier", { ["@identifier"] = identifier}) 
 end

local identifiersBySource = {}

exports("searchForPlayerById", function (id)
    local player = ESX.GetPlayerFromId(id)
    if (player) then return player.identifier end
    return identifiersBySource[id].identifier
end)

ESX.RegisterCommand("searchLoggedPlayer", {"admin"}, function (player, args) 
    local foundPlayer = identifiersBySource[args.playerId]
    if (not foundPlayer) then return TriggerClientEvent('chat:addMessage', player.source, { args = { '^Error', 'Player Not Found' } })  end
    local data = MySQL.single.await("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {["@identifier"] = foundPlayer.identifier})
    TriggerClientEvent('chat:addMessage', player.source, { args = { '^Player Found', string.format('License: %s. Name: %s.', foundPlayer.identifier, data.firstname .. " " .. data.lastname) } })
end, false, {
	help = "Searches a logged player",
	arguments = {
		{ name = 'playerId', help = 'The player id', type = 'number' }
	} 
})

ESX.RegisterCommand("combatlog", {"user", "admin"}, function (player, args)
    if (not Config.combatLogLocations[player.job.name]) then
        return player.showNotification("You do not have permission for this", "error")
    end
    if (identifiersBySource[args.playerId]) then
        local result = setCombatLog(identifiersBySource[args.playerId].identifier, player.job.name)
        if (result) then player.showNotification("Player has been combat logged", "success") end;
    end
end, true, {
	help = "Register a combat log",
	arguments = {
		{ name = 'playerId', help = 'The player id', type = 'number' }
	} 
})

function fetchPlayer(playerIdentifier)
    local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if (player) then
        local result = MySQL.single.await("SELECT last_seen FROM users WHERE identifier = @player", {
            ["@player"] = playerIdentifier
        })
        player.last_seen = result.last_seen
        return player
    end
	local result = MySQL.single.await("SELECT job, firstname, lastname, last_seen FROM users WHERE identifier = @player", {
        ["@player"] = playerIdentifier
	})
	if (not result) then return nil end
	return {
		name = result.firstname .. " " .. result.lastname,
		offline = true,

	}
end 

function getAllIdentifiers(source)
    local rawIdentifiers = {}
    for key, value in pairs(GetPlayerIdentifiers(source)) do
        local split = string.split(value, ":")
        rawIdentifiers[split[1]] = split[2]
    end
    return rawIdentifiers
end

restfx.route("/searchcombatlog", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.id) then
        local foundPlayer = identifiersBySource[tonumber(params.id)]

        if (not foundPlayer) then return restfxStatus(res, 404, "Not found.")  end

        local player = fetchPlayer(foundPlayer.identifier)
        if (not player) then return restfxStatus(res, 404, "Not found.")  end
        
		return restfxStatus(res, 200,  {
            name = player.name,
            offline = player.offline or false,
            lastSeen = player.last_seen,
            allIdentifiers = foundPlayer.rawIdentifiers
        }) 	
	end
	
	return restfxStatus(res, 404, "Not found.")
end, "GET")

RegisterNetEvent("esx:playerLoaded", function (playerId, player)
    local combatLog = getCombatLog(player.identifier)
    if (combatLog) then

        for key,playerId in pairs(GetActivePlayers()) do
            local player = ESX.GetPlayerFromId(playerId)
            if (player and player.job.name == combatLog) then
                player.showNotification(string.format("Combat logged person **%s** has been retuned to the **%s** station.", player.name, string.upper(combatLog)), "warn")
            end
        end
        
        TriggerClientEvent("pixel_anticl:combatLogSpawn", player.source, combatLog)
        Player(player.source).state.handcuffed = true
        clearCombatLog(player.identifier)
    end
end)

function string.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end

    return t
end


AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = ESX.GetIdentifier(id)
    
    identifiersBySource[id] = {
        identifier = "char1:"..identifier,
        rawIdentifiers = getAllIdentifiers(source)
    }
    TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
    if Config.LogSystem then
        SendLog(id, crds, identifier, reason)
    end
end)

function SendLog(id, crds, identifier, reason)
    local name = GetPlayerName(id)
    local date = os.date('*t')
    print("id:"..id)
    print("X: "..crds.x..", Y: "..crds.y..", Z: "..crds.z)
    print("identifier:"..identifier)
    print("reason:"..reason)
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
    local embeds = {
        {
            ["title"] = "Player Disconnected",
            ["type"]="rich",
            ["color"] = 4777493,
            ["fields"] = {
                {
                    ["name"] = "Identifier",
                    ["value"] = identifier,
                    ["inline"] = true,
                },{
                    ["name"] = "Nickname",
                    ["value"] = name,
                    ["inline"] = true,
                },{
                    ["name"] = "Player's ID",
                    ["value"] = id,
                    ["inline"] = true,
                },{
                    ["name"] = "Cordinates",
                    ["value"] = "X: "..crds.x..", Y: "..crds.y..", Z: "..crds.z,
                    ["inline"] = true,
                },{
                    ["name"] = "Reason",
                    ["value"] = reason,
                    ["inline"] = true,
                },
            },
            ["footer"]=  {
                ["icon_url"] = "https://forum.fivem.net/uploads/default/original/4X/7/5/e/75ef9fcabc1abea8fce0ebd0236a4132710fcb2e.png",
                ["text"]= "Sent: " ..date.."",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = Config.LogBotName,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end