function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
end

restfx.route("/setplayerlocation", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
    if (not params.cid or not req.body.coords) then
        return restfxStatus(res, 403, "Invalid Parameters")
    end
    print(json.encode(req.body.coords.x))
    local coords = req.body.coords
    local characterId = exports.stem_common:decode_url(params.cid)
    local player = ESX.GetPlayerFromIdentifier(characterId)

    if (not player) then
		MySQL.Async.execute("UPDATE users SET position = ? WHERE identifier = ?", {json.encode(coords), characterId})
        return restfxStatus(res, 200, {offline = true})
    end

    player.setCoords(vector3(coords.x,coords.y,coords.z))
    
    return restfxStatus(res, 200, {offline = false})
end, "POST")

restfx.route("/setplayerbucket", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid and req.body) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local player = ESX.GetPlayerFromIdentifier(characterId)
    
        if (not player) then
            return restfxStatus(res, 404, "Player not found")
        end    
    
        SetPlayerRoutingBucket(player.source, req.body.bucket)
        return restfxStatus(res, 200, {status = "ok"})
    end
	return restfxStatus(res, 404, "Not found.")
end, "POST")
