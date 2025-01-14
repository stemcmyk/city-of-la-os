local assists = {}


RegisterNUICallback('exit', function(_, cb)
	cb(1)
	SetNuiFocus(false, false)
end)


RegisterNUICallback("assist_action", function (data, cb)
	ESX.TriggerServerCallback("stem_assist:assistAction", function (response) 
		cb(response)
	end, data) 
end)

RegisterNUICallback("assist_update", function (data, cb)
	ESX.TriggerServerCallback("stem_assist:updateAssist", function (response) 
		cb(response)
	end, data) 
end)

function flattenAssists(data) 
	local newAssists = {}
	for index, value in pairs(assists) do
		table.insert(newAssists, value)
	end
	return newAssists;
end 

RegisterNetEvent("stem_assist:updateAssists", function (data)
	if (data.id) then
		assists[data.id] = data;
		
		SendNuiMessage(json.encode({
			action = 'updateAssists',
			data = data
		}))
	else
		assists = data
	end

	local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))

	assists = exports.stem_common:tableMapWithKeys(assists, function (key, value) 
		if (value.acceptedBy and value.acceptedBy.id == playerId) then
			value.status = "accepted"
		end
		return key, value
	end)
	
	SendNuiMessage(json.encode({
		action = 'updateAssists',
		data = flattenAssists(assists)
	}))
end)

RegisterNetEvent("stem_assist:assistanceRequested", function (name, source, description) 
	lib.notify({
		title = locale("assistance_required_notification_title"),
		description = locale("assistance_required_notification_description", source, name, description),
		alignIcon = "top",
		duration = 15000,
		icon = "fa-solid fa-hand",
		iconAnimation = "bounce",
		position = "top",
		type = "warning"
	})
end)

function openAssistMenu()
	TriggerServerEvent("stem_assist:fetchAssists") 

	SetNuiFocus(true, true)
	SendNuiMessage(json.encode({
		action = 'setVisible',
	}))
end

RegisterKeyMapping("assistmenu", "Open staff asssit menu", "keyboard", "f11")
RegisterCommand("assistmenu", openAssistMenu)