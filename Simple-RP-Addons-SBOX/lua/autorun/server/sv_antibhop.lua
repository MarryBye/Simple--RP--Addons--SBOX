local function AntiBhop(ply, movedata)

	ply:SetMaxSpeed(250)
	ply:SetRunSpeed(250)
	ply:SetWalkSpeed(90)
	ply:SetSlowWalkSpeed(90)
	ply:SetLadderClimbSpeed(90)

   if movedata:KeyPressed(IN_JUMP) then 

   		if ply:OnGround() then

   			ply:SetVelocity(-1 * (ply:GetVelocity() * 0.5))

   		end

	end

end

hook.Add('SetupMove', 'AntiBhop', AntiBhop)