RegisterNetEvent(
    "stem_nui:alertDialog",
    function(header, content, centered, displayCancel)
        lib.alertDialog(
            {
                header = header,
                content = content,
                centered = centered,
                cancel = displayCancel
            }
        )
    end
)

RegisterNetEvent(
    "stem_nui:defaultNotify",
    function(id, title, description, duration, position, status)
        lib.defaultNotify(
            {
                id = id,
                title = title,
                description = description,
                duration = duration and duration or 5000,
                position = position and position or "top",
                status = status and status or "info"
            }
        )
    end
)

RegisterNetEvent(
    "stem_nui:successNotify",
    function(id, title, description, duration)
        lib.defaultNotify(
            {
                id = id,
                title = title,
                description = description,
                duration = duration and duration or 5000,
                status = "success"
            }
        )
    end
)

RegisterNetEvent(
    "stem_nui:errorAlert",
    function(id, title, description, duration)
        lib.notify(
            {
                id = id,
                title = title,
                description = description,
                duration = duration and duration or 5000,
                position = "top",
                style = {
                    backgroundColor = "#141517",
                    color = "#909296"
                },
                icon = "ban",
                iconColor = "#C53030"
            }
        )
    end
)

AddEventHandler(
    "stem_nui:showRecallNotice",
    function(vehicles)
        local vehicleRecalls = ""
        for i = 1, #vehicles do
            local veh = vehicles[i]
            vehicleRecalls =
                vehicleRecalls ..
                ("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>"):format(
                    veh.name,
                    veh.plate,
                    veh.date and veh.date or "-",
                    veh.status and veh.status or "Discontinued"
                )
        end
        if vehicleRecalls ~= "" then
            SetNuiFocus(true, true)
            SendNUIMessage(
                {
                    display = "vehicle_recall",
                    value = true,
                    updateRecallTable = true,
                    vehicles = vehicleRecalls
                }
            )
        end
    end
)

AddEventHandler(
    "stem_nui:showComservNotice",
    function(reason)
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                display = "comserv_notice",
                value = true,
                setComservReason = true,
                reason = reason
            }
        )
    end
)

AddEventHandler(
    "stem_nui:openWeazelPublish",
    function()
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                display = "wnews_publish",
                value = true
            }
        )
    end
)

RegisterCommand(
    "newmdt",
    function()
        TriggerServerEvent("noire-mdt:open")
    end
)

RegisterCommand(
    "resetmdt",
    function()
        TriggerEvent("stem_nui:resetMdt")
    end
)

RegisterKeyMapping("newmdt", "Open MDT", "keyboard", "l")

RegisterNetEvent(
    "stem_nui:openMdt",
    function(customUrl)
        if LocalPlayer.state.inMDT then
            return
        end

        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)

        Wait(0)

        SendNUIMessage(
            {
                openMDT = true,
                customUrl = customUrl,
                value = true
            }
        )

        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, true) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
            RequestAnimDict("mp_safehousevagos@boss")
            while not HasAnimDictLoaded("mp_safehousevagos@boss") do
                Wait(0)
            end

            if not IsEntityPlayingAnim(playerPed, "mp_safehousevagos@boss", "vagos_boss_keyboard_base", 3) then
                TaskPlayAnim(playerPed, "mp_safehousevagos@boss", "vagos_boss_keyboard_base", 8.0, 8.0, -1, 49, 0.0,
                    false, false, false)
            end
        end

        LocalPlayer.state:set("inMDT", true, true)

        local dict = "amb@world_human_seat_wall_tablet@female@base"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end

        while true do
            DisableAllControlActions(0)
            EnableControlAction(0, 249, true)

            SetPauseMenuActive(false)

            if not LocalPlayer.state.usingRadio then
                if IsPedInAnyVehicle(playerPed, true) and GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed, false), -1) == playerPed then
                    if not IsEntityPlayingAnim(playerPed, "mp_safehousevagos@boss", "vagos_boss_keyboard_base", 3) then
                        TaskPlayAnim(playerPed, "mp_safehousevagos@boss", "vagos_boss_keyboard_base", 8.0, 8.0, -1, 49,
                            0.0, false, false, false)
                    end
                else
                    if not IsEntityPlayingAnim(playerPed, dict, "base", 3) then
                        TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
                    end
                end
            end

            if IsEntityDead(PlayerPedId()) or IsControlJustPressed(0, 200) or IsDisabledControlJustPressed(0, 200) then
                ClearPedTasks(playerPed)
                LocalPlayer.state:set("inMDT", nil, true)

                SendNUIMessage(
                    {
                        closeMDT = true,
                        value = true
                    }
                )

                SetNuiFocusKeepInput(false)

                break
            end

            Wait(0)
        end

        Wait(0)
        SetNuiFocus(false, false)

        SetPauseMenuActive(false)
        if IsPauseMenuActive() then
            SetFrontendActive(false)
        end
    end
)

AddEventHandler(
    "stem_nui:resetMdt",
    function()
        SendNUIMessage(
            {
                resetMDT = true,
                value = GetGameTimer()
            }
        )
    end
)

RegisterNUICallback(
    "closeNUI",
    function(data, cb)
        SetNuiFocus(false, false)
        cb(true)
    end
)

