-- dbt-generated-talk dialogue.MARCOS
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if ((player.oolong_quest_helper or 0) == 1) and ((player.oolong_resolution or 0) == 0) then
		player.oolong_quest_helper = 2
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "finished") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if false then
		player:takeQuest("oolong", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "completed") then
		player.oolong_quest_helper = 3
		player:takeQuest("oolong", "finished")
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.oolong_quest_helper or 0) == 2 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (player.quests and player.quests.oolong) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "taken") then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[
Marcos: ]=] .. [=[Excuse me? You're saying the village girls went to Castle Oolong by choice? No way! I don't buy it! He must be using some sort of evil, dark magic to warp their minds! Get back there and bring back those village girls! 
]=] end
		if which == [=[2]=] then return [=[Thank you for returning the women to the village!]=] end
		if which == [=[3]=] then return [=[
Marcos: ]=] .. [=[The village girls have returned! They're all very grumpy, though. I suppose it must have been hard to have endured captivity at the hands of that beast. Here, let me give you a reward. This knife has been in my family for generations, but I'd like you to have it. Thanks again.
]=] end
		if which == [=[4]=] then return [=[Still, they're back now and I'm grateful. Here, let me give you a reward. This knife has been in my family for generations, but I'd like you to have it. Thanks again.
]=] end
		if which == [=[5]=] then return [=[What are you waiting for? Those girls are still waiting to be rescued!]=] end
		if which == [=[6]=] then return [=[...]=] end
		if which == [=[7]=] then return [=[Please hurry! Some of the women may still be alive!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
