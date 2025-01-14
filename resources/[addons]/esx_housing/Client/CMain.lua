
Houses = {}
loaded = promise.new()
spawned = promise.new()
blips = {}
view_blips = {}
local Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
    ['NENTER'] = 201, ['N4'] = 108, ['N5'] = 60, ['N6'] = 107, ['N+'] = 96, ['N-'] = 97, ['N7'] = 117, ['N8'] = 61, ['N9'] = 118
}


NewBlip = function(coords, id, owned)
    if owned then
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 40)
        SetBlipColour(blip, 5)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Locales[Config.Locale]['house_marker'] .. ' #' .. id)
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
    else
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 375)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Locales[Config.Locale]['house_marker'] .. ' #' .. id)
        EndTextCommandSetBlipName(blip)
        table.insert(view_blips, blip)
    end
end

function refreshHouses()
    ESX.TriggerServerCallback('esx_housing:ReceiveData', function(houses)
        houses_owned = 0
        for k,v in pairs(houses) do
            Houses[k] = CreateHouse(houses[k])
            Houses[k].owned = Houses[k].owner == ESX.PlayerData.identifier
            if Houses[k].owned then
                NewBlip(Houses[k].doorpos, Houses[k].id, true)
                houses_owned = houses_owned + 1
            end
        end
        
        Citizen.Await(spawned)
        loaded:resolve()
    end)
end

RegisterNetEvent("esx_housing:receiveData", function(houses) 
    houses_owned = 0
    for k,v in pairs(houses) do
        Houses[k] = CreateHouse(houses[k])
        Houses[k].owned = Houses[k].owner == ESX.PlayerData.identifier
        if Houses[k].owned then
            NewBlip(Houses[k].doorpos, Houses[k].id, true)
            houses_owned = houses_owned + 1
        end
    end
end)

RegisterNetEvent("esx:onPlayerSpawn", function () 
    spawned:resolve()
end)

RegisterNetEvent("esx:playerLoaded", function () 
    refreshHouses() 
end)

AddEventHandler("onResourceStart", function (resourceName) 
    if (resourceName ~= GetCurrentResourceName()) then
        return
    end
    refreshHouses() 
end)


InsideHouse = function(house_ins, last_coords)
    house_inside = house_ins
    if (house_ins.data.prop == "interior") then
        ESX.Game.Teleport(PlayerPedId(), house_ins.data.interior_position)
    else 
        ESX.Game.Teleport(PlayerPedId(), Config.Points[house_ins.data.prop].exit)
    end
    DoScreenFadeOut(0)
    Wait(300)
    DoScreenFadeIn(200)
    TriggerServerEvent('esx_housing:playerEnterHouse', house_ins.id)

    CreateThread(function()
        while house_inside do
            local coords = GetEntityCoords(PlayerPedId())
            Wait(0)
            if (house_ins.data.prop == "interior") then
                Config.Points[house_ins.data.prop] = {
                    storage = house_ins.data.storage_position,
                    exit = house_ins.data.interior_position
                }
            end
            
            for k,v in pairs(Config.Points[house_ins.data.prop]) do
                v = vector3(v.x, v.y, v.z)
                local distance = #(coords - v)
                if distance < 5 then
                    DrawMarker(Config.Marker.Type, v, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.Size.x, Config.Marker.Size.y, Config.Marker.Size.z, Config.Marker.Color.r, 255, Config.Marker.Color.b, 100, false, true, 2, false, false, false, false)
                    if distance < 1.5 then
                        if k == 'exit' then
                            ESX.ShowHelpNotification(Locales[Config.Locale]['exit_house'])
                            if IsControlJustPressed(0, 38) then
                                ESX.Game.Teleport(PlayerPedId(), last_coords)
                                TriggerServerEvent('esx_housing:playerExitHouse', house_ins.id)
                                house_inside = nil
                                DoScreenFadeOut(0)
                                Wait(300)
                                DoScreenFadeIn(200)
                            end
                        elseif k == 'storage' and (house_inside.hasKeys() or house_inside.owned) then
                            ESX.ShowHelpNotification(Locales[Config.Locale]['open_storage'])
                            if IsControlJustPressed(0, 38) then
                                exports.ox_inventory:openInventory('stash', string.format("playerhouse-%s", house_inside.id))
                            end
                        end
                    -- elseif distance > 1.5 then
                    --     if k == 'storage' then
                    --         local menu = ESX.UI.Menu.GetOpened('default', GetCurrentResourceName(), 'house_menu' .. house_inside.id .. 'invmenu')
                    --         if not menu then
                    --             ESX.UI.Menu.Close()
                    --         end
                    --     end
                    end
                end
            end


            -- Open House Menu
            if IsControlJustPressed(0, Keys[Config.OpenMenuKey]) then --F5
                if house_inside.owned then
                    OpenAdminHouseMenu(house_inside)
                else
                    OpenNormalHouseMenu(house_inside)
                end
            end
        end
        -- Close All Active Menus on Exit
        if not house_inside then
            ESX.UI.Menu.CloseAll()
        end
    end)
