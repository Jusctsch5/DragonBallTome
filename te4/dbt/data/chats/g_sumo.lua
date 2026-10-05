-- dbt-generated-talk dialogue.SUMO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.fled_sumo or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "completed") then
		player:takeQuest("challenge_judo", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "failed") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "finished") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (player.quests and player.quests.challenge_judo) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if not (((player.fled_sumo or 0) == 1) or ((player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "taken")) or ((player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "completed")) or ((player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "failed")) or ((player.quests and player.quests.challenge_judo and player.quests.challenge_judo.status == "finished")) or (not (player.quests and player.quests.challenge_judo))) then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[You again? No reason to run like that. It was just a friendly match.]=] end
		if which == [=[2]=] then return [=[The Judo school is right next door. You can't miss it.]=] .. [=[Please don't hurt Yawara.]=] end
		if which == [=[3]=] then return [=[
Honda: ]=] .. [=[You convinced her to duel? Excellent! It's a pity she's decided to close her school to train in the mountains, but the path of martial prowess is not always an easy one. I'll miss her. Still, with her school gone, I bet all her students will come over here. I'll be able to afford better training tools, and I'm sure the quality of training here will improve considerably.

]=] end
		if which == [=[4]=] then return [=[
Honda: ]=] .. [=[I'm happy that you were able to convince her to duel, but honestly it never occurred to me that you might not win it.

]=] end
		if which == [=[5]=] then return [=[Hey! Great to see you again!]=] end
		if which == [=[6]=] then return [=[...]=] end
		if which == [=[7]=] then return [=[Error: quest status in actions.lua is a type I'm not using]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
