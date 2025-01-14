RegisterNetEvent("stem_common:stretcher:closeOpenDoor", function (entityNet, toggle, doorIndex) 
    TriggerClientEvent("stem_common:stretcher:closeOpenDoor", -1, entityNet, toggle, doorIndex)
end)

RegisterNetEvent("stem_common:stretcher:grabStretcher", function (entityNet, playerId) 
    Entity(NetworkGetEntityFromNetworkId(entityNet)).state.stretcherAttached = true
    TriggerClientEvent("stem_common:stretcher:grabStretcher", -1, entityNet, playerId)
end)

RegisterNetEvent("stem_common:stretcher:detachStretcher", function (entityNet)
    TriggerClientEvent("stem_common:stretcher:detachStretcher", -1, entityNet)
end)

RegisterNetEvent("stem_common:stretcher:attachStr", function (playerId) 
    TriggerClientEvent("stem_common:stretcher:getOnStretcher", playerId)
end)