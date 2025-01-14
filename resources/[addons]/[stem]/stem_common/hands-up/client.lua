Citizen.CreateThread(
    function()
        local dict = "missminuteman_1ig_2"
        local anim = "handsup_base"

        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        local surrender = {
            dict = {
                "random@arrests",
                "random@arrests@busted"
            },
            firstPressed = nil,
            lastPressed = nil,
            EnterAnimation = function(self)
                local plyPed = PlayerPedId()
                ClearPedTasks(plyPed)
                -- Citizen.Wait(1000)
                TaskPlayAnim(plyPed, self.dict[1], "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, false, false, false)
                Citizen.Wait(4000)
                TaskPlayAnim(plyPed, self.dict[1], "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, false, false, false)
                Citizen.Wait(500)
                TaskPlayAnim(plyPed, self.dict[2], "enter", 8.0, 1.0, -1, 2, 0, false, false, false)
                Citizen.Wait(1000)
                TaskPlayAnim(plyPed, self.dict[2], "idle_a", 8.0, 1.0, -1, 2, 0, false, false, false)
            end,
            ExitAnimation = function(self)
                TaskPlayAnim(PlayerPedId(), self.dict[2], "exit", 8.0, 1.0, -1, 2, 0, false, false, false)
            end
        }

        RequestAnimDict(surrender.dict[1])
        while not HasAnimDictLoaded(surrender.dict[1]) do
            Citizen.Wait(0)
        end
        RequestAnimDict(surrender.dict[2])
        while not HasAnimDictLoaded(surrender.dict[2]) do
            Citizen.Wait(0)
        end

        local scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end

        local handsup = false
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()

            if
                IsUsingKeyboard(0) and IsControlJustPressed(0, 244) and not IsPedReloading(playerPed) and not LocalPlayer.state.blockClearTasks and
                    not LocalPlayer.state.handcuffed and
                    GetPedType(playerPed) == 2
             then
                if not handsup then
                    TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
                    handsup = true
                    LocalPlayer.state:set("handsup", handsup, true)
                else
                    handsup = false
                    LocalPlayer.state:set("handsup", handsup, true)
                    ClearPedTasks(playerPed)
                end
            end

            if IsEntityPlayingAnim(playerPed, dict, anim, 3) and not IsPedInAnyVehicle(playerPed, false) then
                PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
                PopScaleformMovieFunctionVoid()

                BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
                ScaleformMovieMethodAddParamInt(0)
                ScaleformMovieMethodAddParamInt(0)
                ScaleformMovieMethodAddParamInt(0)
                ScaleformMovieMethodAddParamInt(80)
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(0)
                ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 22, 0))
                ScaleformMovieMethodAddParamPlayerNameString("Hold to surrender")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
                EndScaleformMovieMethod()

                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)

                if
                    IsDisabledControlPressed(0, 22, true) and
                        (IsEntityPlayingAnim(playerPed, dict, anim, 3) or IsEntityPlayingAnim(playerPed, surrender.dict[2], "idle_a", 3)) and
                        not IsPedInAnyVehicle(playerPed, false)
                 then
                    if not surrender.firstPressed then
                        surrender.firstPressed = GetGameTimer()
                    end
                    surrender.lastPressed = GetGameTimer()

                    if surrender.lastPressed - surrender.firstPressed > 1000 then
                        if IsEntityPlayingAnim(playerPed, surrender.dict[2], "idle_a", 3) then
                            surrender:ExitAnimation()
                        else
                            surrender:EnterAnimation()
                        end

                        surrender.firstPressed = nil
                        surrender.lastPressed = nil
                    end
                else
                    surrender.firstPressed = nil
                    surrender.lastPressed = nil
                end
            end

            if IsEntityPlayingAnim(playerPed, dict, anim, 3) or IsEntityPlayingAnim(surrender.dict[2], "idle_a", 3) then
                DisableControlAction(0, 14, true)
                DisableControlAction(0, 15, true)
                DisableControlAction(0, 16, true)
                DisableControlAction(0, 17, true)
                DisableControlAction(0, 21, true)
                DisableControlAction(0, 22, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 37, true)
                DisableControlAction(0, 158, true)
                DisableControlAction(0, 289, true)
            end
        end
    end
)
