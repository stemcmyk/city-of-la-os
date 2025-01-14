local chembarrel = {}
local busyg = false
local busyd = false
local barrelprop, x = nil
local npcped = nil
local gameprops = 0
local spawned = 0
local maketable, makebarrel = nil, nil


local function load(time, label, animationDictionary, animationName)
	if LocalPlayer.state.invOpen then
		exports.ox_inventory:closeInventory()
	end

	LocalPlayer.state.blockClearTasks = true
	LocalPlayer.state.invBusy = true

	local progress = exports.ox_lib:progressCircle({
		duration = time,
		label = label,
		anim = {
			dict = animationDictionary,
			clip = animationName,
			blendIn = 1.0, 
			blendOut = 1.0, 
			duration = -1,
		},
		useWhileDead = false,
		canCancel = true,
		disable = {
			car = true,
			move = true,
		},
	})
	LocalPlayer.state.blockClearTasks = nil
	LocalPlayer.state.invBusy = false

	return progress
end

Citizen.CreateThread(
	function()
		modelHash = GetHashKey("a_m_y_breakdance_01")
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Wait(0)
		end
		spawnneeds()
	end
)

function spawnneeds()
	if spawned == 0 then
		maketable = CreateObject("bkr_prop_weed_table_01b", Config.Meth.MethMix.coords.x, Config.Meth.MethMix.coords.y,
			Config.Meth.MethMix.coords.z, false, false, true)
		SetEntityHeading(maketable, Config.Meth.MethMix.h)
		FreezeEntityPosition(maketable, true)
		PlaceObjectOnGroundProperly(maketable)
		makebarrel = CreateObject("prop_barrel_03a", Config.Meth.MakeMeth.coords.x, Config.Meth.MakeMeth.coords.y,
			Config.Meth.MakeMeth.coords.z, false, false, true)
		SetEntityHeading(makebarrel, Config.Meth.MakeMeth.h)
		FreezeEntityPosition(makebarrel, true)
		PlaceObjectOnGroundProperly(makebarrel)
		spawned = 1
	end
end

Citizen.CreateThread(
	function()
		local c = Config.Meth.MethMix.coords
		local cx = Config.Meth.MakeMeth.coords
		local cy = Config.Meth.PackageMeth.coords

		local propz = {
			1928959797
		}

		exports[Config.Target]:AddCircleZone(
			"mix",
			vector3(c.x, c.y, c.z + 1.4),
			1.4,
			{
				name = "mix",
				debugPoly = false,
				useZ = false
			},
			{
				options = {
					{
						event = "stem_drugs:meth:premix",
						icon = "fas fa-pills",
						label = Config.Meth.Locale.TargetMakeMix
					}
				},
				job = { "all" },
				distance = 3
			}
		)
		exports[Config.Target]:AddCircleZone(
			"cook",
			vector3(cx.x, cx.y, cx.z - 0.5),
			1.4,
			{
				name = "cook",
				debugPoly = false,
				useZ = true
			},
			{
				options = {
					{
						event = "stem_drugs:meth:precook",
						icon = "fas fa-pills",
						label = Config.Meth.Locale.TargetCook
					}
				},
				job = { "all" },
				distance = 2
			}
		)
		exports[Config.Target]:AddCircleZone(
			"pack",
			vector3(cy.x, cy.y, cy.z + 0.5),
			1.4,
			{
				name = "pack",
				-- debugPoly = true,
				useZ = true
			},
			{
				options = {
					{
						event = "stem_drugs:meth:pack",
						icon = "fas fa-pills",
						label = Config.Meth.Locale.TargetPack
					}
				},
				job = { "all" },
				distance = 2
			}
		)
	end
)

