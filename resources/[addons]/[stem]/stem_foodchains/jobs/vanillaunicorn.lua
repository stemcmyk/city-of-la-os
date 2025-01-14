MySQL.ready(function ( ) 
    Citizen.CreateThread(function () 

        
        local vanillaUnicorn = Business:new({
            bossGrade = "owner",
            label = "Vanilla Unicorn",
            name = "vu",
            blip = {
                Color = 61,
                Sprite = 489,
                Name = "Vanilla Unicorn",
                Size = 1.2
            },
            coords = vector3(118.09, -1289.9, 28.26)
        })
        vanillaUnicorn:createRegister({
            coords = vector3(129.14, -1284.95, 28.64 + 0.8)
        })
        vanillaUnicorn:addBossMenu(vector3(95.93, -1293.0, 30.07- 1))
    end)
end)