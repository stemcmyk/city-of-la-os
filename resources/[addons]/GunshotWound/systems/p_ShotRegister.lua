-- VARIABLES --
local config = {}
local vars = {}

vars.ResourceName = GetCurrentResourceName()

vars.ArmorCache = {}
vars.WeaponCache = {}
vars.ArmorCacheActive = false
vars.WeaponCacheActive = false

vars.ArmorTable = {}
vars.WeaponTable = {}
vars.BoneTable = {}

vars.LastBoneUsed = 0

vars.ShotRegDelay = 0
vars.ShotRegDelayActive = false
vars.ShotRegFailsafeCount = 0

vars.ScreenFXSet = false

vars.OnlyArmor = 0
vars.ArmorSFXC = 0
vars.StoredArmorHits = 0

vars.StoredDamage = 0
vars.StoredBoneDamageMulti = 0

-- FUNCTIONS --

function ShotRegisterDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end

function ShotRegistrationDamageAndEffects(ped, instant, armor, damage, bone, weapon)
    -- DAMAGE
    if instant == false then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Not Fatal, Damage: ", math.floor(damage+0.5))
        ApplyDamageToPed(ped, math.floor(damage+0.5), armor)
    else
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Fatal Wound", "")
        ApplyDamageToPed(ped, 200, false)
        return
    end

    -- SCREEN EFFECTS
    if vars.WeaponTable.ScreenEffectAble == true and config.ScreenFX == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Screen FX True", "")
        -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
        Citizen.CreateThread(function()
            exports[vars.ResourceName]:SetEffectsVariable(0, true, ped, weapon, false)
            return
        end)
        vars.ScreenFXSet = true
        vars.ArmorSFXC = 0
    end
    -- RAGDOLL
    if vars.WeaponTable.RagdollAble == true and config.Ragdoll == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Ragdoll True", "")
        temp_RandomForAble = math.random(vars.WeaponTable.RagdollOdds.Odd1, vars.WeaponTable.RagdollOdds.Odd2)

        if temp_RandomForAble ~= vars.WeaponTable.RagdollOdds.Odd1 then
            ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Ragdoll Passed Odds", "")
            local ragTime

            if vars.WeaponTable.Type == "LESSLETHAL" and vars.BoneTable.ArmourAble == true and vars.ArmorTable.wearing == true then
                ragTime = math.random(vars.WeaponTable.RagdollOdds.MinTime * 100, vars.WeaponTable.RagdollOdds.MaxTime * 100)
            else
                ragTime = math.random(vars.WeaponTable.RagdollOdds.MinTime * 1000, vars.WeaponTable.RagdollOdds.MaxTime * 1000)
            end

            ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Rag Time: ", ragTime)
            ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Ragdoll Turned on ", ragTime)
            -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
            Citizen.CreateThread(function()
                exports[vars.ResourceName]:SetEffectsVariable(1, true, ped, ragTime)
                return
            end)
        end
    end
    -- PARALYZATION
    if vars.WeaponTable.IsAbleToStrikeArtery == true and vars.BoneTable.Paralyze == true and vars.BoneTable.ArmourAble == true and armor == true and config.Paralyzation == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Paralyze True", "")
        -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
        Citizen.CreateThread(function()
            exports[vars.ResourceName]:SetEffectsVariable(2, true, ped)
            return
        end)
    end
    -- LIMP
    if vars.BoneTable.Limp == true and config.Limp == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Leg True", "")
        -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
        Citizen.CreateThread(function()
            exports[vars.ResourceName]:SetEffectsVariable(3, true, ped)
            return
        end)
    end
    -- BLACKOUT
    if vars.WeaponTable.BlackOutAble == true and config.Blackout == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Blackout True", "")
        local temp_RandomForAble = math.random(vars.WeaponTable.BlackOutOdds.Odd1, vars.WeaponTable.BlackOutOdds.Odd2)

        if temp_RandomForAble == vars.WeaponTable.BlackOutOdds.Odd1 then
            ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Blackout Odds Passed", "")
            -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
            Citizen.CreateThread(function()
                exports[vars.ResourceName]:SetEffectsVariable(5, true, ped)
                return
            end)
        end
    end
    -- HAND
    if vars.BoneTable.Hand == true and (vars.WeaponTable.Type == "SHARP" or vars.WeaponTable.Type == "FIREARM") and config.Hand == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Hand", "")
        -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
        Citizen.CreateThread(function()
            exports[vars.ResourceName]:SetEffectsVariable(6, true, ped)
            return
        end)
    end
    -- BLEEDOUT
    if vars.WeaponTable.BleedOutAble == true and armor == false and config.Bleedout == true then
        ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Bleedout True", "")

        local activateArtery = false

        if vars.WeaponTable.IsAbleToStrikeArtery == true and vars.BoneTable.Artery == true then
            ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Artery True", "")
            if vars.BoneTable.ArteryOdds.Odd1 == math.random(vars.BoneTable.ArteryOdds.Odd1, vars.BoneTable.ArteryOdds.Odd2) then
                ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Atery Passed Odds True", "")
                activateArtery = true
            else
                ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Artery did not pass odds", "")
            end

        else
            ShotRegisterDebug("ShotRegistrationDamageAndEffects", "Artery False, Bleedout True", "")
        end

        -- THREAD CREATION TO FIX LONG CALCULATIONS DELAYING THE ENTIRE SCRIPT
        Citizen.CreateThread(function()
            exports[vars.ResourceName]:AddBleedout(true, activateArtery, ped)
            return
        end)
    end
