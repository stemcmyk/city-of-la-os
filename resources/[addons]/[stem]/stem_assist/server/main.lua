local assists = {}
local assistsBySource = {}

lib.cron.new("* * * * *", function (task, date)
	for key, value in pairs(assists) do
		if (os.time() - value.timestamp > 5 * 60 * 1000) then
			local player = ESX.GetPlayerFromId(value)
			if (player) then player.showNotification("Your assist has expired.") end
			assists[key] = nil
		end
	end
end)

function capitalizeFirst(str)
    return str:gsub("^%l", string.upper)
end
ESX.RegisterServerCallback("stem_assist:updateAssist", function (source, cb, data) 
	if (not assistsBySource[data.id]) then return end
	if (not assistsBySource[data.id]) then return end
	local alrAssist = assists[assistsBySource[data.id]]
	if (not Player(source).state.isStaff) then
		return
	end

	local player = ESX.GetPlayerFromId(source)
	if (not alrAssist) then
		cb(false)
		return player.showNotification("This assist does not exist")	
	end
	if (alrAssist.status == "taken" ) then
		if (data.status ~= "closed" or alrAssist.acceptedBy.id ~= source) then
			cb(false)
			return player.showNotification("This assist is already taken")
		end
	end
	if (alrAssist.status == "closed") then
		cb(false)
		return player.showNotification("This assist is closed")
	end

	if (alrAssist.status == "open") then
		local assistId = assistsBySource[data.id]
		assists[assistId].acceptedBy = {
			name = string.format("%s (%s)", player.name, GetPlayerName(source)),
			id = source,
			identifier = player.identifier
		}
		assists[assistId].status = "taken"
		cb(assists[assistId].acceptedBy)
	end

	if (alrAssist.discordMessgeId) then
		local requestPlayer = ESX.GetPlayerFromId(alrAssist.player.id)
		if (not requestPlayer) then
			player.showNotification("This player has left the server, deleting ticket.", "error")
			assists[tostring(data.id)] = nil
			TriggerClientEvent("stem_assist:updateAssists", -1, assists)
			return
		end
		

		local fields = exports.stem_common:tableFilter({
			{
				name = "",
				value = string.format("Status: **%s**", capitalizeFirst(data.status)),
			},
			alrAssist.acceptedBy and {
				name = "Accepted By",
				value = string.format("**%s**: ``%s (%s)``", player.source, player.name, GetPlayerName(player.source)),
			} or false,
			{
				name = "Description",
				value = string.format("```%s```", alrAssist.description),
			},
			{
				name = "Player information",
				value = string.format("**CID:** %s \n **City Name:** %s", requestPlayer.identifier, requestPlayer.name),
			}
		})

		exports.stem_discord:updateEmbed({
			channelId = "1239863539812794378",
			messageId = alrAssist.discordMessgeId,
			embeds = {
				{
					title = "Assistance Required",
					description = string.format("Player ``%s (%s)`` has requested assistance from staff", GetPlayerName(requestPlayer.source), requestPlayer.source),
					fields = fields
				}
			},
			addTimestamp = true,
		})
	end
	if (data.status == "closed") then
		assists[tostring(data.id)] = nil;
		player.showNotification("Assist closed")
		exports.stem_discord:sendMessage({
			channelId = "1239863539812794378",
			content = string.format("``%s (%s)`` Closed the assist: **%s**", player.name, player.identifier, data.id)
		})
		cb(true)
	end

	TriggerClientEvent("stem_assist:updateAssists", -1, assists[data.id])
end)

