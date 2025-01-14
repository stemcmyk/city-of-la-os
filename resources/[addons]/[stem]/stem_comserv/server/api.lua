function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
end

restfx.route("/delcomserv", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local sentence = fetchSentence(characterId)
        if (not sentence) then return restfxStatus(res, 404, "Sentence not found.") end
        clearSentence(characterId, req.body.from)

        local player = fetchPlayer(characterId)
        sentence.player = player

        return restfxStatus(res, 200, sentence)
	end
	
	return restfxStatus(res, 404, "Not found.")
end, "DELETE")

restfx.route("/addcomserv", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.cid and req.body) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local response = issueCommunityService(req.body.issuer, characterId, req.body)
        if (response == "not_found") then
	        return restfxStatus(res, 404, "Invalid player.")
        end
        
        local sentence = fetchSentence(characterId)

		if (not sentence) then return restfxStatus(res, 404, "Not found.") end
        sentence.player = fetchPlayer(characterId)

        return restfxStatus(res, 200, sentence)
    end
	return restfxStatus(res, 404, "Not found.")
end, "POST")

restfx.route("/getcomserv", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
    print(json.encode(req, {indent=true}))
	if (params.cid) then
        local characterId = exports.stem_common:decode_url(params.cid)
        local sentence = fetchSentence(characterId)
		if (not sentence) then return restfxStatus(res, 404, "Not found.") end
        sentence.player = fetchPlayer(characterId)
		res.body = sentence
		return res	
	end
	
	return restfxStatus(res, 404, "Not found.")
end, "GET")