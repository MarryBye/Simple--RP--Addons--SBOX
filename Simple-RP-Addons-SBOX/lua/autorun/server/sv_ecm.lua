--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

AddCSLuaFile("autorun/client/cl_ecm.lua")
AddCSLuaFile("autorun/sh_ecm.lua")

include("autorun/sh_ecm.lua")

hook.Add("PlayerCanSeePlayersChat", "chatdistance", function(t, isTeam, l, s)
	
	local GM = gmod.GetGamemode()

	function GM:PlayerCanSeePlayersChat(str, isTeam, listener, speaker)

		local distance = listener:GetPos():Distance(speaker:GetPos())

		local symbol_pattern = '(' .. ECM.Prefix .. '%g+)'
		local cmdStart, cmdEnd = string.find(string.lower(str), symbol_pattern)

		for i = 0, table.maxn(ECM.Commands) do

			if cmdStart != nil and cmdEnd != nil then

				local command = string.sub(str, cmdStart, cmdEnd)

				if string.lower(command) == string.lower(ECM.Commands[i].symbol) then

					if distance <= ECM.Commands[i].distance or ECM.Commands[i].distance == 0 then

						return true

					else

						MsgAll(speaker:Nick() .. ': ' .. ECM.Commands["NoCommand"].startSymbol .. str .. ECM.Commands["NoCommand"].stopSymbol .. '\n')

						return false

					end

				end

			else

				if distance <= ECM.Commands['NoCommand'].distance then

					return true

				else

					MsgAll(speaker:Nick() .. ': ' .. ECM.Commands["NoCommand"].startSymbol .. str .. ECM.Commands["NoCommand"].stopSymbol .. '\n')

					return false

				end

			end

		end

	end

end)

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--
