-- dbt-generated-talk dialogue.CQ_SUMO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if false then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not ((false)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	player.yawara_wt = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[I'm thrilled with your progress! You've really managed to put on some decent weight! That will help you tremendously in your fights. You have no idea how important that can be. Take Yawara, for instance. She was the instructor at the Judo school. Nice girl, kind heart, and a strong spirit! I really miss her. Unfortuantely she was a bit on the slender side, and some big, mean nasty scumbag took advantage of that, and went and killed her in a fight. I sure do wish I could lay my hands on that guy, whomever he was.

]=] end
		if which == [=[2]=] then return [=[I'm thrilled with your progress! You've really managed to put on some decent weight! That will help you tremendously in your fights. Still though, take someone like me...I still have a good 200 pounds on you. No matter how skilled you are, it's always going to be tough to overcome s bigger fighter. Take the girl next door, for instance, Yawara. We had a friendly match about a week ago, and she tried some sort of new technique she's been working on, and it just didn't work. I think I understand the principal she was working from, but she's just too small to move someone as big as me. Anyway, I didn't want to embarass her, so I fought her as if she were a real opponent, and unfortunately she got hurt. It was very embarassing all around. Anyway, she's been sulking and hasn't gone into the ring since. It's unhealthy. She's a fiery-spirited girl, and she really needs to get over it. Our schools have often competed with one another, but now it's all very awkward. I wonder if you might do us both a favor, and go challenge her to a friendly match? You're new, so she wouldn't associate you with me. She might accept, and, win or lose, it would be healthy for her to fight again.

]=] end
		if which == [=[]=] then return [=[
Honda: ]=] end
		return "..."
	end,
	answers = {
		{[=[Yes, I can appreciate the situation. I'll do what I can.]=], jump=[=[n0_g1_a]=], action=function(npc, player) player:takeQuest("challenge_judo", "taken") end, cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Beat up on a little girl? No, thanks.]=], jump=[=[n0_g1_b]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{"[Leave]"},
	},
}

local shown_n0_g1_a = nil
local function arm_n0_g1_a(player)
	if shown_n0_g1_a ~= nil then return shown_n0_g1_a end
	player:takeQuest("challenge_judo", "taken")
	shown_n0_g1_a = [=[]=]
	return shown_n0_g1_a
end
newChat{ id=[=[n0_g1_a]=],
	text = function(npc, player)
		local which = arm_n0_g1_a(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
