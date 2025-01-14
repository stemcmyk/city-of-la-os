Prison = nil

PrisonInteractions = {}
PrisonSirens = {}

local CheckBreakout = true

function InitializeScript()
    for k,v in pairs(Config.Prisons) do 
        PrisonInteractions[k] = {}
        if v.blip then 
            CreateBlip(v.blip)
        end
    end
end

CreateThread(
    function()
        while true do
            if (LocalPlayer.state.injail and LocalPlayer.state.injail > 0) then
                SetTextFont(4)
                SetTextProportional(1)
                SetTextScale(0.45, 0.45)
                SetTextColour(255, 255, 255, 255)
                SetTextDropShadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(true)

                BeginTextCommandDisplayText("STRING")
                AddTextComponentSubstringPlayerName("You have ~b~" .. LocalPlayer.state.injail .. "~s~ month(s) remaining.")

                EndTextCommandDisplayText(0.5, 0.95)

                DisableControlAction(0, 200, true)

                Wait(0)
            else
                Wait(1000)
            end
        end
    end
)

function TeleportHospital()
    if not Prison then return end
    CheckBreakout = false
    Wait(2000)
    local ped = PlayerPedId()
    local coords = Config.Prisons[Prison.index].hospital.coords
    local heading = Config.Prisons[Prison.index].hospital.heading
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    SetEntityHeading(ped, heading)
    Wait(2000)
    CheckBreakout = true
end

function ResetBreakout(index)
    local prison = Config.Prisons[index]
    if PrisonInteractions[index].breakout then 
        DeleteInteraction(PrisonInteractions[index].breakout)
    end
    PrisonInteractions[index].breakout = CreateInteraction({
        label = _L("interact_breakout"),
        coords = prison.breakout.start.coords,
        heading = prison.breakout.start.heading
    }, function(selected)
        ServerCallback("pickle_prisons:canBreakout", function(result) 
            if not result then return end
            if Config.Breakout.process(prison.breakout.start) then
                ShowNotification(_L("breakout_success"))
                TriggerServerEvent("pickle_prisons:startBreakout", index)
            else
                ShowNotification(_L("breakout_fail"))
            end
        end, index)
    end)
end

