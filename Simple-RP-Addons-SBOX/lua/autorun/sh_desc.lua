--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

local meta = FindMetaTable('Player')

timer.Create('RefreshFuncDesc', 1, 0, function()
	
	function meta:Description()

		return self:GetNWString('Desc_' .. self:UniqueID() .. '_0', 'Описание персонажа отсутствует')

	end

end)

function meta:SetDescription(str)

	if CLIENT then
                    
	    net.Start('CharDescToPD')

	        net.WriteString(str)
	        net.WriteEntity(self)

	    net.SendToServer()

	end

	if SERVER then 

		self:SetPData('Desc', str)

		for i = 1, 500, 100 do
	
			self:SetNWString('Desc_' .. self:UniqueID() .. '_' .. i - 1, utf8.sub(self:GetPData('Desc'), i, i + 99))

		end

	end

end

function meta:getFullDescription()

	if CLIENT then

		local tblToConcat = {

			self:GetNWString('Desc_' .. self:UniqueID() .. '_0', ' '),
			self:GetNWString('Desc_' .. self:UniqueID() .. '_100', ' '),
			self:GetNWString('Desc_' .. self:UniqueID() .. '_200', ' '),
			self:GetNWString('Desc_' .. self:UniqueID() .. '_300', ' '),
			self:GetNWString('Desc_' .. self:UniqueID() .. '_400', ' ')

		}

		return table.concat(tblToConcat)

	end

	if SERVER then

		self:GetPData('Desc', 'Описание персонажа отсутствует')

	end

end

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--