
local busyg = false
local busyd = false
local busyp = false

local function load(time, label, scenario, animationDictionary)

	local anim = {}
	if (scenario) then anim["scenario"] = scenario end
	if (animationDictionary) then anim["dict"] = animationDictionary end
	ESX.ShowHelpNotification("Press ~INPUT_VEH_DUCK~ to cancel gathering.")

	return exports.ox_lib:progressCircle({
		duration = time,
		label = label,
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			move = true,
		},
	})
end

CreateThread(
	function()
		while not LocalPlayer.state.switchComplete do
			Wait(0)
		end

		exports[Config.Target]:AddTargetModel({ `bkr_prop_weed_lrg_01a` }, {
			options = {
				{
					canInteract = function()
						return GetInteriorFromEntity(PlayerPedId()) == GetInteriorAtCoords(Config.Weed.Field.coords)
					end,
					event = "stem_drugs:weed:pick",
					icon = "fas fa-cannabis",
					label = Config.Weed.Locale.TargetGather
				}
			},
			distance = 1.5
		})
	end)

CreateThread(
	function()
		while not LocalPlayer.state.switchComplete do
			Wait(0)
		end

		-- WEED PROCESSING ZONE
		exports[Config.Target]:AddBoxZone(
			"Weed_Package",
			vector3(-1144.01, -1607.81, 4.29), 2.0, 1.0, {
				name = "Weed_Package",
				heading = 35,
				-- debugPoly=true,
				minZ = 3.29,
				maxZ = 7.29
			},
			{
				options = {
					{
						event = "stem_drugs:weed:tryRollJoint",
						icon = "fas fa-joint",
						label = Config.Weed.Locale.MakeJoint
					},
					{
						event = "stem_drugs:weed:tryPackage",
						icon = "fas fa-tape",
						label = Config.Weed.Locale.MakePackage
					}
				},
				distance = 2.0
			}
		)
	end
)

AddEventHandler(
	"stem_drugs:weed:tryRollJoint",
	function()
		if not busyp then
			busyp = true

			ESX.TriggerServerCallback(
				"stem_drugs:weed:canRoll",
				function(canRoll)
					
					if canRoll then
						LocalPlayer.state.blockClearTasks = true
						LocalPlayer.state.invBusy = true

						local ped = PlayerPedId()

						FreezeEntityPosition(ped, true)
						TaskStartScenarioInPlace(ped, 'PROP_HUMAN_PARKING_METER', 0, true)
						
						local progress = load(10000, Config.Weed.Locale.Joint)
						if (progress) then
							TriggerServerEvent("stem_drugs:weed:makeJoint")
						end
						
						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)

						LocalPlayer.state.blockClearTasks = false
						LocalPlayer.state.invBusy = false
					end

					busyp = false
				end
			)
		end
	end
)

AddEventHandler(
	"stem_drugs:weed:tryPackage",
	function()
		if not busyp then
			busyp = true

			ESX.TriggerServerCallback(
				"stem_drugs:weed:canPackage",
				function(canPackage)
					if canPackage then
						LocalPlayer.state.blockClearTasks = true
						LocalPlayer.state.invBusy = true

						FreezeEntityPosition(PlayerPedId(), true)
						TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
						
						local progress = load(30000, Config.Weed.Locale.Packaging)
						if (progress) then
							TriggerServerEvent("stem_drugs:weed:packageWeed")
						end

						ClearPedTasks(PlayerPedId())
						FreezeEntityPosition(PlayerPedId(), false)

						LocalPlayer.state.blockClearTasks = nil
						LocalPlayer.state.invBusy = false
					end

					busyp = false
				end
			)
		end
	end
)

RegisterNetEvent("stem_drugs:weed:pick")
AddEventHandler(
	"stem_drugs:weed:pick",
	function()
		local ped = PlayerPedId()
		local foot = IsPedOnFoot(ped)
		if foot and not busyg then
			busyg = true
			ESX.TriggerServerCallback(
				"stem_drugs:weed:carry",
				function(canCarry)
					if canCarry then
						-- load(7500, Config.Weed.Locale.Gathering)
						Citizen.CreateThread(PickAnimation)
						local status = exports.ox_lib:progressCircle({
							duration = 7500,
							label = Config.Weed.Locale.Gathering,
							useWhileDead = false,
							canCancel = true,
							disable = {
								car = true,
								move = true,
							},
						}) 
						
						if status then
							ClearAllHelpMessages()

							FreezeEntityPosition(PlayerPedId(), false)
							LocalPlayer.state.blockClearTasks = false
							ClearPedTasks(ped)

							TriggerServerEvent('stem_drugs:weed:pick')
						else
							FreezeEntityPosition(PlayerPedId(), false)
							LocalPlayer.state.blockClearTasks = false
							ClearPedTasks(ped)
						end
					else
						notif(Config.Weed.Locale.NoSpace)
					end
					busyg = false
				end,
				"weed_untrimmed",
				1
			)
		else
			Wait(500)
		end
	end
)

