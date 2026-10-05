-- dbt-generated-talk dialogue.OOLONG_MARRY_PLAYER
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player:takeQuest("oolong", "completed")
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[Oolong, the triumphant: ]=] .. [=[Oh! Dear me, yes!

]=] .. [=[Oolong cries happy tears and immediately comes and sweeps you off your feet. Or, tries to anyway. Instead he knocks you over and the two of you fall into a ridicuous pile on the ground and come up laughing. It's a precious moment, both sweet and playful, and it sets the two of you off on a delightful, but brief courtship, which leads to the most beautiful wedding any girl marrying a pig could ever ask for. You feel immensely happy.

]=]
	end,
	answers = {
		{[=[Retire to a beautiful, happy life of love, joy, and raising adorable little baby piglets]=]},
		{[=[Hold off on children for now.]=]},
		{"[Leave]"},
	},
}

return "n0"
