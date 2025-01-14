PhoneObjects = {}
StreetDealers = {}

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for key, value in pairs(PhoneObjects) do
            DeleteEntity(value.obj)
            exports.ox_target:removeZone(value.zone)
        end
    end
end)

CreateThread(function()
    while not LocalPlayer.state.switchComplete do
        Wait(0)
    end

    local plyPed = PlayerPedId()
    local dict = "ANIM@SCRIPTED@PAYPHONE_HITS@MALE@"
    RequestAnimDict(dict)

    for index, value in pairs(Config.Phones) do
        RequestModel(`sf_prop_sf_phonebox_01b_s`)
        while not HasModelLoaded(`sf_prop_sf_phonebox_01b_s`) do
            Wait(0)
        end

        local obj = CreateObject(`sf_prop_sf_phonebox_01b_s`, value.xyz, false, false, true)

        SetEntityCoords(obj, value.xyz, true, false, false, true)
        SetEntityHeading(obj, value.w)
        SetEntityInvincible(obj, true)
        -- SetEntityCompletelyDisableCollision(obj, false, false)
        FreezeEntityPosition(obj, true)

        local blip = AddBlipForCoord(value.xyz)
        SetBlipSprite(blip, 817)
        SetBlipScale(blip, 0.6)
        SetBlipDisplay(blip, 5)
        SetBlipAsShortRange(blip, true)

        local zone = exports.ox_target:addBoxZone({
            coords = vector3(value.x, value.y, value.z + 1),
            rotation = value.w,
            size = vector3(1, 1, 2),
            options = {{
                label = "Use Payphone",
                icon = "fa-solid fa-phone",
                distance = 2,
                canInteract = function ()
                    return not Config.PhoneState[index]
                end,
                onSelect = function ()
                    LocalPlayer.state.blockClearTasks = true
                    TriggerServerEvent('noire_payphones:syncState', index, true)
                    local phoneObj = GetClosestObjectOfType(value.xyz, 2.0, `sf_prop_sf_phonebox_01b_s`,
                        false, false, false)
    
                    local scene = NetworkCreateSynchronisedScene(value.xyz, 0, 0, value.w, 2,
                        false, false, 1065353216, 0, 1065353216)
                    NetworkAddPedToSynchronisedScene(plyPed, scene, dict, 'FXFR_PTD_1_INTRO_MALE', 1.5, -4.0, 13, 16,
                        1000.0, 0)
                    TriggerServerEvent('noire_payphones:syncScene', index, 'enter_phone')
                    NetworkStartSynchronisedScene(scene)
    
                    Wait(2000)
    
                    scene = NetworkCreateSynchronisedScene(value.xyz, 0, 0, value.w, 2,
                        false, false, 1065353216, 0, 1065353216)
                    NetworkAddPedToSynchronisedScene(plyPed, scene, dict, 'idle_02_male', 1.5, -4.0, 13, 16,
                        1000.0, 0)
                    TriggerServerEvent('stem_payphones:syncScene', index, 'idle_02_phone')
                    NetworkStartSynchronisedScene(scene)
    
                    if exports.ox_inventory:GetItemCount('sticky_note') > 0 then
                        Wait(2500)
                        TriggerServerEvent('stem_payphones:contactDealer')
                    else
                        local input = exports['stem_common']:OpenPayphoneInputMenu()
                    end
    
                    scene = NetworkCreateSynchronisedScene(value.xyz, 0, 0, value.w, 2,
                        false, false, 1065353216, 0, 1065353216)
                    NetworkAddPedToSynchronisedScene(plyPed, scene, dict, 'exit_left_male', 1.5, -4.0, 13, 16,
                        1000.0, 0)
                    TriggerServerEvent('stem_payphones:syncScene', index, 'exit_left_phone')
                    NetworkStartSynchronisedScene(scene)
    
                    Wait(4000)
                    ClearPedTasks(plyPed)
                    TriggerServerEvent('stem_payphones:syncState', index, false)
    
                    LocalPlayer.state.blockClearTasks = nil 
                end
            }}
        })
        
        PhoneObjects[index] = {
            object = obj,
            zone = zone
        }
    end
end)

RegisterNetEvent('stem_payphones:syncScene', function(index, anim)
    local obj = GetClosestObjectOfType(Config.Phones[index].xyz, 2.0, `sf_prop_sf_phonebox_01b_s`, false, false, false)
    if not DoesEntityExist(obj) then
        return
    end

    local dict = "ANIM@SCRIPTED@PAYPHONE_HITS@MALE@"

    local scene = CreateSynchronizedScene(Config.Phones[index].xyz, 0, 0, Config.Phones[index].w, 2)
    PlaySynchronizedEntityAnim(obj, scene, anim, dict, 1000.0, -1000.0, 0, 1000.0)
    ForceEntityAiAndAnimationUpdate(obj)
    NetworkStartSynchronisedScene(scene)
end)

