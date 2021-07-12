--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName = "Записка"

ENT.Category = "MarryBye"
ENT.Purpose = "Обычная записка че пялишь"

ENT.Author = "MarryBye"

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:GetListID()

	return self.uniqueIndex

end

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--