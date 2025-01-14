Citizen.CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Citizen.Wait(1000)
        end

        LocalPlayer.state.contextualSitting = false

        local _targetModels = {
            [`v_serv_ct_chair02`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.0 },
            [`prop_off_chair_04`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.4 },
            [`prop_off_chair_03`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [`prop_off_chair_05`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.4 },
            [`v_club_officechair`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.4 },
            [`v_ilev_leath_chr`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.4 },
            [`v_corp_offchair`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [`v_med_emptybed`] = { offsetX = 0.0, offsetY = 0.13, offsetZ = -0.2 },
            [`prop_off_chair_01`] = { offsetX = 0.0, offsetY = 0.1, offsetZ = -0.5 },
            [`p_clb_officechair_s`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.4 },
            [`prop_sol_chair`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [-470815620] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.1 },
            [-1716259507] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [458447834] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [`v_ret_gc_chair02`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0 },
            [`prop_chair_06`] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.0 },
            [1339364336] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.15 },
            [444105316] = { offsetX = 0.0, offsetY = 0.10, offsetZ = -0.48 },
            [-1278649385] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.15 },
            [1580642483] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.1 },
            [1840174940] = { offsetX = -0.1, offsetY = -0.05, offsetZ = -0.7 },
            [-853526657] = { offsetX = 0.0, offsetY = 0.0, offsetZ = 0.1 },
            [1889748069] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [-146667690] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [-2114478669] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [1594170221] = { offsetX = 0.0, offsetY = -0.2, offsetZ = -0.8 },
            [267626795] = { offsetX = 0.0, offsetY = 0.2, offsetZ = -0.5 },
            [-1343339408] = { offsetX = 0.2, offsetY = 0.0, offsetZ = -0.05 },
            [-1414441318] = { offsetX = 0.2, offsetY = 0.0, offsetZ = -0.05 },
            [-1120527678] = { offsetX = -0.15, offsetY = -0.05, offsetZ = -0.8, direction = -90.0 },
            [1451909242] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.5 },
            [784932497] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.1 },
            [276029927] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.1 },
            [1480618483] = { offsetX = 0.0, offsetY = 0.15, offsetZ = -0.4 },
            [1816935351] = { offsetX = 0.0, offsetY = 0.0, offsetZ = -0.55 }
        }

        local _targets = {}
        for hash, _ in pairs(_targetModels) do
            _targets[#_targets + 1] = hash
        end

        exports.qtarget:AddTargetModel(
            _targets,
            {
                options = {
                    {
                        canInteract = function(entity)
                            return GetInteriorFromEntity(entity) == GetInteriorFromEntity(PlayerPedId()) and
                                not LocalPlayer.state.broadcastMode
                        end,
                        event = "contextualSitChair",
                        icon = "fas fa-chair",
                        label = "Sit"
                    }
                },
                distance = 1.0
            }
        )

        _targetModels[-2139482741] = { offsetX = -0.15, offsetY = -0.2, offsetZ = -0.8, direction = -180.0 }

        exports.qtarget:AddTargetModel(
            { -2139482741 },
            {
                options = {
                    {
                        canInteract = function(entity)
                            return GetInteriorFromEntity(entity) == GetInteriorFromEntity(PlayerPedId())
                        end,
                        event = "contextualSitChair",
                        icon = "fas fa-chair",
                        label = "Sit",
                        job = { ["casino"] = 0 }
                    }
                },
                distance = 2.0
            }
        )

        AddEventHandler(
            "contextualSitChair",
            function(data)
                if LocalPlayer.state.contextualSitting then
                    return
                end

                local playerPed = PlayerPedId()
                local lastPos = GetEntityCoords(playerPed)

                local objCoords = GetEntityCoords(data.entity)

                SetEntityCoords(playerPed, objCoords.x, objCoords.y, objCoords.z + 0.5)
                SetEntityHeading(playerPed, GetEntityHeading(data.entity) - 180.0)

                local objInfo = _targetModels[GetEntityModel(data.entity)]

                LocalPlayer.state.blockClearTasks = true
                LocalPlayer.state.contextualSitting = true

                local heading = GetEntityHeading(data.entity) + 180.0
                if heading > 360.0 then
                    heading = heading - 360.0
                end

                if objInfo.direction then
                    heading = heading + objInfo.direction
                end

                TaskStartScenarioAtPosition(
                    playerPed,
                    "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER",
                    objCoords.x + objInfo.offsetX,
                    objCoords.y + objInfo.offsetY,
                    objCoords.z - objInfo.offsetZ,
                    heading,
                    0,
                    true,
                    true
                )

                SetPedCanRagdoll(playerPed, false)

                Citizen.Wait(2500)

                Citizen.CreateThread(
                    function()
                        ESX.ShowHelpNotification("Press ~INPUT_ENTER~ to stand up.")
                        while true do
                            if IsControlJustPressed(0, 23) or IsEntityDead(playerPed) or IsPedBeingStunned(playerPed, 0) or GetScriptTaskStatus(playerPed, `SCRIPT_TASK_START_SCENARIO_AT_POSITION`) ~= 1 then
                                ClearPedTasksImmediately(playerPed)
                                FreezeEntityPosition(playerPed, false)
                                LocalPlayer.state.blockClearTasks = false
                                LocalPlayer.state.contextualSitting = false
                                SetPedCanRagdoll(playerPed, true)
                                break
                            end
                            Citizen.Wait(0)
                        end
                    end
                )
            end
        )

        while true do
            local pool = GetGamePool("CObject")
            for i = 1, #pool do
                local obj = pool[i]
                if DoesEntityExist(obj) and _targetModels[GetEntityModel(obj)] then
                    FreezeEntityPosition(obj, true)
                end
            end
            Citizen.Wait(5000)
        end
    end
)
