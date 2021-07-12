--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

AddCSLuaFile('cl_dermaFastCopy.lua')
AddCSLuaFile('cl_otherFuncs.lua')
AddCSLuaFile('cl_fonts.lua')

local stnd_buttons = {

    ['CopyNick'] = {name = 'Скопировать ник', listPlaceNum = 1, func = function(player)
        
        SetClipboardText(player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['CopyDescription'] = {name = 'Скопировать описание', listPlaceNum = 2, func = function(player) 

        SetClipboardText(player:getFullDescription())

    end}, -- You can change it! (FOR EXPERINCED)

    ['CopySteamID'] = {name = 'Скопировать SteamID', listPlaceNum = 3, func = function(player) 

        SetClipboardText(player:SteamID())

    end}, -- You can change it! (FOR EXPERINCED)

    ['SteamProfile'] = {name = 'Перейти в профиль', listPlaceNum = 4, func = function(player) 

        player:ShowProfile()

    end}, -- You can change it! (FOR EXPERINCED)

    ['LocalMute'] = {name = 'Заглушить (локально)', listPlaceNum = 5, func = function(player) 

        player:SetMuted(true)
        
    end}, -- You can change it! (FOR EXPERINCED)

    ['LocalUnMute'] = {name = 'Разглушить (локально)', listPlaceNum = 6, func = function(player) 

        player:SetMuted(false)
        
    end} -- You can change it! (FOR EXPERINCED)

}

local adm_buttons = {

    ['Goto'] = {name = 'ТП к нему', listPlaceNum = 1, func = function(player) 

        RunConsoleCommand("ulx", "goto", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['ChangeNick'] = {name = 'Сменить ник', listPlaceNum = 15, func = function(player) 

        requestString(player:Nick(), "Сменить ник", "Вы хотите сменить ник игрока на: ", function(s)
                        
            player:SetNick(s)

        end)

    end}, -- You can change it! (FOR EXPERINCED)

    ['ChangeDesc'] = {name = 'Сменить описание', listPlaceNum = 16, func = function(player)
           
        requestString(player:getFullDescription(), 'Сменить описание', "Вы хотите сменить описание игрока на: ", function(s)

            player:SetDescription(s)

        end) 

    end}, -- You can change it! (FOR EXPERINCED)

    ['Bring'] = {name = 'ТП к себе', listPlaceNum = 2, func = function(player) 

        RunConsoleCommand("ulx", "bring", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['Freeze'] = {name = 'Заморозить', listPlaceNum = 3, func = function(player) 

        RunConsoleCommand("ulx", "freeze", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['UnFreeze'] = {name = 'Разморозить', listPlaceNum = 4, func = function(player) 

        RunConsoleCommand("ulx", "unfreeze", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['Gag'] = {name = 'Заглушить', listPlaceNum = 5, func = function(player) 

        RunConsoleCommand("ulx", "gag", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['UnGag'] = {name = 'Разглушить', listPlaceNum = 6, func = function(player) 

        RunConsoleCommand("ulx", "ungag", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['Mute'] = {name = 'Замутить', listPlaceNum = 7, func = function(player) 

        RunConsoleCommand("ulx", "mute", player:Nick())
        
    end}, -- You can change it! (FOR EXPERINCED)

    ['UnMute'] = {name = 'Размутить', listPlaceNum = 8, func = function(player) 

        RunConsoleCommand("ulx", "unmute", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['Slay'] = {name = 'Убить', listPlaceNum = 9, func = function(player) 

        RunConsoleCommand("ulx", "slay", player:Nick())

    end}, -- You can change it! (FOR EXPERINCED)

    ['Kick'] = {name = 'Кикнуть с сервера', listPlaceNum = 10, func = function(player) 

        requestString('Нарушение правил', "Кикнуть", "Вы хотите кикнуть по причине: ", function(r)
                        
            RunConsoleCommand("ulx", "kick", player:Nick(), r) 

        end) -- You can change it! (FOR EXPERINCED)

    end},

    ['Jail'] = {name = 'Посадить в тюрьму', listPlaceNum = 11, func = function(player) 

        requestString('450', "Посадить в тюрьму", "Вы хотите посадить на: ", function(t)
                        
            RunConsoleCommand("ulx", "jail", player:Nick(), t) 

        end)

    end},

    ['UnJail'] = {name = 'Вытащить из тюрьмы', listPlaceNum = 12, func = function(player) 

        RunConsoleCommand("ulx", "unjail", player:Nick())

    end},

    ['Ban'] = {name = 'Забанить', listPlaceNum = 13, func = function(player) 

        requestString('1d', "Забанить", "Вы хотите забанить на время: ", function(t)
                        
            requestString('Жесткие нарушения', "Забанить", "Вы хотите забанить по причине: ", function(r)
                            
                 RunConsoleCommand("ulx", "ban", player:Nick(), t, r) 
                
            end)
                
        end)

    end}

}

function ScoreboardOpen()

    if IsValid(frame_main) then return end

    frame_main = vgui.Create('DFrame')
    local button_close = vgui.Create('DButton', frame_main)
    frame_main:fastCopyFrame(
    	
    	ScrW() / 2, ScrH() / 2.4, 
    	button_close, 
    	nil, 
    	false
    
    )
    
    local panel_player = vgui.Create('DPanel', frame_main)
    panel_player:fastCopyPanel(
    	
    	3, 9 + button_close:GetTall(), 
    	frame_main:GetWide() / 2 - 5, frame_main:GetTall() - 12 - button_close:GetTall()

    )
    
    local panel_list = vgui.Create('DPanel', frame_main)
    panel_list:fastCopyPanel(
    	
    	2 + frame_main:GetWide() / 2, 9 + button_close:GetTall(), 
    	frame_main:GetWide() / 2 - 5, frame_main:GetTall() - 12 - button_close:GetTall()

    )
    
    local player_name = vgui.Create('DButton', panel_player)
    player_name:fastCopyButton(
    	
    	LocalPlayer():Nick(), 
    	3, 3, 
    	panel_player:GetWide() - 6, 35, 
    	LocalPlayer():Nick()

    )

    player_name.DoRightClick = function(self)

        self:SetEnabled(false)
        self.rclick = true

        requestString(LocalPlayer():Nick(), 'Сменить ник', "Вы хотите сменить свой никнейм на: ", function(s)

			LocalPlayer():SetNick(s)

        end)

        timer.Simple(0.5, function()

            if IsValid(self) then
                
                self:SetEnabled(true)
                self.rclick = false

            end

        end)

    end

    player_name.Think = function(self)
    	
    	self:fastUpdateText(LocalPlayer():Nick())

    end

    local player_description = vgui.Create('DButton', panel_player)
    player_description:fastCopyButton(
    	
    	LocalPlayer():Description(), 
    	3, 41, 
    	panel_player:GetWide() - 6, 35, 
    	LocalPlayer():Description()

    )

    player_description.DoRightClick = function(self)

        self:SetEnabled(false)
        self.rclick = true
            
        requestString(LocalPlayer():getFullDescription(), 'Сменить описание', "Вы хотите сменить своё описание на: ", function(s)

            LocalPlayer():SetDescription(s)

        end)

        timer.Simple(0.5, function()

            if IsValid(self) then
                
                self:SetEnabled(true)
                self.rclick = false

            end

        end)

    end

    player_description.Think = function(self)
    	
    	self:fastUpdateText(LocalPlayer():Description())

    end

    local player_steamid = vgui.Create('DButton', panel_player)
    player_steamid:fastCopyButton(
    	
    	LocalPlayer():SteamID(), 
    	3, 79, 
    	panel_player:GetWide() / 2 - 5, 35, 
    	LocalPlayer():SteamID()

    )

    local player_ping = vgui.Create('DButton', panel_player)
    player_ping:fastCopyButton(
    	
    	'Ping: ' .. LocalPlayer():Ping(), 
    	panel_player:GetWide() / 2 + 3, 79, 
    	panel_player:GetWide() / 2 - 5, 35,
    	'Ping: ' .. LocalPlayer():Ping()

    )

    player_ping.Think = function(self)
    	
    	self:fastUpdateText('Ping: ' .. LocalPlayer():Ping())

    end

    local player_killsdeaths = vgui.Create('DButton', panel_player)
    player_killsdeaths:fastCopyButton(
    	
    	'Kills: ' .. LocalPlayer():Frags() .. ' || ' .. 'Deaths: ' .. LocalPlayer():Deaths(), 
    	panel_player:GetWide() / 2 + 3, 117, 
    	panel_player:GetWide() / 2 - 5, 35, 
    	'Kills: ' .. LocalPlayer():Frags() .. ' || ' .. 'Deaths: ' .. LocalPlayer():Deaths()

    )

    player_killsdeaths.Think = function(self)
    	
    	self:fastUpdateText('Kills: ' .. LocalPlayer():Frags() .. ' || ' .. 'Deaths: ' .. LocalPlayer():Deaths())

    end

    local player_role = vgui.Create('DButton', panel_player)
    player_role:fastCopyButton(
    	
    	'Role: ' .. LocalPlayer():GetUserGroup(), 
    	3, 117, 
    	panel_player:GetWide() / 2 - 5, 35, 
    	'Role: ' .. LocalPlayer():GetUserGroup()

    )

    player_role.Think = function(self)
    	
    	self:fastUpdateText('Role: ' .. LocalPlayer():GetUserGroup())

    end

    local player_hparmor = vgui.Create('DButton', panel_player)
    player_hparmor:fastCopyButton(
    	
    	'HP: ' .. LocalPlayer():Health() .. ' || ' .. 'Armor: ' .. LocalPlayer():Armor(),
    	panel_player:GetWide() / 2 + 3, 155,
    	panel_player:GetWide() / 2 - 5, 35,
    	'HP: ' .. LocalPlayer():Health() .. ' || ' .. 'Armor: ' .. LocalPlayer():Armor()

    )

    player_hparmor.Think = function(self)
    	
    	self:fastUpdateText('HP: ' .. LocalPlayer():Health() .. ' || ' .. 'Armor: ' .. LocalPlayer():Armor())

    end

    local player_mdl_button = vgui.Create('DButton', panel_player)
    player_mdl_button:fastCopyButton(
    	
    	'', 
    	3, 155, 
    	panel_player:GetWide() / 2 - 5, 35, 
    	LocalPlayer():GetModel()
    
    )

    local bg_player_mdl = vgui.Create('DPanel', player_mdl_button)
    local player_mdl = vgui.Create('SpawnIcon', bg_player_mdl)
    player_mdl:fastCopyIcon(LocalPlayer():GetModel(), 3, 3, 29, player_mdl_button:GetTall() - 6, bg_player_mdl)
    player_mdl.startModel = LocalPlayer():GetModel()

    player_mdl.Think = function(self)
    	
    	if self.startModel != LocalPlayer():GetModel() then

            self.startModel = LocalPlayer():GetModel()
            self:SetModel(self.startModel)

        end

    end

    local player_mdl_text = vgui.Create('DLabel', player_mdl_button)
    player_mdl_text:fastCopyLabel(LocalPlayer():GetModel(), 'Main_Font', 35, 1, 212, 35)

    player_mdl_text.Think = function(self)
    	
    	self:fastUpdateText(LocalPlayer():GetModel())

    end

    if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():Alive() then

		local weapon_mdl_button = vgui.Create('DButton', panel_player)
		weapon_mdl_button:fastCopyButton(
		    	
		  	LocalPlayer():GetActiveWeapon():GetPrintName(), 
		    3, 193, 
		    panel_player:GetWide() / 2 - 5, 35, 
		    LocalPlayer():GetActiveWeapon():GetPrintName()

		)

		weapon_mdl_button.Think = function(self)

		  	if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():Alive() then
		    	
		    	self:fastUpdateText(LocalPlayer():GetActiveWeapon():GetPrintName())

		    end

		end

		local ammo_button = vgui.Create('DButton', panel_player)
		ammo_button:fastCopyButton(
		    	
			'Ammo: ' .. LocalPlayer():GetActiveWeapon():Clip1() .. ' / ' .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), 
			panel_player:GetWide() / 2 + 3, 193, 
			panel_player:GetWide() / 2 - 5, 35, 
			'Ammo: ' .. LocalPlayer():GetActiveWeapon():Clip1() .. ' / ' .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())

		)

		ammo_button.Think = function(self)

			if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():Alive() then
		    	
		    	self:fastUpdateText('Ammo: ' .. LocalPlayer():GetActiveWeapon():Clip1() .. ' / ' .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()))

			end

		end

	end

    local openInventory = vgui.Create('DButton', panel_player)
    openInventory:fastCopyButton(
                
        'Открыть инвентарь', 
        3, 269, 
        panel_player:GetWide() - 5, 35, 
        ''

    )

    openInventory.DoClick = function(self)

        self:SetEnabled(false)
        self.click = true

        timer.Simple(0.5, function()

            if IsValid(self) then
                
                self:SetEnabled(true)
                self.click = false

            end

        end)

        if IsValid(inventory) then return end

        inventory = vgui.Create('DFrame')
        local inventory_close = vgui.Create('DButton', inventory)
        local inventory_panel = vgui.Create('DPanel', inventory)
        inventory:fastCopyFrame(
            
            ScrW() / 5, ScrH() / 2,
            inventory_close,
            inventory_panel,
            true

        )

        local inventory_scroll = vgui.Create("DScrollPanel", inventory_panel)
        inventory_scroll:fastCopyScroll(
        
            3, 3, 
            inventory_panel:GetWide() - 6, inventory_panel:GetTall() - 6

        )

        net.Start('LoadItemsPlayer')
        net.SendToServer()

        net.Receive('LoadItemsPlayer', function()

            local items = net.ReadTable()

            for i = 1, table.maxn(items) do

                if items[i] then

                    local inventoryItem = inventory_scroll:Add('DButton')
                    inventoryItem:fastCopyButton('', 0, 0, inventory_panel:GetWide() - 6, 35, i)
                    inventoryItem:Dock(TOP)
                    inventoryItem:DockMargin(0, 0, 0, 3)
                    inventoryItem.itemAssociation = i

                    local inventoryItemInfo = vgui.Create('DLabel', inventoryItem)
                    inventoryItemInfo:fastCopyLabel(items[i].name, 'Main_Font', 35, 1, inventory_panel:GetWide() - 6, 35)

                    local inventoryItemInfo_bg = vgui.Create('DPanel', inventoryItem)
                    local inventoryItemInfo_icon = vgui.Create('SpawnIcon', inventoryItemInfo_bg)
                    inventoryItemInfo_icon:fastCopyIcon(items[i].model, 3, 3, 29, inventoryItem:GetTall() - 6, inventoryItemInfo_bg)

                    inventoryItem.DoClick = function(self)

                        self:SetEnabled(false)
                        self.click = true

                        timer.Simple(0.5, function()

                            if IsValid(self) then
                                
                                self:SetEnabled(true)
                                self.click = false

                            end

                        end)

                        if IsValid(savedItemsActs) then return end

                        savedItemsActs = vgui.Create('DFrame')
                        local savedItemsActs_close = vgui.Create('DButton', savedItemsActs)
                        local savedItemsActs_panel = vgui.Create('DPanel', savedItemsActs)
                        savedItemsActs:fastCopyFrame(
                                
                            150, 110,
                            savedItemsActs_close,
                            savedItemsActs_panel,
                            true

                        )

                        local savedCharLoad = vgui.Create('DButton', savedItemsActs_panel)
                        savedCharLoad:fastCopyButton(
                                
                            'Выкинуть', 
                            3, 3, 
                            savedItemsActs_panel:GetWide() - 6, 35, 
                            ''

                        )

                        savedCharLoad.DoClick = function(self)

                            self:SetEnabled(false)
                            self.click = true

                            timer.Simple(0.5, function()

                                if IsValid(self) then
                                        
                                    self:SetEnabled(true)
                                    self.click = false

                                end

                            end)

                            net.Start('DropItemsFromPlayer')

                                net.WriteTable(items[inventoryItem.itemAssociation].col)
                                net.WriteString(items[inventoryItem.itemAssociation].mat)
                                net.WriteString(items[inventoryItem.itemAssociation].model)
                                net.WriteString(items[inventoryItem.itemAssociation].name)
                                net.WriteInt(inventoryItem.itemAssociation, 32)

                            net.SendToServer()

                            inventoryItem:Remove()
                            savedItemsActs:Close()

                        end

                        local savedCharDelete = vgui.Create('DButton', savedItemsActs_panel)
                        savedCharDelete:fastCopyButton(
                                
                            'Использовать', 
                            3, savedItemsActs_panel:GetTall() - 38, 
                            savedItemsActs_panel:GetWide() - 6, 35, 
                            ''

                        )

                        savedCharDelete.DoClick = function(self)

                            self:SetEnabled(false)
                            self.click = true

                            timer.Simple(0.5, function()

                                if IsValid(self) then
                                        
                                    self:SetEnabled(true)
                                    self.click = false

                                end

                            end)

                            net.Start('UseItemsFromPlayer')

                                net.WriteTable(items[inventoryItem.itemAssociation].col)
                                net.WriteString(items[inventoryItem.itemAssociation].mat)
                                net.WriteString(items[inventoryItem.itemAssociation].model)
                                net.WriteString(items[inventoryItem.itemAssociation].name)
                                net.WriteInt(inventoryItem.itemAssociation, 32)

                            net.SendToServer()

                            inventoryItem:Remove()
                            savedItemsActs:Close()

                        end

                    end

                end

            end

        end)

    end

	local characters_button = vgui.Create('DButton', panel_player)
	characters_button:fastCopyButton(
		    	
		'Сменить персонажа', 
		3, 231, 
		panel_player:GetWide() - 5, 35, 
		''

	)

	characters_button.DoClick = function(self)

        self:SetEnabled(false)
        self.click = true

        timer.Simple(0.5, function()

            if IsValid(self) then
                
                self:SetEnabled(true)
                self.click = false

            end

        end)

        if IsValid(button_chars) then return end

        button_chars = vgui.Create('DFrame')
        local chars_close = vgui.Create('DButton', button_chars)
        local chars_panel = vgui.Create('DPanel', button_chars)
        button_chars:fastCopyFrame(
        	
        	ScrW() / 4, ScrH() / 3,
        	chars_close,
        	chars_panel,
        	true

        )

        local chars_scroll = vgui.Create("DScrollPanel", chars_panel)
    	chars_scroll:fastCopyScroll(
    	
	    	3, 3, 
	    	chars_panel:GetWide() - 6, chars_panel:GetTall() - 44

    	)

        net.Start('GetSaveCharFromPlayer')

        net.SendToServer()

        net.Receive('GetSaveCharFromPlayer', function()

            local charTable = net.ReadTable()

            for i = 1, table.maxn(charTable) do 

                if charTable[i] then
                
                    local savedChar = chars_scroll:Add('DButton')
                    savedChar:fastCopyButton('', 0, 0, chars_panel:GetWide() - 6, 35, i)
                    savedChar:Dock(TOP)
                    savedChar:DockMargin(0, 0, 0, 3)
                    savedChar.charAssociation = i

                    local savedCharInfo = vgui.Create('DLabel', savedChar)
                    savedCharInfo:fastCopyLabel('| ' .. charTable[i].name .. ' | ' .. charTable[i].desc .. ' | ', 'Main_Font', 35, 1, chars_panel:GetWide() - 6, 35)

                    savedCharInfo.Think = function(self)

                        if charTable[i] then
                            
                            self:fastUpdateText('| ' .. charTable[i].name .. ' | ' .. charTable[i].desc .. ' | ')

                        end

                    end

                    local savedChar_icon_bg = vgui.Create('DPanel', savedChar)
                    local savedChar_icon = vgui.Create('SpawnIcon', savedChar_icon_bg)
                    savedChar_icon:fastCopyIcon(charTable[i].model, 3, 3, 29, savedChar:GetTall() - 6, savedChar_icon_bg)
                    savedChar_icon.modelStart = charTable[i].model

                    savedChar_icon.Think = function(self)

                        if charTable[i] then
                            
                            if self.modelStart != charTable[i].model then

                                self.modelStart = charTable[i].model
                                self:SetModel(self.modelStart)

                            end

                        end

                    end

                    savedChar.DoClick = function(self)

                        self:SetEnabled(false)
                        self.click = true

                        timer.Simple(0.5, function()

                            if IsValid(self) then
                                
                                self:SetEnabled(true)
                                self.click = false

                            end

                        end)

                        if IsValid(savedCharActs) then return end

                        savedCharActs = vgui.Create('DFrame')
                        local savedCharActs_close = vgui.Create('DButton', savedCharActs)
                        local savedCharActs_panel = vgui.Create('DPanel', savedCharActs)
                        savedCharActs:fastCopyFrame(
                            
                            150, 110,
                            savedCharActs_close,
                            savedCharActs_panel,
                            true

                        )

                        local savedCharLoad = vgui.Create('DButton', savedCharActs_panel)
                        savedCharLoad:fastCopyButton(
                            
                            'Загрузить', 
                            3, 3, 
                            savedCharActs_panel:GetWide() - 6, 35, 
                            ''

                        )

                        savedCharLoad.DoClick = function(self)

                            self:SetEnabled(false)
                            self.click = true

                            timer.Simple(0.5, function()

                                if IsValid(self) then
                                    
                                    self:SetEnabled(true)
                                    self.click = false

                                end

                            end)

                            net.Start('LoadSaveCharForPlayer')

                                net.WriteInt(savedChar.charAssociation, 32)

                            net.SendToServer()

                            savedCharActs:Close()

                        end

                        local savedCharDelete = vgui.Create('DButton', savedCharActs_panel)
                        savedCharDelete:fastCopyButton(
                            
                            'Удалить', 
                            3, savedCharActs_panel:GetTall() - 38, 
                            savedCharActs_panel:GetWide() - 6, 35, 
                            ''

                        )

                        savedCharDelete.DoClick = function(self)

                            self:SetEnabled(false)
                            self.click = true

                            timer.Simple(0.5, function()

                                if IsValid(self) then
                                    
                                    self:SetEnabled(true)
                                    self.click = false

                                end

                            end)

                            net.Start('DeleteSaveCharFromPlayer')

                                net.WriteInt(savedChar.charAssociation, 32)

                            net.SendToServer()

                            if IsValid(savedChar) then
                                
                                savedChar:Remove()

                            end

                            savedCharActs:Close()

                        end

                    end

                end

            end

        end)

        button_chars_create = vgui.Create('DButton', chars_panel)
        button_chars_create:fastCopyButton(
        	
        	'Создать', 
        	chars_panel:GetWide() / 4, chars_panel:GetTall() - 38, 
        	chars_panel:GetWide() / 2, 35, 
        	''

        )

        button_chars_create.DoClick = function(self)

	        self:SetEnabled(false)
	        self.click = true

	        timer.Simple(0.5, function()

	            if IsValid(self) then
	                
	                self:SetEnabled(true)
	                self.click = false

	            end

	        end)

	        if IsValid(create_character_form) then return end

	        button_chars:Close()

	        create_character_form = vgui.Create('DFrame')
		    local create_character_close = vgui.Create('DButton', create_character_form)
		    create_character_form:fastCopyFrame(
		        	
		     	ScrW() / 2, ScrH() / 2,
		        create_character_close,
		        create_character_panel,
		        false

		    )

		    local create_character_panel = vgui.Create('DPanel', create_character_form)
		    create_character_panel:fastCopyPanel(3, 9 + create_character_close:GetTall(), create_character_form:GetWide() / 2 - 6, create_character_form:GetTall() - 12 - create_character_close:GetTall())

		    local create_character_panel2 = vgui.Create('DPanel', create_character_form)
		    create_character_panel2:fastCopyPanel(create_character_form:GetWide() / 2 + 1, 9 + create_character_close:GetTall(), create_character_form:GetWide() / 2 - 4, create_character_form:GetTall() - 12 - create_character_close:GetTall())

		    local char_name_entry_label = vgui.Create('DLabel', create_character_panel)
	        char_name_entry_label:fastCopyLabel("Ваше имя: ", 'RQ_Font', 3, 11, 212, 35)

		    local char_name_entry = vgui.Create('DTextEntry', create_character_panel)
		    char_name_entry:SetSize(create_character_panel:GetWide() / 1.8, 24)
		    char_name_entry:SetPos(create_character_panel:GetWide() / 2.5, 16)
		    char_name_entry:SetValue('')
		   	char_name_entry:SetFont('Main_Font')
			char_name_entry:SetTextColor(Color(0, 0, 0, 255))
			char_name_entry:SetCursorColor(Color(0, 0, 0, 255))
			char_name_entry:SetPaintBorderEnabled(true)
			char_name_entry:SetPaintBackgroundEnabled(true)
			char_name_entry:SetDrawBorder(true)
			char_name_entry:SetPaintBackground(true)

			local char_desc_entry_label = vgui.Create('DLabel', create_character_panel)
	        char_desc_entry_label:fastCopyLabel("Ваше описание: ", 'RQ_Font', 3, 46, 212, 35)

		    local char_desc_entry = vgui.Create('DTextEntry', create_character_panel)
		    char_desc_entry:SetSize(create_character_panel:GetWide() / 1.8, 24)
		    char_desc_entry:SetPos(create_character_panel:GetWide() / 2.5, 52)
		    char_desc_entry:SetValue('')
		    char_desc_entry:SetFont('Main_Font')
			char_desc_entry:SetTextColor(Color(0, 0, 0, 255))
			char_desc_entry:SetCursorColor(Color(0, 0, 0, 255))
			char_desc_entry:SetPaintBorderEnabled(true)
			char_desc_entry:SetPaintBackgroundEnabled(true)
			char_desc_entry:SetDrawBorder(true)
			char_desc_entry:SetPaintBackground(true)

			local char_bodygroup_entry_label = vgui.Create('DLabel', create_character_panel)
	        char_bodygroup_entry_label:fastCopyLabel("Выбрать бодигруппы: ", 'RQ_Font', 0, 0, 275, 35)
	        char_bodygroup_entry_label:SetPos(create_character_panel:GetWide() / 2 - char_bodygroup_entry_label:fastGetLabelSize("Выбрать бодигруппы: ", 'RQ_Font') / 2, 81)

	        local charSelectedModel = "models/player/dod_american.mdl"

			local selectedModelModel = vgui.Create("DModelPanel", create_character_panel2)
			selectedModelModel:Dock(FILL)
			selectedModelModel:SetFOV( 80 )
			selectedModelModel:SetCamPos(Vector( -50, 0, 50 ))
			selectedModelModel:SetModel(charSelectedModel)
			selectedModelModel:SetCursor("sizewe")
			selectedModelModel.Angles = Angle(0, 0, 0)

			function selectedModelModel:DragMousePress()
				
				self.PressX, self.PressY = gui.MousePos()
				self.Pressed = true
			
			end

			function selectedModelModel:DragMouseRelease() 

				self.Pressed = false 

			end

			function selectedModelModel:LayoutEntity(ent)
				
				if self.bAnimated then self:RunAnimation() end

				if self.Pressed then
					
					local mx = gui.MousePos()
					self.Angles = self.Angles - Angle(0, ((self.PressX or mx) - mx) / 2, 0)

					self.PressX, self.PressY = gui.MousePos()
				
				end

				ent:SetAngles(self.Angles)
			
			end

			local selectedModelModelScroll = vgui.Create("DScrollPanel", create_character_panel)
		    selectedModelModelScroll:fastCopyScroll(
		    	
		    	40, 133, 
		    	300, create_character_panel:GetTall() / 2

		    )

			for i = 1, #selectedModelModel.Entity:GetBodyGroups() do 

				local selectedModelModelSlider = selectedModelModelScroll:Add("DNumSlider")
				selectedModelModelSlider:SetSize(300, 50)		
				selectedModelModelSlider:SetMin(0)				
				selectedModelModelSlider:SetMax(table.maxn(selectedModelModel.Entity:GetBodyGroups()[i]['submodels']))		
				selectedModelModelSlider:SetDecimals(0)
		        selectedModelModelSlider:Dock(TOP)
	        	selectedModelModelSlider:DockMargin(0, 0, 0, 3)	

	        	selectedModelModelSlider.bodygroup = 0
	        	selectedModelModelSlider.id = selectedModelModel.Entity:GetBodyGroups()[i].id

				selectedModelModelSlider.OnValueChanged = function(self, value)

					self.bodygroup = value

					selectedModelModel.Entity:SetBodygroup(self.id, self.bodygroup)

				end

			end

			selectModelButton = vgui.Create('DButton', create_character_panel)
	        selectModelButton:fastCopyButton(
	        	
	        	'Выбрать модель', 
	        	create_character_panel:GetWide() / 4, create_character_panel:GetTall() - 78, 
	        	create_character_panel:GetWide() / 2, 35, 
	        	''

	        )

	        selectModelButton.DoClick = function(self)

		        self:SetEnabled(false)
		        self.click = true

		        timer.Simple(0.5, function()

		            if IsValid(self) then
		                
		                self:SetEnabled(true)
		                self.click = false

		            end

		        end)

		       selectModelFrame = vgui.Create('DFrame')
		       local selectModelFrame_close = vgui.Create('DButton', selectModelFrame)
		       local selectModelFrame_panel = vgui.Create('DPanel', selectModelFrame)
		       selectModelFrame:fastCopyFrame(
		        	
			        ScrW() / 4, ScrH() / 2,
			        selectModelFrame_close,
			        selectModelFrame_panel,
			        true

		       )

		       	local modelsScroll = vgui.Create("DScrollPanel", selectModelFrame_panel)
		       	modelsScroll:DockPadding( 8, 8, 8, 8 )
				modelsScroll:fastCopyScroll(
				    	
				   	3, 3, 
				    selectModelFrame_panel:GetWide() - 6, selectModelFrame_panel:GetTall() - 6

				)

		        for k,v in SortedPairs(player_manager.AllValidModels()) do 

		        	local modelToChooseB = modelsScroll:Add('DButton')
			        modelToChooseB:fastCopyButton(
			        	
			        	v, 
			        	modelsScroll:GetWide() / 4, modelsScroll:GetTall() - 78, 
			        	modelsScroll:GetWide(), 64, 
			        	''

			        )
			        modelToChooseB:Dock(TOP)
			        modelToChooseB:DockMargin(3, 3, 3, 3)
			        modelToChooseB.modelPath = v

			        local modelToChoose = vgui.Create("SpawnIcon", modelToChooseB)
		        	modelToChoose:SetModel(v)
		        	modelToChoose:SetTooltip(v)
		        	modelToChoose:Dock(LEFT)
		        	modelToChoose:SetSize(64, 64)

			        modelToChooseB.DoClick = function(self)

				        self:SetEnabled(false)
				        self.click = true

				        timer.Simple(0.5, function()

				            if IsValid(self) then
				                
				                self:SetEnabled(true)
				                self.click = false

				            end

				        end)

				        selectedModelModel:SetModel(self.modelPath)
				        selectedModelModelScroll:GetCanvas():Clear()

				        for i = 1, #selectedModelModel.Entity:GetBodyGroups() do 

							local selectedModelModelSlider = selectedModelModelScroll:Add("DNumSlider")
							selectedModelModelSlider:SetSize(300, 50)		
							selectedModelModelSlider:SetMin(0)				
							selectedModelModelSlider:SetMax(table.maxn(selectedModelModel.Entity:GetBodyGroups()[i]['submodels']))				
							selectedModelModelSlider:SetDecimals(0)
					        selectedModelModelSlider:Dock(TOP)
				        	selectedModelModelSlider:DockMargin(0, 0, 0, 3)	

				        	selectedModelModelSlider.bodygroup = 0
				        	selectedModelModelSlider.id = selectedModelModel.Entity:GetBodyGroups()[i].id

							selectedModelModelSlider.OnValueChanged = function(self, value)

								self.bodygroup = value

								selectedModelModel.Entity:SetBodygroup(self.id, self.bodygroup)

							end

						end

				    end

		        end

		    end


			char_final_create = vgui.Create('DButton', create_character_panel)
	        char_final_create:fastCopyButton(
	        	
	        	'Создать', 
	        	0, 0, 
	        	create_character_panel:GetWide() / 4, 35, 
	        	''

	        )

	        char_final_create:SetPos(create_character_panel:GetWide() / 2 - char_final_create:GetWide() / 2, create_character_panel:GetTall() - 38)

	        char_final_create.DoClick = function(self)

		        self:SetEnabled(false)
		        self.click = true

		        timer.Simple(0.5, function()

		            if IsValid(self) then
		                
		                self:SetEnabled(true)
		                self.click = false

		            end

		        end)

                net.Start('AddSaveCharToPlayer')

                    net.WriteString(char_name_entry:GetValue())
                    net.WriteString(char_desc_entry:GetValue())
                    net.WriteString(selectedModelModel:GetModel())

                net.SendToServer()

                create_character_form:Close()

		    end

	    end

    end

    local list_scroll = vgui.Create("DScrollPanel", panel_list)
    list_scroll:fastCopyScroll(
    	
    	3, 3, 
    	panel_list:GetWide() - 6, panel_list:GetTall() - 6

    )

    local players = table.Copy(player.GetAll())
        
        table.sort(players, function(a, b) 

            return a:Nick() < b:Nick()
        
        end)

     for k,v in pairs(players) do
        
        local list_button = list_scroll:Add('DButton')
        list_button:fastCopyButton('', 0, 0, panel_list:GetWide() - 6, 35, v:Nick())
        list_button:Dock(TOP)
        list_button:DockMargin(0, 0, 0, 3)

        list_button.DoRightClick = function(self)

        self:SetEnabled(false)
        self.rclick = true

        timer.Simple(0.5, function()

            if IsValid(self) then
                
                self:SetEnabled(true)
                self.rclick = false

            end

        end)

        if IsValid(button_player) then return end

        button_player = vgui.Create('DFrame')
        local player_close = vgui.Create('DButton', button_player)
        local player_panel = vgui.Create('DPanel', button_player)
        button_player:fastCopyFrame(
        	
        	ScrW() / 4, ScrH() / 3,
        	player_close,
        	player_panel,
        	true

        )

        local panel_categories = vgui.Create("DCategoryList", player_panel)
        panel_categories:fastCopyCategory(
        	
        	3, 3,
        	player_panel:GetWide() - 6, player_panel:GetTall() - 6

        )

		local category_1 = panel_categories:Add('Standart function buttons')
		category_1:SetTall(100)
		category_1:DoExpansion(false)

		local category_2 = panel_categories:Add('Admin function buttons')
		category_2:SetTall(100)
		category_2:DoExpansion(false)

        for k,b in pairs(stnd_buttons) do

            local panel_button = category_1:Add("DButton")
            panel_button:fastCopyButton(b.name, 0, 0, player_panel:GetWide() - 6, 35, '')
            panel_button:Dock(TOP)
            panel_button:DockMargin(0, 0, 0, 3)

            panel_button.DoClick = function(self)

                self:SetEnabled(false)
                self.click = true

                timer.Simple(0.5, function()

                    if IsValid(self) then
                
                        self:SetEnabled(true)
                        self.click = false

                    end

                end)

                b.func(v)

            end

        end

        if LocalPlayer():IsAdmin() or LocalPlayer:IsSuperAdmin() then

            for k,b in pairs(adm_buttons) do

                local panel_button_adm = category_2:Add("DButton")
                panel_button_adm:fastCopyButton(b.name, 0, 0, player_panel:GetWide() - 6, 35, '')
                panel_button_adm:Dock(TOP)
                panel_button_adm:DockMargin(0, 0, 0, 3)

                panel_button_adm.DoClick = function(self)

                    self:SetEnabled(false)
                    self.click = true

                    timer.Simple(0.5, function()

                        if IsValid(self) then
                    
                            self:SetEnabled(true)
                            self.click = false

                        end

                    end)

                    b.func(v)

                end

            end

        end

    end

       	local bg_button_model = vgui.Create('DPanel', list_button)
        local button_model = vgui.Create('SpawnIcon', bg_button_model)
        button_model:fastCopyIcon(v:GetModel(), 3, 3, 29, list_button:GetTall() - 6, bg_button_model)
        button_model.modelStart = v:GetModel()

        button_model.Think = function(self)

            if IsValid(v) then
                
                if self.modelStart != v:GetModel() then

                    self.modelStart = v:GetModel()
                    self:SetModel(self.modelStart)

                end

            end

        end

        local button_text_nick = vgui.Create('DLabel', list_button)
        button_text_nick:fastCopyLabel(v:Nick(), 'Main_Font', 35, 1, 212, 35)

        button_text_nick.Think = function(self)

            if IsValid(v) then
                
            	self:fastUpdateText(v:Nick())

            end

        end

        local button_text_ping = vgui.Create('DLabel', list_button)
        button_text_ping:fastCopyLabel(v:Ping() .. ' ms', 'Main_Font', 15, 1, 60, 35)
        button_text_ping:Dock(RIGHT)

        button_text_ping.Think = function(self)

            if IsValid(v) then
                
            	self:fastUpdateText(v:Ping() .. ' ms')

            end

        end

    end

    return false
        
end

hook.Add('ScoreboardShow', 'ScoreboardOpen', ScoreboardOpen)

function ScoreboardClose()

	return false

end

hook.Add('ScoreboardHide', 'ScoreboardClose', ScoreboardClose)

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--