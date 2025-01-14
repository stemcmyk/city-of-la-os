-- Script by Lyrad for LEFR

local scopedWeapons =
{
	`WEAPON_SNIPERRIFLE`,
	`WEAPON_HEAVYSNIPER`,
	`WEAPON_MARKSMANRIFLE`,
	`WEAPON_HEAVYSNIPER`,
	`WEAPON_MARKSMANRIFLE_MK2`,
	`WEAPON_SAUER101`,
	`WEAPON_R700`,
}

validWeaponGroup = {
	[`GROUP_PISTOL`] = true,
	[`GROUP_SMG`] = true,
	[`GROUP_RIFLE`] = true,
	[`GROUP_MG`] = true,
	[`GROUP_SHOTGUN`] = true,
	[`GROUP_HEAVY`] = true,
}

local forcedWeaponFiring = {
    [`WEAPON_MK47FM`] = "burst",
	[`WEAPON_TACTICALRIFLE`] = "semi",
	[`WEAPON_CARBINERIFLE`] = "semi"
}

function HashInTable(hash)
	for k, v in pairs(scopedWeapons) do
		if (hash == v) then
			return true
		end
	end

	return false
end

function ManageReticle()
	local ped = PlayerPedId()
	local _, hash = GetCurrentPedWeapon(ped, true)
	if not HashInTable(hash) then
		HideHudComponentThisFrame(14)
	end
end

function DisableScopeReloading()
	local _, hash = GetCurrentPedWeapon(ped, true)
	if HashInTable(hash) then
		if IsPedReloading(ped) then
			DisableControlAction(0, 25, true)
		end
	end
end

Citizen.CreateThread(function ()
    while true do
		local ped = PlayerPedId()
		local weapon = GetSelectedPedWeapon(ped)
        if (forcedWeaponFiring[weapon] == "burst") then
            if (IsControlJustPressed(0, 24)) then
                Citizen.Wait(300)
                while (IsControlPressed(0, 24) or IsDisabledControlPressed(0, 24)) do
                    DisablePlayerFiring(PlayerId(), true);
                    Citizen.Wait(0)
                end
            end
        end
        if (forcedWeaponFiring[weapon] == "semi") then
			if (IsControlJustPressed(0, 24)) then 
				while (IsControlPressed(0, 24) or IsDisabledControlPressed(0, 24)) do 
					DisablePlayerFiring(PlayerId(), true);
					Wait(0);
				end
			end
        end
        Citizen.Wait(0)
    end
end)

