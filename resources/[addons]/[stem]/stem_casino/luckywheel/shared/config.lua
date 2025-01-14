Config_LuckyWheel = {}
Config = {}
Config.Locale = 'en'
Config_LuckyWheel.ESX = 'esx:getSharedObject'

Config_LuckyWheel.DailySpin = true				-- If true it will let players to spin once per day
Config_LuckyWheel.ResetSpin = {h = 9, m = 0}	-- What time will reset the daily spins | Works only if Config.DailySpin is true
Config_LuckyWheel.SpinMoney = 5000				-- How much will each spin cost | Works only if Config.DailySpin is false (player must have the money in inventory)
Config_LuckyWheel.SpawnWheel = true			-- If your map does NOT have the wheel, set it to true. if your map has already a wheel set it to false
Config_LuckyWheel.WheelPos = {x = 964.64, y = 49.32, z = 80.56, h = 58.00}	-- Where the wheel prop will spawn OR where wheel prop is
Config_LuckyWheel.VehiclePos = {x = 970.05, y = 46.03, z = 80.33, h = 0}
Config_LuckyWheel.VehicleRot = true			-- If true then the vehicle will rotate slowly
Config_LuckyWheel.VehicleWinPos = {x = 933.29, y = -3.33, z = 78.34, h = 149.51}	-- Where the vehicle will spawn if a player win it

-- First it will pick a random
-- type: weapon, money, item, car (for money it will give only in bank)
-- name: the DB name,
-- count:

-- probability: the script will generate a number from 1 to 1000
-- if the random number is between a and b player will win
-- random number must be bigger than a and smaller or equal to b
-- if rnd > a and rnd <= b

-- available sounds: 'car', 'cash', 'chips', 'clothes', 'mystery', 'win'
Config_LuckyWheel.Prices = {
	[1]  = {type = 'car', 		name = 'car', 					count = 1, 		sound = 'car', 		probability = {a =   0, b =   1}},	--  0.1 %   0.1 -- VEHICLE
	[2]  = {type = 'weapon', 	name = 'WEAPON_1911', 			count = 1, 		sound = 'clothes', 	probability = {a =   1, b =   5}},	--  0.4 %   0.5 -- 15.000 RP
	[3]  = {type = 'weapon', 	name = 'random', 				count = 1, 		sound = 'mystery', 	probability = {a =   5, b =  10}},	--  0.5 %   1.0 -- CLOTHING
	[4]  = {type = 'chips', 	name = 'casino_comp_chips', 	count = 25000, 	sound = 'chips', 	probability = {a =  10, b =  20}},	--  1.0 %   2.0 -- 25.000 chips
	[5]  = {type = 'money', 	name = 'money', 				count = 40000, 	sound = 'cash', 	probability = {a =  20, b =  30}},	--  1.0 %   4.0 -- 40.000 $
	[6]  = {type = 'weapon', 	name = 'WEAPON_1911',			count = 1, 		sound = 'clothes', 	probability = {a =  30, b =  45}},	--  1.5 %   6.0 -- 10.000 RP
	[7]  = {type = 'weapon', 	name = 'random', 				count = 1, 		sound = 'mystery', 	probability = {a =  45, b =  50}},	--  0.5 %   8.0 -- CLOTHING
	[8]  = {type = 'mystery', 	name = 'mystery',				count = 1, 		sound = 'mystery', 	probability = {a =  50, b =  100}},	--  5.0 %  12.0 -- MYSTERY
	[9]  = {type = 'chips', 	name = 'casino_comp_chips', 	count = 20000, 	sound = 'chips', 	probability = {a = 	100, b = 150}},	--  5.0 %  17.0 -- 20.000 chips
	[10] = {type = 'weapon', 	name = 'WEAPON_P226', 			count = 1, 		sound = 'clothes', 	probability = {a = 150, b = 200}},	--  5.0 %  22.0 -- 7.500 RP
	[11] = {type = 'weapon',	name = 'random', 				count = 1, 		sound = 'mystery', 	probability = {a = 200, b = 205}},	--  0.5 %  28.0 -- CLOTHING
	[12] = {type = 'chips', 	name = 'casino_comp_chips', 	count = 15000, 	sound = 'chips', 	probability = {a = 205, b = 330}},	--  12.5 % 34.0 -- 15.000 chips
	[13] = {type = 'money', 	name = 'money', 				count = 30000, 	sound = 'cash', 	probability = {a = 330, b = 340}},	--  1.0 %  41.0 -- 30.000 $
	[14] = {type = 'weapon', 	name = 'WEAPON_M9', 			count = 1, 		sound = 'clothes', 	probability = {a = 340, b = 440}},	--  10.0 % 48.0 -- 5.000 RP
	[15] = {type = 'souvenir', 	name = 'random', 				count = 1, 		sound = 'mystery', 	probability = {a = 440, b = 450}},	--  1.0 %  56.0 -- DISCOUNT
	[16] = {type = 'chips',		name = 'casino_comp_chips', 	count = 10000, 	sound = 'chips', 	probability = {a = 450, b = 830}},	--  38.0 % 64.0 -- 10.000 chips
	[17] = {type = 'money',		name = 'money', 				count = 20000, 	sound = 'cash', 	probability = {a = 830, b = 840}},	--  1.0 %  72.0 -- 20.000 $
	[18] = {type = 'weapon', 	name = 'WEAPON_P238',			count = 1, 		sound = 'clothes', 	probability = {a = 840, b = 990}},	--  15.0 % 81.0 -- 2.500 RP
	[19] = {type = 'weapon', 	name = 'random',				count = 1, 		sound = 'mystery', 	probability = {a = 990, b = 995}},	--  0.5 %  90.0 -- CLOTHING
	[20] = {type = 'money', 	name = 'money', 				count = 50000, 	sound = 'cash', 	probability = {a = 995, b = 1000}},	-- 	0.5 % -- 50.000 $
}