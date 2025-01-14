local ox_lib = exports.ox_lib
local ox_target = exports.ox_target
local wasabi_carlock = exports.wasabi_carlock

if (not Config) then
    print("ERROR: No Config Loaded")
end


local menuLocation = "top-right"
local testLength = 1
local isVehicleRotating = false
local currentStore;
local currentVehicle;
local currentCamera;
local storeBlips = {}
local lastLocation, lastHeading
local lastMenu = {}
local currentSupporterAccess = 0


local dealershipBlip = {
    sprite = 832,
    scale = 1,
    color = 0,
    text = "Premium Deluxe Motorsports (PDM)"
}


-- Flattening the shop list
local vehicles = flattenShopList(Config.shop)
hashedVehicles = flattenShopList(Config.shop, true)

exports("getVehicle", function (model) 
    return vehicles[model]
end)

exports("getVehicleByHash", function (model) 
    return hashedVehicles[model]
end)



for key, value in pairs(vehicles) do
    AddTextEntry(key, value.label)
end

exports("getVehicle", function (model) 
    return vehicles[model]
end)

local function setVehicleRotate(vehicle) 
    Citizen.CreateThread(function() 
        isVehicleRotating = true;
        while isVehicleRotating do
            Citizen.Wait(5)
            SetEntityHeading(vehicle, GetEntityHeading(vehicle) + 0.25)
            DisableControlAction(0, 75, true)
        end
    end)
end

local function setPlayerInVehicle(vehicle)
    lastLocation = GetEntityCoords(PlayerPedId()) 
    lastHeading = GetEntityHeading(PlayerPedId())
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    FreezeEntityPosition(vehicle, true)
end

local function stopPreview() 
    if lastLocation then SetEntityCoords(PlayerPedId(), lastLocation.x, lastLocation.y, lastLocation.z - 1, true, false, false, false) end
    if lastHeading then SetEntityHeading(PlayerPedId(), lastHeading) end
    lastLocation = nil
    lastHeading = nil
    ESX.Game.DeleteVehicle(currentVehicle)
    currentVehicle = nil
    isVehicleRotating = false
end

local function verifyVehicleModel(model)
    RequestModel(GetHashKey(model))
    local loadedFor = 0
    while not HasModelLoaded(GetHashKey(model)) do
        Citizen.Wait(10)
        loadedFor = loadedFor + 10
        if loadedFor > 5000 then return false end
    end
    return true
end


RegisterNetEvent("stem_dealership:stopPreview")
AddEventHandler("stem_dealership:stopPreview", function () 
    if (not currentVehicle) then return end

    DoScreenFadeOut(500)

    while IsScreenFadingOut() do
        Wait(50)
    end



    ESX.TriggerServerCallback("stem_dealership:clearBucket", function() 
        if (GetResourceState("wasabi_carlock") == "started") then wasabi_carlock:RemoveKey("TESTCAR") end
    
        stopPreview()

        DoScreenFadeIn()
    end)
end)

function testVehicle(model, testLocation, entity)
    if (currentVehicle) then
        ESX.Game.DeleteVehicle(currentVehicle)
    end

    DoScreenFadeOut(500)
    Wait(500)

    
    local vehicleProperties = entity and ESX.Game.GetVehicleProperties(entity) or nil

    ESX.TriggerServerCallback("stem_dealership:assignBucket", function()
        Wait(200)
        ESX.Game.SpawnLocalVehicle(model, testLocation, testLocation.w, function(vehicle)
            currentVehicle = vehicle

            lastLocation = GetEntityCoords(PlayerPedId()) 
            lastHeading = GetEntityHeading(PlayerPedId())

            Wait(150)

            if (vehicleProperties) then
                ESX.Game.SetVehicleProperties(vehicle, vehicleProperties)
            end


            SetVehicleHasBeenOwnedByPlayer(vehicle)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

            SetVehRadioStation(vehicle, "OFF")
            SetVehicleEngineOn(vehicle, true, true, false)
            SetVehicleNumberPlateText(vehicle, "TESTCAR")
            if (GetResourceState("wasabi_carlock") == "started") then wasabi_carlock:GiveKey("TESTCAR") end
            

            DoScreenFadeIn(500)

            while IsScreenFadingIn() do
                Wait(50)
            end

            ESX.ShowNotification('You have ' .. testLength .. ' minute to test')

            local endTestDrive = GetGameTimer() + 60000
            while GetGameTimer() < endTestDrive do
                ESX.ShowHelpNotification("Press ~INPUT_VEH_DUCK~ to stop the test drive.")
                if IsPedDeadOrDying(PlayerPedId(), 1) then
                    break
                end
                if (IsControlJustPressed(1, 73)) then
                    break
                end
                

                DisableControlAction(0, 75, true)
                Wait(0)
            end
            
            if (not currentVehicle) then return end
            
            TriggerEvent("stem_dealership:stopPreview")
        end)
    end)