AddEventHandler("stem_nui:openTrading", function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = GetClosestObjectOfType(coords, 25.0, `ba_prop_battle_club_computer_02`, false, false, false)
    if DoesEntityExist(obj) then
        local canUse = nil
        ESX.TriggerServerCallback('noire-nui:tradingTerminalAvailable', function(allowed)
            canUse = allowed
        end, GetEntityCoords(obj))

        while canUse == nil do Wait(0) end
        if not canUse then return end

        local laptopOffset = GetEntityCoords(obj) - GetEntityForwardVector(obj) * vector3(1.0, 1.0, 0.6)
        -- laptopOffset.z += 0.5

        local scenePos = GetOffsetFromEntityInWorldCoords(obj, 0, -0.1, 0)

        local scene = NetworkCreateSynchronisedScene(scenePos, GetEntityRotation(obj, 2), 2, false, false,
            1.0, 0.0, 1.0)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'anim@amb@warehouse@laptop@', 'enter', 4.0,
            -2.0, 5, 0, 1000.0, 0)
        NetworkStartSynchronisedScene(scene)

        while GetSynchronizedScenePhase(NetworkGetLocalSceneFromNetworkId(scene)) < 0.93 do
            Wait(0)
        end

        SetTimeout(1000, function()
            PlaySoundFrontend(-1, "Login", "GTAO_Exec_SecuroServ_Warehouse_PC_Sounds", true)
        end)

        local scene2 = NetworkCreateSynchronisedScene(scenePos, GetEntityRotation(obj, 2), 2, false, true,
            1.0, 0.0, 1.0)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene2, 'anim@amb@warehouse@laptop@', 'idle_a', 4.0,
            -2.0, 5, 0, 1000.0, 0)
        NetworkStartSynchronisedScene(scene2)
    end

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    Wait(0)

    SendNUIMessage(
        {
            openTrading = true,
            value = true
        }
    )

    LocalPlayer.state.invBusy = true

    while true do
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)

        SetPauseMenuActive(false)

        if IsEntityDead(PlayerPedId()) or IsControlJustPressed(0, 200) or IsDisabledControlJustPressed(0, 200) then
            -- ClearPedTasks(playerPed)
            SendNUIMessage(
                {
                    closeTrading = true,
                    value = true
                }
            )

            SetNuiFocusKeepInput(false)

            if DoesEntityExist(obj) then
                TriggerServerEvent('noire-nui:exitTradingTerminal')

                local scenePos = GetOffsetFromEntityInWorldCoords(obj, 0, -0.1, 0)
                local scene = NetworkCreateSynchronisedScene(scenePos, GetEntityRotation(obj, 2), 2, false, false,
                    1.0, 0.0, 1.0)
                NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'anim@amb@warehouse@laptop@', 'exit', 8.0,
                    -4.0, 5, 0, 1000.0, 0)
                NetworkStartSynchronisedScene(scene)
            end

            break
        end

        Wait(0)
    end

    Wait(0)
    SetNuiFocus(false, false)
    LocalPlayer.state.invBusy = false

    SetPauseMenuActive(false)
    if IsPauseMenuActive() then
        SetFrontendActive(false)
    end
end)

AddEventHandler("stem_nui:openWiki", function()
    if LocalPlayer.state.blockClearTasks or LocalPlayer.state.invBusy then
        return
    end

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    SendNUIMessage(
        {
            openWiki = true,
            value = true
        }
    )

    local plyPed = PlayerPedId()

    LocalPlayer.state.invBusy = true

    RequestAnimDict('cellphone@')
    TaskPlayAnim(plyPed, 'cellphone@', 'cellphone_text_read_base', 2.0, -2.0, -1, 1, 0.0, false, false, false)

    LocalPlayer.state:set(
        'propData',
        {
            model = `prop_tourist_map_01`,
            boneIndex = 6286,
            offset = vector3(0.15, 0.03, -0.055),
            rotation = vector3(90.0, 30.0, 90.0),
            rotationOrder = 2
        },
        true
    )

    while true do
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)

        SetPauseMenuActive(false)

        if not IsEntityPlayingAnim(plyPed, 'cellphone@', 'cellphone_text_read_base', 3) then
            TaskPlayAnim(plyPed, 'cellphone@', 'cellphone_text_read_base', 2.0, -2.0, -1, 1, 0.0, false, false, false)
        end

        if IsEntityDead(plyPed) or IsControlJustPressed(0, 200) or IsDisabledControlJustPressed(0, 200) then
            -- ClearPedTasks(playerPed)
            SendNUIMessage(
                {
                    closeWiki = true,
                    value = true
                }
            )

            SetNuiFocusKeepInput(false)
            break
        end

        Wait(0)
    end

    ClearPedTasks(plyPed)
    LocalPlayer.state:set('propData', nil, true)

    Wait(0)
    SetNuiFocus(false, false)
    LocalPlayer.state.invBusy = false

    SetPauseMenuActive(false)
    if IsPauseMenuActive() then
        SetFrontendActive(false)
    end
end)

AddEventHandler("stem_nui:openCasinoDashboard", function()
    if LocalPlayer.state.blockClearTasks or LocalPlayer.state.invBusy then
        return
    end

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    SendNUIMessage({ casinoStats = true })

    local plyPed = PlayerPedId()

    LocalPlayer.state.invBusy = true

    while true do
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)

        SetPauseMenuActive(false)

        if IsEntityDead(plyPed) or IsControlJustPressed(0, 200) or IsDisabledControlJustPressed(0, 200) then
            -- ClearPedTasks(playerPed)
            SendNUIMessage({ closeStats = true, value = true })
            SetNuiFocusKeepInput(false)
            break
        end

        Wait(0)
    end

    ClearPedTasks(plyPed)

    Wait(0)
    SetNuiFocus(false, false)
    LocalPlayer.state.invBusy = false

    SetPauseMenuActive(false)
    if IsPauseMenuActive() then
        SetFrontendActive(false)
    end
end)

AddEventHandler("stem_nui:openDOJDashboard", function()
    if LocalPlayer.state.blockClearTasks or LocalPlayer.state.invBusy then
        return
    end

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    SendNUIMessage({ dojStats = true })

    local plyPed = PlayerPedId()

    LocalPlayer.state.invBusy = true

    while true do
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)

        SetPauseMenuActive(false)

        if IsEntityDead(plyPed) or IsControlJustPressed(0, 200) or IsDisabledControlJustPressed(0, 200) then
            -- ClearPedTasks(playerPed)
            SendNUIMessage({ closeStats = true, value = true })
            SetNuiFocusKeepInput(false)
            break
        end

        Wait(0)
    end

    ClearPedTasks(plyPed)

    Wait(0)
    SetNuiFocus(false, false)
    LocalPlayer.state.invBusy = false

    SetPauseMenuActive(false)
    if IsPauseMenuActive() then
        SetFrontendActive(false)
    end
end)

