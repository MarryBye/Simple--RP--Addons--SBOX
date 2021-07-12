--[[
local restrictPlayerJoin = {
  
  	['BOT'] = true,

} -- Тут таблица бессмысленна, просто как пример, т.к. ему надо с таблицей игроков

gameevent.Listen('player_connect')
hook.Add('player_connect', 'players_cant_join_server', function(data)
  
  	local name = data.name
  	local steamid = data.networkid -- В кике можно использовать и UserID, и SteamID
  	local id = data.userid -- В кике можно использовать и UserID, и SteamID
  
  	if restrictPlayerJoin[steamid] then
    
    	game.KickID(id, name .. ': Access restricted')
    	print('[' .. steamid .. '] ' .. name .. ': Access restricted')
  
  	else

    	print('[' .. steamid .. '] ' .. name .. ': Access allowed')
  
  	end

end)]]