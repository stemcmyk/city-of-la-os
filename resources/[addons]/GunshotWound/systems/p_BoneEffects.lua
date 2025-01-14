-- VARIABLES --
local config = {}

local vars = {}

local audio_active = false
local audio_cancel = false
local tunnel_active = false
local effects_active = false
local effects_cancel = false
local hand_cancel = false
local hand_active = false
local blackout_active = false
local blackout_cancel = false
local paralyze_cancel = false
local limp_cancel = false

local listofscreenfx = {
    [1] = {
        Name = "SwitchHUDIn"
    },
    [2] = {
        Name = "FocusIn"
    },
    [3] = {
        Name = "MinigameTransitionIn"
    },
    [4] = {
        Name = "SwitchOpenMichaelIn"
    },
    [5] = {
        Name = "SwitchOpenFranklinIn"
    },
    [6] = {
        Name = "SwitchOpenTrevorIn"
    },
    [7] = {
        Name = "DeathFailOut"
    },
    [8] = {
        Name = "MP_Celeb_Win"
    },
    [9] = {
        Name = "MP_Celeb_LoseName"
    },
    [10] = {
        Name = "DeathFailNeutralIn"
    },
    [11] = {
        Name = "DeathFailMPDark"
    },
    [12] = {
        Name = "DeathFailMPIn"
    },
    [13] = {
        Name = "PeyoteEndOut"
    },
    [14] = {
        Name = "DrugsMichaelAliensFightIn"
    },
    [15] = {
        Name = "DrugsMichaelAliensFightOut"
    },
    [16] = {
        Name = "MenuMGTournamentIn"
    },
    [17] = {
        Name = "DMT_flight"
    },
    [18] = {
        Name = "ChopVision"
    },
    [19] = {
        Name = "Rampage"
    },
    [20] = {
        Name = "Dont_tazeme_bro"
    }
}

-- SET CONFIG --
function BoneEffectsDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end

RegisterNetEvent("c_BoneEffects_ConfigSet")
AddEventHandler("c_BoneEffects_ConfigSet", function(configSent)
    config = configSent
    BoneEffectsDebug("c_BoneEffects_ConfigSet", "Config sent, debug status: ", "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug))
end)

-- FUNCTIONS
-- Function Audio Distrotion
function Audio()
    if audio_active == true then
        return
    end

    print("Audio called")

    audio_active = true
    audio_cancel = false

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if audio_cancel == true then
                audio_active = false
                return
            end
            print("Playing SFX from Bone Effects")
            SetAudioSpecialEffectMode(2)
        end
    end)
end
-- Tunnel Vision
function TunnelVision(ped)
    -- CHECK IF ALREADY PLAYING
    if tunnel_active == true then
        return
    end
    -- SET VARIABLE TO PLAYING
    tunnel_active = true
    local entity = ped
    -- PLAY EFFECT
    AnimpostfxPlay("DeathFailMPDark", 0, true)
    Audio()
    -- DELAY
    local n = 0
    repeat
        Wait(0)
        n = n + 1
        print("LOOP N: " .. n)

        if IsEntityDead(entity) == 1 then
            n = 100
        end
    until(n == 100)
    -- STOP EFFECT
    AnimpostfxStop("DeathFailMPDark")
    -- SET VARIABLE TO NOT PLAYING
    tunnel_active = false
    audio_cancel = true
end
-- Screen Effects
function ScreenEffects(ped)
    -- CHECK IF ALREADY PLAYING
    if effects_active == true then
        return
    end
    -- LOOP UNTIL TUNNEL VISION IS FINISHED
    repeat
        Wait(0)
    until(tunnel_active == false)
    -- SET VARIABLE TO PLAYING
    effects_active = true
    -- PLAY EFFECTS
    local sFx = listofscreenfx[math.random(1,20)]
    AnimpostfxPlay(sFx.Name, 0, true)
    -- Create Thread to Auto Stop Screen Effects After Time
    Citizen.CreateThread(function()
        local entity = ped
        local v = 0
        Audio()
        while true do
            Wait(1000)

            if effects_cancel == true  or IsEntityDead(entity) == 1 then
                effects_active = false
                -- AnimpostfxStopAll()
                effects_cancel = false
                return
            end

            if v == config.ScreenEffectCounterLegnth then
                AnimpostfxStopAll()
                effects_active = false
                audio_cancel = true
                return
            else
                v = v + 1
            end
        end
    end)
end
-- Ragdoll
function Ragdoll(ped, time)
    SetPedToRagdoll(ped, time, time, 0, 0, 0, 0)
end
-- Paralyze
function Paralyze(ped)
    Citizen.CreateThread(function()
        local entity = ped
        while true do
            Wait(0)
            if paralyze_cancel == true  or IsEntityDead(entity) == 1 then
                return
            end
            DisableAllControlActions(2)
            Ragdoll(entity, 10000)
        end
    end)
