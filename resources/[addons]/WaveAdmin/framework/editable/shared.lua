function GetFrameWorkObject(callBack)
    if Config.FrameWork.FRAMEWORK == "ESX" then
        xpcall(function()
            callBack(exports[Config.FrameWork.ESX_RESOURCE_NAME or "es_extended"]:getSharedObject())
        end, function()
            CreateThread(function()
                local ESX, attempt = nil, 0
                while not ESX do
                    Wait(100)
                    TriggerEvent(Config.FrameWork.ESX_SHARED_OBJECT, function(obj)
                        ESX = obj
                    end)
                    attempt = attempt + 1
                    if attempt == 100 then
                        print("Failed to get your ESX object, make sure you configured your framework properly.")
                        return
                    end
                end
                callBack(ESX)
            end)
        end)
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        xpcall(function()
            callBack(exports[Config.FrameWork.QBCORE_RESOURCE_NAME or "qb-core"]:GetCoreObject())
        end, function()
            xpcall(function()
                callBack(exports[Config.FrameWork.QBCORE_RESOURCE_NAME or "qb-core"]:GetSharedObject())
            end, function()
                CreateThread(function()
                    local QBCore, attempt = nil, 0
                    while not QBCore do
                        Wait(100)
                        TriggerEvent(Config.FrameWork.QBCORE_SHARED_OBJECT, function(obj)
                            QBCore = obj
                        end)
                        attempt = attempt + 1
                        if attempt == 100 then
                            print("Failed to get your QBCore object, make sure you configured your framework properly.")
                            return
                        end
                    end
                    callBack(QBCore)
                end)
            end)
        end)
    end
end

function GetGreatestNumber(numbers)
    if type(numbers) == 'table' then
        local g = 0
        for k, v in pairs(numbers) do
            if tonumber(v) and v > g then
                g = v
            end
        end
        return g
    else
        return tonumber(numbers) or 0
    end
end