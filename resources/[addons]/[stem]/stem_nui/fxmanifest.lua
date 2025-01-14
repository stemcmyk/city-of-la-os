-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_script '@es_extended/imports.lua'
client_script "client.lua"
shared_script "@ox_lib/init.lua"

ui_page("nui/index.html")

files {
    "nui/index.html",
    "nui/style.css",
    "nui/script.js"
}
