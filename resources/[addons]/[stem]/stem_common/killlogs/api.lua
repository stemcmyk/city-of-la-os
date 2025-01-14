function restfxStatus(res, status, message) 
	res.status = status;
	res.body = message;
	return res;
end

restfx.route("/killdata", function (req, res)
	local params = exports.stem_common:parse_url(req.path.full)
	if (params.killId and params.serverBootTime) then
        local kill = kills[tonumber(params.killId)]
        if (not kill) then
            return restfxStatus(res, 404, "Kill not found")
        end

        res.head["Content-Type"] = "application/json"
        res.body = kill
        return res
    end
    return restfxStatus(res, 404, "Kill not found")
end, "GET")