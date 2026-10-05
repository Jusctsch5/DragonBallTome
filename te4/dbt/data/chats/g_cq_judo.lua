-- dbt-generated-talk dialogue.CQ_JUDO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player.yawara_wt = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[
Yawara: ]=] .. [=[You've really been a wonderful student! You know, I think I'm going to confide in you about something that's been bothering me. I've always wanted to participate in the World Tournament, and over the past year I've developed a special technique to help me win! Unfortunately last week I had what was supposed to be a friendly match with Honda, the sumo instructor next door. He took it a little too seriously, and threw me to the floor hard enough that I broke my wrist. It will heal, but not in time for the Tournament. These things happen, I know...but ever since he's been parading around town telling everyone what a helpless girl I am. I can't help but wonder if the 'accident' was intentional. Anyway, I think I'm over it...mostly, but sometimes I think maybe it would be best if someone would remind Honda that he makes mistakes too. Still, though...I guess it's really not that important. He did beat me, after all, so maybe I should just get over it.

]=]
	end,
	answers = {
		{[=[No...I think someone should really go teach him some manners.]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("challenge_sumo", "taken") end},
		{[=[Yes, you're right. It's not such a big deal.]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player:takeQuest("challenge_sumo", "taken")
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
