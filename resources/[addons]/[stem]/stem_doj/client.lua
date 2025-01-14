local nr_courtJailCoords = nil

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() or not Config do
			Wait(0)
		end

		local blip = AddBlipForCoord(Config.BlipCoords)
		SetBlipSprite(blip, 419)
		SetBlipScale(blip, 1.05)
		SetBlipAsShortRange(blip, true)
		SetBlipDisplay(blip, 2)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Courthouse")
		EndTextCommandSetBlipName(blip)
	end
)

function clearAnim()
    for _, v in pairs(GetGamePool("CObject")) do
      if IsEntityAttachedToEntity(cache.ped, v) then
        SetEntityAsMissionEntity(v, true, true)
        DeleteObject(v)
        DeleteEntity(v)
      end
    end
	ClearPedTasks(PlayerPedId())
end

RegisterCommand("testFlight", function ()
	TriggerServerEvent("stem_doj:checkFlight")
end)

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Citizen.Wait(1000)
		end

		local firstSpawn = true

		AddEventHandler(
			"playerSpawned",
			function()
				if firstSpawn then
					firstSpawn = false
					TriggerServerEvent("stem_doj:checkFlight")
				end
			end
		)

		exports.qtarget:AddCircleZone(
			"DA_MDT",
			vector3(-557.46, -229.06, 34.13), 0.3, {
				name = "DA_MDT",
				useZ = true,
				--debugPoly=true
			},
			{
				options = {
					{
						action = function()
							TriggerEvent("noire_nui:openMdt")
						end,
						canInteract = function()
							return LocalPlayer.state.contextualSitting == true
						end,
						icon = "fas fa-desktop",
						label = "Use Computer",
					},
				},
				distance = 2.0
			}
		)

		exports.qtarget:AddBoxZone(
			"Court_Podium",
			vector3(-572.82, -207.99, 38.23), 1.0, 0.6, {
				name = "Court_Podium",
				heading = 30,
				--debugPoly=true,
				minZ = 37.23,
				maxZ = 41.23
			},
			{
				options = {
					{
						action = function()
							TriggerEvent("noire_nui:openMdt", "https://mdt.noire.cloud/publicrecords/home")
						end,
						icon = "far fa-file-pdf",
						label = "View Public Court Records",
					},
					{
						action = function()
							TriggerEvent("noire_nui:openDOJDashboard")
						end,
						icon = "fa-solid fa-tablet-screen-button",
						label = "View DOJ Stats",
						job = { ["judge"] = 0, ["lspd"] = 0, ["sahp"] = 0, ["lscso"] = 0 }
					}
				},
				distance = 2.0
			}
		)

		exports["qtarget"]:AddBoxZone(
			"Court_Management",
			vector3(-588.22, -203.7, 38.23),
			1.4,
			0.8,
			{
				name = "Court_Management",
				heading = 300,
				--debugPoly=true,
				minZ = 37.23,
				maxZ = 40.23
			},
			{
				options = {
					{
						event = "stem_doj:accessFunds",
						icon = "fas fa-piggy-bank",
						label = "Access Court Funds",
						job = { ["judge"] = 3 }
					},
					{
						event = "stem_doj:barManagement",
						icon = "fas fa-balance-scale",
						label = "State Bar Management",
						job = { ["judge"] = 3 }
					}
				},
				distance = 1.5
			}
		)

		exports["qtarget"]:Player(
			{
				options = {
					{
						action = function(ent)
							OpenManageChargesMenu(NetworkGetPlayerIndexFromPed(ent))
						end,
						canInteract = function(ent)
							return IsEntityAPed(ent) and not IsPedDeadOrDying(ent)
						end,
						index = 1,
						icon = "fas fa-clipboard-list",
						label = "View Player's Charges",
						job = { ["judge"] = 2 }
					},
					{
						action = function(ent)
							exports["noire_nui"]:OpenJailPlayerMenu(NetworkGetPlayerIndexFromPed(ent))
						end,
						canInteract = function(ent)
							return IsEntityAPed(ent) and not IsPedDeadOrDying(ent)
						end,
						index = 3,
						icon = "fas fa-bars",
						label = "Jail Player",
						job = { ["judge"] = 2 }
					}
				},
				distance = 2.0
			}
		)
	end
)

