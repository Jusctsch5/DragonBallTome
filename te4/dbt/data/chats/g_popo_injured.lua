-- dbt-generated-talk dialogue.POPO_INJURED
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player.popo_state = 3
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[Mr. Popo: ]=] .. [=[Mr. Popo feel that. Maybe Mr. Popo underestimate you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
