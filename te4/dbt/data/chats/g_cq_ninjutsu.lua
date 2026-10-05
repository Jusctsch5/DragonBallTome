-- dbt-generated-talk dialogue.CQ_NINJUTSU
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[
Grandmaster Hatsumi: ]=] .. [=[I am pleased with you. You have trained diligently, and you have been rewarded plentifully in strength and skill. Perhaps it is time to put these to the test. I have a task for you. It is not an easy one, but I believe you are ready. Do you accept?

]=],
	answers = {
		{[=[Yes, master. I am ready.]=], jump=[=[n0_a]=]},
		{[=[Forgive me, master. I am but a seed. Please allow me to train further before I am burdened with such things]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if not (player.quests and player.quests.ballet_pre) then
		player:takeQuest("challenge_ballet", "taken")
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	if not ((not (player.quests and player.quests.ballet_pre))) then
		player:takeQuest("kill_shredder_for_hatsumi", "taken")
		shown_n0_a = [=[2]=]
		return shown_n0_a
	end
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[Grandmaster Hatsumi: ]=] .. [=[In the town to the southwest, there is what appears to be a very ordinary dance and theater school.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Sakura's school?

]=] .. [=[Grandmaster Hatsumi: ]=] .. [=[You already know of it. This is good. Go there, and see with your own eyes the horrors that they bring upon humanity.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...the dance school...?

]=] .. [=[Grandmaster Hatsumi: ]=] .. [=[Do not give in to deception, for there is much that is hidden from those who perceive shallowly. Go to this 'dance' school. Find the secrets that they hide. Put an end to them.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Very well. I will do as you ask.

]=] end
		if which == [=[2]=] then return [=[Grandmaster Hatsumi: ]=] .. [=[As well you know, we ninja train not merely the body, but also the mind, heart and spirit.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes.

]=] .. [=[Grandmaster Hatsumi: ]=] .. [=[But with a strong heart and a strong spirit comes great power. And alas, there are always some who fall short of the path of wisdom, and use this power for mere material gains. Such a one exists right now.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Who is this one?

]=] .. [=[Grandmaster Hatsumi: ]=] .. [=[He is a talented practitioner, some would call him a master. His name is Oroku Saki. He is the leader of The Foot ninja clan, and they operate out of what appears from the outside to be an adbandoned warehouse on a small island to the southwest.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What must I do?

]=] .. [=[Grandmaster Hatsumi: ]=] .. [=[We are all connected, ]=] .. (player.name or "you") .. [=[. You, and I...all of us. Like fingers next to one another, perceiving ourselves to be separate because we do not know that we part are a single hand. This connection we sahre gives us great responsibility. This man, Saki, is like a diseased leaf on tree. He is poisoning all of us, and he must be pruned.

]=] .. [=[Grandmaster Hatsumi: ]=] .. [=[You must find Oroku Saki, and kill him.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I understand. It will be done.

]=] end
		if which == [=[]=] then return [=[Grandmaster Hatsumi: ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = [=[Grandmaster Hatsumi: ]=] .. [=[Very well. One cannot compell a flower to bloom before its time.

]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
