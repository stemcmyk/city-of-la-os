local PlayerData, Targets, Props = {}, {}, {}
local Locations = {}

local function removeTargets() for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end Targets = {} for i = 1, #Props do DeleteEntity(Props[i]) end Props = {} end

local function makeTargets()
	removeTargets()
	for i = 1, #Locations do
		if Locations[i].enableBooth then
			local HasUser = nil;
			if (Locations[i].users) then
				HasUser = exports.stem_common:tableContains(Locations[i].users, ESX.PlayerData.identifier) 
			end
			if Locations[i].gang then RequireGang = Locations[i].RequireGang end
			Targets["Booth"..i] =
			exports.ox_target:addSphereZone({
				coords = Locations[i].coords,
				radius = 0.6,
				options = {
					{ 
						event = "jim-djbooth:client:playMusic", 
						icon = "fab fa-youtube", 
						label = Loc[Config.Lan].target["dj_booth"], 
						groups = Locations[i].jobs, 
						canInteract = function ()
							return HasUser ~= false
						end,
						zoneNum = i,
						distance = 2.0  
					}, 
				},
			})
			if Locations[i].prop then
				Props[#Props+1] = makeProp({prop = Locations[i].prop, coords = vec4(Locations[i].coords.x, Locations[i].coords.y, Locations[i].coords.z, math.random(1,359)+0.0) }, true, false)
			end
		end
	end
end

local function syncLocations()
	local p = promise.new()
	ESX.TriggerServerCallback('jim-djbooth:server:syncLocations', function(cb) p:resolve(cb) end)
	Locations = Citizen.Await(p)
	makeTargets()
end

AddEventHandler('onResourceStart', function(r) if (GetCurrentResourceName() ~= r) then return end
	if GetResourceState("xsound") ~= "started" then print("xSound not started, script won't function") end
	-- PlayerData = QBCore.Functions.GetPlayerData() Wait(5000) 
	syncLocations()
end)
AddEventHandler('esx:playerLoaded', function()
	-- PlayerData = QBCore.Functions.GetPlayerData() Wait(5000) 
	syncLocations()
end)
-- RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerData.job = JobInfo end)
-- RegisterNetEvent('QBCore:Client:OnPlayerUnload', function() PlayerData = {} end)

RegisterNetEvent("jim-djbooth:client:syncLocations", function(newLocations) Locations = newLocations makeTargets() end)

