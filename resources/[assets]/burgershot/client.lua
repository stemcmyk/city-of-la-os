local coords = vec(-1179.292, -891.4589, 13.93344)
local model = `prop_bs_map_door_01`

CreateThread(function()
	CreateModelHide(coords.xyz, 2.0, model, 1)
end)