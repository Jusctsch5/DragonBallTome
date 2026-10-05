-- dbt-generated-talk dialogue.ROSSHI_SHELL_TWO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player.rosshi_turtle_shells = 2
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[Master Rosshi: ]=] .. [=[I see you've grown much stronger in the time you've been training with me. I think it's time for you to wear a heavier shell. Here, wear this 100 pound shell. It will help you train more quickly.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
