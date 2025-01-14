
AddEventHandler(
    "playerSpawned",
    function()
        Citizen.CreateThread(
            function()
                SetPedConfigFlag(PlayerPedId(), 438, true)
                SetPedPopulationBudget(1)
                SetVehiclePopulationBudget(1)

            end
        )
    end
)