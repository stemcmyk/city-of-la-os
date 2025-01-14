_AttachedProps = {}


AddStateBagChangeHandler(
    "propData",
    nil,
    function(bagName, key, value, _reserved, replicated)
        local player = GetPlayerFromStateBagName(bagName)
        if player == 0 then
            return
        end

        if replicated then
            return
        end

        local serverId = GetPlayerServerId(player)
        if _AttachedProps[serverId] then
            local ent = _AttachedProps[serverId]
            if NetworkGetEntityIsLocal(ent) then
                DeleteEntity(ent)
            end

            _AttachedProps[serverId] = nil
        end

        if not value then
            return
        end

        local plyPed = GetPlayerPed(player)

        local model = (type(value.model) == "number" and value.model or GetHashKey(value.model))

        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        local obj = CreateObject(model, GetEntityCoords(plyPed), false, false, false)
        AttachEntityToEntity(
            obj,
            plyPed,
            GetPedBoneIndex(plyPed, value.boneIndex),
            value.offset,
            value.rotation,
            false,
            false,
            false,
            false,
            value.rotationOrder ~= nil and value.rotationOrder or 0,
            not value.fixedRot
        )

        _AttachedProps[serverId] = obj
    end
)

RegisterNetEvent(
    "onPlayerDropped",
    function(serverId)
        if _AttachedProps[serverId] then
            local ent = _AttachedProps[serverId]
            if NetworkGetEntityIsLocal(ent) then
                DeleteEntity(ent)
            end

            _AttachedProps[serverId] = nil
        end
    end
)
