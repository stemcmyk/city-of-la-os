-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield


fx_version "adamant"
game "gta5"
lua54 "yes"

author 'someone'

export "ShowImpoundMenu"

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
}

client_scripts {
	'config.lua',
	'client.lua',
	'json.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua',
	'json.lua',
	'config.lua',
}

ui_page('web/index.html')

files {
    'config.json',
    'web/index.html',
    'web/script.js',
    'web/style.css'
}
