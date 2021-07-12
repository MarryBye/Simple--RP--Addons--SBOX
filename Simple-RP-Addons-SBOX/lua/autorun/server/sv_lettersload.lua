--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--

local hook = hook
local table = table
local game = game
local ents = ents
local pairs = pairs

concommand.Add('deleteLetters', function()

	fullDeleteSaveCookieTable()

	RunConsoleCommand('reloadLetters')

end)

concommand.Add('reloadLetters', function()

	for k,v in pairs(ents.FindByClass("m_lists")) do

		v:Remove()

	end

	local lettersTable = getSaveFromCookieTable()

	for i = 1, table.maxn(lettersTable) do

		if lettersTable[i] then

			if lettersTable[i].map == game.GetMap() then
				
				local letter = ents.Create("m_lists")
				
				letter:SetPos(lettersTable[i].pos)
				letter:SetAngles(lettersTable[i].ang)
				
				letter:Spawn()

				letter:SetLetterID(lettersTable[i].id)
				letter:SetLetterText(lettersTable[i].text)

			end

		end

	end

end)

hook.Add('PostGamemodeLoaded', 'AutoLoadLetters', function()

	timer.Simple(10, function()

		local lettersTable = getSaveFromCookieTable()

		for i = 1, table.maxn(lettersTable) do

			if lettersTable[i] then

				if lettersTable[i].map == game.GetMap() then
					
					local letter = ents.Create("m_lists")
					
					letter:SetPos(lettersTable[i].pos)
					letter:SetAngles(lettersTable[i].ang)
					
					letter:Spawn()

					letter:SetLetterID(lettersTable[i].id)
					letter:SetLetterText(lettersTable[i].text)

				end

			end

		end

	end)

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! 
--=======================================================================--