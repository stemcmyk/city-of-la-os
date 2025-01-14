Config = {}

Config.DrawingTime = 60*1000 --20 seconds
Config.TextColor = {r=255, g=255,b=255} -- WHITE (Player Data)
Config.AlertTextColor = {r=255, g=0, b=0} -- RED (Player Left Game)
Config.LogSystem = false
Config.UseSteam = true -- If False then use R* License
Config.LogBotName = "pixel_logs"
Config.AutoDisableDrawing = true
Config.AutoDisableDrawingTime = 15000

Config.combatLogLocations = {
    ["lscso"] = vector4(368.57, -1608.06, 30.05, 322.35),
    ["lspd"] = vector4(460.33, -994.34, 24.91, 270.9),
    ["sahp"] = vector4(1558.96, 830.02, 77.66, 332.36)
}