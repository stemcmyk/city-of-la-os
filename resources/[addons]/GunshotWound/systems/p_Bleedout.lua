-- VARIABLES --

local config = {}
local vars = {}
vars.BloodAmount = 0
vars.cancel = false
vars.BandageActive = false
vars.NormalHoles = 0
vars.ArteryHoles = 0

vars.AudioActive = false
vars.AudioNumber = 0

vars.DrunkActive = false
vars.DrunkOn = false
vars.DrunkNumber = 0.0

-- DEBUG INFO --

function BleedoutDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end

-- GET CONFIG --

RegisterNetEvent("c_Bleedout_ConfigSet")
AddEventHandler("c_Bleedout_ConfigSet", function(configSent)
    config = configSent
    FirstAidDebug("c_Bleedout_ConfigSet", "Config sent, debug status: ", "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug))
    vars.BloodAmount = config.AmountOfBloodInBody
end)

function ChangeHoles(type, change)
    if type == false then
        vars.NormalHoles = vars.NormalHoles + 1
    else
        vars.ArteryHoles = vars.ArteryHoles + 1
    end
end

function ApplyRagdoll(ped, time)
    SetPedToRagdoll(ped, time, time, 0, 0, 0, 0)
end

function DrawBlood(ped)
    local plrCoords = GetEntityCoords(ped, false)
    local ret, groundZ = GetGroundZFor_3dCoord(plrCoords[1], plrCoords[2], plrCoords[3], false)
    local width = 0.8
    local height = 0.5
    AddDecal(1110, plrCoords[1], plrCoords[2], groundZ, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0, width, height, 0.5, 0.0, 0.0, 1.0, config.BloodTrialTimeout, false, false, false)
end

exports("AddBleedout", function(onOff, Artery, entity)
    vars.cancel = false
    vars.BandageActive = false
    
    ChangeHoles(Artery, 1)

    if onOff == true then
        Citizen.CreateThread(function()
            local ped = entity
            local artery = Artery
            local loopsCompleted = 0

            local firstEffect = false
            local secondEffect = false
            local thirdEffect = false
            
            local waitTime
            if artery == true then
                waitTime = config.ArteryBleedoutDelay
            else
                waitTime = config.NormalBleedoutDelay
            end
            print("Wait Time Set to: " .. waitTime)
            while true do
                Wait(waitTime)
                -- BLACKOUT
                if vars.BloodAmount <= config.BloodAmountForBlackout and vars.BloodAmount >= 1 then
                    Citizen.CreateThread(function()
                        exports[vars.ResourceName]:SetEffectsVariable(5, true, ped)
                        return
                    end)
                elseif vars.BloodAmount == 0 then -- DEATH
                    ApplyDamageToPed(ped, 200, false)
                end

                -- WAIT TIME BANDAGE EFFECT
                if vars.BandageActive == true then
                    if artery == true and waitTime == config.ArteryBleedoutDelay then
                        waitTime = waitTime * 2
                    else
                        print("Cancelling bleedout")
                        vars.cancel = false
                        vars.BandageActive = false
                        ChangeHoles(artery, -1)
                        return
                    end
                end

                -- CANCEL
                if vars.cancel == true then
                    print("Cancelling Bleedout")
                    vars.cancel = false
                    vars.BandageActive = false
                    ChangeHoles(artery, -1)
                    return
                end
                -- ENTITY DEATH CHECK
                if IsEntityDead(ped) then
                    vars.cancel = true
                    vars.BandageActive = false
                    ChangeHoles(artery, -1)
                    print("Cancelling Bleedout")
                    return
                end

                -- DAMAGE
                local requiredNumber = math.random(loopsCompleted, loopsCompleted + 100)
                if loopsCompleted == requiredNumber then
                    ApplyDamageToPed(ped, config.BloodLossDamage, false)
                    loopsCompleted = 0
                    DrawBlood(ped)
                    print("Damaged")
                else
                    loopsCompleted = loopsCompleted + 1
                end

                -- EFFECTS
                if vars.BloodAmount <= 5000 and vars.BloodAmount >= 3000 and firstEffect == false then
                    Citizen.CreateThread(function()
                        print("Applying Level 1 Screen Effects for Bleedout")

                        vars.AudioActive = true
                        vars.AudioNumber = 1

                        vars.DrunkActive = true
                        vars.DrunkNumber = 1.0

                        ApplyRagdoll(ped, 1000)

                        firstEffect = true

                        return
                    end)
                elseif vars.BloodAmount <= 3000 and vars.BloodAmount >= 2000 and secondEffect == false then
                    Citizen.CreateThread(function()
                        print("Applying Level 2 Screen Effects for Bleedout")

                        vars.AudioActive = true
                        vars.AudioNumber = 2

                        vars.DrunkActive = true
                        vars.DrunkNumber = 2.0

                        ApplyRagdoll(ped, 2000)

                        secondEffect = true

                        return
                    end)
                elseif vars.BloodAmount <= 2000 and vars.BloodAmount >= 1000 and thirdEffect == false then
                    Citizen.CreateThread(function()
                        print("Applying Level 3 Screen Effects for Bleedout")

                        vars.AudioActive = true
                        vars.AudioNumber = 2

                        vars.DrunkActive = true
                        vars.DrunkNumber = 4.0

                        ApplyRagdoll(ped, 4000)

                        thirdEffect = true

                        return
                    end)
                end

                print("Blood Amount: " .. tostring(vars.BloodAmount) .. "\nBandages Active: " .. tostring(vars.BandageActive) .. "\nNumber of Normal Holes: " .. tostring(vars.NormalHoles) .. "\nNumber of Artery Holes: " .. tostring(vars.ArteryHoles))

                vars.BloodAmount = vars.BloodAmount - config.BloodLossRate
            end
        end)
    else
        vars.cancel = true
    end
end)

exports("SetBleedoutVariable", function(bandage, cheatyBandage)
    if bandage == true then
        vars.BandageActive = true
    end
    if cheatyBandage == true then
        vars.cancel = true
    end
end)

-- AUDIO
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if vars.AudioActive == true then
            print("Playing SFX from Bleedout")
            SetAudioSpecialEffectMode(vars.AudioNumber)
        end
        if vars.DrunkActive == true and vars.DrunkOn == false then
            print("Setting Camera Shake, " .. vars.DrunkNumber)
            vars.DrunkOn = true
            ShakeGameplayCam("DRUNK_SHAKE", vars.DrunkNumber)
        end
    end
end)

-- SYSTEM VALUE RESET --
RegisterNetEvent("sysValueReset_pBleedout")
AddEventHandler("sysValueReset_pBleedout", function()
    vars.BloodAmount = config.AmountOfBloodInBody
    vars.cancel = true
    vars.BandageActive = false
    vars.NormalHoles = 0
    vars.ArteryHoles = 0
    vars.AudioActive = false
    vars.AudioNumber = 0
    vars.DrunkActive = false
    vars.DrunkOn = false
    vars.DrunkNumber = 0.0
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)