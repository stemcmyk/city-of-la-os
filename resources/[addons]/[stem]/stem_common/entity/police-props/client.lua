local _policeProps = {}

AddStateBagChangeHandler(
    "weaponSling",
    nil,
    function(bagName, key, value, _reserved, replicated)
        if replicated then
            return
        end

        local player = GetPlayerFromStateBagName(bagName)
        if player == 0 then
            return
        end

        local serverId = GetPlayerServerId(player)
        if _policeProps[serverId] then
            local objects = _policeProps[serverId]
            for _, v in pairs(objects) do
                if NetworkGetEntityIsLocal(v) then
                    DeleteEntity(v)
                end
            end
        end

        if not value or not Config_PoliceSlingedWeapons[value] then
            return
        end

        local maxTime = GetGameTimer() + 2500
        while not DoesEntityExist(GetPlayerPed(player)) and GetGameTimer() < maxTime do
            Wait(0)
        end

        local plyPed = GetPlayerPed(player)
        if not DoesEntityExist(plyPed) then
            return
        end

        local wep = Config_PoliceSlingedWeapons[value]

        RequestWeaponAsset(value)
        while not HasWeaponAssetLoaded(value) do
            Wait(0)
        end

        -- local weaponObj = CreateObject(wep.model.hash, GetEntityCoords(plyPed), false, false, false)
        local weaponObj = CreateWeaponObject(value, GetAmmoInPedWeapon(plyPed, wep.model.hash), GetEntityCoords(plyPed),
            true, 1.0, 0)

        AttachEntityToEntity(
            weaponObj,
            plyPed,
            GetPedBoneIndex(plyPed, wep.model.boneIndex),
            wep.model.offset,
            wep.model.rotation,
            true,
            true,
            false,
            false,
            2,
            true
        )

        _policeProps[serverId] = {
            [1] = weaponObj
        }

        if wep.modular then
            if wep.flashlights then
                for _, v in pairs(wep.flashlights) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end

            if wep.magazines then
                for _, v in pairs(wep.magazines) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end

            if wep.scopes then
                for _, v in pairs(wep.scopes) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end

            if wep.frames then
                for _, v in pairs(wep.frames) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end

            if wep.flashlights then
                for _, v in pairs(wep.flashlights) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end

            if wep.grips then
                for _, v in pairs(wep.grips) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end

            if wep.stocks then
                for _, v in pairs(wep.stocks) do
                    if HasPedGotWeaponComponent(plyPed, value, v) then
                        GiveWeaponComponentToWeaponObject(weaponObj, v)
                        break
                    end
                end
            end
        else
            if wep.magazine then
                if HasPedGotWeaponComponent(plyPed, value, wep.magazine.hash) then
                    GiveWeaponComponentToWeaponObject(weaponObj, wep.magazine.hash)
                end

                -- local mag = CreateObject(wep.magazine.hash, GetEntityCoords(plyPed), false, false, false)
                -- AttachEntityToEntity(mag, weaponObj, 0.0, wep.magazine.offset, wep.magazine.rotation, true, true, false, false, 2, true)
                -- _policeProps[serverId][2] = mag
            end

            if wep.scope then
                if HasPedGotWeaponComponent(plyPed, value, wep.scope.hash) then
                    GiveWeaponComponentToWeaponObject(weaponObj, wep.scope.hash)
                end

                -- local scope = CreateObject(wep.scope.hash, GetEntityCoords(plyPed), false, false, false)
                -- AttachEntityToEntity(scope, weaponObj, 0.0, wep.scope.offset, wep.scope.rotation, true, true, false, false, 2, true)
                -- _policeProps[serverId][3] = scope
            end

            if wep.flashlight then
                if HasPedGotWeaponComponent(plyPed, value, wep.flashlight.hash) then
                    GiveWeaponComponentToWeaponObject(weaponObj, wep.flashlight.hash)
                end

                -- local flashlight = CreateObject(wep.flashlight.hash, GetEntityCoords(plyPed), false, false, false)
                -- AttachEntityToEntity(flashlight, weaponObj, 0.0, wep.flashlight.offset, wep.flashlight.rotation, true, true, false, false, 2, true)
                -- _policeProps[serverId][4] = flashlight
            end

            if wep.suppressor then
                if HasPedGotWeaponComponent(plyPed, value, wep.suppressor.hash) then
                    GiveWeaponComponentToWeaponObject(weaponObj, wep.suppressor.hash)
                end

                -- local suppressor = CreateObject(wep.suppressor.hash, GetEntityCoords(plyPed), false, false, false)
                -- AttachEntityToEntity(suppressor, weaponObj, 0.0, wep.suppressor.offset, wep.suppressor.rotation, true, true, false, false, 2, true)
                -- _policeProps[serverId][5] = suppressor
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while ESX == nil do
            Wait(0)
        end

        while not LocalPlayer.state.switchComplete do Wait(0) end

        local items = exports.ox_inventory:GetPlayerItems()
        for k, v in pairs(items) do
            if Config_PoliceSlingedWeapons[GetHashKey(v.name)] then
                LocalPlayer.state:set("weaponSling", GetHashKey(v.name), true)
                break
            end
        end

        local lastWeapon = nil

        while true do
            local playerPed = PlayerPedId()
            local selectedWeapon = exports.ox_inventory:getCurrentWeapon()

            if LocalPlayer.state.weaponSling and IsEntityDead(playerPed) then
                lastWeapon = nil
                LocalPlayer.state:set("weaponSling", nil, true)
                Wait(100)
            elseif selectedWeapon and Config_PoliceSlingedWeapons[selectedWeapon.hash] then
                lastWeapon = selectedWeapon.hash
                LocalPlayer.state:set("weaponSling", "equipped", true)
            elseif LocalPlayer.state.weaponSling == "equipped" and selectedWeapon ~= lastWeapon then -- Weapon was equipped but no longer selected, recreate prop
                LocalPlayer.state:set("weaponSling", lastWeapon, true)
            end

            Citizen.Wait(50)
        end
    end
)

