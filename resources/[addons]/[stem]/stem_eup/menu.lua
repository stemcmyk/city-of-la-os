------------------------------------------------------------------------
------------------------------------------------------------------------
--		    Don't touch if you don't know what you're doing.		  --
--     For support join my discord: https://discord.gg/Z9Mxu72zZ6     --
--																	  --
------------------------------------------------------------------------
------------------------------------------------------------------------

local loadedEUPs = {}

rightPosition = {x = 1320, y = 100}
leftPosition = {x = 0, y = 100}
menuPosition = {x = 0, y = 200}

if config.menuPosition then
    if config.menuPosition == "left" then
        menuPosition = leftPosition
    elseif config.menuPosition == "right" then
        menuPosition = rightPosition
    end
end

local menuWidth = 80
_G.Object = Object

local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head_EUP')
local Object = CreateDui("https://i.imgur.com/BmTnD4k.png", 512, 128)
_G.Object = Object
local TextureThing = GetDuiHandle(Object)
local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head_EUP', TextureThing)
menuImage = "shopui_title_sm_hangar"

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu()
_menuPool:Remove()
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "", menuPosition.x, menuPosition.y, menuImage, menuImage)
_menuPool:Add(mainMenu)
mainMenu:SetMenuWidthOffset(menuWidth)
collectgarbage()

function setEUP(outfit)
    local ped = PlayerPedId()
    local model = "mp_m_freemode_01"
    if GetEntityModel(ped) ~= GetHashKey(model) and GetEntityModel(ped) ~= GetHashKey("mp_f_freemode_01") then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    end
    local ped = PlayerPedId()
    for _, component in ipairs(outfit.components) do
        if (component[1] ~= 2 and component[1] ~= 0) then
            SetPedComponentVariation(ped, component[1], component[2], component[3], 0)
        end
    end
    for _, prop in ipairs(outfit.props) do
        if prop[2] == 0 then
            ClearPedProp(ped, prop[1])
        else
            SetPedPropIndex(ped, prop[1], prop[2], prop[3], true)
        end
    end
end

RegisterNetEvent("stem_eup:loadEUPs", function (newLoadedEUPs)
    loadedEUPs = newLoadedEUPs;
end)

local ToggleClose = NativeUI.CreateItem("Close", "Close the menu")
mainMenu:AddItem(ToggleClose)
ToggleClose.Activated = function(ParentMenu, SelectedItem)
    _menuPool:CloseAllMenus()
end

function ResetMenu() 
    _menuPool = NativeUI.CreatePool()
    mainMenu = NativeUI.CreateMenu()
    _menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    mainMenu = NativeUI.CreateMenu("", "", menuPosition.x, menuPosition.y, menuImage, menuImage)
    _menuPool:Add(mainMenu)
    mainMenu:SetMenuWidthOffset(menuWidth)
    collectgarbage()    
end

local function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end


function Menu()
    ResetMenu()
    
    for departement, eupItems in pairs(loadedEUPs) do
        if (ESX.PlayerData.job.name == departement) then
            local departmentMenu = _menuPool:AddSubMenu(mainMenu, config.groups[departement].title, "", true, menuImage, menuImage)
            departmentMenu:SetMenuWidthOffset(menuWidth)
            
            -- if (ESX.PlayerData.job.grade >= config.groups[ESX.PlayerData.job.name].editGrade) then
            --     departmentMenu:AddInstructionButton({GetControlInstructionalButton(2, 296, true), "Delete EUP"})
            -- end
    
            for k, eupItem in pairs(eupItems) do
                if (ESX.PlayerData.job.grade >= (eupItem.grade or 0)) then
                    local buttonItem = NativeUI.CreateItem(string.format("%s: (%s) %s", eupItem.id, eupItem.grade_name, eupItem.name), "")
                    departmentMenu:AddItem(buttonItem)
        
                    buttonItem.Activated = function(ParentMenu, SelectedItem)
                        setEUP(eupItem.data)
                    end
                end
            end
        end
    end

    _menuPool:ControlDisablingEnabled(false)
    _menuPool:MouseControlsEnabled(false)
    _menuPool:RefreshIndex()
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

if config.enableOpenCommand then
    TriggerEvent("chat:addSuggestion", "/" .. config.openCommand, "Open EUP Menu")
    RegisterCommand(config.openCommand, function(source, args, rawCommand)
        TriggerServerEvent("stem_eup:requestEUP")
        if not _menuPool:IsAnyMenuOpen() then
            Menu()
            mainMenu:Visible(true)
        end
    end, false)
end

Citizen.CreateThread(function()
    TriggerServerEvent("stem_eup:requestEUP")
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

ESX.RegisterClientCallback("stem_eup:saveEUPMenu", function (cb, job, grades, id) 
    local gradeOptions = {}
    for key, value in pairs(grades) do
        table.insert(gradeOptions, { label = string.format("(%s) %s", value.grade, value.label), value = tonumber(value.grade) })
    end

    table.sort(gradeOptions, function (a, b) 
        return a.value < b.value
    end)

    local updateString = id and string.format("Update EUP (%s) for %s", id, string.upper(job)) or string.format("Save EUP for %s", string.upper(job))

    local input = lib.inputDialog(updateString, {
        {
            label = "Name",
            type = "input",
        },
        {
            label = "Job Grade",
            type = "select",
            options = gradeOptions
        }
    })

    if (not input) then return cb(nil) end

    local ped = PlayerPedId()

    local props = {}
    for i = 1, 6, 1 do
        table.insert(props, {i, GetPedPropIndex(ped, i) + 1, GetPedPropTextureIndex(ped, i)})
    end

    local components = {}
    for i = 1, 11, 1 do
        table.insert(components, {i, GetPedDrawableVariation(ped, i), GetPedTextureVariation(ped, i)})
    end

    cb(input[1], input[2], props, components)
end)