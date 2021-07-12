util.AddNetworkString('CheckEnter')

hook.Add('PlayerInitialSpawn', 'CheckEnterFreezePlayer', function(ply)

	timer.Simple(0.1, function()

		ply:GodEnable()
		ply:Freeze(true)

	end)

end)

net.Receive('CheckEnter', function(ln, ply)

	ply:GodDisable()
	ply:Freeze(false)

end)