AddEventHandler(
	"stem_doj:accessFunds",
	function()
		TriggerEvent(
			"esx_society:openBoscookiessMenu",
			"judge",
			function(data, menu)
				menu.close()
			end,
			{
				withdraw = true,
				checkbalance = true,
				employees = false
			}
		)
	end
)

AddEventHandler(
	"stem_doj:barManagement",
	function()
		TriggerEvent(
			"esx_society:openBoscookiessMenu",
			"judge",
			function(data2, menu2)
				menu2.close()
			end
		)
	end
)

RegisterNetEvent("stem_doj:courtLogin")
AddEventHandler(
	"stem_doj:courtLogin",
	function(isPrison)
		if GlobalState.jobCount["doj.2"] and GlobalState.jobCount["doj.2"] > 0 then
			while not LocalPlayer.state.switchComplete do
				Citizen.Wait(0)
			end

			local num = math.random(#Config.Cells)
			local cell = Config.Cells[num]

			DoScreenFadeOut(3000)
			Citizen.Wait(3000)
			SetEntityCoords(PlayerPedId(), cell.x, cell.y, cell.z, false, false, false, false)
			SetEntityHeading(PlayerPedId(), cell.heading)

			FreezeEntityPosition(PlayerPedId(), true)

			RequestCollisionAtCoord(cell.x, cell.y, cell.z)
			while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
				RequestCollisionAtCoord(cell.x, cell.y, cell.z)
				Citizen.Wait(0)
			end

			FreezeEntityPosition(PlayerPedId(), false)

			Citizen.Wait(3000)
			DoScreenFadeIn(3000)

			TriggerServerEvent("stem_doj:svAddToDocket", num)
			TriggerServerEvent("stem_doj:svAlertCourt", num)

			if (not isPrison) then
				ESX.ShowHelpNotification(
					"You have unresolved charges from a not guilty or no contest plea. Please wait for a court officer or attorney.")
			end
		end
	end
)

RegisterNetEvent("stem_doj:bondPosted")
AddEventHandler(
	"stem_doj:bondPosted",
	function(issuerJob, amount, expiry)
		local plyPed = PlayerPedId()
		TriggerEvent("esx_policejob:unrestrain")
		if issuerJob == "lspd" then
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			SetEntityCoords(plyPed, 478.27, -976.25, 27.98, false, false, false, false)
			SetEntityHeading(plyPed, 27.98)
			Citizen.Wait(5000)
			DoScreenFadeIn(1000)

			Citizen.CreateThread(
				function()
					local messages = {
						[1] = "You have been released on a ~r~$" .. amount .. "~s~ bond. Press ~INPUT_CONTEXT~ to continue.",
						[2] = "While on bond, you are expected to maintain good behavior. Press ~INPUT_CONTEXT~ to continue.",
						[3] = "You are required to enter a plea at the ~r~courthouse~s~ within 24 hours. Press ~INPUT_CONTEXT~ to continue.",
						[4] = "If you do not make an appearance by ~y~" ..
							expiry .. "~s~ a ~r~bench warrant~s~ will issued for your arrest. Press ~INPUT_CONTEXT~ to acknowledge."
					}
					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[1], true)
						Citizen.Wait(0)
					end

					while IsControlPressed(0, 51) do
						Citizen.Wait(0)
					end

					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[2], true)
						Citizen.Wait(0)
					end

					while IsControlPressed(0, 51) do
						Citizen.Wait(0)
					end

					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[3], true)
						Citizen.Wait(0)
					end

					while IsControlPressed(0, 51) do
						Citizen.Wait(0)
					end

					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[4], true)
						Citizen.Wait(0)
					end
				end
			)
		elseif issuerJob == "sahp" or issuerJob == "lscso" then
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			SetEntityCoords(plyPed, 815.44, -1290.21, 26.29, false, false, false, false)
			SetEntityHeading(plyPed, 88.54)
			Citizen.Wait(5000)
			DoScreenFadeIn(1000)

			Citizen.CreateThread(
				function()
					local messages = {
						[1] = "You have been released on a ~r~$" .. amount .. "~s~ bond. Press ~INPUT_CONTEXT~ to continue.",
						[2] = "While on bond, you are expected to maintain good behavior. Press ~INPUT_CONTEXT~ to continue.",
						[3] = "You are required to enter a plea at the ~r~courthouse~s~ within 24 hours. Press ~INPUT_CONTEXT~ to continue.",
						[4] = "If you do not make an appearance by ~y~" ..
							expiry .. "~s~ a ~r~bench warrant~s~ will issued for your arrest. Press ~INPUT_CONTEXT~ to acknowledge."
					}
					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[1], true)
						Citizen.Wait(0)
					end

					while IsControlPressed(0, 51) do
						Citizen.Wait(0)
					end

					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[2], true)
						Citizen.Wait(0)
					end

					while IsControlPressed(0, 51) do
						Citizen.Wait(0)
					end

					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[3], true)
						Citizen.Wait(0)
					end

					while IsControlPressed(0, 51) do
						Citizen.Wait(0)
					end

					while true do
						if IsControlJustPressed(0, 51) then
							break
						end

						ESX.ShowHelpNotification(messages[4], true)
						Citizen.Wait(0)
					end
				end
			)
		elseif issuerJob == "judge" then
		end
	end
)

