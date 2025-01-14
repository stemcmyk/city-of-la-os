MySQL.ready(function ( ) 
    Citizen.CreateThread(function () 

        
        local beanMachine = Business:new({
            bossGrade = "owner",
            label = "Best Buds",
            name = "bestbuds",
            blip = {
                Color = 2,
                Sprite = 140,
                Name = "Best Buds",
                Size = 0.9
            },
            coords = vector3(380.23, -826.77, 29.3)
        })
        beanMachine:createRegister({
            coords = vector3(375.6, -827.34, 29.40)
        })
        beanMachine:createRegister({
            coords = vector3(380.22, -827.21, 29.40)
        })
        beanMachine:addBossMenu(vector3(374.3, -824.65, 29.40))

        beanMachine:createInventory({
            coords = vector3(379.84, -819.61, 29.20),
            id = "storage",
            name = "Best Buds Storage",
            icon = "fa-solid fa-box-open",
            size = 100000,
            slots = 50
        })
    end)
end)