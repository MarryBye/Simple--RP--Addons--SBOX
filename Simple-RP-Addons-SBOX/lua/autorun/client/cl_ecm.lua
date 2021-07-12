--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

include("autorun/sh_ecm.lua")

function ECM.SendMessage(ply, str, isTeam, isDead)

	local message = {}
	local needToSend = true

	function ECM.msgTextAdd(value)
		
		message[#message + 1] = value

	end
	
	local symbol_pattern = '(' .. ECM.Prefix .. '%g+)'
	local cmdStart, cmdEnd = string.find(string.lower(str), symbol_pattern)

	for i = 0, table.maxn(ECM.Commands) do

		if cmdStart != nil and cmdEnd != nil then

			local command = string.sub(str, cmdStart, cmdEnd)

			if string.lower(command) == string.lower(ECM.Commands[i].symbol) then

			if ECM.Commands['Other'].showTDPrefix then
				
				if isTeam then
					
					ECM.msgTextAdd(ECM.Commands['Other'].tdPrefixColor)
					ECM.msgTextAdd(ECM.Commands['Other'].teamPrefix .. ' ')

				end

				if isDead then

					ECM.msgTextAdd(ECM.Commands['Other'].tdPrefixColor)
					ECM.msgTextAdd(ECM.Commands['Other'].deadPrefix .. ' ')

				end

			end
				
				if ECM.Commands[i].monoColor then
				
					ECM.msgTextAdd(ECM.Commands[i].colorCommand)

					if ECM.Commands[i].showBrackets then
						
						ECM.msgTextAdd('[')
					
					end
					
					if ECM.Commands[i].showPrefix then
						
						ECM.msgTextAdd(ECM.Commands[i].prefix)

					end
					
					if ECM.Commands[i].showBrackets then

						ECM.msgTextAdd(']')

					end

					if ECM.Commands[i].showNick then
						
						if ECM.Commands[i].showPrefix then
							
							ECM.msgTextAdd(' ')

						end

						ECM.msgTextAdd(ply:Nick())

						if ECM.Commands[i].showPostfix then

							ECM.msgTextAdd(' ' .. ECM.Commands[i].postfix)

						end

						if ECM.Commands[i].showColon then
							
							ECM.msgTextAdd(': ')

						else

							ECM.msgTextAdd(' ')

						end

					end

					ECM.msgTextAdd(ECM.Commands[i].startSymbol .. string.sub(str, string.len(ECM.Commands[i].symbol) + 2) .. ECM.Commands[i].stopSymbol)
					needToSend = false

				else
					
					if ECM.Commands[i].showBrackets then
						
						ECM.msgTextAdd(ECM.Commands[i].colorBracket)
						ECM.msgTextAdd('[')
					
					end

					ECM.msgTextAdd(ECM.Commands[i].colorCommand)
					
					if ECM.Commands[i].showPrefix then
						
						ECM.msgTextAdd(ECM.Commands[i].prefix)

					end
					
					if ECM.Commands[i].showBrackets then

						ECM.msgTextAdd(ECM.Commands[i].colorBracket)
						ECM.msgTextAdd(']')

					end

					if ECM.Commands[i].showNick then

						ECM.msgTextAdd(ECM.Commands['Other'].nickColor)

						if ECM.Commands[i].showPrefix then
							
							ECM.msgTextAdd(' ')

						end

						ECM.msgTextAdd(ply:Nick())

						if ECM.Commands[i].showPostfix then

							ECM.msgTextAdd(' ' .. ECM.Commands[i].postfix)

						end

						ECM.msgTextAdd(ECM.Commands[i].colorText)
						
						if ECM.Commands[i].showColon then
							
							ECM.msgTextAdd(': ')

						else

							ECM.msgTextAdd(' ')

						end

					end

					ECM.msgTextAdd(ECM.Commands[i].startSymbol .. string.sub(str, string.len(ECM.Commands[i].symbol) + 2) .. ECM.Commands[i].stopSymbol)
					needToSend = false

				end

			end

		end

	end

	if needToSend then

		if ECM.Commands['Other'].showTDPrefix then
				
			if isTeam then
					
				ECM.msgTextAdd(ECM.Commands['Other'].tdPrefixColor)
				ECM.msgTextAdd(ECM.Commands['Other'].teamPrefix .. ' ')

			end

			if isDead then

				ECM.msgTextAdd(ECM.Commands['Other'].tdPrefixColor)
				ECM.msgTextAdd(ECM.Commands['Other'].deadPrefix .. ' ')

			end

		end

				if ECM.Commands['NoCommand'].monoColor then
				
					ECM.msgTextAdd(ECM.Commands['NoCommand'].colorCommand)

					if ECM.Commands['NoCommand'].showBrackets then
						
						ECM.msgTextAdd('[')
					
					end
					
					if ECM.Commands['NoCommand'].showPrefix then
						
						ECM.msgTextAdd(ECM.Commands['NoCommand'].prefix)

					end
					
					if ECM.Commands['NoCommand'].showBrackets then

						ECM.msgTextAdd(']')

					end

					if ECM.Commands['NoCommand'].showNick then
						
						if ECM.Commands['NoCommand'].showPrefix then
							
							ECM.msgTextAdd(' ')

						end

						ECM.msgTextAdd(ply:Nick())

						if ECM.Commands['NoCommand'].showPostfix then

							ECM.msgTextAdd(' ' .. ECM.Commands['NoCommand'].postfix)

						end

						if ECM.Commands['NoCommand'].showColon then
							
							ECM.msgTextAdd(': ')

						else

							ECM.msgTextAdd(' ')

						end

					end

					ECM.msgTextAdd(ECM.Commands['NoCommand'].startSymbol .. str .. ECM.Commands['NoCommand'].stopSymbol)
					needToSend = false

				else
					
					if ECM.Commands['NoCommand'].showBrackets then
						
						ECM.msgTextAdd(ECM.Commands['NoCommand'].colorBracket)
						ECM.msgTextAdd('[')
					
					end

					ECM.msgTextAdd(ECM.Commands['NoCommand'].colorCommand)
					
					if ECM.Commands['NoCommand'].showPrefix then
						
						ECM.msgTextAdd(ECM.Commands['NoCommand'].prefix)

					end
					
					if ECM.Commands['NoCommand'].showBrackets then

						ECM.msgTextAdd(ECM.Commands['NoCommand'].colorBracket)
						ECM.msgTextAdd(']')

					end

					if ECM.Commands['NoCommand'].showNick then

						ECM.msgTextAdd(ECM.Commands['Other'].nickColor)

						if ECM.Commands['NoCommand'].showPrefix then
							
							ECM.msgTextAdd(' ')

						end

						ECM.msgTextAdd(ply:Nick())

						if ECM.Commands['NoCommand'].showPostfix then

							ECM.msgTextAdd(' ' .. ECM.Commands['NoCommand'].postfix)

						end

						ECM.msgTextAdd(ECM.Commands['NoCommand'].colorText)
						
						if ECM.Commands['NoCommand'].showColon then
							
							ECM.msgTextAdd(': ')

						else

							ECM.msgTextAdd(' ')

						end

					end

					ECM.msgTextAdd(ECM.Commands['NoCommand'].startSymbol .. str .. ECM.Commands['NoCommand'].stopSymbol)
					needToSend = false

				end

	end

	chat.AddText(unpack(message))

	return true

end

hook.Add("OnPlayerChat", "SendMessage", ECM.SendMessage)

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--
