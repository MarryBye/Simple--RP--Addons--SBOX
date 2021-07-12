local screen = Material('icons/loadScreen.png', "noclamp smooth")
local sounds = { 'hp_meme.wav' }
local screenLerp = 0
local pressBtnA = 255
local loadScreenActive = true

hook.Add('HUDPaint', 'LoadScreenMusic', function()

	surface.PlaySound(table.Random(sounds))

	if not timer.Exists('PlayLoadScreenMusic') then

		timer.Create('PlayLoadScreenMusic', 30, 0, function()

			surface.PlaySound(table.Random(sounds))

		end)

	end

	hook.Remove('HUDPaint', 'LoadScreenMusic')

end)

hook.Add('HUDPaint', 'LoadScreenForPlayerMagiaRPEbat', function()
	
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, ScrW(), ScrH())

	if loadScreenActive then
		
		screenLerp = Lerp(0.05, screenLerp, 255)

		if not timer.Exists('PRESSKNOPKUSUKA') then
			
			timer.Create('PRESSKNOPKUSUKA', 0.5, 0, function()

				if pressBtnA == 0 then 

					pressBtnA = 255

				else 

					pressBtnA = 0

				end

			end)

		end

	else

		screenLerp = Lerp(0.05, screenLerp, 0)
		pressBtnA = screenLerp

	end
		
	surface.SetDrawColor(255, 255, 255, screenLerp)
	surface.SetMaterial(screen)
	surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		
	surface.SetFont('LoadScreen')
	local w = surface.GetTextSize('Нажмите "ENTER" чтобы продолжить')
	text('Нажмите "ENTER" чтобы продолжить', 'LoadScreen', ScrW() / 2 - w / 2, ScrH() / 7, Color(255, 0, 0, pressBtnA))

	if not loadScreenActive then

		timer.Simple(1, function()

			hook.Remove('HUDPaint', 'LoadScreenForPlayerMagiaRPEbat')
			hook.Remove('PlayerButtonDown', 'EnterCheck')
			timer.Remove('PRESSKNOPKUSUKA')
			timer.Remove('PlayLoadScreenMusic')

			RunConsoleCommand('stopsound')

			net.Start('CheckEnter')

			net.SendToServer()

		end)

	end

end)

hook.Add("PlayerButtonDown", "EnterCheck", function(ply, button)
	
	if input.GetKeyName(button) == "ENTER" then
	
		loadScreenActive = false

	end

end)

hook.Add("StartChat", "BlockChatUntilEnter", function(isTeamChat)
	
	if loadScreenActive then 

		return true

	end
	
	return false

end)

hook.Add("EntityEmitSound", "BlockAltSoundsUntilEnter", function(t)
	
	if loadScreenActive then 

		return false

	end
	
end)