CreateThread(
    function()
        LocalPlayer.state.searchingPed = false;
        while not NetworkIsSessionActive() do
            Wait(0)
        end

        exports.qtarget:Player(
            {
                options = {
                    {
                        action = function(ent)
                            local player = NetworkGetPlayerIndexFromPed(ent)
                            FriskPlayer(player)
                        end,
                        icon = "fas fa-search",
                        label = "Frisk Player",
                        canInteract = function(ent)
                            return not IsPedDeadOrDying(ent) and not LocalPlayer.state.searchingPed and
                                (IsEntityPlayingAnim(ent, "missminuteman_1ig_2", "handsup_base", 3) or
                                    IsEntityPlayingAnim(ent, "random@arrests", "random@arrests@busted", 3)) and
                                not LocalPlayer.state.inJail and
                                not LocalPlayer.state.inCommunityService
                        end
                    },
                    {
                        action = function(ent)
                            local player = NetworkGetPlayerIndexFromPed(ent)
                            LootPlayer(player)
                        end,
                        icon = "fas fa-recycle",
                        label = "Loot Body",
                        canInteract = function(ent)
                            local player = NetworkGetPlayerIndexFromPed(ent)
                            local plyState = Player(GetPlayerServerId(player)).state

                            local isCop = false
                            local job = plyState.job?.name
                            if job == 'lspd' or job == 'sahp' or job == 'lscso' then
                                isCop = true
                            end

                            print(plyState.deathCoords)

                            if plyState.deathCoords then
                                if #(GetEntityCoords(ent) - plyState.deathCoords) > 424.0 then
                                    return false
                                end
                            end

                            print("pedArmed", IsPedArmed(PlayerPedId(), 6))

                            return exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(player)) and plyState.inHostileZone and LocalPlayer.state.inHostileZone and
                                IsPedArmed(PlayerPedId(), 6) and not isCop
                        end
                    }
                },
                distance = 1.5
            }
        )

        function FriskPlayer(player)
            local ped = GetPlayerPed(player)

            if not DoesEntityExist(ped) then
                return
            end

            if IsPedInAnyVehicle(ped, false) then
                ESX.ShowNotification("You cannot search someone who is sitting in a vehicle.", "error")
                return
            end

            -- TaskGoStraightToCoord(PlayerPedId(), GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5, 0.0), 1.0, 500, GetEntityHeading(ped), 0.000001)
            -- Wait(2500)

            RequestAnimDict("anim@heists@load_box")
            while not HasAnimDictLoaded("anim@heists@load_box") do
                Wait(0)
            end

            RequestAnimDict("missbigscore2aig_7@driver")
            while not HasAnimDictLoaded("missbigscore2aig_7@driver") do
                Wait(0)
            end

            RequestAnimDict("mini@yoga")
            while not HasAnimDictLoaded("mini@yoga") do
                Wait(0)
            end

            LocalPlayer.state.searchingPed = true

            CreateThread(
                function()
                    while LocalPlayer.state.searchingPed do
                        local myCoords = GetEntityCoords(PlayerPedId())
                        local targetCoords = GetEntityCoords(ped)

                        if #(myCoords.xy - targetCoords.xy) > 2.0 or IsPedDeadOrDying(ped, true) or IsDisabledControlJustPressed(0, 73) then
                            ESX.ShowNotification("~r~Searching cancelled.", "error")
                            LocalPlayer.state.searchingPed = false
                            break
                        end

                        DisableAllControlActions(0)
                        EnableControlAction(0, 1, true)
                        EnableControlAction(0, 2, true)
                        EnableControlAction(0, 249, true)
                        Wait(0)
                    end
                end
            )

            local pos = GetEntityCoords(PlayerPedId())
            local rot = GetEntityRotation(PlayerPedId())
            TaskPlayAnimAdvanced(
                PlayerPedId(),
                "missbigscore2aig_7@driver",
                "boot_l_loop",
                pos,
                rot.x,
                rot.y,
                rot.z + 30.0,
                2.0,
                8.0,
                -1,
                0,
                0,
                false,
                false,
                false
            )
            Wait(500)
            if not LocalPlayer.state.searchingPed then
                ClearPedTasksImmediately(PlayerPedId())
                return
            end
            TaskPlayAnimAdvanced(PlayerPedId(), "mini@yoga", "outro_2", pos, rot.x, rot.y, rot.z + 30.0, 2.0, 8.0, -1, 0,
                0, false, false, false)
            Wait(1500)
            if not LocalPlayer.state.searchingPed then
                ClearPedTasksImmediately(PlayerPedId())
                return
            else
                ClearPedTasks(PlayerPedId())
            end

            TaskPlayAnimAdvanced(
                PlayerPedId(),
                "missbigscore2aig_7@driver",
                "boot_r_loop",
                pos,
                rot.x,
                rot.y,
                rot.z - 30.0,
                2.0,
                8.0,
                -1,
                0,
                0,
                false,
                false,
                false
            )
            Wait(500)
            if not LocalPlayer.state.searchingPed then
                ClearPedTasksImmediately(PlayerPedId())
                return
            end
            TaskPlayAnimAdvanced(PlayerPedId(), "mini@yoga", "outro_2", pos, rot.x, rot.y, rot.z - 30.0, 2.0, 8.0, -1, 0,
                0, false, false, false)
            Wait(1500)
            if not LocalPlayer.state.searchingPed then
                ClearPedTasksImmediately(PlayerPedId())
                return
            else
                ClearPedTasks(PlayerPedId())
            end

            function OpenFriskResultsMenu()
                ESX.TriggerServerCallback(
                    "stem_common:frisk:friskPlayer",
                    function(can)
                        if (not can) then return ESX.ShowNotification("You cannot search this player", "error") end
                        exports.ox_inventory:openInventory('player', GetPlayerServerId(player))
                        
                        LocalPlayer.state.searchingPed = false
                    end,
                    GetPlayerServerId(player)
                )
            end

            OpenFriskResultsMenu()
        end

        function LootPlayer(player)
            local plyPed = PlayerPedId()
            local ped = GetPlayerPed(player)
            if not DoesEntityExist(ped) then
                return
            end

            if IsPedInAnyVehicle(ped, false) then
                ESX.ShowNotification("You cannot loot someone sitting in a vehicle.")
                return
            end

            if not exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(player)) then
                return
            end

            RequestAnimDict("amb@medic@standing@kneel@base")
            while not HasAnimDictLoaded("amb@medic@standing@kneel@base") do
                Wait(0)
            end

            RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
            while not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@") do
                Wait(0)
            end

            LocalPlayer.state.invBusy = true
            LocalPlayer.state.blockClearTasks = true
            TriggerEvent('ox_inventory:disarm', true)

            TaskGoStraightToCoord(plyPed, GetEntityCoords(ped), 5.0, 500, GetEntityHeading(ped), 0.0001)
            Wait(500)

            TaskPlayAnim(plyPed, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
            TaskPlayAnim(
                plyPed,
                "anim@gangops@facility@servers@bodysearch@",
                "player_search",
                8.0,
                -8.0,
                -1,
                48,
                0,
                false,
                false,
                false
            )

            Wait(5000)
            ClearPedTasks(plyPed)

            LocalPlayer.state.blockClearTasks = false
            LocalPlayer.state.invBusy = false

            Wait(10)

            exports.ox_inventory:openInventory('player', GetPlayerServerId(player))
        end
    end
)
