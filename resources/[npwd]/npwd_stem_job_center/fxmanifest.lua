-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "cerulean"
game "gta5"

shared_scripts {
	"@es_extended/imports.lua",
	"@oxmysql/lib/MySQL.lua",
	"config.lua"
}

client_script "client/main.lua"
server_script "server/main.lua"

ui_page "web/dist/index.html"

files {
	"web/dist/index.html",
	"web/dist/**/*",
}
