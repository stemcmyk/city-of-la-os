-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_script {
	'@es_extended/imports.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	"@es_extended/locale.lua",
	"locales/fr.lua",
	"locales/en.lua",
	"config.lua",
	"server/main.lua",
	"server/lib.lua"
}

client_scripts {
	"@ox_lib/init.lua",
	"@es_extended/locale.lua",
	"locales/fr.lua",
	"locales/en.lua",
	"config.lua",
	"client/main.lua"
}

ui_page "html/ui.html"

files {
	"html/ui.html",
	-- "html/logo.png",
	"html/dmv.png",
	"html/cursor.png",
	"html/styles.css",
	"html/questions.js",
	"html/scripts.js",
	"html/debounce.min.js"
}

dependencies {
    "stem_common",
}
