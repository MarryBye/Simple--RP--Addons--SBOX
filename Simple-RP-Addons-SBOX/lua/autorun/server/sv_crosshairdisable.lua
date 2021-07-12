local meta = FindMetaTable('Player')

function meta:CrosshairEnable()

	return 

end

hook.Add('PlayerPostThink', 'CrosshairDisable', function(ply)

	ply:CrosshairDisable()

end)