end
local hasRang = false

-- Draw Markers
CreateThread(function()
    Citizen.Await(loaded)
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        Wait(0)

        if house_active then
            if house_active.getdistance(coords) < Config.DrawDistance then
                DrawMarker(Config.Marker.Type, house_active.doorpos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.Size.x, Config.Marker.Size.y, Config.Marker.Size.z, Config.Marker.Color.r, 255, Config.Marker.Color.b, 100, false, true, 2, false, false, false, false)
                if Config.Debug and (Config.DebugLevel >= 1) then
                    print('House near to ' .. house_active.id .. ' price ' .. house_active.data.price .. '$' .. ' owner ' .. house_active.owner)
                end

                local distance = house_active.getdistance(coords)
                if distance < 1.5 then
                    if house_active.owned or house_active.hasKeys() then
                        ESX.ShowHelpNotification(Locales[Config.Locale]['enter_house'])
                        -- Enter to the house
                        if IsControlJustPressed(0,38) then
                            -- While inside house Thread
                            InsideHouse(house_active, house_active.doorpos)
                        end
                    elseif house_active.owner == ('' or "") or not house_active.owner then
                        -- Check Houses
                        ESX.ShowHelpNotification(Locales[Config.Locale]['view_house_info'])
                        if IsControlJustPressed(0, 38) then
                            OpenBuyMenu(house_active)
                        end
                    elseif house_active.owner ~= ('' or "") then
                        ESX.ShowHelpNotification(Locales[Config.Locale]['house_interaction'])
                        if IsControlJustPressed(0, 38) then
                            house_active.ring()
                            hasRang = true
                        end
                    end
                end
            else
                house_active = nil
                close = false
            end
        else 
            Wait(1000)
        end
    end
end)

-- Thread to get the closest house, running at same time than Draw Markers Thread, not running in single thread due to performance increase.
CreateThread(function()
    Citizen.Await(loaded)
    while true do
        Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Houses) do
            if not house_inside then
                if Houses[k].getdistance(coords) <= Config.DrawDistance then
                    if house_active and Houses[k].getdistance(coords) < house_active.getdistance(coords) then
                        if Config.Debug and (Config.DebugLevel >= 1) then
                            print('overwriting ' .. 'house id .. ' .. Houses[k].id .. 'due to being closer than  ' .. house_active.id .. ' Distance to new house: ' .. Houses[k].getdistance(coords) .. ' Distance to old house ' .. house_active.getdistance(coords))
                        end
                        house_active = Houses[k]

                    elseif not house_active then
                        house_active = Houses[k]
                    end

                    close = true
                end
            end
        end

        if not house_active then
            Wait(1000)
        else
            Wait(500)
        end
    end
end)