end

function ShotRegistrationDelay(increase)
    if increase == false then
        if vars.ShotRegDelay == 1 then
            vars.ShotRegDelayActive = false
        else
            vars.ShotRegDelay = vars.ShotRegDelay - 1
            ShotRegisterDebug("ShotRegistrationDelay", vars.ShotRegDelay, "")
        end
    else
        if vars.ShotRegDelay == 0 then
            vars.ShotRegDelayActive = true
            vars.ShotRegDelay = 1
        else
            vars.ShotRegDelay = vars.ShotRegDelay + 1
            ShotRegisterDebug("ShotRegistrationDelay", vars.ShotRegDelay, "")
        end
    end
end

function ShotRegistration(ped)
    -- DEATH CHECK
    if IsEntityDead(ped) then
        if config.RemoveWeaponsOnDeath == true then
            RemoveAllPedWeapons(ped)
        end
        TriggerServerEvent("sysValueReset")
        Wait(5000) -- DELAY TO HELP LAG
        return
    end

    -- GET BONE & HIT
    local hit, bone = GetPedLastDamageBone(ped)

    -- CHECK THAT WE'RE GOOD
    if hit == 1 and vars.LastBoneUsed ~= bone and vars.ShotRegDelayActive == false then
        ShotRegisterDebug("ShotRegistration", "Hit good", "")

        vars.LastBoneUsed = bone

        -- CACHE CHECK
        if vars.WeaponCacheActive == false then -- ARMOR ONLY OR NEITHER
            TriggerEvent("c_ShotRegister_GetWeapon", ped)
            ShotRegistrationDelay(true)
            ShotRegisterDebug("ShotRegistration", "Weapon isn't in cache.", "")
        end
        if vars.ArmorCacheActive == false then -- WEAPON ONLY OR NEITHER
            TriggerEvent("c_ShotRegister_GetArmor", ped)
            ShotRegistrationDelay(true)
            ShotRegisterDebug("ShotRegistration", "Armor isn't in cache.", "")
        end
        TriggerEvent("c_ShotRegister_GetBone", bone)
        ShotRegistrationDelay(true)
        repeat
            Wait(0)
            if vars.ShotRegFailsafeCount == 200 then
                ShotRegisterDebug("ShotRegistration", "FAILSAFE ACTIVATED ", "Critical error: Delay past 500ms for getting datasets. Terminating.")
                vars.ShotRegFailsafeCount = 0
                return
            else
                vars.ShotRegFailsafeCount = vars.ShotRegFailsafeCount + 1
            end
        until( vars.ShotRegDelayActive == false )

        -- FATAL CHECK
        if vars.BoneTable.Fatal == true and vars.ArmorTable.helmet == false then
            -- ShotRegistrationDamageAndEffects(ped, true, false, 200, bone)
        end

        -- DAMAGE CHECK
        if vars.ArmorTable.wearing == true and vars.BoneTable.ArmourAble == true and vars.WeaponTable.MaxArmourLevel >= vars.ArmorTable.level and vars.ArmorTable.hits > 1 then
            local damage = vars.WeaponTable.BaseDamage * vars.WeaponTable.ArmourDamageMultiplier * vars.BoneTable.DamageMultiplier
            ShotRegisterDebug("ShotRegistration", "Wearing Armor ", damage)
            ShotRegistrationDamageAndEffects(ped, false, true, damage, bone, vars.WeaponTable.Hash)
        else
            local damage
            if vars.WeaponTable.BaseDamage == nil then
                damage = vars.StoredDamage * vars.StoredBoneDamageMulti
                ShotRegisterDebug("ShotRegistration", "NIL, Using backup", "")
            else
                damage = vars.WeaponTable.BaseDamage * vars.BoneTable.DamageMultiplier
                ShotRegisterDebug("ShotRegistration", "good to use normal", "")
            end
            ShotRegisterDebug("ShotRegistration", "Not Wearing Armor ", damage)
            ShotRegistrationDamageAndEffects(ped, false, false, damage, bone, vars.WeaponTable.Hash)
        end
    end
