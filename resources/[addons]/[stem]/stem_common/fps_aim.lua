local forcefirst_shot = false
local forcefirst_check = false
local forcefirst_check2 = false
local forcefirst_count = 0

-- Use weapon group instead of individual weapon hashes, much cleaner solution
local ExemptWeaponGroupFP = {
	[`GROUP_MELEE`] = true,
	-- [`GROUP_SNIPER`] = true,
	[`GROUP_THROWN`] = true,
	[`GROUP_FIREEXTINGUISHER`] = true,
	[`GROUP_PETROLCAN`] = true,
	[`GROUP_METALDETECTOR`] = true,
}

CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Wait(0)
		end

		local bForcedFirst = false

		while true do
			Wait(0)
			local playerPed = PlayerPedId()

			local selectedWeapon = GetSelectedPedWeapon(playerPed)
			local weaponGroup = GetWeapontypeGroup(selectedWeapon)

			if GetPedConfigFlag(playerPed, 388, true) or (IsPlayerFreeAiming(PlayerId()) and weaponGroup ~= 0 and not ExemptWeaponGroupFP[weaponGroup] and not IsPedInAnyHeli(playerPed))
				or ((exports['PolySZ']:IsPedInForumZone()) and exports['stem_common']:IsPedOnRoofMaterial()) then
				-- Need to figure out a better solution to prevent rooftop camping, leave this for now

				if not bForcedFirst then
					SetFollowPedCamViewMode(4)
					bForcedFirst = true
				end
			else
				if bForcedFirst == true then
					SetFollowPedCamViewMode(1)
					bForcedFirst = false
				end
			end

			if bForcedFirst then
				DisableControlAction(0, 0, true)
			end
		end
	end
)

CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Wait(0)
		end

		while true do
			Wait(0)

			local playerPed = PlayerPedId()

			local selectedWeapon = GetSelectedPedWeapon(playerPed)
			local weaponGroup = GetWeapontypeGroup(selectedWeapon)


			if weaponGroup ~= 0 and not ExemptWeaponGroupFP[weaponGroup] and not IsPedInAnyHeli(playerPed) then
				if IsPedShooting(playerPed) and forcefirst_shot == false and GetFollowPedCamViewMode() ~= 4 then
					forcefirst_check2 = true
					forcefirst_shot = true
					SetFollowPedCamViewMode(4)
				end

				if IsPedShooting(playerPed) and forcefirst_shot == true and GetFollowPedCamViewMode() == 4 then
					forcefirst_count = 0
				end

				if not IsPedShooting(playerPed) and forcefirst_shot == true then
					forcefirst_count = forcefirst_count + 1
				end

				if not IsPedShooting(playerPed) and forcefirst_shot == true then
					if not IsPedShooting(playerPed) and forcefirst_shot == true and forcefirst_count > 20 then
						if forcefirst_check2 == true then
							forcefirst_check2 = false
							forcefirst_shot = false
							SetFollowPedCamViewMode(1)
						end
					end
				end
			end
		end
	end
)
