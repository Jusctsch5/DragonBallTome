-- dbt-generated-talk dialogue.NAMEK_GENERIC
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.namek_general_state or 0) == 0 then
		player.namek_general_state = 1
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.namek_general_state or 0) == 999 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.namek_general_state or 0) == 0) or ((player.namek_general_state or 0) == 999)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Namek: ]=] .. [=[An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?

]=] end
		if which == [=[2]=] then return [=[Namek: ]=] end
		if which == [=[3]=] then return [=[Namek: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[.

]=] end
		return "..."
	end,
	answers = {
		{[=[A friend, I think. Who are you? Where am I?]=], jump=[=[n0_g0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[I am an explorer. I'm sorry...but why do I feel so heavy? It's difficult for me to even walk!]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a]=],
	text = function(npc, player)
		return [=[Namek: ]=] .. [=[This is the planet Namek, and I am a native of this planet. If you would be our friend, then you are most welcome.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you. Charming place. The colors here are lovely.

]=] .. [=[Namek: ]=] .. [=[And thank you, stranger. But perhaps I am not the most suitable contact for you. May I recommend that you visit one of our village Elders? I'm sure they'll be able tell you far more about our world than I could.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Village Elder? Alright. Thank you. I think I'll do that.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = function(npc, player)
		return [=[Namek: ]=] .. [=[Heavy? Ahh...you must come from a world with lighter gravity than ours. Yes, it can be difficult. I myself have never been off this planet, so I cannot say I have experienced what you describe. But, I have heard stories of other worlds.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[It...is difficult...yes. Please don't think me rude. I am an explorer, and I am glad to be here...but I didn't expect this.

]=] .. [=[Namek: ]=] .. [=[I understand. Perhaps you should speak to one of our Elders. We occassionally have guests from other worlds, and they may be able to help you. Or at least offer you a comfortable place to rest.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Oh? Where might I find them?

]=] .. [=[Namek: ]=] .. [=[Each of our villages have an Elder. Look for yurts carved of stone.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_d = nil
local function arm_n0_g0_d(player)
	if shown_n0_g0_d ~= nil then return shown_n0_g0_d end
	player.namek_general_state = 999
	shown_n0_g0_d = [=[]=]
	return shown_n0_g0_d
end
newChat{ id=[=[n0_g0_d]=],
	text = function(npc, player)
		arm_n0_g0_d(player)
		return [=[Namek: ]=] .. [=[I see. We of Namek have dealt with your kind before. And I do not believe you will be the last. Flee from this world while you're still able!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_e]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
