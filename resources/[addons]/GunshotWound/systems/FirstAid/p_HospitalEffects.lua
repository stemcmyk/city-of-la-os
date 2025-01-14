-- VARIABLES --
local vars = {
    blackscreen = false,
    heartbeatMonitor = false,
    heartbeatMonitorDelay = 0,
    Malpractice = false,
    MalpracticeCounter = 0,
    RandomLossAndRevival = false,
    RandomLossCounter = 0,
    RandomRevivalCounter = 0,
    deadsound = false,
    deadsoundPlaying = false,
    deadsoundSoundId
}
local config = {}
-- DEBUG PRINT --
function EffectsDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end
-- GET CONFIG --
RegisterNetEvent("c_Effects_ConfigSet")
AddEventHandler(
    "c_Effects_ConfigSet",
    function(configSent)
        config = configSent
        EffectsDebug(
            "c_Effects_ConfigSet",
            "Config sent, debug status: ",
            "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug)
        )
    end
)
-- QUICK LOOP --
Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if vars.blackscreen == true then
                DrawRect(0.5, 0.5, 1.0, 1.0, 0, 0, 0, 255)
            end
        end
    end
)
-- DELAY LOOP --
Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if vars.heartbeatMonitor == true then
                local s = GetSoundId()
                PlaySoundFromEntity(s, "IDLE_BEEP", PlayerPedId(), "EPSILONISM_04_SOUNDSET", false, false)
                EffectsDebug("DELAY LOOP", "Played sound.", "")
                ReleaseSoundId(s)
                if vars.Malpractice == true then
                    if vars.MalpracticeCounter == config.HospitalMalpracticeCounterThreshold then
                        vars.heartbeatMonitor = false
                        vars.deadsound = true
                        vars.MalpracticeCounter = 0
                    else
                        vars.MalpracticeCounter = vars.MalpracticeCounter + 1
                        EffectsDebug("MALPRACTICE COUNTER: ", vars.MalpracticeCounter, "")
                    end
                end
                if vars.RandomLossAndRevival == true then
                    if vars.RandomLossCounter == config.HospitalRandomLossCounterThreshold then
                        vars.heartbeatMonitor = false
                        vars.deadsound = true
                        vars.deadsoundPlaying = false
                        vars.RandomLossCounter = 0
                    else
                        vars.RandomLossCounter = vars.RandomLossCounter + 1
                        EffectsDebug("RandomLossCounter: ", vars.RandomLossCounter, "")
                    end
                end
                Wait(vars.heartbeatMonitorDelay)
            end

            if vars.deadsound == true and vars.deadsoundPlaying == false then
                local s = GetSoundId()
                PlaySoundFromEntity(s, "CONTINUAL_BEEP", PlayerPedId(), "EPSILONISM_04_SOUNDSET", false, false)
                EffectsDebug("DELAY LOOP", "Playing death sound.", "")
                if vars.RandomLossAndRevival == false then
                    TriggerEvent("playerDiedFromMalpractice")
                end
                vars.deadsoundSoundId = s
                vars.deadsoundPlaying = true
            end

            if vars.RandomLossAndRevival == true and vars.deadsoundPlaying == true then
                if vars.RandomRevivalCounter == 5 then
                    StopSound(vars.deadsoundSoundId)
                    ReleaseSoundId(vars.deadsoundSoundId)
                    vars.deadsoundPlaying = false
                    vars.heartbeatMonitor = true
                    vars.deadsound = false
                    vars.RandomRevivalCounter = 0
                    vars.RandomLossAndRevival = false
                else
                    vars.RandomRevivalCounter = vars.RandomRevivalCounter + 1
                    EffectsDebug("RandomRevivalCounter: ", vars.RandomRevivalCounter, "")
                end
                Wait(vars.heartbeatMonitorDelay)
            end
            if vars.deadsoundPlaying == true and vars.Malpractice == false and RandomLossAndRevival == false then
                StopSound(vars.deadsoundSoundId)
                ReleaseSoundId(vars.deadsoundSoundId)
                vars.deadsound = false
                vars.deadsoundPlaying = false
            end
            if IsEntityDead(PlayerPedId()) then
                StopSound(vars.deadsoundSoundId)
                ReleaseSoundId(vars.deadsoundSoundId)
                vars.deadsound = false
                vars.deadsoundPlaying = false
            end
        end
    end
)
-- EVENTS --
AddEventHandler(
    "client_effects_blackscreen",
    function(changeTo)
        vars.blackscreen = changeTo
        EffectsDebug("client_effects_blackscreen", "Setting blackout to: " .. tostring(changeTo), "")
    end
)
AddEventHandler(
    "client_effects_heartmonitor",
    function(changeTo, Malpractice, time, RandomLossAndRevival)
        vars.heartbeatMonitor = changeTo
        vars.heartbeatMonitorDelay = time
        vars.Malpractice = Malpractice
        vars.RandomLossAndRevival = RandomLossAndRevival
        EffectsDebug(
            "client_effects_heartmonitor",
            "Setting heartbeat beep to: " .. tostring(changeTo),
            ". Delay: " .. tostring(time) .. ". Malpractice: " .. tostring(Malpractice) .. ". RandomLossAndRevival: " .. tostring(RandomLossAndRevival)
        )
    end
)
