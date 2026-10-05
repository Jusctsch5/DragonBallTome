-- dbt-generated-talk dialogue.MONK_ONE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.ofuda or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.ofuda or 0) == 0)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Hello. Welcome to Orinji Temple. What can I do for you?

]=] end
		if which == [=[2]=] then return [=[Hello again.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Hello. May I buy another ofuda?

]=] .. [=[Monk: ]=] .. [=[You still haven't used the last one I gave you.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Is that a problem?

]=] .. [=[Monk: ]=] .. [=[Not at all. It is excellent that you haven't had the need to protect yourself from evil spirits or demons. But it would be inviting misfortune to be too prepared for such things. Water gathers in deep pits, and too much preparation for bad events may aid them in finding you. One ofuda is all you need.

]=] end
		if which == [=[]=] then return [=[Monk: ]=] end
		return "..."
	end,
	answers = {
		{[=[Oh, nothing much. I'm just exploring. Thanks, though.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	if (player.money or 0) > 99 then
		shown_n0_b = [=[1]=]
		return shown_n0_b
	end
	if not (((player.money or 0) > 99)) then
		shown_n0_b = [=[2]=]
		return shown_n0_b
	end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[Monk: ]=] .. [=[I could paint an ofuda for you, if you'd like. If you're willing to donate 100zn to the Temple, that is.

]=] end
		if which == [=[2]=] then return [=[Monk: ]=] .. [=[I could paint an ofuda for you, if you'd like. If you're willing to donate 100zn to the Temple, that is.

]=] end
		if which == [=[]=] then return [=[Monk: ]=] .. [=[I could paint an ofuda for you, if you'd like. If you're willing to donate 100zn to the Temple, that is.

]=] end
		return "..."
	end,
	answers = {
		{[=[Yes, please.]=], jump=[=[n0_b_b]=], cond=function(npc, player) return arm_n0_b(player) == [=[1]=] end},
		{[=[I'm sorry. I don't have 100zn. I'll come back another time.]=], jump=[=[n0_b_c]=], cond=function(npc, player) return arm_n0_b(player) == [=[2]=] end},
		{[=[What's an ofuda?]=], jump=[=[n0_b_a]=], cond=function(npc, player) return arm_n0_b(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a]=],
	text = function(npc, player)
		return [=[Monk: ]=] .. [=[Ofuda are charms, written out of paper to evoke a particular change in one's life, or for protection, and so on. A very popular choice is 'Akuryo Taisan,' which means 'Evil Spirit Begone!' Should you encounter any evil spirits or demons, it will surely help you to avoid harm. Simply read out the words on the ofuda, and smack the demon on the forehead with it. Works every time.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...uhh, your name wouldn't happen to be Mars would it?

]=] .. [=[Monk: ]=] .. [=[Mars? No. Why do you ask?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[No reason. Thanks for explaining.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
