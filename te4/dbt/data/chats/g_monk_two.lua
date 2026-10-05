-- dbt-generated-talk dialogue.MONK_TWO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.monk_two_state or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Monk: ]=] .. [=[...oooommmmmmm....oooommmmmmm...oooommmmmmm.....]=] end
		if which == [=[]=] then return [=[Monk: ]=] .. [=[...oooommmmmmm....oooommmmmmm...oooommmmmmm.....]=] end
		return "..."
	end,
	answers = {
		{[=[(Bonk him on the head to get his attention)]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Hello.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[(Just leave)]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[There is no answer other than 'om.']=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = [=[Still no answer. Wow. Good concentration.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