end


local function previewVehicle(vehicleParameters)

    if (not currentStore) then return error("Invalid store location") end
    local previewLocation = currentStore.previewLocation

    
    DoScreenFadeOut(500)
    Citizen.Wait(500)

    ESX.TriggerServerCallback("stem_dealership:assignBucket", function() 
        ESX.Game.SpawnLocalVehicle(GetHashKey(vehicleParameters.model), vector3(previewLocation.x, previewLocation.y, previewLocation.z), 160, function(vehicle)
            currentVehicle = vehicle
            
            SetVehicleNumberPlateText(vehicle, "TESTCAR")
            
            
            if (GetResourceState("wasabi_carlock") == "started") then wasabi_carlock:GiveKey("TESTCAR") end
            

            setPlayerInVehicle(vehicle)
            setVehicleRotate(vehicle)

            
            local carCoords = GetEntityCoords(vehicle)
            SetGameplayCamRelativeHeading(previewLocation.w)
            SetGameplayCamRelativePitch(20)

            DoScreenFadeIn(500)
        end)
    end)
end

local function createPreviewMenu(vehicleParameters, veh) 
    local dragCoeff = ESX.Math.Round(GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff"), 2)
    local maxVel = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel")
    local topSpeed = ESX.Math.Round((maxVel * 0.82) * 1.1, 2)
    local gears = GetVehicleHandlingInt(veh, "CHandlingData", "nInitialDriveGears")
    local driveForce = ESX.Math.Round(GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce") * 1250, 0)
    local curbWeight = ESX.Math.Round(GetVehicleHandlingFloat(veh, "CHandlingData", "fMass") * 2.2, 2)
    local modkitType = GetVehicleModKitType(veh)

    ox_lib:registerContext({
        id = "preview:"..vehicleParameters.model,
        title = "Previewing: "..vehicleParameters.label.."",
        menu = vehicleParameters.model,
        onBack = function() TriggerEvent("stem_dealership:stopPreview") end;
        onExit = function() TriggerEvent("stem_dealership:stopPreview") end;
        options = exports.stem_common:tableFilter({
            {
                title = ("Top Speed: %s"):format(topSpeed)
            },
            GetEntityBoneIndexByName(veh, "boot") == -1 and {
                title = "NO WORKING TRUNK ON THIS VEHICLE"
            } or false,
            exports.stem_common:CanVehicleDriveby(veh) and {
                title = "Vehicle Drive-by Compatible"
            } or false,
            {
                title =  "Curb weight / Torque ",
                description = curbWeight .. "lb / " .. driveForce .. " lb-ft"
            },
            {
                title = "Transmission / Drag",
                description = gears .. "-speed / " .. dragCoeff
            }
        })
    })
end

local function registerLoading(model, label) 
    ox_lib:registerContext({
        id = "loading:"..model,
        title = "Loading **"..label.."**",
        menu = model,
        onBack = function() TriggerEvent("stem_dealership:stopPreview") end;
        onExit = function() TriggerEvent("stem_dealership:stopPreview") end;
        options = {
            {
                title = "Loading"
            }
        }
    })
end

function createVehicle(vehicleParameters, parentId, ucl)
    registerLoading(vehicleParameters.model, vehicleParameters.label)

    local options = exports.stem_common:tableFilter({  
        not ucl and {
            title = "Preview",
            onSelect = function ()
                previewVehicle(vehicleParameters)
                local showingMenu = false;
                while not currentVehicle do
                    if (not showingMenu) then ox_lib:showContext("loading:"..vehicleParameters.model); showingMenu = true end
                    Wait(100)
                end
                createPreviewMenu(vehicleParameters, currentVehicle)
                ox_lib:showContext("preview:"..vehicleParameters.model)
            end
        } or false,
        ucl and {
            title = "Seller Information",
            metadata = {
                {
                    label = "Seller Name",
                    value = ucl.seller.name
                },
                {
                    label = "Seller Phone",
                    value = ucl.seller.phone
                }
            }
        } or false,
        {
            title = "Test Vehicle",
            onSelect = function() 
                if (ucl) then
                    local entityId = NetworkGetEntityFromNetworkId(ucl.vehicle)
                    local v = GetEntityCoords(entityId)
                    return testVehicle(vehicleParameters.model, vector4(v.x, v.y, v.z - 1, GetEntityHeading(entityId)), entityId)
                end
                testVehicle(GetHashKey(vehicleParameters.model), currentStore.testLocation)
            end
        },
        {
            title = string.format("Purchase: %s", vehicleParameters.label),
            description = "for $"..exports.stem_common:formatPrice(vehicleParameters.price),
            onSelect = function() 
                if (ucl) then
                    local entityId = NetworkGetEntityFromNetworkId(ucl.vehicle)
                    return TriggerServerEvent("stem_dealership:buy_vehicle", vehicleParameters.model, ESX.Game.GetVehicleProperties(entityId),  GetMakeNameFromVehicleModel(vehicleParameters.model) or GetDisplayNameFromVehicleModel(vehicleParameters.model), ucl.id, uclZone and uclZone:isPointInside(GetEntityCoords(cache.ped)))
                end
                if (verifyVehicleModel(vehicleParameters.model)) then
                    local coords = GetEntityCoords(PlayerPedId())
                    ESX.Game.SpawnLocalVehicle(GetHashKey(vehicleParameters.model), vector3(coords.x, coords.y, 0), 0, function (vehicle) 
                        TriggerServerEvent("stem_dealership:buy_vehicle", vehicleParameters.model, ESX.Game.GetVehicleProperties(vehicle),  GetMakeNameFromVehicleModel(vehicleParameters.model) or GetDisplayNameFromVehicleModel(vehicleParameters.model))
                        SetEntityAsNoLongerNeeded(vehicle)
                        DeleteEntity(vehicle)
                    end)
                else
                    ESX.ShowNotification('~r~Error loading vehicle "' .. vehicleParameters.model .. '", unable to purchase')
                end
            end
        }
    })

    if (ucl) then
        return ox_lib:registerContext({
            id =  "ucl:"..ucl.vehicle,
            title = vehicleParameters.label,
            position = menuLocation,
            options = options
        }) 
    end

    ox_lib:registerContext({
        id =  vehicleParameters.model,
        title = vehicleParameters.label,
        position = menuLocation,
        menu = parentId,
        options = options
    }) 
    return {
        title = vehicleParameters.label .. " - $"..exports.stem_common:formatPrice(vehicleParameters.price),
        icon = "car",
        menu = vehicleParameters.model
    }
end

local function createCategory(categoryData, parentId)
    return {
        options = exports.stem_common:tableMap(categoryData, function (item)
            local sub = ""
            if (item.id) then sub = ":" .. item.id end
            local categoryId = parentId .. sub
            if (item.type ~= "category") then
                return createVehicle(item, categoryId)
            end

            local registeredCategory = createCategory(item.items, categoryId)

            ox_lib:registerContext({
                id = categoryId,
                menu = parentId,
                title = "Category: "..item.label,
                position = menuLocation,
                options = registeredCategory.options,
            })
            
            local categoryButton = {
                title = item.label, 
                icon = item.icon or "list",
                arrow = true,
                menu = categoryId,
            }
            


            if (item.color) then
                categoryButton.progress = type(item.progress) == "number" and item.progress or 100;
                categoryButton.colorScheme = item.color
            end

            return categoryButton
        end)
    }
end

local dealerships = {}
function createDealership(type)
    if (dealerships[type]) then return end
    local dealership = exports.stem_common:tableMap(Config.shop[type], function (item) 
        if (item.type == "category" and item.id == "supporter") then
            if (#LocalPlayer.state.supporterAccess > 0) then
                item.progress = 100
            else 
                item.progress = 0
            end
            item.items =  exports.stem_common:tableFilter(exports.stem_common:tableMap(item.items, function (item) 
                item.items = filterDealership(Config.shop[type], "supporter", item.id)
                
                if (LocalPlayer.state.supporterAccess and exports.stem_common:tableContains(LocalPlayer.state.supporterAccess, item.id)) then
                    item.progress = 100
                else 
                    item.progress = 0
                end

                if (#item.items > 0) then
                    return item
                end
                return false
            end))
        else
            item.items = filterDealership(item.items, "supporter", nil)
        end
        return item
    end)
    
    local registeredMenu = createCategory(dealership, "stem_dealership:"..type)

    ox_lib:registerContext({
        id = "stem_dealership:"..type,
        title = "Dealership",
        position = menuLocation,
        options = registeredMenu.options,
        onSelected = registeredMenu.select,
    })
    dealerships[type] = true
end

local concierePeds = {};

Citizen.CreateThread(function() 
    while not LocalPlayer.state.discordRolesLoaded do
        Wait(100)
    end
    for index, store in pairs(Config.stores) do
        if (not store.id) then error('no id set for "'..store.label or "Invalid Label"..'"') end
        createDealership(store.type)
        
        local conciereLocation = store.conciere.location
        local conciereModel = store.conciere.model
        local conciereAnimation = store.conciere.animation
        if (not concierePeds[store.id]) then
            
            
            RequestModel(GetHashKey(conciereModel))
            while not HasModelLoaded(GetHashKey(conciereModel)) do
                Citizen.Wait(1)
            end
    
            concierePeds[store.id] = CreatePed(5, GetHashKey(conciereModel), conciereLocation.x, conciereLocation.y,conciereLocation.z, conciereLocation.w, false, false)

            while not DoesEntityExist(concierePeds[store.id]) do
                Citizen.Wait(50)
            end
    
            FreezeEntityPosition(concierePeds[store.id], true)
            SetEntityInvincible(concierePeds[store.id], true)
    
            
            RequestAnimDict(conciereAnimation.dict)
            while not HasAnimDictLoaded(conciereAnimation.dict) do
                Citizen.Wait(1)
            end

            TaskPlayAnim(concierePeds[store.id], conciereAnimation.dict, conciereAnimation.name, -1, 0, -1, 1, 0, 0, 0)
            TaskStartScenarioInPlace(concierePeds[store.id], scenario, 0, true) -- begins peds animation
            SetBlockingOfNonTemporaryEvents(concierePeds[store.id], true)

            Citizen.Wait(50)

            local entityLocation = GetPedBoneCoords(concierePeds[store.id], 0x8B93, 0,0,0)
            
            ox_target:addBoxZone({
                coords = entityLocation,
                size = vector3(1, 1, 1),
                rotation = GetEntityRotation(concierePeds[store.id]),
                options = {
                    {
                        event = 'stem_dealership:open',
                        icon = 'fa-solid fa-basket-shopping',
                        label = "Open Dealership",
                        onSelect = function() 
                            currentStore = store
                            local supporterLevel = LocalPlayer.state.supporterAccess and #LocalPlayer.state.supporterAccess or 0
                            if (currentSupporterAccess ~= supporterLevel) then
                                createDealership(store.type) 
                            end
                            currentSupporterAccess = supporterLevel
                            ox_lib:showContext("stem_dealership:"..store.type)
                        end,
                        distance = 3,
                    },
                },
            })

        end
    end
end)



Citizen.CreateThread(function()
    for index, store in pairs(Config.stores) do
        local blip = AddBlipForCoord(store.conciere.location.x, store.conciere.location.y)
        SetBlipSprite(blip, store.blip?.sprite or dealershipBlip.sprite)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(store.label)
        EndTextCommandSetBlipName(blip)
        storeBlips[store.id] = blip
    end
end)


RegisterNetEvent("stem_dealership:spawn_vehicle")
AddEventHandler("stem_dealership:spawn_vehicle", function(model, plate, properties) 
    ESX.Game.SpawnVehicle(model, currentStore.purchasePoint, 10.0, function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, properties)

        SetVehicleNumberPlateText(vehicle, plate)
        if (GetResourceState("wasabi_carlock") == "started") then wasabi_carlock:GiveKey(plate) end
        
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        ESX.Game.DeleteVehicle(currentVehicle)
    end)
end)

AddEventHandler("onResourceStop", function (resourceName) 
    if (GetCurrentResourceName() == resourceName) then
        for key, store in pairs(Config.stores) do    
            if (concierePeds[store.id]) then
                DeletePed(concierePeds[store.id])
                ox_target:removeEntity(concierePeds[store.id])
            end
            if (storeBlips[store.id]) then RemoveBlip(storeBlips[store.id]) end

            if (store.disabledVehicleGenerationArea and #store.disabledVehicleGenerationArea == 2) then
                local l1, l2 = table.unpack(store.disabledVehicleGenerationArea)
                RemoveVehiclesFromGeneratorsInArea(l1.x, l1.y, l1.z, l2.x, l2.y, l2.z)
            end
        end
        if (currentVehicle) then 
            stopPreview()
        end
    end
end)

ESX.RegisterClientCallback("stem-dealership:spawnTemporaryCar", function (cb, model, plate)
    local playerCoords = GetEntityCoords(PlayerPedId())
    ESX.Game.SpawnLocalVehicle(GetHashKey(model), vector3(playerCoords.x, playerCoords.y, playerCoords.z - 10), 0, function (vehicle) 
        SetVehicleNumberPlateText(plate)
        cb(NetworkGetNetworkIdFromEntity(vehicle), ESX.Game.GetVehicleProperties(vehicle), lib.getVehicleProperties(vehicle),  GetMakeNameFromVehicleModel(model) or GetDisplayNameFromVehicleModel(model))
        SetEntityAsNoLongerNeeded(vehicle)
        DeleteEntity(vehicle)
    end)
end)