local casino_backEntrance = vector3(949.84, 43.47, 80.01)
local casino_insideExit = vector3(914.93, 0.12, 105.52)

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(0)
        end


        exports.qtarget:AddBoxZone(
            "CasinoBoss",
            vector3(931.6, 12.05, 81.12),
            1.2,
            0.8,
            {
                name = "CasinoBoss",
                heading = 328,
                --debugPoly=true,
                minZ = 80.12,
                maxZ = 82.12
            },
            {
                options = {
                    {
                        action = function()
                            OpenCasinoExecutiveMenu()
                        end,
                        icon = "fas fa-clipboard",
                        label = "Open Executive Menu",
                        job = { ["casino"] = 3 }
                    },
                    {
                        action = function()
                            OpenCasinoBlacklistMenu()
                        end,
                        icon = "fas fa-clipboard",
                        label = "View Guest Blacklist",
                        job = { ["casino"] = 3 }
                    }
                },
                distance = 2.5
            }
        )

        exports.qtarget:AddCircleZone(
            "Casino_Cashier",
            vector3(966.31, 24.75, 81.14),
            0.25,
            {
                name = "Casino_Cashier",
                useZ = true
                -- debugPoly = true
            },
            {
                options = {
                    {
                        action = function()
                            local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 6.0)
                            exports["stem_nui"]:OpenCasinoCashierMenu(players)
                        end,
                        canInteract = function()
                            return not IsEntityDead(PlayerPedId())
                        end,
                        icon = "fas fa-exchange-alt",
                        label = "Cashier Exchange",
                        job = { ["casino"] = 0 }
                    }
                },
                distance = 2.0
            }
        )

        exports.qtarget:AddCircleZone(
            "Casino_Cashier",
            vector3(966.56, 24.56, 81.14),
            0.25,
            {
                name = "Casino_Cashier",
                useZ = true
                -- debugPoly = true
            },
            {
                options = {
                    {
                        action = function()
                            local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 6.0)
                            exports["noire_nui"]:OpenCasinoCashierMenu(players)
                        end,
                        canInteract = function()
                            return not IsEntityDead(PlayerPedId())
                        end,
                        icon = "fas fa-exchange-alt",
                        label = "Cashier Exchange",
                        job = { ["casino"] = 0 }
                    }
                },
                distance = 2.0
            }
        )

        exports.qtarget:AddBoxZone(
            "Casino_FrontDesk",
            vector3(942.79, 60.92, 80.9), 1.4, 0.5, {
                name = "Casino_FrontDesk",
                heading = 58,
                --debugPoly=true,
                minZ = 79.9,
                maxZ = 83.9
            },
            {
                options = {
                    {
                        action = function()
                            TriggerEvent('noire_nui:openCasinoDashboard')
                        end,
                        canInteract = function()
                            return not IsEntityDead(PlayerPedId()) and LocalPlayer.state.casinoVIP
                        end,
                        icon = "fa-solid fa-tablet-screen-button",
                        label = "View Casino Stats"
                    }
                },
                distance = 2.0
            }
        )

        exports.qtarget:Player(
            {
                options = {
                    {
                        action = function(entity)
                            TriggerServerEvent("stem_casino:throwOut",
                                GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
                        end,
                        canInteract = function(entity)
                            return GetInteriorFromEntity(PlayerPedId()) ==
                                GetInteriorAtCoords(963.4197, 47.8542328, 74.31705) and not IsEntityDead(entity) and
                                IsPedOnFoot(entity)
                        end,
                        icon = "fas fa-sign-out-alt",
                        label = "Throw out of Casino",
                        job = { ["casino"] = 0 }
                    },
                    {
                        action = function(entity)
                            TriggerServerEvent("stem_casino:blacklist",
                                GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
                        end,
                        canInteract = function(entity)
                            local plySource = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                            local dist = #(GetEntityCoords(PlayerPedId()) - vector3(963.4197, 47.8542328, 74.31705))
                            return dist < 400 and not IsEntityDead(entity) and IsPedOnFoot(entity) and
                                not Player(plySource).state.casinoBlacklisted
                        end,
                        icon = "fas fa-ban",
                        label = "Ban from Casino",
                        job = { ["casino"] = 3 }
                    }
                },
                distance = 2.0
            }
        )

        local phones = {
            vector3(930.68, 36.11, 80.89),
            vector3(966.11, 20.92, 80.80),
            vector3(932.41, 13.17, 80.90),
            vector3(923.37, 34.18, 80.92),
            vector3(921.93, 31.83, 80.92)
        }

        for i = 1, #phones do
            exports.qtarget:AddCircleZone(
                "Casino_Phone" .. i,
                phones[i],
                0.25,
                {
                    name = "Casino_Phone" .. i,
                    useZ = true
                    -- debugPoly = true
                },
                {
                    options = {
                        {
                            action = function()
                                TriggerServerEvent("stem_casino:callPolice")
                            end,
                            canInteract = function()
                                return not IsEntityDead(PlayerPedId())
                            end,
                            icon = "fas fa-phone",
                            label = "Call Police",
                            job = { ["casino"] = 0 }
                        },
                        {
                            action = function()
                                exports['stem_nui']:OpenCasinoThrowoutMenu()
                            end,
                            icon = "fas fa-sign-out-alt",
                            label = "Throw out Casino Guest",
                            job = { ["casino"] = 0 }
                        },
                    },
                    distance = 2.0
                }
            )
        end
    end
)

function OpenCasinoBlacklistMenu()
    TriggerServerEvent("stem_casino:viewBlacklist")
end

function OpenCasinoExecutiveMenu()
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent(
        "esx_society:openBossMenu",
        "casino",
        function(data, menu)
            FreezeEntityPosition(PlayerPedId(), false)
            menu.close()
        end,
        {
            withdraw = true,
            deposit = true,
            checkbalance = true,
            wash = false
        }
    )
end

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(1000)
        end

        while not LocalPlayer.state.switchComplete do
            Wait(1000)
        end

        local model = GetHashKey("u_f_m_casinocash_01")
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        local cashierPed = CreatePed(26, model, 967.15, 23.23, 80.01, 310.03, false, false)
        SetEntityInvincible(cashierPed, true)
        SetBlockingOfNonTemporaryEvents(cashierPed, true)
        SetPedCanRagdoll(cashierPed, false)
        FreezeEntityPosition(cashierPed, true)

        exports.ox_target:addLocalEntity(cashierPed, {
            {
                onSelect = function()
                    exports["stem_nui"]:OpenCasinoVIPCashierMenu()
                end,
                canInteract = function()
                    return true
                end,
                icon = "fa-solid fa-cash-register",
                label = "Exchange Cash / Chips",
            }
        })

        exports.qtarget:AddBoxZone(
            "Casino_Hotel_Inventory",
            vector3(917.59, -0.67, 106.52), 3.4, 1.0, {
                name = "Casino_Hotel_Inventory",
                heading = 58,
                --debugPoly=true
            },
            {
                options = {
                    {
                        action = function()
                            TriggerServerEvent("stem_casino:createOpenInventory")
                        end,
                        canInteract = function()
                            return LocalPlayer.state.casinoVIP
                        end,
                        icon = "fa-solid fa-house",
                        label = "Open Storage",
                    },
                    {
                        action = function()
                            exports.allhousing:OpenWardrobeMenu()
                        end,
                        canInteract = function()
                            return LocalPlayer.state.casinoVIP
                        end,
                        icon = "fas fa-tshirt",
                        label = "Wardrobe",
                    }
                },
                distance = 2.0
            }
        )

        while true do
            -- if GlobalState.CasinoOnline ~= nil and GlobalState.CasinoOnline > 0 then
            --     SetEntityVisible(cashierPed, false, 0)
            -- else
            --     SetEntityVisible(cashierPed, true, 0)
            -- end

            local plyPed = PlayerPedId()
            local coords = GetEntityCoords(plyPed)
            local distFromBackEntrance = #(coords - casino_backEntrance)
            local distFromInsideExit = #(coords - casino_insideExit)
            local sleepThread = true

            if distFromBackEntrance < 50.0 then
                sleepThread = false
                DrawMarker(25, casino_backEntrance, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 255, 200, false, false, 0,
                    false, nil, nil, false)
                if distFromBackEntrance < 1.5 and LocalPlayer.state.casinoVIP then
                    local bAttached = false
                    local activePlayers = GetActivePlayers()
                    for i = 1, #activePlayers do
                        if activePlayers[i] ~= PlayerId() and DoesEntityExist(GetPlayerPed(activePlayers[i])) then
                            if GetEntityAttachedTo(GetPlayerPed(activePlayers[i])) == plyPed then
                                bAttached = true
                                break
                            end
                        end
                    end

                    if bAttached then
                        ESX.ShowHelpNotification("You cannot enter the casino with another player.", true)
                    else
                        ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to enter the VIP hotel room.", true)
                        if IsControlJustPressed(0, 51) then
                            LocalPlayer.state:set("lastSafeCoords",
                                { x = casino_backEntrance.x, y = casino_backEntrance.y, z = casino_backEntrance.z }, true)
                            LocalPlayer.state.blockClearTasks = true
                            TriggerServerEvent("stem_casino:instance")

                            DoScreenFadeOut(1500)
                            while IsScreenFadingOut() do
                                DisableAllControlActions(0)
                                Wait(0)
                            end

                            SetEntityCoords(plyPed, casino_insideExit, true, false, false, false, false)
                            SetEntityHeading(plyPed, 145.04)
                            Wait(500)

                            DoScreenFadeIn(1000)
                            while IsScreenFadingIn() do
                                DisableAllControlActions(0)
                                Wait(0)
                            end

                            TriggerEvent("stem_casino:restrictWeaponControls")
                            TriggerEvent("ox_inventory:disarm", true)
                            ESX.ShowHelpNotification("Welcome to your Diamond Casino & Resort VIP hotel room.")
                            Wait(5000)

                            LocalPlayer.state.blockClearTasks = false
                        end
                    end
                end
            end

            if distFromInsideExit < 10.0 then
                sleepThread = false
                DrawMarker(25, casino_insideExit, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 255, 200, false, false, 0,
                    false, nil, nil, false)
                if distFromInsideExit < 1.5 and LocalPlayer.state.casinoVIP then
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to return to lobby.", true)
                    if IsControlJustPressed(0, 51) then
                        LocalPlayer.state:set("lastSafeCoords", nil, true)
                        LocalPlayer.state.blockClearTasks = true
                        TriggerServerEvent("stem_casino:instance")

                        DoScreenFadeOut(1500)
                        while IsScreenFadingOut() do
                            DisableAllControlActions(0)
                            Wait(0)
                        end

                        SetEntityCoords(plyPed, casino_backEntrance, true, false, false, false, false)
                        SetEntityHeading(plyPed, 232.94)
                        Wait(500)

                        DoScreenFadeIn(1000)
                        while IsScreenFadingIn() do
                            DisableAllControlActions(0)
                            Wait(0)
                        end

                        LocalPlayer.state.blockClearTasks = false
                    end
                end
            end

            if sleepThread then
                Wait(500)
            end

            Wait(0)
        end
    end
)

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(0)
        end

        while not LocalPlayer.state.switchComplete do
            Wait(0)
        end

        while true do
            if LocalPlayer.state.casinoBlacklisted then
                local casinoInt = GetInteriorAtCoords(974.01, 44.83, 74.48)
                local currentInt = GetInteriorFromEntity(PlayerPedId())

                if currentInt == casinoInt then
                    TriggerEvent("stem_casino:throwOut")
                    Wait(5000)
                end
            end

            Wait(500)
        end
    end
)

