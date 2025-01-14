-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

lua54 'yes'

fx_version 'adamant'
game 'gta5'

this_is_a_map 'yes'

client_scripts {
	'client.lua'
}

data_file 'AUDIO_GAMEDATA' 'stream/occlusions/k4mb1_casino1_col_game.dat' -- dat151
data_file 'AUDIO_DYNAMIXDATA' 'stream/occlusions/k4mb1_casino1_col_mix.dat' -- dat15

files {
  'stream/occlusions/k4mb1_casino1_col_game.dat151.rel',
  'stream/occlusions/k4mb1_casino1_col_mix.dat15.rel',
}

escrow_ignore {
  'client.lua',  -- Only ignore one file
  'stream/extra/*.ydr'   -- Ignore all .ydr files in any subfolder
}
dependency '/assetpacks'