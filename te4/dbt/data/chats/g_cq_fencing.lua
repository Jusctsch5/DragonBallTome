-- dbt-generated-talk dialogue.CQ_FENCING
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[
Jacques: ]=] .. [=[Ahhh...]=] .. [=[! You have improved so much! I am most pleased with your progress! Sadly, ours is but a poor, small school and I do not think you will be able to progress much further here. At least, as things are now. You see, the kung fu school next door robs me of my business! It is the television, I think. People see Bruce Lee, and want to fight like he does. Ahhh...the young ones do not appreciate our fine traditions! If only that school were to go away, I am certain that our school would improve very much. Perhaps...you might be willing to challenge their instructor to a duel? If you were to defeat him, I am sure he would close his school from shame!

]=],
	answers = {
		{[=[Me, oui! (yes)]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("challenge_kungfu", "taken") end},
		{[=[No. (no)]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player:takeQuest("challenge_kungfu", "taken")
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
