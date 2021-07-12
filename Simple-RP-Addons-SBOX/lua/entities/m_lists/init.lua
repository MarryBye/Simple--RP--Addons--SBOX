--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

local include = include
local AddCSLuaFile = AddCSLuaFile

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

local net = net
local util = util
local table = table
local cookie = cookie
local game = game
local IsValid = IsValid
local Color = Color
local MsgC = MsgC

util.AddNetworkString('EditLetter')
util.AddNetworkString('DeleteLetter')
util.AddNetworkString('SaveLetter')

function fullDeleteSaveCookieTable()
		
	cookie.Delete('SavedLetters')

end

function saveToCookieTable(_id, _pos, _ang, _text)

	local lettersTable = getSaveFromCookieTable()

	if istable(lettersTable) then

		for i = 1, table.maxn(lettersTable) do

			if lettersTable[i] then

				if lettersTable[i].id == _id then

					lettersTable[i] = nil

					break

				end

			end

		end

		lettersTable[table.maxn(lettersTable) + 1] = { id = _id, pos = _pos, ang = _ang, map = game.GetMap(), text = _text}

		cookie.Set('SavedLetters', util.TableToJSON(lettersTable))

	end

end

function deleteSaveFromCookieTable(id)

	local lettersTable = getSaveFromCookieTable()

	if istable(lettersTable) then

		for i = 1, table.maxn(lettersTable) do

			if lettersTable[i] then 
				
				if lettersTable[i].id == id then

					lettersTable[i] = nil

					cookie.Set('SavedLetters', util.TableToJSON(lettersTable))

					break

				end

			end

		end

	end

end

function getSaveFromCookieTable()

	if cookie.GetString('SavedLetters') == nil then
	
		return {}

	else

		return util.JSONToTable(cookie.GetString('SavedLetters'))

	end

end

function ENT:Initialize()

	self:SetModel("models/props_lab/clipboard.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():SetMass(10)

	self.id = 0
	self.letterText = ''

end

function ENT:SetLetterText(t)

	self.letterText = t

end

function ENT:GetLetterText()

	return self.letterText

end

function ENT:SetLetterID(id)

	self.id = id

end

function ENT:GetLetterID()

	return self.id

end

function ENT:AcceptInput(name, ply, caller)

	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	net.Start('EditLetter')

		net.WriteEntity(self)
		net.WriteString(self:GetLetterText())

	net.Send(ply)

end

function ENT:SaveLetter(t)

	if self:GetLetterID() == 0 then

		self:SetLetterID(math.random(1000000000, 9999999999))

	end

	self:SetLetterText(t)

	saveToCookieTable(self:GetLetterID(), self:GetPos(), self:GetAngles(), t)

end

function ENT:DeleteLetter()

	deleteSaveFromCookieTable(self:GetLetterID())

end

net.Receive('DeleteLetter', function(len, ply)

	local ent = net.ReadEntity()

	ent:DeleteLetter()
	ent:Remove()

end)

net.Receive('SaveLetter', function(len, ply)

	local ent = net.ReadEntity()
	local str = net.ReadString()

	ent:SaveLetter(str)

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--