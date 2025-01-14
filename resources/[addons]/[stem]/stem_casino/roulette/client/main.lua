-- ESX = nil
local SITTING_SCENE = nil
local CURRENT_CHAIR_DATA = nil
local SELECTED_CHAIR_ID = nil
selectedRulett = nil
Rulettek = {}
closetoRulett = false
currentBetAmount = 10
totalBetAmount = 0
idleTimer = 0
aimingAtBet = -1
lastAimedBet = -1
betsLeft = 0
timeLeft = 0

createRulettAsztal = function(index, data)
    local self = {}

    self.index = index
    self.data = data
    local lastBet;


    Config_roulette.DebugMsg(string.format("Rulett table creating.. %s", self.index))



    RequestModel(`vw_prop_casino_roulette_01b`)
    while not HasModelLoaded(`vw_prop_casino_roulette_01b`) do
        Wait(0)
    end
    

    -- self.tableObject = CreateObject(GetHashKey("vw_prop_casino_roulette_01"), data.position, false)
    self.tableObject = GetClosestObjectOfType(data.position, 4.0, `vw_prop_casino_roulette_01b`, false, false, false)
    while not DoesEntityExist(self.tableObject) do
        self.tableObject = GetClosestObjectOfType(data.position, 4.0, `vw_prop_casino_roulette_01b`, false, false, false)
        Wait(0)
    end
    -- SetEntityHeading(self.tableObject, data.rot)

    RequestModel(`S_F_Y_Casino_01`)
    while not HasModelLoaded(`S_F_Y_Casino_01`) do
        Wait(0)
    end

    -- local pedOffset = GetObjectOffsetFromCoords(data.position.x, data.position.y, data.position.z, data.rot, 0.68, 0.7, 1.0)
    local pedOffset = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.1, 0.7, 0.0)
    self.ped = CreatePed(2, `S_F_Y_Casino_01`, pedOffset, data.rot - 90.0, false, true)
    local tableHeading = GetEntityHeading(self.tableObject)
    tableHeading = tableHeading + 180
    if tableHeading > 360 then
        tableHeading = tableHeading - 360
    end
    SetEntityHeading(self.ped, tableHeading)

    SetEntityCanBeDamaged(self.ped, 0)
    SetPedAsEnemy(self.ped, 0)
    SetBlockingOfNonTemporaryEvents(self.ped, 1)

    SetPedResetFlag(self.ped, 249, 1)
    SetPedConfigFlag(self.ped, 185, true)
    SetPedConfigFlag(self.ped, 108, true)
    SetPedConfigFlag(self.ped, 208, true)

    SetPedCanEvasiveDive(self.ped, 0)
    SetPedCanRagdollFromPlayerImpact(self.ped, 0)

    -- 1.0.1
    SetPedVoiceGroup(self.ped, "S_M_Y_Casino_01_WHITE_01")
    addRandomClothes(self.ped)
    -- SetDealerOutfit(self.ped)

    TaskPlayAnim(self.ped, "anim_casino_b@amb@casino@games@roulette@dealer_female", "idle", 3.0, 3.0, -1, 2, 0, true, true, true)

    self.numbersData = {}
    self.betData = {}
    self.hoverObjects = {}
    self.betObjects = {}
    self.ballObject = nil

    self.rulettCam = nil
    self.cameraMode = 1

    self.enableCamera = function(state)
        if state then
            LocalPlayer.state.invBusy = true
            self.speakPed("MINIGAME_DEALER_GREET")
            DisplayRadar(false)
            TriggerEvent("ShowPlayerHud", false)
            -- SendNUIMessage(
            --     {
            --         action = "showRulettNui",
            --         state = true
            --     }
            -- )
            -- SendNUIMessage(
            --     {
            --         action = "setBetAmount",
            --         amount = currentBetAmount
            --     }
            -- )
            casinoNuiUpdateGame(self.index, self.ido, self.statusz)

            Config_roulette.DebugMsg("creating camera..")
            local rot = vector3(270.0, -90.0, self.data.rot + 270.0)
            self.rulettCam =
                CreateCamWithParams(
                "DEFAULT_SCRIPTED_CAMERA",
                self.data.position.x,
                self.data.position.y,
                self.data.position.z + 2.0,
                rot.x,
                rot.y,
                rot.z,
                80.0,
                true,
                2
            )
            SetCamActive(self.rulettCam, true)
            RenderScriptCams(true, 900, 900, true, false)
            Config_roulette.DebugMsg("camera setted active.")

            selectedRulett = self.index
            self.betRenderState(true)

            playRulettIdle()

            CreateThread(
                function()
                    while selectedRulett ~= nil do
                        Wait(1000)

                        if idleTimer ~= nil then
                            idleTimer = idleTimer - 1
                            if idleTimer < 1 then
                                Config_roulette.DebugMsg("start idle")
                                idleTimer = nil
                                playRulettIdle()
                            end
                        end
                    end
                end
            )

            CreateThread(
                function()
                    while selectedRulett ~= nil do
                        Wait(0)

                        if self.betObjects then
                            for i = 1, #self.betObjects, 1 do
                                local bet = self.betObjects[i]
                                if DoesEntityExist(bet.obj) then
                                    local coords = GetEntityCoords(bet.obj)
                                    if bet.playerSrc == GetPlayerServerId(PlayerId()) then
                                        Utils.Draw3DText(coords, string.format("~w~%s", bet.betAmount), 0.10, 0)
                                    end
                                end
                            end
                        end
                    end
                end
            )

            CreateThread(
                function()
                    while selectedRulett ~= nil do
                        Wait(100)

                        if IsDisabledControlPressed(0, 172) then
                            if currentBetAmount >= 100 then
                                currentBetAmount = currentBetAmount + 100
                            else
                                currentBetAmount = currentBetAmount + 10
                            end
                            changeBetAmount(currentBetAmount)
                        elseif IsDisabledControlPressed(0, 173) then
                            if currentBetAmount > 0 then
                                if currentBetAmount >= 200 then
                                    currentBetAmount = currentBetAmount - 100
                                else
                                    currentBetAmount = currentBetAmount - 10
                                end

                                if currentBetAmount < 10 then
                                    currentBetAmount = 10
                                end

                                changeBetAmount(currentBetAmount)
                            end
                        end
                    end
                end
            )

            CreateThread(
                function()
                    while selectedRulett ~= nil do
                        Wait(0)
                        DisableAllControlActions(0)
                        EnableControlAction(0, 249, true)

                        -- Utils.ShowHelpNotification(_U("help_rulett_all"))
                        instructionalScaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
                        while not HasScaleformMovieLoaded(instructionalScaleform) do
                            Wait(0)
                        end

                        local barCount = {1}
                        DrawTimerBar(barCount, "BET", currentBetAmount == 0 and "0" or currentBetAmount)
                        DrawTimerBar(barCount, "THIS BET", totalBetAmount == 0 and "0" or totalBetAmount)
                        DrawTimerBar(barCount, "BETS REMAINING", betsLeft == 0 and "0" or betsLeft)
                        DrawTimerBar(barCount, "TIME", s2m(timeLeft))

                        PushScaleformMovieFunction(instructionalScaleform, "CLEAR_ALL")
                        PopScaleformMovieFunctionVoid()

                        BeginScaleformMovieMethod(instructionalScaleform, "SET_BACKGROUND_COLOUR")
                        ScaleformMovieMethodAddParamInt(0)
                        ScaleformMovieMethodAddParamInt(0)
                        ScaleformMovieMethodAddParamInt(0)
                        ScaleformMovieMethodAddParamInt(80)
                        EndScaleformMovieMethod()

                        BeginScaleformMovieMethod(instructionalScaleform, "SET_DATA_SLOT")
                        ScaleformMovieMethodAddParamInt(0)
                        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 177, 0))
                        ScaleformMovieMethodAddParamPlayerNameString("Quit")
                        EndScaleformMovieMethod()

                        BeginScaleformMovieMethod(instructionalScaleform, "SET_DATA_SLOT")
                        ScaleformMovieMethodAddParamInt(1)
                        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 24, 0))
                        ScaleformMovieMethodAddParamPlayerNameString("Place Bet")
                        EndScaleformMovieMethod()

                        BeginScaleformMovieMethod(instructionalScaleform, "SET_DATA_SLOT")
                        ScaleformMovieMethodAddParamInt(2)
                        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 204, 0))
                        ScaleformMovieMethodAddParamPlayerNameString("Max Bet")
                        EndScaleformMovieMethod()

                        BeginScaleformMovieMethod(instructionalScaleform, "SET_DATA_SLOT")
                        ScaleformMovieMethodAddParamInt(3)
                        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 173, 0))
                        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 172, 0))
                        ScaleformMovieMethodAddParamPlayerNameString("Adjust Bet")
                        EndScaleformMovieMethod()

                        BeginScaleformMovieMethod(instructionalScaleform, "SET_DATA_SLOT")
                        ScaleformMovieMethodAddParamInt(4)
                        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 51, 0))
                        ScaleformMovieMethodAddParamPlayerNameString("Change Camera")
                        EndScaleformMovieMethod()

                        BeginScaleformMovieMethod(instructionalScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
                        EndScaleformMovieMethod()

                        DrawScaleformMovieFullscreen(instructionalScaleform, 255, 255, 255, 255, 0)

                        if IsDisabledControlJustPressed(0, 204) then
                            if selectedRulett and Config_roulette.RulettTables[selectedRulett] then
                                changeBetAmount(Config_roulette.RulettTables[selectedRulett].maxBet)
                            end
                            PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", false)
                        end

                        if (IsDisabledControlJustPressed(0, 177) or IsPedDeadOrDying(PlayerPedId(), true)) and (not self.betObjects or #self.betObjects < 1) then
                            self.enableCamera(false)
                            PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", false)
                        end
                        if IsDisabledControlJustPressed(0, 38) then
                            self.changeKameraMode()
                            PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", false)
                        end
                    end
                end
            )

            Wait(1500)
        else
            LocalPlayer.state.invBusy = false
            TriggerEvent("casino:roulette:onStandUp")
            TriggerServerEvent("casino:rulett:notUsing", selectedRulett)

            -- SendNUIMessage(
            --     {
            --         action = "showRulettNui",
            --         state = false
            --     }
            -- )

            for i = 1, #self.hoverObjects do
                local obj = self.hoverObjects[i]
                if DoesEntityExist(obj) then
                    DeleteEntity(obj)
                end
            end

            if DoesCamExist(self.rulettCam) then
                DestroyCam(self.rulettCam, false)
            end
            RenderScriptCams(false, 900, 900, true, false)
            self.betRenderState(false)
            Config_roulette.DebugMsg("camera deleted.")
            selectedRulett = nil
            self.speakPed("MINIGAME_DEALER_LEAVE_NEUTRAL_GAME")

            NetworkStopSynchronisedScene(SITTING_SCENE)

            local endingDict = "anim_casino_b@amb@casino@games@shared@player@"
            RequestAnimDict(endingDict)
            while not HasAnimDictLoaded(endingDict) do
                Wait(0)
            end

            local whichAnim = nil
            if SELECTED_CHAIR_ID == 1 then
                whichAnim = "sit_exit_left"
            elseif SELECTED_CHAIR_ID == 2 then
                whichAnim = "sit_exit_right"
            elseif SELECTED_CHAIR_ID == 3 then
                whichAnim = ({"sit_exit_left", "sit_exit_right"})[math.random(1, 2)]
            elseif SELECTED_CHAIR_ID == 4 then
                whichAnim = "sit_exit_left"
            end

            TaskPlayAnim(PlayerPedId(), endingDict, whichAnim, 1.0, 1.0, 2500, 0)
            SetPlayerControl(PlayerId(), 0, 0)
            Wait(3600)
            SetPlayerControl(PlayerId(), 1, 0)

            DisplayRadar(true)
            TriggerEvent("ShowPlayerHud", true)
        end
    end

    self.changeKameraMode = function()
        if DoesCamExist(self.rulettCam) then
            if self.cameraMode == 1 then
                DoScreenFadeOut(200)
                while not IsScreenFadedOut() do
                    Wait(0)
                end
                self.cameraMode = 2
                local camOffset = GetOffsetFromEntityInWorldCoords(self.tableObject, -1.45, -0.15, 1.45)
                SetCamCoord(self.rulettCam, camOffset)
                SetCamRot(self.rulettCam, -25.0, 0.0, self.data.rot + 270.0, 2)
                SetCamFov(self.rulettCam, 40.0)
                ShakeCam(self.rulettCam, "HAND_SHAKE", 0.3)
                DoScreenFadeIn(200)
            elseif self.cameraMode == 2 then
                DoScreenFadeOut(200)
                while not IsScreenFadedOut() do
                    Wait(0)
                end
                self.cameraMode = 3
                local camOffset = GetOffsetFromEntityInWorldCoords(self.tableObject, 1.45, -0.15, 2.15)
                SetCamCoord(self.rulettCam, camOffset)
                SetCamRot(self.rulettCam, -58.0, 0.0, self.data.rot + 90.0, 2)
                ShakeCam(self.rulettCam, "HAND_SHAKE", 0.3)
                SetCamFov(self.rulettCam, 80.0)
                DoScreenFadeIn(200)
            elseif self.cameraMode == 3 then
                DoScreenFadeOut(200)
                while not IsScreenFadedOut() do
                    Wait(0)
                end
                self.cameraMode = 4
                local camOffset = GetWorldPositionOfEntityBone(self.tableObject, GetEntityBoneIndexByName(self.tableObject, "Roulette_Wheel"))
                local rot = vector3(270.0, -90.0, self.data.rot + 270.0)
                SetCamCoord(self.rulettCam, camOffset + vector3(0.0, 0.0, 0.5))
                SetCamRot(self.rulettCam, rot, 2)
                StopCamShaking(self.rulettCam, false)
                SetCamFov(self.rulettCam, 80.0)
                DoScreenFadeIn(200)
            elseif self.cameraMode == 4 then
                DoScreenFadeOut(200)
                while not IsScreenFadedOut() do
                    Wait(0)
                end
                self.cameraMode = 1
                local rot = vector3(270.0, -90.0, self.data.rot + 270.0)
                SetCamCoord(self.rulettCam, self.data.position + vector3(0.0, 0.0, 2.0))
                SetCamRot(self.rulettCam, rot, 2)
                SetCamFov(self.rulettCam, 80.0)
                StopCamShaking(self.rulettCam, false)
                DoScreenFadeIn(200)
            end
        end
    end

    self.loadTableData = function()
        Config_roulette.DebugMsg("Table data creating, loading..")
        self.numbersData = {}
        self.betData = {}
        local e = 1
        for i = 0, 11, 1 do
            for j = 0, 2, 1 do
                table.insert(
                    self.numbersData,
                    {
                        name = e + 1,
                        hoverPos = GetOffsetFromEntityInWorldCoords(self.tableObject, (0.081 * i) - 0.057, (0.167 * j) - 0.192, 0.9448),
                        hoverObject = "vw_prop_vw_marker_02a"
                    }
                )
                local offset = nil
                if j == 0 then
                    offset = 0.155
                elseif j == 1 then
                    offset = 0.171
                elseif j == 2 then
                    offset = 0.192
                end

                table.insert(
                    self.betData,
                    {
                        betId = e,
                        name = e + 1,
                        pos = GetOffsetFromEntityInWorldCoords(self.tableObject, (0.081 * i) - 0.057, (0.167 * j) - 0.192, 0.9448),
                        objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.081 * i - 0.057, 0.167 * j - 0.192, 0.9448),
                        hoverNumbers = {e}
                    }
                )

                e = e + 1
            end
        end
        table.insert(
            self.numbersData,
            {
                name = "Zero",
                hoverPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.137, -0.148, 0.9448),
                hoverObject = "vw_prop_vw_marker_01a"
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "Zero",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.137, -0.148, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.137, -0.148, 0.9448),
                hoverNumbers = {#self.numbersData}
            }
        )
        table.insert(
            self.numbersData,
            {
                name = "Double Zero",
                hoverPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.133, 0.107, 0.9448),
                hoverObject = "vw_prop_vw_marker_01a"
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "Double Zero",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.133, 0.107, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.133, 0.107, 0.9448),
                hoverNumbers = {#self.numbersData}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "RED",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.3, -0.4, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.3, -0.4, 0.9448),
                hoverNumbers = {1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "BLACK",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.5, -0.4, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.5, -0.4, 0.9448),
                hoverNumbers = {0, 2, 4, 6, 8, 9, 11, 13, 15, 18, 20, 22, 24, 26, 27, 29, 31, 33, 35}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "EVEN",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.15, -0.4, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.15, -0.4, 0.9448),
                hoverNumbers = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "ODD",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.65, -0.4, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.65, -0.4, 0.9448),
                hoverNumbers = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "1to18",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.02, -0.4, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, -0.02, -0.4, 0.9448),
                hoverNumbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "19to36",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.78, -0.4, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.78, -0.4, 0.9448),
                hoverNumbers = {19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "1st 12",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.05, -0.3, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.05, -0.3, 0.9448),
                hoverNumbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "2nd 12",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.4, -0.3, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.4, -0.3, 0.9448),
                hoverNumbers = {13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "3rd 12",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.75, -0.3, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.75, -0.3, 0.9448),
                hoverNumbers = {25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "2to1",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, -0.15, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, -0.15, 0.9448),
                hoverNumbers = {1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "2to1",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.0, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.0, 0.9448),
                hoverNumbers = {2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35}
            }
        )
        table.insert(
            self.betData,
            {
                betId = #self.betData,
                name = "2to1",
                pos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.15, 0.9448),
                objectPos = GetOffsetFromEntityInWorldCoords(self.tableObject, 0.91, 0.15, 0.9448),
                hoverNumbers = {3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36}
            }
        )

        Config_roulette.DebugMsg("Table data successfully created..")
    end

    self.speakPed = function(speakName)
        PlayAmbientSpeech1(self.ped, speakName, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR", 1)
    end

    self.createBetObjects = function(bets)
        for i = 1, #self.betObjects, 1 do
            if DoesEntityExist(self.betObjects[i].obj) then
                DeleteObject(self.betObjects[i].obj)
            end
        end

        self.betObjects = {}

        local existBetId = {}

        for i = 1, #bets, 1 do
            local t = self.betData[bets[i].betId]

            if existBetId[bets[i].betId] == nil then
                existBetId[bets[i].betId] = 0
            else
                existBetId[bets[i].betId] = existBetId[bets[i].betId] + 1
            end

            if t ~= nil then
                local betModelObject = getBetObjectType(bets[i].betAmount)

                if betModelObject ~= nil then
                    RequestModel(betModelObject)
                    while not HasModelLoaded(betModelObject) do
                        Wait(0)
                    end

                    local obj = CreateObject(betModelObject, t.objectPos.x, t.objectPos.y, t.objectPos.z + (existBetId[bets[i].betId] * 0.0081), false)
                    SetEntityHeading(obj, self.data.rot)
                    table.insert(
                        self.betObjects,
                        {
                            obj = obj,
                            betAmount = bets[i].betAmount,
                            playerSrc = bets[i].playerSrc,
                            name = t.name
                        }
                    )
                end
            end
        end
    end

    self.hoverNumbers = function(hoveredNumbers)
        for i = 1, #self.hoverObjects, 1 do
            if DoesEntityExist(self.hoverObjects[i]) then
                DeleteObject(self.hoverObjects[i])
            end
        end

        self.hoverObjects = {}

        for i = 1, #hoveredNumbers, 1 do
            local t = self.numbersData[hoveredNumbers[i]]
            if t ~= nil then
                RequestModel(GetHashKey(t.hoverObject))
                while not HasModelLoaded(GetHashKey(t.hoverObject)) do
                    Wait(0)
                end

                local obj = CreateObject(GetHashKey(t.hoverObject), t.hoverPos, false)
                SetEntityHeading(obj, self.data.rot)

                table.insert(self.hoverObjects, obj)
            end
        end

        if #self.hoverObjects > 0 then
            PlaySoundFrontend(-1, "DLC_VW_BET_HIGHLIGHT", "dlc_vw_table_games_frontend_sounds", true)
        end
    end

    self.betRenderState = function(state)
        enabledBetRender = state

        Config_roulette.DebugMsg("Bet rendering turned: %s", enabledBetRender)

        if state then
            CreateThread(
                function()
                    while enabledBetRender do
                        Wait(8)

                        if aimingAtBet ~= -1 and lastAimedBet ~= aimingAtBet then
                            Config_roulette.DebugMsg("aimed at different bet.")
                            lastAimedBet = aimingAtBet
                            local bettingData = self.betData[aimingAtBet]
                            if bettingData ~= nil then
                                self.hoverNumbers(bettingData.hoverNumbers)
                            else
                                self.hoverNumbers({})
                            end
                        end

                        if aimingAtBet == -1 and lastAimedBet ~= -1 then
                            self.hoverNumbers({})
                        end
                    end
                end
            )


            CreateThread(
                function()
                    while enabledBetRender do
                        Wait(0)

                        ShowCursorThisFrame()

                        local e = Rulettek[selectedRulett]
                        if e ~= nil then
                            local cx, cy = GetNuiCursorPosition()
                            local rx, ry = GetActiveScreenResolution()

                            local n = 30 -- this is for the cursor point, how much to tolerate in range, increasing it you will find it easier to click on the bets.

                            local foundBet = false

                            for i = 1, #self.betData, 1 do
                                local bettingData = self.betData[i]
                                local onScreen, screenX, screenY = World3dToScreen2d(bettingData.pos.x, bettingData.pos.y, bettingData.pos.z)
                                local l = math.sqrt(math.pow(screenX * rx - cx, 2) + math.pow(screenY * ry - cy, 2))
                                if l < n then
                                    aimingAtBet = i
                                    foundBet = true

                                    if IsDisabledControlJustPressed(0, 24) then
                                        if currentBetAmount > 0 then
                                            if Config_roulette.RulettTables[selectedRulett] ~= nil then
                                                if
                                                    currentBetAmount >= Config_roulette.RulettTables[selectedRulett].minBet and
                                                        currentBetAmount <= Config_roulette.RulettTables[selectedRulett].maxBet
                                                 then
                                                    if (GetGameTimer() >= (lastBet or 0) + 1000) then
                                                        PlaySoundFrontend(-1, "DLC_VW_BET_DOWN", "dlc_vw_table_games_frontend_sounds", true)
                                                        TriggerServerEvent("casino:taskBetRulett", selectedRulett, aimingAtBet, currentBetAmount)
                                                        lastBet = GetGameTimer()
                                                    end
                                                else
                                                    PlaySoundFrontend(-1, "DLC_VW_ERROR_MAX", "dlc_vw_table_games_frontend_sounds", true)
                                                    Utils.ShowNotification(_U("limit_exceed"))
                                                end
                                            end
                                        else
                                            Utils.ShowNotification(_U("invalid_bet"))
                                        end
                                    end
                                end
                            end

                            if not foundBet then
                                aimingAtBet = -1
                            end
                        end
                    end
                end
            )
        end
    end

    self.spinRulett = function(tickRate)
        Config_roulette.DebugMsg(self.index)
        if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) and GetEntityBoneCount(self.tableObject) == 10 then
            Config_roulette.DebugMsg("spinRulett event 1")

            self.speakPed("MINIGAME_DEALER_CLOSED_BETS")
            TaskPlayAnim(self.ped, "anim_casino_b@amb@casino@games@roulette@dealer_female", "no_more_bets", 3.0, 3.0, -1, 0, 0, true, true, true)

            Wait(1500)

            if DoesEntityExist(self.ballObject) then
                DeleteObject(self.ballObject)
            end

            TaskPlayAnim(self.ped, "anim_casino_b@amb@casino@games@roulette@dealer_female", "spin_wheel", 3.0, 3.0, -1, 0, 0, true, true, true)

            RequestModel(GetHashKey("vw_prop_roulette_ball"))
            while not HasModelLoaded(GetHashKey("vw_prop_roulette_ball")) do
                Wait(0)
            end

            local ballOffset = GetWorldPositionOfEntityBone(self.tableObject, GetEntityBoneIndexByName(self.tableObject, "Roulette_Wheel"))

            Config_roulette.DebugMsg("spinRulett event 2")

            local LIB = "anim_casino_b@amb@casino@games@roulette@table"
            RequestAnimDict(LIB)
            while not HasAnimDictLoaded(LIB) do
                Wait(0)
            end

            Wait(3000)

            self.ballObject = CreateObject(GetHashKey("vw_prop_roulette_ball"), ballOffset, false)
            SetEntityHeading(self.ballObject, self.data.rot)
            SetEntityCoordsNoOffset(self.ballObject, ballOffset, false, false, false)
            local h = GetEntityRotation(self.ballObject)
            SetEntityRotation(self.ballObject, h.x, h.y, h.z + 90.0, 2, false)

            if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
                Config_roulette.DebugMsg("spinRulett event 3")

                local firstCount, secondCount, thirdCount = 0, 0, 0
                for k, v in pairs(self.betObjects) do
                    if
                        (type(v.name) == "number" and v.name >= 1 and v.name <= 12) or v.name == "1st 12" or v.name == "1to18" or v.name == "EVEN" or
                            v.name == "Zero" or
                            v.name == "Double Zero"
                     then
                        firstCount = firstCount + 1
                    end

                    if (type(v.name) == "number" and v.name >= 13 and v.name <= 24) or v.name == "2nd 12" or v.name == "RED" or v.name == "BLACK" then
                        secondCount = secondCount + 1
                    end

                    if
                        (type(v.name) == "number" and v.name >= 25 and v.name <= 36) or v.name == "3rd 12" or v.name == "ODD" or v.name == "19to36" or
                            v.name == "2to1"
                     then
                        thirdCount = thirdCount + 1
                    end
                end

                PlayEntityAnim(self.ballObject, "intro_ball", LIB, 1000.0, false, true, false, 0, 136704)
                PlayEntityAnim(self.ballObject, "loop_ball", LIB, 1000.0, true, false, false, 0, 136704)

                PlayEntityAnim(self.tableObject, "intro_wheel", LIB, 1000.0, false, true, true, 0, 136704)
                PlayEntityAnim(self.tableObject, "loop_wheel", LIB, 1000.0, false, true, false, 0, 136704)

                PlaySoundFromEntity(-1, "dlc_vw_roulette_exit_" .. tickRate, self.ballObject, "dlc_vw_table_games_roulette_exit_sounds", false, 0)

                PlayEntityAnim(self.ballObject, string.format("exit_%s_ball", tickRate), LIB, 1000.0, false, true, false, 0, 136704)
                PlayEntityAnim(self.tableObject, string.format("exit_%s_wheel", tickRate), LIB, 1000.0, false, true, false, 0, 136704)

                Wait(11e3)

                self.speakPed("MINIGAME_ROULETTE_BALL_" .. Config_roulette.rouletteSzamok[tickRate])

                if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
                    local pos = selectedRulett and Config_roulette.RulettTables[selectedRulett].position or GetEntityCoords(PlayerPedId())

                    if firstCount > 0 then
                        if firstCount >= 11 then
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_LRG", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        elseif firstCount >= 3 then
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_MED", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        else
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_SML", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        end

                        TaskPlayAnim(
                            self.ped,
                            "anim_casino_b@amb@casino@games@roulette@dealer_female",
                            "clear_chips_zone1",
                            3.0,
                            3.0,
                            -1,
                            0,
                            0,
                            true,
                            true,
                            true
                        )
                        Wait(1500)
                    end

                    if secondCount > 0 then
                        if secondCount >= 11 then
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_LRG", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        elseif secondCount >= 3 then
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_MED", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        else
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_SML", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        end

                        TaskPlayAnim(
                            self.ped,
                            "anim_casino_b@amb@casino@games@roulette@dealer_female",
                            "clear_chips_zone2",
                            3.0,
                            3.0,
                            -1,
                            0,
                            0,
                            true,
                            true,
                            true
                        )
                        Wait(1500)
                    end

                    if thirdCount > 0 then
                        if thirdCount >= 11 then
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_LRG", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        elseif thirdCount >= 3 then
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_MED", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        else
                            PlaySoundFromCoord(-1, "DLC_VW_CHIP_DRAG_POT_SML", pos, "dlc_vw_table_games_sounds", false, 0, false)
                        end

                        TaskPlayAnim(
                            self.ped,
                            "anim_casino_b@amb@casino@games@roulette@dealer_female",
                            "clear_chips_zone3",
                            3.0,
                            3.0,
                            -1,
                            0,
                            0,
                            true,
                            true,
                            true
                        )
                    end

                    Wait(2000)
                    if DoesEntityExist(self.tableObject) and DoesEntityExist(self.ped) then
                        TaskPlayAnim(self.ped, "anim_casino_b@amb@casino@games@roulette@dealer_female", "idle", 3.0, 3.0, -1, 0, 0, true, true, true)
                    end

                    Config_roulette.DebugMsg("spinRulett event ending")

                    if DoesEntityExist(self.ballObject) then
                        DeleteEntity(self.ballObject)
                    end
                end
            end
        end
    end

    self.loadTableData()
    Config_roulette.DebugMsg(string.format("Rulett table created %s id", self.index))
    Rulettek[self.index] = self
