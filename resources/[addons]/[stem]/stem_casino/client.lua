Citizen.CreateThread(function()
	
-- Main Casino
	local interiorid = GetInteriorAtCoords(965.5146, 52.25026, 83.01856)
	
	-- ActivateInteriorEntitySet(interiorid, "k4_luckywheel") -- ch_prop_casino_lucky_wheel_01a
	ActivateInteriorEntitySet(interiorid, "k4_luckywheel2") -- vw_prop_vw_luckywheel_01a
	RefreshInterior(interiorid)
	

-- Casino Vault.
	local interiorid = GetInteriorAtCoords(960.9944, 28.87757, 74.43959)
	
	ActivateInteriorEntitySet(interiorid, "k4_display") -- Display case & diamond prop in the small vault room.
	ActivateInteriorEntitySet(interiorid, "k4_trollys") -- 10x Trollys behind the gates
	ActivateInteriorEntitySet(interiorid, "k4_paintings") -- 8x Paintings behind the gates

	RefreshInterior(interiorid)
	
-- Casino Hotel Floor 5.
	local interiorid = GetInteriorAtCoords(957.7612, 31.35768, 105.2141)
	
	-- Hotel numbers
	ActivateInteriorEntitySet(interiorid, "k4_number")
	-- ActivateInteriorEntitySet(interiorid, "k4_number2")

	RefreshInterior(interiorid)
		
end)