function GetClosestPrison() 
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local closest
    for k,v in pairs(Config.Prisons) do 
        if (not closest or (#(coords-v.coords) < closest.dist)) then
            closest = {index = k, dist = #(coords-v.coords) }
        end
    end 
    if closest then 
        return closest.index
    end
end 

function JailDialog() 
    local players = GetPlayersInArea()
    local players_list = {}
    local prisons = {}
    for i=1, #players do
        local id = GetPlayerServerId(players[i])
        players_list[#players_list + 1] = {label = _L("jail_dialog_player", GetPlayerName(players[i]), id), value = id}
    end
    for k,v in pairs(Config.Prisons) do 
        prisons[#prisons + 1] = {label = v.label, value = k}
    end
    if #prisons < 1 or #players_list < 1 then return end
    local input = lib.inputDialog(_L("jail_dialog_title"), {
        {type = 'select', label = _L("jail_dialog_prisoner"), default = players_list[1].value, required = true, options = players_list},
        {type = 'select', label = _L("jail_dialog_prison"), default = "default", required = true, options = prisons},
        {type = 'number', label = _L("jail_dialog_sentence"), default = 1, required = true, min = 1},
    }) 
    if not input then return end
    TriggerServerEvent("pickle_prisons:jailPlayer", input[1], input[3], input[2])
end 

RegisterNetEvent("pickle_prisons:jailDialog", JailDialog)

RegisterNetEvent("pickle_prisons:startBreakout", function(index)
    local prison = Config.Prisons[index]
    DeleteInteraction(PrisonInteractions[index].breakout)
    PrisonInteractions[index].breakout = CreateInteraction({
        label = _L("interact_active_breakout"),
        coords = prison.breakout.start.coords,
        heading = prison.breakout.start.heading,
        model = Config.Breakout.model
    }, function(selected)
        ServerCallback("pickle_prisons:enterBreakoutPoint", function(result) 
            if not result then return end
            local coords = prison.breakout.enter.coords
            local heading = prison.breakout.enter.heading
            TriggerServerEvent("pickle_prisons:breakout")
            TriggerEvent("pickle_prisons:leavePrison")
            WarpPlayer(coords, heading)
            local interact = CreateInteraction({
                label = _L("interact_exit_breakout"),
                coords = prison.breakout.leave.coords,
                heading = prison.breakout.leave.heading,
                model = Config.Breakout.model
            }, function(selected)
                ServerCallback("pickle_prisons:enterBreakoutPoint", function(result) 
                    if not result then return end
                    local coords = prison.breakout.finish.coords
                    local heading = prison.breakout.finish.heading
                    WarpPlayer(coords, heading)
                    DeleteInteraction(interact)
                end, index, "finish")
            end)
        end, index, "enter")
    end)
end)


function showMessages() 
    local messages = {
        [1] = "You have been sent to jail. Press ~INPUT_CONTEXT~ to continue.",
        [2] =
        "In jail, you are required to maintain good behavior and have the option of working to reduce your sentence. Press ~INPUT_CONTEXT~ to continue.",
        [3] = "You are required to enter a plea of guilty or not guilty. Press ~INPUT_ENTER~ to continue.",
        [4] =
        "Pleading guilty will result in an immediate felony conviction. Press ~INPUT_ENTER~ to continue.",
        [5] =
        "Pleading not guilty will result in a court hearing, if available. Please note that not guilty pleas ~r~may result in court fees and carries additional risk~s~. You may receive a harsher sentence if convicted at trial. Press ~INPUT_FRONTEND_ACCEPT~ to acknowledge this risk and continue."
    }

    while true do
        if IsControlJustPressed(0, 51) then
            break
        end

        ESX.ShowHelpNotification(messages[1], true)
        Wait(0)
    end

    while IsControlPressed(0, 51) do
        Wait(0)
    end

    while true do
        if IsControlJustPressed(0, 51) then
            break
        end

        ESX.ShowHelpNotification(messages[2], true)
        Wait(0)
    end

    while IsControlPressed(0, 51) do
        Wait(0)
    end

    while true do
        if IsControlJustPressed(0, 23) or IsDisabledControlJustPressed(0, 23) then
            break
        end

        ESX.ShowHelpNotification(messages[3], true)
        Wait(0)
    end

    while IsControlPressed(0, 23) or IsDisabledControlPressed(0, 23) do
        Wait(0)
    end

    while true do
        if IsControlJustPressed(0, 23) or IsDisabledControlJustPressed(0, 23) then
            break
        end

        ESX.ShowHelpNotification(messages[4], true)
        Wait(0)
    end

    while IsControlPressed(0, 23) or IsDisabledControlPressed(0, 23) do
        Wait(0)
    end

    while true do
        if IsControlJustPressed(0, 201) or IsDisabledControlJustPressed(0, 201) then
            break
        end

        ESX.ShowHelpNotification(messages[5], true)
        Wait(0)
    end
end

function showArraignmentMenu()
    
    local doneMenu = false
    local pleadNotGuilty = false

    local function ArraignmentMenu()
        ESX.UI.Menu.CloseAll()

        ESX.TriggerServerCallback(
            "esx_billing:getCriminalCharges",
            function(bills, dojWhitelist)
                if #bills > 0 then
                    local elements = {
                        head = { "Case No.", "Date", "Charge", "Fine Amount", "Action" },
                        rows = {}
                    }

                    for k, v in ipairs(bills) do
                        local actions = nil
                        if v.category ~= nil then
                            if v.category == "Ticket" then
                                actions = "{{Guilty|guilty}} {{Not Guilty|nguilty}} {{No Contest|ncontest}}"
                            else
                                if dojWhitelist then
                                    actions = "{{Guilty|guilty}}"
                                else
                                    actions = "{{Guilty|guilty}} {{Not Guilty|nguilty}}"
                                end
                            end
                        end

                        table.insert(
                            elements.rows,
                            {
                                data = v,
                                cols = {
                                    v.category and v.id or "N/A",
                                    v.issue_date and
                                    (v.overdue and '<span style="color:red;">' .. v.issue_date .. "</span>" or v.issue_date) or
                                    "N/A",
                                    v.label,
                                    "$" .. v.amount,
                                    actions
                                }
                            }
                        )
                    end

                    ESX.UI.Menu.Open(
                        "list",
                        GetCurrentResourceName(),
                        "billing",
                        elements,
                        function(data, menu)
                            local billData = data.data

                            if data.value == "guilty" or data.value == "ncontest" then
                                ESX.TriggerServerCallback(
                                    "esx_billing:pleadGuiltyOrNoContest",
                                    function()
                                        ArraignmentMenu()
                                    end,
                                    data.value,
                                    billData.id
                                )
                            elseif data.value == "nguilty" then
                                pleadNotGuilty = true
                                ESX.TriggerServerCallback(
                                    "esx_billing:pleadNotGuilty",
                                    function()
                                        ArraignmentMenu()
                                    end,
                                    billData.id
                                )
                            end
                        end,
                        function(data, menu)
                            ESX.ShowHelpNotification(
                                "You are required to enter a plea for all of your charges.")
                        end
                    )
                else
                    doneMenu = true
                end
            end
        )
    end

    CreateThread(
        function()
            while not doneMenu do
                Wait(0)
            end
        end
    )

    ArraignmentMenu()

    while not doneMenu do
        Wait(0)
    end

    if pleadNotGuilty then
        if GlobalState.jobCount["doj.2"] and GlobalState.jobCount["doj.2"] > 0 then
            jailTime = 0

            TriggerServerEvent('stem_doj:checkFlight', true)
        else
            while true do
                if IsControlJustPressed(0, 51) then
                    break
                end

                ESX.ShowHelpNotification(
                    "The court is unavailable for a hearing. You are responsible for showing up to court to resolve your not guilty plea after you are released. Press ~INPUT_CONTEXT~ to acknowledge this message.",
                    true
                )
                Wait(0)
            end
        end
    else
        ESX.ShowHelpNotification(
            "You have plead guilty to all of your charges and will now serve out your prison sentence.")
    end
end

RegisterNetEvent("pickle_prisons:stopBreakout", function(index)
    ResetBreakout(index)
end)

RegisterNetEvent("pickle_prisons:jailPlayer", function(data)
    Prison = data
    local prison = Config.Prisons[data.index]
    local cell = prison.cells[math.random(1, #prison.cells)]
    local coords = cell.coords
    local heading = cell.heading
    WarpPlayer(coords, heading, function()
        ToggleOutfit(true)
    end)
    exports["nearest-postal"]:hidePostal(true)
    TriggerEvent("pickle_prisons:enterPrison")
    LocalPlayer.state.inPrison = true

    
    SetEntityVisible(PlayerPedId(), false, false)
    FreezeEntityPosition(PlayerPedId(), true)
    NetworkSetFriendlyFireOption(false)
    
    showMessages() 
    showArraignmentMenu()

    SetEntityVisible(PlayerPedId(), true, false)
    FreezeEntityPosition(PlayerPedId(), false)
    NetworkSetFriendlyFireOption(true)

    Wait(2000)
    CreateThread(function()
        local coords = prison.coords
        while Prison and Prison.index == data.index do 
            if CheckBreakout then
                if Config.EnableSneakout then 
                    local pcoords = GetEntityCoords(PlayerPedId())
                    if #(coords - pcoords) > prison.radius then 
                        TriggerServerEvent("pickle_prisons:breakout")
                        TriggerEvent("pickle_prisons:leavePrison")
                        break
                    end
                else
                    local pcoords = GetEntityCoords(PlayerPedId())
                    if #(coords - pcoords) > prison.radius then 
                        local cell = prison.cells[math.random(1, #prison.cells)]
                        local coords = cell.coords
                        local heading = cell.heading
                        ShowNotification(_L("cant_sneakout"))
                        WarpPlayer(coords, heading, function()
                            ToggleOutfit(true)
                        end)
                    end
                end
            end
            Wait(1500)
        end
    end)
end)

RegisterNetEvent("pickle_prisons:unjailPlayer", function(data, court)
    TriggerEvent("pickle_prisons:leavePrison")
    if (court) then
        return ToggleOutfit(false)
    end
    local prison = Config.Prisons[data.index]
    local coords = prison.release.coords
    local heading = prison.release.heading
    WarpPlayer(coords, heading, function()
        ToggleOutfit(false)
    end)
end)

RegisterNetEvent("pickle_prisons:enterPrison", function()
    local index = Prison.index
    local prison = Config.Prisons[index]
    ResetBreakout(index)
    LocalPlayer.state.inPrison = true
end)

RegisterNetEvent("pickle_prisons:leavePrison", function()
    Prison = nil
    exports["nearest-postal"]:hidePostal(false)
    LocalPlayer.state.inPrison = false
end)

RegisterNetEvent("pickle_prisons:startSiren", function(index)
    if PrisonSirens[index] then return end
    PrisonSirens[index] = true
    local prison = Config.Prisons[index]
    SendNUIMessage({
        type = "startSiren"
    })
    CreateThread(function()
        local maxDist = prison.radius * 2
        while PrisonSirens[index] do 
            if GetClosestPrison() == index then
                local pcoords = GetEntityCoords(PlayerPedId())
                local dist = #(prison.coords - pcoords)
                local factor = 1.0 - (dist / maxDist)
                if factor < 0 then
                    factor = 0
                end
                SendNUIMessage({
                    type = "setVolume",
                    value = factor
                })
            end
            Wait(1500)
        end
        SendNUIMessage({
            type = "endSiren"
        })
    end)
end)

RegisterNetEvent("pickle_prisons:stopSiren", function(index)
    PrisonSirens[index] = nil
end)

RegisterNetEvent("pickle_prisons:alert", function(index, disabled)
    Config.Alerts(index, disabled)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    Wait(1000)
    TriggerServerEvent("pickle_prisons:initializePlayer")
end)

CreateThread(function()
    InitializeScript()
end)