end

function changeBetAmount(amount)
    if not selectedRulett or not Config_roulette.RulettTables[selectedRulett] then
        return
    end

    if amount > Config_roulette.RulettTables[selectedRulett].maxBet then
        currentBetAmount = Config_roulette.RulettTables[selectedRulett].maxBet
        return
    end

    currentBetAmount = amount
    -- SendNUIMessage(
    --     {
    --         action = "setBetAmount",
    --         amount = amount
    --     }
    -- )
end

function getGenericTextInput(type)
    if type == nil then
        type = ""
    end
    AddTextEntry("FMMC_MPM_NA", tostring(type))
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", tostring(type), "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then
            return result
        end
    end
    return false
end

function s2m(s)
    if s <= 0 then
        return "00:00"
    else
        local m = string.format("%02.f", math.floor(s / 60))
        return m .. ":" .. string.format("%02.f", math.floor(s - m * 60))
    end
end

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(0)
        end

        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            closetoRulett = false
            for k, v in pairs(Config_roulette.RulettTables) do
                if #(playerCoords - Config_roulette.RulettTables[k].position) < 50.0 then
                    closetoRulett = true
                end
            end
            Wait(1000)
        end
    end
)

CreateThread(
    function()
        

        while not NetworkIsSessionActive() do
            Wait(0)
        end

        while not closetoRulett do
            Wait(50)
        end

        for rulettIndex, data in pairs(Config_roulette.RulettTables) do
            createRulettAsztal(rulettIndex, data)

            RequestAnimDict("anim_casino_b@amb@casino@games@roulette@table")
            RequestAnimDict("anim_casino_b@amb@casino@games@roulette@dealer_female")
            RequestAnimDict("anim_casino_b@amb@casino@games@shared@player@")
            RequestAnimDict("anim_casino_b@amb@casino@games@roulette@player")
        end

        Config_roulette.DebugMsg("Roulette loaded.")
    end
)

