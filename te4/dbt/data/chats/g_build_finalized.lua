-- dbt-generated-talk dialogue.BUILD_FINALIZED
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player:takeQuest("dojo_destroyer", "finished")
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[Congratulations!
]=] .. [=[Through much patience and diligent training you have finalized your personal style of martial arts, and destroyed the schools of all unworthy pratitioners. You have settled on your basics. There may still be some room for growth at this level, but to advance much further than your current level you will need to seek out highly specialized masters, capable of taking your power to the next level.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