RegisterNetEvent(
    "stem_casino:throwOut",
    function()
        if LocalPlayer.state.playingPoker then return end
        local coords = vector3(978.05, 76.55, 80.99 - 0.4)

        LocalPlayer.state.blockClearTasks = true

        DoScreenFadeOut(2500)
        while not IsScreenFadedOut() do
            Wait(0)
        end

        Wait(1500)

        RequestAnimDict("mini@strip_club@throwout_d@")
        while not HasAnimDictLoaded("mini@strip_club@throwout_d@") do
            Wait(0)
        end

        RequestModel(GetHashKey("S_M_Y_ClubBar_01"))
        while not HasModelLoaded(GetHashKey("S_M_Y_ClubBar_01")) do
            Wait(0)
        end

        local ped1 = CreatePed(4, GetHashKey("S_M_Y_ClubBar_01"), coords, 0, false, true)
        local ped2 = CreatePed(4, GetHashKey("S_M_Y_ClubBar_01"), coords, 0, false, true)

        DoScreenFadeIn(1000)
        -- Wait(500)

        ESX.ShowHelpNotification("You have been kicked out of the Casino.")

        local scene = CreateSynchronizedScene(coords, 0, 0, -150.0, 2)

        TaskSynchronizedScene(ped1, scene, "mini@strip_club@throwout_d@", "throwout_d_bouncer_a", 1000.0, -2.0, 4.0, 0,
            1000.0, 0)
        TaskSynchronizedScene(ped2, scene, "mini@strip_club@throwout_d@", "throwout_d_bouncer_b", 1000.0, -2.0, 4.0, 0,
            1000.0, 0)

        TaskSynchronizedScene(PlayerPedId(), scene, "mini@strip_club@throwout_d@", "throwout_d_victim", 1000.0, -2.0, 4.0,
            0, 1000.0, 0)

        Wait(9500)
        ClearPedTasks(PlayerPedId())

        LocalPlayer.state.blockClearTasks = false

        DeleteEntity(ped1)
        DeleteEntity(ped2)
    end
)

