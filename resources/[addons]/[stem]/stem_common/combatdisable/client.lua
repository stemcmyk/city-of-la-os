function format_time(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local seconds = seconds % 60

    local formattedString = ""
    if days > 0 then
        formattedString = formattedString .. string.format("%dd ", math.floor(days))
    end
    if hours > 0 or days > 0 then
        formattedString = formattedString .. string.format("%dh ", math.floor(hours))
    end
    if minutes > 0 or hours > 0 or days > 0 then
        formattedString = formattedString .. string.format("%dm ", math.floor(minutes))
    end

    return formattedString:match("^%s*(.-)%s*$") -- Trim leading/trailing spaces
end

Citizen.CreateThread(function ()
    while true do
        if (LocalPlayer.state.combatDisabled and LocalPlayer.state.combatDisabled >= 60 * 1000) then
            DisableViolentActions()

			SetTextFont(4)
			SetTextScale(0.4, 0.4)
			SetTextEntry("STRING")
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextEdge(4, 0, 0, 0, 255)
			SetTextOutline()
			AddTextComponentString(string.format("Combat disabled: ~r~%s", format_time(LocalPlayer.state.combatDisabled / 1000)))
			EndTextCommandDisplayText(0.01, 0.95)

            Citizen.Wait(1)
        else
            Citizen.Wait(500)
        end
    end
end)

function DisableViolentActions()
	local playerPed = PlayerPedId()

	if disable_actions == true then
		DisableAllControlActions(0)
	end

	DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
	DisablePlayerFiring(playerPed, true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
	DisableControlAction(0, 106, true) -- Disable in-game mouse controls
	DisableControlAction(0, 140, true)
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)
	EnableControlAction(0, 249, true)

	if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
		TriggerEvent("ox_inventory:disarm", true)
	end

	if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
		TriggerEvent("ox_inventory:disarm", true)
	end
end

