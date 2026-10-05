-- dbt-generated-talk dialogue.KICKBOXING
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.fled_kickboxing or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "completed") then
		player:takeQuest("challenge_karate", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "failed") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "finished") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (player.quests and player.quests.challenge_karate) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if not (((player.fled_kickboxing or 0) == 1) or ((player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "taken")) or ((player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "completed")) or ((player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "failed")) or ((player.quests and player.quests.challenge_karate and player.quests.challenge_karate.status == "finished")) or (not (player.quests and player.quests.challenge_karate))) then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Oh, look. It's the clumsy buffoon who thought he could fight me!]=] end
		if which == [=[2]=] then return [=[The Karate school is right next door in suite 100. Don't make too]=] .. [=[much of a mess of the pavement with them.]=] end
		if which == [=[3]=] then return [=[
Bobi: ]=] .. [=[You beat Nakamura, huh? Yeah, I didn't think he'd be too much trouble for you. Looks like his studio will be closing, too! That's terrific! I'm sure the quality of martial arts around here will improve considerably.

]=] end
		if which == [=[4]=] then return [=[I don't understand how you could of lost to TKD. Guess I should]=] .. [=[have made you do more bag work.]=] end
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
