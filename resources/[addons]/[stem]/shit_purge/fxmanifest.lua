fx_version "bodacious"
game "gta5"
lua54 "yes"

client_script "client.lua"
shared_scripts { 
  "config.lua" 
}
-- server_script "server_config.lua"
server_script "server.lua"

ui_page {
  "index.html"
}

files {
  "index.html",
  "main.css",
  "main.js",
  "fonts/VCR_OSD_MONO.ttf",
  "purge.mp3"
}
