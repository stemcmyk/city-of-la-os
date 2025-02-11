OpenBuyMenu = function(house)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id, {
        title    = Locales[Config.Locale]['house_menu'] .. " #" .. house.id,
        align = 'bottom-right',
        elements = {
            {label = Locales[Config.Locale]['house_info'], value = 'house_info'},
            {label = Locales[Config.Locale]['buy_house'] .. house.data.price .. "$", value = 'buy_house'}
    }}, function(data, menu)
        menu.close()

        if data.current.value == 'house_info' then
            ESX.ShowNotification("<b>" .. Locales[Config.Locale]['view_house_info_menu'] .. "</b><br>" .. Locales[Config.Locale]["house_id_menu"] .. "<i> #" .. house.id .. "</i><br>" .. Locales[Config.Locale]['house_price_menu'] .. "<i>" .. house.data.price .. "$</i><br>" .. Locales[Config.Locale]["interior_menu"] .. "<i>" .. house.data.prop .. "</i>", 5000)
        elseif data.current.value == 'buy_house' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id, {
                title    = Locales[Config.Locale]['about_to_buy_house_menu'] .. " #" .. house.id,
                align = 'bottom-right',
                elements = {
                    {label = Locales[Config.Locale]['no'], value = 'no'},
                    {label = Locales[Config.Locale]['yes'], value = 'yes'},
                }}, function(data2, menu2)
                    menu2.close()
                    if data2.current.value == "yes" then
                        if houses_owned >= Config.MaxHousesperUser then
                            ESX.ShowNotification(Locales[Config.Locale]['exceeded_house'])
                        else
                            ESX.TriggerServerCallback('esx_housing:BuyHouse', function(result)
                                -- Attempt to buy house
                                xPlayer = ESX.GetPlayerData()
                                if result then
                                    ESX.ShowNotification(Locales[Config.Locale]["bought_house"] .. " #" .. house.id .. "<br>por valor de " .. house.data.price .. "$")
                                    Houses[house.id].owner = xPlayer.identifier
                                    Houses[house.id].owned = true
                                    NewBlip(Houses[house.id].doorpos, Houses[house.id].id, true)
                                    houses_owned = houses_owned + 1
                                    InsideHouse(Houses[house.id], Houses[house.id].doorpos)
                                end
                            end, house.id)
                        end
                    end
                end, function(data, menu)
                    menu.close()
                end)
        end
    end, function(data, menu)
        menu.close()
    end)
end


BeginSetGarage = function(house)
    local isSettingGarage = true
    Citizen.CreateThread(function () 
        while isSettingGarage do
            if (GetInteriorFromEntity(PlayerPedId()) ~= 0) then
                ESX.ShowHelpNotification("Exit your house to set your garage.", true)
            else
                local distanceFromHouse = GetDistanceBetweenCoords(house.data.door.x, house.data.door.y, house.data.door.z, GetEntityCoords(PlayerPedId()))
                if (distanceFromHouse < 35) then
                    ESX.ShowHelpNotification("Press ~INPUT_DETONATE~ to set your garage.", true)
                    if (IsControlJustPressed(1, 47)) then
                        TriggerServerEvent("esx_housing:setGarage", house.id)
                        isSettingGarage = false
                    end
                else
                    ESX.ShowHelpNotification("You walked too far away from the door", isSettingGarage)
                end
            end
            Citizen.Wait(0)
        end
    end)
end

