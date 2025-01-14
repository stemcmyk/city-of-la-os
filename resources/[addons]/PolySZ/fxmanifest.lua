-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_script '@es_extended/imports.lua'

client_scripts {
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/EntityZone.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
    "client.lua",
    '@ox_lib/init.lua'
}

server_script "server.lua"
