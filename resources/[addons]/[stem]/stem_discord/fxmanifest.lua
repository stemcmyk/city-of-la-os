-- shared_script '@WaveShield/resource/waveshield.js' --this line was automatically written by WaveShield

-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'stemcmyk'
description "stem's discord bridge"

dependencies {
    "es_extended"
}


client_scripts {
    'client.lua'
}

shared_scripts {
    "@ox_lib/init.lua",
    "@es_extended/imports.lua",
    "@oxmysql/lib/MySQL.lua"
}

server_scripts {
	'@restfx/build/import.lua',
    'server.js',
    'server.lua',
    "api.lua"
}

server_export 'getRoles'
server_export 'getRolesCallback'
server_export 'userHasRole'
server_export 'userHasRoleCallback'
server_export 'giveRole'
server_export 'giveRoleCallback'
server_export 'getName'
server_export 'sendMessage'
server_export 'updateEmbed'
server_export 'getUserDiscord'
server_export 'sendThroughWebhook'
