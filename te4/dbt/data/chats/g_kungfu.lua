-- dbt-generated-talk dialogue.KUNGFU
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.fled_kungfu or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "completed") then
		player:takeQuest("challenge_fencing", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "failed") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "finished") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (player.quests and player.quests.challenge_fencing) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if not (((player.fled_kungfu or 0) == 1) or ((player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "taken")) or ((player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "completed")) or ((player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "failed")) or ((player.quests and player.quests.challenge_fencing and player.quests.challenge_fencing.status == "finished")) or (not (player.quests and player.quests.challenge_fencing))) then
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
		if which == [=[2]=] then return [=[The fencing school is in the suite next door.]=] .. [=[Go wipe them out!]=] end
		if which == [=[3]=] then return [=[
Fong-Sai Yuk: ]=] .. [=[Excellent! With that fool Jacques out of the way, and our studio being the only one in this area, I'm sure we'll do much better, and the quality of instruction will improve, too!

]=] end
		if which == [=[4]=] then return [=[I'm not talking to you.]=] .. [=[You really embarrassed me when you lost to that fencer.]=] end
		if which == [=[5]=] then return [=[Thanks again for getting rid of that fencing school!]=] end
		if which == [=[6]=] then return [=[...]=] end
		if which == [=[7]=] then return [=[Error: quest status in actions.lua is a type I'm not using]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