local lastSit = GetGameTimer()

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(0)
        end

        while true do
            local letSleep = true

            local playerpos = GetEntityCoords(PlayerPedId())

            if closetoRulett and selectedRulett == nil then
                for k, v in pairs(Rulettek) do
                    if DoesEntityExist(v.tableObject) then
                        local objcoords = GetEntityCoords(v.tableObject)
                        local dist = #(playerpos - objcoords)
                        if dist < 4.0 then
                            letSleep = false

                            local closestChairData = getClosestChairData(v.tableObject)
                            if closestChairData == nil then
                                break
                            end

                            Utils.ShowHelpNotification(GetLabelText("ROUL_PROMPT"))
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent("server_remote:rulett:taskSitDown", k, closestChairData)
                                Wait(5000)
                            end
                            break
                        end
                    else
                        v.tableObject = GetClosestObjectOfType(v.data.position, 2.0, GetHashKey("vw_prop_casino_roulette_01b"), false, false, false)
                    end
                end
            end

            if letSleep then
                Wait(1000)
            end
            Wait(0)
        end
    end
)

RegisterNetEvent("client_callback:rulett:taskSitDown")
AddEventHandler(
    "client_callback:rulett:taskSitDown",
    function(rulettIndex, chairData)
        TriggerEvent("casino:roulette:onSitDown")
        SELECTED_CHAIR_ID = chairData.chairId
        CURRENT_CHAIR_DATA = chairData
        SITTING_SCENE = NetworkCreateSynchronisedScene(chairData.position, chairData.rotation, 2, 1, 0, 1065353216, 0, 1065353216)
        RequestAnimDict("anim_casino_b@amb@casino@games@shared@player@")
        while not HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@player@") do
            Wait(0)
        end

        local randomSit = ({"sit_enter_left", "sit_enter_right"})[math.random(1, 2)]
        NetworkAddPedToSynchronisedScene(PlayerPedId(), SITTING_SCENE, "anim_casino_b@amb@casino@games@shared@player@", randomSit, 2.0, -2.0, 13, 16, 2.0, 0)
        NetworkStartSynchronisedScene(SITTING_SCENE)
        SetPlayerControl(PlayerId(), 0, 0)
        startRulett(rulettIndex, chairData.chairId)
        Wait(4000)
        SetPlayerControl(PlayerId(), 1, 0)
    end
)

