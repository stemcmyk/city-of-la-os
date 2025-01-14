function IsStringPassedProfanityCheck(str)
    local valid, token = ScProfanityCheckString(str)
    if not valid then
        return false
    end

    while ScProfanityGetCheckIsPending(token) and ScProfanityGetCheckIsValid(token) do
        Wait(0)
    end

    return ScProfanityGetStringPassed(token)
end

exports('IsStringPassedProfanityCheck', IsStringPassedProfanityCheck)

function parse_url(url)
    local params = {}
    for key, value in url:gmatch("([^?=&]+)=([^&]*)") do
        params[key] = value
    end
    return params
end

exports("parse_url", parse_url)


function decode_url(str)
    return (str:gsub("%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

exports("decode_url", decode_url)