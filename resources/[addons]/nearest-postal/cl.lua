local raw = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), "postal_file"))
local postals = json.decode(raw)

local nearest = nil
local pBlip = nil
local isHidden = false

AddEventHandler(
	"playerSpawned",
	function()
		isHidden = false
	end
)

AddEventHandler(
	"esx:onPlayerDeath",
	function(reason)
		isHidden = true
	end
)

RegisterNetEvent("wasabi_ambulance:revive", function() isHidden = false end)
RegisterNetEvent("nearest-postal:resetUI", function() isHidden = false end)

-- thread for nearest and blip
CreateThread(
	function()
		while true do
			local x, y = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

			local ndm = -1 -- nearest distance magnitude
			local ni = -1 -- nearest index
			for i, p in ipairs(postals) do
				local dm = (x - p.x) ^ 2 + (y - p.y) ^ 2 -- distance magnitude
				if ndm == -1 or dm < ndm then
					ni = i
					ndm = dm
				end
			end

			--setting the nearest
			if ni ~= -1 then
				local nd = math.sqrt(ndm) -- nearest distance
				nearest = {i = ni, d = nd}
			end

			-- if blip exists
			if pBlip then
				local b = {x = pBlip.p.x, y = pBlip.p.y} -- blip coords
				local dm = (b.x - x) ^ 2 + (b.y - y) ^ 2 -- distance magnitude
				if dm < config.blip.distToDelete ^ 2 then
					-- delete blip if close
					RemoveBlip(pBlip.hndl)
					pBlip = nil
				end
			end

			Wait(200)
		end
	end
)

local timeDisplay = ""
local streetDisplay = ""
local directions = {
	[0] = "N",
	[1] = "NW",
	[2] = "W",
	[3] = "SW",
	[4] = "S",
	[5] = "SE",
	[6] = "E",
	[7] = "NE",
	[8] = "N"
}

