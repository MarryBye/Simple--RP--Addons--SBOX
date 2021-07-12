--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

AddCSLuaFile('cl_otherFuncs.lua')
AddCSLuaFile('cl_fonts.lua')

net.Receive("NoclipONOFF", function()

    if net.ReadBool() then

        local function NoclipPhysgun(ply, wep, enabled, target, bone, deltaPos)

        	if ply:GetMoveType() == MOVETYPE_NOCLIP and wep:GetOwner() == ply then
            	
            	return false

            else

            	return true

            end

        end

        hook.Add("DrawPhysgunBeam", "NoclipPhysgun", NoclipPhysgun)

        local function NoclipHUD()

            for k,v in pairs (player.GetAll()) do

                if not LocalPlayer():Alive() then

                    hook.Remove("HUDPaint", "NoclipHUD")
                    hook.Remove("DrawPhysgunBeam", "NoclipPhysgun")

                end

                if v:Nick() != LocalPlayer():Nick() then

                    local pos = v:GetBonePosition(v:LookupBone('ValveBiped.Bip01_Head1')) + Vector(0, 0, 15)
                    
                    if pos == v:GetPos() then
                        
                        pos = v:GetBoneMatrix(v:LookupBone('ValveBiped.Bip01_Head1')):GetTranslation() + Vector(0, 0, 15)
                    
                    end

        	        local Position = (pos):ToScreen()

                        surface.SetFont("3D_Font_Noclip")
                        text(v:Nick(), "3D_Font_Noclip", Position.x - surface.GetTextSize(v:Nick()) / 2, Position.y, Color(175, 0, 255, 255))

                end

            end

        end

        hook.Add("HUDPaint", "NoclipHUD", NoclipHUD)

    else

        hook.Remove("HUDPaint", "NoclipHUD")
        hook.Remove("DrawPhysgunBeam", "NoclipPhysgun")

    end

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--