-- fxmanifest.lua
fx_version 'cerulean'
game 'gta5'

author 'LankyBoy01'
description 'An ESX Job locked Vehicles Extras menu'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    "@es_extended/imports.lua",
    'config.lua'
}

dependencies {
    'ox_lib',
    'es_extended'
}
