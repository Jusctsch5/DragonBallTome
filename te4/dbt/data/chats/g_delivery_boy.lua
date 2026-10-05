-- dbt-generated-talk dialogue.DELIVERY_BOY
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
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Awww, man! This is way not cool. I don't think I want to be a part of this anymore.

]=] end
		if which == [=[2]=] then return [=[Hey, dude. You shouldn't be back here.

]=] end
		if which == [=[]=] then return [=[Delivery Boy: ]=] end
		return "..."
	end,
	answers = {
		{[=[Follow me. I'll take you back to Akira.]=], jump=[=[n0_g0_a]=], action=function(npc, player) player:partyWith({define_as="RACE_DELIVERY_BOY", name="companion", level=1}) end, cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Sounds like a personal problem to me. Deal with it, punk.]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Oh. Sorry.]=], jump=[=[n0_g1_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Akira was worried about you. I'm here to take you home.]=], jump=[=[n0_g1_b]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{"[Leave]"},
	},
}

local shown_n0_g0_a = nil
local function arm_n0_g0_a(player)
	if shown_n0_g0_a ~= nil then return shown_n0_g0_a end
	player:partyWith({define_as="RACE_DELIVERY_BOY", name="companion", level=1})
	shown_n0_g0_a = [=[]=]
	return shown_n0_g0_a
end
newChat{ id=[=[n0_g0_a]=],
	text = function(npc, player)
		arm_n0_g0_a(player)
		return [=[Delivery Boy: ]=] .. [=[Dude! You serious? Wow, that's so great. Thanks, man! I'll follow you. But let's be careful. There's some dangerous people runnin' around here, you know.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_b]=],
	text = [=[Delivery Boy: ]=] .. [=[No way, man! It's way cool here. I'm not goin' anywhere!

]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