RegisterNetEvent("stem_drugs:meth:premix")
AddEventHandler(
	"stem_drugs:meth:premix",
	function()
		ESX.TriggerServerCallback(
			"stem_drugs:meth:busy",
			function(busy)
				if busy then
					notif(Config.Meth.Locale.Using)
				elseif not busy then
					TriggerEvent("stem_drugs:meth:mix")
				end
			end,
			1
		)
	end
)
RegisterNetEvent("stem_drugs:meth:pack")
AddEventHandler(
	"stem_drugs:meth:pack",
	function()
		local ped = PlayerPedId()
		if (busyp) then return end
		

		ESX.TriggerServerCallback(
			"stem_drugs:meth:busy",
			function(busy)
				if busy then
					notif(Config.Meth.Locale.Using)
				elseif not busy then
					TriggerServerEvent("stem_drugs:meth:busy", true, 3)
					busyp = true
					ESX.TriggerServerCallback(
						"stem_drugs:meth:pack",
						function(have)
							if have then
								local response = load(Config.Meth.PackTime, Config.Meth.Locale.PackingMeth, "mp_arresting", "a_uncuff")
								if (response) then 
									TriggerServerEvent("stem_drugs:meth:pack")
								end
		
								ClearPedTasks(ped)
								FreezeEntityPosition(ped, false)
								busyp = false
								TriggerServerEvent("stem_drugs:meth:busy", false, 3)
							else
								TriggerServerEvent("stem_drugs:meth:busy", false, 3)
								busyp = false
							end
						end
					)
				end
			end,
			3
		)
	end
)
function waterbottlea()
	LocalPlayer.state:set(
		"propData",
		{
			model = GetHashKey("prop_water_bottle_dark"),
			boneIndex = 57005,
			offset = vector3(0.1, 0.11, -0.05),
			rotation = vector3(180.0, 0.0, 0.0),
			rotationOrder = 1
		},
		true
	)
	Wait(11000)
	LocalPlayer.state:set("propData", nil, true)
end

function methmixa()
	LocalPlayer.state:set(
		"propData",
		{
			model = GetHashKey("bkr_prop_meth_hcacid"),
			boneIndex = 57005,
			offset = vector3(0.1, 0.09, -0.02),
			rotation = vector3(200.0, 0.0, 0.0),
			rotationOrder = 1
		},
		true
	)
	Wait(8000)
	LocalPlayer.state:set("propData", nil, true)
end

RegisterNetEvent("stem_drugs:meth:precook")
AddEventHandler(
	"stem_drugs:meth:precook",
	function()
		ESX.TriggerServerCallback(
			"stem_drugs:meth:busy",
			function(busy)
				if busy then
					notif(Config.Meth.Locale.Using)
				elseif not busy then
					TriggerEvent("stem_drugs:meth:cook")
				end
			end,
			2
		)
	end
)

