-- ESX = nil

local car, h
local _wheel, _base, _lights1, _lights2, _arrow1, _arrow2 = nil, nil, nil, nil, nil, nil
local _podiumModel = vector3(970.05, 460.3, 80.33)

local m1a = GetHashKey("vw_prop_vw_luckylight_off")
local m1b = GetHashKey("vw_prop_vw_luckylight_on")
local m2a = GetHashKey("vw_prop_vw_jackpot_off")
local m2b = GetHashKey("vw_prop_vw_jackpot_on")
local vehicle;

LocalPlayer.state:set("luckywheel", nil, nil)

local _wheelPos = Config_LuckyWheel.WheelPos

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Wait(1000)
		end

		ESX.TriggerServerCallback(
			"stem_casino:getPodiumVehicle",
			function(_car)
				car = _car
			end
		)

		local model1 = GetHashKey("vw_prop_vw_luckywheel_02a")
		local model2 = GetHashKey("vw_prop_vw_luckywheel_01a")
		local podiumModel = GetHashKey("vw_prop_vw_casino_podium_01a")

		if Config_LuckyWheel.SpawnWheel == false then
			local o = GetClosestObjectOfType(Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z, 2.5,
				GetHashKey("vw_prop_vw_luckywheel_01a"), 0, 0, 0)
			local o1 = GetClosestObjectOfType(Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z, 2.5,
				GetHashKey("vw_prop_vw_jackpot_on"), 0, 0, 0)
			local o2 = GetClosestObjectOfType(Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z, 2.5,
				GetHashKey("vw_prop_vw_luckylight_on"), 0, 0, 0)
			if DoesEntityExist(o) then
				Config_LuckyWheel.WheelPos.x = GetEntityCoords(o).x
				Config_LuckyWheel.WheelPos.y = GetEntityCoords(o).y - 1.0
				Config_LuckyWheel.WheelPos.z = GetEntityCoords(o).z + 0.2593
				Config_LuckyWheel.WheelPos.h = GetEntityHeading(o)
				SetModelAsNoLongerNeeded(o, true, true)
				SetEntityCollision(o, false, false)
				SetEntityVisible(o, false)

				SetModelAsNoLongerNeeded(o1, true, true)
				SetEntityCollision(o1, false, false)
				SetEntityVisible(o1, false)

				SetModelAsNoLongerNeeded(o2, true, true)
				SetEntityCollision(o2, false, false)
				SetEntityVisible(o2, false)
			end
		end

		Citizen.CreateThread(
			function()
				RequestModel(model1)
				while not HasModelLoaded(model1) do
					Citizen.Wait(0)
				end
				RequestModel(model2)
				while not HasModelLoaded(model2) do
					Citizen.Wait(0)
				end

				RequestModel(m1a)
				while not HasModelLoaded(m1a) do
					Citizen.Wait(0)
				end
				RequestModel(m1b)
				while not HasModelLoaded(m1b) do
					Citizen.Wait(0)
				end
				RequestModel(m2a)
				while not HasModelLoaded(m2a) do
					Citizen.Wait(0)
				end
				RequestModel(m2b)
				while not HasModelLoaded(m2b) do
					Citizen.Wait(0)
				end

				ClearArea(Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z, 5.0, true, false, false, false)

				_wheel = CreateObject(model1, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z + 0.26, false,
					false, true)
				SetEntityHeading(_wheel, Config_LuckyWheel.WheelPos.h)
				SetModelAsNoLongerNeeded(model1)

				_base = CreateObject(model2, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z, false, false, true)
				SetEntityHeading(_base, Config_LuckyWheel.WheelPos.h)
				SetModelAsNoLongerNeeded(_base)

				_lights1 = CreateObject(m1a, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z + 0.26 + 0.35, false,
					false, true)
				SetEntityHeading(_lights1, Config_LuckyWheel.WheelPos.h)
				SetModelAsNoLongerNeeded(_lights1)

				_lights2 = CreateObject(m1b, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z + 0.26 + 0.35, false,
					false, true)
				SetEntityVisible(_lights2, false, 0)
				SetEntityHeading(_lights2, Config_LuckyWheel.WheelPos.h)
				SetModelAsNoLongerNeeded(_lights2)

				_arrow1 = CreateObject(m2a, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z + 0.26 + 2.5, false,
					false, true)
				SetEntityHeading(_arrow1, Config_LuckyWheel.WheelPos.h)
				SetModelAsNoLongerNeeded(_arrow1)

				_arrow2 = CreateObject(m2b, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z + 0.26 + 2.5, false,
					false, true)
				SetEntityVisible(_arrow2, false, 0)
				SetEntityHeading(_arrow2, Config_LuckyWheel.WheelPos.h)
				SetModelAsNoLongerNeeded(_arrow2)

				RequestModel(podiumModel)
				while not HasModelLoaded(podiumModel) do
					Citizen.Wait(0)
				end

				_podiumModel = CreateObject(podiumModel, _podiumModel.x, _podiumModel.y, _podiumModel.z, false, false,
					true)
				SetEntityHeading(_podiumModel, 0.0)
				SetModelAsNoLongerNeeded(podiumModel)

				h = GetEntityRotation(_wheel)
			end
		)

		exports.qtarget:AddTargetModel(
			{ GetHashKey("vw_prop_vw_luckywheel_01a"), GetHashKey("vw_prop_vw_luckywheel_02a") },
			{
				options = {
					{
						action = function()
							TriggerServerEvent("stem_casino:forceResetWheel")
						end,
						canInteract = function()
							return GlobalState.LuckyWheel ~= nil
						end,
						label = "Force Reset Wheel",
						job = "casino"
					}
				},
				distance = 2
			}
		)
	end
)

