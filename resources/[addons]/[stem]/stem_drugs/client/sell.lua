local nr_drug_curSearching = false
local nr_drug_curSelling = false
local nr_drug_nextSaleTime = nil
local nr_currentBuyerPed = nil
local nr_currentBuyerNet = nil

function GetDrugZonePedIsIn(ped)
    local coords = GetEntityCoords(ped)
    local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)

    if zoneName == "CHAMH" or zoneName == "DAVIS" or zoneName == "STRAW" or zoneName == "RANCHO" or zoneName == "GRAPES" or zoneName == "BEACH" then
        return zoneName
    else
        return nil
    end
end

AddStateBagChangeHandler("drugWander", nil, function(bagName, key, value, _reserved, replicated)
    
    if not value then
        return
    end

    local pedNet = bagName:gsub("entity:", "")
    pedNet = tonumber(pedNet)

    local maxTime = GetGameTimer() + 1000
    while not NetworkDoesEntityExistWithNetworkId(pedNet) and GetGameTimer() < maxTime do
        Wait(0)
    end

    if not NetworkDoesEntityExistWithNetworkId(pedNet) then
        return
    end

    local ped = NetToPed(pedNet)

    while DoesEntityExist(ped) and not IsEntityDead(ped) do
        if not Entity(ped).state.drugWander then
            ClearPedTasks(ped)
            break
        else
            if NetworkHasControlOfEntity(ped) then
                if GetScriptTaskStatus(ped, `SCRIPT_TASK_WANDER_IN_AREA`) ~= 1 then
                    local coords = Entity(ped).state.drugBuyer?.taskCoords or GetEntityCoords(ped)
                    TaskWanderInArea(ped, coords.x, coords.y, coords.z, 16.0, 2.0, 5.0)
                    SetPedConfigFlag(ped, 146, true)
                end
            end
        end

        Wait(1000)
    end
end)

AddStateBagChangeHandler(
    "drugBuyer",
    nil,
    function(bagName, key, value, _reserved, _replicated)
        if not bagName:find("entity:") then
            return
        end

        local entityNet = bagName:gsub("entity:", "")
        entityNet = tonumber(entityNet)

        while not NetworkDoesEntityExistWithNetworkId(entityNet) do
            Wait(0)
        end

        if value and value.taskDone then
            return
        end

        local ghostPed = nil
        local ped = NetToPed(entityNet)

        while DoesEntityExist(ped) and not IsEntityDead(ped) do
            if Entity(ped).state.drugBuyer and Entity(ped).state.drugBuyer.taskDone then
                break
            end

            SetPedCombatAttributes(ped, 46, true)
            SetPedFleeAttributes(ped, 0, 0)
            SetPedConfigFlag(ped, 146, true)

            if NetworkHasControlOfEntity(ped) then
                SetBlockingOfNonTemporaryEvents(ped, true)

                if IsPedStill(ped) then
                    if GetScriptTaskStatus(ped, `SCRIPT_TASK_GO_TO_ENTITY`) ~= 1 then
                        if not ghostPed then
                            ghostPed = CreatePed(4, `mp_m_freemode_01`, value.taskCoords, value.heading, false, false)
                            SetBlockingOfNonTemporaryEvents(ghostPed, true)
                            SetEntityInvincible(ghostPed, true)
                            SetPedCanRagdoll(ghostPed, false)
                            SetPedCanBeTargetted(ghostPed, false)

                            FreezeEntityPosition(ghostPed, true)
                            SetEntityCollision(ghostPed, false, false)
                            SetEntityVisible(ghostPed, false, false)
                        end

                        TaskGoToEntity(ped, ghostPed, -1, 10.0, 1.0, 1073741824, 0)
                        -- TaskGoStraightToCoord(ped, value.taskCoords.x, value.taskCoords.y, value.taskCoords.z, 0.5, -1, 0, 0.05)
                    end
                end
            end

            Wait(500)
        end

        DeleteEntity(ghostPed)
    end
)

