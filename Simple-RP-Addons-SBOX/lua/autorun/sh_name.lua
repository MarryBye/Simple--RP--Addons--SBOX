--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

local meta = FindMetaTable('Player')

timer.Create('RefreshFuncName', 1, 0, function()
	
	function meta:Nick()

		return self:GetNWString('Name', 'Имя персонажа отсутствует')

	end

	meta.Name = meta.Nick
	meta.GetName = meta.Nick

end)

function meta:SetNick(str)

	if CLIENT then 
                
	    net.Start('CharNameToPD')

	        net.WriteString(str)
	        net.WriteEntity(self)

	    net.SendToServer()

	end
	
	if SERVER then 

		self:SetPData('Name', str)
		self:SetNWString('Name', str)

	end

end

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--