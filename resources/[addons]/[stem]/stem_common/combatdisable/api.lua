function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
end

restfx.route("/getcombatDisable", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local response, status = fetchCombatDisable(characterId)
        if (response == "not_found") then
	        return restfxStatus(res, 404, "Invalid player.")
        end
        return restfxStatus(res, 200, {timestamp = response, offline = not status})
    end
	return restfxStatus(res, 404, "Not found.")
end, "GET")

restfx.route("/setcombatdisable", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid and req.body) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local response, status = issueCombatDisable(characterId, req.body.hours)
        if (response == "not_found") then
	        return restfxStatus(res, 404, "Invalid player.")
        end
        return restfxStatus(res, 200, {timestamp = response, offline = not status})
    end
	return restfxStatus(res, 404, "Not found.")
end, "POST")

restfx.route("/remcombatdisable", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local response = clearCombatDisable(characterId)
        if (not response) then return restfxStatus(res, 404, "Sentence not found.") end
        clearCombatDisable(characterId)

        return restfxStatus(res, 200, response)
	end
	
	return restfxStatus(res, 404, "Not found.")
end, "DELETE")
