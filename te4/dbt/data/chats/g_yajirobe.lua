-- dbt-generated-talk dialogue.YAJIROBE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if game.zone and game.zone.name == [=[World Tournament]=] then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[He is too focused on cutting you to ribbons to say much.]=] end
		if which == [=[]=] then return [=[Implement me!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
