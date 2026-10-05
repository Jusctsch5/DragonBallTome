-- dbt-generated-talk dialogue.MIA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if player:isPartied("RACE_MIA") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not ((player:isPartied("RACE_MIA"))) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Mia: ]=] .. [=[Wow!!! It's so -=FUN=- being in a party with you!!! Thank you so much!

]=] end
		if which == [=[2]=] then return [=[Mia: ]=] .. [=[HELLO!!!!!! :) :) :)

]=] .. [=[I wanna join your party!!!! May I? May I? Please?!!?!?

]=] end
		return "..."
	end,
	answers = {
		{[=[I'm glad you're having fun. Let's go explore some more, shall we?]=], jump=[=[n0_g0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[It was nice having you around, but I think it's time for me to move on.]=], jump=[=[n0_g0_b]=], action=function(npc, player) player:unparty("RACE_MIA") end, cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Sure.]=], jump=[=[n0_g1_a]=], action=function(npc, player) player:partyWith({define_as="RACE_MIA", name="companion", level=1}) end, cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[No chance.]=], jump=[=[n0_g1_b]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a]=],
	text = [=[Mia: ]=] .. [=[Yuppers!!!

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_b = nil
local function arm_n0_g0_b(player)
	if shown_n0_g0_b ~= nil then return shown_n0_g0_b end
	player:unparty("RACE_MIA")
	shown_n0_g0_b = [=[]=]
	return shown_n0_g0_b
end
newChat{ id=[=[n0_g0_b]=],
	text = function(npc, player)
		arm_n0_g0_b(player)
		return [=[Mia: ]=] .. [=[Ok! I'll go do something else exciting for a while! Come back if you want to play some more! :)

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a = nil
local function arm_n0_g1_a(player)
	if shown_n0_g1_a ~= nil then return shown_n0_g1_a end
	player:partyWith({define_as="RACE_MIA", name="companion", level=1})
	shown_n0_g1_a = [=[]=]
	return shown_n0_g1_a
end
newChat{ id=[=[n0_g1_a]=],
	text = function(npc, player)
		arm_n0_g1_a(player)
		return [=[Mia: ]=] .. [=[Yay! Yay for me! I get to be in a party, yay! I am a happy Mia!!! :)

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Wow. You're really into this, huh? Do you have anything useful to offer other than exhuberance?

]=] .. [=[Mia: ]=] .. [=[Yuppers! You can press 'p' to access the party command menu.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[That's good to know.

]=] .. [=[Mia: ]=] .. [=[Thank you! I aim to please. :)

]=]
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