local heading = Config_LuckyWheel.VehiclePos.h
Citizen.CreateThread(
	function()
		while not LocalPlayer.state.switchComplete do
			Wait(0)
		end

		while true do
			Citizen.Wait(100)

			if Config_LuckyWheel.SpawnWheel == false then
				local o = GetClosestObjectOfType(Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z, 2.5,
					GetHashKey("ch_prop_casino_lucky_wheel_01a"), 0, 0, 0)
				SetEntityCollision(o, false, false)
				SetEntityVisible(o, false)
				if DoesEntityExist(o) and GetEntityCoords(o) ~= GetEntityCoords(_wheel) then
					Config_LuckyWheel.WheelPos.x = GetEntityCoords(o).x
					Config_LuckyWheel.WheelPos.y = GetEntityCoords(o).y - 2.0
					Config_LuckyWheel.WheelPos.z = GetEntityCoords(o).z
					Config_LuckyWheel.WheelPos.h = GetEntityHeading(o)
					SetEntityCoords(_wheel, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z + 1.50)
					SetEntityCoords(_base, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z)

					SetEntityCoords(_lights1, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z)
					SetEntityCoords(_lights2, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z)
					SetEntityCoords(_arrow1, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z)
					SetEntityCoords(_arrow2, Config_LuckyWheel.WheelPos.x, Config_LuckyWheel.WheelPos.y, Config_LuckyWheel.WheelPos.z)

					SetEntityHeading(_lights1, Config_LuckyWheel.WheelPos.h)
					SetEntityHeading(_lights2, Config_LuckyWheel.WheelPos.h)
					SetEntityHeading(_arrow1, Config_LuckyWheel.WheelPos.h)
					SetEntityHeading(_arrow2, Config_LuckyWheel.WheelPos.h)
					SetEntityHeading(_wheel, Config_LuckyWheel.WheelPos.h)
					SetEntityHeading(_base, Config_LuckyWheel.WheelPos.h)
				end
			end

			if #(GetEntityCoords(PlayerPedId()) - vector3(Config_LuckyWheel.VehiclePos.x, Config_LuckyWheel.VehiclePos.y, Config_LuckyWheel.VehiclePos.z)) < 40 then
				if not DoesEntityExist(vehicle) then
					if car then
						local vehProps = json.decode(car.vehicle)
						RequestModel(vehProps.model)
						while not HasModelLoaded(vehProps.model) do
							Wait(0)
						end

						vehicle = CreateVehicle(vehProps.model, Config_LuckyWheel.VehiclePos.x, Config_LuckyWheel.VehiclePos.y,
							Config_LuckyWheel.VehiclePos.z, 0.0, false, false)

						SetVehicleOnGroundProperly(vehicle)
						FreezeEntityPosition(vehicle, true)
						SetEntityInvincible(vehicle, true)
						SetVehicleColours(vehicle, 62, 159)
						SetEntityCoords(vehicle, Config_LuckyWheel.VehiclePos.x, Config_LuckyWheel.VehiclePos.y, Config_LuckyWheel.VehiclePos.z, false,
							false, false, true)

						-- local props = ESX.Game.GetVehicleProperties(vehicle)
						-- props["wheelColor"] = 147
						-- props["plate"] = "GETLUCKY"

						ESX.Game.SetVehicleProperties(vehicle, vehProps)
						SetVehicleDirtLevel(vehicle, 0.0)
						SetVehicleDoorsLocked(vehicle, 2)
					end
				end
			else
				Citizen.Wait(1000)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			if _podiumModel ~= nil then
				local _heading = GetEntityHeading(_podiumModel)
				local _z = _heading - 0.05
				SetEntityHeading(_podiumModel, _z)
			end

			if Config_LuckyWheel.VehicleRot == true and DoesEntityExist(vehicle) then
				local _heading = GetEntityHeading(vehicle)
				local _z = _heading - 0.05
				SetEntityHeading(vehicle, _z)
			end

			Citizen.Wait(0)
		end
	end
)