function startRulett(index, chairId)
    if Rulettek[index] then
        TriggerServerEvent("casino:taskStartRoulette", index, chairId)
    end
end

RegisterNetEvent("client:casino:openRulett")
AddEventHandler(
    "client:casino:openRulett",
    function(rulettIndex)
        if Rulettek[rulettIndex] ~= nil then
            Wait(4000)
            Rulettek[rulettIndex].enableCamera(true)
        end
    end
)

RegisterNetEvent("casino:rulett:startSpin")
AddEventHandler(
    "casino:rulett:startSpin",
    function(rulettIndex, tickRate)
        if Rulettek[rulettIndex] ~= nil then
            Config_roulette.DebugMsg(string.format("rulett table index: %s, tickrate: %s", rulettIndex, tickRate))
            Rulettek[rulettIndex].spinRulett(tickRate)

            if selectedRulett == rulettIndex then
                Config_roulette.DebugMsg("impartial anim play")
                playImpartial()
            end
        end
    end
)

RegisterNetEvent("client:rulett:updateStatusz")
AddEventHandler(
    "client:rulett:updateStatusz",
    function(rulettIndex, ido, statusz)
        if Rulettek[rulettIndex] ~= nil then
            Rulettek[rulettIndex].ido = ido
            Rulettek[rulettIndex].statusz = statusz
            casinoNuiUpdateGame(rulettIndex, ido, statusz)
        end
    end
)

