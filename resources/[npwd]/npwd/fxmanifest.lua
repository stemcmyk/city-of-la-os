-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

shared_script '@WaveShield/resource/waveshield.js' --this line was automatically written by WaveShield

fx_version("cerulean")
game("gta5")
description("js runtime monkaW")
authors({ "itschip", "erik-sn", "TasoOneAsia", "kidz", "RockySouthpaw", "SamShanks", "c-wide", "mojito" })
version("3.14.4-beta.1")
client_scripts({
	"dist/game/client/client.js",
	"dist/game/client/*.lua",
})

server_script({
	-- This is a file that lives purely in source code and isn't compiled alongside
	-- rest of the release. It's used to detect whether a user can read or not.
	"dist/game/server/server.js",
})

ui_page("dist/html/index.html")

files({
	"config.json",
	"dist/html/index.html",
	"dist/html/**/*",
})

dependency({
	"screenshot-basic",
	"pma-voice",
})