RegisterNUICallback(
    "submitNews",
    function(data, cb)
        if not data.data then
            exports["mythic_notify"]:SendAlert("error", "Error publishing newspaper.")
            return
        end

        TriggerServerEvent("weazelNews:submitNewspaper", data.data)
        exports["mythic_notify"]:SendAlert("success", "Successfully published newspaper.")

        SetNuiFocus(false, false)
        cb(true)
    end
)

RegisterNetEvent(
    "weazelNews:publishInput",
    function()
        local input =
            lib.inputDialog(
                "Publish News",
                {
                    { type = "input",    label = "Page 1",        placeholder = "https://change.me/test.png" },
                    { type = "input",    label = "Page 2",        placeholder = "https://change.me/test.png" },
                    { type = "input",    label = "Page 3",        placeholder = "https://change.me/test.png" },
                    { type = "input",    label = "Page 4",        placeholder = "https://change.me/test.png" },
                    { type = "input",    label = "Page 5",        placeholder = "https://change.me/test.png" },
                    { type = "input",    label = "Page 6",        placeholder = "https://change.me/test.png" },
                    { type = "checkbox", label = "Webhook Alert", checked = true }
                }
            )

        TriggerServerEvent("weazelNews:submitNewspaper", input)
        exports["mythic_notify"]:SendAlert("success", "Successfully published newspaper.")
    end
)

RegisterNetEvent(
    "locksmith:availableKeys",
    function(data)
        local selectElements = {}
        for i = 1, #data do
            local coords = json.decode(data[i].entry)
            local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local display = exports["nearest-postal"]:getPostalNearCoords(coords) ..
                " " .. GetStreetNameFromHashKey(streetHash)
            selectElements[#selectElements + 1] = {
                value = data[i].id,
                label = "House #" .. data[i].id .. " | " .. display
            }
        end

        local input =
            lib.inputDialog(
                "Property Key Management",
                {
                    { type = "select", label = "Select Property",            options = selectElements },
                    { type = "number", label = "Number of Keys ($10K each)", default = 1,             min = 1, max = 5 }
                }
            )

        TriggerServerEvent("noire-locksmith:buyKeys", input)
    end
)

RegisterNetEvent(
    "stem_nui:compMenu",
    function()
        local input =
            lib.inputDialog(
                "Comp Menu",
                {
                    { type = "input",  label = "Steam Identifier" },
                    {
                        type = "select",
                        options = {
                            { value = "debit",  label = "Bank Debit" },
                            { value = "credit", label = "Bank Credit" }
                        }
                    },
                    { type = "number", label = "Amount" }
                }
            )

        if not input then
            return
        end

        local identifier, action, amount = input[1], input[2], input[3]
        if not identifier or not action or not amount then
            TriggerEvent("stem_nui:defaultNotify", "Error_Comp_Input", "Compensation Menu",
                "All fields need to have a value.")
            return
        end

        TriggerServerEvent("stem_nui:submitComp", identifier, action, amount)
    end
)