AddEventHandler("esx:addInventoryItem", function(itemName, totalCount)
    local weaponHash = GetHashKey(itemName)
    if Config_PoliceSlingedWeapons[weaponHash] then
        if not LocalPlayer.state.weaponSling then
            local wepName = nil
            for item, data in pairs(exports.ox_inventory:Items()) do
                if item == itemName then
                    wepName = data.label
                    break
                end
            end
            ESX.ShowNotification("~r~Unracked~s~ " .. (wepName or 'weapon'))
            LocalPlayer.state:set("weaponSling", weaponHash, true)
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            if weaponHash == `WEAPON_GRENADELAUNCHER` then
                CreateThread(function ()
                    while true do
                        if LocalPlayer.state.weaponSling == nil then
                            break
                        end

                        DisableControlAction(0, 23, true)
                        if IsDisabledControlJustPressed(0, 23) then
                            ESX.ShowNotification('Cannot enter vehicle with Launcher')
                        end
                        Wait(0)
                    end
                end)
            end

            TriggerEvent("police:unrackedVehicleCheck")
        end
    end
end)

AddEventHandler("esx:removeInventoryItem", function(itemName, totalCount)
    local weaponHash = GetHashKey(itemName)
    if Config_PoliceSlingedWeapons[weaponHash] then
        if LocalPlayer.state.weaponSling == weaponHash then
            local wepName = nil
            for item, data in pairs(exports.ox_inventory:Items()) do
                if item == itemName then
                    wepName = data.label
                    break
                end
            end
            ESX.ShowNotification("~g~Racked~s~ " .. (wepName or 'weapon'))
            LocalPlayer.state:set("weaponSling", nil, true)
        end
    end
end)


AddEventHandler(
    "police:rackRifle",
    function()
        if LocalPlayer.state.weaponSling and LocalPlayer.state.weaponSling ~= GetHashKey("WEAPON_CARBINERIFLE") and LocalPlayer.state.weaponSling ~= "equipped" then
            ESX.ShowNotification("You are already slinging a weapon.")
            return
        end

        if not LocalPlayer.state.weaponSling then
            for weaponHash, _ in pairs(Config_PoliceSlingedWeapons) do
                SetCanPedEquipWeapon(PlayerPedId(), weaponHash, false)
            end

            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), true)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~r~Unracked~s~ rifle")
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            LocalPlayer.state:set("weaponSling", GetHashKey("WEAPON_CARBINERIFLE"), true)
        else
            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), false)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~g~Racked~s~ rifle")

            LocalPlayer.state:set("weaponSling", nil, true)
        end

        if not LocalPlayer.state.weaponSling then
            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
            if weaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
                TriggerEvent("ox_inventory:disarm", true)
            end
        end
    end
)

