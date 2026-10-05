-- dbt-generated-talk dialogue.CHI_CRANE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if not (player.quests and player.quests.chi_crane) then
		player:takeQuest("chi_crane", "taken")
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Tsuru-Seni'nin: ]=] .. [=[Excellent, ]=] .. (player.name or "you") .. [=[! I am very pleased with your progress. But there is still much for you to learn. I believe you are ready to learn advanced techniques, but I require proof of your worthiness.

]=] .. [=[On an island northwest of here lives an old rival of mine. Rosshi. He practices the slow and dimwitted art of Turtle fighting. Defeat Rosshi and I will teach you greater things.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
