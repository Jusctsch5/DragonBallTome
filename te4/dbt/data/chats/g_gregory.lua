-- dbt-generated-talk dialogue.GREGORY
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.kaio_gregory and player.quests.kaio_gregory.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.kaio_gregory and player.quests.kaio_gregory.status == "taken"))) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[You have to hit with with the hammer, bozo.]=] end
		if which == [=[2]=] then return [=[Wow! You didn't have to hit my so hard!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
