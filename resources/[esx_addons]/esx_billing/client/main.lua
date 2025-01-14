
local courtModel = `a_f_y_femaleagent`
local courtLocation = vector4(-552.95, -192.15, 38.22 - 1, 213.03)
local courtAnimation = {
    dict = "hs3_prp_celb-18",
    anim = "a_m_y_business_03^1_dual-18"
}
local courtPed
local isDead = false


function ShowRecordMenu()
	ESX.UI.Menu.CloseAll()

	ESX.TriggerServerCallback(
		"esx_billing:getCharges",
		function(convictions)
			if type(convictions) == "table" then
				local elements = {
					head = {"Case #", "Charge", "Date Convicted", "Expunge Date"},
					rows = {}
				}

				for i = 1, #convictions do
					elements.rows[#elements.rows + 1] = {
						cols = {
							("%s/%s"):format(convictions[i].caseId, convictions[i].id),
							convictions[i].label,
							convictions[i].issue_date,
							convictions[i].expunge_date
						}
					}
				end

				ESX.UI.Menu.Open(
					"list",
					GetCurrentResourceName(),
					"criminal_record",
					elements,
					function(data, menu)
						menu.close()
					end,
					function(data, menu)
						menu.close()
					end
				)
			else
				ESX.ShowNotification("You have no conviction(s) on your record.")
			end
		end,
        "convictions"
	)
end

function ShowBillsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.TriggerServerCallback(
		"esx_billing:getCharges",
		function(bills)
			if #bills > 0 then
				local elements = {
					head = {"Case No.", "Date", "Charge", "Fine Amount", "Action"},
					rows = {}
				}

				for k, v in ipairs(bills) do
					local actions = nil
					if v.category ~= "Ticket" then
						if v.category < 1 then
							actions = "{{Guilty|guilty}} {{Not Guilty|nguilty}} {{No Contest|ncontest}}"
						else
							actions = "{{Guilty|guilty}} {{Not Guilty|nguilty}}"
						end
					else
						actions = "{{Pay|pay}}"
					end

					table.insert(
						elements.rows,
						{
							data = v,
							cols = {
								v.category and ("%s/%S"):format(v.caseId, v.id) or "N/A",
								v.dateIssued and (v.overdue and '<span style="color:red;">' .. v.dateIssued .. "</span>" or v.dateIssued) or "N/A",
								v.label,
								"$" .. v.amount,
								actions
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
						local billData = data.data

						print(json.encode(data))

						if billData.category ~= nil then
							local pos = GetEntityCoords(PlayerPedId())

							local dist = #(pos.xy - courtLocation.xy)
							if dist > 5 then
								ESX.ShowHelpNotification("Citations and criminal charges can only be handled at the ~r~courthouse~s~.")
								menu.close()
								return
							end
						end

						if data.value == "guilty" or data.value == "ncontest" then
							ESX.TriggerServerCallback(
								"esx_billing:pleadGuiltyOrNoContest",
								function()
									ShowBillsMenu()
								end,
								data.value,
								billData.id
							)
						elseif data.value == "nguilty" then
							ESX.TriggerServerCallback(
								"esx_billing:pleadNotGuilty",
								function()
									ShowBillsMenu()
								end,
								billData.id
							)
						elseif data.value == "pay" then
							ESX.TriggerServerCallback(
								"esx_billing:payBill",
								function()
									ShowBillsMenu()
								end,
								billData.id
							)
						end
					end,
					function(data, menu)
						menu.close()
					end
				)
			else
				ESX.ShowNotification(_U("no_invoices"))
			end
		end,
        "bills"
	)
end

function OpenChangePleaMenu()
    ESX.UI.Menu.CloseAll()

    ESX.TriggerServerCallback(
		"esx_billing:getCharges",
		function(bills)
			if #bills > 0 then
				local elements = {
					head = {"Case No.", "Issue Date", "Plea Date", "Charge", "Fine Amount", "Plea Entered", "Action"},
					rows = {}
				}

				for k, v in ipairs(bills) do
					local actions = nil
					if v.category ~= nil then
						actions = "{{Change to Guilty|guilty}}"
					end

					table.insert(
						elements.rows,
						{
							data = v,
							cols = {
								v.category and ("%s/%s"):format(v.caseId, v.id) or "N/A",
								v.issue_date and v.issue_date or "N/A",
								v.plea_entered_date and v.plea_entered_date ~= 0 and v.plea_entered_date  or "N/A",
								v.label,
								"$" .. ESX.Math.GroupDigits(v.amount),
								v.plea_entered or "N/A",
								actions
							}
						}
					)
				end

				ESX.UI.Menu.Open(
					"list",
					GetCurrentResourceName(),
					"billing_change_plea",
					elements,
					function(data, menu)
						local billData = data.data

						if billData.category ~= nil then
							local pos = GetEntityCoords(PlayerPedId())

							local dist = #(pos.xy - courtLocation.xy)
							if dist > 5 then
								ESX.ShowHelpNotification("Citations and criminal charges can only be handled at the ~r~courthouse~s~.")
								menu.close()
								return
							end
						end

						if data.value == "guilty" then
							ESX.TriggerServerCallback(
								"esx_billing:pleadGuiltyOrNoContest",
								function()
									OpenChangePleaMenu()
								end,
								data.value,
								billData.id
							)
						end
					end,
					function(data, menu)
						menu.close()
					end
				)
			else
				ESX.ShowNotification(_U("no_invoices"))
			end
		end,
        "change_plea"
	)
end

Citizen.CreateThread(function ()
    if (LocalPlayer.state.hasCreatedCourtPed) then return end
    LocalPlayer.state.hasCreatedCourtPed = true

	RequestModel(courtModel)
	while not HasModelLoaded(courtModel) do
		Citizen.Wait(1)
	end
	

	courtPed = CreatePed(5, courtModel, courtLocation.x, courtLocation.y,courtLocation.z, courtLocation.w, false, true)
	print("billing ped creation")

	while not DoesEntityExist(courtPed) do
		Citizen.Wait(50)
	end

	FreezeEntityPosition(courtPed, true)
	SetEntityInvincible(courtPed, true)

	RequestAnimDict(courtAnimation.dict)
	while not HasAnimDictLoaded(courtAnimation.dict) do
		Citizen.Wait(1)
	end

	TaskPlayAnim(courtPed, courtAnimation.dict, courtAnimation.name, -1, 0, -1, 1, 0, 0, 0)
	TaskStartScenarioInPlace(courtPed, scenario, 0, true) -- begins peds animation
	SetBlockingOfNonTemporaryEvents(courtPed, true)

	Citizen.Wait(50)

	local entityLocation = GetPedBoneCoords(courtPed, 0x8B93, 0,0,0)
	
	exports.ox_target:addBoxZone({
		coords = entityLocation,
		size = vector3(1, 1, 1),
		rotation = GetEntityRotation(courtPed),
		options = {
			{
				icon = 'fa-solid fa-gavel',
				label = "View Criminal Record",
				onSelect = function() 
					ShowRecordMenu()
				end,
				distance = 4,
			},
			{
				icon = 'fa-solid fa-gavel',
				label = "Pay Fines or Enter Plea",
				onSelect = function() 
					ShowBillsMenu()
				end,
				distance = 4,
			},
			{
				icon = 'fa-solid fa-gavel',
				label = "Change or Modify Plea",
				onSelect = function() 
					OpenChangePleaMenu()
				end,
				distance = 4,
			},
		},
	})
end)

AddEventHandler("onResourceStop", function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end 
    if DoesEntityExist(courtPed) then
        DeleteEntity(courtPed)
    end
end)

RegisterCommand(
	"showbills",
	function()
		if not isDead and not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "billing") then
			ShowBillsMenu()
		end
	end,
	false
)

RegisterKeyMapping("showbills", _U("keymap_showbills"), "keyboard", "F7")

AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)