local zones = {
	["AIRP"] = "Los Santos International Airport",
	["ALAMO"] = "Alamo Sea",
	["ALTA"] = "Alta",
	["ARMYB"] = "Fort Zancudo",
	["BANHAMC"] = "Banham Canyon Dr",
	["BANNING"] = "Banning",
	["BEACH"] = "Vespucci Beach",
	["BHAMCA"] = "Banham Canyon",
	["BRADP"] = "Braddock Pass",
	["BRADT"] = "Braddock Tunnel",
	["BURTON"] = "Burton",
	["CALAFB"] = "Calafia Bridge",
	["CANNY"] = "Raton Canyon",
	["CCREAK"] = "Cassidy Creek",
	["CHAMH"] = "Chamberlain Hills",
	["CHIL"] = "Vinewood Hills",
	["CHU"] = "Chumash",
	["CMSW"] = "Chiliad Mountain State Wilderness",
	["CYPRE"] = "Cypress Flats",
	["DAVIS"] = "Davis",
	["DELBE"] = "Del Perro Beach",
	["DELPE"] = "Del Perro",
	["DELSOL"] = "La Puerta",
	["DESRT"] = "Grand Senora Desert",
	["DOWNT"] = "Downtown",
	["DTVINE"] = "Downtown Vinewood",
	["EAST_V"] = "East Vinewood",
	["EBURO"] = "El Burro Heights",
	["ELGORL"] = "El Gordo Lighthouse",
	["ELYSIAN"] = "Elysian Island",
	["GALFISH"] = "Galilee",
	["GOLF"] = "GWC and Golfing Society",
	["GRAPES"] = "Grapeseed",
	["GREATC"] = "Great Chaparral",
	["HARMO"] = "Harmony",
	["HAWICK"] = "Hawick",
	["HORS"] = "Vinewood Racetrack",
	["HUMLAB"] = "Humane Labs and Research",
	["JAIL"] = "Bolingbroke Penitentiary",
	["KOREAT"] = "Little Seoul",
	["LACT"] = "Land Act Reservoir",
	["LAGO"] = "Lago Zancudo",
	["LDAM"] = "Land Act Dam",
	["LEGSQU"] = "Legion Square",
	["LMESA"] = "La Mesa",
	["LOSPUER"] = "La Puerta",
	["MIRR"] = "Mirror Park",
	["MORN"] = "Morningwood",
	["MOVIE"] = "Richards Majestic",
	["MTCHIL"] = "Mount Chiliad",
	["MTGORDO"] = "Mount Gordo",
	["MTJOSE"] = "Mount Josiah",
	["MURRI"] = "Murrieta Heights",
	["NCHU"] = "North Chumash",
	["NOOSE"] = "N.O.O.S.E",
	["OCEANA"] = "Pacific Ocean",
	["PALCOV"] = "Paleto Cove",
	["PALETO"] = "Paleto Bay",
	["PALFOR"] = "Paleto Forest",
	["PALHIGH"] = "Palomino Highlands",
	["PALMPOW"] = "Palmer-Taylor Power Station",
	["PBLUFF"] = "Pacific Bluffs",
	["PBOX"] = "Pillbox Hill",
	["PROCOB"] = "Procopio Beach",
	["RANCHO"] = "Rancho",
	["RGLEN"] = "Richman Glen",
	["RICHM"] = "Richman",
	["ROCKF"] = "Rockford Hills",
	["RTRAK"] = "Redwood Lights Track",
	["SANAND"] = "San Andreas",
	["SANCHIA"] = "San Chianski Mountain Range",
	["SANDY"] = "Sandy Shores",
	["SKID"] = "Mission Row",
	["SLAB"] = "Stab City",
	["STAD"] = "Maze Bank Arena",
	["STRAW"] = "Strawberry",
	["TATAMO"] = "Tataviam Mountains",
	["TERMINA"] = "Terminal",
	["TEXTI"] = "Textile City",
	["TONGVAH"] = "Tongva Hills",
	["TONGVAV"] = "Tongva Valley",
	["VCANA"] = "Vespucci Canals",
	["VESP"] = "Vespucci",
	["VINE"] = "Vinewood",
	["WINDF"] = "Ron Alternates Wind Farm",
	["WVINE"] = "West Vinewood",
	["ZANCUDO"] = "Zancudo River",
	["ZP_ORT"] = "Port of South Los Santos",
	["ZQ_UAR"] = "Davis Quartz"
}

CreateThread(
	function()
		while true do
			local playerPed = PlayerPedId()
			local pos = GetEntityCoords(playerPed)
			local streetHash, crossHash = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local streetName = GetStreetNameFromHashKey(streetHash)
			local crossName = GetStreetNameFromHashKey(crossHash)
			local zoneName = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
			local heading = directions[math.floor((GetEntityHeading(playerPed) + 22.5) / 45.0)]

			local h = GetClockHours()
			local m = GetClockMinutes()

			streetDisplay = string.format("%s | %s %s", heading, postals[nearest.i].code, streetName)
			if zoneName then
				streetDisplay = streetDisplay .. " | " .. zoneName
			end

			local normalizedHour = h > 12 and h % 12 or h
			timeDisplay = string.format("%02d:%02d %s LOCAL TIME %s", normalizedHour, m, h < 12 and "AM" or "PM", tostring(GlobalState.RealTime):upper())

			SetBlipAlpha(GetNorthRadarBlip(), 0)

			Wait(1000)
		end
	end
)

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(0)
        end

        -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
        -- 0.05 * ((safezone - 0.9) * 10)

        while true do
            local safezone = GetSafeZoneSize()
            local safezone_x = 1.0 / 20.0
            local safezone_y = 1.0 / 20.0
            local aspect_ratio = GetAspectRatio(0)
            local res_x, res_y = GetActiveScreenResolution()
            local xscale = 1.0 / res_x
            local yscale = 1.0 / res_y
            local Minimap = {}
            Minimap.width = xscale * (res_x / (4 * aspect_ratio))
            Minimap.height = yscale * (res_y / 5.674)
            Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
            Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
            Minimap.right_x = Minimap.left_x + Minimap.width
            Minimap.top_y = Minimap.bottom_y - Minimap.height
            Minimap.x = Minimap.left_x
            Minimap.y = Minimap.top_y
            Minimap.xunit = xscale
            Minimap.yunit = yscale
            MinimapX = Minimap.right_x * 1.05
            Wait(5000)
        end
    end
)

