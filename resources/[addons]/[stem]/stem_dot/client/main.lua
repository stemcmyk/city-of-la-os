local currentTask = {}
local GUI = {}
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ""
local CurrentActionData = {}
local OnJob = false
local TargetCoords = nil
local Blips = {}
local CurrentlyTowedVehicle = nil

GUI.Time = 0

local allowedTowModels = {
	["flatbed"] = {x = -0.4, y = -4.0, z = 1.0} -- default GTA V flatbed
}

local allowTowingBoats = false -- Set to true if you want to be able to tow boats.
local allowTowingPlanes = false -- Set to true if you want to be able to tow planes.
local allowTowingHelicopters = false -- Set to true if you want to be able to tow helicopters.
local allowTowingTrains = false -- Set to true if you want to be able to tow trains.
local allowTowingTrailers = true -- Disables trailers.

RegisterNetEvent("stem_dot:notifyCancelled")
AddEventHandler(
	"stem_dot:notifyCancelled",
	function(callData)
		local postal = exports["nearest-postal"]:getPostalNearCoords(callData.location)

		local streethash = GetStreetNameAtCoord(callData.location.x, callData.location.y, callData.location.z)
		local streetName = GetStreetNameFromHashKey(streethash)

		ESX.ShowHelpNotification("A call you accepted at " .. (postal and (postal .. " " .. streetName) or streetName) .. " has been cancelled by the caller.")
		PlaySoundFrontend(-1, "Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", true)
	end
)

RegisterNetEvent("stem_dot:notifyNewCall")
AddEventHandler(
	"stem_dot:notifyNewCall",
	function(callData)
		local postal = exports["nearest-postal"]:getPostalNearCoords(callData.location)

		local streethash = GetStreetNameAtCoord(callData.location.x, callData.location.y, callData.location.z)
		local streetName = GetStreetNameFromHashKey(streethash)

		ESX.ShowAdvancedNotification(
			"S.A DOT HQ", 
			"New Call", 
			"A new ~b~call~s~ is available at " .. (postal and (postal .. " " .. streetName) or streetName) .. ".", 
			"CHAR_LS_CUSTOMS"
		)
		PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", false)
	end
)

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Wait(0)
		end

		while ESX == nil do
			Citizen.Wait(1000)
		end

		local hash = GetHashKey("s_m_y_airworker")
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Wait(0)
		end

		local dotPed = CreatePed(4, hash, -182.6537, -1168.4948, 22.1302, 226.8055, false, true)
		while not DoesEntityExist(dotPed) do
			Wait(1000)
		end

		SetBlockingOfNonTemporaryEvents(dotPed, true)
		FreezeEntityPosition(dotPed, true)
		TaskStartScenarioInPlace(dotPed, "WORLD_HUMAN_SMOKING_POT", 0, true)

		exports.ox_target:addLocalEntity(dotPed, {
			{
				onSelect = function()
					OpenMecanoActionsMenu()
				end,
				canInteract = function()
					return true
				end,
				label = "D.O.T. Actions",
				groups = { "sadot" }
			}
		})

		exports.ox_target:addGlobalVehicle({
			{
				bones = {"seat_dside_f", "seat_pside_f"},
				onSelect = function(data)
					TriggerEvent("stem_dot:hijackVehicle", data.entity)
				end,
				distance = 1.5,
				icon = "fas fa-lock-open",
				label = "Force Open Vehicle",
				groups = { "sadot" }
			},
			
			{
				onSelect = function(data)
					TriggerEvent("stem_dot:repairVehicle", data.entity)
				end,
				icon = "fas fa-wrench",
				label = "Repair Vehicle",
				groups = { "sadot" }
			},
			
			{
				onSelect = function(data)
					TriggerEvent("stem_dot:flipVehicle", data.entity)
				end,
				icon = "fa-solid fa-repeat",
				label = "Flip Vehicle",
				groups = { "sadot" }
			},
		})

		exports.ox_target:addGlobalPlayer({
			{
				onSelect = function (data)
                    local player = NetworkGetPlayerIndexFromPed(data.entity)
					TriggerEvent("stem_common:payment_terminal:beginTerminal", GetPlayerServerId(player), nil, {
						job = "sadot"
					})
				end,
				icon = "fa-solid fa-file-invoice-dollar",
				label = "Send Bill",
				groups = { "sadot" }
			}
		})
	end
)

