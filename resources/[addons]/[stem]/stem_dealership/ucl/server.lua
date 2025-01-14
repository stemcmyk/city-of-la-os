local uclVehicles = {}

RegisterNetEvent("stem_dealership:ucl:fetch", function () 
    local zone = Config.usedCarLots["sandy"]
    TriggerClientEvent("stem_dealership:ucl:register", source, zone)
end)

ESX.RegisterCommand("sellcar", "user", function (player) 
    ESX.TriggerClientCallback(player.source, "stem_dealership:ucl:sellPrompt", function (data) 
        if (not data) then return end

        local vehicle = MySQL.single.await("SELECT owner FROM owned_vehicles WHERE plate = @plate", {
            ["@plate"] = string.strtrim(data.plate) 
        })
        
        if (not vehicle or vehicle.owner ~= player.identifier) then return player.showNotification("You do not own this vehicle", "error") end
            
        local vehicleId = #uclVehicles + 1
        uclVehicles[vehicleId] = {
            id = vehicleId,
            vehicle = data.vehicle,
            price = data.price,
            odometer = data.odometer,
            seller = {
                name = player.name,
                phone = (exports.npwd:getPlayerData({ identifier = player.identifier }).phoneNumber) or "No phone number"
            }
        }
        if (GetResourceState("wasabi_carlock") == "started") then exports.wasabi_carlock:RemoveKey(player.source, GetVehicleNumberPlateText(entityId)) end
        TriggerClientEvent("stem_dealership:ucl:registerCar", -1, uclVehicles[vehicleId])
    end)
end)

function getUCLVehicle(vehicleId) 
    return uclVehicles[vehicleId]
end
function removeUCLVehicle(vehicleId) 
    uclVehicles[vehicleId] = nil
end