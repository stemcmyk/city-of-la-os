local config = {}
-- CONFIG --

-- DEBUG/TEST/DEV ITEMS --
config.Debug = false -- Debug Messages
config.TestingItems = false -- DEV ITEM, DONT TURN ON. THE SCRIPT WILL DO WEIRD RANDOM STUFF.

-- UNIVERSAL ITEMS --
config.ScreenFX = false -- Do we enable ScreenFX Feature?
config.Ragdoll = false -- Do we enable Ragdoll Feature?
config.Paralyzation = true -- Do we enable Paralyzation Feature?
config.Limp = true -- Do we enable Limp Feature?
config.Blackout = false -- Do we enable Blackout Feature?
config.Bleedout = false -- Do we enable Bleedout Feature?
config.Hand = true -- Do we enable Hand Feature?
config.TunnelVision = false -- Do we enable Tunnel Vision Feature?

-- MISC SETTING ITEMS --
config.DefaultLessLethal = true -- Are you utilizing the default Less Lethal Options in the databases? When this is true, it disables the stock GTA 5 damage for the 2 Less Lethal Weapons.
config.StopRegeneration = true -- Stops health regeneration
config.RemoveReticle = true -- Removes the reticle from players screen
config.RemoveWeaponsOnDeath = false -- Removes weapon on death.

-- BLEEDOUT ITEMS --
config.AmountOfBloodInBody = 6700 -- How much blood the player has (Will be divided by current health)
config.BloodLossDamage = 1 -- How much damage is given to the player every 20 bleedout cycles
config.BloodAmountForBlackout = 1000 -- How much blood should be left in the player before they pass out? Default Amount based on: https://www.healthline.com/health/how-much-blood-can-you-lose#shock
config.NormalBleedoutDelay = 1000 -- How long we should wait until we loop the bleedout loop, for normal bleeding injuries (in ms)
config.ArteryBleedoutDelay = 100 -- How long we should wait until we loop the bleedout loop, for severed arteries (in ms)
config.BloodLossRate = 1 -- How much blood should we take from the player every 100 ms
config.BloodTrialTimeout = 1800000 -- How long (in ms) until the blood gets removed. -1 = infinite. Default is 30 minutes.

-- EFFECT ITEMS --
config.BlackoutCounterLength = 1000 -- How many ticks will the player be blacked out for?
config.ScreenEffectCounterLegnth = 120 -- How many seconds should screen effects be active for before turned off?

-- FIRST AID ITEMS --
config.HospitalPrompts = true -- Should we give the player control prompts?
config.UseVehicleClass = true -- Should we check if the car is an emergency vehicle, or use the CarsAbleToGiveFirstAid table
config.CarsAbleToGiveFirstAid = {
    [1] = {
        Name = "e450ambo", -- SPAWN CODE FOR THE CAR
        BandageType = 1 -- WHAT BANDAGE TYPE TO USE FOR THIS CAR?
    }
}
config.CarBandageType = 1 -- Type of bandages we should use for cars
config.HopistalWorkTime = 10000 -- How long should the player be in the hospital for while recovering? (in milliseconds)
config.HospitalRandomLossCounterThreshold = 7 -- At what value should we do the "Random Loss and Revival" function. (It ticks up as go)
config.HospitalMalpracticeCounterThreshold = 15 -- At what value should we do "Malpractice" function. (It ticks up as beeps go)
config.HospitalUsageDelay = 60000 -- How long the script should stop the player from using the hospital after they use it (in ms)
config.StoreBandageType = 1 -- What bandages should we give to the player from stores?
--
--[[
    MEDID LIST:
    1 = Turn off bleeding if artery is not severed, slow down bleeding if artery is severed
    2 = Turn off bleeding no matter what
    3 = MedID 1 + Turns off Limp Damage
    4 = MedID 2 + Turns off Limp Damage
]] config.BandageTypes = {
    [1] = {
        Name = "Tourniquet",
        TypeID = 2,
        MedID = 2
    }
}
config.Hospitals = {
    -- ["Davis - Emergency Door"] = {
    --     x = 294.32, -- X Value for the door you walk up to in order to get hospital aid.
    --     y = -1449.02, -- Y Value for the door you walk up to in order to get hospital aid.
    --     z = 140.28, -- Z Value for the door you walk up to in order to get hospital aid.
    --     MaxDist = 1.5, -- Max Distance you can be from the X,Y,and Z to get hospital aid.
    --     outX = 308.03, -- "Out Patient" X Value.
    --     outY = -1433.37, -- "Out Patient" Y Value.
    --     outZ = 29.97, -- "Out Patient" Z Value.
    --     outH = 139.06 -- "Out Patient" Heading(H) Value.
    -- },
    ["Pillbox Hospital"] = {
        x = 311.59,
        y = -594.09,
        z = 42.29,
        heading = 341.842,
        MaxDist = 2.5,
        outX = 321.49,
        outY = -583.97,
        outZ = 42.28,
        outH = 69.45
    },
    ["Lower Pillbox Hospital"] = {
        x = 349.37,
        y = -587.66,
        z = 27.8,
        heading = 253.06,
        MaxDist = 2.5,
        outX = 364.73,
        outY = -583.33,
        outZ = 42.28,
        outH = 156.7
    },
    ["Sandy Shores Hospital"] = {
        x = 1832.62,
        y = 3676.55,
        z = 33.28,
        heading = 293.30,
        MaxDist = 2.5,
        outX = 1826.50,
        outY = 3679.86,
        outZ = 34.28,
        outH = 299.57
    },
    ["Mount Zonah Hospital"] = {
        x = -435.37,
        y = -324.12,
        z = 33.91,
        heading = 163.28,
        MaxDist = 2.5,
        outX = -458.54,
        outY = -282.56,
        outZ = 34.91,
        outH = 196.75
    },
    ["Paleto Hospital"] = {
        x = -255.80,
        y = 6330.65,
        z = 31.43,
        heading = 315.57,
        MaxDist = 2.5,
        outX = -251.53,
        outY = 6317.02,
        outZ = 32.43,
        outH = 317.94
    }
}
config.StoreLocations = {
    ["Pillbox"] = {
        x = 316.75,
        y = -588.10,
        z = 43.29,
        MaxDist = 2.5
    },
    ["Sandy"] = {
        x = 1830.6,
        y = 3681.59,
        z = 34.27,
        MaxDist = 2.5
    }
}

-- END OF CONFIG --

if config.Debug == true then
    print("config.lua || Sending config.")
end

TriggerServerEvent("s_FirstAid_ConfigSet", config)

if config.Debug == true then
    print("config.lua || Sent config successfully.")
end