OpenAdminHouseMenu = function(house)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id .. "invmenu", {
        title    = Locales[Config.Locale]['house_menu'] .. " #" .. house.id,
        align = 'bottom-right',
        elements = {
            {label = Locales[Config.Locale]['view_invites'], value = 'view_invites'},
            -- {label = Locales[Config.Locale]['sell_house'] .. house.data.price * Config.ResellPrice .. "$", value = 'sell_house'},
            {label = Locales[Config.Locale]['keys_manager'], value = 'keys_manager'},
            {label = "Set garage", value = 'set_garage'}
    }}, function(data, menu)
        menu.close()
        if data.current.value == "sell_house" then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id, {
                title    = Locales[Config.Locale]['about_to_sell_house_menu'] .. " #" .. house.id,
                align = 'bottom-right',
                elements = {
                    {label = Locales[Config.Locale]['no'], value = 'no'},
                    {label = Locales[Config.Locale]['yes'], value = 'yes'},
                }}, function(data2, menu2)
                    menu2.close()
                    menu.close()
                    if data2.current.value == "yes" then
                        ESX.TriggerServerCallback("esx_housing:SellHouse", function(sell)
                            if sell then
                                houses_owned = houses_owned - 1
                                Houses[house.id].owned = false
                                Houses[house.id].storage = {}
                                Houses[house.id].keys = {}
                                Houses[house.id].owner = ""
                                Houses[house.id].money = 0
                                Houses[house.id].black_money = 0
                                house_inside = nil
                                for k,v in pairs(blips) do
                                    local coords = GetBlipCoords(v)
                                    if coords == Houses[house.id].doorpos then
                                        RemoveBlip(v)
                                        break
                                    end
                                end
                            end

                        end, house.id)
                    end
                end, function(data, menu)
                    menu.close()
                end)
        elseif data.current.value == "set_garage" then
            BeginSetGarage(house)
        elseif data.current.value == "view_invites" then
            ESX.TriggerServerCallback("esx_housing:GetInvites", function(members)
                member_list = {}
                for k,v in pairs(members) do
                    table.insert(member_list, {
                        label = v.name,
                        value = v.src
                    })
                end
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id, {
                    title    = Locales[Config.Locale]['house_menu'] .. " #" .. house.id,
                    align = 'bottom-right',
                    elements = member_list
                }, function(data, menu)
                    TriggerServerEvent('esx_housing:AcceptInvite', house.id, data.current.value)
                    ESX.ShowNotification(Locales[Config.Locale]["invite_accepted"] .. data.current.label)
                end, function(data, menu)
                    menu.close()
                end)
            end, house.id)
        elseif data.current.value == "keys_manager" then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id, {
                title    = Locales[Config.Locale]['house_menu'] .. " #" .. house.id,
                align = 'bottom-right',
                elements = {
                    {label = Locales[Config.Locale]['give_keys'] .. " " .. Config.KeyCreationPrice .. "$", value = 'give_keys'},
                    {label = Locales[Config.Locale]['reset_keys'] .. " " .. Config.KeyResetPrice .. "$", value = 'reset_keys'}
            }}, function(data, menu)
                menu.close()
                if data.current.value == "give_keys" then
                    if #Houses[house.id].keys <= Config.MaxKeysperHouse then
                        local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5)
                        local elements = {}
                        for k,v in pairs(players) do
                            id = GetPlayerServerId(v)
                            local name = GetPlayerName(v)
                            elements[k] = {value = id, label = name}
                        end
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id, {
                            title    = Locales[Config.Locale]['house_menu'] .. ' #' .. house.id,
                            align = 'bottom-right',
                            elements = elements
                        }, function(data, menu)
                            TriggerServerEvent('esx_housing:addKeys', house.id, data.current.value)
                            ESX.UI.Menu.CloseAll()
                        end, function(data, menu)
                            ESX.UI.Menu.CloseAll()
                        end)
                    end
                elseif data.current.value == "reset_keys" then
                    ESX.TriggerServerCallback("esx_housing:ResetKeys", function(reset)
                        if reset then
                            Houses[house.id].keys = {}
                            ESX.ShowNotification("You've paid " .. Config.KeyResetPrice .. "$ to remove all keys")
                        end

                    end, Houses[house.id].id)
                end
            end, function(data, menu)
                menu.close()
            end)

        end
    end, function(data, menu)
        menu.close()
    end)
end

OpenNormalHouseMenu = function(house)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_menu' .. house.id .. "invmenu", {
        title    = Locales[Config.Locale]['house_menu'] .. " #" .. house.id,
        align = 'bottom-right',
        elements = {
            {label = Locales[Config.Locale]['view_invites'], value = 'view_invites'},
    }}, function(data, menu)
    if data.current.value == "view_invites" then
        ESX.TriggerServerCallback("esx_housing:GetInvites", function(members)
        end, house.id)
    end

    end, function(data, menu)
        menu.close()
    end)
end


OpenArmoryMenu = function(house)
    
end


ActionMenu = function(data1, house, action)
    count = data1.current.quantity
    item = data1.current.item
    if data1.current.type == "item" then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'house_menu' .. house.id .. 'deposit_value', {
        title = Locales[Config.Locale]["how_much_money"],
        align = "middle",
        elements = ''
        }, function(data2, menu2)
            count = tonumber(data2.value)
            if count <= 0 or count == nil then
                ESX.ShowNotification(Locales[Config.Locale]["amount_invalid"])
            else
                if count <= data1.current.quantity then
                    ESX.UI.Menu.CloseAll()
                    if action == "deposit" then
                        TriggerServerEvent('esx_housing:addItem', data1.current.type, data1.current.name, count, data1.current.item, house.id)
                    elseif action == "withdraw" then
                        TriggerServerEvent('esx_housing:removeItem', data1.current.type, data1.current.name, count, data1.current.item, house.id)
                    end
                else
                    ESX.ShowNotification(Locales[Config.Locale]["amount_invalid"])
                end
            end
        end, function(data, menu)
            ESX.UI.Menu.CloseAll()

        end)
    elseif data1.current.type == "account" then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'house_menu' .. house.id .. 'deposit_value', {
            title = Locales[Config.Locale]["how_much_money"],
            align = "middle",
            elements = elements
            }, function(data2, menu2)
                count = tonumber(data2.value)
                if count <= 0 or count == nil then
                    ESX.ShowNotification(Locales[Config.Locale]["amount_invalid"])
                else
                    if count <= data1.current.quantity then
                        ESX.UI.Menu.CloseAll()
                        if action == "deposit" then
                            TriggerServerEvent('esx_housing:addItem', data1.current.type, data1.current.name, count, data1.current.item, house.id)
                        elseif action == "withdraw" then
                            TriggerServerEvent('esx_housing:removeItem', data1.current.type, data1.current.name, count, data1.current.item, house.id)
                        end
                        -- ESX.ShowNotification con el deposit
                    else
                        ESX.ShowNotification(Locales[Config.Locale]["amount_invalid"])
                    end
                end
            end, function(data, menu)
                ESX.UI.Menu.CloseAll()
            end)
    elseif data1.current.type == "weapon" then
        if action == "deposit" then
            TriggerServerEvent('esx_housing:addItem', data1.current.type, data1.current.name, count, data1.current.item, house.id)
        elseif action == "withdraw" then
            TriggerServerEvent('esx_housing:removeItem', data1.current.type, data1.current.name, count, data1.current.item, house.id)
        end
        ESX.UI.Menu.CloseAll()
    end