RegisterNetEvent("client:rulett:updateTableBets")
AddEventHandler(
    "client:rulett:updateTableBets",
    function(rulettIndex, bets)
        if Rulettek[rulettIndex] ~= nil then
            if #bets == 0 then
                betsLeft = 10
                totalBetAmount = 0
            end

            Rulettek[rulettIndex].createBetObjects(bets)

            local resetTotal = false
            local uniqueBets = {}

            if selectedRulett == rulettIndex then
                for i = 1, #bets do
                    if bets[i].playerSrc == GetPlayerServerId(PlayerId()) then
                        if not resetTotal then
                            resetTotal = true
                            totalBetAmount = 0
                        end

                        if not uniqueBets[bets[i].betId] then
                            uniqueBets[bets[i].betId] = true
                        end

                        totalBetAmount = totalBetAmount + bets[i].betAmount
                    end
                end

                local betsPlaced = 0
                for _, v in pairs(uniqueBets) do
                    betsPlaced = betsPlaced + 1
                end

                betsLeft = 10 - betsPlaced
            end
        end
    end
)

function casinoNuiUpdateGame(rulettIndex, ido, statusz)
    if selectedRulett == rulettIndex then
        if not statusz then
            -- SendNUIMessage(
            --     {
            --         action = "setGameInfo",
            --         header = _U("starting_soon"),
            --         szoveg = string.format("%s %s", ido, _U("seconds"))
            --     }
            -- )
            timeLeft = ido
        else
            -- SendNUIMessage(
            --     {
            --         action = "setGameInfo",
            --         header = _U("game_going_on"),
            --         szoveg = nil
            --     }
            -- )
        end
    end
