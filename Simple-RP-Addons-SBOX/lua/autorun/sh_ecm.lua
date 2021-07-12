--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--

ECM = {}

ECM.Prefix = '/' -- You can change it!

ECM.Commands = {}

ECM.Commands['NoCommand'] = {}
ECM.Commands['NoCommand'].hud = '*Говорит*' -- You can change it!
ECM.Commands['NoCommand'].prefix = 'Общение' -- You can change it!
ECM.Commands['NoCommand'].postfix = 'сказал' -- You can change it!
ECM.Commands['NoCommand'].symbol = '' -- You can change it!
ECM.Commands['NoCommand'].colorCommand = Color(240, 235, 135, 255) -- You can change it!
ECM.Commands['NoCommand'].colorBracket = Color(240, 235, 135, 255) -- You can change it!
ECM.Commands['NoCommand'].colorText = Color(240, 235, 135, 255) -- You can change it!
ECM.Commands['NoCommand'].startSymbol = '"' -- You can change it!
ECM.Commands['NoCommand'].stopSymbol = '"' -- You can change it!
ECM.Commands['NoCommand'].monoColor = true -- You can change it!
ECM.Commands['NoCommand'].showPrefix = false -- You can change it!
ECM.Commands['NoCommand'].showPostfix = true -- You can change it!
ECM.Commands['NoCommand'].showNick = true -- You can change it!
ECM.Commands['NoCommand'].showColon = true -- You can change it!
ECM.Commands['NoCommand'].showBrackets = false -- You can change it!
ECM.Commands['NoCommand'].distance = 300 -- You can change it!

ECM.Commands['Other'] = {}
ECM.Commands['Other'].showTDPrefix = false -- You can change it!
ECM.Commands['Other'].tdPrefixColor = Color(255, 0, 25, 255) -- You can change it!
ECM.Commands['Other'].deadPrefix = '[D]' -- You can change it!
ECM.Commands['Other'].teamPrefix = '[T]' -- You can change it!
ECM.Commands['Other'].nickColor = Color(190, 190, 190, 255) -- You can change it!

function ECM.AddCommand(hud, prefix, postfix, symbol, colorCommand, colorBracket, colorText, startSymbol, stopSymbol, monoColor, showPrefix, showPostfix, showNick, showColon, showBrackets, distance)

	ECM.Commands[#ECM.Commands] = {}
	ECM.Commands[#ECM.Commands].hud = tostring(hud)
	ECM.Commands[#ECM.Commands].prefix = tostring(prefix)
	ECM.Commands[#ECM.Commands].postfix = tostring(postfix)
	ECM.Commands[#ECM.Commands].symbol = tostring(ECM.Prefix .. symbol)
	ECM.Commands[#ECM.Commands].colorCommand = colorCommand
	ECM.Commands[#ECM.Commands].colorBracket = colorBracket
	ECM.Commands[#ECM.Commands].colorText = colorText
	ECM.Commands[#ECM.Commands].startSymbol = tostring(startSymbol)
	ECM.Commands[#ECM.Commands].stopSymbol = tostring(stopSymbol)
	ECM.Commands[#ECM.Commands].monoColor = monoColor
	ECM.Commands[#ECM.Commands].showPrefix = showPrefix
	ECM.Commands[#ECM.Commands].showPostfix = showPostfix
	ECM.Commands[#ECM.Commands].showNick = showNick
	ECM.Commands[#ECM.Commands].showColon = showColon
	ECM.Commands[#ECM.Commands].showBrackets = showBrackets
	ECM.Commands[#ECM.Commands].distance = distance

	table.insert(ECM.Commands, ECM.Commands[#ECM.Commands])

end

-- You can add some commands! Example:
-- ECM.AddCommand('HUD', Prefix', 'symbol', 'Postfix', Color(0, 0, 0, 255) (CMD), Color(0, 0, 0, 255) (Brackets), Color(0, 0, 0, 255) (Text), '^^^', '<<<', true/false (monocolor ?), true/false (show prefix?), true/false (show postfix?), true/false (show nick?), true/false (show :?), true/false (show []?), dist (0 - no limit), type)

ECM.AddCommand('', 'OOC', '', '/', Color(255, 0, 25, 255), Color(255, 255, 255, 255), Color(255, 255, 255, 255), '', '', false, true, false, true, true, true, 0)
ECM.AddCommand('', 'LOOC', '', 'l', Color(255, 0, 25, 255), Color(255, 255, 255, 255), Color(255, 255, 255, 255), '', '', false, true, false, true, true, true, 300)
ECM.AddCommand('*Кричит*', 'Крик', 'крикнул', 'y', Color(240, 235, 135, 255), Color(240, 235, 135, 255), Color(240, 235, 135, 255), '"', '"', true, false, true, true, true, false, 750)
ECM.AddCommand('*Шепчет*', 'Шепот', 'шепчет', 'w', Color(240, 235, 135, 255), Color(240, 235, 135, 255), Color(240, 235, 135, 255), '"', '"', true, false, true, true, true, false, 150)
ECM.AddCommand('*Действует*', '', '', 'me', Color(240, 235, 135, 255), Color(240, 235, 135, 255), Color(240, 235, 135, 255), '', '', true, false, false, true, false, false, 300)
ECM.AddCommand('', '', '', 'it', Color(240, 235, 135, 255), Color(240, 235, 135, 255), Color(240, 235, 135, 255), '**', '', true, false, false, false, false, false, 300)
ECM.AddCommand('*Говорит по рации*','Рация', 'передает', 'r', Color(40, 175, 5, 255), Color(255, 255, 255, 255), Color(255, 255, 255, 255), '"', '"', true, false, true, true, true, false, 0)
ECM.AddCommand('', 'Глобальное РП', '', 'event', Color(255, 115, 0, 255), Color(255, 255, 255, 255), Color(255, 255, 255, 255), '**', '', true, false, false, false, false, false, 0)

table.remove(ECM.Commands, table.maxn(ECM.Commands))

--=======================================================================--
-- DO NOT TOUCH THIS!!! (Except lines with 'You can change it!')
--=======================================================================--