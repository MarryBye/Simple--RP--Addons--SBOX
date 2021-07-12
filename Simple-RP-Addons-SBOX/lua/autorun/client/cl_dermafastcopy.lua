--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

local button_colors = {

    ['IDLE'] = Color(35, 35, 35, 150), -- You can change it!
    ['HOVERED'] = Color(175, 35, 35, 150), -- You can change it!
    ['ACCEPT'] = Color(35, 175, 35, 150), -- You can change it!
    ['EDIT'] = Color(175, 175, 35, 150) -- You can change it!

}

local blur_mat = Material( "pp/blurscreen" )

local PMeta = FindMetaTable('Panel')

-- Only text -- 

function PMeta:fastUpdateText(txt)

    if self:GetText() != txt then

        self:SetText(txt)

    end

end

-- Fast button --

function PMeta:fastCopyButton(LabelText, x, y, w, h, copy)

    self:SetSize(w, h)
    self:SetPos(x, y)
    self:SetText(LabelText)
    self:SetColor(Color(230, 230, 230, 255)) -- You can change it!
    self:SetFont('Main_Font')

    self.click = false
    self.rclick = false

    self.Paint = function(self, x, y)

        if self.click and not self.rclick then

            draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), button_colors['ACCEPT'])

        elseif self.rclick and not self.click then

            draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), button_colors['EDIT'])

        elseif self:IsHovered() then

            draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), button_colors['HOVERED'])

        else

            draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), button_colors['IDLE'])

        end

    end

    self.DoClick = function(self)

        if copy then

            SetClipboardText(copy)

        end

        self:SetEnabled(false)
        self.click = true

        timer.Simple(0.5, function()

            if IsValid(self) then
                
                self:SetEnabled(true)
                self.click = false

            end

        end)

    end

end

-- Fast frame --

function PMeta:fastCopyFrame(w, h, varButton, varPanel, needPanelInFrame)

    self:SetSize(w, h)
    self:SetTitle('')
    self:Center()

    self:MakePopup()
    self:SetDraggable(true)
    self:ShowCloseButton(false)

    self.Paint = function(self, x, y)

        blur(self, 5, 5, 255)
        draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), Color(35, 35, 35, 150)) -- You can change it! (Color)
        draw.RoundedBox(0, 0, 0, self:GetWide(), 26, Color(111, 111, 111, 115)) -- You can change it! (Color)

    end

    varButton:SetSize(20, 20)
    varButton:SetPos(self:GetWide() - varButton:GetWide() - 3, 3)
    varButton:SetText('✖')
    varButton:SetColor(Color(230, 230, 230, 255)) -- You can change it!

    varButton.Paint = function(self, x, y)

        if not varButton:IsHovered() then

            draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), button_colors['IDLE'])

        else

            draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), button_colors['HOVERED'])

        end

    end

    varButton.DoClick = function()

        self:Close()

    end

    if needPanelInFrame and IsValid(varPanel) then

	    varPanel:SetSize(self:GetWide() - 6, self:GetTall() - 12 - varButton:GetTall())
	    varPanel:SetPos(3, 9 + varButton:GetTall())

	    varPanel.Paint = function(self, x, y)

	        draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), Color(40, 40, 40, 220)) -- You can change it! (Color)

	    end

	end

end

-- Fast panel --

function PMeta:fastCopyPanel(x, y, w, h)

	self:SetSize(w, h)
    self:SetPos(x, y)

    self.Paint = function(self, x, y)

        draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), Color(40, 40, 40, 220)) -- You can change it! (Color)

    end

end

-- Fast label --

function PMeta:fastCopyLabel(txt, font, x, y, w, h)

    self:SetText(txt)
    self:SetFont(font)
    self:SetSize(w, h)
    self:SetPos(x, y)

end

-- Fast label size (for custom font) --

function PMeta:fastGetLabelSize(txt, font)

	surface.SetFont(font)
	local w, h = surface.GetTextSize(self:GetText())

	return w, h

end

-- Fast scroll

function PMeta:fastCopyScroll(x, y, w, h)

	self:SetSize(w, h)
    self:SetPos(x, y)
        
    local sbar = self:GetVBar()
    sbar.LerpTarget = 0

    function sbar:AddScroll(dlta)

        local OldScroll = self.LerpTarget or self:GetScroll()
        dlta = dlta * 25
        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())

        return OldScroll ~= self:GetScroll()
        
    end

    sbar.Think = function(s)
        
        local frac = FrameTime() * 5 

        if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize / 10)) then

            frac = FrameTime() * 2 

        end

        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        s:SetScroll(math.Clamp(newpos, 0, s.CanvasSize))

        if (s.LerpTarget < 0 and s:GetScroll() <= 0) then
            
            s.LerpTarget = 0
        
        elseif (s.LerpTarget > s.CanvasSize and s:GetScroll() >= s.CanvasSize) then

            s.LerpTarget = s.CanvasSize

        end

    end    

    self.VBar:SetWide(0)

end

