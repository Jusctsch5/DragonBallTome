-- dbt-generated-talk dialogue.FENCING
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.fled_kungfu or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "completed") then
		player:takeQuest("challenge_kungfu", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "failed") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "finished") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (player.quests and player.quests.challenge_kungfu) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if not (((player.fled_kungfu or 0) == 1) or ((player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "taken")) or ((player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "completed")) or ((player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "failed")) or ((player.quests and player.quests.challenge_kungfu and player.quests.challenge_kungfu.status == "finished")) or (not (player.quests and player.quests.challenge_kungfu))) then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Only a coward would flee from battle as you did.]=] end
		if which == [=[2]=] then return [=[The kung fu school is right next door.]=] end
		if which == [=[3]=] then return [=[
Jacques: ]=] .. [=[Ahhh, ]=] .. [=[! You have defeated Fong-Sai Yuk, and he has indeed closed his school! It is most excellent! Many of his former students have signed up here already, and I'm certain that as our school continues to grow, the quality of our instruction shall improve as well!

]=] end
		if which == [=[4]=] then return [=[Ahhh, you did not do so well. How sad.]=] end
		if which == [=[5]=] then return [=[Thanks again for getting rid of that kung fu school!]=] end
		if which == [=[6]=] then return [=[...]=] end
		if which == [=[7]=] then return [=[Error: quest status in actions.lua is a type I'm not using]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