AddEventHandler(
    "police:rackShotgun",
    function()
        if LocalPlayer.state.sling and LocalPlayer.state.sling ~= GetHashKey("WEAPON_PUMPSHOTGUN") and LocalPlayer.state.weaponSling ~= "equipped" then
            ESX.ShowNotification("You are already slinging a weapon.")
            return
        end

        if not LocalPlayer.state.weaponSling then
            for weaponHash, _ in pairs(Config_PoliceSlingedWeapons) do
                SetCanPedEquipWeapon(PlayerPedId(), weaponHash, false)
            end

            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_PUMPSHOTGUN"), true)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~r~Unracked~s~ shotgun")
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            LocalPlayer.state:set("weaponSling", GetHashKey("WEAPON_PUMPSHOTGUN"), true)
        else
            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_PUMPSHOTGUN"), false)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~g~Racked~s~ shotgun")

            LocalPlayer.state:set("weaponSling", nil, true)
        end

        if not LocalPlayer.state.weaponSling then
            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
            if weaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
                TriggerEvent("ox_inventory:disarm", true)
            end
        end
    end
)

AddEventHandler(
    "police:rackLauncher",
    function()
        if LocalPlayer.state.sling and LocalPlayer.state.sling ~= GetHashKey("WEAPON_GRENADELAUNCHER") and LocalPlayer.state.weaponSling ~= "equipped" then
            ESX.ShowNotification("You are already slinging a weapon.")
            return
        end

        if not LocalPlayer.state.weaponSling then
            for weaponHash, _ in pairs(Config_PoliceSlingedWeapons) do
                SetCanPedEquipWeapon(PlayerPedId(), weaponHash, false)
            end

            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_GRENADELAUNCHER"), true)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~r~Unracked~s~ launcher")
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            LocalPlayer.state:set("weaponSling", GetHashKey("WEAPON_GRENADELAUNCHER"), true)
        else
            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_GRENADELAUNCHER"), false)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~g~Racked~s~ launcher")

            LocalPlayer.state:set("weaponSling", nil, true)
        end

        if not LocalPlayer.state.weaponSling then
            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
            if weaponHash == GetHashKey("WEAPON_GRENADELAUNCHER") then
                TriggerEvent("ox_inventory:disarm", true)
            end
        end
    end
)

AddEventHandler(
    "police:rackMP5",
    function()
        if LocalPlayer.state.sling and LocalPlayer.state.sling ~= GetHashKey("WEAPON_MP5") and LocalPlayer.state.weaponSling ~= "equipped" then
            ESX.ShowNotification("You are already slinging a weapon.")
            return
        end

        if not LocalPlayer.state.weaponSling then
            for weaponHash, _ in pairs(Config_PoliceSlingedWeapons) do
                SetCanPedEquipWeapon(PlayerPedId(), weaponHash, false)
            end

            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_MP5"), true)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~r~Unracked~s~ MP5")
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            LocalPlayer.state:set("weaponSling", GetHashKey("WEAPON_MP5"), true)
        else
            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_MP5"), false)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~g~Racked~s~ MP5")

            LocalPlayer.state:set("weaponSling", nil, true)
        end

        if not LocalPlayer.state.weaponSling then
            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
            if weaponHash == GetHashKey("WEAPON_MP5") then
                TriggerEvent("ox_inventory:disarm", true)
            end
        end
    end
)

AddEventHandler(
    "police:rackMK18",
    function()
        if LocalPlayer.state.sling and LocalPlayer.state.sling ~= GetHashKey("WEAPON_MK18") and LocalPlayer.state.weaponSling ~= "equipped" then
            ESX.ShowNotification("You are already slinging a weapon.")
            return
        end

        if not LocalPlayer.state.weaponSling then
            for weaponHash, _ in pairs(Config_PoliceSlingedWeapons) do
                SetCanPedEquipWeapon(PlayerPedId(), weaponHash, false)
            end

            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_MK18"), true)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~r~Unracked~s~ MK18")
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            LocalPlayer.state:set("weaponSling", GetHashKey("WEAPON_MK18"), true)
        else
            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_MK18"), false)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~g~Racked~s~ MK18")

            LocalPlayer.state:set("weaponSling", nil, true)
        end

        if not LocalPlayer.state.weaponSling then
            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
            if weaponHash == GetHashKey("WEAPON_MK18") then
                TriggerEvent("ox_inventory:disarm", true)
            end
        end
    end
)

