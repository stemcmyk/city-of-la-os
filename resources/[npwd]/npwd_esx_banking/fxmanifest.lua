-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "cerulean"
game "gta5"

dependency 'es_extended'
shared_scripts {
    '@es_extended/imports.lua', '@es_extended/locale.lua'
}

client_script 'client/client.lua'
server_scripts { '@oxmysql/lib/MySQL.lua','server/server.lua'}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/*.js',
}
