local refineingInputOptions = {}

for k, v in pairs(Config.SmeltingOptions) do
    if v.refineable then
        table.insert(refineingInputOptions, {value = k, label = v.label})
    end
end

ESX.RegisterClientCallback("stem_mining:getNetEntityModel", function (cb, state)
    return cb(GetEntityModel(state))
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

local function beginSmeltingDialog() 
    local refineInput = lib.inputDialog(Config.Smelting.input.refineTitle, {
        {type = 'select', label = Config.Smelting.input.refineSelectMaterial, description = Config.Smelting.input.refineSelectMaterialDesc, required = true, icon = Config.Smelting.input.refineSelectMaterialIcon, options = refineingInputOptions},
    })
    if refineInput == nil then
        return 
    end
    ESX.TriggerServerCallback("stem_mining:beginSmelting", function (canSmelt, duration) 
        if (not canSmelt) then return end
        local progress = lib.progressCircle({
            duration = duration,
            label = "Smelting Ores",
            position = "middle",
            useWhileDead = false,
            canCancel = true,
            anim = {dict = 'amb@world_human_stand_fire@male@idle_a', clip = 'idle_a'},
            disable = {move = true, car = true, combat = true}
        })
        TriggerServerEvent("stem_mining:finishSmelting", progress)
    end, refineInput[1])
end

local function miningAnimation(cb) 
    local done = false
    Citizen.CreateThread(function()
        local impacts = 0
        local ped = PlayerPedId()
        local pickaxe;
        FreezeEntityPosition(ped, true)
        while impacts < Config.MiningData.hits and not done do
            Citizen.Wait(0)
            local plyCoords = GetEntityCoords(ped)
            local FrontRock = GetEntityForwardVector(ped)
            local x, y, z   = table.unpack(plyCoords + FrontRock * 1.0)
            if not HasNamedPtfxAssetLoaded("core") then
                RequestNamedPtfxAsset("core")
                    while not HasNamedPtfxAssetLoaded("core") do
                    Wait(0)
                end
            end
            if impacts == 0 then
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                AttachEntityToEntity(pickaxe, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, true, true, false, true, 1, true)
            end
            LoadDict('melee@large_wpn@streamed_core')
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot',  8.0, 8.0, -1, 80, 0, 0, 0, 0)
            Citizen.Wait(730)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.5, "mining", 35.10)
            UseParticleFxAssetNextCall("core")
            effect = StartParticleFxLoopedAtCoord("ent_amb_stoner_landing",x, y, z-1.0, 0.0, 0.0, 0.0, 1.6, false, false, false, false)
            Citizen.Wait(1000)
            StopParticleFxLooped(effect, 0)
            Citizen.Wait(1500)
            ClearPedTasks(ped)
            impacts = impacts+1
            print('mining loop->',impacts)
            if impacts == Config.MiningData.hits then
                impacts = 0
                done = true
                DeleteEntity(pickaxe)
                cb(true)
                break
            end
        end
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
        DeleteEntity(pickaxe)
    end)
    local progress = lib.progressCircle({
        duration = (730 + 1000 + 1500) * Config.MiningData.hits,
        canCancel = true,
    })
    if (not progress and not done) then
        done = true
        cb(false)
    end
end

local function mineRock(entity, zoneIndex) 
    ESX.TriggerServerCallback("stem_mining:beginMiningRock", function (canMine)
        if (not canMine) then return end
        miningAnimation(function (status) 
            TriggerServerEvent("stem_mining:finishMiningRock", status, entity, zoneIndex)
        end)
    end, entity)
end

Citizen.CreateThread(function () 
    for index, zone in ipairs(Config.MiningZones) do
        exports.ox_target:addSphereZone({
            coords = zone.coords,
            radius = zone.radius,
            drawSprite = false,
            options = {
                {
                    label = "Mine",
                    icon = "fa-solid fa-hand",
                    canInteract = function (entity)
                        local pickaxeSlot = exports.ox_inventory:GetSlotWithItem("pickaxe")
                        if (not pickaxeSlot) then return false end

                        local status, err = pcall(function () 
                            if (Config.RockModels[GetEntityModel(entity)]) then return true end
                            return false
                        end)
                        
                        return status
                    end,
                    onSelect = function (data) 
                        mineRock(data.entity, index)
                    end
                }
            }
        })
    end
    if (Config.Smelting) then
        exports.ox_target:addBoxZone({
            coords = Config.Smelting.coords,
            size = vector3(4.0, 4.2, 2),
            rotation = 50,
            options = {
                {
                    icon = Config.Smelting.icon,
                    label = Config.Smelting.title,
                    onSelect = beginSmeltingDialog,
                    distance = 2
                }
            }
        })

        local blip = AddBlipForCoord(Config.Smelting.coords)
        SetBlipSprite(blip, 648)
        SetBlipColour(blip, 17)
        SetBlipScale(blip, 0.75)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Refinery")
        EndTextCommandSetBlipName(blip)
    end
    for key, value in pairs(Config.MiningZones) do
        local blip = AddBlipForCoord(value.coords)
        SetBlipSprite(blip, 618)
        SetBlipColour(blip, 5)
        SetBlipScale(blip, 0.75)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(value.blipTitle)
        EndTextCommandSetBlipName(blip)
    end
end)

-- exports.ox_target

-- qtarget:AddBoxZone('refineing', Config.SmeltingLocation, 4.0, 4.2, {
--     name = 'refineingZone',
--     heading = 50.0,
--     debugPoly = false,
--     minZ = 30.5,
--     maxZ = 32.5,
-- }, {
--     options = {
--         {
--             icon = Target.refineIcon,
--             label = Target.refineLabel,
--             canInteract = function()
--                 if refineStarted then
--                     return false
--                 else
--                     return true
--                 end
--             end,
--             action = function()
--                 refineStarted = true
--                 startSmelt()
--             end
--         }
--     },
--     distance = 2
-- })