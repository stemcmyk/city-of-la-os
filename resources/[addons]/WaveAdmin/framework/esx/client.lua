if Config.FrameWork.FRAMEWORK ~= 'ESX' then return end

ESX = nil

CreateThread(function()
    GetFrameWorkObject(function(object)
        ESX = object
    end)
end)