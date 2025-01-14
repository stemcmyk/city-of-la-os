RegisterNetEvent('stem_common:payment_terminal:beginTerminal', function(player, pos, meta)
    local ped = cache.ped
    local coords = GetEntityCoords(ped)

    if (not pos) then
        lib.requestModel('bzzz_prop_payment_terminal', 300)
        lib.requestAnimDict('cellphone@', 100)

        LocalPlayer.state:set(
            'propData',
            {
                model = `bzzz_prop_payment_terminal`,
                boneIndex = 57005,
                offset = vector3(0.18, 0.01, 0.0),
                rotation = vector3(-54.0, 220.0, 43.0),
                rotationOrder = 1
            },
            true
        )

        TaskPlayAnim(ped, 'cellphone@', 'cellphone_text_read_base', 8.0, 1.0, -1, 49, 0, false, false, false)
    else
        LocalPlayer.state.paymentTerminalActive = true
    end

    -- players[#players + 1] = {
    --     label = 'ID: ' .. GetPlayerServerId(PlayerId()),
    --     value = GetPlayerServerId(PlayerId())
    -- }

    local amount;
    
    if (not player) then
        local players = {}

        if not player then 
            local coords = GetEntityCoords(PlayerPedId())
            local closestPlayers = ESX.Game.GetPlayersInArea(coords, 5.0)
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
        end

        local input =
            lib.inputDialog(
                "New Invoice",
                {
                    { type = "select", label = "Select Player", options = players },
                    { type = "number", label = "Enter Amount",  min = 1,          max = 10000 }
                }
            )
        if (input) then
            player = input[1]
            amount = input[2]
        end
    else
        amount =
        lib.inputDialog(
            string.format('New Invoice For (%s)', player),
            {
                { type = 'number', label = 'Enter Amount (max. $5,000)', min = 1, max = 5000 }
            }
        )
    end

    if not amount or not player then
        LocalPlayer.state.blockClearTasks = nil
        LocalPlayer.state.invBusy = false
        ClearPedTasks(ped)
        LocalPlayer.state.paymentTerminalActive = false
        LocalPlayer.state:set('propData', nil, true)
        return
    end

    TriggerServerEvent('stem_common:payment_terminal:invoiceCreated', player, amount, meta, pos)
    
    LocalPlayer.state.blockClearTasks = true
    LocalPlayer.state.invBusy = true

    ESX.ShowHelpNotification('Press ~INPUT_VEH_DUCK~ to cancel transaction.')

    while LocalPlayer.state.propData or LocalPlayer.state.entityTerminal do
        if not IsEntityPlayingAnim(ped, 'cellphone@', 'cellphone_text_read_base', 3) and not LocalPlayer.state.entityTerminal then
            TaskPlayAnim(ped, 'cellphone@', 'cellphone_text_read_base', 8.0, 1.0, -1, 49, 0, false, false, false)
        end

        if IsControlJustPressed(0, 73) or IsEntityDead(ped) then
            LocalPlayer.state.paymentTerminalActive = false
            LocalPlayer.state.blockClearTasks = nil
            LocalPlayer.state.invBusy = false
            ClearPedTasks(ped)
            LocalPlayer.state:set('propData', nil, true)
            TriggerServerEvent('stem_common:payment_terminal:finish', player)
            return
        end

        Wait(0)
    end
end)

RegisterNetEvent('stem_common:payment_terminal:floatingNotify', function(initPlayer, amount, pos)
    local player = GetPlayerFromServerId(initPlayer)
    local plyPed = GetPlayerPed(player)
    if not DoesEntityExist(plyPed) then return end

    while true do
        local plyCoords = GetEntityCoords(plyPed)

        local entityCoords = pos

        if (not pos) then
            local obj = GetClosestObjectOfType(plyCoords, 1.0, `bzzz_prop_payment_terminal`, false, false, false)
            if not DoesEntityExist(obj) then return end
            if not Player(initPlayer).state.propData then return end
            entityCoords = GetEntityCoords(obj)
        end

        if #(GetEntityCoords(cache.ped) - plyCoords) < 5.0 then
            ESX.ShowFloatingHelpNotification('~INPUT_DETONATE~Pay $' .. amount, entityCoords)

            if IsControlJustPressed(0, 47) then
                TriggerServerEvent('stem_common:payment_terminal:acceptInvoice', initPlayer, pos)
                return
            end
        end

        Wait(0)
    end
end)


RegisterNetEvent('stem_common:payment_terminal:complete', function()
    LocalPlayer.state.blockClearTasks = nil
    LocalPlayer.state.invBusy = false
    LocalPlayer.state.paymentTerminalActive = false
    ClearPedTasks(PlayerPedId())
    LocalPlayer.state:set('propData', nil, true)
end)

RegisterNetEvent('stem_common:payment_terminal:playSound', function(audioName, audioRef)
    PlaySoundFrontend(-1, audioName, audioRef, false)
end)

exports.ox_inventory:displayMetadata({
    ppratio = 'Payment Ratio',
    society = 'Society'
})
