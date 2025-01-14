Config_AntiNLR = {}
Config_AntiNLR.CannotReturnTime = 30 * 60 * 1000 -- Time where the player cannot return to the scene
Config_AntiNLR.CannotReturnDist = 250.0 -- Distance where the player will be auto killed if they return to the scene

Config_AntiNLR.exemptJobs = {
    ["amr"] = true,
    ["lspd"] = true,
    ["sahp"] = true,
    ["lscso"] = true,
    ["doj"] = true
}

Config_AntiNLR.hospitals = {
    vec3(324.15, -583.14, 44.20),
    vector3(-442.99, -322.24, 34.91),
    vector3(-251.28, 6316.91, 32.43),
    vector3(316.4, -581.84, 43.28),
    vector3(1827.4, 3680.31, 34.28)
}

Config_AntiNLR.policeStations = {
    ["sahp"] = vector4(1537.92, 810.23, 78.17, 241.06),
    ["lspd"] = vector4(468.93, -1000.73, 33.42, 176.2),
    ["lscso"] = vector4(370.54, -1593.09, 26.57 - 1, 232.01) ,
}