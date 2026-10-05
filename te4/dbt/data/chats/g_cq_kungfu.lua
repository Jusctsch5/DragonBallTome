-- dbt-generated-talk dialogue.CQ_KUNGFU
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[
Fong-Sai Yuk: ]=] .. [=[I'm very pleased with your progress! You've come a long ways. Fortuantely you chose to study here instead of that ridiculous fencing school next door. Great martial arts always comes from a strong initial foundation. You can't just build the top floor of a building and expect it to stand. Fencing is kind of like that. Still, a lot of people in this area to study there, and honestly I think it's detracted from the quality of martial arts in the whole city. Say...maybe you could challenge Jacques to a duel? I'm so much better than he is, it wouldn't mean nyathing if I did...but if you, as a student were to beat him...wow! That would show everybody how worthless fencing is! What do you say?

]=],
	answers = {
		{[=[Absolutely! I will prove to them the superiority of Kung-Fu!]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("challenge_fencing", "taken") end},
		{[=[No, sorry. I don't think that's such a good idea.]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player:takeQuest("challenge_fencing", "taken")
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