RegisterNetEvent('stem_payphones:syncState', function(index, value)
    Config.PhoneState[index] = value
end)

RegisterNetEvent('stem_payphones:streetDealerOpenMenu', function(pedNet)
    function createConfirmationDialog(data) 
        local response = lib.alertDialog({
            header = data.header,
            content = data.description,
            centered = true,
            cancel = true,
        })
        if (response == "cancel") then return data.onCancel() end;
        if (response == "confirm") then return data.onConfirm() end;
    end

    lib.registerContext({
        id = "streetdealer:intel",
        title = "Contact",
        menu = "streetdealer",
        options = {
            GlobalState.GunVanIntelPrice and {
                title = "Buy Gun Van Intel",
                description = string.format("Price: **$%s**", ESX.Math.GroupDigits(GlobalState.GunVanIntelPrice)),
                onSelect = function () 
                    createConfirmationDialog({
                        header = "Are you sure?",
                        description = string.format("Are you sure you want to purchase Gun Van intel for **%s** Dirty Money? You will not be able to use the dealer again.", ESX.Math.GroupDigits(GlobalState.GunVanIntelPrice)),
                        onConfirm = function()
                            ESX.TriggerServerCallback("stem_payphones:purchaseGunVanIntel", function (ok, total, required)
                                if (ok == "no_funds") then
                                    return lib.notify({
                                        type = "error",
                                        title = "You do not have enough Dirty Cash for this.",
                                        description = string.format("This purchase is **$%s**, you have **$%s**", ESX.Math.GroupDigits(total), ESX.Math.GroupDigits(required)),
                                    })
                                end 
                                lib.hideContext()
                            end, pedNet)
                        end,
                        onCancel = function()
                            lib.showContext("streetdealer:intel")
                        end
                    })
                end
            },
            Config.ArmoredTruckIntelPrice and {
                title = "Buy Gruppe6 Intel",
                description = string.format("Price: **$%s**", ESX.Math.GroupDigits(Config.ArmoredTruckIntelPrice)),
            }
        }
    })

    lib.registerContext({
        id = "streetdealer",
        title = "Street Dealer",
        options = {{
            title = "Intel",
            description = "Purchase intel with dirty cash.",
            menu = "streetdealer:intel"
        }}
    })

    lib.showContext("streetdealer")

    -- if GlobalState.INTEL_COST_ASSASSINATION_HIT then
    --     local item = NativeUI.CreateItem('Assassination Hit',
    --         'Pay an fixed amount of dirty cash to have someone killed without direct involvement.')

    --     item:RightLabel('$' .. GlobalState.INTEL_COST_ASSASSINATION_HIT)
    --     menu:AddItem(item)
    -- end

    -- menu.OnItemSelect = function(sender, item, index)
    --     if index == 1 then
    --         local inputData = exports['noire_nui']:OpenPlaceAssassinationMenu()
    --         SetControlNormal(0, 177, 1.0)
    --         if inputData then
    --             TriggerServerEvent('assassinations:placeHit', inputData[1], inputData[2])
    --         end
    --     end
    -- end
    
    -- FENCE GOODS
    local sellMenu = nil
    if GlobalState.PawnShop then
        sellMenu = menuPool:AddSubMenu(menu, 'Fence Goods',
            'Sell legal items obtained through illegal or questionable means.')

        for itemName, itemData in pairs(GlobalState.PawnShop) do
            local count = exports.ox_inventory:GetItemCount(itemName)
            local item = NativeUI.CreateItem(itemData.label .. string.format(' (%d/%d)', itemData.sold, itemData.max),
                'Sell ' .. count .. ' ' .. itemData.label .. ' for $' .. itemData.price .. ' each.')

            item.name = itemName
            item:RightLabel('$' .. itemData.price)
            sellMenu:AddItem(item)
        end

        sellMenu.OnItemSelect = function(_, item)
            if exports.ox_inventory:GetItemCount(item.name) > 0 then
                TriggerServerEvent('noire-contacts:fenceItem', item.name)
            else
                ESX.ShowNotification('You do not have any items to sell.')
            end
        end
    end

    LocalPlayer.state:set('interactingPed', pedNet, true)

    -- CreateThread(
    --     function()
    --         LocalPlayer.state.invBusy = true
    --         LocalPlayer.state.blockClearTasks = true
    --         ClearPedTasksImmediately(PlayerPedId())
    --         FreezeEntityPosition(PlayerPedId(), true)

    --         while true do
    --             if IsDisabledControlJustReleased(0, 177) or IsDisabledControlJustReleased(1, 177) or IsDisabledControlJustReleased(2, 177) or
    --                 IsDisabledControlJustReleased(0, 199) or IsDisabledControlJustReleased(1, 199) or IsDisabledControlJustReleased(2, 199) then
    --                 break
    --             end

    --             Wait(0)

    --             DisableControlAction(0, 30, true)
    --             DisableControlAction(0, 31, true)
    --             DisableControlAction(0, 32, true)
    --             DisableControlAction(0, 33, true)
    --             DisableControlAction(0, 34, true)
    --             DisableControlAction(0, 35, true)
    --             DisableControlAction(0, 36, true)

    --             menuPool:ProcessMenus()
    --             menuPool:MouseControlsEnabled(false)
    --             menuPool:MouseEdgeEnabled(false)
    --             menuPool:ControlDisablingEnabled(false)
    --         end

    --         bVisible = false
    --         FreezeEntityPosition(PlayerPedId(), false)
    --         LocalPlayer.state.invBusy = false
    --         LocalPlayer.state.blockClearTasks = nil
    --         LocalPlayer.state:set('interactingPed', nil, true)

    --         intelMenu:Clear()
    --         if sellMenu then
    --             sellMenu:Clear()
    --         end

    --         menu:Visible(false)
    --     end
    -- )
end)