end

HouseMaker = function(cur_data)
    local options = {
        {label = Locales[Config.Locale]['interior_type'] .. cur_data["interior_type"], value = 'interior_type', data=cur_data["interior_type"]},
        cur_data["interior_type"] == "interior" and  {label = Locales[Config.Locale]['interior_position'] .. cur_data["interior_position"], value = 'interior_position', data=cur_data["interior_position"]} or false,
        cur_data["interior_type"] == "interior" and  {label = Locales[Config.Locale]['storage_position'] .. cur_data["storage_position"], value = 'storage_position', data=cur_data["storage_position"]} or false,
        {label = Locales[Config.Locale]['door_position'] .. cur_data["door_coords"], value = 'door_coords', data=cur_data["door_coords"]},
        {label = Locales[Config.Locale]['house_price'] .. cur_data["house_price"], value = 'house_price', data=cur_data["house_price"]},
        {label = Locales[Config.Locale]['create_house'], value = 'create_house'},
        }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_builder', {
        title = Locales[Config.Locale]["house_builder"],
        align = "bottom-right",
        elements = exports.stem_common:tableFilter(options)
    }, function(data, menu)
            if data.current.value == "interior_type" then
                elements = {}
                for k,v in pairs(Config.Points) do
                    table.insert(elements, {label=k, value=k})
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'house_builder_int', {
                    title = Locales[Config.Locale]["house_builder"],
                    align = "bottom-right",
                    elements = elements
                    }, function(data2, menu2)
                        cur_data["interior_type"] = data2.current.value
                        menu.close()
                        menu2.close()
                        HouseMaker(cur_data)

                    end, function(data2, menu2)
                        menu2.close()
                    end)

            elseif data.current.value == "door_coords" then
                local coords = GetEntityCoords(PlayerPedId())
                local coords = vector3(coords.x, coords.y, coords.z)
                current_data["door_coords"] = coords
                menu.close()
                HouseMaker(cur_data)
            
            
            elseif data.current.value == "interior_position" then
                local coords = GetEntityCoords(PlayerPedId())
                local coords = vector3(coords.x, coords.y, coords.z)
                current_data["interior_position"] = coords
                menu.close()
                HouseMaker(cur_data)
                
            elseif data.current.value == "storage_position" then
                local coords = GetEntityCoords(PlayerPedId())
                local coords = vector3(coords.x, coords.y, coords.z)
                current_data["storage_position"] = coords
                menu.close()
                HouseMaker(cur_data)

            elseif data.current.value == "house_price" then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'house_builder_price', {
                    title = Locales[Config.Locale]["how_much_money"],
                    align = "middle",
                    elements = elements
                    }, function(data2, menu2)
                        cur_data["house_price"] = tonumber(data2.value)
                        menu.close()
                        menu2.close()
                        HouseMaker(cur_data)
                    end, function(data2, menu2)
                        menu2.close()
                end)

            elseif data.current.value == "create_house" then
                -- for k,v in pairs(cur_data) do
                --     if v == (nil or '' or "") then
                --         HouseMaker(cur_data)
                --         miss = k
                --         ESX.ShowNotification("Parameter " .. miss .. " is missing, re-check ")
                --         return
                --     end
                -- end
                menu.close()
                ESX.TriggerServerCallback("esx_housing:NewHouse", function(data)
                    if data then
                        ESX.ShowNotification(Locales[Config.Locale]["house_created"] .. "ID" .. data.id .. "<br>" .. Locales[Config.Locale]["house_price_menu"] .. data.data.price .. "$")
                    end
                end, cur_data)
            end
    end)
end