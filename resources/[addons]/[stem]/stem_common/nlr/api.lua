function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
end

restfx.route("/clearredzones", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local player = ESX.GetPlayerFromIdentifier(characterId)
    
        clearPlayerZones(characterId)

        if (not player) then
            return restfxStatus(res, 404, { offline = true })
        end    
        return restfxStatus(res, 200, {offline = false})
    end
	return restfxStatus(res, 404, "Not found.")
end, "POST")
