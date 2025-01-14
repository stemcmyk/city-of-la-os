local interiors = {
    {
        ipl = 'gabz_davispd_milo_',
        coords = { x = 371.0543, y = -1600.378, z = 34.73263 },
        entitySets = {
            { name = 'davispd_room01_rainhall_es', enable = true },
            { name = 'davispd_room02_reception_es', enable = true },
            { name = 'davispd_room03_captainoffice_es', enable = true },
            { name = 'davispd_room04_officeleft_es', enable = true },
            { name = 'davispd_room05_officeright_es', enable = true },
            { name = 'davispd_room06_archives_es', enable = true },
            { name = 'davispd_room07_staircase_es', enable = true },
            { name = 'davispd_room08_basementa_es', enable = true },
            { name = 'davispd_room09_listening_es', enable = true },
            { name = 'davispd_room10_interrogation_es', enable = true },
            { name = 'davispd_room11_toilets_es', enable = true },
            { name = 'davispd_room12_mugshot_es', enable = true },
            { name = 'davispd_room13_basementb_es', enable = true },
            { name = 'davispd_room14_armory_es', enable = true },
            { name = 'davispd_room15_forensics_es', enable = true },
            { name = 'davispd_room16_lockers_es', enable = true },
            { name = 'davispd_room17_showerleft_es', enable = true },
            { name = 'davispd_room18_showerright_es', enable = true },
        }
    },
}

CreateThread(function()
    for _, interior in ipairs(interiors) do
        if not interior.ipl or not interior.coords or not interior.entitySets then
            print('^5[GABZ]^7 ^1Error while loading interior.^7')
            return
        end
        RequestIpl(interior.ipl)
        local interiorID = GetInteriorAtCoords(interior.coords.x, interior.coords.y, interior.coords.z)
        if IsValidInterior(interiorID) then
            for __, entitySet in ipairs(interior.entitySets) do
                if entitySet.enable then
                    EnableInteriorProp(interiorID, entitySet.name)
                    if entitySet.color then
                        SetInteriorPropColor(interiorID, entitySet.name, entitySet.color)
                    end
                else
                    DisableInteriorProp(interiorID, entitySet.name)
                end
            end
            RefreshInterior(interiorID)
        end
    end
    print("^5[GABZ]^7 Interiors datas loaded.")
end)