Config = {}

Config.Target = "qtarget" 

Config.Weed = {}

Config.Weed.BlackMoney = true  -- give black money
Config.Weed.JointPrice = 100   -- price per 1 joint
Config.Weed.CannabisAmount = 8 -- cannabis plants in zone
Config.Weed.Blips = true       -- enable blips; false - disable blips

Config.Weed.Field = { coords = vector3(-1131.5, -1620.79, 4.3) }
Config.Weed.Package = vector3(-1144.01, -1607.81, 4.29)

Config.Weed.Locale = {
	NoSpace = "Not enough space in your inventory",
	NotEnoughUntrim = "You need at least 2x ~g~Untrimmed Cannabis",
	Gathering = "Gathering untrimmed cannabis...",
	Drying = "Drying untrimmed cannabis...",
	Packaging = "Packaging cannabis...",
	Joint = "Rolling a joint...",
	TargetGather = "Harvest 1x cannabis",
	TargetDry = "Dry untrimmed cannabis",
	BlipWeed = "Weed Farm",
	MakeJoint = "Roll a joint (2x Cannabis)",
	MakePackage = "Package weed (10x Cannabis)"
}

Config.Weed.Items = {
	joint =  "joint",
	bud = "weed_untrimmed",
	package = "weed_packaged"
}

Config.Meth = {}

Config.Meth.BarrelAmount = 10 -- barrel amount in field
Config.Meth.Blips = true -- enable blips; false - disable blips
Config.Meth.NeededMsg = true -- enable ingridients message; false - disable
Config.Meth.Chance = 5 -- chance of not getting anything from barrel 1 in 5

Config.Meth.MaxMeth = 1 -- What is maximum for meth that player can get after cooking it
Config.Meth.MinMeth = 1 -- What is minimum for meth that player can get after cooking it

Config.Meth.Chemical = {coords = vector3(1420.2, 6334.15, 24.6)}
Config.Meth.MethMix = {coords = vector3(1420.88, 6338.78, 23.59), h = 9.00}
Config.Meth.MakeMeth = {coords = vector3(1422.78, 6332.32, 23.65)}
Config.Meth.PackageMeth = {coords = vector3(1417.93, 6330.96, 23.99), h = 98.57}

Config.Meth.Locale = {
	Sold = "You sold meth bags for $",
	NoSpace = "Not enough space in your inventory",
	NoCookIngridients = "You need ~p~1x~y~ Mixed Meth Chemicals ~w~and ~p~1x~y~ Water Cooler Jug ~w~and ~p~1x~y~Ziplock Bag",
	NoItem = "You don't have meth bags",
	Using = "Someone is using it right now",
	Searching = "Searching for chemicals...",
	Making = "Mixing chemicals...",
	PourWater = "Pouring water...",
	PouringMethMix = "Pouring meth mix...",
	Cooking = "Cooking meth...",
	ReactionStart = "Reaction started",
	PackingMeth = "Packing meth into bag...",
	TargetPack = "Package meth",
	TargetSearch = "Search for chemicals",
	TargetMakeMix = "Make meth mix",
	TargetCook = "Cook meth",
	TargetSell = "Sell Meth Bag For $750 Each",
	BlipBarrel = "Chemical Barrels",
	BlipMakeMix = "Mixing Meth",
	BlipCookMeth = "Meth Cooking",
	BlipSell = "Meth Drug Dealer",
	Nothing = "You didn't find anything",
	YouFound = "You found",
	PickingMeth = "Picking meth...",
	NoNeeded = "You don't have enough ingredients or a plastic can",
	Needed = "You need ~p~1x~y~ Ammonia ~p~1x~y~ Lithium ~p~1x~y~ Ephedrine ~p~1x~y~ Iodine ~p~1x~y~ Phosphorus",
	NeedMeth = "You need at least ~p~1x~b~ Meth",
	Needed2 = "~p~1x~y~ Pseudoephedrine ~w~and ~p~1x~w~ ~b~Empty ~r~Can~w~ for carrying",
	NotEnoughSpace = "You cannot carry any more items"
}

Config.Meth.MixTime = 26000
Config.Meth.PackTime = 1500
Config.Meth.CookTime = {11000, 8000, 16000, 3000}

Config.Coke = {}

Config.Coke.Gathering = {
	vector4(-329.62, -2443.38, 7.16, 320.39),
	vector4(-331.24, -2445.38, 7.16, 320.398),
	vector4(-332.80, -2447.30, 7.16, 320.39)
}

Config.Coke.Processing = {
	vector4(-328.61, -2439.98, 7.16, 49.57),
	vector4(-327.83, -2436.67, 7.16, 140.25)
}

Config.Coke.Packaging = {
	vector4(-323.16, -2441.70, 7.09, 140.42)
}

Config.Coke.Locale = {
	NoSpace = "Not enough space in your inventory",
	GatherUncut = "Gather 1x Uncut Cocaine",
	ProccessUncut = "Proccess 5x Uncut Cocaine",
	PackageCut = "Package 1x Cut Cocaine",
	GatheringUncut = "Gathering Uncut Cocaine...",
	ProcessingUncut = "Processing Uncut Cocaine..",
	PackagingCut = "Packaging Cut Cocaine...",
	NotEnoughUncut,
	NotEnoughCut
}

Config.Coke.Items = {
 	uncut = "cocaine_uncut",
 	cut = "cocaine_cut",
 	package = "cocaine_packaged",
}

Config.Sales = {}

Config.Sales.LSPDRequired = 3
Config.Sales.SAHPRequired = 4

Config.Sales.Items = {
    ["cocaine_packaged"] = GetConvarInt('drugprices:coke', 800),
    ["dhm-pmeth"] = GetConvarInt('drugprices:meth', 800),
    ["weed_packaged"] = GetConvarInt('drugprices:weed', 600),
}

Config.Sales.ItemNames = { 'cocaine_packaged', 'coke_gram', 'dhm-pmeth', 'weed_packaged', 'cayo_cocaine_packaged' }

Config.Sales.DisallowedJobs = {
    ["ambulance"] = true,
    ["lspd"] = true,
    ["sahp"] = true,
    ["lscso"] = true,
    ["mecano"] = true,
    ["judge"] = true,
    ["taxi"] = true,
    ["wnews"] = true,
    ["casino"] = true
}

Config.Sales.JobsToNotify = {
	lspd = true, sahp = true, lscso = true
}

Config.Sales.BlacklistedPostals = {
    ["71"] = true,
    ["72"] = true,
    ["73"] = true,
    ["74"] = true,
    ["88"] = true,
    ["101"] = true,
    ["102"] = true,
    ["113"] = true,
    ["375"] = true,
    ["383"] = true,
    ["384"] = true,
    ["394"] = true,
    ["140"] = true,
    ["142"] = true,
    ["143"] = true,
    ["149"] = true,
    ["200"] = true,
    ["125"] = true,
    ["148"] = true,
    ["213"] = true,
    ["214"] = true,
    ["155"] = true,
    ["156"] = true,
    ["157"] = true,
    ["150"] = true,
    ["151"] = true,
    ["158"] = true,
    ["133"] = true
}