function OpenMobileMecanoActionsMenu()
	lib.registerContext({
		id = "mobile_mechanic",
		title = "Mobile Mechanic",
		options = {
			{
				title = "Available Calls",
				onSelect = function () 
					ESX.TriggerServerCallback(
						"stem_dot:fetchCalls",
						function(calls)
							local newCalls = exports.stem_common:tableMap(calls, function (call) 
								local postal = exports["nearest-postal"]:getPostalNearCoords(call.location)
								local streetHash = GetStreetNameAtCoord(call.location.x, call.location.y, call.location.z)
								local streetName = GetStreetNameFromHashKey(streetHash)

								return {
									title = string.format("%s ET - %s (%s)", call.displayTime, postal and (postal .. " " .. streetName) or streetName, #call.accepted),
									timestamp = call.timestamp,
									onSelect = function ()
										TriggerServerEvent("stem_dot:acceptCall", call.player)
										SetWaypointOff()
										SetNewWaypoint(call.location.x, call.location.y)
										ESX.ShowNotification("A **waypoint** has been set!")
									end
								}
							end)

							table.sort(newCalls, function(a, b) 
								return a.timestamp > b.timestamp
							end)
							
							lib.registerContext({
								title = "Recent Calls",
								id = "recent_calls",
								options = newCalls,
							})

							lib.showContext("recent_calls")
						end
					)
				end
			},
			{
				title = "Send To Insurance",
				event = "stem_dot:sendToInsurance"
			}
		}
	})
	lib.showContext("mobile_mechanic")
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function isTargetVehicleATrailer(modelHash)
	if GetVehicleClassFromName(modelHash) == 11 then
		return true
	else
		return false
	end
end

function isVehicleATowTruck(vehicle)
	local isValid = false
	for model, posOffset in pairs(allowedTowModels) do
		if IsVehicleModel(vehicle, model) then
			xoff = posOffset.x
			yoff = posOffset.y
			zoff = posOffset.z
			isValid = true
			break
		end
	end
	return isValid
end

local xoff = 0.0
local yoff = 0.0
local zoff = 0.0

RegisterNetEvent("stem_dot:sendToInsurance", function () 
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	ESX.ShowHelpNotification("Sending vehicle to insurance")
	TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)

	currentTask.busy = true
	currentTask.task =
		ESX.SetTimeout(
		10000,
		function()
			ClearPedTasks(playerPed)
			ImpoundVehicle(vehicle)
			Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
		end
	)

	-- keep track of that vehicle!
	Citizen.CreateThread(
		function()
			while currentTask.busy do
				Citizen.Wait(1000)

				vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
				if (not DoesEntityExist(vehicle) or exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId())))) and currentTask.busy then
					ESX.ShowNotification("Could not send to insurance")
					ESX.ClearTimeout(currentTask.task)
					ClearPedTasks(playerPed)
					currentTask.busy = false
					break
				end
			end
		end
	)
end)

RegisterNetEvent("stem_dot:onHijack")
AddEventHandler(
	"stem_dot:onHijack",
	function()
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local vehicle = nil

			if IsPedInAnyVehicle(playerPed, false) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
			else
				vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			end

			local crochete = math.random(100)
			local alarm = math.random(100)

			if DoesEntityExist(vehicle) then
				if alarm <= 33 then
					SetVehicleAlarm(vehicle, true)
					StartVehicleAlarm(vehicle)
				end
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
				Citizen.CreateThread(
					function()
						Citizen.Wait(10000)
						if crochete <= 66 then
							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification(_U("veh_unlocked"))
						else
							ESX.ShowNotification(_U("hijack_failed"))
							ClearPedTasksImmediately(playerPed)
						end
					end
				)
			end
		end
	end
)

