if not Config.AimBlock.enable then return end
print("asss")
function aimBlock(global)
    CreateThread(function()
        while cache.weapon and Config.AimBlock.weaponsToBlock[cache.weapon] and (global and true or currentZone) do

            local aiming, entity = GetEntityPlayerIsFreeAimingAt(cache.playerId)
            local type = GetEntityType(entity)

            if (not currentZone or IsPedAPlayer(entity)) then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 58, true)
                DisablePlayerFiring(cache.ped, true)
            end
            Wait(1)
        end
    end)
end
