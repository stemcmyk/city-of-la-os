lib.locale()
local config = require('shared.config')
local policeCount = nil 

local function policeCall()
    if config.Dispatch == "ps-dispatch" then
     exports['ps-dispatch']:ATMHacking()
    else
    -- Add your custom export here
    end
end

local modelsATM = {
    'prop_atm_01',
    'prop_atm_02',
    'prop_atm_03',
    'prop_fleeca_atm'
}

local optionATM = {
    {
        name = 'HackATM',
        icon = config.LabelIcon,
        label = locale('target_label'),
        items = config.RequiredItem,
        distance = 2.5,
        onSelect = function(data)
            TriggerServerEvent('possible-atm-robbery:server:startHack', NetworkGetNetworkIdFromEntity(data.entity))
        end
    }
}

exports.ox_target:addModel(modelsATM, optionATM)

local function onHackDone(success, netId)
    ClearPedTasks(PlayerPedId())
    if success then
        if config.Emotes == 'rpemotes' then
            ClearPedTasks(PlayerPedId())
            ClearPedTasksImmediately(PlayerPedId())
        else
            exports.scully_emotemenu:cancelEmote()
        end
        TaskPlayAnim(PlayerPedId(), "anim@scripted@player@mission@tun_table_grab@cash@", "grab", -1, -1, config.ProgressDuration)        
        TriggerEvent('mhacking:hide')
        if lib.progressBar({
            duration = config.ProgressDuration,
            label = locale('looting_progress_label'),
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true
            }, 
            anim = {
                dict = 'anim@scripted@player@mission@tun_table_grab@cash@',
                clip = 'grab', 
                lockX = true,
                lockY = true,
                lockZ = true,
            },
        }) then
            lib.notify({
                title = locale('looting_success_title'),
                description = locale('looting_success_description'),
                type = 'success',
                position = config.NotifPosition,
                icon = config.NotifIcon
            })
            TriggerEvent('possible-atm-robbery:client:success', netId)
        else
            lib.cancelProgress()
            lib.notify({
                title = locale('looting_signal_lost_title'),
                description = locale('looting_signal_lost_description'),
                type = 'error',
                position = config.NotifPosition,
                icon = config.NotifIcon
            })
        end
    else
        lib.notify({
            title = locale('looting_failed_title'),
            description = locale('looting_failed_description'),
            type = 'error',
            position = config.NotifPosition,
            icon = config.NotifIcon
        })
        TriggerEvent("mhacking:hide")
        if config.Emotes == 'rpemotes' then
            exports["rpemotes"]:EmoteCancel(forceCancel)
        else
            exports.scully_emotemenu:cancelEmote()
        end
    end
end

RegisterNetEvent('possible-atm-robbery:client:receivePoliceCount', function(count)
    policeCount = count
    if config.Debug then
        print('Police count: ' .. policeCount)
    end
end)

RegisterNetEvent('possible-atm-robbery:client:startHack', function(netId)
    TriggerServerEvent('possible-atm-robbery:server:requestPoliceCount')
    Wait(500)
    local territory = GetEntityCoords(PlayerPedId()).y > 500 and "sahp" or "lspd"
    local enough = false

    if (territory == "lspd") then
        enough = (GlobalState.jobCount["lspd"] or 0) + (GlobalState.jobCount["lssd"] or 0) >= config.Police.jobs["lspd"]
    else 
        enough = (GlobalState.jobCount["sahp"] or 0) >= config.Police.jobs["sahp"]
    end

    if enough then
            if config.Emotes == 'rpemotes' then
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
            else
                exports.scully_emotemenu:playEmoteByCommand('phone')
            end
            policeCall()
            TriggerEvent("mhacking:show")
            TriggerEvent("mhacking:start", math.random(2, 2), math.random(9, 12), function (data) onHackDone(data, netId) end)
        else
            lib.notify({
                title = locale('not_enough_police_title'),
                description = locale('not_enough_police_description'),
                type = 'error',
                position = config.NotifPosition,
                icon = config.NotifIcon
            })
     end
end)

RegisterNetEvent('possible-atm-robbery:client:success', function(netId)
    TriggerServerEvent('possible-atm-robbery:server:giveReward', netId)
end)

