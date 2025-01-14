local interiors = {}
local zones = {}
local loadedPublic = promise.new()

local DEBUG = false

function enterInterior(interior) 
    for index, value in ipairs(interiors) do
        if (interior == GetInteriorAtCoords(value.coords)) then
            TriggerServerEvent("stem_foodchains:fetchBusinesses", value.name)
        end
    end
end

RegisterNetEvent("stem_foodchains:setupPublic", function (businesses)
    for key, business in pairs(businesses) do
        table.insert(interiors, {coords = business.coords, name = business.name})

        local blip = AddBlipForCoord(business.coords)
        SetBlipSprite(blip, business.blip.Sprite)
        SetBlipColour(blip, business.blip.Color)
        SetBlipScale(blip, business.blip.Size)
        
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(business.blip.Name)
        EndTextCommandSetBlipName(blip)
    end
    loadedPublic:resolve()
end)

RegisterNetEvent("stem_foodchains:setupBusinesses", 
    --- func desc
    ---@param business Business
    function (business) 
        for key, value in pairs(business.inventories) do
            local zone = exports.ox_target:addSphereZone({
                coords = value.coords,
                radius = value.radius or 1,
                debug = DEBUG,
                options = {{
                    label = "Open "..value.name,
                    icon = value.icon,
                    onSelect = function (data) 
                        exports.ox_inventory:openInventory("stash", { id = value.stashId })
                    end,
                    distance = 2,
                    groups = { business.businessInformation.name } 
                }}
            })
            table.insert(zones, zone)
        end

        for key, value in pairs(business.registers) do
            local zone = exports.ox_target:addSphereZone({
                coords = value.coords,
                radius = 0.4,
                debug = DEBUG,
                options = {{
                    label = "Charge Player",
                    icon = "fas fa-cash-register",
                    onSelect = function (data) 
                        TriggerEvent("stem_common:payment_terminal:beginTerminal", nil, GetEntityCoords(data.entity), {
                            society = business.businessInformation.name,
                        })
                    end,
                    distance = 2,
                    groups = { business.businessInformation.name } 
                },}
            })
            table.insert(zones, zone)
        end
        
        for processId, process in pairs(business.processes) do
            local zone = exports.ox_target:addSphereZone({
                coords = process.coords,
                radius = process.radius or 0.4,
                debug = DEBUG,
                options = exports.stem_common:tableMap(process.options, function (option, index) 
                    return {
                        label = option.title or "anal",
                        icon = option.icon,
                        onSelect = function (data)
                            ESX.TriggerServerCallback("stem_foodchains:beginProcess", function (canDo)
                                if (not canDo or type(canDo) == "string") then
                                    return 
                                end
                                if (process.standCoords) then
                                    TaskGoStraightToCoord(PlayerPedId(), process.standCoords, -1, 0, 5, 0.05)
                                    Citizen.Wait(1000)
                                    SetEntityHeading(PlayerPedId(), process.standCoords.w)
                                    SetEntityCoords(PlayerPedId(), process.standCoords, true, true, true)
                                end

                                local removeEntityOnFinish;
                                Citizen.CreateThread(function() 
                                    while true do
                                        Citizen.Wait(0)
                                        for _, v in pairs(GetGamePool("CObject")) do
                                            if IsEntityAttachedToEntity(PlayerPedId(), v) then
                                                if (GetEntityModel(v) == -2013814998) then
                                                    removeEntityOnFinish = v
                                                    return 
                                                end
                                            end
                                        end
                                    end
                                end)
                                local progress = lib.progressCircle({
                                    duration = option.waitTime or 7000,
                                    label = option.progressLabel,
                                    anim = process.anim,
                                    canCancel = true,
                                    disable = {
                                        combat = true,
                                        move = true,
                                        car = true
                                    },
                                })
                                if (DoesEntityExist(removeEntityOnFinish)) then
                                    SetEntityAsMissionEntity(removeEntityOnFinish, true, true)
                                    DeleteObject(removeEntityOnFinish)
                                    DeleteEntity(removeEntityOnFinish)
                                end
                                
                                TriggerServerEvent("stem_foodchains:finishProcess", progress)
                            end, business.businessInformation.name, processId, index)
                        end,
                        distance = 2,
                        groups = { business.businessInformation.name } 
                    }
                end)
            })
            table.insert(zones, zone)
        end

        if (business.bossMenu) then
            local zone = exports.ox_target:addSphereZone({
                coords = business.bossMenu,
                radius = 0.4,
                debug = DEBUG,
                options = {{
                    label = "Open Boss Menu",
                    icon = "fas fa-clipboard",
                    onSelect = function (data) 
                        ClearPedTasksImmediately(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), true)
                        TriggerEvent(
                            "esx_society:openBossMenu",
                            business.businessInformation.name,
                            function(data, menu)
                                FreezeEntityPosition(PlayerPedId(), false)
                                menu.close()
                            end,
                            {
                                withdraw = true,
                                deposit = true,
                                checkbalance = true,
                                wash = false
                            }
                        )
                    end,
                    distance = 2,
                    groups = { [business.businessInformation.name] = 2 } 
                },}
            })
            table.insert(zones, zone)
        end
    end
)

Citizen.CreateThread(function () 
    TriggerServerEvent("stem_foodchains:clientAwake")
    Citizen.Await(loadedPublic)

    local inInterior = false

    while true do
        local currentInterior = GetInteriorFromEntity(PlayerPedId())

        if (not inInterior and currentInterior ~= 0) then
            enterInterior(currentInterior)
            inInterior = true
        end
        if (inInterior and currentInterior == 0) then
            for key, zone in pairs(zones) do
                exports.ox_target:removeZone(zone)
            end
            inInterior = false
        end

        Citizen.Wait(500)
    end
end)