AddEventHandler(
    "police:rackM16",
    function()
        if LocalPlayer.state.sling and LocalPlayer.state.sling ~= GetHashKey("WEAPWEAPON_FM1_M16A4") and LocalPlayer.state.weaponSling ~= "equipped" then
            ESX.ShowNotification("You are already slinging a weapon.")
            return
        end

        if not LocalPlayer.state.weaponSling then
            for weaponHash, _ in pairs(Config_PoliceSlingedWeapons) do
                SetCanPedEquipWeapon(PlayerPedId(), weaponHash, false)
            end

            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_FM1_M16A4"), true)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~r~Unracked~s~ M16")
            PlaySoundFrontend(1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET")

            LocalPlayer.state:set("weaponSling", GetHashKey("WEAPON_FM1_M16A4"), true)
        else
            SetCanPedEquipWeapon(PlayerPedId(), GetHashKey("WEAPON_FM1_M16A4"), false)
            ESX.UI.Menu.CloseAll()
            ESX.ShowNotification("~g~Racked~s~ M16s")

            LocalPlayer.state:set("weaponSling", nil, true)
        end

        if not LocalPlayer.state.weaponSling then
            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
            if weaponHash == GetHashKey("WEAPON_FM1_M16A4") then
                TriggerEvent("ox_inventory:disarm", true)
            end
        end
    end
)

AddEventHandler(
    "police:equipShield",
    function()
        TriggerEvent("shield:ToggleSwatShield")
    end
)

RegisterNetEvent("shield:ToggleSwatShield")
AddEventHandler(
    "shield:ToggleSwatShield",
    function()
        Citizen.CreateThread(
            function()
                if not LocalPlayer.state.shield then
                    local ped = GetPlayerPed(-1)
                    local propName = "prop_jswat_shield"
                    local coords = GetEntityCoords(ped)
                    local prop = GetHashKey(propName)

                    local dict = "weapons@first_person@aim_rng@generic@light_machine_gun@combat_mg@"
                    local name = "wall_block_low"

                    while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(10)
                        RequestAnimDict(dict)
                    end

                    RequestModel(prop)
                    while not HasModelLoaded(prop) do
                        Citizen.Wait(100)
                    end

                    LocalPlayer.state:set(
                        "propData",
                        {
                            model = "prop_jswat_shield",
                            boneIndex = 57005,
                            offset = vector3(0.21, 0.01, 0.24),
                            rotation = vector3(-72.0, 85.0, 80.0),
                            rotationOrder = 2
                        },
                        true
                    )

                    LocalPlayer.state.shield = true

                    while not HasAnimSetLoaded("move_ped_crouched") do
                        Citizen.Wait(0)
                        RequestAnimSet("move_ped_crouched")
                    end

                    local Player = PlayerPedId()
                    SetPedUsingActionMode(Player, false, -1, "DEFAULT_ACTION")
                    SetPedMovementClipset(Player, "move_ped_crouched", 0.55)
                    SetPedStrafeClipset(Player, "move_ped_crouched_strafing") -- it force be on third person if not player will freeze but this func make player can shoot with good anim on crouch if someone know how to fix this make request :D
                    SetWeaponAnimationOverride(Player, "Ballistic")
                else
                    LocalPlayer.state.shield = false
                    ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
                    SetModelAsNoLongerNeeded(prop)
                    LocalPlayer.state:set("propData", nil, true)

                    local Player = PlayerPedId()
                    SetPedMaxMoveBlendRatio(Player, 1.0)
                    ResetPedMovementClipset(Player, 0.55)
                    ResetPedStrafeClipset(Player)
                    SetPedCanPlayAmbientAnims(Player, true)
                    SetPedCanPlayAmbientBaseAnims(Player, true)
                    ResetPedWeaponMovementClipset(Player)
                end
            end
        )
    end
)

Citizen.CreateThread(
    function()
        while true do
            local interval = 500

            if LocalPlayer.state.shield then
                interval = 0

                local dict = "weapons@first_person@aim_rng@generic@light_machine_gun@combat_mg@"
                local name = "wall_block_low"

                DisablePlayerFiring(PlayerId(), true)

                if not IsEntityPlayingAnim(PlayerPedId(), dict, name, 3) then
                    TaskPlayAnim(PlayerPedId(), dict, name, 1.0, 4.0, -1, 49, 0, 0, 0, 0)
                end
            end

            Citizen.Wait(interval)
        end
    end
)
