uclZone = nil
DoScreenFadeIn(
	500
)

RegisterNetEvent("stem_dealership:ucl:register", function (zone) 
    if (uclZone) then return end
	uclZone = PolyZone:Create(
        zone.zone,
		{
			name = "UCL",
            -- debugPoly = true,
            
		}
	)
	uclZone:onPlayerInOut(function (out)
        if (out ) then
            lib.notify({
                type = "info",
                description = "Welcome to the **Used Car Lot**. Do **/sellcar** to put a vehicle on the market",
                duration = 4000 
            })
        end
	end)
    local blip = AddBlipForCoord(uclZone.center)
    SetBlipSprite(blip, 380)
    SetBlipAsShortRange(blip, true)
    SetBlipDisplay(blip, 4)

    
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName("Used Car Lot")
    EndTextCommandSetBlipName(blip)
end)

ESX.RegisterClientCallback("stem_dealership:ucl:sellPrompt", function (cb)
    if (not uclZone or not uclZone:isPointInside(GetEntityCoords(cache.ped))) then 
        if (not exports.stem_common:tableContains(LocalPlayer.state.supporterAccess, "silver")) then
            return lib.notify({
                type = "error",
                description = "You are not at the **UCL** or you do not have **Silver** supporter.",  
            }) 
        end
    end

    local vehiclePlayerIsIn = GetVehiclePedIsIn(cache.ped, false)
    if (not vehiclePlayerIsIn or vehiclePlayerIsIn < 1) then return lib.notify({
        type = "error",
        description = "You are not in a vehicle.",  
    }) end

    local input = lib.inputDialog("Sell Vehicle", {{
        label = "Price",
        type = "number",
    }})

    if (not input) then return end
    
    cb({price = input[1] or 0, vehicle = NetworkGetNetworkIdFromEntity(vehiclePlayerIsIn), plate = GetVehicleNumberPlateText(vehiclePlayerIsIn), odometer = Entity(vehiclePlayerIsIn).state.odometer})
end)

Citizen.CreateThread(function()
    TriggerServerEvent("stem_dealership:ucl:fetch")
end)

local registeredVehicles = {}


RegisterNetEvent("stem_dealership:ucl:registerCar", function (data)
    local entityId = NetworkGetEntityFromNetworkId(data.vehicle)
    local seats = GetVehicleModelNumberOfSeats(GetEntityModel(entityId))
    
    for i = 1, seats, 1 do
        TaskLeaveVehicle(
            GetPedInVehicleSeat(entityId, i - 2), 
        	entityId,
            0
        )
    end
    
    SetVehicleDoorsLocked(entityId, 2)

    local vehicleShopListing = exports.stem_dealership:getVehicleByHash(GetEntityModel(entityId))
    Entity(entityId).state.odometer = data.odometer or Entity(entityId).state.odometer
    
    createVehicle({
        model = GetEntityModel(entityId),
        price = data.price,
        label = vehicleShopListing?.label or GetDisplayNameFromVehicleModel(GetEntityModel(entityId)) or GetEntityModel(entityId)
    }, nil, data)

    registeredVehicles[data.vehicle] = data
end)

Citizen.CreateThread(function () 
    exports.ox_target:addGlobalVehicle({{
        label = "View Car Listing",
        onSelect = function (data) 
            lib.showContext("ucl:"..NetworkGetNetworkIdFromEntity(data.entity))
        end,
        canInteract = function (entity)
            if (registeredVehicles[NetworkGetNetworkIdFromEntity(entity)]) then
                return true
            end
            return false
        end
    }})
    local timeout = 500
    while true do
        for key, data in pairs(registeredVehicles) do
            if (data) then
                local entityId = NetworkGetEntityFromNetworkId(data.vehicle)
                if (DoesEntityExist(entityId) and GetDistanceBetweenCoords(GetEntityCoords(entityId), GetEntityCoords(cache.ped)) < 5) then
                    local c = GetEntityCoords(entityId)
                    DrawText3D(vector3(c.x, c.y, c.z + 1), ("Vehicle on sale for: ~g~$%s~w~"):format(ESX.Math.GroupDigits(data.price)))
                    DrawText3D(vector3(c.x, c.y, c.z + 0.9), ("Total Miles: ~r~%s~w~"):format(ESX.Math.GroupDigits(math.floor(((Entity(entityId).state.odometer or 0) / 1000) * 0.6213712)) .. " mi."))
                    timeout = 1
                else 
                    timeout = 500
                end
            end
        end
        Citizen.Wait(timeout)
    end
end)

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end

RegisterNetEvent("stem_dealership:vehicle_bought", function (vehNetId, playerId) 
    if (registeredVehicles[vehNetId]) then
        if (playerId == GetPlayerServerId(PlayerId())) then
            local entityId = NetworkGetEntityFromNetworkId(vehNetId)
            if (GetResourceState("wasabi_carlock") == "started") then exports.wasabi_carlock:GiveKey(GetVehicleNumberPlateText(entityId)) end
            Wait(50)
            SetVehicleDoorsLocked(entityId, 1)
            Wait(50)
            TaskEnterVehicle(
                cache.ped, 
                entityId, 
                250, 
                -1, 
                1
            )
        end

        registeredVehicles[vehNetId] = nil
    end
end)