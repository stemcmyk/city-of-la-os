local isLoadingScreenFinished = false

RegisterNetEvent("esx_identity:alreadyRegistered", function()
    while not isLoadingScreenFinished do Wait(100) end

    TriggerEvent("esx_skin:playerRegistered")
end)

RegisterNetEvent("esx_identity:setPlayerData", function(data)
    if type(data) ~= "table" then return end

    Wait(10)

    ESX.SetPlayerData("name", ("%s %s"):format(data.firstName, data.lastName))
    ESX.SetPlayerData("firstName", data.firstName)
    ESX.SetPlayerData("lastName", data.lastName)
    ESX.SetPlayerData("dateofbirth", data.dateOfBirth)
    ESX.SetPlayerData("sex", data.sex)
    ESX.SetPlayerData("height", data.height)
end)

AddEventHandler("esx:loadingScreenOff", function()
    isLoadingScreenFinished = true
end)
if Config.UseDeferrals then return end



local function showIdentityForm()
    SetTimecycleModifier("hud_def_blur")
    if (exports["esx_multicharacter"]:FinishBigSkyLoader()) then exports["esx_multicharacter"]:FinishBigSkyLoader() end

    local minDate = Config.DateFormat
    minDate = string.gsub(minDate, "[Yy][Yy][Yy][Yy]", Config.LowestYear) -- Replace "YYYY" or "yyyy" with Config.LowestYear
    minDate = string.gsub(minDate, "[Mm][Mm]", "01")                      -- Replace "MM" or "mm" with "01"
    minDate = string.gsub(minDate, "[Dd][Dd]", "01")                      -- Replace "DD" or "dd" with "01"

    local maxDate = Config.DateFormat
    maxDate = string.gsub(maxDate, "[Yy][Yy][Yy][Yy]", Config.HighestYear + 1) -- Replace "YYYY" or "yyyy" with Config.HighestYear
    maxDate = string.gsub(maxDate, "[Mm][Mm]", "01")                           -- Replace "MM" or "mm" with "01"
    maxDate = string.gsub(maxDate, "[Dd][Dd]", "01")                           -- Replace "DD" or "dd" with "01"

    local input = lib.inputDialog("IDENTITY", {
        {
            type = "input",
            label = "First Name",
            description = "Your character's first name",
            required = true,
            placeholder = "First Name",
            min = Config.MinFirstNameLength,
            max = Config.MaxFirstNameLength
        },
        {
            type = "input",
            label = "Last Name",
            description = "Your character's last name",
            required = true,
            placeholder = "Last Name",
            min = Config.MinLastNameLength,
            max = Config.MaxLastNameLength
        },
        {
            type = "date",
            label = "Date Of Birth",
            description = "Your character's date-of-birth",
            required = true,
            format = Config.DateFormat,
            min = minDate,
            max = maxDate
        },
        {
            type = "number",
            label = "Height (CM)",
            description = "Your character's height",
            required = true,
            placeholder = "Height (CM)",
            min = Config.MinHeight,
            max = Config.MaxHeight
        },
        {
            type = "select",
            label = "Gender",
            description = "Your character's gender",
            required = true,
            placeholder = "Gender",
            options = {
                { label = "Male",   value = "m" },
                { label = "Female", value = "f" }
            },
            default = "m"
        }
    }, { allowCancel = false })

    if not input then return showIdentityForm() end

    local data = {
        firstname = input[1],
        lastname = input[2],
        dateofbirth = input[3],
        height = input[4],
        sex = input[5]
    }

    ESX.TriggerServerCallback("esx_identity:registerIdentity", function(callback)
        if not callback then return showIdentityForm() end
        ClearTimecycleModifier()

        ESX.ShowNotification(_U("thank_you_for_registering"), "success")

        if ESX.GetConfig().Multichar then return end

        TriggerEvent("esx_skin:playerRegistered")
    end, data)
end

RegisterNetEvent("esx_identity:showRegisterIdentity", function()
    TriggerEvent("esx_skin:resetFirstSpawn")


    if not ESX.PlayerData.dead then showIdentityForm() end
end)
