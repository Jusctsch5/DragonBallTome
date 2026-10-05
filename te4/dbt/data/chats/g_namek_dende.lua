-- dbt-generated-talk dialogue.NAMEK_DENDE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.namek_general_state or 0) == 0 then
		player.namek_general_state = 1
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.dende_state or 0) == 0 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.dende_state or 0) == 0)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Dende: ]=] .. [=[An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?

]=] end
		if which == [=[2]=] then return [=[Dende: ]=] .. [=[An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?

]=] end
		if which == [=[3]=] then return [=[Dende: ]=] .. [=[An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?

]=] end
		if which == [=[]=] then return [=[Dende: ]=] .. [=[An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?

]=] end
		return "..."
	end,
	answers = {
		{[=[A friend, I think. Who are you? Where am I?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

return "n0"