RegisterNetEvent("stem_dot:attachVehicle")
AddEventHandler("stem_dot:attachVehicle", function (vehicle) 
	local playerped = PlayerPedId()
	local isVehicleTow = isVehicleATowTruck(vehicle)

	if isVehicleTow then
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)

		if currentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				local targetVehicleLocation = GetEntityCoords(targetVehicle, true)
				local towTruckVehicleLocation = GetEntityCoords(vehicle, true)
				local distanceBetweenVehicles = GetDistanceBetweenCoords(targetVehicleLocation, towTruckVehicleLocation, false)

				if distanceBetweenVehicles > 12.0 then
					lib.notify({
						type = "error",
						title = "Your cables can't reach. Move your truck closer"
					})
				else
					local targetModelHash = GetEntityModel(targetVehicle)
					if
						not ((not allowTowingBoats and IsThisModelABoat(targetModelHash)) or (not allowTowingHelicopters and IsThisModelAHeli(targetModelHash)) or
							(not allowTowingPlanes and IsThisModelAPlane(targetModelHash)) or
							(not allowTowingTrains and IsThisModelATrain(targetModelHash)) or
							(not allowTowingTrailers and isTargetVehicleATrailer(targetModelHash)))
					 then
						if not IsPedInAnyVehicle(playerped, true) then
							if vehicle ~= targetVehicle and IsVehicleStopped(vehicle) then
								local progress = lib.progressBar({
									label = "Attaching Vehicle",
									anim = {
										scenario = "PROP_HUMAN_BUM_BIN"
									},
									duration = 5000,
								})
								ClearPedTasksImmediately(PlayerPedId())

								AttachEntityToEntity(targetVehicle, vehicle, 20, 0.0 + xoff, -1.5 + yoff, 0.0 + zoff, 0, 0, 0, 1, 1, 0, 1, 0, 1)
								currentlyTowedVehicle = targetVehicle

								lib.notify({
									type = "success",
									title = _U("vehicle_success_attached")
								})
							else
								lib.notify({
									type = "error",
									title = "There is currently no vehicle on the flatbed."
								})
							end
						else
							lib.notify({
								type = "error",
								title = "You need to be outside of your vehicle to load or unload vehicles."
							})
						end
					else
						lib.notify({
							type = "error",
							title = "You cannot tow this vehicle"
						})
					end
				end
			else
				lib.notify({
					type = "error",
					title = "No towable vehicle detected."
				})
			end
		elseif IsVehicleStopped(vehicle) then
			local progress = lib.progressBar({
				label = "Detaching Vehicle",
				anim = {
					scenario = "PROP_HUMAN_BUM_BIN"
				},
				duration = 5000,
			})
			ClearPedTasksImmediately(PlayerPedId())
			DetachEntity(currentlyTowedVehicle, false, false)
			local vehiclesCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -11.0, 0.0)
			SetEntityCoords(currentlyTowedVehicle, vehiclesCoords["x"], vehiclesCoords["y"], vehiclesCoords["z"], 1, 0, 0, 1)
			SetVehicleOnGroundProperly(currentlyTowedVehicle)
			currentlyTowedVehicle = nil
			lib.notify({
				type = "success",
				title =  _U("veh_det_succ")
			})
		end
	else
		lib.notify({
			type = "error",
			title = "You need a flatbed"
		})
	end
end)

