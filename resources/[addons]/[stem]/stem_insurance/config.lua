Config = {}

Config.Name = "Insurance Office"

Config.DefaultInsurancePrice = 1000
Config.InsurancePrices = {
    [0] = 500,      -- Compacts
    [1] = 750,        -- Sedans
    [2] = 500,      -- Compacts
    [3] = 1000,    -- Coupes
    [4] = 750,    -- Muscle
    [5] = 1250,  -- Sports Classics
    [6] = 1500,  -- Sports
    [7] = 2500,      -- Super
    [8] = 1250,        -- Motorcycles
    [9] = 1000,      -- Off-road
    [10] = 1500,       -- Industrial
    [11] = 1500,       -- Utility
    [12] = 1000,       -- Vans
    [13] = 250, -- Cycles
    [14] = 2000,       -- Boats
    [15] = 2500,     -- Helicopters
    [16] = 5000,     -- Planes
    [17] = 1500, -- Service
    -- [18] = { 'hard', 'medium', 'hard' },     -- Emergency
    -- [19] = { 'hard', 'hard', 'hard' },       -- Military
    [20] = 1500,     -- Commercial
    -- [21] = { 'easy', 'easy', 'easy' }, -- Trains
    -- [22] = { 'easy', 'easy', 'easy' }, -- Open Wheel?
}
Config.RecoverMultiplier = 0.5;

Config.InsuranceOffice = {
    pedModel = "a_m_y_business_01",
    pedLocation = vector4(114.61, -209.25, 53.63, 359.97)
}

Config.Locale = {
    ["already_recovered"] = "Your vehicle can only be recovered **once**~ every 24 hours.",
    ["already_out"] = "Your vehicle has been located and marked on your **GPS**",
    ["already_garage"] = "Your vehicle is already in a garage and does not need to be recovered",
    ["impounded"] = "Your vehicle is **IMPOUNDED** and cannot be recovered.", "error",
    ["success"] = "Your vehicle has been **recovered** and returned to a public garage.",
    ["not_enough_money"] = "You do not have enough money to purchase insurance for this vehicle",
    ["purchase_complete"] = "You paid **$ %s** for insurance on **%s**.",
    ["insurance_canceled"] = "You hace cancelled your insurance policy"
}

Config.Blip = {
    Sprite = 810,
    Scale = 0.8,
    Colour = 30
}