RegisterNetEvent("jim-djbooth:client:playMusic", function(data)
	print(json.encode(data))
	local booth = ""
	for k, v in pairs(Locations) do
		if #(GetEntityCoords(PlayerPedId()) - v["coords"]) <= v["radius"] then
			if v["job"] then booth = v["job"]..k elseif v["gang"] then booth = v["gang"]..k end
		end
	end
	local song = { playing = "", duration = "", timeStamp = "",	duration = "", url = "", icon = "", header = Loc[Config.Lan].menu["no_song"], txt = "", volume = "" }
	local p = promise.new()
	ESX.TriggerServerCallback('jim-djbooth:songInfo', function(cb) p:resolve(cb) end)
	previousSongs = Citizen.Await(p)

	-- Grab song info and build table
	if exports["xsound"]:soundExists(booth) then
		song = {
			playing = exports["xsound"]:isPlaying(booth),
			timeStamp = "",
			url = exports["xsound"]:getLink(booth),
			icon = "https://img.youtube.com/vi/"..string.sub(exports["xsound"]:getLink(booth), - 11).."/mqdefault.jpg",
			header = "",
			txt = exports["xsound"]:getLink(booth),
			volume = math.ceil(exports["xsound"]:getVolume(booth)*100)
		}
		if exports["xsound"]:isPlaying(booth) then song.header = Loc[Config.Lan].menu["cur_playing"] end
		if exports["xsound"]:isPaused(booth) then song.header = Loc[Config.Lan].menu["cur_paused"] end
		if exports["xsound"]:getMaxDuration(booth) == 0 then song.timeStamp = Loc[Config.Lan].menu["live"] end
		if exports["xsound"]:getMaxDuration(booth) > 0 then
			local timestamp = (exports["xsound"]:getTimeStamp(booth) * 10)
			local mm = (timestamp // (60 * 10)) % 60.
			local ss = (timestamp // 10) % 60.
			timestamp = string.format("%02d:%02d", mm, ss)
			local duration = (exports["xsound"]:getMaxDuration(booth) * 10)
			mm = (duration // (60 * 10)) % 60.
			ss = (duration // 10) % 60.
			duration = string.format("%02d:%02d", mm, ss)
			song.timeStamp = "("..timestamp.."/"..duration..")"
			if exports["xsound"]:isPlaying(booth) then song.timeStamp = "🔊 "..song.timeStamp else song.timeStamp = "🔇 "..song.timeStamp end
		end
	end

	local musicMenu = {}
	if Config.Menu == "qb" then
		musicMenu[#musicMenu+1] = {
			isMenuHeader = true,
			header = '<img src=https://cdn-icons-png.flaticon.com/512/1384/1384060.png width=20px></img>&nbsp; '..Loc[Config.Lan].target["dj_booth"],
			txt = ""
		}
		musicMenu[#musicMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].menu["close"], params = { event = "qb-menu:client:closemenu" } }
	end

	musicMenu[#musicMenu + 1] = {
		canClick = false,
		disabled = true,
		image = song.icon, icon = song.icon,
		header = song.header, txt = song.txt.."<br>"..song.timeStamp, --qb-menu
		title = song.header, description = song.txt.."\n"..song.timeStamp, -- ox_lib
	}
	musicMenu[#musicMenu+1] = {
		icon = "fab fa-youtube",
		header = song.header, txt =  Loc[Config.Lan].menu["enter_url"], --qb-menu
		title = Loc[Config.Lan].menu["play"], -- ox_lib
		header = Loc[Config.Lan].menu["play"],
		event = "jim-djbooth:client:musicMenu",	args = { zoneNum = data.zoneNum }, -- ox_lib
		params = { event = "jim-djbooth:client:musicMenu", args = { zoneNum = data.zoneNum } }
	}
	if previousSongs[booth] then
		musicMenu[#musicMenu+1] = {
			icon = "fas fa-clock-rotate-left",
			header = Loc[Config.Lan].menu["history"],
			title = Loc[Config.Lan].menu["history"], -- ox_lib
			event = "jim-djbooth:client:history", args = { history = previousSongs[booth], zoneNum = data.zoneNum }, -- ox_lib
			params = { event = "jim-djbooth:client:history", args = { history = previousSongs[booth], zoneNum = data.zoneNum } }
		}
	end
	if exports["xsound"]:soundExists(booth) then
		if exports["xsound"]:isPlaying(booth) then
			musicMenu[#musicMenu+1] = {
				icon = "fas fa-pause",
				header = Loc[Config.Lan].menu["text_pause"],
				title = Loc[Config.Lan].menu["text_pause"],
				serverEvent = "jim-djbooth:server:PauseResume", args = { zoneNum = data.zoneNum },
				params = { isServer = true, event = "jim-djbooth:server:PauseResume", args = { zoneNum = data.zoneNum } }
			}
		elseif exports["xsound"]:isPaused(booth) then
			musicMenu[#musicMenu+1] = {
				icon = "fas fa-play",
				header = Loc[Config.Lan].menu["text_resume"],
				title = Loc[Config.Lan].menu["text_resume"],
				serverEvent = "jim-djbooth:server:PauseResume", args = { zoneNum = data.zoneNum },
				params = { isServer = true, event = "jim-djbooth:server:PauseResume", args = { zoneNum = data.zoneNum } }
			}
		end
		musicMenu[#musicMenu+1] = {
			icon = "fas fa-volume-off",
			header = Loc[Config.Lan].menu["volume"]..song.volume.."%",
			title = Loc[Config.Lan].menu["volume"]..song.volume.."%",
			progress = tonumber(song.volume),
			event = "jim-djbooth:client:changeVolume", args = { zoneNum = data.zoneNum,  },
			params = { event = "jim-djbooth:client:changeVolume", args = { zoneNum = data.zoneNum } }
		}
		musicMenu[#musicMenu+1] = {
			icon = "fas fa-stop",
			header = Loc[Config.Lan].menu["stop"],
			title = Loc[Config.Lan].menu["stop"],
			serverEvent = "jim-djbooth:server:stopMusic", args = { zoneNum = data.zoneNum }, -- ox_lib
			params = { isServer = true,	event = "jim-djbooth:server:stopMusic",	args = { zoneNum = data.zoneNum } }
		}
	end

	if Config.Menu == "ox" then
		exports.ox_lib:registerContext({id = 'booth', title = Loc[Config.Lan].target["dj_booth"], position = 'top-right', options = musicMenu })
		exports.ox_lib:showContext("booth")
	elseif Config.Menu == "qb" then
		exports['qb-menu']:openMenu(musicMenu)
	end
	song = nil
end)
RegisterNetEvent("jim-djbooth:client:history", function(data)
	local musicMenu = {}
	if Config.Menu == "qb" then
		musicMenu[#musicMenu+1] = {	icon = "fas fa-clock-rotate-left", isMenuHeader = true, header = "<img src=https://cdn-icons-png.flaticon.com/512/1384/1384060.png width=20px></img>&nbsp; "..Loc[Config.Lan].target["dj_booth"], txt = Loc[Config.Lan].menu["history_play"] }
	end
	musicMenu[#musicMenu+1] = {
		icon = "fas fa-circle-arrow-left",
		header = "", txt = Loc[Config.Lan].menu["back"],
		title = Loc[Config.Lan].menu["back"],
		event = "jim-djbooth:client:playMusic", args = { job = data.jobs, zone = data.zoneNum },
		params = { event = "jim-djbooth:client:playMusic", args = { job = data.jobs, zone = data.zoneNum } }
	}
	for i = #data.history, 1, -1 do
		musicMenu[#musicMenu+1] = {
			image = "https://img.youtube.com/vi/"..string.sub(data.history[i], - 11).."/mqdefault.jpg",
			icon = "https://img.youtube.com/vi/"..string.sub(data.history[i], - 11).."/mqdefault.jpg",
			header = "", txt = data.history[i],
			title = data.history[i],
			event = "jim-djbooth:client:historyPlay", args = { song = data.history[i], zoneNum = data.zoneNum },
			params = { event = "jim-djbooth:client:historyPlay", args = { song = data.history[i], zoneNum = data.zoneNum } }
		}
	end
	if Config.Menu == "ox" then
		exports.ox_lib:registerContext({ id = 'history', title = Loc[Config.Lan].target["dj_booth"], position = 'top-right', options = musicMenu,})
		exports.ox_lib:showContext("history")
	elseif Config.Menu == "qb" then
		exports['qb-menu']:openMenu(musicMenu)
	end
end)

RegisterNetEvent('jim-djbooth:client:historyPlay', function(data) TriggerServerEvent('jim-djbooth:server:playMusic', data.song, data.zoneNum) end)

RegisterNetEvent('jim-djbooth:client:musicMenu', function(data)
	local dialog = nil
	if Config.Menu == "ox" then
		dialog = exports.ox_lib:inputDialog(Loc[Config.Lan].menu["select"], {Loc[Config.Lan].menu["youtube_url"]})
	elseif Config.Menu == "qb" then
		dialog = exports['qb-input']:ShowInput({
        header = Loc[Config.Lan].menu["select"],
        submitText = Loc[Config.Lan].menu["submit"],
        inputs = { { type = 'text', isRequired = true, name = 'song', text = Loc[Config.Lan].menu["youtube_url"] } } })
	end
    if dialog then
        if not dialog.song and not dialog[1] then return end
		-- Attempt to correct link if missing "youtube" as some scripts use just the video id at the end
		if not string.find((dialog.song or dialog[1]), "youtu") then dialog.song = "https://www.youtube.com/watch?v="..(dialog.song or dialog[1]) end
		triggerNotify(nil, Loc[Config.Lan].notify["load_link"]..(dialog.song or dialog[1]))
        TriggerServerEvent('jim-djbooth:server:playMusic', (dialog.song or dialog[1]), data.zoneNum)
    end
end)

RegisterNetEvent('jim-djbooth:client:changeVolume', function(data)
	local dialog = nil
	if Config.Menu == "ox" then
		dialog = exports.ox_lib:inputDialog(Loc[Config.Lan].menu["music_volume"], {Loc[Config.Lan].menu["range"]})
	elseif Config.Menu == "qb" then
		dialog = exports['qb-input']:ShowInput({
        header = Loc[Config.Lan].menu["music_volume"],
        submitText = Loc[Config.Lan].menu["submit"],
        inputs = { { type = 'text', isRequired = true, name = 'volume', text = Loc[Config.Lan].menu["range"] } } })
	end
    if dialog then
        if not dialog.volume and not dialog[1] then return end
		-- Automatically correct from numbers to be numbers xsound understands
		dialog.volume = ((dialog.volume or dialog[1]) / 100)
		-- Don't let numbers go too high or too low
		if dialog.volume <= 0.01 then dialog.volume = 0.01 end
		if dialog.volume > 1.0 then dialog.volume = 1.0 end
		triggerNotify(nil, Loc[Config.Lan].notify["new_volume"]..math.ceil(dialog.volume * 100).."%", "success")
        TriggerServerEvent('jim-djbooth:server:changeVolume', dialog.volume, data.zoneNum)
    end
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	if GetResourceState("qb-target") == "started" or GetResourceState("ox_target") == "started" then
		for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
		for i = 1, #Props do DeleteEntity(Props[i]) end
	end
end)