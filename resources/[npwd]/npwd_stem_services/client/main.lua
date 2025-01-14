

RegisterNUICallback("npwd:stem_services:getJobCounts", function(data, cb)
    print("ass")
    ESX.TriggerServerCallback("npwd:stem_services:getJobCounts", function (data)
        cb({ status = "ok", data = data })
    end)
end)