RegisterNetEvent('stem_payphones:streetDealerSuccess', function(msg)
    if msg then ESX.ShowNotification(msg) end
    PlaySoundFrontend(-1, 'LOCAL_PLYR_CASH_COUNTER_INCREASE', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', 0)
    SetControlNormal(0, 177, 1.0)
end)


AddStateBagChangeHandler('streetDealer', nil, function(bagName, key, value, _reserved, replicated)
    local niDealerPed = bagName:gsub('entity:', '')
    niDealerPed = tonumber(niDealerPed)

    while not NetworkDoesEntityExistWithNetworkId(niDealerPed) do
        Wait(0)
    end

    local ped = NetToPed(niDealerPed)
    if IsPedAPlayer(ped) or IsEntityDead(ped) then
        return
    end

    local coords = GetEntityCoords(ped)
    while not HasCollisionLoadedAroundEntity(ped) do
        Wait(0)
    end

    if value then
        ClearAreaLeaveVehicleHealth(GetEntityCoords(ped), 25.0, false, false, false, false)

        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)

        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetPedCanRagdoll(ped, false)

        SetPedCanBeTargetted(ped, false)

        ClearPedTasks(ped)
        -- FreezeEntityPosition(ped, true)

        if NetworkHasControlOfEntity(ped) then
            SetPedConfigFlag(ped, 185, true)
            SetPedConfigFlag(ped, 108, true)
            SetPedConfigFlag(ped, 106, true)
            SetPedConfigFlag(ped, 188, true)
            SetPedConfigFlag(ped, 294, true)
            SetPedConfigFlag(ped, 456, true)
            SetPedConfigFlag(ped, 208, true)

            if not IsPedUsingScenario(ped, value.scenario) then
                TaskStartScenarioInPlace(ped, value.scenario, 0, false)
            end
        end

        if value.source == GetPlayerServerId(PlayerId()) then
            StreetDealers.zone = exports.ox_target:addBoxZone({
                coords = GetEntityCoords(ped),
                rotation = GetEntityHeading(ped),
                size = vector3(1, 1, 2.5),
                options = {{
                    label = "Talk to dealer",
                    icon = "fa-solid fa-person",
                    distance = 2,
                    onSelect = function ()
                        TriggerEvent("stem_payphones:streetDealerOpenMenu", PedToNet(ped))
                    end 
                }}
            })
        end
    else
        ClearPedTasks(ped)
        SetBlockingOfNonTemporaryEvents(ped, false)
        FreezeEntityPosition(ped, false)
        TaskWanderStandard(ped, 10.0, 10)

        if StreetDealers.blip and DoesBlipExist(StreetDealers.blip) then
            RemoveBlip(StreetDealers.blip)
            StreetDealers.blip = nil
            exports.ox_target:removeZone(StreetDealers.zone)
        end
    end
end)

RegisterNetEvent('stem_payphones:streetDealerBlip', function(coords)
    local blip = AddBlipForCoord(coords)
    StreetDealers.blip = blip
    SetBlipSprite(blip, 47)
    SetBlipColour(blip, 29)
    SetBlipPriority(blip, 9)
    -- SetBlipDisplay(blip, 5)
    SetBlipFlashes(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Contact")
    EndTextCommandSetBlipName(blip)

    SetTimeout(600000, function()
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end)