RegisterNetEvent("stem_drugs:weed:dry")
AddEventHandler(
	"stem_drugs:weed:dry",
	function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		if not busyd then
			busyd = true
			ESX.TriggerServerCallback(
				"stem_drugs:weed:quantity",
				function(quantity)
					if quantity >= 2 then
						local dryentity = CreateObject("bkr_prop_weed_drying_01a", coords.x + 0.35, coords.y - 0.2,
							coords.z + 1.2, false, false, false)
						FreezeEntityPosition(dryentity, true)
						PlayDryAnimation()
						load(9500, Config.Weed.Locale.Drying)
						Wait(10000)
						PlayDryAnimation()
						DeleteEntity(dryentity)
						TriggerServerEvent("stem_drugs:weed:dry")
						busyd = false
					else
						busyd = false
						notif(Config.Weed.Locale.NotEnoughUntrim)
					end
				end,
				"noire-weed"
			)
		end
	end
)


function PickAnimation()
	local ped = PlayerPedId()
	local animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
	local animName = "weed_spraybottle_crouch_spraying_02_inspector"
	RequestAnimDict(animDict)
	while (not HasAnimDictLoaded(animDict)) do
		Wait(0)
	end

	local closestProp = GetClosestObjectOfType(GetEntityCoords(ped), 5.0, GetHashKey("prop_weed_01"), true, false, false)
	TaskTurnPedToFaceEntity(ped, closestProp, 1500)
	while GetScriptTaskStatus(ped, 0xCBCE4595) ~= 7 do
		if not busyg then
			return
		end
		DisableAllControlActions(0)
		Wait(0)
	end

	local scene = NetworkCreateSynchronisedScene(GetEntityCoords(closestProp), vector3(0.0, 0.0, 0.0), 2, false, false,
		1.0, 0, 1.0)
	NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, animDict, animName, 8.0, -8.0, -1, 0, 0, 0)
	NetworkStartSynchronisedScene(scene)

	LocalPlayer.state.blockClearTasks = true
	LocalPlayer.state.invBusy = true
	FreezeEntityPosition(PlayerPedId(), true)
	local endTime = GetGameTimer() + 7500
	while GetGameTimer() < endTime do
		if not busyg then
			return
		end
		Wait(0)
	end
	FreezeEntityPosition(PlayerPedId(), false)
	NetworkStopSynchronisedScene(scene)
	LocalPlayer.state.blockClearTasks = false
	LocalPlayer.state.invBusy = false
end

function PlayDryAnimation()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 240.0)
	RequestAnimDict("amb@prop_human_movie_bulb@idle_a")
	while (not HasAnimDictLoaded("amb@prop_human_movie_bulb@idle_a")) do
		Wait(0)
	end

	local scene = NetworkCreateSynchronisedScene(GetEntityCoords(ped), vector3(0.0, 0.0, 0.0), 2, false, false, 1.0, 0,
		1.0)
	NetworkAddPedToSynchronisedScene(ped, scene, "amb@prop_human_movie_bulb@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, 0)
	NetworkStartSynchronisedScene(scene)

	LocalPlayer.state.blockClearTasks = true
	LocalPlayer.state.invBusy = true
	FreezeEntityPosition(PlayerPedId(), true)
	-- TaskPlayAnim(ped, "amb@prop_human_movie_bulb@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(2500)
	FreezeEntityPosition(PlayerPedId(), false)
	NetworkStopSynchronisedScene(scene)
	ClearPedTasks(ped)
	LocalPlayer.state.blockClearTasks = false
	LocalPlayer.state.invBusy = false
end


function notif(text)
	TriggerEvent("esx:showNotification", text)
end

CreateThread(
	function()
		if Config.Weed.Blips then
			local blips = {
				{
					title = Config.Weed.Locale.BlipWeed,
					colour = 2,
					id = 140,
					x = Config.Weed.Field.coords.x,
					y = Config.Weed.Field.coords.y,
					z = Config.Weed.Field.coords.z
				}
			}

			for _, dhm in pairs(blips) do
				dhm.blip = AddBlipForCoord(dhm.x, dhm.y, dhm.z)
				SetBlipSprite(dhm.blip, dhm.id)
				SetBlipDisplay(dhm.blip, 5)
				SetBlipScale(dhm.blip, 0.8)
				SetBlipColour(dhm.blip, dhm.colour)
				SetBlipAsShortRange(dhm.blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(dhm.title)
				EndTextCommandSetBlipName(dhm.blip)
			end
		end
	end
)
