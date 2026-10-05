-- dbt-generated-talk dialogue.KARATE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.fled_karate or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "completed") then
		player:takeQuest("challenge_kickboxing", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "failed") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "finished") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (player.quests and player.quests.challenge_kickboxing) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if not (((player.fled_karate or 0) == 1) or ((player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "taken")) or ((player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "completed")) or ((player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "failed")) or ((player.quests and player.quests.challenge_kickboxing and player.quests.challenge_kickboxing.status == "finished")) or (not (player.quests and player.quests.challenge_kickboxing))) then
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
Nakamura Sensei: ]=] .. [=[Only a coward would flee from battle as you did.

]=] end
		if which == [=[2]=] then return [=[
Nakamura Sensei: ]=] .. [=[The Kickboxing school is right next door in suite 101. Go wipe them out!

]=] end
		if which == [=[3]=] then return [=[
Nakamura Sensei: ]=] .. [=[Congratulations on your victory! I hear Bob didn't give you much of a fight. I'm not surprised. But now that they're gone, and we're the only school around here that focuses on barehanded fighting, our student base will surely double! It will be very good for the school, and I'm the quality of instruction will improve, too!

]=] end
		if which == [=[4]=] then return [=[I'm not talking to you.]=] .. [=[You really embarrassed me when you lost to that Bob guy.]=] end
		if which == [=[5]=] then return [=[Thanks again for getting rid of that kickboxing school!]=] end
		if which == [=[6]=] then return [=[...]=] end
		if which == [=[7]=] then return [=[Error: quest status in actions.lua is a type I'm not using]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
