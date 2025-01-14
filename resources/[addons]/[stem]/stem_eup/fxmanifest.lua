-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

-- Don't change anything. For support join my discord: https://discord.gg/Z9Mxu72zZ6
fx_version "cerulean"
game "gta5"
lua54 'yes'

title "STEMs EUP Menu"
author "stemcmyk"

server_script {
    "@oxmysql/lib/MySQL.lua",
    "server.lua"
}

shared_scripts {
    "@es_extended/imports.lua",
    "@ox_lib/init.lua",
    "config.lua",
}

client_scripts {
    "NativeUI.lua",
    "menu.lua"
}