RegisterNetEvent(
	"stem_casino:helpNotify",
	function(label, arg1)
		BeginTextCommandDisplayHelp(label)
		if arg1 then
			AddTextComponentInteger(arg1)
		end
		EndTextCommandDisplayHelp(0, false, true, -1)
	end
)


RegisterNetEvent(
	"stem_casino:carWon",
	function(nCar, winner, vehNetId)
		local maxTime = GetGameTimer() + 5000
		while not NetworkDoesEntityExistWithNetworkId(vehNetId) and GetGameTimer() < maxTime do
			Wait(0)
		end


		if NetworkDoesEntityExistWithNetworkId(vehNetId) then
			local nVehicle = NetworkGetEntityFromNetworkId(vehNetId)

			if winner == GetPlayerServerId(PlayerId()) then
				Wait(5000)

				DoScreenFadeOut(2500)
				while not IsScreenFadedOut() do
					Wait(0)
				end

				car = nil
				DeleteEntity(vehicle)
				local car = nCar

				SetPedIntoVehicle(PlayerPedId(), nVehicle, -1)
				while not NetworkHasControlOfEntity(nVehicle) do
					Wait(0)
				end

				local vehProps = json.decode(car.vehicle)
				ESX.Game.SetVehicleProperties(nVehicle, vehProps)

				Wait(1000)

				exports["esx-sna-fuel"]:SetFuel(nVehicle, 100)
				Entity(nVehicle).state:set("fuel", 100, true)
				exports.wasabi_carlock:GiveKey(vehProps.plate)

				DoScreenFadeIn(2500)
				while not IsScreenFadedIn() do
					Wait(0)
				end

				Wait(1000)
				SetVehicleEngineOn(nVehicle, true, false, true)
			end
		end

		car = nil
	end
)

RegisterNetEvent(
	"stem_casino:restrictWeaponControls",
	function()
		local job = LocalPlayer.state.job?.name
		if job == 'lspd' or job == 'sahp' or job == 'lscso' or job == 'casino' then
			return
		end

		local plyPed = PlayerPedId()

		local interior = GetInteriorFromEntity(plyPed)
		if interior ~= 0 then
			while GetInteriorFromEntity(plyPed) ~= 0 do
				local currentWeapon = exports.ox_inventory:getCurrentWeapon()
				if currentWeapon then
					TriggerEvent('ox_inventory:disarm', true)
				end
				Wait(0)
			end
		end
	end
)