RegisterNetEvent("stem_drugs:sell:instCreated")
AddEventHandler(
    "stem_drugs:sell:instCreated",
    function(pedNetId)

        while not NetworkDoesEntityExistWithNetworkId(pedNetId) do
            Wait(0)
        end

        nr_currentBuyerPed = NetToPed(pedNetId)
        nr_currentBuyerNet = pedNetId
    end
)

RegisterNetEvent("stem_drugs:sell:clPlayerReported")
AddEventHandler(
    "stem_drugs:sell:clPlayerReported",
    function(coords)
        PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", false)
        local blip = AddBlipForRadius(coords.x, coords.y, coords.z, 50.0)
        SetBlipSprite(blip, 9)
        SetBlipAlpha(blip, 100)
        SetBlipColour(blip, 1)

        local postal = exports["nearest-postal"]:getPostalNearCoords(coords)
        local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)

        local subject = GetStreetNameFromHashKey(streetHash)
        if postal ~= -1 then
            subject = postal .. " " .. GetStreetNameFromHashKey(streetHash)
        end

        AddTextEntry("drugReportedNotification",
            "Suspicious activity has been reported at ~o~" .. subject .. "~s~. " .. "Press [Z] to set GPS.")
        BeginTextCommandThefeedPost("drugReportedNotification")
        EndTextCommandThefeedPostTicker(false, false)

        local endTime = GetGameTimer() + 15000
        while GetGameTimer() < endTime do
            if IsControlJustReleased(0, 20) then
                SetBlipRoute(blip, true)
                break
            end
            Wait(0)
        end

        SetTimeout(
            60000,
            function()
                RemoveBlip(blip)
            end
        )
    end
)


function GetPlayerGender()
    local gender = "Male"
    if ESX.PlayerData.sex == "f" then
        gender = "Female"
    end
    return gender
end

function GetStreetAndZone(coords)
    local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    return street .. ", " .. zone
end


