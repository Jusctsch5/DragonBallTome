-- dbt-generated-talk dialogue.CQ_KARATE
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[
Nakamura Sensei: ]=] .. [=[I've been following your training very closely, and I must say that I'm impressed! Fortunately you chose to study here instead of that kickboxing school next door. So many people who don't know any better study there...it's such a waste! Kickboxing is just mindless punching and kicking. No discipline, no control, no balance. Sure, it's a good workout and repetition is good, but it's very limiting in the long run. Why, I bet even a student like you could defeat their instructor, Bob. Hmm. That might not be a bad idea. I could do it myself, of course, but as the master of this school, it wouldn't mean anything. Of *course* I could beat him. But if you, a mere student did...that would really prove to people the value of mind and discipline in the martial arts.

]=],
	answers = {
		{[=[Yes, Sensei! I will defeat him in honorable combat!]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("challenge_kickboxing", "taken") end},
		{[=[No, sorry. I don't think that's such a good idea.]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player:takeQuest("challenge_kickboxing", "taken")
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