end

RegisterNetEvent("casino:nui:updateChips")
AddEventHandler(
    "casino:nui:updateChips",
    function(amount)
        SendNUIMessage(
            {
                action = "setCurrentChips",
                amount = amount
            }
        )
    end
)

function getClosestChairData(tableObject)
    local localPlayer = PlayerPedId()
    local playerpos = GetEntityCoords(localPlayer)
    if DoesEntityExist(tableObject) and GetEntityBoneCount(tableObject) == 10 then
        local chairs = {"Chair_Base_01", "Chair_Base_02", "Chair_Base_03", "Chair_Base_04"}

        local closestChair = nil
        local closestDist = 1.7

        for i = 1, #chairs, 1 do
            local objcoords = GetWorldPositionOfEntityBone(tableObject, GetEntityBoneIndexByName(tableObject, chairs[i]))
            local dist = #(playerpos - objcoords)

            if dist < closestDist then
                closestDist = dist
                closestChair = {
                    position = objcoords,
                    rotation = GetWorldRotationOfEntityBone(tableObject, GetEntityBoneIndexByName(tableObject, chairs[i])),
                    chairId = Config_roulette.ChairIds[chairs[i]]
                }
            end
        end

        return closestChair
    end
end

function getBetObjectType(betAmount)
    if betAmount < 10 then
        return GetHashKey("vw_prop_vw_coin_01a")
    elseif betAmount >= 10 and betAmount < 50 then
        return GetHashKey("vw_prop_chip_10dollar_x1")
    elseif betAmount >= 50 and betAmount < 100 then
        return GetHashKey("vw_prop_chip_50dollar_x1")
    elseif betAmount >= 100 and betAmount < 500 then
        return GetHashKey("vw_prop_chip_100dollar_x1")
    elseif betAmount >= 500 and betAmount < 1000 then
        return GetHashKey("vw_prop_chip_500dollar_x1")
    elseif betAmount >= 1000 and betAmount < 5000 then
        return GetHashKey("vw_prop_chip_1kdollar_x1")
    elseif betAmount >= 5000 then
        return GetHashKey("vw_prop_plaq_10kdollar_x1")
    else -- this should never happen, but yeah.
        return GetHashKey("vw_prop_plaq_10kdollar_x1")
    end

    -- these are deprecated, it looks cool, but it hides some data, you can put it in you like the big chip piles.

    -- elseif bets[i].betAmount >= 10000 and bets[i].betAmount < 25000 then
    --     return GetHashKey('vw_prop_vw_chips_pile_01a')
    -- elseif bets[i].betAmount >= 25000 and bets[i].betAmount < 50000 then
    --     return GetHashKey('vw_prop_vw_chips_pile_02a')
    -- elseif bets[i].betAmount >= 50000 then
    --     return GetHashKey('vw_prop_vw_chips_pile_03a')
    -- end