end

 -- EVENTS --

RegisterNetEvent("c_ShotRegister_ConfigSet")
AddEventHandler("c_ShotRegister_ConfigSet", function(configSent)
    config = configSent
    ShotRegisterDebug("c_ShotRegister_ConfigSet", "Config sent, debug status: ", "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug))
end)

RegisterNetEvent("c_ShotRegister_RecieveWeapon")
AddEventHandler("c_ShotRegister_RecieveWeapon", function(inTableSent, tableSent)
    if inTableSent == true then
        vars.WeaponTable = tableSent
        vars.StoredDamage = tableSent.BaseDamage
        ShotRegisterDebug("c_ShotRegister_RecieveWeapon", "Weapon table is set.", "")
        ShotRegistrationDelay(false)
    else
        ShotRegisterDebug("c_ShotRegister_RecieveWeapon", "Weapon table was unable to be set, weapon not in table.", "")
    end
end)

RegisterNetEvent("c_ShotRegister_RecieveBone")
AddEventHandler("c_ShotRegister_RecieveBone", function(inTableSent, tableSent)
    if inTableSent == true then
        vars.BoneTable = tableSent
        vars.StoredBoneDamageMulti = tableSent.DamageMultiplier
        ShotRegisterDebug("c_ShotRegister_RecieveBone", "Bone table is set.", "")
        ShotRegistrationDelay(false)
    end
end)

RegisterNetEvent("c_ShotRegister_RecieveArmor")
AddEventHandler("c_ShotRegister_RecieveArmor", function(inTableSent, hits, level, helmet)
    if inTableSent == true then
        local tts = {}
        tts.wearing = true
        tts.hits = hits
        tts.level = level
        tts.helmet = helmet
        if vars.StoredArmorHits >= 1 then
            tts.hits = vars.StoredArmorHits
        end
        vars.ArmorTable = tts
    else
        local tts = {}
        tts.wearing = false
        tts.hits = 0
        tts.level = 0
        tts.helmet = false
        vars.ArmorTable = tts
    end
    ShotRegisterDebug("c_ShotRegister_RecieveArmor", "Armor table is set.", "")
    ShotRegistrationDelay(false)
end)

RegisterNetEvent("sysValueReset_pShotReg")
AddEventHandler("sysValueReset_pShotReg", function()
    vars.ArmorCache = {}
    vars.WeaponCache = {}
    vars.ArmorCacheActive = false
    vars.WeaponCacheActive = false

    vars.ArmorTable = {}
    vars.WeaponTable = {}
    vars.BoneTable = {}

    vars.LastBoneUsed = 0

    vars.ShotRegDelay = 0
    vars.ShotRegDelayActive = false
    vars.ShotRegFailsafeCount = 0

    vars.ScreenFXSet = false

    vars.OnlyArmor = 0
    vars.ArmorSFXC = 0
    vars.StoredArmorHits = 0

    vars.StoredDamage = 0
    vars.StoredBoneDamageMulti = 0
end)

-- CACHE --

AddEventHandler("pCache_SentArmor", function(tableSent)
    vars.ArmorCache = tableSent
    vars.ArmorCacheActive = true
end)
AddEventHandler("pCache_SentWeapons", function(tableSent)
    vars.WeaponCache = tableSent
    vars.WeaponCacheActive = true
end)


-- LOOPS --

-- Citizen.CreateThread(function ()
--     local ped
-- 	while true do
-- 		Wait(0)
--         ped = PlayerPedId()
--         ShotRegistration(ped)
-- 	end
-- end)