RegisterNetEvent("stem_casino:syncWheelAnim")
AddEventHandler(
	"stem_casino:syncWheelAnim",
	function()
		doRoll(0)
	end
)

RegisterNetEvent("stem_casino:startWheelRoll")
AddEventHandler(
	"stem_casino:startWheelRoll",
	function(s, index, p)
		-- Citizen.Wait(1000)
		SetEntityVisible(_lights1, false, 0)
		SetEntityVisible(_lights2, true, 0)
		win = (index - 1) * 18 + 0.0
		local j = 360

		if DoesEntityExist(_wheel) then
			PlaySoundFromEntity(-1, "Spin_Start", _wheel, "dlc_vw_casino_lucky_wheel_sounds", false, 1)
		end

		for i = 1, 1100, 1 do
			SetEntityRotation(_wheel, h.x, j + 0.0, h.z, 0, false)
			if i < 50 then
				j = j - 1.5
			elseif i < 100 then
				j = j - 2.0
			elseif i < 150 then
				j = j - 2.5
			elseif i > 1060 then
				j = j - 0.3
			elseif i > 1030 then
				j = j - 0.6
			elseif i > 1000 then
				j = j - 0.9
			elseif i > 970 then
				j = j - 1.2
			elseif i > 940 then
				j = j - 1.5
			elseif i > 910 then
				j = j - 1.8
			elseif i > 880 then
				j = j - 2.1
			elseif i > 850 then
				j = j - 2.4
			elseif i > 820 then
				j = j - 2.7
			else
				j = j - 3.0
			end
			if i == 850 then
				j = math.random(win - 4, win + 10) + 0.0
			end
			if j > 360 then
				j = j + 0
			end
			if j < 0 then
				j = j + 360
			end
			if i == 900 then
			end
			Citizen.Wait(0)
		end

		Citizen.Wait(300)
		SetEntityVisible(_arrow1, false, 0)
		SetEntityVisible(_arrow2, true, 0)
		local t = true

		PlaySoundFromEntity(-1, "Win", _wheel, "dlc_vw_casino_lucky_wheel_sounds", true, 1)
		SetVariableOnSound(-1, 1.0)

		if s == GetPlayerServerId(PlayerId()) then
			if p.sound == "car" then
				PlaySoundFromEntity(-1, "Win_Car", _wheel, "dlc_vw_casino_lucky_wheel_sounds", 1, 1)
			elseif p.sound == "cash" then
				PlaySoundFromEntity(-1, "Win_Cash", _wheel, "dlc_vw_casino_lucky_wheel_sounds", 1, 1)
			elseif p.sound == "chips" then
				PlaySoundFromEntity(-1, "Win_Chips", _wheel, "dlc_vw_casino_lucky_wheel_sounds", 1, 1)
			elseif p.sound == "clothes" then
				PlaySoundFromEntity(-1, "Win_Clothes", _wheel, "dlc_vw_casino_lucky_wheel_sounds", 1, 1)
			elseif p.sound == "mystery" then
				PlaySoundFromEntity(-1, "Win_Mystery", _wheel, "dlc_vw_casino_lucky_wheel_sounds", 1, 1)
			end

			local playerPed = PlayerPedId()
			local _lib = "anim_casino_a@amb@casino@games@lucky7wheel@female"
			if IsPedMale(playerPed) then
				_lib = "anim_casino_a@amb@casino@games@lucky7wheel@male"
			end
			local lib, anim = _lib, "enter_right_to_baseidle"

			ClearPedTasks(playerPed)

			local scene = NetworkCreateSynchronisedScene(GetEntityCoords(_base), GetEntityRotation(_base), 2, false,
				false, 1.0, 0.0, 1.0)

			local animName = "Win"
			if p.sound == "car" then
				animName = "Win_Huge"
			elseif p.sound == "mystery" then
				animName = "Win_Big"
			end

			NetworkAddPedToSynchronisedScene(playerPed, scene, lib, animName, 2.0, -2.0, 5, 0, 1000.0, 0)
			NetworkStartSynchronisedScene(scene)

			LocalPlayer.state.blockClearTasks = false
		end

		for i = 1, 15, 1 do
			Citizen.Wait(200)
			SetEntityVisible(_lights1, t, 0)
			SetEntityVisible(_arrow2, t, 0)
			t = not t
			SetEntityVisible(_lights2, t, 0)
			SetEntityVisible(_arrow1, t, 0)
			if i == 5 then
				if s == GetPlayerServerId(PlayerId()) then
					LocalPlayer.state:set("luckywheel", "done", true)
					-- TriggerServerEvent("luckywheel:give", s, p)
				end
			end
		end

		Citizen.Wait(1000)
		SetEntityVisible(_lights1, true, 0)
		SetEntityVisible(_lights2, false, 0)
		SetEntityVisible(_arrow1, true, 0)
		SetEntityVisible(_arrow2, false, 0)
		TriggerServerEvent("stem_casino:wheelStopRoll")

		SetEntityRotation(_wheel, h.x, 0.0, h.z, 0, false)
	end
)