RegisterNetEvent("stem_dot:flipVehicle")
AddEventHandler(
	"stem_dot:flipVehicle", function (vehicle)
		local model = GetEntityModel(vehicle)
		if not IsThisModelABike(model) and not IsThisModelACar(model) then
			lib.notify({
				type = "error",
				title = "Could not flip vehicle over"
			})
			return
		end

		if SetVehicleOnGroundProperly(vehicle) then
			lib.notify({
				type = "success",
				title = "Vehicle flipped over"
			})
		else
			lib.notify({
				type = "error",
				title = "Could not flip vehicle over"
			})
		end
	end
)
RegisterNetEvent("stem_dot:onCarokit")
AddEventHandler(
	"stem_dot:onCarokit",
	function()
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local vehicle = nil

			if IsPedInAnyVehicle(playerPed, false) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
			else
				vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			end

			if DoesEntityExist(vehicle) then
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HAMMERING", 0, true)
				Citizen.CreateThread(
					function()
						Citizen.Wait(10000)
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowNotification(_U("body_repaired"))
					end
				)
			end
		end
	end
)

AddEventHandler(
	"stem_dot:hijackVehicle",
	function(vehicle)
		local playerPed = PlayerPedId()
		if DoesEntityExist(vehicle) then
			
			LocalPlayer.state.blockClearTasks = true
			LocalPlayer.state.invBusy = true

			local progress = lib.progressCircle({
				duration = 10000,
				label = "Unlocking Vehicle",
				disable = {
					move = true,
				},
				anim = {
					scenario = "WORLD_HUMAN_WELDING",
				},
				canCancel = true
			})
			if (progress) then
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				lib.notify({
					type = "success",
					title = _U("vehicle_unlocked")
				})
			end
			LocalPlayer.state.blockClearTasks = false
			LocalPlayer.state.invBusy = false
		end
	end
)

AddEventHandler(
	"stem_dot:repairVehicle",
	function(vehicle)
		local playerPed = PlayerPedId()
		if DoesEntityExist(vehicle) then
			
			LocalPlayer.state.blockClearTasks = true
			LocalPlayer.state.invBusy = true

			local offset = GetOffsetFromEntityInWorldCoords(vehicle, 0, 3.0, 0)

			local heading = GetEntityHeading(vehicle) + 180.0
			if heading > 360.0 then
				heading = heading - 360.0
			end

			LocalPlayer.state.blockClearTasks = true

			TaskGoStraightToCoord(playerPed, offset, 1.0, 7500, heading, 0.05)
			Citizen.Wait(5000)

			-- SetVehicleDoorOpen(vehicle, 4, false, false)
			
			local veh = NetToVeh(VehToNet(vehicle))
			if DoesEntityExist(veh) then
				SetVehicleDoorOpen(veh, 4, false, false)
			end

			local progress = lib.progressCircle({
				duration = 7500,
				label = "Repairing Vehicle",
				disable = {
					move = true,
				},
				anim = {
					scenario = "PROP_HUMAN_BUM_BIN",
				},
				canCancel = true
			})
			if (progress) then
				SetVehicleFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, true, true)
				SetVehicleEngineCanDegrade(vehicle, true)

				local plate = GetVehicleNumberPlateText(vehicle)
				exports["wasabi_carlock"]:GiveKey(plate)
				
				ClearPedTasksImmediately(playerPed)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				
				lib.notify({
					type = "success",
					title = _U("vehicle_repaired")
				})
			end
			SetVehicleDoorShut(veh, 4, false, false)

			LocalPlayer.state.blockClearTasks = false
			LocalPlayer.state.invBusy = false
		end
	end
)

-- Key Controls
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat("STRING")
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38) and ESX and ESX.PlayerData.job.name == "sadot" then
					if CurrentAction == "delete_vehicle" then
						if Config.EnableSocietyOwnedVehicles then
							local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
							TriggerServerEvent("esx_society:putVehiclecookiesInGarage", "mecano", vehicleProps)
						else
							if GetEntityModel(vehicle) == GetHashKey("flatbed") or GetEntityModel(vehicle) == GetHashKey("slamvan3") then
								TriggerServerEvent("esx_service:disableService", "mecano")
							end
						end

						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					end

					CurrentAction = nil
				end
			end

			if IsControlJustReleased(0, 167) and ESX and ESX.PlayerData.job.name == "sadot" then
				OpenMobileMecanoActionsMenu()
			end
		end
	end
)

