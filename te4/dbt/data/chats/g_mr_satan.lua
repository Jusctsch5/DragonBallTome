-- dbt-generated-talk dialogue.MR_SATAN
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if game.zone and game.zone.name == [=[World Tournament]=] then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if ((player.satan_state or 0) == 0) or ((player.satan_state or 0) == 1) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Sorry, ]=] .. (player.name or "you") .. [=[. I won't go easy on you just because you're family.]=] end
		if which == [=[2]=] then return [=[Mr. Satan: ]=] end
		if which == [=[]=] then return [=[Hello, ]=] .. (player.name or "you") end
		return "..."
	end,
	answers = {
		{[=[Oh. I'm sorry. I'll go, then.]=], jump=[=[n0_g1_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b = nil
local function arm_n0_g1_b(player)
	if shown_n0_g1_b ~= nil then return shown_n0_g1_b end
	player.satan_state = 1
	player:takeQuest("briefs_satan_delivery", "failed")
	shown_n0_g1_b = [=[]=]
	return shown_n0_g1_b
end
newChat{ id=[=[n0_g1_b]=],
	text = function(npc, player)
		local which = arm_n0_g1_b(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