ESX.RegisterServerCallback("stem_assist:assistAction", function (source, cb, data) 
	if (not assistsBySource[data.id]) then return end
	local alrAssist = assists[assistsBySource[data.id]]
	if (not Player(source).state.isStaff) then
		return
	end
	if (not alrAssist) then
		return 
	end
	local player = ESX.GetPlayerFromId(source)
	local requestPlayer = ESX.GetPlayerFromId(alrAssist.player.id)

	if (not requestPlayer) then
		player.showNotification("This player has left the server, deleting ticket.", "error")
		assists[tostring(data.id)] = nil
		return
	end

	if (GetResourceState("gay_baby_jail") == "started") then
		exports["gay_baby_jail"]:SetTempPermission(
			requestPlayer.source --[[ integer ]],
			"Client" --[[ string ]],
			"BypassTeleport" --[[ string ]],
			true --[[ boolean ]],
			false --[[ boolean ]]
		)
		exports["gay_baby_jail"]:SetTempPermission(
			player.source --[[ integer ]],
			"Client" --[[ string ]],
			"BypassTeleport" --[[ string ]],
			true --[[ boolean ]],
			false --[[ boolean ]]
		)
	end
	
	if (data.action == "tp:bring") then
		requestPlayer.setCoords(player.getCoords())
		exports.stem_discord:sendMessage({
			channelId = "1239863539812794378",
			content = string.format("``%s (%s)`` brought ``%s (%s)`` (Assist ID: **%s**)", player.name, player.identifier, requestPlayer.name, requestPlayer.identifier, data.id)
		})
	end
	
	if (data.action == "tp:goto") then
		player.setCoords(requestPlayer.getCoords())
		exports.stem_discord:sendMessage({
			channelId = "1239863539812794378",
			content = string.format("``%s (%s)`` teleported to ``%s (%s)`` (Assist ID: **%s**)", player.name, player.identifier, requestPlayer.name, requestPlayer.identifier, data.id)
		})
	end
	
	if (data.action == "tp:tolegion") then
		requestPlayer.setCoords(vector4(249.13, -878.22, 30.49, 283.24))
		exports.stem_discord:sendMessage({
			channelId = "1239863539812794378",
			content = string.format("``%s (%s)`` teleported ``%s (%s)`` to Legion Squeare  (Assist ID: **%s**)", player.name, player.identifier, requestPlayer.name, requestPlayer.identifier, data.id)
		})
	end

	if (data.action == "heal") then
		TriggerClientEvent('wasabi_ambulance:revive', requestPlayer.source)
		exports.stem_discord:sendMessage({
			channelId = "1239863539812794378",
			content = string.format("``%s (%s)`` healed ``%s (%s)`` (Assist ID: **%s**)", player.name, player.identifier, requestPlayer.name, requestPlayer.identifier, data.id)
		})
	end
	
	if (GetResourceState("gay_baby_jail") == "started") then
		exports["gay_baby_jail"]:SetTempPermission(
			requestPlayer.source --[[ integer ]],
			"Client" --[[ string ]],
			"BypassTeleport" --[[ string ]],
			false --[[ boolean ]],
			false --[[ boolean ]]
		)
		exports["gay_baby_jail"]:SetTempPermission(
			player.source --[[ integer ]],
			"Client" --[[ string ]],
			"BypassTeleport" --[[ string ]],
			false --[[ boolean ]],
			false --[[ boolean ]]
		)
	end
end)

RegisterNetEvent("stem_assist:fetchAssists", function ( ) 
	if (not Player(source).state.isStaff) then
		return
	end
	TriggerClientEvent("stem_assist:updateAssists", source, assists)
end)

lib.addCommand("assist", {
	help = "Send an assist out to the admins.", 
	params = {{
		name = 'description', help = 'Describe your problem', type = 'string'
	} }
}, function (source, args, raw)
	local player = ESX.GetPlayerFromId(source)
	local alrAssist = assistsBySource[player.source]
	if (alrAssist) then
		if (alrAssist.status ~= "closed") then
			return player.showNotification(locale("assistance_already_requested"))
		end
	end

	local description = string.gsub(raw, "assist ", "")

	local name = GetPlayerName(player.source)

	for index, source in pairs(GetActivePlayers()) do
		if (Player(source).state.isStaff) then
			TriggerClientEvent("stem_assist:assistanceRequested", source, player.name, player.source,  description)
		end
	end

	local id = #assists + 1
	assists[id] = {
		name = name,
		description = description,
		id = player.source,
		status = "open",
		timestamp = os.time(),
		player = {
			gameName = player.name,
			name = name,
			id = player.source,
			identifier = player.identifier
		}
	}
	assistsBySource[player.source] = id
	for key, value in pairs(GetActivePlayers()) do
		if (Player(value).state.isStaff) then
			TriggerClientEvent("stem_assist:updateAssists", value, assists)
		end
	end

	exports.stem_discord:sendMessage({
		channelId = "1239863539812794378",
		embeds = {
			{
				title = "Assistance Required",
				description = string.format("Player ``%s (%s)`` has requested assistance from staff", name, player.source),
				fields = {
					{
						name = "",
						value = "Status: **Open**",
					},
					{
						name = "Description",
						value = string.format("```%s```", description),
					},
					{
						name = "Player information",
						value = string.format("CID: %s \n City Name: %s", player.identifier, player.name),
					}
				}
			}
		},
		addTimestamp = true,
	}, function (message) 
		assists[id].discordMessgeId = message.id
	end)	
end)

