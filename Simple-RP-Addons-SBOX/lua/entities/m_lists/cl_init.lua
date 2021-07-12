--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

local include = include
local AddCSLuaFile = AddCSLuaFile

include("shared.lua")

AddCSLuaFile('autorun/client/cl_dermaFastCopy.lua')
AddCSLuaFile('autorun/client/cl_fonts.lua')

local net = net
local table = table
local vgui = vgui
local timer = timer
local IsValid = IsValid
local Color = Color

local ScrW, ScrH = ScrW, ScrH

function ENT:Draw()
	
	self:DrawModel()

	net.Receive('EditLetter', function(len, ply)

		local ent = net.ReadEntity()
		local str = net.ReadString()

		l_frame = vgui.Create('DFrame')
		local frame_panel = vgui.Create('DPanel', l_frame)
		local frame_close = vgui.Create('DButton', l_frame)

		l_frame:fastCopyFrame(ScrW() / 2.5, ScrH() / 1.5, frame_close, frame_panel, true)

		panel_enterText = vgui.Create( "DTextEntry", frame_panel )
		panel_enterText:fastCopyEntry(3, 3, frame_panel:GetWide() - 6, frame_panel:GetTall() - 43, str, 'Main_Font')

		local delete_letter = vgui.Create('DButton', l_frame)

		delete_letter:fastCopyButton('Удалить записку', l_frame:GetWide() / 2 - 143, l_frame:GetTall() - 40, 140, 35, '')

		delete_letter.DoClick = function(self)

            self:SetEnabled(false)
            self.click = true

            timer.Simple(0.5, function()

                if IsValid(self) then
                
                    self:SetEnabled(true)
                    self.click = false

                end

            end)

            net.Start('DeleteLetter')

            	net.WriteEntity(ent)

            net.SendToServer()

        end

        local save_letter = vgui.Create('DButton', l_frame)

		save_letter:fastCopyButton('Сохранить записку', l_frame:GetWide() / 2 + 3, l_frame:GetTall() - 40, 140, 35, '')

		save_letter.DoClick = function(self)

            self:SetEnabled(false)
            self.click = true

            timer.Simple(0.5, function()

                if IsValid(self) then
                
                    self:SetEnabled(true)
                    self.click = false

                end

            end)

            net.Start('SaveLetter')

            	net.WriteEntity(ent)
            	net.WriteString(panel_enterText:GetValue())

            net.SendToServer()

        end

    end)

end

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--