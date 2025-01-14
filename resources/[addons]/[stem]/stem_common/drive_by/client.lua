local Util = require 'drive_by.client-utils'

local sc0tt_driveby = {
	driveby = true,
	driver = true,
	rear = false,
	dist = -14.0,
	player = PlayerId(),
	allowedModels = {
		-- [`hpbike`] = true,
		-- [`moto`] = true,
		-- [`polmav`] = true
	},
	allowedLayouts = {
		[`LAYOUT_DELTA_SUV`] = true,
		[`LAYOUT_DELTA_PICKUP`] = true,
		[`LAYOUT_DELTA_STD`] = true,
		[`LAYOUT_DELTA_LOW`] = true,
		[`LAYOUT_DELTA_SPORT`] = true,
		[`LAYOUT_DELTA_SUPER`] = true,
		[`LAYOUT_DELTA_SUV_HIGH`] = true,
		[`LAYOUT_DELTA_SUV_LOW`] = true,
		[`LAYOUT_DELTA_SUV_HIGH_LOWREAR`] = true,
		[`LAYOUT_DELTA_RANGER`] = true,
		[`LAYOUT_DELTA_VAN`] = true,
		[`LAYOUT_DELTA_VAN_LOW`] = true
	},
	minSpeed = 5.0,
	maxSpeed = 80.0,
	baseShake = 1.0,
	speedFactor = 0.02
}

local lastSpeedAllowedTime = 0

-- local sc0tt_driveby['driveby'] = true -- can anybody shoot?
-- local sc0tt_driveby['driver'] = false -- can driver shoot?
-- local sc0tt_driveby['rear'] = false -- can shoot behind?
-- local sc0tt_driveby['dist'] = -7.0 -- how far behind the ped is the cut off point? (the closer it is, the less backwards they will be able to shoot)

-- stop shooting behind you fucks
function lookingBehind()
	local coordA = GetEntityCoords(PlayerPedId(), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, sc0tt_driveby.dist, 0.0)
	--DrawMarker(1,coordB,0,0,0,0,0,0,1.001,1.0001,0.4001,0,155,255,175,0,0,0,0)
	local onScreen, _x, _y = World3dToScreen2d(coordB.x, coordB.y, coordB.z)
	return onScreen
end

Util.Tick(
	function()
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed) then
			local canshoot = true

			local _, weaponHash = GetCurrentPedWeapon(playerPed, 1)
			local veh = GetVehiclePedIsIn(playerPed, false)


			if weaponHash ~= `WEAPON_UNARMED` and GetPedInVehicleSeat(veh, -1) == playerPed then
				canshoot = false -- no shooty shooty driver
			end

			-- canshoot = false -- no shooty shooty ever


			local vehClass = GetVehicleClass(veh)
			local model = GetEntityModel(veh)
			local vehLayout = GetVehicleLayoutHash(veh)
			if veh ~= 0 and sc0tt_driveby.allowedModels[model] or not IsThisModelABike(model) then
				if GetPedInVehicleSeat(veh, 1) == playerPed or GetPedInVehicleSeat(veh, 2) == playerPed then
					canshoot = true
				else
					canshoot = not lookingBehind()
				end

				if canshoot then
					canshoot = false
					local mph = GetEntitySpeed(veh) * 2.23
					if mph >= sc0tt_driveby.minSpeed then
						canshoot = true
						lastSpeedAllowedTime = GetGameTimer() + 2500
					else
						if GetGameTimer() < lastSpeedAllowedTime then
							canshoot = true
						end
					end
				end
			end

			if LocalPlayer.state.testDriving or LocalPlayer.state.handcuffed then
				canshoot = false
			end

			if not sc0tt_driveby.allowedLayouts[vehLayout] then
				canshoot = false
			end

			if vehClass == 8 then -- Block shooting in super & motorcycle
				canshoot = false
			end

			if GetPedInVehicleSeat(veh, -1) == playerPed then
				canshoot = false
			end
			if vehClass == 18 and GetPedInVehicleSeat(veh, 0) == playerPed then
				if not lookingBehind() then
					canshoot = true
				end
			end

			if IsThisModelAHeli(model) or weaponHash == `WEAPON_UNARMED` or model == `pbike` then
				canshoot = true
			end

			if weaponHash == `WEAPON_PROLASER4` and GetPedInVehicleSeat(veh, -1) == playerPed and GetFollowVehicleCamViewMode() == 4 then
				canshoot = true
			end

			if sc0tt_driveby.allowedLayouts[vehLayout] and GlobalState.purgeActive and GetPedInVehicleSeat(veh, -1) ~= playerPed then
				canshoot = true -- Allow driveby with no speed restrictions
			end


			SetPlayerCanDoDriveBy(sc0tt_driveby.player, canshoot)

			if IsPedDoingDriveby(playerPed) and weaponHash ~= `WEAPON_UNARMED` and not IsThisModelAHeli(model) then
				-- if GetFollowVehicleCamViewMode() ~= 4 then
				-- 	SetCamViewModeForContext(GetCamActiveViewModeContext(), 4)
				-- end

				if not IsGameplayCamShaking() then
					local speedDiff = Absf((GetEntitySpeed(veh) * 2.23) - sc0tt_driveby.minSpeed)
					local amount = sc0tt_driveby.baseShake + (speedDiff * sc0tt_driveby.speedFactor)
					ShakeGameplayCam("ROAD_VIBRATION_SHAKE", amount)
				end

				if IsPedShooting(playerPed) then
					local relPitch = GetGameplayCamRelativePitch()
					local relYaw = GetGameplayCamRelativeHeading()
					-- local camRot = GetGameplayCamRot(2)
					-- SetGameplayCamRelativePitch(relPitch + 0.01, 1.0)
					SetGameplayCamRelativeRotation(relYaw, relPitch + 4.0, 0.2)
				end
			elseif not IsPedDoingDriveby(playerPed) and IsGameplayCamShaking() then
				if IsPedInAnyVehicle(playerPed, false) then
					StopGameplayCamShaking(true)
				end
			end

			if veh ~= 0 and NetworkHasControlOfEntity(veh) then
				local frontPsgr = GetPedInVehicleSeat(veh, 0)
				if DoesEntityExist(frontPsgr) and IsPedAPlayer(frontPsgr) and IsPedDoingDriveby(frontPsgr) then
					if IsVehicleWindowIntact(veh, 1) then
						RollDownWindow(veh, 1)
					end
				end

				local rearPsgrL = GetPedInVehicleSeat(veh, 1)
				if DoesEntityExist(rearPsgrL) and IsPedAPlayer(rearPsgrL) and IsPedDoingDriveby(rearPsgrL) then
					if IsVehicleWindowIntact(veh, 2) then
						RollDownWindow(veh, 2)
					end
				end

				local rearPsgrR = GetPedInVehicleSeat(veh, 2)
				if DoesEntityExist(rearPsgrR) and IsPedAPlayer(rearPsgrR) and IsPedDoingDriveby(rearPsgrR) then
					if IsVehicleWindowIntact(veh, 3) then
						RollDownWindow(veh, 3)
					end
				end
			end
		end
	end
)

function CanVehicleDriveby(veh)
	local layoutHash = GetVehicleLayoutHash(veh)
	if sc0tt_driveby.allowedLayouts[layoutHash] then
		return true
	end

	return false
end

exports("CanVehicleDriveby", CanVehicleDriveby)
