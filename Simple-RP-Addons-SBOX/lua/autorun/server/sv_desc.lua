--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

util.AddNetworkString('CharDescToPD')
util.AddNetworkString('CharGetFullDescription')

hook.Add('PlayerInitialSpawn', 'SetPD', function(ply)

	timer.Simple(0.1, function()

		if IsValid(ply) then
	
			if ply:GetPData('Desc') == nil then

				ply:SetPData('Desc', 'Описание персонажа отсутствует.')
				ply:SetNWString('Desc_' .. ply:UniqueID() .. '_0', ply:GetPData('Desc'))

			else

				for i = 1, 500, 100 do
	
					ply:SetNWString('Desc_' .. ply:UniqueID() .. '_' .. i - 1, utf8.sub(ply:GetPData('Desc'), i, i + 99))

				end

			end

		end

	end)

end)

net.Receive('CharDescToPD', function()

	local desc = net.ReadString()
	local player = net.ReadEntity()

	player:SetPData('Desc', desc)
	
	for i = 1, 500, 100 do
	
		player:SetNWString('Desc_' .. player:UniqueID() .. '_' .. i - 1, utf8.sub(desc, i, i + 99))

	end

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--