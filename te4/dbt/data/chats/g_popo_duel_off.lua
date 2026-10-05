-- dbt-generated-talk dialogue.POPO_DUEL_OFF
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.popo_state or 0) == 2 then
		player.popo_state = 1
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.popo_injured or 0) == 1 then
		player.popo_injured = 2
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
