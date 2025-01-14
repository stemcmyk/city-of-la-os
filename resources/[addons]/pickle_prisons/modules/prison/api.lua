function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
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


function fetchJailTime(identifier) 
	local player = ESX.GetPlayerFromId(identifier)
	if (player) then
		local prisonData = Prisoners[player.source]
		if (not prisonData) then return nil end;
		return {
			timeSentenced = prisonData.sentence_date,
			timeLeft = Player(player.source).state.injail
		}
	else
		local response = MySQL.single.await("SELECT sentence_date, time FROM pickle_prisons WHERE identifier = @identifier", {["@identifier"] = identifier})
		if (not response) then return nil end;
		return {
			timeSentenced = response.sentence_date,
			timeLeft = response.time
		}
	end
end

restfx.route("/clearprison", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)

		local player = fetchPlayer(characterId)
        local prisonData = fetchJailTime(characterId) 

		if (not player) then return restfxStatus(res, 404, "Player not found.") end
		if (not prisonData) then return restfxStatus(res, 404, "Player isn't in prison.") end

		if (not player.offline) then
			UnjailPlayer(player.source)
		else
			local pc = Config.Prisons["default"].release.coords
			MySQL.Async.execute("DELETE FROM pickle_prisons WHERE identifier = @identifier", {["@identifier"] = characterId})
			MySQL.Async.execute("UPDATE users SET position = ? WHERE identifier = ?", {json.encode({x = pc.x, y = pc.y, z = pc.z}), characterId})
		end
		
		exports.stem_discord:sendMessage({
			channelId = "1237768213711028276",
			content = string.format("%s Unjailed ``%s``", req.body.from or "Server", player.name)
		})

		prisonData.player = {
			name = player.name,
			identifier = player.identifier,
			offline = player.offline,
		}
        return restfxStatus(res, 200, prisonData)
	end
	
	return restfxStatus(res, 404, "Not found.")
end, "DELETE")

restfx.route("/fetchprison", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local prisonData = fetchJailTime(characterId) 

		if (not prisonData) then
			return restfxStatus(res, 404, "Not found.")
		end
		

		local player = fetchPlayer(characterId)
		if (not player) then return restfxStatus(res, 404, "Player not found.") end
		
		prisonData.player = {
			name = player.name,
			identifier = player.identifier,
			offline = player.offline,
		}
        return restfxStatus(res, 200, prisonData)
	end
	
	return restfxStatus(res, 404, "Not found.")
end, "GET")