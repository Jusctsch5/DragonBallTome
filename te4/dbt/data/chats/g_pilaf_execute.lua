-- dbt-generated-talk dialogue.PILAF_EXECUTE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if ((player.pilaf_execute or 0) == 1) and ((player.quests and player.quests.pilaf_execute and player.quests.pilaf_execute.status == "taken")) then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Emperor Pilaf: ]=] .. [=[Such loyalty!

]=] .. [=[Mai: ]=] .. [=[Wow. ]=] .. [=[ really did it. Not very bright.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
