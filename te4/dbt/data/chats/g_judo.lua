-- dbt-generated-talk dialogue.JUDO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.fled_judo or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.fled_sumo or 0) == 2 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_sumo and player.quests.challenge_sumo.status == "taken") then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.challenge_sumo and player.quests.challenge_sumo.status == "completed") then
		player:takeQuest("challenge_sumo", "finished")
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Yawara smiles and says 'Hello!']=] end
		if which == [=[2]=] then return [=[It's really a shame you lost to Honda.]=] end
		if which == [=[3]=] then return [=[Honda's sumo school is right next door. It's really not a big]=] .. [=[deal, though. Why don't we all just let it go?]=] end
		if which == [=[4]=] then return [=[
Yawara: ]=] .. [=[So you really defeated Honda, huh? That's impressive. You know, I really didn't have anything against him personally. Apparantly he's feeling awfully humiliated about having been defeated by one of my students, though, and he's decided to close his school so he can dedicate himself full time to his training. It's not how I planned things, but I have to admit it will be good for us. Honda's school gave us a lot of competition, and now that they're gone, I'm sure our school will do much better.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
