-- local alreadyNotified = false
-- local peds = {}

-- CreateThread(
--     function()
--         while not NetworkIsSessionActive() do
--             Wait(0)
--         end
        
--         if (LocalPlayer.state.spawnedGuards) then return end
--         LocalPlayer.state.spawnedGuards = true

--         for key, value in pairs(peds) do
--             if (DoesEntityExist(value)) then DeleteEntity(value) end
--         end

--         for i = 1, #Config_ArmedGuards.Peds do
--             local guardData = Config_ArmedGuards.Peds[i]
--             if (not peds[i]) then
--                 local model = guardData.model or `s_m_m_security_01`
--                 RequestModel(model)
--                 while not HasModelLoaded(model) do
--                     Wait(0)
--                 end

--                 local ped = CreatePed(5, model, guardData.position.x, guardData.position.y, guardData.position.z, guardData.position.w or guardData.heading, false, true)

--                 SetPedHearingRange(ped, 100.0)
--                 SetPedSeeingRange(ped, 100.0)
--                 SetPedAlertness(ped, 3)
--                 SetPedFleeAttributes(ped, 0, 0)
--                 SetBlockingOfNonTemporaryEvents(ped, true)
--                 SetPedCombatAttributes(ped, 46, true)
--                 SetPedFleeAttributes(ped, 0, 0)
--                 SetEntityInvincible(ped, true)
--                 SetPedCanRagdoll(ped, false)
--                 SetTimeout(2000, function ()
--                     -- ensure ped is on the ground 
--                     FreezeEntityPosition(ped, true)
--                 end)

--                 while not DoesEntityExist(ped) do
--                     Wait(1000)
--                 end

--                 table.insert(peds, ped)
--                 Entity(ped).state.guardFlags = Config_ArmedGuards.Peds[i]
--             end
--         end
--     end
-- )

-- Citizen.CreateThread(function () 
--     while not NetworkIsSessionActive() do
--         Wait(0)
--     end

--     local function GetCopsInArea(coords)
--         local cops = 0
--         local players = ESX.Game.GetPlayers(true)
--         for i = 1, #players do
--             local plyPed = GetPlayerPed(players[i])
--             if #(GetEntityCoords(plyPed) - coords) < 50.0 then
--                 local plyServerId = GetPlayerServerId(players[i])
--                 local job = Player(plyServerId).state.job?.name
--                 if job == 'lspd' or job == 'sahp' or job == 'lscso' then
--                     cops = cops + 1
--                 end
--             end
--         end

--         return cops
--     end
    
--     while true do
--         local plyPed = PlayerPedId()
--         local coords = GetEntityCoords(plyPed)
--         local currentInt = GetInteriorFromEntity(plyPed)

--         local closestPed = nil
--         local closestDist = 100.0
--         for i = 1, #peds do
--             if DoesEntityExist(peds[i]) and #(GetEntityCoords(peds[i]) - coords) < closestDist then
--                 local dist = #(GetEntityCoords(peds[i]) - coords)
--                 local guardFlags = Entity(peds[i]).state.guardFlags

--                 if currentInt ~= 0 then
--                     if guardFlags and guardFlags.interior ~= 0 then
--                         if GetInteriorFromEntity(peds[i]) == GetInteriorFromEntity(plyPed) then
--                             closestDist = dist
--                             closestPed = peds[i]
--                         end
--                     end
--                 else
--                     if guardFlags and guardFlags.interior == 0 then
--                         if guardFlags.distance then
--                             if dist <= guardFlags.distance then
--                                 closestDist = dist
--                                 closestPed = peds[i]
--                             end
--                         else
--                             closestDist = dist
--                             closestPed = peds[i]
--                         end
--                     end
--                 end
--             end
--         end

--         if closestPed and not IsEntityDead(plyPed) and not IsPedInAnyVehicle(plyPed, false) and not GlobalState.purgeActive then
--             local aiming, entityAiming = GetEntityPlayerIsFreeAimingAt(PlayerId())
--             local selectedWeapon = GetSelectedPedWeapon(plyPed)

--             if not Config_ArmedGuards.PoliceJobs[ESX?.PlayerData?.job?.name] and GetPedType(plyPed) ~= 28 then
--                 local targeting, meleeTarget = GetPlayerTargetEntity(PlayerId())

--                 if
--                     IsPedShooting(plyPed) or IsPedPerformingMeleeAction(plyPed) == 1 or
--                     (aiming and GetEntityType(entityAiming) == 1 and GetWeaponDamageType(selectedWeapon) == 3) or
--                     (GetWeaponDamageType(selectedWeapon) == 2 and selectedWeapon ~= GetHashKey("WEAPON_UNARMED") and closestDist < 10.0)
--                 then
--                     if GetScriptTaskStatus(closestPed, 0x0A01F8B8) ~= 1 and HasEntityClearLosToEntityInFront(closestPed, plyPed) and GetCopsInArea(GetEntityCoords(closestPed)) < 2 then
--                         if not alreadyNotified then
--                             alreadyNotified = true
--                             lib.notify({
--                                 type = "error",
--                                 description = "Shooting, punching, and criminal activity is not tolerated in this area. Private armed security is taking action."
--                             })
--                         end

--                         FreezeEntityPosition(closestPed, false)
--                         GiveWeaponToPed(closestPed, GetHashKey("WEAPON_CARBINERIFLE"), 250, false, true)
--                         TaskShootAtEntity(closestPed, plyPed, 5000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))

--                         SetTimeout(
--                             5000,
--                             function()
--                                 alreadyNotified = false

--                                 ClearPedTasksImmediately(closestPed)

--                                 if IsEntityDead(PlayerPedId()) then
--                                     LocalPlayer.state:set("guardKilled", true, true)
--                                     LocalPlayer.state.isFatal = true
--                                 end

--                                 RemoveWeaponFromPed(closestPed, GetHashKey("WEAPON_CARBINERIFLE"))
--                                 local guardFlags = Entity(closestPed).state.guardFlags
--                                 if guardFlags then
--                                     SetEntityCoords(closestPed, guardFlags.position, guardFlags.heading or guardFlags.position.w, false, false,
--                                         false, false)
--                                     SetEntityHeading(closestPed, guardFlags.heading or guardFlags.position.w)
--                                 end

--                                 FreezeEntityPosition(closestPed, true)
--                             end
--                         )
--                     end
--                 end
--             end
--         else
--             Wait(500)
--         end

--         Wait(0)
--     end
-- end)

-- AddEventHandler("onResourceStop", function(resourceName) 
--     if (resourceName ~= GetCurrentResourceName()) then
--         return
--     end
--     LocalPlayer.state.spawnedGuards = false
--     for key, value in pairs(peds) do
--         if (DoesEntityExist(value)) then DeleteEntity(value) end
--     end
-- end)