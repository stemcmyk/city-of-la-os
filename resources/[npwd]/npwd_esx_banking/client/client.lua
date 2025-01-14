local addDashes = function(str)
    local result = ""
    local count = 0
    local dashesAdded = 0
    
    for i = 1, #str do
        result = result .. string.sub(str, i, i)
        count = count + 1
        
        if count == 3 and dashesAdded < 2 then
            result = result .. "-"
            count = 0
            dashesAdded = dashesAdded + 1
        end
    end
    
    return result
end


local errorNotify = function(message)
    exports["npwd"]:createNotification({
        notisId = "banking:wrongNumber",
        appId = "BANKING",
        content = message,
        secondaryTitle = "ERROR",
        keepOpen = false,
        duration = 2000,
        path = "/banking",
    })
end

RegisterNUICallback("npwd:esx-banking:getBalance", function(_, cb)
    ESX.TriggerServerCallback('npwd:esx-banking:getBankingInfo', function(data)
        cb({
            status = "ok",
            data = data
        })
    end)
end)


RegisterNUICallback("npwd:esx-banking:tryTransfer", function(data, cb)
    if data.amount == "" then
        errorNotify("Nieprawidłowa ilość")
        return
    end
    local pattern = "^%d%d%d%-?%d%d%d%-?%d%d%d%d$"
    local isMatch = string.match(data.phoneNumber, pattern) ~= nil
    if not isMatch then
        errorNotify("Nieprawidłowy numer telefonu!")
    else
        local formatedPhoneNumber = addDashes(string.gsub(data.phoneNumber, "-", ""))
        ESX.TriggerServerCallback('npwd:esx-banking:checkPhoneNumber', function(status)
            if status == "NEXIST" then
                errorNotify("Numer nie istnieje!")
                return
            elseif status == "NMONEY" then
                errorNotify("Nie masz tyle pieniędzy!")
                return
            elseif status == "GOOD" then
                exports["npwd"]:createNotification({
                    notisId = "banking:transferSuccess",
                    appId = "BANKING",
                    content = "Wysłano "..data.amount.."$ na konto ".. formatedPhoneNumber,
                    secondaryTitle = "Przelew",
                    keepOpen = false,
                    duration = 4000,
                    path = "/banking",
                })
                return 
            end
        end, formatedPhoneNumber, tonumber(data.amount), data.date)
    end
    cb("Ok")
end)

RegisterNetEvent('npwd:esx-banking:showNotify', function(amount, from)
    exports["npwd"]:createNotification({
        notisId = "banking:transferSuccess",
        appId = "BANKING",
        content = "Otrzymano "..amount.."$ od ".. from,
        secondaryTitle = "Przelew",
        keepOpen = false,
        duration = 4000,
        path = "/banking",
    })
end)

RegisterNetEvent('npwd:esx-banking:updateTransactions', function()
    ESX.TriggerServerCallback('npwd:esx-banking:getBankingInfo', function(data)
        exports.npwd:sendUIMessage({type = "npwd:esx-banking:updateTransactions", payload = {transactions = data.transactions, bankBalance = data.amount}})
    end)
end)

RegisterCommand('checkSubscription', function(source,args)
    exports.npwd:sendUIMessage({type = "npwd:esx-banking:updateTransactions", payload = {text =  "XD", dupa = "DDDSS"}})
end)