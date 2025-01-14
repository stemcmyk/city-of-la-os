local JOB_PAYOUT_WEBHOOK = GetConvar("job_payout_webhook", nil)



RegisterNetEvent("stem_garbage:updateRoute", function (vehicle)
    local player = ESX.GetPlayerFromId(source)
    
    local routeId = Player(player.source).state.garbageRouteId
    local lastRouteId = Player(player.source).state.garbageLastRouteId
    local routeVehicle = Player(player.source).state.garbageServiceVehicle

    local doesVehicleExist = DoesEntityExist(NetworkGetEntityFromNetworkId(vehicle)) and DoesEntityExist(NetworkGetEntityFromNetworkId(routeVehicle))
    
    if (player.job.name ~= "sanitation") then
        return player.showNotification("You cannot switch jobs during the route and expect pay.")
    end

    if (vehicle ~= routeVehicle or not routeId or not vehicle or not routeVehicle or not doesVehicleExist or not Player(player.source).state.garbageInService) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_garbage:updateRoute",
			reason = "Invalid garbage vehicle or route",
			metadata = {
                routeVehicle = routeVehicle,
                vehicle = vehicle,
                routeId = routeId
			}
		})
    end
    
    if (routeId == lastRouteId) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_garbage:updateRoute",
			reason = "Same route id",
			metadata = {
                lastRouteId = lastRouteId,
                routeId = routeId
			}
		})
    end

    Player(player.source).state.garbageLastRouteId = routeId

    local payment = math.ceil(math.random(450, 650))
    player.addAccountMoney("bank", payment)
    player.showNotification(("You have been paid **$%s**"):format(payment), "success")
    if (JOB_PAYOUT_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
            exports.stem_discord:sendThroughWebhook({
                webhook = JOB_PAYOUT_WEBHOOK,
                params = {
                    username = "Job Delivery",
                    content = ([[
                        <@%s> ``%s (%s)`` **%s** finished a **Garbage** route and made **$%s**
                    ]]):format(
                        playerDiscord, player.name, GetPlayerName(player.source), player.identifier, ESX.Math.GroupDigits(payment)
                    ),
                },
                ignoreEnv = true,
            })
        end)
    else
        print("No job_payout_webhook found")
    end
end)

RegisterNetEvent("stem_garbage:beginService", function (vehicle) 
    local player = ESX.GetPlayerFromId(source)
    print(("%s begun their garbage service"):format(player.name, player.source))
    Player(player.source).state.garbageServiceVehicle = vehicle
    Player(player.source).state.garbageInService = true
end)

RegisterNetEvent("stem_garbage:beginRoute", function ( ) 
    local player = ESX.GetPlayerFromId(source)
    if (not Player(player.source).state.garbageInService) then return end
    print(("%s begun a garbage route"):format(player.name, player.source))

    local newRouteId = (Player(player.source).state.garbageRouteId or 0) + 1
    Player(player.source).state.garbageRouteId = newRouteId >= #Shared.GarbagePos and 1 or newRouteId
end)

RegisterNetEvent("stem_garbage:finishService", function ( ) 
    local player = ESX.GetPlayerFromId(source)
    if (not Player(player.source).state.garbageInService) then return end
    local newRouteId = (Player(player.source).state.garbageRouteId or 0) + 1
    Player(player.source).state.garbageRouteId = nil
    Player(player.source).state.garbageServiceVehicle = nil
end)
    
    