-- version check
Citizen.CreateThread(function()
    local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
    if vRaw and config.versionCheck then
        local v = json.decode(vRaw)
        local url = 'https://raw.githubusercontent.com/DevBlocky/nearest-postal/master/version.json'
        PerformHttpRequest(url, function(code, res)
            if code == 200 then
                local rv = json.decode(res)
                if rv.version ~= v.version then
                    print(([[
-------------------------------------------------------
nearest-postal
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
]]):format(rv.version, rv.changelog))
                end
            else
                print('nearest-postal was unable to check the version')
            end
        end, 'GET')
    end
end)

-- add functionality to get postals server side from a vec3

local postals = nil
Citizen.CreateThread(function()
    postals = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
    postals = json.decode(postals)
    for i, postal in ipairs(postals) do
        postals[i] = {vec(postal.x, postal.y), code = postal.code}
    end
end)

local function getPostalServer(coords)
    while postals == nil do
        Wait(1)
    end
    local _total = #postals
    local _nearestIndex, _nearestD
    coords = vec(coords[1], coords[2])

    for i = 1, _total do
        local D = #(coords - postals[i][1])
        if not _nearestD or D < _nearestD then
            _nearestIndex = i
            _nearestD = D
        end
    end
    local _code = postals[_nearestIndex].code
    local nearest = {code = _code, dist = _nearestD}
    return nearest or nil
end

exports('getPostalServer', function(coords)
    return getPostalServer(coords)
end)

function get12HourClock()
    local currentTime = os.date("*t")

    -- Extract hours and minutes
    local hours = currentTime.hour
    local minutes = currentTime.min

    -- Determine if it's AM or PM
    local period = "AM"
    if hours >= 12 then
        period = "PM"
        hours = hours - 12
    end

    -- Adjust 12-hour time for midnight
    if hours == 0 then
        hours = 12
    end
    return string.format("%02d:%02d %s", hours, minutes, period)
end

function updateTime() 
    TriggerClientEvent("nearest-postal:setRealTime", -1, get12HourClock())
end

lib.cron.new("* * * * *", updateTime)
Citizen.CreateThread(updateTime)

