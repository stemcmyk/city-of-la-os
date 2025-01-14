fx_version "cerulean"
game "gta5"
lua54 "yes"

author "your a nerd | https://reaperac.com"

shared_script "await.lua"
client_script "client.lua"
client_script "c-bypass.lua"
server_script "weaponsList.lua"
server_script "s-bypass.lua"
server_script "server-e.lua"
server_script "server.lua"

files {
    'web/build/assets/*',
    'web/build/index.html',
    "modules/**/client.lua"
}

ui_page "web/build/index.html"
escrow_ignore { "weaponsList.lua", "client.lua", "server.lua", "modules/**/*.lua" }
dependency '/assetpacks'
dependency '/assetpacks'