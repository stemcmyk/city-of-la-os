local peds = {}
local blips = {}

function openVendor(vendor, location) 
    ESX.TriggerServerCallback("stem_standalone:vendors:getItems", function (items, vendorData) 
        local items = exports.stem_common:tableFilter(exports.stem_common:tableMap(items, function(item)
            if (item.groups and not exports.stem_common:tableContains(item.groups, ESX.PlayerData.job.name)) then

                return false
            end
            
            if (item.type == "sell") then
                local totalSale =  math.ceil(item.price * item.count)
                return {
                    title = "Sell " .. item.label,
                    description = string.format("**$%s** / each. %sx in inventory. **$%s** for all", ESX.Math.GroupDigits(item.price), item.count, ESX.Math.GroupDigits(totalSale)),
                    onSelect = function ( )
                        local input = lib.inputDialog("How many do you want to sell?", {{
                            label = "Amount",
                            type = "slider",
                            min = 1,
                            max = item.count,
                        }}, {
                            allowCancel = true
                        }) 
                        if (not input) then
                            return lib.showContext(vendor)
                        end

                        ESX.TriggerServerCallback("stem_standalone:vendors:sellItem", function (reopen) 
                            if (reopen) then
                                openVendor(vendor)
                            end
                        end, vendor, item.itemName, input[1], location)
                    end,
                } 
            end
            if (item.type == "buy") then
                return {
                    title = "Buy " .. item.label,
                    description = string.format("**$%s** / each", ESX.Math.GroupDigits(item.price)),
                    onSelect = function ( )
                        local input = lib.inputDialog("How many do you want to buy?", {{
                            label = "Amount",
                            type = "slider",
                            min = 1,
                            max = 20,
                        }}, {
                            allowCancel = true
                        })
                        if (not input) then
                            return lib.showContext(vendor)
                        end

                        ESX.TriggerServerCallback("stem_standalone:vendors:purchaseItem", function (reopen) 
                            if (reopen) then
                                openVendor(vendor)
                            end
                        end, vendor, item.itemName, input[1], location)
                    end,
                } 
            end
            print("no sll", json.encode(item))
            return false
        end))

        lib.registerContext({
            id = vendor,
            title = vendorData.name,
            options = #items > 0 and items or {
                {
                    title = "You don't have anything to buy or sell here"
                }
            }
        })
        lib.showContext(vendor)
    end, vendor)
end


Citizen.CreateThread(function () 
    while not NetworkIsSessionActive() do
        Wait(0)
    end
    
    if (LocalPlayer.state.spawnedVendors) then return end
    LocalPlayer.state.spawnedVendors = true

    for key, value in pairs(peds) do
        if (DoesEntityExist(value)) then DeleteEntity(value) end
    end
    for key, value in pairs(blips) do
        if (DoesBlipExist(value)) then RemoveBlip(value) end
    end

    for key, value in pairs(Config_vendors.vendors) do
        if (type(value.coords) ~= "vector4" and type(value.coords) ~= "table") then return print("Invalid coords for vendor", key) end
        local locations = type(value.coords) == "vector4" and {value.coords} or value.coords
        for key, coords in pairs(locations) do
            RequestModel(value.model)
        
            while not HasModelLoaded(value.model) do Wait(0) end
            local ped = CreatePed(5, value.model, coords.x, coords.y, coords.z, coords.w, false, true)
        
            FreezeEntityPosition(ped, true)
            SetPedHearingRange(ped, 100.0)
            SetPedSeeingRange(ped, 100.0)
            SetPedAlertness(ped, 3)
            SetPedFleeAttributes(ped, 0, 0)
            SetBlockingOfNonTemporaryEvents(ped, true)
            SetPedCombatAttributes(ped, 46, true)
            SetPedFleeAttributes(ped, 0, 0)
            SetEntityInvincible(ped, true)
            SetPedCanRagdoll(ped, false)
        
            exports.ox_target:addLocalEntity(ped, {
                {
                    label = "Open "..value.name,
                    icon = value.icon,
                    distance = 2,
                    onSelect = function () 
                        openVendor(value.id)
                    end
                }
            })
    
            table.insert(peds, ped)
    
            
            local blip = AddBlipForCoord(coords)
            SetBlipDisplay(blip, 4)
            SetBlipSprite(blip, value.blip.sprite)
            SetBlipColour(blip, value.blip.color)
            SetBlipScale(blip, value.blip.scale)
    
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(value.name)
            EndTextCommandSetBlipName(blip)
    
            table.insert(blips, blip)
        end
    end
end)

AddEventHandler("onResourceStop", function (resource)
    if (GetCurrentResourceName() ~= resource) then
        return
    end
    LocalPlayer.state.spawnedVendors = false

    for key, value in pairs(peds) do
        if (DoesEntityExist(value)) then DeleteEntity(value) end
    end
    for key, value in pairs(blips) do
        if (DoesBlipExist(value)) then RemoveBlip(value) end
    end
end)