end

RegisterNetEvent("client:rulett:playBetAnim")
AddEventHandler(
    "client:rulett:playBetAnim",
    function(chairId)
        local sex = 0

        if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
            sex = 1
        end

        local rot = CURRENT_CHAIR_DATA.rotation

        if chairId == 4 then
            rot = rot + vector3(0.0, 0.0, 90.0)
        elseif chairId == 3 then
            rot = rot + vector3(0.0, 0.0, -180.0)
        elseif chairId == 2 then
            rot = rot + vector3(0.0, 0.0, -90.0)
        elseif chairId == 1 then
            chairId = 1
            rot = rot + vector3(0.0, 0.0, -90.0)
        end

        local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@play@v01", chairId, chairId)
        if sex == 1 then
            L = string.format("anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@play@v01", chairId, chairId)
        end

        RequestAnimDict(L)
        while not HasAnimDictLoaded(L) do
            Wait(0)
        end

        if CURRENT_CHAIR_DATA ~= nil then
            local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
            NetworkAddPedToSynchronisedScene(
                PlayerPedId(),
                currentScene,
                L,
                ({"place_bet_zone1", "place_bet_zone2", "place_bet_zone3"})[math.random(1, 3)],
                4.0,
                -2.0,
                13,
                16,
                1148846080,
                0
            )
            NetworkStartSynchronisedScene(currentScene)

            idleTimer = 8
        end
    end
)

RegisterNetEvent("client:rulett:playWinAnim")
AddEventHandler(
    "client:rulett:playWinAnim",
    function(chairId)
        PlaySoundFrontend(-1, "DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds", true)
        local rot = CURRENT_CHAIR_DATA.rotation

        if chairId == 4 then
            rot = rot + vector3(0.0, 0.0, 90.0)
        elseif chairId == 3 then
            rot = rot + vector3(0.0, 0.0, -180.0)
        elseif chairId == 2 then
            rot = rot + vector3(0.0, 0.0, -90.0)
        elseif chairId == 1 then
            chairId = 1
            rot = rot + vector3(0.0, 0.0, -90.0)
        end

        local sex = 0
        local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@reacts@v01", chairId, chairId)

        if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
            sex = 1
        end

        if sex == 1 then
            local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@reacts@v01", chairId, chairId)
        end

        RequestAnimDict(L)
        while not HasAnimDictLoaded(L) do
            Wait(0)
        end

        if CURRENT_CHAIR_DATA ~= nil then
            local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), currentScene, L, "reaction_great", 4.0, -2.0, 13, 16, 1148846080, 0)
            NetworkStartSynchronisedScene(currentScene)

            idleTimer = 8
        end
    end
)

RegisterNetEvent("client:rulett:playLossAnim")
AddEventHandler(
    "client:rulett:playLossAnim",
    function(chairId)
        local rot = CURRENT_CHAIR_DATA.rotation

        if chairId == 4 then
            rot = rot + vector3(0.0, 0.0, 90.0)
        elseif chairId == 3 then
            rot = rot + vector3(0.0, 0.0, -180.0)
        elseif chairId == 2 then
            rot = rot + vector3(0.0, 0.0, -90.0)
        elseif chairId == 1 then
            chairId = 1
            rot = rot + vector3(0.0, 0.0, -90.0)
        end

        local sex = 0
        local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@reacts@v01", chairId, chairId)

        if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
            sex = 1
        end

        if sex == 1 then
            local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@reacts@v01", chairId, chairId)
        end

        RequestAnimDict(L)
        while not HasAnimDictLoaded(L) do
            Wait(0)
        end

        if CURRENT_CHAIR_DATA ~= nil then
            local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
            NetworkAddPedToSynchronisedScene(
                PlayerPedId(),
                currentScene,
                L,
                ({"reaction_bad_var01", "reaction_bad_var02", "reaction_terrible"})[math.random(1, 3)],
                4.0,
                -2.0,
                13,
                16,
                1148846080,
                0
            )
            NetworkStartSynchronisedScene(currentScene)

            idleTimer = 8
        end
    end
)