function OpenAtomRegisterMenu(closestPlayers)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local input =
        lib.inputDialog(
            "Up-n-Atom",
            {
                { type = "select", label = "Select Player", options = players },
                { type = "number", label = "Enter Amount",  min = 1,          max = 25000 }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("upnatom:chargeCustomer", input[1], input[2])
end

function OpenBurgershotRegisterMenu(closestPlayers)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local input =
        lib.inputDialog(
            "BurgerShot",
            {
                { type = "select", label = "Select Player", options = players },
                { type = "number", label = "Enter Amount",  min = 1,          max = 25000 }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("burgershot:chargeCustomer", input[1], input[2])
end

function OpenTaxiChargeMenu(fare, vehicle, closestPlayers)
    local players = {}
    for i = 1, #closestPlayers do
        local ped = GetPlayerPed(closestPlayers[i])
        if not IsEntityDead(ped) and closestPlayers[i] ~= PlayerId() then
            if GetPedInVehicleSeat(vehicle, 0) == ped then
                players[#players + 1] = {
                    label = string.format("Front Psgr. (ID: %d)", GetPlayerServerId(closestPlayers[i])),
                    value = GetPlayerServerId(closestPlayers[i])
                }
            elseif GetPedInVehicleSeat(vehicle, 1) == ped then
                players[#players + 1] = {
                    label = string.format("Rear Left Psgr. (ID: %d)", GetPlayerServerId(closestPlayers[i])),
                    value = GetPlayerServerId(closestPlayers[i])
                }
            elseif GetPedInVehicleSeat(vehicle, 2) == ped then
                players[#players + 1] = {
                    label = string.format("Rear Right Psgr. (ID: %d)", GetPlayerServerId(closestPlayers[i])),
                    value = GetPlayerServerId(closestPlayers[i])
                }
            else
                players[#players + 1] = {
                    label = string.format("Pedestrian (ID: %d)", GetPlayerServerId(closestPlayers[i])),
                    value = GetPlayerServerId(closestPlayers[i])
                }
            end
        end
    end

    if #players == 0 then
        return
    end

    local input =
        lib.inputDialog(
            "Downtown Cab Co.",
            {
                { type = "select", label = "Select Player", options = players },
                {
                    type = "number",
                    label = "$ Fare Amount",
                    description = "Amount charged to the selected passenger.",
                    placeholder = fare,
                    default = fare,
                    disabled = true
                }
            }
        )

    while not input do
        input =
            lib.inputDialog(
                "Downtown Cab Co.",
                {
                    { type = "select", label = "Select Player", options = players },
                    {
                        type = "number",
                        label = "$ Fare Amount",
                        description = "Amount charged to the selected passenger.",
                        placeholder = fare,
                        default = fare,
                        disabled = true
                    }
                }
            )
        Wait(0)
    end

    if not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("esx_taxijob:chargePassenger", input[1], input[2])
end

function OpenTaxiRateTipMenu()
    local input =
        lib.inputDialog(
            "Downtown Cab Co.",
            {
                {
                    type = "slider",
                    label = "Rate your Driver",
                    description = "Ratings are used to help improve future rides.",
                    min = 1,
                    max = 5,
                    step = 1,
                    default = 5
                },
                {
                    type = "select",
                    label = "Tip your Driver",
                    options = {
                        { label = "$100",    value = 100 },
                        { label = "$250",    value = 250 },
                        { label = "$500",    value = 500 },
                        { label = "$1,000",  value = 1000 },
                        { label = "$2,500",  value = 2500 },
                        { label = "$5,000",  value = 5000 },
                        { label = "$10,000", value = 10000 }
                    }
                },
                {
                    type = "input",
                    label = "Leave a message",
                    description = "Optional. Leave a short message about your ride experience."
                }
            }
        )

    TaskLeaveAnyVehicle(PlayerPedId(), 0, 0)

    if not input then
        return
    end

    TriggerServerEvent("esx_taxijob:rateAndTip", input[1], input[2], input[3])
end

function OpenCinemaChargeMenu(closestPlayers)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local ticketPrice = GetConvarInt("cinema_price", 1000)

    local input =
        lib.inputDialog(
            "Cinema",
            {
                { type = "select", label = "Select Player", options = players },
                {
                    type = "number",
                    label = "Ticket Price",
                    description = "Price to charge for one ticket.",
                    placeholder = ticketPrice,
                    default = ticketPrice,
                    disabled = true
                }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("cinema:chargeCustomer", input[1], input[2])
end

function OpenCinemaAdjustTicketMenu()
    local ticketPrice = GetConvarInt("cinema_price", 1000)

    local input =
        lib.inputDialog(
            "Cinema",
            {
                {
                    type = "slider",
                    label = "Ticket Price",
                    description = "Price to charge for one ticket.",
                    placeholder = ticketPrice,
                    default = ticketPrice,
                    -- disabled = true,
                    min = 1,
                    max = 10000
                }
            }
        )

    if not input then
        return
    end

    TriggerServerEvent("cinema:setAdmissionPrice", input[1])
end

function OpenCinemaSnackRegisterMenu(register)
    local input =
        lib.inputDialog(
            "Cinema",
            {
                {
                    type = "number",
                    label = "Charge Amount",
                    description = "Price to charge customer.",
                    placeholder = 100,
                    default = 100,
                    -- disabled = true,
                    min = 1,
                    max = 5000
                }
            }
        )

    if not input then
        return
    end

    TriggerServerEvent("cinema:snackCharge", register, input[1])
end

function OpenCasinoCashierMenu(closestPlayers)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) and closestPlayers[i] ~= PlayerId() then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local input =
        lib.inputDialog(
            "Diamond Casino & Resort",
            {
                { type = "select", label = "Select Player", options = players },
                {
                    type = "select",
                    label = "Transaction Type",
                    description = "Specify the type of transaction.",
                    options = {
                        { label = "Withdraw from Bank", value = "withdraw" },
                        { label = "Deposit to Bank",    value = "deposit" }
                    }
                },
                { type = "number", label = "Enter Amount",  description = "Transaction amount.", min = 1 }
            }
        )

    if not input then
        return
    end

    if not input[1] then
        TriggerEvent("stem_nui:errorAlert", "CASINO_ERROR_NO_PLAYER_SELECTED", "Error", "Player not selected.")
        return
    end

    if not input[2] then
        TriggerEvent("stem_nui:errorAlert", "CASINO_ERROR_NO_TRANSACTION_TYPE", "Error",
            "A transaction type needs to be selected.")
        return
    end

    if not input[3] then
        TriggerEvent("stem_nui:errorAlert", "CASINO_ERROR_NO_AMOUNT", "Error", "A valid amount needs to be entered.")
        return
    end

    if input[2] == "withdraw" then
        TriggerServerEvent("noire-casino:cashierWithdraw", input[1], input[3])
    elseif input[2] == "deposit" then
        TriggerServerEvent("noire-casino:cashierDeposit", input[1], input[3])
    end
end

function OpenPrisonerIntakeMenu(closestPlayers, cells)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local input =
        lib.inputDialog(
            "Prisoner Intake",
            {
                { type = "select", label = "Select Player", options = players }
            }
        )

    if not input then
        return
    end

    if not input[1] then
        TriggerEvent("stem_nui:errorAlert", "PRISON_ERROR_NO_PLAYER", "Error", "Player not selected.")
        return
    end

    TriggerServerEvent("noire-prison:checkIn", input[1])
end

function OpenMBAInteriorMenu()
    local interiorOptions = {
        { value = "basketball",   label = "Basketball" },
        { value = "boxing",       label = "Boxing" },
        { value = "concert",      label = "Concert" },
        { value = "curling",      label = "Curling" },
        { value = "derby",        label = "Derby" },
        { value = "fameorshame",  label = "Fame or Shame" },
        { value = "fashion",      label = "Fashion Show" },
        { value = "football",     label = "Football (Soccer)" },
        { value = "icehockey",    label = "Ice Hockey" },
        { value = "gokarta",      label = "Go Kart A" },
        { value = "gokartb",      label = "Go Kart B" },
        { value = "trackmaniaa",  label = "Track Mania A" },
        { value = "trackmaniab",  label = "Track Mania B" },
        { value = "trackmaniac",  label = "Track Mania C" },
        { value = "trackmaniad",  label = "Track Mania D" },
        { value = "mma",          label = "MMA" },
        { value = "none",         label = "None (Empty)" },
        { value = "paintball",    label = "Paintball" },
        { value = "rocketleague", label = "Rocket League" },
        { value = "Wrestling",    label = "Wrestling" }
    }

    local input =
        lib.inputDialog(
            "Select Interior",
            {
                {
                    type = "select",
                    label = "Interior",
                    options = interiorOptions
                }
            }
        )

    TriggerServerEvent("mba:changeInterior", input[1])
end

function OpenApplyOrganizationMenu()
    local input =
        lib.inputDialog(
            "Register a Business or Organization",
            {
                {
                    type = "input",
                    label = "Org. Name",
                    description = "Full name of the business or organization.",
                    required = true
                },
                {
                    type = "input",
                    label = "Abbreviated Name",
                    description =
                    "Abbreviated name of the business or organization.",
                    required = true
                },
                {
                    type = "number",
                    label = "Headcount",
                    description = "Rough approximation of number of members.",
                    required = true
                },
                {
                    type = "select",
                    options = {
                        { value = "business",     label = "Business" },
                        { value = "gang",         label = "Gang" },
                        { value = "organization", label = "Organization" }
                    },
                    description = "Type of entity you are trying to register.",
                    required = true
                },
                {
                    type = "color",
                    description =
                    "Color of the business or organization you are trying to apply for. Optional, mainly used for criminal organizations."
                },
                {
                    type = "textarea",
                    label = "Brief description of the purpose of the organization.",
                    description =
                    "In a few sentences, describe the goal and purpose behind registering your organization.",
                    required = true,
                    min = 1,
                    max = 3,
                    autosize = true
                },
                {
                    type = "checkbox",
                    label = "A deposit of $" ..
                        ESX.Math.GroupDigits(GetConvarInt("org_applicationFee", 500000)) ..
                        " will be required and held for consideration. If your application is denied, your deposit will be credited back in full. Asking about the status of your application will result in an automatic denial. Check this box to acknowledge.",
                    required = true
                }
            }
        )

    if not input then
        return
    end

    TriggerServerEvent("noire-orgs:submitApp", input[1], input[2], input[3], input[4], input[5], input[6], input[7])
end

function OpenCreateJobMenu(requestingIdentifier, label, orgType, username)
    local input =
        lib.inputDialog(
            "Create " .. orgType .. " - " .. username,
            {
                { type = "input",    label = "Job Name",        description = "Primary key.", required = true },
                {
                    type = "input",
                    label = "Job Label",
                    description = "Display text.",
                    default = label,
                    required = true
                },
                { type = "checkbox", label = "Whitelisted Job?" },
                { type = "checkbox", label = "Gang Job?" }
            }
        )

    if not input then
        return
    end

    TriggerServerEvent("noire-orgs:acceptApp", requestingIdentifier, input[1], input[2], input[3], input[4])
end

function OpenDenyJobMenu(requestingIdentifier, label, orgType, username)
    local input =
        lib.inputDialog(
            "Deny " .. label .. " - " .. username,
            {
                {
                    type = "textarea",
                    label = "Provide a reason for denying this application.",
                    required = true,
                    min = 1,
                    max = 3,
                    autosize = true
                }
            }
        )

    if not input then
        return
    end

    TriggerServerEvent("noire-orgs:denyApp", requestingIdentifier, input[1])
end

function OpenPlayerReportMenu()
    local input =
        lib.inputDialog(
            "Report Player",
            {
                {
                    type = "select",
                    options = {
                        { value = "RDM",              label = "Random Killing (RDM)" },
                        { value = "Unrealistic Area", label = "Crime in Unrealistic Area" },
                        { value = "Scamming",         label = "Scamming" },
                        { value = "Cheating",         label = "Cheating" }
                    },
                    description = "What are you trying to report the player for?",
                    label = "Violation",
                    required = true
                },
                {
                    type = "multi-select",
                    options = {
                        { value = "Aimbot",          label = "Aimbot" },
                        { value = "ESP",             label = "ESP" },
                        { value = "Recoil Modifier", label = "Recoil Modifier" },
                        { value = "Speed Hack",      label = "Speed Hack" },
                        { value = "Other",           label = "Other" }
                    },
                    description =
                    "Select all that apply if the violation type is Cheating. Will be ignored for other report types.",
                    label = "Specific Violation(s)"
                },
                {
                    type = "input",
                    label = "URL to Video Evidence",
                    description =
                    "Reports without video evidence will be rejected. Links must contain the https:// prefix."
                },
                {
                    type = "textarea",
                    description = "Any further information to add. Keep it brief.",
                    label = "Additional Information",
                    min = 1,
                    max = 3,
                    autosize = true,
                    required = true
                },
                {
                    type = "checkbox",
                    label =
                    "Reports will submitted to the staff team for review. Any action taken based on this report may or may not be communicated to you. Inquiring about the status of a report is strictly prohibited and considered out of character (OOC). You are submitting this report in good faith with a genuine belief that the information provided is true and accurate to the best of your knowledge. Submitting false reports or making malicious accusations may result in disciplinary action.\n\nPlease check the box below to confirm that you have read and agreed to the terms stated above."
                }
            }
        )

    if not input then
        return false
    end

    if not input[1] or not input[4] or not input[5] then
        TriggerEvent("stem_nui:errorAlert", "PLAYER_REPORT_ERROR", "Error", "One or more fields were not provided.")
        return false
    end

    TriggerServerEvent("noire:submitReport", input)
    return true
end

function OpenChangeCoverFeeMenu()
    local input =
        lib.inputDialog(
            "Set Cover Charge",
            {
                {
                    type = "input",
                    label = "Set Amount",
                    description = "Change the cover fee for all employees.",
                    required = true
                }
            }
        )

    if not input or not tonumber(input[1]) then
        return
    end

    TriggerServerEvent("noire_assets:setEntryFee", tonumber(input[1]))
end

function OpenJailPlayerMenu(player)
    local serverId = GetPlayerServerId(player)
    local input =
        lib.inputDialog(
            "Jail Player " .. serverId,
            {
                { type = "input", label = "Sentence", description = "Jail sentence in months.", required = true }
            }
        )

    if not input or not tonumber(input[1]) then
        return
    end

    TriggerServerEvent("noire-prison:sv_jailPlayer", serverId, tonumber(input[1]))
end

function OpenWeazelPriceMenu()
    local input =
        lib.inputDialog(
            "Set Newspaper Price",
            {
                { type = "input", label = "Price", description = "Newspaper price.", required = true }
            }
        )

    if not input or not tonumber(input[1]) then
        return
    end

    TriggerServerEvent("weazelNews:setNewspaperPrice", tonumber(input[1]))
end

function OpenSaveOutfitMenu()
    local input =
        lib.inputDialog(
            "Save Current Outfit",
            {
                { type = "input", label = "Outfit name", required = true }
            }
        )

    if not input or not input[1] then
        return
    end

    return input[1]
end

function OpenPoliceStoreItemMenu(itemName)
    local input =
        lib.inputDialog(
            "Store Evidence",
            {
                { type = "input", label = "Quantity", description = "Item amount.", required = true }
            }
        )

    if not input or not input[1] then
        return
    end

    local count = input[1]
    if count < 1 then
        return
    end

    TriggerServerEvent("esx_policejob:putStockItems", itemName, count)
end

function OpenDOTInvoiceMenu(closestPlayer)
end

function OpenSocietyWithdrawMenu(society)
    local input =
        lib.inputDialog(
            "Withdraw Funds",
            {
                { type = "input", label = "Amount", description = "Withdraw amount.", required = true }
            }
        )

    if not input or not input[1] then
        return
    end

    local amount = tonumber(input[1])
    if amount < 1 then
        return
    end

    TriggerServerEvent("esx_society:withdrawMoney", society, amount)
end

function OpenSocietyDepositMenu(society)
    local input =
        lib.inputDialog(
            "Deposit Funds",
            {
                { type = "input", label = "Amount", description = "Deposit amount.", required = true }
            }
        )

    if not input or not input[1] then
        return
    end

    local amount = tonumber(input[1])
    if amount < 1 then
        return
    end

    TriggerServerEvent("esx_society:depositMoney", society, amount)
end

function OpenSetVanityPlateMenu()
    local input =
        lib.inputDialog(
            "Set Vanity Plate",
            {
                {
                    type = "input",
                    label = "New Plate",
                    description = "All plates must be between 3 and 8 characters.",
                    required = true
                }
            }
        )

    if not input or not input[1] then
        return
    end

    return input[1]
end

function OpenGrafittiMenu()
    local input =
        lib.inputDialog(
            "Spray Graffiti",
            {
                {
                    type = "input",
                    label = "Enter text",
                    description = "Message to be sprayed. Max 9 characters.",
                    required = true
                }
            }
        )

    if not input or not input[1] then
        return
    end

    return input[1]
end

function OpenDenyHouseRequestMenu()
    local input =
        lib.inputDialog(
            "Deny Request",
            {
                {
                    type = "textarea",
                    label = "Reason",
                    description = "Why this request is being denied. Be specific, 10 character min.",
                    required = true,
                    min = 1,
                    max = 3,
                    autosize = true
                }
            }
        )

    if not input or not input[1] then
        return
    end

    return input[1]
end

function OpenManualHouseRelocMenu()
    local input =
        lib.inputDialog(
            "Relocate House",
            {
                { type = "input", label = "House ID",   required = true },
                { type = "input", label = "Shell Type", description = "ApartmentV2, HotelV2, etc.", required = true },
                {
                    type = "checkbox",
                    label = "Open Interior",
                    description = "Is this relocation to an open interior?",
                    checked = false
                }
            }
        )

    if not input or not input[1] then
        return
    end

    return input
end

function OpenCasinoVIPCashierMenu()
    local input =
        lib.inputDialog(
            "Diamond Casino & Resort",
            {
                {
                    type = "select",
                    label = "Transaction Type",
                    description = "Specify the type of transaction.",
                    options = {
                        { label = "Withdraw from Bank", value = "withdraw" },
                        { label = "Deposit to Bank",    value = "deposit" }
                    }
                },
                { type = "number", label = "Enter Amount", description = "Transaction amount.", min = 1 }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    if input[1] == "withdraw" then
        TriggerServerEvent("stem_casino:cashierVIPWithdraw", tonumber(input[2]))
    elseif input[1] == "deposit" then
        TriggerServerEvent("stem_casino:cashierVIPDeposit", tonumber(input[2]))
    end
end

function StartPrisonShankMinigame()
    local difficulty = {}
    local checks = math.random(20, 30)
    for i = 1, checks do
        difficulty[#difficulty + 1] = "easy"
    end
    return lib.skillCheck(difficulty, { "w", "a", "s", "d" })
end

function OpenEditCriminalCodeMenu(id, label, amount, category, jailtime, points)
    local input =
        lib.inputDialog(
            "Edit Criminal Code",
            {
                {
                    type = "input",
                    label = "Charge",
                    default = label,
                    disabled = true,
                    required = true
                },
                {
                    type = "number",
                    label = "Fine Amt.",
                    default = amount,
                    required = true
                },
                {
                    type = "number",
                    label = "Category",
                    description = "0 = Infraction/Traffic, 1 = Misdemeanor, 2 = Felony",
                    default = category,
                    disabled = true,
                    required = true
                },
                {
                    type = "number",
                    label = "Jail Sentence",
                    default = jailtime,
                    required = true
                },
                {
                    type = "number",
                    label = "DMV Points",
                    description = "Amount of points assessed by the DMV upon a guilty/no contest plea or conviction.",
                    default = points,
                    required = true
                }
            }
        )

    if not input then
        return
    end

    TriggerServerEvent("noire_doj:updateCriminalCode", id, input[1], input[2], input[3], input[4], input[5])
end

function OpenMBAChargePlayerMenu(register)
    local coords = GetEntityCoords(PlayerPedId())
    local closestPlayers = ESX.Game.GetPlayersInArea(coords, 5.0)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local ticketPrice = GetConvarInt("mba_ticket_price", 2500)

    local input =
        lib.inputDialog(
            "Maze Bank Arena Ticket",
            {
                { type = "select", label = "Select Player", options = players },
                {
                    type = "number",
                    label = "Ticket Price",
                    description = "Price to charge for one ticket.",
                    placeholder = ticketPrice,
                    default = ticketPrice,
                    disabled = true
                }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("mba:chargeTicket", input[1], input[2], register)
end

function OpenBeanMachineRegisterMenu()
    local coords = GetEntityCoords(PlayerPedId())
    local closestPlayers = ESX.Game.GetPlayersInArea(coords, 5.0)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) and closestPlayers[i] ~= PlayerId() then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local input =
        lib.inputDialog(
            "Bean Machine",
            {
                { type = "select", label = "Select Player", options = players },
                { type = "number", label = "Enter Amount",  min = 1,          max = 10000 }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("stem_common:pos:chargePlayer", input[1], input[2])
end

function OpenSaveEUPMenu()
    local jobLabels = nil
    ESX.TriggerServerCallback(
        "eup:getJobLabels",
        function(data)
            jobLabels = data
        end,
        ESX.PlayerData.job.name
    )

    while jobLabels == nil do
        Wait(0)
    end

    local gradeOptions = {}
    for i = 0, #jobLabels do
        gradeOptions[#gradeOptions + 1] = {
            value = tostring(i),
            label = jobLabels[i]
        }
    end

    local input =
        lib.inputDialog(
            "Save Current EUP Outfit",
            {
                {
                    type = "checkbox",
                    label = "Force Hat?",
                    description =
                    "If checked, outfit will force the current hat on the player."
                },
                {
                    type = "checkbox",
                    label = "Force Glasses?",
                    description =
                    "If checked, outfit will force the current glasses on the player."
                },
                {
                    type = "checkbox",
                    label = "Force Ear Accs?",
                    description =
                    "If checked, outfit will force the current ear accessories on the player."
                },
                {
                    type = "checkbox",
                    label = "Force Watch?",
                    description =
                    "If checked, outfit will force the current watch on the player."
                },
                {
                    type = "checkbox",
                    label = "Force Bracelet?",
                    description =
                    "If checked, outfit will force the current bracelet on the player."
                },
                { type = "input", label = "Job Required", default = ESX.PlayerData.job.name, disabled = true },
                {
                    type = "select",
                    label = "Job Grade Required",
                    description = "Rank required to use outfit. Cannot exceed your current grade.",
                    default = tostring(ESX.PlayerData.job.grade),
                    options = gradeOptions
                },
                {
                    type = "input",
                    label = "Outfit Name",
                    description = "Be descriptive but concise. Ideal format is [[FE]MALE] ADJ. TYPE.",
                    placeholder = "Male Casual Dress"
                }
            }
        )

    if not input then
        return
    end

    local plyPed = PlayerPedId()

    local data = {
        job = input[6],
        grade = tonumber(input[7]),
        outfitName = input[8],
        props = {},
        components = {
            [1] = { GetPedDrawableVariation(plyPed, 1), GetPedTextureVariation(plyPed, 1) },
            [3] = { GetPedDrawableVariation(plyPed, 3), GetPedTextureVariation(plyPed, 3) },
            [4] = { GetPedDrawableVariation(plyPed, 4), GetPedTextureVariation(plyPed, 4) },
            [5] = { GetPedDrawableVariation(plyPed, 5), GetPedTextureVariation(plyPed, 5) },
            [6] = { GetPedDrawableVariation(plyPed, 6), GetPedTextureVariation(plyPed, 6) },
            [7] = { GetPedDrawableVariation(plyPed, 7), GetPedTextureVariation(plyPed, 7) },
            [8] = { GetPedDrawableVariation(plyPed, 8), GetPedTextureVariation(plyPed, 8) },
            [9] = { GetPedDrawableVariation(plyPed, 9), GetPedTextureVariation(plyPed, 9) },
            [10] = { GetPedDrawableVariation(plyPed, 10), GetPedTextureVariation(plyPed, 10) },
            [11] = { GetPedDrawableVariation(plyPed, 11), GetPedTextureVariation(plyPed, 11) }
        }
    }

    if input[1] then
        data.props[0] = { GetPedPropIndex(plyPed, 0), GetPedPropTextureIndex(plyPed, 0) }
    end
    if input[2] then
        data.props[1] = { GetPedPropIndex(plyPed, 1), GetPedPropTextureIndex(plyPed, 1) }
    end
    if input[3] then
        data.props[2] = { GetPedPropIndex(plyPed, 2), GetPedPropTextureIndex(plyPed, 2) }
    end
    if input[4] then
        data.props[6] = { GetPedPropIndex(plyPed, 6), GetPedPropTextureIndex(plyPed, 6) }
    end
    if input[5] then
        data.props[7] = { GetPedPropIndex(plyPed, 7), GetPedPropTextureIndex(plyPed, 7) }
    end

    TriggerServerEvent("eup:saveCurrentOutfit", data)
end

function OpenDeleteEUPMenu()
    local outfits = nil
    ESX.TriggerServerCallback(
        "esx:fetchEUP",
        function(data)
            outfits = data
        end,
        ESX.PlayerData.job.name
    )

    while outfits == nil do
        Wait(0)
    end

    local options = {}
    for i = 1, #outfits do
        options[#options + 1] = { value = outfits[i].id, label = outfits[i].outfitName }
    end

    local input =
        lib.inputDialog(
            "Delete EUP Outfits",
            {
                {
                    type = "multi-select",
                    label = "Select Outfit(s)",
                    options = options,
                    description = "Select outfit(s) to delete."
                }
            }
        )

    if not input or not input[1] then
        return
    end

    TriggerServerEvent("eup:deleteOutfits", input[1])
end

function OpenHookiesChargeMenu()
    local coords = GetEntityCoords(PlayerPedId())
    local closestPlayers = ESX.Game.GetPlayersInArea(coords, 5.0)
    local players = {}
    for i = 1, #closestPlayers do
        if not IsEntityDead(GetPlayerPed(closestPlayers[i])) and closestPlayers[i] ~= PlayerId() then
            players[#players + 1] = {
                label = "ID: " .. GetPlayerServerId(closestPlayers[i]),
                value = GetPlayerServerId(closestPlayers[i])
            }
        end
    end

    table.sort(
        players,
        function(a, b)
            return a.label < b.label
        end
    )

    local input =
        lib.inputDialog(
            "Hookies",
            {
                { type = "select", label = "Select Player", options = players },
                { type = "number", label = "Enter Amount",  min = 1,          max = 10000 }
            }
        )

    if not input or not input[1] or not input[2] then
        return
    end

    TriggerServerEvent("hookies:chargePlayer", input[1], input[2])
end

function SkillCheck(difficulty, keys)
    local success = lib.skillCheck(difficulty, keys)
    return success
end

function OpenCasinoThrowoutMenu()
    local plyPed = PlayerPedId()
    local coords = GetEntityCoords(plyPed)
    local players = ESX.Game.GetPlayersInArea(coords, 200)

    local select = {}

    for i = 1, #players do
        local ped = GetPlayerPed(players[i])
        if GetInteriorFromEntity(ped) ~= 0 then
            select[#select + 1] = {
                label = "ID: " .. GetPlayerServerId(players[i]),
                value = GetPlayerServerId(players[i])
            }
        end
    end

    table.sort(select, function(a, b) return a.label < b.label end)

    local input = lib.inputDialog("Throw Out Player", {
        { type = "select", label = "Select ID", options = select }
    })

    if not input or not input[1] then return end

    TriggerServerEvent("stem_casino:throwOut", input[1])
end

function OpenSocietyPayEmployeeMenu(identifier, name)
    local input = lib.inputDialog("Pay Employee", {
        { type = "input", label = "Payee", disabled = true, default = name },
        {
            type = "number",
            label = "Amount",
            description = "Amount to pay employee.",
            required = true,
            min = 1,
            max = 100000
        }
    })

    if not input or not input[2] then return end

    TriggerServerEvent("esx_society:payEmployee", identifier, input[2])
end

function OpenTradingRegisterMenu()
    local input = lib.inputDialog("Register Brokerage Account", {
        {
            type = "input",
            label = "Legal Name",
            disabled = true,
            default = LocalPlayer.state.name
        },
        {
            type = "input",
            label = "Enter Password",
            description = "Minimum 8 characters required.",
            required = true,
            password = true,
            min = 8
        }
    })

    if not input or not input[2] then return end
    TriggerServerEvent("stem_nui:tradingRegister", input[2])
end

function OpenPayphoneInputMenu()
    local input = lib.inputDialog('Payphone', {
        {
            type = 'input',
            label = 'Enter Number',
            description = 'Call number, format: XXX-XXXX',
            required = true
        }
    })

    return input
end

function OpenPlaceAssassinationMenu()
    local input = nil

    ESX.TriggerServerCallback('assassinations:fetchEligiblePlayers', function(players)
        local selectElements = {}
        for i = 1, #players do
            selectElements[#selectElements + 1] = { value = players[i], label = players[i] }
        end

        table.sort(selectElements, function(a, b) return a.label < b.label end)

        input = lib.inputDialog('Place Hit', {
            {
                type = 'select',
                label = 'Select Target',
                options = selectElements,
                description = 'Full name of the player, exact spelling. Case sensitive.',
                required = true
            },
        })
    end)

    while not input do
        Wait(0)
    end

    return input
end

function OpenInspectVINDialog(vin)
    lib.alertDialog({
        header = 'VIN',
        content = vin,
        centered = true,
        labels = {
            confirm = 'Copy VIN'
        }
    })

    lib.setClipboard(vin)
    lib.defaultNotify({ description = 'Copied VIN to clipboard', status = "success" })
end

exports("OpenAtomRegisterMenu", OpenAtomRegisterMenu)
exports("OpenTaxiChargeMenu", OpenTaxiChargeMenu)
exports("OpenTaxiRateTipMenu", OpenTaxiRateTipMenu)
exports("OpenCinemaChargeMenu", OpenCinemaChargeMenu)
exports("OpenCinemaAdjustTicketMenu", OpenCinemaAdjustTicketMenu)
exports("OpenCinemaSnackRegisterMenu", OpenCinemaSnackRegisterMenu)
exports("OpenCasinoCashierMenu", OpenCasinoCashierMenu)
exports("OpenCasinoVIPCashierMenu", OpenCasinoVIPCashierMenu)
exports("OpenBurgershotRegisterMenu", OpenBurgershotRegisterMenu)
exports("OpenPrisonerIntakeMenu", OpenPrisonerIntakeMenu)
exports("OpenMBAInteriorMenu", OpenMBAInteriorMenu)
exports("OpenApplyOrganizationMenu", OpenApplyOrganizationMenu)
exports("OpenCreateJobMenu", OpenCreateJobMenu)
exports("OpenDenyJobMenu", OpenDenyJobMenu)
exports("OpenPlayerReportMenu", OpenPlayerReportMenu)
exports("OpenChangeCoverFeeMenu", OpenChangeCoverFeeMenu)
exports("OpenJailPlayerMenu", OpenJailPlayerMenu)
exports("OpenWeazelPriceMenu", OpenWeazelPriceMenu)
exports("OpenSaveOutfitMenu", OpenSaveOutfitMenu)
exports("OpenPoliceStoreItemMenu", OpenPoliceStoreItemMenu)
exports("OpenDOTInvoiceMenu", OpenDOTInvoiceMenu)
exports("OpenSocietyWithdrawMenu", OpenSocietyWithdrawMenu)
exports("OpenSocietyDepositMenu", OpenSocietyDepositMenu)
exports("OpenSetVanityPlateMenu", OpenSetVanityPlateMenu)
exports("OpenGrafittiMenu", OpenGrafittiMenu)
exports("OpenDenyHouseRequestMenu", OpenDenyHouseRequestMenu)
exports("OpenManualHouseRelocMenu", OpenManualHouseRelocMenu)
exports("StartPrisonShankMinigame", StartPrisonShankMinigame)
exports("OpenEditCriminalCodeMenu", OpenEditCriminalCodeMenu)
exports("OpenMBAChargePlayerMenu", OpenMBAChargePlayerMenu)
exports("OpenBeanMachineRegisterMenu", OpenBeanMachineRegisterMenu)
exports("OpenSaveEUPMenu", OpenSaveEUPMenu)
exports("OpenDeleteEUPMenu", OpenDeleteEUPMenu)
exports("OpenHookiesChargeMenu", OpenHookiesChargeMenu)
exports("SkillCheck", SkillCheck)
exports("OpenCasinoThrowoutMenu", OpenCasinoThrowoutMenu)
exports("OpenSocietyPayEmployeeMenu", OpenSocietyPayEmployeeMenu)
exports("OpenTradingRegisterMenu", OpenTradingRegisterMenu)
exports("OpenPayphoneInputMenu", OpenPayphoneInputMenu)
exports("OpenPlaceAssassinationMenu", OpenPlaceAssassinationMenu)
exports("OpenInspectVINDialog", OpenInspectVINDialog)
