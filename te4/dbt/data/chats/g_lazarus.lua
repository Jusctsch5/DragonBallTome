-- dbt-generated-talk dialogue.LAZARUS
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.stolen_goods and player.quests.stolen_goods.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if ((player.quests and player.quests.destroy_the_foot and player.quests.destroy_the_foot.status == "finished")) or ((player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "finished")) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.stolen_goods and player.quests.stolen_goods.status == "taken")) or (((player.quests and player.quests.destroy_the_foot and player.quests.destroy_the_foot.status == "finished")) or ((player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "finished")))) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[It sure has been tough finding good merchandise lately.]=] end
		if which == [=[3]=] then return [=[Yes, there's a pool hall around here someplace.]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
