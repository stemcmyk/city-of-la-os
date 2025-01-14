Citizen.CreateThread(function()


RequestIpl("gabz_franklins_milo_")

	 interiorID = GetInteriorAtCoords(50.60, -1862.985, 22.28377)
	 
	 
	 if IsValidInterior(interiorID) then
	 EnableInteriorProp(interiorID, "V_57_FranklinStuff")
	 EnableInteriorProp(interiorID, "V_57_Franklin_Safari")

	 RefreshInterior(interiorID)

	 end

end)