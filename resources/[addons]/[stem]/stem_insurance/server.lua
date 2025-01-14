-- Event: "stem_insurance:getLastGarage"

-- ESX CB "stem_insurance:fetchData"
-- ESX CB "stem_insurance:updateVehStatus"
-- ESX CB "stem_insurance:recoverVehicle"

ESX.RegisterServerCallback("stem_insurance:fetchData", function (source, cb)
    local player = ESX.GetPlayerFromId(source) 
    MySQL.Async.fetchAll("SELECT vehicle, plate, insurance, status FROM owned_vehicles WHERE owner = @identifier", {
        ["@identifier"] = player.identifier
    }, function (result) 
        if (result) then
            cb(result)
        end
    end)
end)

local function returnVehicle(plate) 
    MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate", { ["@plate"] = plate, ["stored"] = 1})
end


ESX.RegisterServerCallback("stem_insurance:recoverVehicle", function (source, cb, plate)    
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchSingle("SELECT pound, stored, insurance FROM owned_vehicles WHERE plate = @plate", {
        ["@identifier"] = player.identifier,
        ["@plate"] = plate
    }, function (result) 
        if (result) then
            if (result.pound) then return cb("impounded") end
            if (result.stored) then return cb("already_garage") end
            local vehicle = exports.lunar_garage:getVehicle(player.source, plate)
            if not vehicle or not DoesEntityExist(vehicle) then
                returnVehicle(plate)
                return cb(true)
            end
            if (vehicle) then
                TriggerClientEvent("stem_insurance:receivePos", player.source, GetEntityCoords(vehicle))
                return cb("already_out") 
            end
            cb(false)
        end
    end)
end)

local bitToBool = { [0] = false, [1] = true }

ESX.RegisterServerCallback("stem_insurance:updateVehStatus", function (source, cb, plate, status)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchSingle("SELECT insurance, vehicle FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = plate
    }, function (result) 
        if (type(result.insurance) == "boolean" and result.insurance ~= bitToBool[status]) then
            ESX.TriggerClientCallback(player.source, "stem_insurance:vehicles:getClassFromName",  function (response)
                if (bitToBool[status]) then
                    local price = Config.InsurancePrices[response] or Config.DefaultInsurancePrice
                    if (player.getAccount("bank").money <= price) then
                        return player.showNotification(Config.Locale["not_enough_money"], "error")
                    end
                    player.removeAccountMoney("bank", price)
                    player.showNotification(string.format(Config.Locale["purchase_complete"], ESX.Math.GroupDigits(price), plate), "success")
                else
                    player.showNotification(Config.Locale["insurance_canceled"], "success")
                end
                MySQL.Async.execute("UPDATE owned_vehicles SET insurance = @insurance WHERE plate = @plate", {
                    ["@plate"] = plate,
                    ["@insurance"] = status,
                }, function(result) 
                    if (result) then return cb(true) end
                    cb(false)
                end)
            end, json.decode(result.vehicle).model)
        end
    end)
end)