function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U("impound_successful"))
	currentTask.busy = false
end

function OpenMecanoActionsMenu()
	local options = { 
		Config.EnablePlayerManagement and ESX.PlayerData.job.name == 'sadot' and ESX.PlayerData.job.grade >= 3 and {
			title = _U("boss_actions"),
			onSelect = function () 
				TriggerEvent(
					"esx_society:openBossMenu",
					"sadot",
					function(data, menu)
						menu.close()
					end,
					{
						withdraw = true,
						checkbalance = true
					}
				)
			end
		} or false,
		-- Vehicle list
		{
			title = _U("vehicle_list"),
			onSelect = function ()
				if Config.EnableSocietyOwnedVehicles then
					ESX.TriggerServerCallback(
						"esx_society:getVehiclesInGarage",
						function(vehicles)
							lib.registerConext({
								id = "vehicle_spawner",
								title = _U("service_vehicle"),
								options = exports.stem_common:tableFilter(exports.stem_common:tableMap(vehicles, function (vehicle) 
									return {
										label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. " [" .. vehicles[i].plate .. "]",
										onSelect = function () 
											TriggerServerEvent("esx_society:removeVehicleFromGarage", "sadot", vehicleProps)
										end
									}
								end))
							})
							lib.showContext("vehicle_spawner")
						end,
						"sadot"
					)
				else
					local vehicles = {
						{
							title = _U("flat_bed"), 
							value = "c3f350rollback"
						},
						ESX.PlayerData.job.grade >= 2 and {
							title = "2016 Dodge Ram 2500 Dually", 
							value = "dot16ramd"
						} or false,
						ESX.PlayerData.job.grade >= 2 and {
							title = "D.O.T. Gooseneck", 
							value = "dotgooseneck"
						} or false
					}
					
					lib.registerContext({
						id = "vehicle_spawner",
						title = _U("service_vehicle"),
						options = exports.stem_common:tableMap(exports.stem_common:tableFilter(vehicles), function (vehicle) 
							return {
								title = vehicle.title,
								onSelect = function () 
									if Config.MaxInService == -1 then
										ESX.TriggerServerCallback(
											"stem_dot:createVeh",
											function(vehNetId)
												while not NetworkDoesEntityExistWithNetworkId(vehNetId) do
													Citizen.Wait(0)
												end
				
												local vehicle = NetToVeh(vehNetId)
				
												local playerPed = PlayerPedId()
												TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				
												while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
													Citizen.Wait(0)
												end
				
												local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
												exports["wasabi_carlock"]:GiveKey(plate)
												Entity(vehicle).state:set("fuel", 100, true)
											end,
											vehicle.value,
											vector4(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z, Config.Zones.VehicleSpawnPoint.Heading)
										)
									end
								end
							}
						end)
					})
					lib.showContext("vehicle_spawner")

				end
			end
		},
		{
			title = "Get Radio",
			onSelect = function ( ) 

				TriggerServerEvent("stem_dot:getRadio")
			end
		},
		-- {
		-- 	title = "Get SprayPaint Remover",
		-- 	function ( ) 
		-- 		TriggerServerEvent("stem_dot:getSprayRemover")
		-- 	end
		-- },
		{
			title = _U("civ_wear"),
			onSelect = function ()
				TriggerEvent("raid_clothes:LoadYourClothes")
			end
		}
	}

	lib.registerContext({
		id = "mechanic_actions",
		title = _U("mechanic"),
		options = exports.stem_common:tableFilter(options)
	})

	lib.showContext("mechanic_actions")
end
