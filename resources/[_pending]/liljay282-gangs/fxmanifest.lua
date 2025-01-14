shared_script '@WaveShield/resource/waveshield.js' --this line was automatically written by WaveShield

-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'
game 'gta5'

shared_scripts { 'shared/*' }

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*'
}

server_scripts { 'server/*' }

ui_page 'dist/index.html'

files {'dist/index.html', 'dist/assets/*'}