CreateThread(
	function()
		while not LocalPlayer.state.switchComplete do
			Wait(0)
		end

		while true do
			if nearest and not IsHudHidden() and not isHidden and not LocalPlayer.state.invOpen and not LocalPlayer.state.hudHidden then
				local screenX = GetActiveScreenResolution()
				config.text.posX = MinimapX + (IsPedSwimming(PlayerPedId()) and 150 - 45 or 130 - 45) / screenX

				local voiceOutput = nil
				if not MumbleIsActive() then
					voiceOutput = 'Voice Chat [~r~Disabled~s~]'
				elseif not MumbleIsConnected() then
					voiceOutput = 'Voice Chat [~r~Disconnected~s~]'
				else
					local radioChannel = LocalPlayer.state.radioChannel
					
					if MumbleIsPlayerTalking(PlayerId()) == 1 then
						if type(radioChannel) == 'number' and radioChannel > 0 then
							voiceOutput = string.format('Voice Chat [~o~%s~s~]', (LocalPlayer.state.proximity?.mode or 'Initializing') .. (' - ' .. radioChannel .. ' MHz'))
						else
							voiceOutput = string.format('Voice Chat [~o~%s~s~]', (LocalPlayer.state.proximity?.mode or 'Initializing'))
						end
					else
						if type(radioChannel) == 'number' and radioChannel > 0 then
							voiceOutput = string.format('Voice Chat [%s]', (LocalPlayer.state.proximity?.mode or 'Initializing') .. (' - ' .. radioChannel .. ' MHz'))
						else
							voiceOutput = string.format('Voice Chat [%s]', (LocalPlayer.state.proximity?.mode or 'Initializing'))
						end
					end
				end

				if voiceOutput then
					SetTextFont(4)
					SetTextScale(0.35, 0.30)
					SetTextEntry("STRING")
					SetTextDropShadow(0, 0, 0, 0, 255)
					SetTextColour(255, 255, 255, 255)
					SetTextDropShadow()
					SetTextEdge(4, 0, 0, 0, 255)
					SetTextOutline()
					SetTextRightJustify(true)
					SetTextWrap(0,0.99)
					AddTextComponentString(voiceOutput)
					EndTextCommandDisplayText(0.9, config.text.posY - 0.932)
				end

				SetTextFont(7)
				SetTextScale(0.5, 0.5)
				SetTextEntry("STRING")
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextColour(255, 255, 255, 255)
				SetTextDropShadow()
				SetTextEdge(4, 0, 0, 0, 100)
				SetTextOutline()
				SetTextRightJustify(true)
				SetTextWrap(0,0.99)
				AddTextComponentString(ESX?.PlayerData?.job?.label .. " - " .. ESX?.PlayerData?.job?.grade_label .. '~s~')
				EndTextCommandDisplayText(1.2, config.text.posY - 0.91)

				local locMod = IsRadarHidden() and 0.14 or -0.003

				-- TIME OF DAY AND OTHER INFORMATION
				SetTextFont(4)
				SetTextScale(0.35, 0.35)
				SetTextEntry("STRING")
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextEdge(4, 0, 0, 0, 255)
				SetTextOutline()
				AddTextComponentString(timeDisplay)
				EndTextCommandDisplayText(config.text.posX - locMod, config.text.posY - 0.040)

				SetTextScale(0.45, 0.45)
				SetTextFont(4)
				SetTextOutline()
				BeginTextCommandDisplayText("STRING")
				if #streetDisplay > 36 then
					local truncatedStr = string.sub(streetDisplay, 1, 36)
					truncatedStr = truncatedStr .. "..."
					AddTextComponentSubstringPlayerName(truncatedStr)
				else
					AddTextComponentSubstringPlayerName(streetDisplay)
				end

				EndTextCommandDisplayText(config.text.posX - locMod, config.text.posY - 0.020)
			end
			Wait(0)
		end
	end
)

