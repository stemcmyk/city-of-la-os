local active = true
local inAnim = false
local licenseProps = {}

RequestAnimDict("mp_common")
RequestAnimDict("veh@drivebystd_ds")

AddEventHandler(
	"playerSpawned",
	function()
		if active and LocalPlayer.state.hasPlayerLicense then
			active = false
			SendNUIMessage(
				{
					type = "licenses:MSG",
					active = active
				}
			)
			LocalPlayer.state:set("hasPlayerLicense", false, true)
		end
	end
)

-- Functions --
local function GetPlayers()
	local players = {}
	for _, id in ipairs(GetActivePlayers()) do
		if ((NetworkIsPlayerActive(id)) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			table.insert(players, id)
		end
	end
	return players
end

local function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for k, v in ipairs(players) do
		local target = GetPlayerPed(v)
		if (target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(v), 0)
			local distance = #(targetCoords - plyCoords)
			if (closestDistance == -1 or closestDistance > distance) then
				if distance ~= 0.0 then
					closestPlayer = v
					closestDistance = distance
				end
			end
		end
	end
	return closestPlayer, closestDistance
end

local function LoadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

local function DisplayNotification(blink, background, msg)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(msg)
	if background then
		ThefeedSetNextPostBackgroundColor(background)
	end
	EndTextCommandThefeedPostTicker(blink, false)
end

local function DisplayOnClient(data)
	active = true
	local helpText = "licenses_" .. data.Format .. "_helptext"

	SendNUIMessage(
		{
			type = "licenses:MSG",
			active = active,
			data = data,
			format = data.Format
		}
	)

	Citizen.CreateThread(
		function()
			local scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(0)
			end

			while active do
				if IsControlJustReleased(0, 194) then
					active = false
					SendNUIMessage(
						{
							type = "licenses:MSG",
							active = active
						}
					)
					LocalPlayer.state:set("hasPlayerLicense", false, true)
				else
					PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
					PopScaleformMovieFunctionVoid()

					BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
					ScaleformMovieMethodAddParamInt(0)
					ScaleformMovieMethodAddParamInt(0)
					ScaleformMovieMethodAddParamInt(0)
					ScaleformMovieMethodAddParamInt(80)
					EndScaleformMovieMethod()

					BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
					ScaleformMovieMethodAddParamInt(0)
					ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 194, 0))
					ScaleformMovieMethodAddParamPlayerNameString("Hide")
					EndScaleformMovieMethod()

					BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
					EndScaleformMovieMethod()

					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
				end
				Citizen.Wait(0)
			end

			SetScaleformMovieAsNoLongerNeeded(scaleform)
		end
	)
end

local function ShowToClosest(data)
	local targetPlayer, dist = GetClosestPlayer()
	if targetPlayer ~= -1 and dist < 2.0 then
		TriggerServerEvent("licenses:display", GetPlayerServerId(targetPlayer), data)
		LoadAnimDict(Config.Animation.dict)
		TaskPlayAnim(PlayerPedId(), Config.Animation.dict, Config.Animation.anim, 8.0, 8.0, 1500, 50, 0, false, false,
			false)
		RemoveAnimDict(Config.Animation.dict)
		DisplayNotification(false, false, Config.Localization["success_" .. data.Format])
	else
		DisplayNotification(true, 6, Config.Localization["fail_" .. data.Format])
		return
	end
end

function PlayGiveIDAnimation(ped)
	inAnim = true
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		PlayAnimationInVehicle(ped)
	else
		PlayAnimationOnFoot(ped)
	end
	inAnim = false
end

function PlayAnimationOnFoot(closestPed)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end

	TaskTurnPedToFaceEntity(PlayerPedId(), closestPed, -1)
	Citizen.Wait(1000)

	RequestAnimDict("mp_common")
	while not HasAnimDictLoaded("mp_common") do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 8.0, 8.0, -1, 16, 0, false, false, false)

	LocalPlayer.state:set(
		"propData",
		{
			model = GetHashKey("p_ld_id_card_01"),
			boneIndex = 11347,
			offset = vector3(0.03, 0.03, 0.01),
			rotation = vector3(270.0, 0.0, 0.0),
			rotationOrder = 2
		},
		true
	)

	Citizen.SetTimeout(
		1500,
		function()
			LocalPlayer.state:set("propData", nil, true)
		end
	)

	Citizen.Wait(2500)
	ClearPedTasks(PlayerPedId())
end

