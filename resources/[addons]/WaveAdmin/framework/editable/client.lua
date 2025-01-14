-- ======[EDITABLE FUNCTIONS]======

function RestoreConsumableStats()
    if Config.FrameWork.FRAMEWORK == "ESX" then
        TriggerEvent('esx_status:set', 'hunger', 1000000)
        TriggerEvent('esx_status:set', 'thirst', 1000000)
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        TriggerEvent("hud:client:UpdateNeeds", 100, 100)
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
    end
end

function OpenSkinMenu()
    if Config.FrameWork.FRAMEWORK == "ESX" then
        TriggerEvent('esx_skin:openSaveableMenu')
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        TriggerEvent("qb-clothes:client:CreateFirstCharacter")
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
    end
end

function OpenClothesMenu()
    if Config.FrameWork.FRAMEWORK == "ESX" then
        TriggerEvent('esx_skin:openMenu')
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        TriggerEvent("qb-clothing:client:openMenu")
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
    end
end


-- ======[Callback Events]======
local ServerCallbacks = {}

function TriggerServerCallback(name, cb, ...)
    ServerCallbacks[name] = cb
    TriggerServerEvent(GetCurrentResourceName()..':TriggerServerCallback', name, ...)
end

RegisterNetEvent(GetCurrentResourceName()..':TriggerServerCallback', function(name, ...)
    if ServerCallbacks[name] then
        ServerCallbacks[name](...)
        ServerCallbacks[name] = nil
    end
end)