end
-- Limp
function Limp(ped)
    RequestAnimSet("move_m@injured")
    while not HasAnimDictLoaded("move_m@injured") do
        Wait(1)
    end
    SetPedMovementClipset(ped, "move_m@injured", true)
    -- DISABLE CONTROLS
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if limp_cancel == true  or IsEntityDead(entity) == 1 then
                return
            end
            DisableControlAction(2, 21, true) -- SPRINT
            DisableControlAction(2, 22, true) -- JUMP
        end
    end)
end
-- Blackout
function Blackout(ped)
    if blackout_active == true then
        return
    end
    
    blackout_active = true

    Citizen.CreateThread(function()
        local entity = ped
        local v = 0
        while true do
            Wait(0)
            if blackout_cancel == true  or IsEntityDead(entity) == 1 then
                blackout_active = false
                blackout_cancel = false
                audio_cancel = true
                return
            end

            if v == config.BlackoutCounterLength then
                blackout_active = false
                audio_cancel = true
                return
            else
                DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255)
                Ragdoll(entity, 10000)
                DisableAllControlActions(2)
                Audio()
                v = v + 1
            end
        end
    end)
end
-- Hand
function Hand(ped)
    if hand_active == true then
        return
    end
    hand_active = true
    hand_cancel = false
    Citizen.CreateThread(function()
        local entity = ped
        while true do
            Wait(0)
            if hand_cancel == true or IsEntityDead(entity) == 1 then
                print("Cancelling hand. Cancel: " .. tostring(hand_cancel) .. ". Dead: " .. tostring(IsEntityDead(entity)))
                hand_active = false
                hand_cancel = false
                return
            end
            DisableControlAction(2, 25, true) -- AIM
            DisableControlAction(2, 45, true) -- RELOAD
            DisableControlAction(2, 50, true) -- ACCURATE AIM
            DisableControlAction(2, 16, true) -- SELECT WEAPON 1
            DisableControlAction(2, 17, true) -- SELECT WEAPON 2
            DisableControlAction(2, 37, true) -- SELECT WEAPON 3
            DisableControlAction(2, 99, true) -- SELECT WEAPON 4
            DisableControlAction(2, 100, true) -- SELECT WEAPON 5
            DisableControlAction(2, 157, true) -- SELECT WEAPON 6
            DisableControlAction(2, 158, true) -- SELECT WEAPON 7
            DisableControlAction(2, 159, true) -- SELECT WEAPON 8
            DisableControlAction(2, 160, true) -- SELECT WEAPON 9
            DisableControlAction(2, 161, true) -- SELECT WEAPON 10
            DisableControlAction(2, 162, true) -- SELECT WEAPON 11
            DisableControlAction(2, 163, true) -- SELECT WEAPON 12
            DisableControlAction(2, 164, true) -- SELECT WEAPON 13
            DisableControlAction(2, 165, true) -- SELECT WEAPON 14
            DisableControlAction(2, 23, true) -- ENTER VEHICLE
        end
    end)
end

exports("SetEffectsVariable", function(id, value, arg1, arg2, arg3, arg4)
    --Screen Fx
    if id == 0 then
        if value == true then
            effects_cancel = false
            ScreenEffects(arg1)
        end
    end
    --Ragdoll
    if id == 1 then
        if value == true then
            Ragdoll(arg1, arg2)
        end
    end
    --Paralyze
    if id == 2 then
        if value == true then
            paralyze_cancel = false
            Paralyze(arg1)
        else
            paralyze_cancel = true
        end
    end
    --Limp
    if id == 3 then
        if value == true then
            limp_cancel = false
            Limp(arg1)
        else
            limp_cancel = true
            ResetPedMovementClipset(arg1, 0.0)
        end
    end
    --Tunnel Vision
    if id == 4 then
        if value == true then
            TunnelVision(arg1)
        end
    end
    --Blackout
    if id == 5 then
        if value == true then
            blackout_cancel = false
            Blackout(arg1)
        end
    end
    --Hand
    if id == 6 then
        if value == true then
            hand_cancel = true
            Hand(arg1)
        end
    end
end)


-- SYSTEM VALUE RESET --
RegisterNetEvent("sysValueReset_pBoneEffects")
AddEventHandler("sysValueReset_pBoneEffects", function()
    local ped = PlayerPedId()

    paralyze_cancel = true
    limp_cancel = true
    effects_cancel = true
    blackout_cancel = true
    hand_cancel = true
    audio_cancel = true

    -- AnimpostfxStopAll()
    ResetPedMovementClipset(ped, 0.0)
end)