RegisterCommand(
	"gps",
	function(source, args, raw)
		if #args < 1 then
			if pBlip then
				RemoveBlip(pBlip.hndl)
				pBlip = nil
				TriggerEvent(
					"chat:addMessage",
					{
						color = {255, 0, 0},
						args = {
							"GPS",
							config.blip.deleteText
						}
					}
				)
			end
			return
		end
		local n = string.upper(args[1])

		local fp = nil
		for _, p in ipairs(postals) do
			if string.upper(p.code) == n then
				fp = p
			end
		end

		if fp then
			if pBlip then
				RemoveBlip(pBlip.hndl)
			end
			pBlip = {hndl = AddBlipForCoord(fp.x, fp.y, 0.0), p = fp}
			SetBlipRoute(pBlip.hndl, true)
			SetBlipSprite(pBlip.hndl, config.blip.sprite)
			SetBlipColour(pBlip.hndl, config.blip.color)
			SetBlipRouteColour(pBlip.hndl, config.blip.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(config.blip.blipText:format(pBlip.p.code))
			EndTextCommandSetBlipName(pBlip.hndl)

			TriggerEvent(
				"chat:addMessage",
				{
					color = {255, 0, 0},
					args = {
						"GPS",
						config.blip.drawRouteText:format(fp.code)
					}
				}
			)
		else
			TriggerEvent(
				"chat:addMessage",
				{
					color = {255, 0, 0},
					args = {
						"GPS",
						config.blip.notExistText
					}
				}
			)
		end
	end
)

--[[Development shit]]
local dev = false
if dev then
	local devLocal = json.decode(raw)
	local next = 0

	RegisterCommand(
		"setnext",
		function(src, args, raw)
			local n = tonumber(args[1])
			if n ~= nil then
				next = n
				print("next " .. next)
				return
			end
			print("invalid " .. n)
		end
	)
	RegisterCommand(
		"next",
		function(src, args, raw)
			for i, d in ipairs(devLocal) do
				if d.code == tostring(next) then
					print("duplicate " .. next)
					return
				end
			end
			local coords = GetEntityCoords(GetPlayerPed(-1))
			table.insert(devLocal, {code = tostring(next), x = coords.x, y = coords.y})
			print("insert " .. next)
			next = next + 1
		end
	)
	RegisterCommand(
		"rl",
		function(src, args, raw)
			if #devLocal > 0 then
				local data = table.remove(devLocal, #devLocal)
				print("remove " .. data.code)
				print("next " .. next)
				next = next - 1
			else
				print("invalid")
			end
		end
	)
	RegisterCommand(
		"remove",
		function(src, args, raw)
			if #args < 1 then
				print("invalid")
			else
				for i, d in ipairs(devLocal) do
					if d.code == args[1] then
						table.remove(devLocal, i)
						print("remove " .. d.code)
						return
					end
				end
				print("invalid")
			end
		end
	)
	RegisterCommand(
		"json",
		function(src, args, raw)
			print(json.encode(devLocal))
		end
	)
end

exports(
	"getPostal",
	function()
		if nearest ~= nil then
			return postals[nearest.i].code
		else
			return nil
		end
	end
)

exports(
	"getPostalNearCoords",
	function(coords)
		local ndm = -1 -- nearest distance magnitude
		local ni = -1 -- nearest index
		for i, p in ipairs(postals) do
			local dm = (coords.x - p.x) ^ 2 + (coords.y - p.y) ^ 2 -- distance magnitude
			if ndm == -1 or dm < ndm then
				ni = i
				ndm = dm
			end
		end

		--setting the nearest
		if ni ~= -1 then
			local nd = math.sqrt(ndm) -- nearest distance
			return postals[ni].code
		else
			return -1
		end
	end
)

exports(
	"hidePostal",
	function(enabled)
		isHidden = enabled
	end
)

exports(
	"GetZoneDisplayName",
	function(zone)
		return zones[zone]
	end
)

RegisterNetEvent("nearest-postal:setRealTime")
AddEventHandler("nearest-postal:setRealTime", function (time)
    GlobalState.RealTime = time
end)