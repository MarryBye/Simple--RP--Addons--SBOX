util.AddNetworkString('AddSaveCharToPlayer')
util.AddNetworkString('GetSaveCharFromPlayer')
util.AddNetworkString('LoadSaveCharForPlayer')
util.AddNetworkString('DeleteSaveCharFromPlayer')

util.AddNetworkString('AddItemToPlayer')
util.AddNetworkString('DropItemsFromPlayer')
util.AddNetworkString('UseItemsFromPlayer')
util.AddNetworkString('LoadItemsPlayer')

local pmeta = FindMetaTable('Player')

concommand.Add('deleteInventory', function(ply)

	local items = ply:getPlayerItems()
	for i = 1, table.maxn(items) do

		if items[i] then
			
			ply:deletePlayerItem(i)

		end

	end

end)

concommand.Add('deleteChars', function(ply)

	local chars = ply:getPlayerChars()
	for i = 1, table.maxn(chars) do

		if chars[i] then
			
			ply:deletePlayerChar(i)

		end

	end

end)

function pmeta:Give(weap)

	local weapon = ents.Create(weap)
	weapon:SetPos(self:GetPos())
	
	weapon:Spawn()

	weapon:SetOwner(self)

end

pmeta.Give = pmeta.Give

function pmeta:addPlayerItem(ent)

	local itemTable = self:getPlayerItems()

	itemTable[table.maxn(itemTable) + 1] = { name = ent:GetClass(), model = ent:GetModel(), mat = ent:GetMaterial(), col = Color(ent:GetColor().r, ent:GetColor().g, ent:GetColor().b, ent:GetColor().a) }

	self:SetPData('PlayerItems', util.TableToJSON(itemTable))

end

function pmeta:deletePlayerItem(n)

	local itemTable = self:getPlayerItems()

	itemTable[n] = nil

	self:SetPData('PlayerItems', util.TableToJSON(itemTable))	

end

function pmeta:getPlayerItems()

	if self:GetPData('PlayerItems') == nil then
	
		return {}

	else

		return util.JSONToTable(self:GetPData('PlayerItems'))

	end

end

function pmeta:addPlayerChar(n, d, m)

	local charTable = self:getPlayerChars()

	charTable[table.maxn(charTable) + 1] = { name = n, desc = d, model = m }

	self:SetPData('PlayerChars', util.TableToJSON(charTable))

end

function pmeta:deletePlayerChar(n)

	local charTable = self:getPlayerChars()

	charTable[n] = nil

	self:SetPData('PlayerChars', util.TableToJSON(charTable))

end

function pmeta:getPlayerChars()

	if self:GetPData('PlayerChars') == nil then
	
		return {}

	else

		return util.JSONToTable(self:GetPData('PlayerChars'))

	end

end

function pmeta:setLastChosenChar(n)

	self:SetPData('LastChar', util.TableToJSON(n))

end

function pmeta:getLastChosenChar()

	if self:GetPData('LastChar') == nil then
	
		return {name = self:Nick(), desc = self:getFullDescription(), model = 'models/player/dod_american.mdl'}

	else

		return util.JSONToTable(self:GetPData('LastChar'))

	end

end

net.Receive('AddSaveCharToPlayer', function(_, ply)

	local name = net.ReadString()
	local desc = net.ReadString()
	local model = net.ReadString()

	ply:addPlayerChar(name, desc, model)

end)

net.Receive('GetSaveCharFromPlayer', function(_, ply)

	local chars = ply:getPlayerChars()

	net.Start('GetSaveCharFromPlayer')

		net.WriteTable(chars)

	net.Send(ply)

end)

net.Receive('LoadSaveCharForPlayer', function(_, ply)

	local chars = ply:getPlayerChars()
	local charNum = net.ReadInt(32)

	ply:setLastChosenChar(chars[charNum])

	ply:SetNick(chars[charNum].name)
	ply:SetDescription(chars[charNum].desc)
	ply:SetModel(chars[charNum].model)

end)

net.Receive('DeleteSaveCharFromPlayer', function(_, ply)

	local chars = ply:getPlayerChars()
	local charNum = net.ReadInt(32)

	ply:deletePlayerChar(charNum)

end)

net.Receive('DropItemsFromPlayer', function(_, ply)

	local col = net.ReadTable()
	local mat = net.ReadString()
	local model = net.ReadString()
	local name = net.ReadString()
	local num = net.ReadInt(32)

	local item = ents.Create(name)
	item:SetModel(model)
	item:SetPos(ply:GetPos())
	
	item:Spawn()

	item:SetColor(col)
	item:SetMaterial(Material(mat))

	ply:deletePlayerItem(num)

end)

net.Receive('LoadItemsPlayer', function(_, ply)

	local items = ply:getPlayerItems()

	net.Start('LoadItemsPlayer')

		net.WriteTable(items)

	net.Send(ply)

end)

net.Receive('UseItemsFromPlayer', function(_, ply)

	local col = net.ReadTable()
	local mat = net.ReadString()
	local model = net.ReadString()
	local name = net.ReadString()
	local num = net.ReadInt(32)

	local item = ents.Create(name)
	item:SetModel(model)
	item:SetPos(ply:GetPos())
	
	item:Spawn()

	item:SetColor(col)
	item:SetMaterial(Material(mat))

	item:SetOwner(ply)

	ply:deletePlayerItem(num)

end)

hook.Add('PlayerInitialSpawn', 'LoadModelOnStart', function(ply)

	timer.Simple(0.1, function()

		local char = ply:getLastChosenChar()

		ply:SetModel(char.model)

	end)

end)

hook.Add('PlayerSetModel', 'OffStandartModelChange', function(ply)

	return false

end)

hook.Add('PlayerCanPickupItem', 'OffStandartPickUpItem', function(ply, ent)

	if not IsValid(ent:GetOwner()) or not ent:GetOwner() == ply then
		
		return false

	end

end)

hook.Add('PlayerCanPickupWeapon', 'OffStandartPickUpWeapon', function(ply, ent)

	if not IsValid(ent:GetOwner()) or not ent:GetOwner() == ply then
		
		return false

	end

end)

hook.Add("AllowPlayerPickup", "OffStandartPickUp", function(ply, ent)
    
    return false

end)

local restrictedEnts = {
	
	['World'] = true,
	['player'] = true,
	['worldspawn'] = true,
	['prop_ragdoll'] = true,
	['prop_physics'] = true,
	[''] = true,
	[''] = true

}

hook.Add("PlayerButtonDown", "CheckPickupButton", function(ply, button)
	
	if button == 15 and ply:Crouching() then

		if IsValid(ply:GetEyeTrace().Entity) then
			
			if not restrictedEnts[ply:GetEyeTrace().Entity:GetClass()] then

				local dist = ply:GetPos():Distance(ply:GetEyeTrace().Entity:GetPos())

				if dist <= 50 then
					
					ply:addPlayerItem(ply:GetEyeTrace().Entity)
					ply:GetEyeTrace().Entity:Remove()

				end

			end

		end

	end

end)