-- dbt-generated-talk dialogue.NINJUTSU
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_ballet and player.quests.challenge_ballet.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "completed") then
		player:takeQuest("kill_shredder", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "finished") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_ballet and player.quests.challenge_ballet.status == "finished") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "taken")) or ((player.quests and player.quests.challenge_ballet and player.quests.challenge_ballet.status == "taken")) or ((player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "completed")) or ((player.quests and player.quests.kill_shredder and player.quests.kill_shredder.status == "finished")) or ((player.quests and player.quests.challenge_ballet and player.quests.challenge_ballet.status == "finished"))) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The Shredder is a skilled opponent. Do not take him lightly.]=] end
		if which == [=[2]=] then return [=[...]=] end
		if which == [=[3]=] then return [=[
Hamato Yoshi: ]=] .. [=[The vile one has been destroyed. You have done well. With his corruption gone, at last our art will flourish.

]=] end
		if which == [=[4]=] then return [=[It is an honor to see you again.]=] end
		if which == [=[5]=] then return [=[It is an honor to see you again.]=] end
		if which == [=[6]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
