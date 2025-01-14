-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "adamant"
game "gta5"
lua54 "yes"

shared_scripts {
	'@es_extended/imports.lua',
    "@ox_lib/init.lua",
	"config.lua",
	"bonetable.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	"server.lua",
	"server_gangwar.lua",
}

client_scripts {
	"client.lua",
	"client_gangwar.lua"
}

dependencies {
	"es_extended"
}
