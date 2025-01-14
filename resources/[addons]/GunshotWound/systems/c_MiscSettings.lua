-- VARIABLES --
local config = {}
local vars = {}

vars.AITestCounter = 0
vars.ResourceName = GetCurrentResourceName()

-- EVENTS --
RegisterNetEvent("c_MiscSettings_ConfigSet")
AddEventHandler("c_MiscSettings_ConfigSet", function(configSent)
    config = configSent
    print("c_MiscSettings_ConfigSet | Config sent, debug status: From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug))
end)

-- LOOP --
local firstRun = true
Citizen.CreateThread(function ()
	while true do
		Wait(0)
        local ped = PlayerPedId()
        -- if config.RemoveReticle == true then
        --     HideHudComponentThisFrame(14)
        -- end

        if config.StopRegeneration == true then
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        end

        if config.DefaultLessLethal == true then
            SetWeaponDamageModifier(1432025498, 0.0001)
            SetWeaponDamageModifier(2024373456, 0.0001)
            SetWeaponDamageModifier(911657153, 0.0)
        end

        if IsPedShooting(ped) and config.TunnelVision == true then
            Citizen.CreateThread(function()
                exports[vars.ResourceName]:SetEffectsVariable(4, true, ped)
                return
            end)
        end

        if config.TestingItems == true and firstRun == true then
            firstRun = false
            exports[vars.ResourceName]:SetEffectsVariable(6, true, ped)
        end
	end
end)