CreateThread(function()
	local lastShot = nil
	local resetOnce = false

	local math_random = math.random
	local lastSprintTime = 0
	local lastMeleeTime = 0

	while true do
		Wait(0)
		local ped = PlayerPedId()
		local weapon = GetSelectedPedWeapon(ped)

		if not IsPedInAnyVehicle(ped, false) then
			if not IsControlPressed(0, 37) then -- INPUT_SELECT_WEAPON
				HideHudComponentThisFrame(19)
				HideHudComponentThisFrame(20)
			end
		end

		if IsPedSprinting(ped) or (GetInteriorFromEntity(ped) ~= 0 and IsControlPressed(0, 21)) then
			lastSprintTime = GetGameTimer()
		end

		if IsPedPerformingMeleeAction(ped) then
			lastMeleeTime = GetGameTimer()
		end

		-- Disable weapon wheel stats
		HideHudComponentThisFrame(20)

		-- Disable reticle
		ManageReticle()

		-- Disable melee while aiming (may be not working)
		if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
		end

		SetPedConfigFlag(ped, 122, false)

		-- Prevent accidential melee
		if (not IsPlayerTargettingAnything(PlayerId()) or IsPedSprinting(ped) or ((GetGameTimer() - lastSprintTime) < 750)) and (weapon == `WEAPON_UNARMED` or weapon == `WEAPON_KNIFE`) then
			SetPedConfigFlag(ped, 122, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)
		end

		-- if (GetGameTimer() - lastMeleeTime) < 2500 then
		-- 	SetPedConfigFlag(ped, 122, true)
		-- 	DisableControlAction(0, 140, true)
		-- 	DisableControlAction(0, 141, true)
		-- 	DisableControlAction(0, 142, true)
		-- 	DisableControlAction(0, 263, true)
		-- 	DisableControlAction(0, 264, true)
		-- end

		SetPedEnableWeaponBlocking(ped, false)

		-- Disable ammo HUD
		DisplayAmmoThisFrame(false)

		-- Disable aim assist
		SetPlayerTargetingMode(3)

		-- Disable scoping when reloading a scoped weapon
		DisableScopeReloading()

		-- Pistol

		local pitchPerFrame = nil
		local yawPerFrame = nil

		local minimumTimeBetweenShots = 75
		local timeoutDuration = 50

		local weaponTable = {
			[`WEAPON_APPISTOL`] = {
				pitchPerFrame = 0.6,
				yawPerFrame = 40,
				minimumTimeBetweenShots = 50,
				timeoutDuration = 50
			},
			[`WEAPON_MACHINEPISTOL`] = {
				pitchPerFrame = 0.2,
				yawPerFrame = 20,
				minimumTimeBetweenShots = 50,
				timeoutDuration = 50
			},
			[`WEAPON_SNSPISTOL`] = {
				pitchPerFrame = 0.7,
				yawPerFrame = 17,
				minimumTimeBetweenShots = 75,
				timeoutDuration = 50,
			},
			[`WEAPON_ASSAULTRIFLE`] = {
				pitchPerFrame = 0.02,
				yawPerFrame = 8,
				minimumTimeBetweenShots = 150,
				timeoutDuration = 50
			},
			[`WEAPON_SMG`] = {
				pitchPerFrame = 0.04,
				yawPerFrame = 16,
				minimumTimeBetweenShots = 150,
				timeoutDuration = 50
			},
			[`WEAPON_DOUBLEACTION`] = {
				pitchPerFrame = 2.1,
				yawPerFrame = 40,
				minimumTimeBetweenShots = -1,
				timeoutDuration = 50,
				shakeFactor = 0.06
			},
			[`WEAPON_REVOLVER`] = {
				pitchPerFrame = 2.4,
				yawPerFrame = 50,
				minimumTimeBetweenShots = -1,
				timeoutDuration = 50,
				shakeFactor = 0.08
			},
			[`WEAPON_PUMPSHOTGUN`] = {
				pitchPerFrame = 3.5,
				yawPerFrame = 45,
				minimumTimeBetweenShots = -1,
				timeoutDuration = 50,
				shakeFactor = 0.12
			},
			[`WEAPON_SAUER101`] = {
				pitchPerFrame = 3.5,
				yawPerFrame = 25,
				minimumTimeBetweenShots = -1,
				timeoutDuration = 50,
				shakeFactor = 0.08
			},
			[`WEAPON_R700`] = {
				pitchPerFrame = 3.5,
				yawPerFrame = 25,
				minimumTimeBetweenShots = -1,
				timeoutDuration = 50,
				shakeFactor = 0.08
			},
			[`WEAPON_MAC10`] = {
				pitchPerFrame = 0.5,
				yawPerFrame = 20,
				minimumTimeBetweenShots = 50,
				timeoutDuration = 50,
				shakeFactor = 0.02
			},
			[`WEAPON_WALTHER`] = {
				pitchPerFrame = 0.33,
				yawPerFrame = 15,
				minimumTimeBetweenShots = 75,
				timeoutDuration = 50
			},
			[`WEAPON_FNFAL`] = {
				pitchPerFrame = 0.16,
				yawPerFrame = 12,
				minimumTimeBetweenShots = 50,
				timeoutDuration = 50,
				shakeFactor = 0.01
			},
			[`WEAPON_MP5`] = {
				pitchPerFrame = 0.01,
				yawPerFrame = 5,
				minimumTimeBetweenShots = 150,
				timeoutDuration = 50,
				shakeFactor = 0.01
			},
			[`WEAPON_FM1_M16A4`] = {
				pitchPerFrame = 0.005,
				yawPerFrame = 5,
				minimumTimeBetweenShots = 150,
				timeoutDuration = 50
			},
			[`WEAPON_CARBINERIFLE`] = {
				pitchPerFrame = 0.06,
				yawPerFrame = 10,
				minimumTimeBetweenShots = 100,
				timeoutDuration = 50
			},
			[`WEAPON_TACTICALRIFLE`] = {
				pitchPerFrame = 0.06,
				yawPerFrame = 10,
				minimumTimeBetweenShots = 100,
				timeoutDuration = 50
			},
			[`WEAPON_COMPACTRIFLE`] = {
				pitchPerFrame = 0.1,
				yawPerFrame = 20,
				minimumTimeBetweenShots = 100,
				timeoutDuration = 50
			},
			[`WEAPON_MK47FM`] = {
				pitchPerFrame = 0.06,
				yawPerFrame = 10,
				minimumTimeBetweenShots = 100,
				timeoutDuration = 50
			},
		}

		if weaponTable[weapon] and not IsPedInAnyVehicle(ped, false) then
			if IsPedShooting(ped) then
				if weaponTable[weapon].shakeFactor then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', weaponTable[weapon].shakeFactor)
				end

				local relPitch = GetGameplayCamRelativePitch()
				SetGameplayCamRelativePitch(relPitch + weaponTable[weapon].pitchPerFrame, 1.0)

				local relHeading = GetGameplayCamRelativeHeading()
				lastShot = GetGameTimer()
				SetGameplayCamRelativeHeading(relHeading +
					(math_random(-weaponTable[weapon].yawPerFrame, weaponTable[weapon].yawPerFrame) / 100)
				)
			else
				local curTime = GetGameTimer()
				if lastShot and curTime - lastShot > 0 and curTime - lastShot < weaponTable[weapon].minimumTimeBetweenShots then
					if not resetOnce then
						resetOnce = true

						SetTimeout(weaponTable[weapon].timeoutDuration, function()
							local relpitch = GetGameplayCamRelativePitch()
							SetGameplayCamRelativePitch(relpitch - weaponTable[weapon].pitchPerFrame, 1.0)
						end)
					end
				elseif lastShot and curTime - lastShot >= weaponTable[weapon].minimumTimeBetweenShots then
					resetOnce = false
				end
			end
		end

		-- Infinite FireExtinguisher
		if weapon == `WEAPON_FIREEXTINGUISHER` then
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, `WEAPON_FIREEXTINGUISHER`)
			end
		end
	end
