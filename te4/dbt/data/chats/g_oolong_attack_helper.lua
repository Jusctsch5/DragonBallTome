-- dbt-generated-talk dialogue.OOLONG_ATTACK_HELPER
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if true then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Oolong, the terrified: ]=] .. [=[Arrrgghhhh! Help! Help!

]=] end
		if which == [=[]=] then return [=[Oolong, the terrified: ]=] .. [=[Snuggles! Help!

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
