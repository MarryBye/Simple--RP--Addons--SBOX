--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

util.AddNetworkString('CharNameToPD')

local names = {
	'Алексей',
	'Вадим',
	'Владимир',
	'Артём',
	'Данил',
	'Денис',
	'Дмитрий',
	'Егор',
	'Кирилл',
	'Леонид',
	'Максим',
	'Матвей',
	'Никита',
	'Олег',
	'Павел',
	'Пётр',
	'Роман',
	'Сергей',
	'Станислав',
	'Виктор',
	'Антон'
}

local fams = {
	'Лукьянов',
	'Иванов',
	'Смирнов',
	'Кузнецов',
	'Попов',
	'Николаев',
	'Орлов',
	'Макаров',
	'Захаров',
	'Северный',
	'Елизаров',
	'Грибов',
	'Калачев',
	'Козлов',
	'Волков',
	'Фёдоров',
	'Михайлов',
	'Соколов',
	'Новиков',
	'Васильев'
}

hook.Add('PlayerInitialSpawn', 'SetPDName', function(ply)

	timer.Simple(0.1, function()

		if IsValid(ply) then
	
			if ply:GetPData('Name') == nil then

				ply:SetPData('Name', table.Random(names) .. ' ' .. table.Random(fams))
				ply:SetNWString('Name', ply:GetPData('Name'))

			else

				ply:SetNWString('Name', ply:GetPData('Name'))

			end

		end

	end)

end)

net.Receive('CharNameToPD', function()

	local name = net.ReadString()
	local player = net.ReadEntity()

	player:SetPData('Name', name)
	player:SetNWString('Name', name)

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--