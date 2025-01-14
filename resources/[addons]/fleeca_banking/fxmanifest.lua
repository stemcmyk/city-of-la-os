-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "bodacious"

games {"gta5"}

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
}

client_script('client/client.lua')

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server.lua'
}

ui_page('client/html/UI.html') -- English UI


files {
	'client/html/UI.html', -- English UI
    'client/html/style.css',
    'client/html/media/font/Bariol_Regular.otf',
    'client/html/media/font/Vision-Black.otf',
    'client/html/media/font/Vision-Bold.otf',
    'client/html/media/font/Vision-Heavy.otf',
    'client/html/media/img/bg.png',
    'client/html/media/img/circle.png',
    'client/html/media/img/curve.png',
    'client/html/media/img/fingerprint.png',
    'client/html/media/img/fingerprint.jpg',
    'client/html/media/img/graph.png',
    'client/html/media/img/logo-big.png',
    'client/html/media/img/logo-top.png'
}

dependency 'es_extended'