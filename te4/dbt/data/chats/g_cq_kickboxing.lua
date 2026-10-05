-- dbt-generated-talk dialogue.CQ_KICKBOXING
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = function(npc, player)
		return [=[
Bob: ]=] .. [=[Hey, ]=] .. (player.name or "you") .. [=[! I'm really impressed with your progress! Fortunately you decided to study here instead of that karate school next door. Yeah, it's really too bad that so many people fall into that trap. I know, everybody thinks 'karate' when they think of martial arts, but most people don't realize karate is all about forms and tradition rather than actually fighting. We lose a lot of business to them. Hey...here's a thought: how'd you like to prove yourself by challenging their head instructor? I'd do it myself, but it wouldn't mean as much as if you did. I've been tournament fighting for years, but you're just a student. Think of it as your chance to break into the big league. How does that sound to you?

]=]
	end,
	answers = {
		{[=[Yeah, sure. I need a cool-down from my last workout anyway.]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("challenge_karate", "taken") end},
		{[=[No, sorry. I don't think that's such a good idea.]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player:takeQuest("challenge_karate", "taken")
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