RegisterNetEvent(
    "stem_casino:announcer",
    function(speech)
        if not LocalPlayer.state.insideCasino then
            return
        end

        local pedPool = GetGamePool("CPed")
        for i = 1, #pedPool do
            if GetEntityModel(pedPool[i]) == `A_F_Y_GenCasPat_01` and NetworkGetEntityIsLocal(pedPool[i]) then
                if IsAnySpeechPlaying(pedPool[i]) then
                    StopPedSpeaking(pedPool[i])
                    RemoveEntityFromAudioMixGroup(pedPool[i], 0.0)
                    DeleteEntity(pedPool[i])
                end
            end
        end

        local model = `A_F_Y_GenCasPat_01`
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        local ped = CreatePed(26, model, 971.13, 32.74, 84.8, 0, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false, false)
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        StopPedSpeaking(ped)
        DisablePedPainAudio(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        AddEntityToAudioMixGroup(ped, "DLC_VW_Casino_PA_Announcement_Mixgroup", 0.0)

        PlayPedAmbientSpeechWithVoiceNative(ped, speech and speech or "CAPA_AAAA", "CAS_PA",
            "SPEECH_PARAMS_FORCE_NORMAL_CRITICAL", false)

        while IsAnySpeechPlaying(ped) do
            Wait(0)
        end

        RemoveEntityFromAudioMixGroup(ped, 0.0)
        DeleteEntity(ped)
    end
)

RegisterNetEvent(
    "stem_casino:viewBlacklist",
    function(data)
        ESX.UI.Menu.CloseAll()

        local elements = {
            head = { "Guest Name", "Blacklisted Since", "Actions" },
            rows = {}
        }

        for i = 1, #data do
            elements.rows[#elements.rows + 1] = {
                data = data,
                cols = {
                    data[i].name,
                    data[i].date_blacklisted,
                    "{{Remove|remove}}"
                }
            }
        end

        ESX.UI.Menu.Open(
            "list",
            GetCurrentResourceName(),
            "casino_blacklist",
            elements,
            function(data, menu)
                local rowData = data.data
                if data.value == "remove" then
                    menu.close()
                    TriggerServerEvent("stem_casino:removeBlacklistByIdentifier", rowData.identifier)
                end
            end,
            function(data, menu)
                menu.close()
            end
        )
    end
)