function PlayAnimationInVehicle(closestPed)
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end

	RequestAnimDict("veh@drivebystd_ds")
	while not HasAnimDictLoaded("veh@drivebystd_ds") do
		Citizen.Wait(0)
	end

	LocalPlayer.state:set(
		"propData",
		{
			model = GetHashKey("p_ld_id_card_01"),
			boneIndex = 11347,
			offset = vector3(0.03, 0.03, 0.01),
			rotation = vector3(270.0, 0.0, 0.0),
			rotationOrder = 2
		}
	)

	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local offset = GetOffsetFromEntityGivenWorldCoords(veh, GetEntityCoords(closestPed))
	if offset.x <= 0.0 then -- LEFT SIDE
		RollDownWindow(veh, 0)
		TaskPlayAnim(PlayerPedId(), "veh@drivebystd_ds", "intro_90l", 1.0, 1.0, -1, 18, 0, false, false, false)
	else
		RollDownWindow(veh, 1)
		TaskPlayAnim(PlayerPedId(), "veh@drivebystd_ds", "intro_90r", 1.0, 1.0, -1, 18, 0, false, false, false)
	end

	Citizen.Wait(3000)
	ClearPedTasks(PlayerPedId())
	LocalPlayer.state:set("propData", nil, true)
end

-- Events --
RegisterNetEvent("licenses:displayOnClient")
AddEventHandler(
	"licenses:displayOnClient",
	function(data)
		DisplayOnClient(data)
	end
)

RegisterNetEvent("licenses:showToClosest")
AddEventHandler(
	"licenses:showToClosest",
	function(data)
		ShowToClosest(data)
	end
)

RegisterNetEvent("licenses:showPlayer")
AddEventHandler(
	"licenses:showPlayer",
	function(data)
		local plySource = tonumber(data.CitizenID)
		
		data.Sex = (data.Sex:upper() == "M") and "Male" or "Female"

		local player = GetPlayerFromServerId(plySource)
		if player ~= -1 then
			local ped = GetPlayerPed(player)
			if GetPedHairColor(ped) ~= -1 then
				data.Hair = Config.HairColors[GetPedHairColor(ped)] and Config.HairColors[GetPedHairColor(ped)] or
					Config.HairColors[math.random(1, #Config.HairColors)]
			end

			if GetPedEyeColor(ped) ~= -1 then
				data.Eyes = Config.EyeColors[GetPedEyeColor(ped)] and Config.EyeColors[GetPedEyeColor(ped)] or
					Config.EyeColors[math.random(1, #Config.EyeColors)]
			else
				data.Eyes = Config.EyeColors[math.random(1, #Config.EyeColors)]
			end
		end

		DisplayOnClient(data)
	end
)

RegisterNetEvent(
	"noire-licenses:requestFromPlayer",
	function(requestingPlayer)
		local player = GetPlayerFromServerId(requestingPlayer)

		local maxTime = GetGameTimer() + 10000
		while GetGameTimer() < maxTime do
			ESX.ShowHelpNotification("An officer is requesting your identification. Press ~INPUT_CONTEXT~ to show.", true)

			if IsControlJustPressed(0, 47) or IsDisabledControlJustPressed(0, 47) then
				PlayGiveIDAnimation(GetPlayerPed(player))
				TriggerServerEvent("noire-licenses:showDriversLicense", requestingPlayer)
				break
			end

			Wait(0)
		end
	end
)

-- Initialize --
Citizen.CreateThread(
	function()
		AddTextEntry("licenses_id_helptext", Config.Localization["hide_id"])
		AddTextEntry("licenses_driver_license_helptext", Config.Localization["hide_driver_license"])

		exports("ShowToClosest", ShowToClosest)
		exports("DisplayOnClient", DisplayOnClient)
	end
)

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Citizen.Wait(1000)
		end

		exports["ox_target"]:addGlobalPlayer(
			{
				{
					onSelect = function(data)
						PlayGiveIDAnimation(data.entity)
						local serverID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
						TriggerServerEvent("licenses:showDriversLicense", serverID)
					end,
					canInteract = function(ent)
						local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ent))
						local state = Player(id).state.hasPlayerLicense
						return IsEntityAPed(ent) and not exports.wasabi_ambulance:isPlayerDead(id) and
							(state == nil or state == false) and not inAnim and not LocalPlayer.state.handcuffed
					end,
					icon = "fas fa-id-card",
					label = "Show ID",
					item = "driverlicense"
				},
				{
					onSelect = function(data)
						local serverID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
						TriggerServerEvent("licenses:grabLicenseFromBody", serverID)
					end,
					canInteract = function(ent)
						local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ent))
						local state = Player(id).state.hasPlayerLicense
						return exports.wasabi_ambulance:isPlayerDead(id) and not inAnim
					end,
					icon = "fas fa-id-card",
					label = "Grab ID Found on Body"
				}
			}
		)
	end
)