RegisterNetEvent("stem_doj:cannotPostBond")
AddEventHandler(
	"stem_doj:cannotPostBond",
	function()
	end
)

RegisterNetEvent("stem_doj:releasePlayer")
AddEventHandler(
	"stem_doj:releasePlayer",
	function()
		DoScreenFadeOut(3000)
		Citizen.Wait(3000)
		SetEntityCoordsNoOffset(PlayerPedId(), Config.ReleasePos.xyz, true, false, false)
		SetEntityHeading(PlayerPedId(), Config.ReleasePos.w)
		Citizen.Wait(3000)
		DoScreenFadeIn(3000)

		ESX.ShowNotification("You have been released from court.")
	end
)

RegisterNetEvent("stem_doj:alertSound")
AddEventHandler(
	"stem_doj:alertSound",
	function()
		PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
		Citizen.Wait(50)
		PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
		Citizen.Wait(50)
		PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
	end
)

function OpenJudgeActionsMenu()
	if (ESX?.PlayerData?.job?.name ~= "doj") then
		return 
	end 

	lib.hideContext()
	
	local options = {
		{
			title = "View Court Docket",
			onSelect = function () 
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)

				ESX.TriggerServerCallback(
					"stem_doj:fetchDocket",
					function(docket)
						OpenCourtDocketMenu(docket)
					end
				)
			 end
		},
		{
			title = "View Nearby Players",
			onSelect = function () 			
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)

				local players = exports.stem_common:tableMap(ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 25.0), function (player) 
					return GetPlayerServerId(player)
				end)

				ESX.TriggerServerCallback(
					"stem_doj:getNearbyPlayers",
					function(data)
						OpenCourtDocketMenu(data, true)
				end, players)
			end
		},
	}

	if ESX.PlayerData.job.grade >= 3 then
		table.insert(options, { title = "View or Update Criminal Code", onSelect = function () OpenCriminalCodeMenu() end })
	end
	
	lib.registerContext({
		id = "judge_actions",
		title = ESX.PlayerData.job.label .. " - " .. ESX.PlayerData.job.grade_label,
		options = options,
		onExit = function ()
			clearAnim()
		end
	})

	lib.showContext("judge_actions")
end

function RegisterCourtActionsMenu(data)
	local options = {
		{
			title = "Send to jail",
			onSelect = function () 
				local input = lib.inputDialog(("Send %s to jail"):format(data.playerName), {{
					label = "Total Months",
					type = "number",
				}}, {
					canCancel = true,
				})

				if not input then
					return lib.showContext("court_player_actions:"..data.playerId)
				end

				TriggerServerEvent("stem_doj:jailPlayer", data.playerId, input[1])
				clearAnim()
			end
		},
		{
			title = "Release",
			onSelect = function () 
				local input = lib.alertDialog({
					header = "Are you sure?",
					content = ("Are you sure you want to release %s?"):format(data.playerName),
					cancel = true,
					centered = true,
				})
				if input == "cancel" then
					return lib.showContext("court_player_actions:"..data.playerId)
				end

				TriggerServerEvent("stem_doj:releasePlayer", data.playerId)
				lib.showContext("judge_actions")
			end
		},
		{
			title = "Show Vehicles",
			onSelect = function ()
				
				ESX.TriggerServerCallback(
					"stem_doj:getVehicles",
					function(data)
						OpenViewPropertyMenu(data)
						clearAnim()
					end,
					data.playerId
				)

			end
		},

		{
			title = "Show Charges",
			onSelect = function () 
				OpenManageChargesMenu(data)
				clearAnim()
			end
		}
	}
	lib.registerContext({
		id = "court_player_actions:"..data.playerId,
		title = ("%s: %s"):format(data.playerName, data.playerId),
		options = options,
		menu = "court_docket",
		onExit = function() 
			clearAnim()
		end
	})