-- Inside House thread
CreateThread(function()
    Citizen.Await(loaded)
    local PlayerData = ESX.GetPlayerData()
    local identifier = PlayerData.identifier
    for k,v in pairs(Houses) do
        for d,f in pairs(Houses[k].extradata.instancedMembers) do
            if f.license == identifier then
                print("in house", identifier)
                if Config.SleepEnabled then
                    if Houses[k].owned then
                        InsideHouse(Houses[k], Houses[k].doorpos)
                        return
                    end

                    if Config.KickPlayersWithNoKeys then
                        for r,s in pairs(Houses[k].keys) do
                            if s == identifier then
                                InsideHouse(Houses[k], Houses[k].doorpos)
                                return
                            end
                        end
                        ESX.Game.Teleport(PlayerPedId(), Houses[k].doorpos)
                        TriggerServerEvent('esx_housing:playerExitHouse', Houses[k].id)
                    else
                        InsideHouse(Houses[k], Houses[k].doorpos)
                        return
                    end
                else
                    ESX.Game.Teleport(PlayerPedId(), Houses[k].doorpos)
                end
            end
        end
    end
end)

-- Events

RegisterNetEvent('esx_housing:Sync', function(house)
    Houses[house.id] = CreateHouse(house)
    if house_active and house_active.id == Houses[house.id].id then
        house_active = nil
    end
end)

RegisterNetEvent('esx_housing:Ring', function(src)
    ESX.ShowNotification(Locales[Config.Locale]['someone_ringing'])
    SendNUIMessage("a")
end)

RegisterNetEvent('esx_housing:enterHouse', function(house_id)
    local PlayerData = ESX.GetPlayerData()
    local identifier = PlayerData.identifier
    if Houses[house_id] then
        if Houses[house_id].owned then
            InsideHouse(Houses[house_id], Houses[house_id].doorpos)
            return
        end
        if (hasRang) then
            InsideHouse(Houses[house_id], Houses[house_id].doorpos)
        end

        for r,s in pairs(Houses[house_id].keys) do
            if s == identifier then
                InsideHouse(Houses[house_id], Houses[house_id].doorpos)
                return
            end
        end
    end
end)

RegisterNetEvent('esx_housing:leaveHouse', function()
    -- Event to kick players out of the house in case of sell
    ESX.Game.Teleport(PlayerPedId(), house_inside.doorpos)
    house_inside = nil
    house_ins = nil
end)

-- Commands
-- View all not sold houses
RegisterCommand("createhouse", function()
    ESX.TriggerServerCallback("esx_housing:createHouseMenu", function(permission)
        if permission == "admin" then
            current_data = {
                interior_type = "",
                interior_position = "",
                storage_position = "",
                door_coords = "",
                house_price = "",
            }
            HouseMaker(current_data)
        end
    end, '')
end)


RegisterCommand('viewhouses', function()
    if not viewing then
        for k,v in pairs(Houses) do
            Houses[k] = CreateHouse(Houses[k])
            if not Houses[k].owned or Houses[k].owner == ('' or "") then
                NewBlip(Houses[k].doorpos, Houses[k].id)
            end
        end
        viewing = true
    else
        for k,v in pairs(view_blips) do
            RemoveBlip(v)
        end
        viewing = false
    end
end)


