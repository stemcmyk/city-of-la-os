return {
    Debug = false,
    Framework = "esx",
    Police = {
        jobs = {
            ["lspd"] = 2,
            ["sahp"] = 2,
            ["lscso"] = 1
        }
    },
    MinimumPolice = 1,
    Dispatch = 'ps-dispatch', -- If using qb-dispatch otherwise add your export in client policeCall function
    RequiredItem = 'atmhacker',
    InventoryType = 'ox_inventory',
    LabelIcon = 'fa-solid fa-user-ninja',
    ProgressDuration = 7500,
    Emotes = 'rpemotes', -- If using rpemotes otherwise anything else for scully_emotemenu
    PossibleTerritories = true, -- Integrates my paid territrory script - https://possible-scripts.tebex.io/package/6045013 set false if no likey
    PossibleGangLevel = true, -- Integrates my paid gang level script - https://possible-scripts.tebex.io/package/6036883 set false if no likey
    Cash = true,
    CashItem = 'black_money',
    DirtyCashType = 'markedbills', -- If using qb-inventory and cahs = false
    MinReward = 1500, 
    MaxReward = 3000,
    NotifPosition = 'top'
}