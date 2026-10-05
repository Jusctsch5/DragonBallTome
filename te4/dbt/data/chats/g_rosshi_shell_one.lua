-- dbt-generated-talk dialogue.ROSSHI_SHELL_ONE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player.rosshi_turtle_shells = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[Master Rosshi: ]=] .. [=[Before we begin, let me give you this turtle shell to wear on your back. It weighs fifty pounds, and will help you to train more quickly.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