end

function OpenCourtDocketMenu(data, nearby)
	local options = {}

	for key, value in next, data do
		RegisterCourtActionsMenu(value)
		print( ESX.PlayerData.job.grade >= 2 and "court_player_actions:"..value.playerId or "court_docket")
		table.insert(options, {
			title = not nearby and ("Docket #%d: %s"):format(value.index, value.playerName) or ("Player: %s"):format(value.playerName) ,
			description = not nearby and ("%s"):format(value.time),
			menu = ESX.PlayerData.job.grade >= 2 and "court_player_actions:"..value.playerId or "court_docket",
			onSelect = function () 
				local player = GetPlayerFromServerId(value.playerId)

				if NetworkIsPlayerActive(player) then
					local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(player))
					if (not nearby) then
						ESX.ShowAdvancedNotification(
							"Court Docket #" .. value.index,
							value.playerName,
							"Arrival Time: " .. value.time .. "\nCell Number: " .. value.cell,
							mugshotStr,
							2
						)
					else
						ESX.ShowAdvancedNotification(
						"Nearby Player",
						value.playerName,
						"Player Id: "..value.playerId,
						mugshotStr,
						2
					)

					end
					UnregisterPedheadshot(mugshot)
				end
			end
		})
	end

	lib.registerContext({
		id = "court_docket",
		title = not nearby and "Court Docket" or "Nearby Players",
		menu = "judge_actions",
		options = options,
		onExit = function () 
			clearAnim()
		end,
		onBack = function () 
			clearAnim()
		end
	})
	lib.showContext("court_docket")
end

function OpenManageChargesMenu(playerData)
	local player = GetPlayerFromServerId(playerData.playerId)
	local elements = {
		head = { ("Case No."), ("Charge"), ("Fine Amount"), ("Action"), ("Pled Not Guilty") },
		rows = {}
	}

	ESX.TriggerServerCallback(
		"esx_billing:getCharges",
		function(bills)
			for k, bill in ipairs(bills) do
				table.insert(
					elements.rows,
					{
						data = bill,
						cols = {
							("%s/%s"):format(bill.caseId, bill.id),
							bill.label,
							('<span style="color:red;">%s</span>'):format(("$%s"):format(ESX.Math.GroupDigits(bill.amount))),
							"{{" .. ("Dismiss") .. "|dismiss}} {{" .. ("Find Guilty") .. "|affirm}}",
							(bill.plea_entered ~= nil) and "☑️" or ""
						}
					}
				)
			end

			ESX.UI.Menu.Open(
				"list",
				GetCurrentResourceName(),
				"billing",
				elements,
				function(data, menu)
					local billingInfo = data.data
					if data.value == "dismiss" then
						menu.close()
						ESX.TriggerServerCallback(
							"stem_doj:dismissCharge",
							function()
								ESX.ShowNotification(("You dismissed a charge of: **%s** against **%s**"):format(
									billingInfo.label, playerData.playerName))
								OpenManageChargesMenu(playerData)
							end,
							billingInfo.id
						)
					elseif data.value == "affirm" then
						menu.close()
						ESX.TriggerServerCallback(
							"stem_doj:findGuilty",
							function()
								ESX.ShowNotification(("You found %s **GUILTY** of: %s"):format(playerData.playerName,
									billingInfo.label))
								OpenManageChargesMenu(playerData)
							end,
							billingInfo.id
						)
					end
				end,
				function(data, menu)
					menu.close()
				end
			)
		end,
		"judge",
		playerData.playerId
	)
end

