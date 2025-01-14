-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "cerulean"
game "gta5"
lua54 "yes"

author "Mads"
description "Licenses"

shared_script '@es_extended/imports.lua'

client_scripts {
	"config.lua",
	"client.lua"
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server.lua"
}

ui_page("html/index.html")

files(
	{
		"html/index.html",
		"html/script.js",
		"html/style.css",
		"html/images/*.png",
		"html/fonts/franklingothicdemi/Franklin-Gothic-Demi-Regular.woff",
		"html/fonts/justsignature/JustSignature.woff"
	}
)
