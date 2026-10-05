-- dbt-generated-talk dialogue.NAMEK_ELDER
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.namek_general_state or 0) == 999 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.namek_general_state or 0) == 0 then
		player.namek_general_state = 1
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.namek_know_db or 0) == 1 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.namek_know_db or 0) == 2 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.namek_know_aj or 0) > 0 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.namek_know_gr or 0) > 0 then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.namek_know_fr or 0) > 0 then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	if ((player.alignment or 0) < 1) and ((player.namek_know_db or 0) == 2) then
		shown_n0 = [=[8]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[2]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[3]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[4]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[5]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[6]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[7]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[8]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		if which == [=[]=] then return [=[: ]=] .. [=[What else would you ask of me?

]=] end
		return "..."
	end,
	answers = {
		{[=[I would like to ask for you to give me the dragonball you have in your posession.]=], jump=[=[n0_b]=], action=function(npc, player) player.namek_lev_check = 1 end, cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[...]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[What can you tell me about the ajisa plant?]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[So you're the Great Elder of Namek?]=], cond=function(npc, player) return arm_n0(player) == [=[6]=] end},
		{[=[Did you know there's a super powerful maniac running loose on Namek? His name is Freeza, and here's here to kill you all and steal the dragonballs.]=], cond=function(npc, player) return arm_n0(player) == [=[7]=] end},
		{[=[Gimme your dragonball or I'll splatter you like a grease spot.]=], cond=function(npc, player) return arm_n0(player) == [=[8]=] end},
		{[=[Thank you for your time.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[What can you tell me of your people?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[What can you tell me about this planet?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[One of the other villages needs water. Do you have any advice?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[The second Elder asked me to give you this ajisa plant for cross pollination]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[A nearby village has run out of ajisa seeds. Do you have any to spare?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I've been asked to plant an ajisa tree, but I don't know anything about them. Any advice?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[The Elder of the island village is dying, and seeks a successor. Do you konw of anyone suitable?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I've been tasked to slay a leviathan. Do you know where I might find one?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	player.namek_lev_check = 1
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		arm_n0_b(player)
		return [=[: ]=] .. [=[You wish to have the dragonball I guard? Very well. I am willing to part with it, but you must first render a service to my village. Two weeks ago, our well ran completely dry. Our village is in no danger from it, we're able to fly to water for ourselves, and carry in back in small quantities, but it is difficult to carry enough water for our fields. If you can find a way to restore water to our wells, I will give you the dragonball in my posession.

]=] .. [=[Hmm. Perhaps I would be willing. But, would you be willing to perform a service for me in return? It is only a very small thing that I ask. Our most recent growth season was unusually strong, and we have prepared a number of potted ajisa plants to be carried to the other villages across Namek for cross-fertilization. Deliver all six plants and return here, and I will give the dragonball that I guard.

]=] .. [=[Oh...you believe you are deserving of a wish? Very well. It happens that my village has recently suffered a number of distressing botanical disasters, and we have been left completely bereft of ajisa seeds for our next planting season. We have time left to resolve it, but it would be a great service if you could collect a number of seeds for us. Twenty should be enogh for the next planting. Do this, and I will give you the dragonball that I keep in my custody.

]=] .. [=[You are attempting to gather the dragonballs? Interesting. Very well. It is custom that anyone making such a request must prove themselves by performing a task to demonstrate a particular virtue. In practice, this usually means solving some problem that the Elder has not been able to resolve. However, everything has been spendid in our village for years, and I have no tasks to give you worthy of awarding you with a dragonball should you succeed. However...do you know about the ajisa plant?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[: ]=] .. [=[Indeed.

]=] .. [=[: ]=] .. [=[The ajisa is our most sacred and beautiful plant. In the years since our near destruction, we have cared for them and struggled to spread them across our lands once again.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I can tell you value them a great deal.

]=] .. [=[: ]=] .. [=[Yes. Almost as much as we value the dragonballs. And if I am to give to you our greatest prize, it is important that you understand us, understand our ways...and understand the ajisa.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What do you want me to do?

]=] .. [=[: ]=] .. [=[Take this ajisa seed. Plant it. Care for it. Help it to grow. Bring it to fullness, and when you have done this, return to me and I will give you the dargonball entrusted to me.

]=] .. [=[You seek the dragonballs? Forgive me...but your timing is most convenient. Our village is in need of a hero to perform a task. I have become...old. Too old to properly care for my village, and I fear that it is time for me to step down. Sadly, we have no warriors at our village, and none of us are able to fly any longer. Yes, I know...it is a sad state of affairs. Go to the neighboring villages and find a suitable master to replace me. If you do this, I will gladly give you the dragonball that I watch over.

]=] .. [=[I would give the dragonball freely to any who can prove themselves a deserving warrior. Are you a warrior? Are you willing to prove it? If so, find and do battle with a Leviathan. Defeat it and return me. If you are able to do this I will give you my dragonball.

]=] .. [=[Implement path!n
]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	if (player.quests and player.quests.namek_water and player.quests.namek_water.status == "completed") then
		player:takeQuest("namek_water", "completed")
		shown_n0_c = [=[1]=]
		return shown_n0_c
	end
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		local which = arm_n0_c(player)
		if which == [=[1]=] then return [=[So you have! In truth, I thought I had given you an impossible task. Surely it should have taken years to transport that much water from so far. But you have done what we could not. For this I award you with the dragonball in my possession. Please use it wisely.

]=] end
		if which == [=[]=] then return [=[: ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
