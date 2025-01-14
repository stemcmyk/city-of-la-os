
print("begin")


function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end

Citizen.CreateThread(function()
	local bool = false
    local timeout = 500
	while true do
		Citizen.Wait(timeout)			-- mandatory wait
		local ped = GetPlayerPed(-1)	-- get local ped
		
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsIn(ped, false)
            local seat = GetPedVehicleSeat(ped)
			if bool == false then
				bool = true

                if seat == 0 then
                    local playerPed = PlayerPedId()
                    SetPedIntoVehicle(playerPed, veh, 0)
                    SetPedConfigFlag(playerPed, 184, true)
                    SetPedConfigFlag(playerPed, 35, false)
        
                    if not IsVehicleSeatAccessible(playerPed, veh, -1, false, true) and not DoesEntityExist(GetPedInVehicleSeat(veh, -1)) then
                        local maxTime = GetGameTimer() + 2500
                        while GetGameTimer() < maxTime do
                            if IsControlJustPressed(0, 51) then
                                TriggerEvent("SeatShuffle")
                                timeout = 500
                                break
                            end
        
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to switch to the driver seat.", true)
                            Wait(0)
                        end
                    end
                end
			end
		else
			if bool == true then
				bool = false
			end
		end
	end
end)

AddEventHandler(
	"baseevents:enteredVehicle",
	function(veh, seat)
        print(veh, seat)
	end
)

CreateThread(function()
	while not LocalPlayer.state.switchComplete do
		Wait(1000)
	end

	while true do
		SetPedConfigFlag(PlayerPedId(), 35, false)
		Wait(1000)
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler(
	"SeatShuffle",
	function()
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			SetPedConfigFlag(PlayerPedId(), 184, false)
			Citizen.Wait(5000)
			SetPedConfigFlag(PlayerPedId(), 184, true)
		else
			CancelEvent()
		end
	end
)

RegisterCommand(
	"shuff",
	function(source, args, raw)
		TriggerEvent("SeatShuffle")
	end,
	false
)