AttemptDrugSell = function(area, key)
    if nr_drug_curSearching or nr_drug_curSelling then
        return
    end

    if Config.Sales.DisallowedJobs[ESX.PlayerData.job.name] then
        return
    end

    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do
        Wait(0)
    end

    local playerSellables = {}

    local playerPed = PlayerPedId()

    if not IsPedOnFoot(playerPed) then
        return
    end

    if IsPedInAnyVehicle(playerPed, true) then
        return
    end

    if IsPedDeadOrDying(playerPed, true) then
        return
    end

    if GetPedType(playerPed) ~= 2 then
        return
    end

    if GetEntityModel(playerPed) ~= GetHashKey("mp_m_freemode_01") and GetEntityModel(playerPed) ~= GetHashKey("mp_f_freemode_01") then
        return
    end

    if GetInteriorFromEntity(playerPed) ~= 0 then
        return
    end

    if exports["PolySZ"]:IsPedInAnySafeZone(playerPed) then
        return
    end

    local currentZone = GetDrugZonePedIsIn(playerPed)
    if not currentZone then
        return
    end

    if (currentZone == "BEACH" and not GlobalState.gangWar) then
        ESX.ShowHelpNotification("You cannot sell drugs in this zone at this time.")
        return
    end

    if ((currentZone ~= "BEACH" and currentZone ~= "GRAPES") and GlobalState.gangWar) then
        ESX.ShowHelpNotification("You cannot sell drugs in this zone during an active gang war.")
        return
    end

    local postal = exports["nearest-postal"]:getPostal()
    if postal ~= nil and Config.Sales.BlacklistedPostals[postal] then
        return
    end

    local currentCoords = GetEntityCoords(playerPed)
    if currentCoords.y > 500 then
        if GlobalState.jobCount["sahp"] < Config.Sales.SAHPRequired then
            ESX.ShowHelpNotification("Not enough ~b~police~s~ to sell at this time.")
            return
        end
    else
        if (GlobalState.jobCount["lspd"] + GlobalState.jobCount["lscso"]) < GetConvarInt('sv_copsRequiredCityDrugSales', Config.Sales.LSPDRequired) then
            ESX.ShowHelpNotification("Not enough ~b~police~s~ to sell at this time.")
            return
        end
    end

    local playerSellables = {}
    local inventory = exports.ox_inventory:Search('count', Config.Sales.ItemNames)
    if inventory then
        for name, count in pairs(inventory) do
            if count > 0 then
                playerSellables[#playerSellables + 1] = name
            end
        end
    end

    if #playerSellables < 1 then
        ESX.ShowNotification("You have nothing to sell here.")
        return
    end

    nr_drug_curSearching = true
    LocalPlayer.state.blockClearTasks = true

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_MOBILE", 0, true)

    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName("Attempting to find a buyer on Lifeinvader Marketplace...")
    EndTextCommandBusyspinnerOn(3)

    ESX.ShowHelpNotification("Press ~INPUT_CREATOR_LT~ to cancel searching.", false, true, 2500)

    TriggerServerEvent("stem_drugs:sell:searchingBuyer", GetPlayerGender(), GetStreetAndZone(currentCoords), nr_drug_nextSaleTime and GetGameTimer() < nr_drug_nextSaleTime)

    LocalPlayer.state.invBusy = true
    LocalPlayer.state.invHotkeys = false
    exports.ox_inventory:closeInventory()

    local scenarioEndtime = GetGameTimer() + 10000
    while GetGameTimer() < scenarioEndtime do
        if IsControlJustPressed(0, 252) then
            ESX.ShowNotification("Searching cancelled.")
            BusyspinnerOff()
            ClearPedTasks(playerPed)
            ClearPedTasksImmediately(playerPed)
            nr_drug_curSearching = false
            LocalPlayer.state.blockClearTasks = false
            LocalPlayer.state.invBusy = false
            LocalPlayer.state.invHotkeys = true
            
            DisableControlAction(0, 23, false)
            DisableControlAction(0, 37, false)
            DisableControlAction(0, 73, false)
            DisableControlAction(0, 244, false)
            DisableControlAction(0, 245, false)
            DisableControlAction(0, 289, false)
            DisableControlAction(0, 301, false)
            return
        end

        DisableControlAction(0, 23, true)
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 73, true)
        DisableControlAction(0, 244, true)
        DisableControlAction(0, 245, true)
        DisableControlAction(0, 289, true)
        DisableControlAction(0, 301, true)
        Wait(0)
    end

    LocalPlayer.state.invBusy = false
    LocalPlayer.state.invHotkeys = true

    if nr_drug_nextSaleTime then
        if GetGameTimer() < nr_drug_nextSaleTime then
            ESX.ShowHelpNotification("You are searching for a buyer too often. Please wait and try again.")
            BusyspinnerOff()
            ClearPedTasks(playerPed)
            LocalPlayer.state.blockClearTasks = false

            SetTimeout(
                5000,
                function()
                    nr_drug_curSearching = false
                end
            )
            return
        end
    end

    local maxFindTime = GetGameTimer() + 5000
    local spawnPos = nil
    while true do
        if GetGameTimer() > maxFindTime then
            break
        end

        local x, y, z = table.unpack(GetEntityCoords(playerPed))

        local rnd = math.random(-100, 100)
        while math.abs(rnd) < 50 do
            rnd = math.random(-100, 100)
            Wait(0)
        end
        x = x + rnd

        rnd = math.random(-100, 100)
        while math.abs(rnd) < 50 do
            rnd = math.random(-100, 100)
            Wait(0)
        end
        y = y + rnd

        local ret, pos = GetSafeCoordForPed(x, y, z, y < 400, 16)
        if ret then
            spawnPos = pos
            break
        end

        Wait(0)
    end

    if spawnPos == nil then
        ESX.ShowHelpNotification("You cannot sell in this area. Move to a different location.")
        BusyspinnerOff()
        ClearPedTasks(playerPed)
        LocalPlayer.state.blockClearTasks = false

        SetTimeout(
            5000,
            function()
                nr_drug_curSearching = false
            end
        )
        return
    end

    local canSpawn = nil
    local csReason = nil
    ESX.TriggerServerCallback(
        "stem_drugs:sell:canSpawnPed",
        function(allowed, reason)
            csReason = reason
            canSpawn = allowed
        end,
        currentZone,
        GetZoneFromNameId(currentZone)
    )

    while canSpawn == nil do
        Wait(0)
    end

    if not canSpawn then
        ESX.ShowHelpNotification(csReason)
        BusyspinnerOff()
        ClearPedTasks(playerPed)
        LocalPlayer.state.blockClearTasks = false

        SetTimeout(
            5000,
            function()
                nr_drug_curSearching = false
            end
        )
        return
    end

    TriggerServerEvent("stem_drugs:sell:instance", spawnPos, currentZone)

    BusyspinnerOff()

    ClearPedTasks(playerPed)
    LocalPlayer.state.blockClearTasks = false

    while not nr_currentBuyerPed do
        Wait(0)
    end

    local saleItemName = playerSellables[math.random(1, #playerSellables)]

    nr_drug_curSelling = true
    nr_drug_curSearching = false

    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(nr_currentBuyerPed)

    -- ESX.ShowHelpNotification("Locate the ~r~buyer~s~ and press ~INPUT_CONTEXT~ to sell drugs while in proximity.")
    PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, true)
    ESX.ShowAdvancedNotification("Drug Sales", "Buyer Found", "Wait for the ~r~buyer~s~ to arrive.", mugshotStr, 2)

    local taskCompleted = false
    local takenAction = false
    local endTimer = GetGameTimer() + 180000
    while GetGameTimer() < endTimer do
        local c1 = GetEntityCoords(playerPed)
        local c2 = GetEntityCoords(nr_currentBuyerPed)

        if not taskCompleted then
            if #(c1 - c2) < 15.0 then
                TriggerServerEvent("stem_drugs:sell:pedTaskComplete", PedToNet(nr_currentBuyerPed))
                taskCompleted = true
            end

            ClearPrints()
            BeginTextCommandPrint("STRING")
            AddTextComponentSubstringPlayerName("Wait for the ~r~buyer~s~ to approach.")
            EndTextCommandPrint(250, true)
        else
            ClearPrints()
            BeginTextCommandPrint("STRING")
            AddTextComponentSubstringPlayerName("The ~r~buyer~s~ has arrived.")
            EndTextCommandPrint(250, true)
        end

        postal = exports["nearest-postal"]:getPostal()
        if postal ~= nil and Config.Sales.BlacklistedPostals[postal] then
            takenAction = true
            if nr_currentBuyerNet then
                TriggerServerEvent("stem_drugs:sell:cleanupPed", nr_currentBuyerNet)
            end
            ClearPrints()
            BeginTextCommandPrint("STRING")
            AddTextComponentSubstringPlayerName("The ~r~buyer~s~ was spooked from your location.")
            EndTextCommandPrint(5000, true)
            break
        end

        if not DoesEntityExist(nr_currentBuyerPed) or (#(c1 - c2) > 200) then
            takenAction = true
            if nr_currentBuyerNet then
                TriggerServerEvent("stem_drugs:sell:cleanupPed", nr_currentBuyerNet)
            end
            ClearPrints()
            BeginTextCommandPrint("STRING")
            AddTextComponentSubstringPlayerName("The ~r~buyer~s~ or seller has left the area.")
            EndTextCommandPrint(5000, true)
            break
        end

        if IsEntityDead(nr_currentBuyerPed) then
            takenAction = true
            local oldBuyerNet = nr_currentBuyerNet
            SetTimeout(
                60000,
                function()
                    TriggerServerEvent("stem_drugs:sell:cleanupPed", oldBuyerNet)
                end
            )
            ClearPrints()
            BeginTextCommandPrint("STRING")
            AddTextComponentSubstringPlayerName("The ~r~buyer~s~ was killed.")
            EndTextCommandPrint(5000, true)
            break
        end

        if #(c1 - c2) < 2.0 and #(c1 - c2) > 0.5 then
            AddTextEntry(GetCurrentResourceName(), "~INPUT_CONTEXT~ to sell drugs.")
            BeginTextCommandDisplayHelp(GetCurrentResourceName())
            EndTextCommandDisplayHelp(2, false, false, -1)

            SetFloatingHelpTextWorldPosition(1, vector3(c2.x, c2.y, c2.z + 0.8))
            SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)

            if IsControlJustPressed(0, 51) and IsPedOnFoot(playerPed) and not IsPedSprinting(playerPed) and not IsEntityDead(nr_currentBuyerPed) and HasEntityClearLosToEntityInFront(nr_currentBuyerPed, playerPed) then
                TriggerEvent('ox_inventory:disarm', true)
                TriggerServerEvent("stem_drugs:sell:soldPed", PedToNet(nr_currentBuyerPed))

                takenAction = true

                local pool = GetGamePool("CObject")
                for i = 1, #pool do
                    local obj = pool[i]
                    if DoesEntityExist(obj) and GetEntityType(obj) == 3 and GetEntityAttachedTo(obj) == playerPed then
                        DeleteEntity(obj)
                    end
                end
                ClearPedTasksImmediately(playerPed)
                ClearPedTasksImmediately(nr_currentBuyerPed)

                exports['rpemotes']:EmoteCancel(true)
                LocalPlayer.state.blockClearTasks = true

                CreateThread(
                    function()
                        while LocalPlayer.state.blockClearTasks do
                            DisableAllControlActions(0)
                            EnableControlAction(0, 1, true)
                            EnableControlAction(0, 2, true)
                            EnableControlAction(0, 249, true)
                            Wait(0)
                        end
                    end
                )

                local oldViewMode = GetFollowPedCamViewMode()
                SetFollowPedCamViewMode(4)

                local endCoord = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.0)

                TaskGoStraightToCoord(nr_currentBuyerPed, endCoord, 1.0, 2000, 0, 0.05)

                local endTimer = GetGameTimer() + 5000
                while GetScriptTaskStatus(nr_currentBuyerPed, `SCRIPT_TASK_GO_STRAIGHT_TO_COORD`) ~= 7 and GetGameTimer() < endTimer do
                    if not NetworkHasControlOfEntity(nr_currentBuyerPed) then
                        NetworkRequestControlOfEntity(nr_currentBuyerPed)
                    elseif GetScriptTaskStatus(nr_currentBuyerPed, `SCRIPT_TASK_GO_STRAIGHT_TO_COORD`) ~= 7 then
                        TaskGoStraightToCoord(nr_currentBuyerPed, endCoord, 1.0, 2000, 0, 0.05)
                    end
                    Wait(0)
                end

                SetBlockingOfNonTemporaryEvents(nr_currentBuyerPed, true)
                SetPedFleeAttributes(nr_currentBuyerPed, 0, 0)

                TaskTurnPedToFaceEntity(nr_currentBuyerPed, playerPed, 1000)

                endTimer = GetGameTimer() + 1000
                while GetScriptTaskStatus(nr_currentBuyerPed, `SCRIPT_TASK_TURN_PED_TO_FACE_ENTITY`) ~= 7 and GetGameTimer() < endTimer do
                    if not NetworkHasControlOfEntity(nr_currentBuyerPed) then
                        NetworkRequestControlOfEntity(nr_currentBuyerPed)
                    elseif GetScriptTaskStatus(nr_currentBuyerPed, `SCRIPT_TASK_TURN_PED_TO_FACE_ENTITY`) ~= 7 then
                        TaskTurnPedToFaceEntity(nr_currentBuyerPed, playerPed, 1000)
                    end
                    Wait(0)
                end

                TaskTurnPedToFaceEntity(playerPed, nr_currentBuyerPed, 1000)
                while GetScriptTaskStatus(playerPed, `SCRIPT_TASK_TURN_PED_TO_FACE_ENTITY`) ~= 7 do
                    Wait(0)
                end

                SetPedKeepTask(playerPed, true)
                SetPedKeepTask(nr_currentBuyerPed, true)

                PlayPedAmbientSpeechNative(nr_currentBuyerPed, "GENERIC_HI", "SPEECH_PARAMS_STANDARD")

                Wait(2500)

                SetPedCanPlayAmbientAnims(playerPed, false)
                SetPedCanPlayAmbientBaseAnims(playerPed, false)
                SetPedCanPlayAmbientIdles(playerPed, false)
                SetPedCanPlayGestureAnims(playerPed, false)
                SetPedCanPlayInjuredAnims(playerPed, false)
                SetPedCanPlayVisemeAnims(playerPed, false)

                FreezeEntityPosition(playerPed, true)

                LocalPlayer.state:set(
                    "propData",
                    {
                        model = GetHashKey("hei_prop_hei_drug_pack_02"),
                        boneIndex = 11347,
                        offset = vector3(0.03, 0.03, 0.01),
                        rotation = vector3(270, 0, 0),
                        rotationOrder = 2
                    },
                    true
                )

                TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, 1.0, -1, 16, 0, false, false, false)

                SetTimeout(
                    1500,
                    function()
                        LocalPlayer.state:set("propData", nil, true)
                    end
                )

                if DoesEntityExist(nr_currentBuyerPed) and not IsEntityDead(nr_currentBuyerPed) then
                    TaskPlayAnim(nr_currentBuyerPed, "mp_common", "givetake1_b", 8.0, 1.0, -1, 16, 0, false, false, false)
                end

                ClearPrints()
                BeginTextCommandPrint("STRING")
                AddTextComponentSubstringPlayerName("~g~Drug sale~s~ in progress.")
                EndTextCommandPrint(2500, true)

                Wait(3000)

                SetPedCanPlayAmbientAnims(playerPed, true)
                SetPedCanPlayAmbientBaseAnims(playerPed, true)
                SetPedCanPlayAmbientIdles(playerPed, true)
                SetPedCanPlayGestureAnims(playerPed, true)
                SetPedCanPlayInjuredAnims(playerPed, true)
                SetPedCanPlayVisemeAnims(playerPed, true)

                if not IsPedDeadOrDying(playerPed, true) then
                    LocalPlayer.state.lastSale = GetGameTimer()
                    TriggerServerEvent("stem_drugs:sell:completeSale", currentZone, saleItemName, GetClockHours())
                end

                FreezeEntityPosition(playerPed, false)
                ClearPedTasks(playerPed)
                LocalPlayer.state.blockClearTasks = nil

                if oldViewMode ~= 4 then
                    SetFollowPedCamViewMode(oldViewMode)
                end

                if math.random(100) <= 10 then
                    SetPedCombatAttributes(nr_currentBuyerPed, 0, false)
                    TaskCombatPed(nr_currentBuyerPed, playerPed, 0, 16)
                else
                    TaskWanderStandard(nr_currentBuyerPed, 10.0, 10)
                end

                break
            end
        end

        Wait(0)
    end

    if not takenAction then -- Time expired without the ped dying, going out of range, or sold to
        if nr_currentBuyerNet then
            TriggerServerEvent("stem_drugs:sell:cleanupPed", nr_currentBuyerNet)
        end
        ClearPrints()
        BeginTextCommandPrint("STRING")
        AddTextComponentSubstringPlayerName("The ~r~buyer~s~ was spooked.")
        EndTextCommandPrint(5000, true)
    end

    UnregisterPedheadshot(mugshot)

    nr_currentBuyerPed = nil
    nr_currentBuyerNet = nil

    nr_drug_nextSaleTime = GetGameTimer() + math.random(30000, 45000)
    LocalPlayer.state.nextSaleTime = nr_drug_nextSaleTime

    SetTimeout(
        5000,
        function()
            nr_drug_curSearching = false
            nr_drug_curSelling = false
        end
    )
end

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(1000)
        end

        local model = GetHashKey("hei_prop_hei_drug_pack_02")
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        model = GetHashKey("prop_cash_pile_02")
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
)

RegisterCommand("tryselldrugs", AttemptDrugSell, false)
RegisterKeyMapping("tryselldrugs", "Attempt drug sale (in zone)", "keyboard", "g")
