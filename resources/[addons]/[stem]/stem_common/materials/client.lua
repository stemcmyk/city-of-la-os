function GetMaterialNameFromHash(hash)
    return Config_Materials.Hashes[hash]
end

function IsPedInFoliage()
    local plyPed = PlayerPedId()

    local startCoords = GetPedBoneCoords(plyPed, 0x60F0)
    local destinationCoords = {
        GetOffsetFromEntityInWorldCoords(plyPed, -1.5, 0, 0),
        GetOffsetFromEntityInWorldCoords(plyPed, 1.5, 0, 0),
        GetOffsetFromEntityInWorldCoords(plyPed, 0, -1.5, 0),
        GetOffsetFromEntityInWorldCoords(plyPed, 0, 1.5, 0),
        GetOffsetFromEntityInWorldCoords(plyPed, 0, 0, -5.0),
        GetOffsetFromEntityInWorldCoords(plyPed, 0, 0, 5.0)
    }

    for i = 1, #destinationCoords do
        local destination = destinationCoords[i]
        local handle = StartExpensiveSynchronousShapeTestLosProbe(startCoords.x, startCoords.y, startCoords.z + 1.0,
            destination.x, destination.y, startCoords.z, 4294967295, plyPed, 4)

        local _, hit, endCoords, surfaceNormal, materialHash, entityHit =
            GetShapeTestResultIncludingMaterial(
                handle)

        local material = Config_Materials.Hashes[(materialHash or 0) & 0xFFFFFFFF]
        if Config_Materials.Bushes[material] then
            return true
        end
    end

    return false
end

function IsPedOnRoofMaterial()
    local plyPed = PlayerPedId()
    local coords = GetEntityCoords(plyPed)

    local handle = StartExpensiveSynchronousShapeTestLosProbe(coords.x, coords.y, coords.z + 1.0, coords.x, coords.y,
        coords.z - 5.0, 4294967295, plyPed, 4)

    local _, hit, endCoords, surfaceNormal, materialHash, entityHit =
        GetShapeTestResultIncludingMaterial(
            handle)

    local material = Config_Materials.Hashes[(materialHash or 0) & 0xFFFFFFFF]
    if material == 'RoofTile' or material == 'RoofFelt' then
        return true
    end

    return false
end

exports("GetMaterialNameFromHash", GetMaterialNameFromHash)
exports("IsPedInFoliage", IsPedInFoliage)
exports("IsPedOnRoofMaterial", IsPedOnRoofMaterial)