function doRoll(index)
	if not LocalPlayer.state.luckywheel then
		LocalPlayer.state.blockClearTasks = true
		LocalPlayer.state:set("luckywheel", "spinning", true)

		local playerPed = PlayerPedId()
		local _lib = "anim_casino_a@amb@casino@games@lucky7wheel@female"
		if IsPedMale(playerPed) then
			_lib = "anim_casino_a@amb@casino@games@lucky7wheel@male"
		end
		local lib, anim = _lib, "enter_right_to_baseidle"

		local scene = NetworkCreateSynchronisedScene(GetEntityCoords(_base), GetEntityRotation(_base), 2, false, false,
			1.0, 0.0, 1.0)
		NetworkAddPedToSynchronisedScene(playerPed, scene, lib, "ArmRaisedIDLE_to_SpinningIDLE_Med", 8.0, -1.5, 5, 0,
			1000.0, 0)
		NetworkStartSynchronisedScene(scene)
		while GetSynchronizedScenePhase(NetworkGetLocalSceneFromNetworkId(scene)) < 0.99 do
			DisableAllControlActions(0)
			Wait(0)
		end

		scene = NetworkCreateSynchronisedScene(GetEntityCoords(_base), GetEntityRotation(_base), 2, false, false, 1.0,
			0.0, 1.0)
		NetworkAddPedToSynchronisedScene(playerPed, scene, lib, "SpinningIDLE_High", 1.5, -2.0, 5, 0, 1000.0, 0)
		NetworkStartSynchronisedScene(scene)
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			local coords = GetEntityCoords(PlayerPedId())
			local model = GetEntityModel(PlayerPedId())

			if
				#(coords - vector3(965.75, 48.73, 81.62)) < 2.0 and (model == GetHashKey("mp_m_freemode_01") or model == GetHashKey("mp_f_freemode_01")) and
				not LocalPlayer.state.luckywheel and
				not GlobalState.LuckyWheel
			then
				local canPlay = false
				if (GlobalState.jobCount["casino"] and GlobalState.jobCount["casino"] >= 1) or LocalPlayer.state.casinoVIP then
					canPlay = true
					ESX.ShowHelpNotification(GetLabelText("LW_PLAY"))
				else
					ESX.ShowHelpNotification(GetLabelText("CASINO_LUCK_WD"))
				end

				if canPlay and IsControlJustReleased(0, 38) then
					local serverResp = nil
					ESX.TriggerServerCallback('stem_casino:canSpinWheel', function(resp)
						serverResp = resp
					end)

					while serverResp == nil do
						Wait(0)
					end

					if serverResp then
						TriggerServerEvent("stem_casino:wheelUsing")

						local playerPed = PlayerPedId()
						local _lib = "anim_casino_a@amb@casino@games@lucky7wheel@female"
						if IsPedMale(playerPed) then
							_lib = "anim_casino_a@amb@casino@games@lucky7wheel@male"
						end
						local lib, anim = _lib, "enter_right_to_baseidle"

						RequestAnimDict(lib)
						while not HasAnimDictLoaded(lib) do
							Wait(0)
						end

						LocalPlayer.state.blockClearTasks = true

						-- local animPos = GetAnimInitialOffsetPosition(lib, "Enter_to_ArmRaisedIDLE", vector3(978.0117, 50.3486, 73.676109), 0, 0, 0, 0, 2)
						-- local animRot = GetAnimInitialOffsetRotation(lib, "Enter_to_ArmRaisedIDLE", vector3(978.0117, 50.3486, 73.676109), 0, 0, 0, 0, 2)

						-- local _movePos = GetObjectOffsetFromCoords(GetEntityCoords(_base), GetEntityHeading(_base), -1.314819, -0.847443, 0.0)
						local _movePos = GetObjectOffsetFromCoords(GetEntityCoords(_base), GetEntityHeading(_base),
							-1.277710,
							-0.628174, 0.0)

						TaskGoStraightToCoord(playerPed, _movePos, 1.0, 5000, GetEntityHeading(_base), 0.001)
						while GetScriptTaskStatus(playerPed, GetHashKey("SCRIPT_TASK_GO_STRAIGHT_TO_COORD")) ~= 7 do
							Wait(0)
						end

						SetEntityHeading(playerPed, GetEntityHeading(_base))

						local scene = NetworkCreateSynchronisedScene(GetEntityCoords(_base), GetEntityRotation(_base), 2,
							false, false, 1.0, 0.0, 1.0)
						NetworkAddPedToSynchronisedScene(playerPed, scene, lib, "Enter_to_ArmRaisedIDLE", 2.0, -2.0, 5, 0,
							1000.0, 0)
						NetworkStartSynchronisedScene(scene)

						while GetSynchronizedScenePhase(NetworkGetLocalSceneFromNetworkId(scene)) < 0.99 do
							DisableAllControlActions(0)
							Wait(0)
						end

						scene = NetworkCreateSynchronisedScene(GetEntityCoords(_base), GetEntityRotation(_base), 2, false,
							true, 1.0, 0.0, 1.0)
						NetworkAddPedToSynchronisedScene(playerPed, scene, lib, "ArmRaisedIDLE", 4.0, -4.0, 5, 0, 1000.0,
							0)
						NetworkStartSynchronisedScene(scene)

						while true do
							ESX.ShowHelpNotification(GetLabelText("LUCK_W_SPIN_PC"), true)

							Citizen.Wait(0)
							DisableAllControlActions(0)

							if IsDisabledControlJustPressed(0, 33) then
								local resolved = nil
								ESX.TriggerServerCallback(
									"stem_casino:spinWheel",
									function(canSpin)
										if not canSpin then
											TaskPlayAnim(playerPed, lib, "Exit_to_Standing", 4.0, -4.0, -1, 0, 0, false,
												false, false)
											while IsEntityPlayingAnim(playerPed, lib, "ArmRaisedIDLE_to_SpinReadyIDLE", 3) do
												Citizen.Wait(0)
												DisableAllControlActions(0)
											end

											Wait(2000)
											TriggerServerEvent("stem_casino:wheelExit")
										end
										resolved = true
									end
								)

								while resolved == nil do
									Wait(0)
								end

								LocalPlayer.state.blockClearTasks = false
								break
							end

							if
								not GlobalState.LuckyWheel or GlobalState.LuckyWheel.player ~= GetPlayerServerId(PlayerId()) or IsEntityDead(playerPed) or
								IsDisabledControlJustPressed(0, 202)
							then
								if not IsEntityDead(playerPed) then
									TaskPlayAnim(playerPed, lib, "Exit_to_Standing", 4.0, -4.0, -1, 0, 0, false, false,
										false)
									while IsEntityPlayingAnim(playerPed, lib, "ArmRaisedIDLE_to_SpinReadyIDLE", 3) do
										Citizen.Wait(0)
										DisableAllControlActions(0)
									end

									Wait(2000)
								end

								TriggerServerEvent("stem_casino:wheelExit")

								LocalPlayer.state.blockClearTasks = false
								break
							end
						end
					else
						Wait(500)
					end
				end
			else
				Citizen.Wait(500)
			end
		end
	end
)
