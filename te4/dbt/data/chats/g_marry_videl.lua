-- dbt-generated-talk dialogue.MARRY_VIDEL
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.akira_sushi and player.quests.akira_sushi.status == "taken") then
		player:takeQuest("akira_sushi", "finished")
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The next few days are an absolute blur, as you race through, yet find yourself rather enjoying what is probably the most expensive shotgun wedding of all time, followed by two weeks in Milan, compliments of Videl's father. Obviously you weren't in this for the money, but having a wife who's father happens to be extremely rich is sort of convenient. And, as it turns out, Videl is honest, loyal, feminine, and of course, extremely attractive.

]=] .. [=[Videl: ]=] .. [=[I'm sorry, this really isn't how I expected things to turn out, but...I think I've fallen in love with you.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Don't apologize. Just, be beautiful, be loving, and be mine.

]=] .. [=[Videl: ]=] .. [=[Yes, sir.

]=] .. [=[And, since Videl is still only 17, and still in school, that leaves you with plenty of time to continue on your adventures.

]=] end
		if which == [=[]=] then return [=[The next few days are an absolute blur, as you race through, yet find yourself rather enjoying what is probably the most expensive shotgun wedding of all time, followed by two weeks in Milan, compliments of Videl's father. Obviously you weren't in this for the money, but having a wife who's father happens to be extremely rich is sort of convenient. And, as it turns out, Videl is honest, loyal, feminine, and of course, extremely attractive.

]=] .. [=[Videl: ]=] .. [=[I'm sorry, this really isn't how I expected things to turn out, but...I think I've fallen in love with you.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Don't apologize. Just, be beautiful, be loving, and be mine.

]=] .. [=[Videl: ]=] .. [=[Yes, sir.

]=] .. [=[And, since Videl is still only 17, and still in school, that leaves you with plenty of time to continue on your adventures.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
