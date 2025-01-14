local config = {}
-- CONFIG --
config.Debug = true
config.G1DamageBase = 3
config.G2DamageBase = 12
config.G3DamageBase = 20
config.G4DamageBase = 2
config.G5DamageBase = 45
config.G6DamageBase = 70
-- END OF CONFIG --
-- DEBUG --
function DebugPrint(msg)
    if config.Debug == true then
        print("GSW | " .. tostring(msg))
    end
end
-- END OF DEBUG --
-- WEAPON TABLES --
local G1weaponTable = {
    [2725352035] = { -- UNARMED / FISTS
        Hash = 2725352035, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.01, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 10 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = false, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3, -- N2
            MinTime = 1, -- Min Ragdoll Time (In Seconds)
            MaxTime = 2 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [1737195953] = { -- NIGHTSTICK
        Hash = 1737195953, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [1317494643] = { -- HAMMER
        Hash = 1317494643, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.1, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [2508868239] = { -- BAT
        Hash = 2508868239, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.2, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 8 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [1141786504] = { -- GOLFCLUB
        Hash = 1141786504, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.1, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [2227010557] = { -- CROWBAR
        Hash = 2227010557, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.1, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 6 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [3638508604] = { -- KNUCKLE
        Hash = 3638508604, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.1, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 2, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 1, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [2484171525] = { -- POOLCUE
        Hash = 2484171525, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.1, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 3 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 1, -- Min Ragdoll Time (In Seconds)
            MaxTime = 3 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [419712736] = { -- WRENCH
        Hash = 419712736, -- HASH KEY
        BaseDamage = config.G1DamageBase * 1.1, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.07, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 5, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 1, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "BLUNT"
    },
    [2578778090] = { -- KNIFE
        Hash = 2578778090, -- HASH KEY
        BaseDamage = config.G1DamageBase * 2.0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 1, -- Min Ragdoll Time (In Seconds)
            MaxTime = 4 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    },
    [4192643659] = { -- BOTTLE
        Hash = 4192643659, -- HASH KEY
        BaseDamage = config.G1DamageBase * 2.5, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 6 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    },
    [2460120199] = { -- DAGGER
        Hash = 2460120199, -- HASH KEY
        BaseDamage = config.G1DamageBase * 2.3, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 4, -- Min Ragdoll Time (In Seconds)
            MaxTime = 8 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    },
    [4191993645] = { -- HACHET
        Hash = 4191993645, -- HASH KEY
        BaseDamage = config.G1DamageBase * 2.9, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 20 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    },
    [3713923289] = { -- MACHETE
        Hash = 3713923289, -- HASH KEY
        BaseDamage = config.G1DamageBase * 3.0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 20 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    },
    [3756226112] = { -- SWITCHBLADE
        Hash = 3756226112, -- HASH KEY
        BaseDamage = config.G1DamageBase * 2.0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 6 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    },
    [3441901897] = { -- BATTLEAXE
        Hash = 3441901897, -- HASH KEY
        BaseDamage = config.G1DamageBase * 2.8, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.05, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 1, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2, -- N2
            MinTime = 4, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "SHARP"
    }
}
local G2weaponTable = {
    [584646201] = { -- APPISTOL
        Hash = 584646201, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [1593441988] = { -- COMBATPISTOL
        Hash = 1593441988, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.20, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3523564046] = { -- HEAVYPISTOL
        Hash = 3523564046, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.30, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3218215474] = { -- SNSPISTOL
        Hash = 3218215474, -- HASH KEY
        BaseDamage = config.G2DamageBase * 0.80, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [453432689] = { -- PISTOL
        Hash = 453432689, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3219281620] = { -- PISTOLMK2
        Hash = 3219281620, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3696079510] = { -- MARKSMANPISTOL
        Hash = 3696079510, -- HASH KEY
        BaseDamage = config.G2DamageBase * 0.30, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [137902532] = { -- VINTAGEPISTOL
        Hash = 137902532, -- HASH KEY
        BaseDamage = config.G2DamageBase * 0.80, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2548703416] = { -- DOUBLEACTION
        Hash = 2548703416, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3249783761] = { -- WEAPON_REVOLVER
        Hash = 3249783761, -- HASH KEY
        BaseDamage = config.G2DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [911657153] = { -- WEAPON_STUNGUN
        Hash = 911657153, -- HASH KEY
        BaseDamage = 0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 20 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        -- HEY, HEY YOU. With the stun gun, turning off ragdoll completely by game standards is not possible by changing this value, as I don't override it. You can only really disable the script ragdoll.
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 50, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "LESSLETHAL"
    }
}
local G3weaponTable = {
    [2741846334] = { -- RAN OVER BY VEHICLE
        Hash = 2741846334, -- HASH KEY
        BaseDamage = config.G3DamageBase * 0.10, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.9, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 2 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 2, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 10, -- N2
            MinTime = 10, -- Min Ragdoll Time (In Seconds)
            MaxTime = 30 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "MVA"
    },
    [171789620] = { -- COMBATPDW
        Hash = 171789620, -- HASH KEY
        BaseDamage = config.G3DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [736523883] = { -- SMG
        Hash = 736523883, -- HASH KEY
        BaseDamage = config.G3DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2024373456] = { -- SMGMK2
        Hash = 2024373456, -- HASH KEY
        BaseDamage = 0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 100 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 9999, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "LESSLETHAL" -- LESS LETHAL
    },
    [324215364] = { -- MICROSMG
        Hash = 324215364, -- HASH KEY
        BaseDamage = config.G3DamageBase * 0.50, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3675956304] = { -- MACHINEPISTOL
        Hash = 3675956304, -- HASH KEY
        BaseDamage = config.G3DamageBase * 0.50, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3173288789] = { -- MINISMG
        Hash = 3173288789, -- HASH KEY
        BaseDamage = config.G3DamageBase * 0.60, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [162746534] = { -- GERMAN SMG, No clue what its called off the top of my head.
        Hash = 162746534, -- HASH KEY
        BaseDamage = config.G3DamageBase * 0.60, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.10, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2828843422] = { -- MUSKET
        Hash = 2828843422, -- HASH KEY
        BaseDamage = config.G3DamageBase * 0.10, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.8, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 2, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    }
}
local G4weaponTable = {
    [317205821] = { -- WEAPON_AUTOSHOTGUN
        Hash = 317205821, -- HASH KEY
        BaseDamage = config.G4DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3800352039] = { -- WEAPON_ASSAULTSHOTGUN
        Hash = 3800352039, -- HASH KEY
        BaseDamage = config.G4DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2640438543] = { -- WEAPON_BULLPUPSHOTGUN
        Hash = 2640438543, -- HASH KEY
        BaseDamage = config.G4DamageBase * 2.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2017895192] = { -- WEAPON_SAWNOFFSHOTGUN
        Hash = 2017895192, -- HASH KEY
        BaseDamage = config.G4DamageBase * 2.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [487013001] = { -- WEAPON_PUMPSHOTGUN
        Hash = 487013001, -- HASH KEY
        BaseDamage = config.G4DamageBase * 2.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [1432025498] = { -- WEAPON_PUMPSHOTGUN_MK2
        Hash = 1432025498, -- HASH KEY
        BaseDamage = 0, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = false, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 100, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 5 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = false, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "LESSLETHAL" -- LESS LETHAL.
    },
    [984333226] = { -- WEAPON_HEAVYSHOTGUN
        Hash = 984333226, -- HASH KEY
        BaseDamage = config.G4DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [4019527611] = { -- WEAPON_DBSHOTGUN
        Hash = 4019527611, -- HASH KEY
        BaseDamage = config.G4DamageBase * 2.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 5, -- Min Ragdoll Time (In Seconds)
            MaxTime = 10 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    }
}
local G5weaponTable = {
    [1649403952] = { -- WEAPON_COMPACTRIFLE
        Hash = 1649403952, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3231910285] = { -- WEAPON_SPECIALCARBINE
        Hash = 3231910285, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2937143193] = { -- WEAPON_ADVANCEDRIFLE
        Hash = 2937143193, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [4024951519] = { -- WEAPON_ASSAULTSMG
        Hash = 4024951519, -- HASH KEY
        BaseDamage = config.G5DamageBase * 0.90, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 2, -- Min Ragdoll Time (In Seconds)
            MaxTime = 7 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2228681469] = { -- WEAPON_BULLPUPRIFLE_MK2
        Hash = 2228681469, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2132975508] = { -- WEAPON_BULLPUPRIFLE
        Hash = 2132975508, -- HASH KEY
        BaseDamage = config.G5DamageBase * 0.90, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2210333304] = { -- WEAPON_CARBINERIFLE
        Hash = 2210333304, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [4208062921] = { -- WEAPON_CARBINERIFLE_MK2
        Hash = 4208062921, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [3220176749] = { -- WEAPON_ASSAULTRIFLE
        Hash = 3220176749, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = false, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [961495388] = { -- WEAPON_ASSAULTRIFLE_MK2
        Hash = 961495388, -- HASH KEY
        BaseDamage = config.G5DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 3, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    }
}
local G6weaponTable = {
    [3342088282] = { -- WEAPON_MARKSMANRIFLE
        Hash = 3342088282, -- HASH KEY
        BaseDamage = config.G6DamageBase * 1.10, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 10, -- Min Ragdoll Time (In Seconds)
            MaxTime = 18 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [1785463520] = { -- WEAPON_MARKSMANRIFLE_MK2
        Hash = 1785463520, -- HASH KEY
        BaseDamage = config.G6DamageBase * 1.20, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 10, -- Min Ragdoll Time (In Seconds)
            MaxTime = 18 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [100416529] = { -- WEAPON_SNIPERRIFLE
        Hash = 100416529, -- HASH KEY
        BaseDamage = config.G6DamageBase * 1.30, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.15, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 3, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 10, -- Min Ragdoll Time (In Seconds)
            MaxTime = 18 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2634544996] = { -- WEAPON_MG
        Hash = 2634544996, -- HASH KEY
        BaseDamage = config.G6DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.25, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 4, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 7, -- Min Ragdoll Time (In Seconds)
            MaxTime = 13 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2144741730] = { -- WEAPON_COMBATMG
        Hash = 2144741730, -- HASH KEY
        BaseDamage = config.G6DamageBase * 1.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.25, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 4, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 8, -- Min Ragdoll Time (In Seconds)
            MaxTime = 15 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [2578377531] = { -- WEAPON_PISTOL50
        Hash = 2578377531, -- HASH KEY
        BaseDamage = config.G6DamageBase * 2.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.35, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 5, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 10, -- Min Ragdoll Time (In Seconds)
            MaxTime = 18 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [205991906] = { -- WEAPON_HEAVYSNIPER
        Hash = 205991906, -- HASH KEY
        BaseDamage = config.G6DamageBase * 2.50, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.35, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 5, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 20, -- Min Ragdoll Time (In Seconds)
            MaxTime = 40 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    },
    [177293209] = { -- WEAPON_HEAVYSNIPER_MK2
        Hash = 177293209, -- HASH KEY
        BaseDamage = config.G6DamageBase * 3.00, -- DAMAGE TO DO IF NO ARMOUR ON
        ArmourDamageMultiplier = 0.35, -- DAMAGE TO DO IF ARMOUR ON
        MaxArmourLevel = 5, -- MAX ARMOUR THAT WILL PROTECT, ANH = NO ARMOUR HELPS
        BlackOutAble = true, -- IS PLAYER ABLE TO BE KNOCKED OUT
        BlackOutOdds = { -- ODDS OF BEING KNOCKED OUT BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 40 -- N2
        },
        BleedOutAble = true, -- IS PLAYER ABLE TO BLEED OUT
        Severity = 4, -- SEVERITY OF A WOUND CAUSED BY THIS WEAPON BETWEEN 1 AND 5
        ScreenEffectAble = true, -- SHOULD A SCREEN EFFECT BE APPLIED
        ScreenEffectSeverity = math.random(1,20), -- HOW BAD SHOULD THE SCREEN EFFECT BE. MAX IS 20, MIN IS 1. I HAVE IT SET TO RANDOM, BUT YOU CAN SET YOUR MANUALLY.
        RagdollAble = true, -- IS PLAYER ABLE TO RAGDOLL
        RagdollOdds = { -- ODDS OF **NOT** BEING RAGDOLLED BETWEEN:
            Odd1 = 1, -- N1, AND
            Odd2 = 5, -- N2
            MinTime = 20, -- Min Ragdoll Time (In Seconds)
            MaxTime = 50 -- Max Ragdoll Time (In Seconds)
        },
        IsAbleToStrikeArtery = true, -- IS IT ABLE TO STRIKE INTO THE ARTERY
        Type = "FIREARM"
    }
}
-- END OF WEAPON TABLES --
-- EVENT REGISTER --
RegisterNetEvent("getWeaponInfo_1_StC")
RegisterNetEvent("getWeaponInfo_2_StC")
RegisterNetEvent("getWeaponInfo_3_StC")
RegisterNetEvent("getWeaponInfo_4_StC")
RegisterNetEvent("getWeaponInfo_5_StC")
RegisterNetEvent("getWeaponInfo_6_StC")
-- END OF EVENT REGISTER --
-- EVENTS --
AddEventHandler("getWeaponInfo_1_StC", function(ped, hashSent) -- GET WEAPON PED WAS HIT WITH
    local wTable = G1weaponTable[hashSent]
    if wTable == nil then
        TriggerServerEvent("s_ShotRegister_PassWpn", false)
    else
        TriggerServerEvent("s_ShotRegister_PassWpn", true, wTable)
        TriggerEvent("pCache_SetWeapons", wTable)
    end
end)
AddEventHandler("getWeaponInfo_2_StC", function(ped, hashSent) -- GET WEAPON PED WAS HIT WITH
    local wTable = G2weaponTable[hashSent]
    if wTable == nil then
        TriggerServerEvent("s_ShotRegister_PassWpn", false)
    else
        TriggerServerEvent("s_ShotRegister_PassWpn", true, wTable)
        TriggerEvent("pCache_SetWeapons", wTable)
    end
end)
AddEventHandler("getWeaponInfo_3_StC", function(ped, hashSent) -- GET WEAPON PED WAS HIT WITH
    local wTable = G3weaponTable[hashSent]
    if wTable == nil then
        TriggerServerEvent("s_ShotRegister_PassWpn", false)
    else
        TriggerServerEvent("s_ShotRegister_PassWpn", true, wTable)
        TriggerEvent("pCache_SetWeapons", wTable)
    end
end)
AddEventHandler("getWeaponInfo_4_StC", function(ped, hashSent) -- GET WEAPON PED WAS HIT WITH
    local wTable = G4weaponTable[hashSent]
    if wTable == nil then
        TriggerServerEvent("s_ShotRegister_PassWpn", false)
    else
        TriggerServerEvent("s_ShotRegister_PassWpn", true, wTable)
        TriggerEvent("pCache_SetWeapons", wTable)
    end
end)
AddEventHandler("getWeaponInfo_5_StC", function(ped, hashSent) -- GET WEAPON PED WAS HIT WITH
    local wTable = G5weaponTable[hashSent]
    if wTable == nil then
        TriggerServerEvent("s_ShotRegister_PassWpn", false)
    else
        TriggerServerEvent("s_ShotRegister_PassWpn", true, wTable)
        TriggerEvent("pCache_SetWeapons", wTable)
    end
end)
AddEventHandler("getWeaponInfo_6_StC", function(ped, hashSent) -- GET WEAPON PED WAS HIT WITH
    local wTable = G6weaponTable[hashSent]
    if wTable == nil then
        TriggerServerEvent("s_ShotRegister_PassWpn", false)
    else
        TriggerServerEvent("s_ShotRegister_PassWpn", true, wTable)
        TriggerEvent("pCache_SetWeapons", wTable)
    end
end)
-- END OF EVENTS --