-- Fast category --

function PMeta:fastCopyCategory(x, y, w, h)

	self:SetSize(w, h)
	self:SetPos(x, y)

	self.Paint = function(self, x, y)

		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 0))

	end
            
    local sbar = self:GetVBar()
    sbar.LerpTarget = 0

    function sbar:AddScroll(dlta)

       	local OldScroll = self.LerpTarget or self:GetScroll()
        dlta = dlta * 25
        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())

         return OldScroll ~= self:GetScroll()
            
    end

    sbar.Think = function(s)
            
        local frac = FrameTime() * 5 

        if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize / 10)) then

           	frac = FrameTime() * 2 

        end

        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        s:SetScroll(math.Clamp(newpos, 0, s.CanvasSize))

        if (s.LerpTarget < 0 and s:GetScroll() <= 0) then
                
            s.LerpTarget = 0
            
        elseif (s.LerpTarget > s.CanvasSize and s:GetScroll() >= s.CanvasSize) then

            s.LerpTarget = s.CanvasSize

        end

    end    

    self.VBar:SetWide(0)

end

-- Fast spawnicon --

function PMeta:fastCopyIcon(ico, x, y, w, h, varPanel)

    varPanel:SetSize(w, h)
    varPanel:SetPos(x, y)

    varPanel.Paint = function(self, x, y)

        draw.RoundedBox(1, 0, 0, self:GetWide(), self:GetTall(), Color(40, 40, 40, 220)) -- You can change it! (Color)

    end

    self:SetSize(varPanel:GetWide(), varPanel:GetTall())
    self:SetPos(0, 0)
    self:SetModel(ico)

end

-- Blur for panels

blur = function( panel, layers, density, alpha )

    local x, y = panel:LocalToScreen(0, 0)
    surface.SetDrawColor( 255, 255, 255, alpha )
    surface.SetMaterial( blur_mat )
    
    for i = 1, 3 do

        blur_mat:SetFloat( "$blur", ( i / layers ) * density )
        blur_mat:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )

    end

end

function PMeta:fastCopyEntry(x, y, w, h, sv, font)

    self:SetPos(x, y)
    self:SetSize(w, h)
    self:SetFont(font)
    self:SetValue(sv)
    self:SetEnabled(false)
    self:SetEditable(false)
    
    timer.Simple(2.5, function()

        if IsValid(self) then
    	
        	self:SetValue(sv)
        	self:SetEnabled(true)
            self:SetEditable(true)

        end

    end)

    self:SetMultiline(true)
    self:SetTextColor(Color(255, 255, 255, 255))
    self:SetCursorColor(Color(255, 255, 255, 255))
    self:SetPaintBorderEnabled(false)
    self:SetPaintBackgroundEnabled(false)
    self:SetDrawBorder(false)
    self:SetPaintBackground(false)

end

-- Analog for Derma_StringRequest()

function requestString(value, act, desc, func)

    if IsValid(rq_main) then return end

    rq_main = vgui.Create('DFrame')
    local rq_close = vgui.Create('DButton', rq_main)
    local rq_panel = vgui.Create('DPanel', rq_main)
    
    rq_main:fastCopyFrame(ScrW() / 4.3, ScrH() / 3.3, rq_close, rq_panel, true)

    local rq_label_act = vgui.Create('DLabel', rq_panel)
    rq_label_act:SetText(act)
    rq_label_act:SetFont('RQ_Font')
    surface.SetFont('RQ_Font')
    rq_label_act:SetPos(rq_panel:GetWide() / 2 - surface.GetTextSize(rq_label_act:GetText()) / 2, 10)
    rq_label_act:SetSize(200, 35)

    local rq_label_desc = vgui.Create('DLabel', rq_panel)
    rq_label_desc:SetText(desc)
    rq_label_desc:SetFont('Main_Font')
    surface.SetFont('Main_Font')
    rq_label_desc:SetPos(rq_panel:GetWide() / 2 - surface.GetTextSize(rq_label_desc:GetText()) / 2, rq_panel:GetTall() / 2 - 50)
    rq_label_desc:SetSize(280, 35)

    local rq_textEntry = vgui.Create('DTextEntry', rq_panel)
    rq_textEntry:SetSize(250, 30)
    rq_textEntry:SetPos(rq_panel:GetWide() / 2 - rq_textEntry:GetWide() / 2, rq_panel:GetTall() / 2 + rq_textEntry:GetTall() / 2 + 45)
    rq_textEntry:SetFont('Main_Font')
    rq_textEntry:SetValue(value)
    rq_textEntry:SetEnabled(false)
    rq_textEntry:SetEditable(false)
    
    timer.Simple(2.5, function()

        if IsValid(rq_main) then
	    
    	    rq_textEntry:SetValue(value)
    	    rq_textEntry:SetEnabled(true)
            rq_textEntry:SetEditable(true)

        end

	end)

    rq_textEntry.OnEnter = function()

        func(rq_textEntry:GetValue())
        rq_main:Close()

    end

end

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--