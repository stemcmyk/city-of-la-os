fx_version 'adamant'
lua54 'yes'
games { 'gta5' }

description "Free Garbage Job"
author "Var"

version "1.0.0"

client_scripts {
	"client/*.lua"
}

server_scripts {
	"server/*.lua"
}

shared_scripts {
	"shared/*.lua",
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}