function OpenViewPropertyMenu(vehicles)
	ESX.UI.Menu.CloseAll()

	local elements = {
		head = { ("Vehicle"), ("Type"), ("Make Model"), ("Reg. Date"), ("Est. Liquidation Value"), ("Status"), ("Action") },
		rows = {}
	}

	for _, v in ipairs(vehicles) do
		local vehData = json.decode(v.vehicle)
		local vehModel = GetLabelText(GetDisplayNameFromVehicleModel(vehData.model))
		local vehShopData = exports.stem_dealership:getVehicle(v.model)

		local model = vehShopData and vehShopData.label or vehModel ~= "NULL" and vehModel or v.model

		local vehType = "Unknown"
		if IsThisModelACar(vehData.model) then
			vehType = "Car"
		elseif IsThisModelABicycle(vehData.model) then
			vehType = "Bicycle"
		elseif IsThisModelABike(vehData.model) then
			vehType = "Motorcycle"
		elseif IsThisModelABoat(vehData.model) then
			vehType = "Boat"
		elseif IsThisModelAJetski(vehData.model) then
			vehType = "Jetski"
		end

		local options = "{{" ..
			("Force Liquidate") ..
			"|liquidate}}" --{{" .. ("Seize Asset") .. "|seize}} {{" .. ("Return to Owner") .. "|retn}}
		if v.status == 3 then
			options = "{{" .. ("Force Liquidate") .. "|liquidate}} {{" .. ("Return to Owner") .. "|retn}}"
		elseif v.status == 2 then
			options = "{{" .. ("Force Liquidate") .. "|liquidate}} {{" .. ("Seize Asset") .. "|seize}}"
		elseif v.status == 1 then
			options = "{{" .. ("Seize Asset") .. "|seize}}"
		end


		table.insert(
			elements.rows,
			{
				data = v,
				model = vehData.model,
				cols = {
					v.plate,
					vehType,
					model,
					v.date or "N/A",
					v.price and "$" .. ESX.Math.GroupDigits(v.price) or "N/A",
					v.status,
					options
				}
			}
		)
	end

	ESX.UI.Menu.Open(
		"list",
		GetCurrentResourceName(),
		"court_player_property_list",
		elements,
		function(data, menu)
			local billingInfo = data.data
			if data.value == "seize" then
				TriggerServerEvent("stem_doj:seizeVehicle", tostring(data.data.plate))
				menu.close()
			elseif data.value == "retn" then
				TriggerServerEvent("stem_doj:returnVehicle", data.data.plate)
				menu.close()
			elseif data.value == "liquidate" then
				TriggerServerEvent("stem_doj:forceLiquidate", tostring(data.data.plate))
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenSelectPlayerPropertyMenu()
	local elements = {}

	local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 25.0)
	for _, player in pairs(players) do
		elements[#elements + 1] = {
			label = ("[%d] %s"):format(GetPlayerServerId(player), GetPlayerName(player)),
			value = player
		}
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"court_player_property_menu",
		{
			title = "Select player to view",
			align = "right",
			elements = elements
		},
		function(data, menu)
			if data.current.value ~= PlayerId() then
				ESX.TriggerServerCallback(
					"stem_doj:getVehicles",
					function(data)
						OpenViewPropertyMenu(data)
					end,
					GetPlayerServerId(data.current.value)
				)
			else
				ESX.ShowNotification("You cannot view your own property.")
			end

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenCriminalCodeMenu()
	ESX.UI.Menu.CloseAll()

	local charges = nil
	ESX.TriggerServerCallback(
		"stem_doj:fetchCriminalCode",
		function(data)
			charges = data
		end
	)

	while charges == nil do
		Wait(0)
	end

	local elements = {
		head = { ("Charge"), ("Fine Amt."), ("Category"), ("Jail Sentence"), ("Points"), ("Action") },
		rows = {}
	}

	for i = 1, #charges do
		elements.rows[#elements.rows + 1] = {
			id = charges[i].id,
			data = charges[i],
			cols = {
				charges[i].label,
				charges[i].amount,
				charges[i].category,
				charges[i].jailtime,
				charges[i].points,
				"{{Edit Charges|edit}}"
			}
		}
	end

	ESX.UI.Menu.Open(
		"list",
		GetCurrentResourceName(),
		"criminal_code_list",
		elements,
		function(data, menu)
			if data.value == "edit" then
				exports["noire_nui"]:OpenEditCriminalCodeMenu(data.data.id, data.data.label, data.data.amount,
					data.data.category, data.data.jailtime, data.data.points)
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

RegisterCommand("openjudgemenu", OpenJudgeActionsMenu)
RegisterKeyMapping("openjudgemenu", "Open judge menu", "keyboard", "f6")