end)

CreateThread(function()
	while not LocalPlayer.state.switchComplete do
		Wait(0)
	end

	Citizen.InvokeNative(`SET_PED_TURNING_THRESHOLDS` & 0xFFFFFFFF, -135, 135)
	SetAimCooldown(250)
	SetWeaponsNoAimBlocking(true)

	local bForcedShoes = false
	local oldShoesDrawable, oldShoesTexture = nil, nil

	while true do
		Wait(0)

		local ped = PlayerPedId()

		if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped) or (GetFollowPedCamViewMode() == 4 and not IsPlayerFreeAiming(PlayerId())) then
			DisableControlAction(2, 24, true)
			DisableControlAction(2, 142, true)
			DisableControlAction(2, 257, true)
		end

		local stealth = GetPedStealthMovement(ped)
		local _, weaponHash = GetCurrentPedWeapon(ped, true)
		local wepGroup = GetWeapontypeGroup(weaponHash)

		if stealth and weaponHash == `WEAPON_UNARMED` then
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)
			DisablePlayerFiring(PlayerId(), true)
		end

		if weaponHash ~= `WEAPON_UNARMED` and IsWeaponValid(weaponHash) and validWeaponGroup[wepGroup] then
			local recoilAmp = GetWeaponRecoilShakeAmplitude(weaponHash)
			if recoilAmp < 0.05 then
				if not LocalPlayer.state._ea03693e then
					local currentWeapon = exports.ox_inventory:getCurrentWeapon()
					LocalPlayer.state:set('_ea03693e', {
						value = recoilAmp,
						label = currentWeapon.label
					}, true)
				end
			end

			local dmg = GetWeaponDamageModifier(weaponHash)
			if dmg > 1.0 then
				if not LocalPlayer.state._4ef3b842 then
					local currentWeapon = exports.ox_inventory:getCurrentWeapon()
					LocalPlayer.state:set('_4ef3b842', {
						value = dmg,
						label = currentWeapon.label
					}, true)
				end
			end
		end

		local pedModel = GetEntityModel(ped)
		if pedModel == `mp_m_freemode_01` or pedModel == `mp_f_freemode_01` and not IsEntityDead(ped) then
			local min, max = GetModelDimensions(pedModel)
			if min.y < -0.29 or max.z > 0.98 then
				if not LocalPlayer.state._ff61bfb7 then
					LocalPlayer.state:set('_ff61bfb7', true, true)
				end
			end

			-- local job = LocalPlayer.state.job?.name or ''

			-- if job ~= 'lspd' and job ~= 'sahp' and job ~= 'lscso' then
			-- 	if IsPlayerFreeAiming(PlayerId()) then
			-- 		if not bForcedShoes then
			-- 			bForcedShoes = true
			-- 			oldShoesDrawable = GetPedDrawableVariation(ped, 6)
			-- 			oldShoesTexture = GetPedTextureVariation(ped, 6)
			-- 			SetPedComponentVariation(ped, 6, 0, 0, 3)
			-- 		end
			-- 	else
			-- 		if bForcedShoes then
			-- 			bForcedShoes = false
			-- 			if oldShoesDrawable ~= nil and oldShoesTexture ~= nil then
			-- 				SetPedComponentVariation(ped, 6, oldShoesDrawable, oldShoesTexture, 3)
			-- 			end
			-- 		end
			-- 	end
			-- end
		end
	end
end)
