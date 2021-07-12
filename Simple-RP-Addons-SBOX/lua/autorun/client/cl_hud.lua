--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

AddCSLuaFile('cl_fonts.lua')
AddCSLuaFile('cl_otherfuncs.lua')
AddCSLuaFile("autorun/sh_ecm.lua")
AddCSLuaFile('autorun/sh_utf8.lua')

include("autorun/sh_ecm.lua")
include("autorun/sh_utf8.lua")

local draw = draw
local surface = surface
local table = table 
local math = math 
local hook = hook
local gmod = gmod
local Color = Color 
local FrameTime = FrameTime
local ScrW, ScrH = ScrW, ScrH

local crosshairColor = Color(245, 245, 245)
local lerpSpeed, crosshairLerp, headHUDLerp = 0.25, 0, 0
local shouldDraw = false

local hud_list = {

    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudSuitPower"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true

}

local txtVar = 1

local typingVars = {

	[1] = { txt = 'Пишет' },
	[2] = { txt = 'Пишет.' },
	[3] = { txt = 'Пишет..' },
	[4] = { txt = 'Пишет...' },

}

hook.Add('HUDPaint', 'OffGrabEar', function()
	
	local GM = gmod.GetGamemode()

	function GM:GrabEarAnimation(ply)

		return

	end

	hook.Remove('HUDPaint', 'OffGrabEar')

end)

local function HideHUD(name)
    
    if hud_list[name] then 
		
        return false 
	
    end

end
    
hook.Add("HUDShouldDraw", "HideHUD", HideHUD)

local function HideMouseHUD()
    
    return false

end

hook.Add("HUDDrawTargetID", "HideMouseHUD", HideMouseHUD)

local function PlayerHUD()

	local locply = LocalPlayer()
	local entTrace = locply:GetEyeTrace().Entity

	if locply:IsSprinting() or not locply:OnGround() then

		crosshairLerp = Lerp(lerpSpeed, crosshairLerp, 0) 
		circle(ScrW() / 2, ScrH() / 2, 3, 180, Color(0, 0, 0, crosshairLerp))
		circle(ScrW() / 2, ScrH() / 2, 2, 180, Color(crosshairColor.r, crosshairColor.g, crosshairColor.b, crosshairLerp))

	else 
	
		crosshairLerp = Lerp(lerpSpeed, crosshairLerp, 255) 
		circle(ScrW() / 2, ScrH() / 2, 3, 180, Color(0, 0, 0, crosshairLerp))
		circle(ScrW() / 2, ScrH() / 2, 2, 180, Color(crosshairColor.r, crosshairColor.g, crosshairColor.b, crosshairLerp))

	end

	if locply:GetMoveType() == MOVETYPE_NOCLIP then 

		crosshairLerp = 255 
		circle(ScrW() / 2, ScrH() / 2, 3, 180, Color(0, 0, 0, crosshairLerp))
		circle(ScrW() / 2, ScrH() / 2, 2, 180, Color(crosshairColor.r, crosshairColor.g, crosshairColor.b, crosshairLerp))

	end

	if entTrace:IsPlayer() then 

		if entTrace == locply then shouldDraw = false return end 
		if not entTrace:Alive() then shouldDraw = false return end
		if entTrace:GetNoDraw() then shouldDraw = false return end
		if entTrace:GetMoveType() == MOVETYPE_NOCLIP then shouldDraw = false return end
		
		local Distance = locply:GetPos():Distance(entTrace:GetPos())

		if Distance > 150 then shouldDraw = false crosshairColor = Color(245, 245, 245) return end

		crosshairColor = Color(175, 0, 255)
	
	else

		crosshairColor = Color(245, 245, 245)

		shouldDraw = false
		headHUDLerp = 0

	end

	if not shouldDraw and not timer.Exists('ShowOverHeadHUD') then

		timer.Remove('changeText')
		txtVar = 1
		
		timer.Create('ShowOverHeadHUD', 1.5, 1, function()

			shouldDraw = true

			timer.Remove('ShowOverHeadHUD')

		end)

	end

	if shouldDraw then 

		local pos = entTrace:GetBonePosition(entTrace:LookupBone('ValveBiped.Bip01_Head1')) + Vector(0, 0, 12)
       	
       	if pos == entTrace:GetPos() then
            
            pos = entTrace:GetBoneMatrix(entTrace:LookupBone('ValveBiped.Bip01_Head1')):GetTranslation() + Vector(0, 0, 12)
        
        end

       	local Position = (pos):ToScreen()
		
		local frontPlayerNick = entTrace:Nick()
		local frontPlayerDesc = entTrace:getFullDescription()
			
		local line1Desc = utf8.sub(frontPlayerDesc, 1, 60)
		local line2Desc = utf8.sub(frontPlayerDesc, 61, 120)
		local line3Desc = utf8.sub(frontPlayerDesc, 121, 180)

		surface.SetFont('3D_Font')
		local widthN, heightN = surface.GetTextSize(frontPlayerNick)
			
		surface.SetFont('3D_Font_Desc')
		local widthD, heightD = surface.GetTextSize(frontPlayerDesc)
		
		headHUDLerp = Lerp(lerpSpeed, headHUDLerp, 255) 

		if entTrace:IsTyping() then

			text(typingVars[txtVar].txt, '3D_Font', Position.x, Position.y - 30, Color(255, 255, 255, headHUDLerp), TEXT_ALIGN_CENTER)

			if not timer.Exists('changeText') then
				
				timer.Create('changeText', 0.5, 0, function()

					txtVar = txtVar + 1

					if txtVar > #typingVars then

						txtVar = 1

					end

				end)

			end

		end

		text(frontPlayerNick, '3D_Font', Position.x, Position.y, Color(175, 0, 255, headHUDLerp), TEXT_ALIGN_CENTER)
			
		text(line1Desc, '3D_Font_Desc', ScrW() / 2, ScrH() / 2 + heightD * 0.5, Color(255, 255, 255, headHUDLerp), TEXT_ALIGN_CENTER)
		text(line2Desc, '3D_Font_Desc', ScrW() / 2, ScrH() / 2 + heightD * 1.5, Color(255, 255, 255, headHUDLerp), TEXT_ALIGN_CENTER)
		text(line3Desc, '3D_Font_Desc', ScrW() / 2, ScrH() / 2 + heightD * 2.5, Color(255, 255, 255, headHUDLerp), TEXT_ALIGN_CENTER)

	end

end 

hook.Add('HUDPaint', 'PlayerHUD', PlayerHUD)

local function showFullDescription(ply, button)

	local entTrace = ply:GetEyeTrace().Entity
		
	if entTrace:IsPlayer() then

		if input.GetKeyName(button) == 'e' then

			local Distance = ply:GetPos():Distance(entTrace:GetPos())

			if Distance <= 150 then 

				if not IsValid(fullDescription_frame) then 

					fullDescription_frame = vgui.Create("DFrame")
					local fullDescription_panel = vgui.Create('DPanel', fullDescription_frame)
					local fullDescription_close = vgui.Create('DButton', fullDescription_frame)
					fullDescription_frame:fastCopyFrame(ScrW() / 4, ScrH() / 6, fullDescription_close, fullDescription_panel, true)

					local fullDescription_text = vgui.Create("RichText", fullDescription_frame)
					fullDescription_text:Dock(FILL)
					fullDescription_text:InsertColorChange(225, 225, 225, 255)
					fullDescription_text:AppendText(entTrace:getFullDescription())

				end
			
			end
		
		end

	end

end

hook.Add("PlayerButtonDown", "showFullDescription", showFullDescription)

 --=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--