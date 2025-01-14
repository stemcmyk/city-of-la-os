

previousSongs, CurrentBooths = {}, {}
local Locations = Config.Locations

print(json.encode(Loc[Config.Lan]))

ESX.RegisterServerCallback('jim-djbooth:server:syncLocations', function(source, cb) cb(Locations) end)

local function DestroyAll()
	for i = 1, #Locations do
		local Booth = Locations[i]
		if Booth.playing then local zoneLabel = ""..(Booth.gang or Booth.job)..i exports["xsound"]:Destroy(-1, zoneLabel) end
	end
end

RegisterNetEvent('jim-djbooth:server:AddLocation', function(data)
	DestroyAll()
	Locations[#Locations+1] = data
	if Config.Debug then
		local coords = { string.format("%.2f", data.coords.x), string.format("%.2f", data.coords.y), string.format("%.2f", data.coords.z), (string.format("%.2f", data.coords.w or 0.0)) }
		print("^5Debug^7: ^2Adding new ^3Booth^2 location^7: ^5vec4^7(^6"..(coords[1]).."^7, ^6"..(coords[2]).."^7, ^6"..(coords[3]).."^7, ^6"..(coords[4]).."^7)")
	end
	TriggerClientEvent("jim-djbooth:client:syncLocations", -1, Locations)
end)

RegisterNetEvent("jim-djbooth:server:syncLocations", function() TriggerClientEvent("jim-jobgarage:client:syncLocations", -1, Locations) end)

RegisterNetEvent('jim-djbooth:server:playMusic', function(song, zoneNum)
    local src, coords, Booth = source, GetEntityCoords(ped), Locations[zoneNum]
	local zoneLabel = ""..(Booth.gang or (Booth.jobs and Booth.jobs[1]) or "")..zoneNum
	if not previousSongs[zoneLabel] then previousSongs[zoneLabel] = { [1] = song, }
	elseif previousSongs[zoneLabel] then
		local songList = previousSongs[zoneLabel]
		songList[#songList+1] = song
		previousSongs[zoneLabel] = songList
	end
	exports["xsound"]:PlayUrlPos(-1, zoneLabel, song, (Booth.CurrentVolume or Booth.DefaultVolume), (Booth.soundLoc or Booth.coords))
	exports["xsound"]:Distance(-1, zoneLabel, Booth.radius)
	Locations[zoneNum].playing = true
	TriggerClientEvent('jim-djbooth:client:playMusic', src, { zoneNum = zoneNum })
end)

RegisterNetEvent('jim-djbooth:server:stopMusic', function(data)
    local src, Booth = source, Locations[data.zoneNum]
	local zoneLabel = ""..(Booth.gang or Booth.job)..data.zoneNum
    if Booth.playing then Locations[data.zoneNum].playing = nil Locations[data.zoneNum].CurrentVolume = nil exports["xsound"]:Destroy(-1, zoneLabel) end
    TriggerClientEvent('jim-djbooth:client:playMusic', src, { zoneNum = data.zoneNum })
end)

RegisterNetEvent("jim-djbooth:server:PauseResume", function(data)
    local src, Booth = source, Locations[data.zoneNum]
	local zoneLabel = ""..(Booth.gang or Booth.job)..data.zoneNum
	if Booth.playing then Booth.playing = nil exports["xsound"]:Pause(-1, zoneLabel)
	elseif not Locations[data.zoneNum].playing then Locations[data.zoneNum].playing = true exports["xsound"]:Resume(-1, zoneLabel) end
    TriggerClientEvent('jim-djbooth:client:playMusic', src, { zoneNum = data.zoneNum })
end)

RegisterNetEvent('jim-djbooth:server:changeVolume', function(volume, zoneNum)
    local src, Booth = source, Locations[zoneNum]
	local zoneLabel = ""..(Booth.gang or Booth.job)..zoneNum
    if not tonumber(volume) then return end
    if Booth.playing then exports["xsound"]:setVolume(-1, zoneLabel, volume) Locations[zoneNum].CurrentVolume = volume end
    TriggerClientEvent('jim-djbooth:client:playMusic', src, { zoneNum = zoneNum })
end)

ESX.RegisterServerCallback('jim-djbooth:songInfo', function(source, cb) cb(previousSongs) end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end DestroyAll() end)

local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/jimathy/jim-djbooth/master/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^2Current^7: '^5"..currentVersion.."^7' ^2Latest^7: '^5"..newestVersion.."^7'") end
		print(advice)
	end)
end
CheckVersion()