RegisterNetEvent("casino:roulette:onChipsChange")
AddEventHandler(
    "casino:roulette:onChipsChange",
    function(amount, isIncrease)
        RequestScaleformScriptHudMovie(21)
        while not HasScaleformScriptHudMovieLoaded(21) do
            Wait(0)
        end

        RequestScaleformScriptHudMovie(22)
        while not HasScaleformScriptHudMovieLoaded(22) do
            Wait(0)
        end

        local chips = 0
        local inventory = exports.ox_inventory:Search('count', {'casino_chips', 'casino_comp_chips'})
        if inventory then
            for name, count in pairs(inventory) do
                chips = chips + count
            end
        end

        -- RemoveScaleformScriptHudMovie(21)
        BeginScaleformScriptHudMovieMethod(21, "SET_PLAYER_CHIPS")
        ScaleformMovieMethodAddParamInt(chips)
        EndScaleformMovieMethod()

        BeginScaleformScriptHudMovieMethod(22, "SET_PLAYER_CHIP_CHANGE")
        ScaleformMovieMethodAddParamInt(amount)
        ScaleformMovieMethodAddParamBool(isIncrease)
        EndScaleformMovieMethod()

        SetTimeout(
            5000,
            function()
                RemoveScaleformScriptHudMovie(22)
            end
        )
    end
)

AddEventHandler(
    "casino:roulette:onSitDown",
    function()
        TriggerEvent("pma-voice:toggleui")
        if LocalPlayer.state.invOpen then
            exports.ox_inventory:closeInventory()
        end
        exports["nearest-postal"]:hidePostal(true)
        exports.npwd:setPhoneDisabled(true)

        RequestScaleformScriptHudMovie(21)
        while not HasScaleformScriptHudMovieLoaded(21) do
            Wait(0)
        end

        local chips = 0
        local inventory = exports.ox_inventory:Search('count', {'casino_chips', 'casino_comp_chips'})
        if inventory then
            for _, count in pairs(inventory) do
                chips = chips + count
            end
        end

        BeginScaleformScriptHudMovieMethod(21, "SET_PLAYER_CHIPS")
        ScaleformMovieMethodAddParamInt(chips)
        EndScaleformMovieMethod()
    end
)

AddEventHandler(
    "casino:roulette:onStandUp",
    function()
        TriggerEvent("pma-voice:toggleui")
        exports["nearest-postal"]:hidePostal(false)
        exports.npwd:setPhoneDisabled(true)

        RemoveScaleformScriptHudMovie(21)
        RemoveScaleformScriptHudMovie(22)
    end
)

function playImpartial()
    local rot = CURRENT_CHAIR_DATA.rotation

    if SELECTED_CHAIR_ID == 4 then
        rot = rot + vector3(0.0, 0.0, 90.0)
    elseif SELECTED_CHAIR_ID == 3 then
        rot = rot + vector3(0.0, 0.0, -180.0)
    elseif SELECTED_CHAIR_ID == 2 then
        rot = rot + vector3(0.0, 0.0, -90.0)
    elseif SELECTED_CHAIR_ID == 1 then
        SELECTED_CHAIR_ID = 1
        rot = rot + vector3(0.0, 0.0, -90.0)
    end

    local sex = 0
    local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@reacts@v01", SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)

    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        sex = 1
    end

    if sex == 1 then
        local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@reacts@v01", SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)
    end

    RequestAnimDict(L)
    while not HasAnimDictLoaded(L) do
        Wait(0)
    end

    if CURRENT_CHAIR_DATA ~= nil then
        local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(
            PlayerPedId(),
            currentScene,
            L,
            ({"reaction_impartial_var01", "reaction_impartial_var02", "reaction_impartial_var03"})[math.random(1, 3)],
            4.0,
            -2.0,
            13,
            16,
            1148846080,
            0
        )
        NetworkStartSynchronisedScene(currentScene)

        idleTimer = 8
    end
end

function playRulettIdle()
    local rot = CURRENT_CHAIR_DATA.rotation

    if SELECTED_CHAIR_ID == 4 then
        rot = rot + vector3(0.0, 0.0, 90.0)
    elseif SELECTED_CHAIR_ID == 3 then
        rot = rot + vector3(0.0, 0.0, -180.0)
    elseif SELECTED_CHAIR_ID == 2 then
        rot = rot + vector3(0.0, 0.0, -90.0)
    elseif SELECTED_CHAIR_ID == 1 then
        SELECTED_CHAIR_ID = 1
        rot = rot + vector3(0.0, 0.0, -90.0)
    end

    local sex = 0
    local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_male@seat_%s@regular@0%sa@idles", SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)

    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        sex = 1
    end

    if sex == 1 then
        local L = string.format("anim_casino_b@amb@casino@games@roulette@ped_female@seat_%s@regular@0%sa@idles", SELECTED_CHAIR_ID, SELECTED_CHAIR_ID)
    end

    RequestAnimDict(L)
    while not HasAnimDictLoaded(L) do
        Wait(0)
    end

    if CURRENT_CHAIR_DATA ~= nil then
        local currentScene = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, rot, 2, 1, 0, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(
            PlayerPedId(),
            currentScene,
            L,
            ({"idle_a", "idle_b", "idle_c", "idle_d"})[math.random(1, 4)],
            1.0,
            -2.0,
            13,
            16,
            1148846080,
            0
        )
        SetSynchronizedSceneLooped(currentScene, true)
        NetworkStartSynchronisedScene(currentScene)
    end
end

function addRandomClothes(ped)
    local r = math.random(1, 5)
    SetPedDefaultComponentVariation(ped)

    if r == 1 then
        SetPedComponentVariation(ped, 0, 4, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 4, 0, 0)
        SetPedComponentVariation(ped, 3, 2, 1, 0)
        SetPedComponentVariation(ped, 4, 1, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 1, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 0, 0, 0)
        SetPedPropIndex(ped, 1, 0, 0, false)
    elseif r == 2 then
        SetPedComponentVariation(ped, 0, 3, 1, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 3, 1, 0)
        SetPedComponentVariation(ped, 3, 1, 1, 0)
        SetPedComponentVariation(ped, 4, 1, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 2, 0, 0)
        SetPedComponentVariation(ped, 8, 1, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 0, 0, 0)
    elseif r == 3 then
        SetPedComponentVariation(ped, 0, 3, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 3, 0, 0)
        SetPedComponentVariation(ped, 3, 0, 1, 0)
        SetPedComponentVariation(ped, 4, 1, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 1, 0, 0)
        SetPedComponentVariation(ped, 8, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 0, 0, 0)
        SetPedPropIndex(ped, 1, 0, 0, false)
    elseif r == 4 then
        SetPedComponentVariation(ped, 0, 2, 1, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 2, 1, 0)
        SetPedComponentVariation(ped, 3, 3, 3, 0)
        SetPedComponentVariation(ped, 4, 1, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 2, 0, 0)
        SetPedComponentVariation(ped, 8, 3, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 0, 0, 0)
    end
end
