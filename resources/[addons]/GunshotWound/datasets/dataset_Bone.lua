local config = {}
-- CONFIG --
config.Debug = true
-- END OF CONFIG --
-- DEBUG --
function DebugPrint(msg)
    if config.Debug == true then
        print("GSW | " .. tostring(msg))
    end
end
-- END OF DEBUG --
-- ARMOUR TABLES --
local BoneTable = {
    [11816] = {
        -- SKEL_Pelvis
        Hash = 11816, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 5
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 3, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [58271] = {
        -- SKEL_L_Thigh
        Hash = 58271, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 5
        },
        DamageMultiplier = 0.9, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [63931] = {
        -- SKEL_L_Calf
        Hash = 63931, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 5
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 1, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [14201] = {
        -- SKEL_L_Foot
        Hash = 14201, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 1, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [2108] = {
        -- SKEL_L_Toe0
        Hash = 2108, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [65245] = {
        -- IK_L_Foot
        Hash = 65245, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [57717] = {
        -- PH_L_Foot
        Hash = 57717, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [46078] = {
        -- MH_L_Knee
        Hash = 46078, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [51826] = {
        -- SKEL_R_Thigh
        Hash = 51826, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 5
        },
        DamageMultiplier = 0.9, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [36864] = {
        -- SKEL_R_Calf
        Hash = 36864, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [52301] = {
        -- SKEL_R_Foot
        Hash = 52301, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [20781] = {
        -- SKEL_R_Toe0
        Hash = 20781, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [35502] = {
        -- IK_R_Foot
        Hash = 35502, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [24806] = {
        -- PH_R_Foot
        Hash = 24806, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [16335] = {
        -- MH_R_Knee
        Hash = 16335, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [23639] = {
        -- RB_L_ThighRoll
        Hash = 23639, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 5
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [6442] = {
        -- RB_R_ThighRoll
        Hash = 6442, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 5
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = true, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [57597] = {
        -- SKEL_Spine_Root
        Hash = 57597, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 2
        },
        DamageMultiplier = 1.2, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = true,
        Helmet = false
    },
    [23553] = {
        -- SKEL_Spine0
        Hash = 23553, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 2
        },
        DamageMultiplier = 1.2, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = true,
        Helmet = false
    },
    [24816] = {
        -- SKEL_Spine1
        Hash = 24816, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 2
        },
        DamageMultiplier = 1.2, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = true,
        Helmet = false
    },
    [24817] = {
        -- SKEL_Spine2
        Hash = 24817, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 2, -- ODDS OF HITTING ARTERY
            Odd2 = 4
        },
        DamageMultiplier = 1.2, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = true,
        Helmet = false
    },
    [24818] = {
        -- SKEL_Spine3
        Hash = 24818, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 3, -- ODDS OF HITTING ARTERY
            Odd2 = 4
        },
        DamageMultiplier = 1.2, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = true,
        Helmet = false
    },
    [64729] = {
        -- SKEL_L_Clavicle
        Hash = 64729, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 2, -- ODDS OF HITTING ARTERY
            Odd2 = 6
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [45509] = {
        -- SKEL_L_UpperArm
        Hash = 45509, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [61163] = {
        -- SKEL_L_Forearm
        Hash = 61163, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [18905] = {
        -- SKEL_L_Hand
        Hash = 18905, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [26610] = {
        -- SKEL_L_Finger00
        Hash = 26610, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4089] = {
        -- SKEL_L_Finger01
        Hash = 4089, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4090] = {
        -- SKEL_L_Finger02
        Hash = 4090, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [26611] = {
        -- SKEL_L_Finger10
        Hash = 26611, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4169] = {
        -- SKEL_L_Finger11
        Hash = 4169, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4170] = {
        -- SKEL_L_Finger12
        Hash = 4170, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [26612] = {
        -- SKEL_L_Finger20
        Hash = 26612, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4185] = {
        -- SKEL_L_Finger21
        Hash = 4185, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4186] = {
        -- SKEL_L_Finger22
        Hash = 4186, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [26613] = {
        -- SKEL_L_Finger30
        Hash = 26613, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4137] = {
        -- SKEL_L_Finger31
        Hash = 4137, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4138] = {
        -- SKEL_L_Finger32
        Hash = 4138, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [26614] = {
        -- SKEL_L_Finger40
        Hash = 26614, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4153] = {
        -- SKEL_L_Finger41
        Hash = 4153, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [4154] = {
        -- SKEL_L_Finger42
        Hash = 4154, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [60309] = {
        -- PH_L_Hand
        Hash = 60309, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [36029] = {
        -- IK_L_Hand
        Hash = 36029, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [61007] = {
        -- RB_L_ForeArmRoll
        Hash = 61007, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [5232] = {
        -- RB_L_ArmRoll
        Hash = 5232, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [22711] = {
        -- NAMMH_L_ElbowE
        Hash = 22711, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.6, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [10706] = {
        -- SKEL_R_Clavicle
        Hash = 10706, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 2, -- ODDS OF HITTING ARTERY
            Odd2 = 6
        },
        DamageMultiplier = 0.9, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = true,
        Helmet = false
    },
    [40269] = {
        -- SKEL_R_UpperArm
        Hash = 40269, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [28252] = {
        -- SKEL_R_Forearm
        Hash = 28252, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [57005] = {
        -- SKEL_R_Hand
        Hash = 57005, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [58866] = {
        -- SKEL_R_Finger00
        Hash = 58866, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64016] = {
        -- SKEL_R_Finger01
        Hash = 64016, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64017] = {
        -- SKEL_R_Finger02
        Hash = 64017, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [58867] = {
        -- SKEL_R_Finger10
        Hash = 58867, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64096] = {
        -- SKEL_R_Finger11
        Hash = 64096, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64097] = {
        -- SKEL_R_Finger12
        Hash = 64097, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [58868] = {
        -- SKEL_R_Finger20
        Hash = 58868, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64112] = {
        -- SKEL_R_Finger21
        Hash = 64112, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64113] = {
        -- SKEL_R_Finger22
        Hash = 64113, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [58869] = {
        -- SKEL_R_Finger30
        Hash = 58869, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64064] = {
        -- SKEL_R_Finger31
        Hash = 64064, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64065] = {
        -- SKEL_R_Finger32
        Hash = 64065, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [58870] = {
        -- SKEL_R_Finger40
        Hash = 58870, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64080] = {
        -- SKEL_R_Finger41
        Hash = 64080, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [64081] = {
        -- SKEL_R_Finger42
        Hash = 64081, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [28422] = {
        -- PH_R_Hand
        Hash = 28422, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [6286] = {
        -- IK_R_Hand
        Hash = 6286, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.1, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = true, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [43810] = {
        -- RB_R_ForeArmRoll
        Hash = 43810, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [37119] = {
        -- RB_R_ArmRoll
        Hash = 37119, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [2992] = {
        -- MH_R_Elbow
        Hash = 2992, -- HASH OF THE BONE
        Fatal = false, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 7
        },
        DamageMultiplier = 0.8, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [35731] = {
        -- RB_Neck_1
        Hash = 35731, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 2
        },
        DamageMultiplier = 1.5, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [39317] = {
        -- SKEL_Neck_1
        Hash = 39317, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = true, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 2
        },
        DamageMultiplier = 1.5, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = true, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = false
    },
    [31086] = {
        -- A HEAD HASH
        Hash = 31086, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [12844] = {
        -- A HEAD HASH
        Hash = 12844, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [65068] = {
        -- A HEAD HASH
        Hash = 65068, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [58331] = {
        -- A HEAD HASH
        Hash = 58331, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [45750] = {
        -- A HEAD HASH
        Hash = 45750, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [25260] = {
        -- A HEAD HASH
        Hash = 25260, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [21550] = {
        -- A HEAD HASH
        Hash = 21550, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [29868] = {
        -- A HEAD HASH
        Hash = 29868, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [43536] = {
        -- A HEAD HASH
        Hash = 43536, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [27474] = {
        -- A HEAD HASH
        Hash = 27474, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [19336] = {
        -- A HEAD HASH
        Hash = 19336, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [1356] = {
        -- A HEAD HASH
        Hash = 1356, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [11174] = {
        -- A HEAD HASH
        Hash = 11174, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [37193] = {
        -- A HEAD HASH
        Hash = 37193, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [20178] = {
        -- A HEAD HASH
        Hash = 20178, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [61839] = {
        -- A HEAD HASH
        Hash = 61839, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [20279] = {
        -- A HEAD HASH
        Hash = 20279, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [17719] = {
        -- A HEAD HASH
        Hash = 17719, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [46240] = {
        -- A HEAD HASH
        Hash = 46240, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [17188] = {
        -- A HEAD HASH
        Hash = 17188, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [20623] = {
        -- A HEAD HASH
        Hash = 20623, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [47419] = {
        -- A HEAD HASH
        Hash = 47419, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [49979] = {
        -- A HEAD HASH
        Hash = 49979, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [47495] = {
        -- A HEAD HASH
        Hash = 47495, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    },
    [56604] = {
        -- A HEAD HASH
        Hash = 56604, -- HASH OF THE BONE
        Fatal = true, -- SHOULD THEY BE INSTANTLY KILLED?
        Artery = false, -- BLEED THEM OUT FASTER?
        ArteryOdds = {
            Odd1 = 1, -- ODDS OF HITTING ARTERY
            Odd2 = 3
        },
        DamageMultiplier = 1.0, -- EXTRA DAMAGE?
        Limp = false, -- GIVE THEM A LIMP?
        Paralyze = false, -- PARALYZE THEM?
        Paralyzation = {
            Odd1 = 1,
            Odd2 = 5
        },
        Hand = false, -- IS THIS BONE A HAND?
        Severity = 2, -- SEVERITY?
        ArmourAble = false,
        Helmet = true
    }
}
-- END OF ARMOUR TABLES --
-- EVENTS --
AddEventHandler(
    "c_ShotRegister_GetBone",
    function(bone) -- GET BONE DATA
        local tValue = BoneTable[bone]
        if tValue == nil then
            print("GSW: CRITICAL, BONE MISSING FROM INDEX. PLEASE REPORT TO DEVELOPER. BONEID: " .. bone)
            return
        end
        TriggerServerEvent("s_ShotRegister_PassBone", true, tValue)
    end
)
-- END OF EVENTS --

function getBoneFromTable(bone)
    return BoneTable[bone]
end

exports("getBoneFromTable", getBoneFromTable)
