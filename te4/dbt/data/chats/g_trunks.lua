-- dbt-generated-talk dialogue.TRUNKS
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[Trunks: ]=] .. [=[I hate waiting! We should be doing somthing, not just sitting here!!!

]=],
	answers = {
		{[=[Yes, please excuse me. I must train more before the androids arrive.]=], jump=[=[n0_a]=]},
		{[=[Would you help me train?]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if (player.trunks_state or 0) == 0 then
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	if (player.trunks_state or 0) == 0 then
		shown_n0_b = [=[1]=]
		return shown_n0_b
	end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
