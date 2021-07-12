--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

util.AddNetworkString('NoclipONOFF')

local pmeta = FindMetaTable('Player')

function pmeta:extendedNoClip(bool)

	self.extendedNoClipState = bool

	net.Start('NoclipONOFF')

		net.WriteBool(bool)

	net.Send(self)
				
	self:SetNoDraw(bool)
	
	if not bool then 
		
		self:GodDisable()

	else

		self:GodEnable()

	end

	self:SetNoTarget(bool)
	self:SetCustomCollisionCheck(bool)

	for k,v in pairs(self:GetWeapons()) do

		if not bool then
					
			v:SetRenderMode(0)
			v:Fire("alpha", 255, 0)
			v:SetMaterial("")

		else

			v:SetRenderMode(1)
			v:Fire("alpha", 0, 0)
			v:SetMaterial("")

		end

	end

end

function pmeta:getExtendedNoClip()
	
	return self.extendedNoClipState

end

hook.Add("PlayerNoClip", "OnAllowNoclip", function(ply, state)

	if state then

		timer.Simple(0.1, function()

			if ply:GetMoveType() == MOVETYPE_NOCLIP then
		
				ply:extendedNoClip(true)

			end

		end)

	else

		timer.Simple(0.1, function()
				
			ply:extendedNoClip(false)

		end)

	end

end)

hook.Add('PlayerPostThink', 'CheckValidMode', function(ply)

	if ply:getExtendedNoClip() then

		if not ply:GetMoveType() == MOVETYPE_NOCLIP or ply:InVehicle() then
			
			ply:extendedNoClip(false)

		end

	end

end)

hook.Add("ShouldCollide", "NoClipNoCollision", function(ent1, ent2)

    if ent1:getExtendedNoClip() or ent2:getExtendedNoClip() then return false end

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--