RegisterNetEvent("stem_drugs:meth:mix")
AddEventHandler(
	"stem_drugs:meth:mix",
	function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local mixcrd = Config.Meth.MethMix.coords

		if not busyd then
			busyd = true
			TriggerServerEvent("stem_drugs:meth:busy", true, 1)
			ESX.TriggerServerCallback(
				"stem_drugs:meth:mixmix",
				function(have)
					if have then
						-- SetEntityCoords(ped, mixcrd.x + 0.8, mixcrd.y, mixcrd.z - 0.7, 1, 0, 0, 1)
						-- SetEntityHeading(ped, 100.0)
						local jerrycan = CreateObject("bkr_prop_meth_hcacid", mixcrd.x + 0.25, mixcrd.y + 0.4,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(jerrycan, 180.0)
						PlaceObjectOnGroundProperly(jerrycan)
						FreezeEntityPosition(jerrycan, true)
						local bowlas = CreateObject("apa_mp_h_acc_bowl_ceramic_01", mixcrd.x + 0.25, mixcrd.y,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(bowlas, 180.0)
						PlaceObjectOnGroundProperly(bowlas)
						FreezeEntityPosition(bowlas, true)

						local bottle1 = CreateObject("bkr_prop_coke_bottle_02a", mixcrd.x + 0.16, mixcrd.y - 0.47,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(bottle1, 180.0)
						PlaceObjectOnGroundProperly(bottle1)
						FreezeEntityPosition(bottle1, true)
						local bottle2 = CreateObject("bkr_prop_coke_powderbottle_01", mixcrd.x + 0.03, mixcrd.y - 0.4,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(bottle2, 180.0)
						PlaceObjectOnGroundProperly(bottle2)
						FreezeEntityPosition(bottle2, true)
						local bottle3 = CreateObject("p_cs_script_bottle_s", mixcrd.x + 0.07, mixcrd.y - 0.2,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(bottle3, 180.0)
						PlaceObjectOnGroundProperly(bottle3)
						FreezeEntityPosition(bottle3, true)
						local bottle4 = CreateObject("p_weed_bottle_s", mixcrd.x, mixcrd.y - 0.18, mixcrd.z - 0.15, false,
							true, true)
						SetEntityHeading(bottle4, 180.0)
						PlaceObjectOnGroundProperly(bottle4)
						FreezeEntityPosition(bottle4, true)
						local bottle5 = CreateObject("stt_prop_lives_bottle", mixcrd.x - 0.03, mixcrd.y - 0.07,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(bottle5, 180.0)
						PlaceObjectOnGroundProperly(bottle5)
						FreezeEntityPosition(bottle5, true)
						local bottle6 = CreateObject("prop_cs_script_bottle_01", mixcrd.x + 0.2, mixcrd.y - 0.3,
							mixcrd.z - 0.15, false, true, true)
						SetEntityHeading(bottle6, 180.0)
						PlaceObjectOnGroundProperly(bottle6)
						FreezeEntityPosition(bottle6, true)

						RequestAnimDict("mp_arresting")
						while (not HasAnimDictLoaded("mp_arresting")) do
							Citizen.Wait(0)
						end
						local response = true
						Citizen.CreateThread(function () 
							Citizen.Wait(Config.Meth.MixTime - 4000)
							if (not response) then return end

							SetEntityCoords(jerrycan, mixcrd.x + 0.28, mixcrd.y, mixcrd.z - 0.3)
							SetEntityCoords(bowlas, mixcrd.x + 0.22, mixcrd.y - 0.6, mixcrd.z - 0.15)
							PlaceObjectOnGroundProperly(jerrycan)
							PlaceObjectOnGroundProperly(bowlas)
							TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, -8.0, -1, 0, 0, false, false, false)
						end)
						local response = load(Config.Meth.MixTime, Config.Meth.Locale.Making, "mp_arresting", "a_uncuff")
						if (response) then 
							TriggerServerEvent("stem_drugs:meth:mix")
						 end

						ClearPedTasks(ped)
						FreezeEntityPosition(ped, false)
						DeleteEntity(bowlas)
						DeleteEntity(jerrycan)
						busyd = false
						TriggerServerEvent("stem_drugs:meth:busy", false, 1)
					else
						TriggerServerEvent("stem_drugs:meth:busy", false, 1)
						busyd = false
						notif(Config.Meth.Locale.NoNeeded)
						-- if Config.Meth.NeededMsg then
						-- 	notif(Config.Meth.Locale.Needed)
						-- 	notif(Config.Meth.Locale.Needed2)
						-- end
					end
				end
			)
		end
	end
)

RegisterNetEvent("stem_drugs:meth:steam")
AddEventHandler(
	"stem_drugs:meth:steam",
	function()
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(0)
			end
		end
		SetPtfxAssetNextCall("core")
		local steam =
			StartParticleFxLoopedAtCoord(
				"ent_amb_smoke_gaswork",
				Config.Meth.MakeMeth.coords.x,
				Config.Meth.MakeMeth.coords.y,
				Config.Meth.MakeMeth.coords.z + 0.8,
				0.0,
				0.0,
				0.0,
				5.0,
				false,
				false,
				false,
				false
			)
		SetParticleFxLoopedAlpha(steam, 0.9)
		SetParticleFxLoopedColour(steam, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(30000)
		StopParticleFxLooped(steam, 0)
	end
)

function cancelCook()
	TriggerServerEvent("stem_drugs:meth:busy", false, 2)
	busyp = false
	FreezeEntityPosition(ped, false)
end

RegisterNetEvent("stem_drugs:meth:cook")
AddEventHandler(
	"stem_drugs:meth:cook",
	function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		if not busyp then
			TriggerServerEvent("stem_drugs:meth:busy", true, 2)
			busyp = true
			ESX.TriggerServerCallback(
				"stem_drugs:meth:chemical",
				function(have)
					if have then
						-- SetEntityCoords(ped, Config.Meth.MakeMeth.coords.x + 0.4, Config.Meth.MakeMeth.coords.y + 0.6, Config.Meth.MakeMeth.coords.z - 0.7, 1, 0, 0, 1)
						-- SetEntityHeading(ped, 150.0)
						PlaceObjectOnGroundProperly(ped)
						FreezeEntityPosition(ped, true)

						Citizen.CreateThread(waterbottlea)
						local state = load(Config.Meth.CookTime[1], Config.Meth.Locale.PourWater, "weapons@first_person@aim_lt@generic@misc@jerrycan@", "fire_intro_med")
						if (not state) then
							cancelCook()
							LocalPlayer.state:set("propData", nil, true)
							return
						end
						Citizen.CreateThread(methmixa)
						local state = load(Config.Meth.CookTime[2], Config.Meth.Locale.PouringMethMix, "weapons@first_person@aim_lt@generic@misc@jerrycan@","fire_intro_med")
						if (not state) then
							cancelCook()
							LocalPlayer.state:set("propData", nil, true)
							return
						end
						Citizen.CreateThread(function () 
							notif(Config.Meth.Locale.ReactionStart)
							TriggerServerEvent("stem_drugs:meth:steam")
							PlaceObjectOnGroundProperly(ped)
						end)
						local state = load(Config.Meth.CookTime[3], Config.Meth.Locale.Cooking)
						if (not state) then
							cancelCook()
							return
						end
						
						local state = load(Config.Meth.CookTime[4], Config.Meth.Locale.PickingMeth)
						if (not state) then
							cancelCook()
							return
						end
						RequestAnimDict("random@domestic")
						while (not HasAnimDictLoaded("random@domestic")) do
							Citizen.Wait(0)
						end
						TaskPlayAnim(ped, "random@domestic", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)
						FreezeEntityPosition(ped, false)
						TriggerServerEvent("stem_drugs:meth:cook")
						TriggerServerEvent("stem_drugs:meth:busy", false, 2)
						busyp = false
					else
						TriggerServerEvent("stem_drugs:meth:busy", false, 2)
						busyp = false
					end
				end
			)
		end
	end
)

RegisterNetEvent("stem_drugs:meth:methbag")
AddEventHandler(
	"stem_drugs:meth:methbag",
	function()
		local ped = PlayerPedId()
		RequestAnimDict("mp_arresting")
		while (not HasAnimDictLoaded("mp_arresting")) do
			Citizen.Wait(0)
		end
		TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, -8.0, -1, 0, 0, false, false, false)
		Citizen.Wait(4000)
		ClearPedTasks(ped)
	end
)

AddEventHandler(
	"onResourceStop",
	function(resource)
		if resource == GetCurrentResourceName() then
			deleteas()
		end
	end
)
function notif(text)
	TriggerEvent("esx:showNotification", text)
end

Citizen.CreateThread(
	function()
		if Config.Meth.Blips then
			local blips = {
				{
					title = Config.Meth.Locale.BlipBarrel,
					colour = 3,
					id = 499,
					x = Config.Meth.Chemical.coords.x,
					y = Config.Meth.Chemical.coords.y,
					z = Config.Meth.Chemical.coords.z
				}
			}

			for _, dhm in pairs(blips) do
				dhm.blip = AddBlipForCoord(dhm.x, dhm.y, dhm.z)
				SetBlipSprite(dhm.blip, dhm.id)
				SetBlipDisplay(dhm.blip, 5)
				SetBlipScale(dhm.blip, 0.6)
				SetBlipColour(dhm.blip, dhm.colour)
				SetBlipAsShortRange(dhm.blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(dhm.title)
				EndTextCommandSetBlipName(dhm.blip)
			end
		end
	end
)
