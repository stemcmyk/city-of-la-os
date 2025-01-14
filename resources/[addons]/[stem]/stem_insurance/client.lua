Citizen.CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(0)
        end



        local pedModel = GetHashKey(Config.InsuranceOffice.pedModel)
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(0)
        end

        local ped = CreatePed(4, pedModel, Config.InsuranceOffice.pedLocation, false, false)
        SetEntityAsMissionEntity(ped, true, true)
        SetPedHearingRange(ped, 0.0)
        SetPedSeeingRange(ped, 0.0)
        SetPedAlertness(ped, 0.0)
        SetPedFleeAttributes(ped, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCombatAttributes(ped, 46, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        while not DoesEntityExist(ped) do
            Wait(1000)
        end

        exports.ox_target:addLocalEntity(ped, {
            {
                label = Config.Name,
                icon = "fa-solid fa-clipboard-list",
                onSelect = function()
                    OpenInsuranceMenu()
                end,
                distance = 2,
            }
        })

    

        local blip = AddBlipForCoord(Config.InsuranceOffice.pedLocation)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipColour(blip, Config.Blip.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Name)
        EndTextCommandSetBlipName(blip)
        

        local _threadCreated = false

        function CheckPlayerInsideInsurance()
            if _threadCreated then
                return
            end

            _threadCreated = true
            Citizen.CreateThread(
                function()
                    local int = GetInteriorFromEntity(ped)
                    while GetInteriorFromEntity(PlayerPedId()) == int do
                        Wait(0)
                    end

                    lib.hideContext()
                    _threadCreated = false
                end
            )
        end

        function OpenBuyMenu(plate, insurance, model)
            local elements = {}
            local insLabel = nil

            local insurancePrice = Config.InsurancePrices[GetVehicleClassFromName(model)] or Config.DefaultInsurancePrice;
            local recoverPrice = insurancePrice * Config.RecoverMultiplier  
            

            if not insurance then
                insLabel = "UNINSURED"
                table.insert(elements, {title = "Buy Insurance Policy", description = string.format("Price: **$%s**", ESX.Math.GroupDigits(insurancePrice)), onSelect = function ()
                    ESX.TriggerServerCallback(
                        "stem_insurance:updateVehStatus",
                        function()
                            OpenInsuranceMenu()
                        end,
                        plate,
                        1
                    )
                end})
            else
                insLabel = "INSURED"
                table.insert(elements, {title = "Cancel Insurance Policy", onSelect = function () 
                    ESX.TriggerServerCallback(
                        "stem_insurance:updateVehStatus",
                        function()
                            OpenInsuranceMenu()
                        end,
                        plate,
                        0
                    )
                end})
                table.insert(elements, {title = "Recover Vehicle", description = string.format("Price: **$%s**", ESX.Math.GroupDigits(recoverPrice)), onSelect = function () 
                    ESX.TriggerServerCallback(
                        "stem_insurance:recoverVehicle",
                        function(result)
                            if type(result) == "string" then
                                if result == "already_recovered" then
                                    ESX.ShowNotification(Config.Locale.already_recovered)
                                elseif result == "already_out" then
                                    ESX.ShowNotification(Config.Locale.already_out)
                                elseif result == "already_garage" then
                                    ESX.ShowNotification(Config.Locale.already_garage)
                                elseif result == "impounded" then
                                    ESX.ShowNotification(Config.Locale.impounded, "error")
                                end
                            elseif type(result) == "boolean" and result == true then
                                ESX.ShowNotification(Config.Locale.success, "success")
                            end
                        end,
                        plate
                    )
                end})
            end

            CheckPlayerInsideInsurance()

            lib.registerContext({
                id = "insurance:"..plate,
                title = string.format("%s - **%s**", plate, insLabel),
                options = elements,
                menu = "insurance"
            })

            lib.showContext("insurance:"..plate)
        end

        function OpenInsuranceMenu()
            ESX.TriggerServerCallback(
                "stem_insurance:fetchData",
                function(vehicles)
                    local elements = {}

                    for k, v in pairs(vehicles) do
                        local vehHash = json.decode(v.vehicle).model
                        local vehName = GetDisplayNameFromVehicleModel(vehHash)
                        local vehLabel = GetLabelText(vehName)

                        elements[#elements + 1] = {
                            title = (v.status ~= 0 and "(SEIZED) " or "") .. vehLabel .. ": " .. v.plate,
                            plate = v.plate,
                            onSelect = function() 
                                if (v.status ~= 0) then return lib.showContext("insurance") end
                                OpenBuyMenu(v.plate, v.insurance, vehHash)
                            end
                        }
                    end
                    lib.registerContext({
                        id = "insurance",
                        title = Config.Name,
                        options = elements
                    })

                    lib.showContext("insurance")

                    CheckPlayerInsideInsurance()
                end
            )
        end
    end
)

RegisterNetEvent("stem_insurance:receivePos")
AddEventHandler(
    "stem_insurance:receivePos",
    function(pos)
        SetWaypointOff()
        SetNewWaypoint(pos)
    end
)

ESX.RegisterClientCallback("stem_insurance:vehicles:getClassFromName", function (cb, model) 
    cb(GetVehicleClassFromName(model))
end)