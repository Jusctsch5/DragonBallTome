-- dbt-generated-talk dialogue.IMELDA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if not (player.quests and player.quests.boss_rabbit) then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.boss_rabbit and player.quests.boss_rabbit.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.boss_rabbit and player.quests.boss_rabbit.status == "completed") then
		player:takeQuest("boss_rabbit", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.boss_rabbit and player.quests.boss_rabbit.status == "finished") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[
Imelda: ]=] .. [=[I'm sorry...I just can't do it. I can't go out with that Marcos guy. Please find the evil rabbit and...oh, wait. He already ate the carrots, it's not like you can rescue them. Hmm. Well, could you kill him anyway, just to make me feel better? Plus, that way if any new men come to the village, they won't get eaten too.
]=] end
		if which == [=[3]=] then return [=[
Imelda: ]=] .. [=[You have killed the evil rabbit! Oh! Happy day! Thank you! Now maybe some decent men will come to this village! ]=] .. [=[
(Received shoes)
]=] end
		if which == [=[4]=] then return [=[Thanks again for killing that horrible, evil Boss Rabbit!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