function openHousingRequestMenu(housingRequest) 
    lib.registerContext({
        id = "housing_request:"..housingRequest.id,
        title = ("Housing Request (%s)"):format(housingRequest.id),
        options = {
            {
                title = "Approve",
                onSelect = function ()
                    local interiorTypes = {}
                    for key, value in pairs(Config.Points) do
                        if (value ~= true) then
                            table.insert(interiorTypes, key)
                        end
                    end

                    local res = lib.inputDialog("Housing Creation", {
                        {
                            label = "Interior Type",
                            type = "select",
                            options = exports.stem_common:tableMap(interiorTypes, function (type) 
                                return {
                                    label = string.upper(string.sub(type, 1, 1)) .. string.sub(type, 2),
                                    value = type,
                                }
                            end)
                        }
                    }, {allowCancel = true})

                    if (not res) then return end;

                    TriggerServerEvent("esx_housing:housingStatus", true, res[1])
                end
            },
            {
                title = "Disapprove",
                onSelect = function () 
                    local res = lib.inputDialog("Why are you declining this?", {{
                        label = "Reason",
                        type = "textarea",
                    }}, {
                        allowCancel = true
                    })
                    if (not res) then return end
                    TriggerServerEvent("esx_housing:housingStatus", false, res[1])
                end
            },
            {
                title = "View Houses",
                onSelect = function ()
                    ESX.TriggerServerCallback("esx_housing:getHouses", function (houses) 
                        print(json.encode(houses))
                        lib.registerContext({
                            id = "housing_request:houses:"..housingRequest.identifier,
                            title = "Other Houses",
                            options = exports.stem_common:tableMap(houses, function (house)
                                print(json.encode(house))
                                local c = house.data.door
                                house.coords = vector3(c.x, c.y, c.z) 
                                local nearestPostal = exports["nearest-postal"]:getPostalNearCoords(house.coords)
                                return {
                                    title = ("House (%s) near: %s"):format(house.id, nearestPostal),
                                    onSelect = function () 
                                        TriggerServerEvent("esx_housing:replaceHouse", house.id)
                                    end
                                }
                            end) 
                        })
                        lib.showContext("housing_request:houses:"..housingRequest.identifier)
                    end)
                end
            }
        },
    })
    lib.showContext("housing_request:"..housingRequest.id)
end

local housingRequestBlip;
local housingRequest;

RegisterNetEvent("esx_housing:viewHousingRequest", function (request) 
    local c = json.decode(request.coords)
    request.coords = vector3(c.x, c.y, c.z)
    housingRequest = request
    housingRequestBlip = AddBlipForCoord(request.coords)
    SetBlipSprite(housingRequestBlip, 375)
    SetBlipColour(housingRequestBlip, 3)
    
    SetBlipAsShortRange(housingRequestBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(("Housing request: %s"):format(housingRequest.id))
    EndTextCommandSetBlipName(housingRequestBlip)
end)

RegisterNetEvent("esx_housing:hidehousingrequest", function () 
    RemoveBlip(housingRequestBlip)
    housingRequest = nil
end)

RegisterCommand("hidehousingrequest", function ()
    TriggerEvent("esx_housing:hidehousingrequest")
end)

Citizen.CreateThread(function ()
    local timeout = 500
    while true do
        if (housingRequest) then
            DrawMarker(1, housingRequest.coords.x, housingRequest.coords.y, housingRequest.coords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 250, 200, 50)
            DrawText3D(housingRequest.coords.x, housingRequest.coords.y, housingRequest.coords.z + 0.5, ("Housing request: %s"):format(housingRequest.id))
            if (GetDistanceBetweenCoords(housingRequest.coords, GetEntityCoords(PlayerPedId())) < 3) then
                ESX.ShowHelpNotification("Press ~INPUT_TALK~ to open the housing request", true)
                if IsControlJustPressed(1, 46) then
                    openHousingRequestMenu(housingRequest)
                end
            end
            timeout = 0
        else
            timeout = 500
        end
        Citizen.Wait(timeout)
    end
end)

local color = {r = 220, g = 220, b = 220, alpha = 255} -- Color of the text
local font = 4 -- Font of the text

local background = {enable = true, color = {r = 35, g = 35, b = 35, alpha = 200}}
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0 * scale, 0.80 * scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextOutline()
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        --AddTextComponentString(text)
        local height = GetTextScaleHeight(0.45 * scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x, _y + scale / 73, width, height, background.color.r, background.color.g, background.color.b, background.color.alpha)
        end
    end
end