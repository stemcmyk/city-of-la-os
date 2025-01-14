if Config.FrameWork.FRAMEWORK ~= 'QBCORE' then return end

QBCore = nil

CreateThread(function()
    GetFrameWorkObject(function(object)
        QBCore = object
    end)
end)