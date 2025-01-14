-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

-- Customize these functions to update various things throughout Wasabi Scripts

-- Notifications
RegisterNetEvent('wasabi_bridge:notify', function(title, desc, style, icon, id)
    --Customize with your own notification system.
    --To use framework specific one you can use this function:
    -- WSB.showNotification(msg, style)

    -- Edit code below to use your own notification system (This support wasabi_notify and ox_lib notify by default!)
    -- wasabi_notify: https://store.wasabiscripts.com/package/6215100

    if GetResourceState('wasabi_notify') == 'started' then
        exports.wasabi_notify:notify(title, desc, 3500, style, Config.NotificationSound or false, icon, id)
        return
    end

    lib.notify({
        title = title,
        description = desc or false,
        id = id or false,
        position = 'top-right',
        icon = icon or false,
        duration = 3500,
        type = style or 'inform'
    })

    -- Edit Code above to use your own notification system


end)

-- Text UI
local textUI = false

-- Show text UI
function WSB.showTextUI(msg)
    -- EDIT: Customize with your own text UI system
    lib.showTextUI(msg)

    textUI = msg
end

-- Hide text UI
function WSB.hideTextUI()
    -- EDIT: Customize with your own text UI system
    lib.hideTextUI()

    textUI = false
end

-- Checking for text UI
function WSB.isTextUIOpen()
    return textUI and true or false, textUI or false
end

-- Add car keys
function WSB.giveCarKeys(plate, _model, _vehicle)
    if WSB.framework == 'qb' then
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
    else
        exports.wasabi_carlock:GiveKey(plate) -- Leave like this if using wasabi_carlock
    end
end

function WSB.removeCarKeys(plate, _model, _vehicle)
    -- Put remove key logic here
end
