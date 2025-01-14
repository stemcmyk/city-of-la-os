

function clearSentence(identifier, from) 
	local player = fetchPlayer(identifier)
	if (not player) then return "not_found" end
	local result = MySQL.query.await('DELETE FROM stem_comserv WHERE identifier = ?', {identifier})
	if (not player.offline) then
		TriggerClientEvent("stem_comserv:finishSentence", player.source)
		player.showNotification("Your community service is now over, be a good lad.")
	else
		MySQL.query.await("UPDATE users SET position = ? WHERE identifier = ?", {
			json.encode({x = Config.ReleaseLocation.x, y = Config.ReleaseLocationy, z = Config.ReleaseLocation.z}),
			identifier
		})
	end
	
	if (from) then
		exports.stem_discord:sendMessage({
			channelId = "1237803095849828454",
			content = string.format("%s has cleared ``%s``'s community service", from, player.name)
		})
		return result
	end
	exports.stem_discord:sendMessage({
		channelId = "1237803095849828454",
		content = string.format("``%s`` has finished their community service", player.name)
	})
	return result
end

function fetchSentence(identifier) 
	local sentence = MySQL.single.await('SELECT * FROM stem_comserv WHERE identifier = ?', {identifier})
	return sentence
end

function updateService(identifier, data)
	local currentCount = MySQL.scalar.await('SELECT actions_remaining FROM stem_comserv WHERE identifier = ?', {identifier})
	if currentCount then
		local updateRows = MySQL.update.await('UPDATE stem_comserv SET actions_remaining = ? WHERE identifier = ?', {data.actions, identifier})
	else
		local insert = MySQL.insert.await('INSERT INTO stem_comserv (identifier, actions_remaining, reason, evidence) VALUES (?, ?, ?, ?)', {identifier, data.actions, data.reason, data.evidence})
	end
end

function fetchPlayer(playerIdentifier)
    local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if (player) then 
        return player
    end
	local result = MySQL.single.await("SELECT job, firstname, lastname, last_seen FROM users WHERE identifier = @player", {
        ["@player"] = playerIdentifier
	})
	if (not result) then return nil end
	return {
		name = result.firstname .. " " .. result.lastname,
		identifier = playerIdentifier,
		offline = true,
	}
end 

function issueCommunityService(issuer, identifier, data)
	local player = fetchPlayer(identifier)

	if (not player) then 
		 print("stem_comserv", issuer, "tried to send", identifier, "to comserv but identifier does not exist") 
		return "not_found"
	end
	
	updateService(identifier, data)
	exports.stem_discord:sendMessage({
		channelId = "1237803095849828454",
		content = string.format("%s Sent ``%s (%s)`` to **%s actions** of community service\n**Reason** ```%s```**Evidence**\n%s", issuer, player.name, player.identifier, data.actions, data.reason, data.evidence)
	})

	if (not player.offline) then
		player.showNotification(string.format("%s has been sentenced to %s community service actions", player.name, data.actions))
		TriggerClientEvent("stem_comserv:beginSentence", player.source, data.actions)
	end

	return player
end
	
local allowedJobs = {
	["lscso"] = 5,
	["sahp"] = 7,
	["lspd"] = 9,
}

ESX.RegisterCommand("comserv", "user", function (player, args) 
	local isAllowedJob = allowedJobs[player.job.name]
	if (not isAllowedJob or player.job.grade < isAllowedJob) then
		if player.group ~= "admin" then
			return player.showNotification("You do not have permission for this command.", "error")
		end
	end
	
	ESX.TriggerClientCallback(player.source, "stem_comserv:getReason", function (actions, reason, evidence)
		if (not actions or not reason or not evidence) then
			return player.showNotification("Invalid parameters")
		end
		local status = issueCommunityService(string.format("``%s (%s)``", player.name, player.identifier), args.player.identifier, {
			actions = actions, reason = reason, evidence = evidence
		})
		if (status) then 
			player.showNotification(string.format("%s has been issued %s community actions.", args.player.name, actions))
		end
	end)
end, false, {
	help = "Send a scum to the sweeps", 
	arguments = {
		{ name = 'player', help = 'The player id', type = 'player' }
	} 
})

ESX.RegisterCommand("clearcomserv", "user", function (player, args) 
	if player.group ~= "admin" then
		return player.showNotification("You do not have permission for this command.", "error")
	end
	clearSentence(args.player.identifier)
end, false, {
	help = "Clear the community service of a player", 
	arguments = {
		{ name = 'player', help = 'The player id', type = 'player' }
	} 
})


RegisterNetEvent("esx:playerLoaded", function (source) 
	local player = ESX.GetPlayerFromId(source)
	local sentence = fetchSentence(player.identifier)
	
	if (sentence and sentence.actions_remaining > 0) then
		TriggerClientEvent("stem_comserv:beginSentence", player.source, sentence.actions_remaining)
	end
end)

ESX.RegisterServerCallback("stem_comserv:finishSweep", function (source, cb)
	local player = ESX.GetPlayerFromId(source) 
	local sentence = fetchSentence(player.identifier)
	local remaining = sentence.actions_remaining
	if (remaining - 1 < 1) then
		clearSentence(player.identifier)
		return cb(true)
	end
	updateService(player.identifier, {actions = remaining - 1})
	cb(false)
end)

ESX.RegisterServerCallback("stem_comserv:getComserv", function (source, cb)
	local player = ESX.GetPlayerFromId(source)
	local sentence = fetchSentence(player.identifier)

	cb(sentence)
end)

MySQL.ready(function ( ) 
	Citizen.CreateThread(function ( ) 
		for key, player in pairs(GetActivePlayers()) do
			local player = ESX.GetPlayerFromId(player);
			local sentence = fetchSentence(player.identifier)
			if (sentence and sentence.actions_remaining) then
				TriggerClientEvent("stem_comserv:beginSentence", player.source, sentence.actions_remaining)
			end
		end
	end)
end)

