-- dbt-generated-talk dialogue.NAMEK_NAIL
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.namek_general_state or 0) == 0 then
		player.namek_general_state = 1
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Implement me!]=] end
		if which == [=[]=] then return [=[Implement me!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
