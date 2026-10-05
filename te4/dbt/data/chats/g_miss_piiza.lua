-- dbt-generated-talk dialogue.MISS_PIIZA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.piiza_state or 0) == 0 then
		player.piiza_state = 1
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.sushi_quest_awkward or 0) ~= 0 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.piiza_state or 0) == 0) or ((player.sushi_quest_awkward or 0) ~= 0)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.sushi_quest_awkward or 0) == 0 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if not (((player.sushi_quest_awkward or 0) == 0)) then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Miss Piiza: ]=] .. [=[Why, hello! I'm Miss Piiza! Welcome to the private estate and training dojo of the most powerful fighter in the whole world: the magnificient Mr. Satan! If you're here to gape in awe, please feel free to peruse the trophy room.

]=] end
		if which == [=[2]=] then return [=[Miss Piiza: ]=] .. [=[Oh. Hello again. Did you, umm...remember to bring the sushi this time?

]=] end
		if which == [=[3]=] then return [=[Miss Piiza: ]=] .. [=[Hello, again! Mr. Satan adores his admirers. Please feel free to drool in awe of Mr. Satan's masculine prowess. But please don't drool on the floor. Here's a paper cup to catch it in.

]=] end
		if which == [=[4]=] then return [=[...]=] end
		if which == [=[5]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{[=[Thank you, Miss Piiza. I'll just look around on my own, thanks.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[I'd like to sign up for classes.]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[Yes. Here it is, with my apologies for the delay.]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[Sushi? What sushi?]=], jump=[=[n0_d]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		return [=[Miss Piiza: ]=] .. [=[Yes, I'm sure you would. But please understand that Mr. Satan is a very busy, terribly important man, and he can't be bothered to train just anybody.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What do I have to do to be accepted as a student?

]=] .. [=[Miss Piiza: ]=] .. [=[Well, honestly, there's probably nothing you can do. he's very picky. But, you're welcome to try to run the gauntlet, if you'd like.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[The gauntlet?

]=] .. [=[Miss Piiza: ]=] .. [=[Yes. This mansion is a massive, five story training hall. Since Mr. Satan is too busy to actively teach classes, his students train themselves by constantly fighting on the various levels. The higher you go, the more dangerous your opponents will become. If you can reach the top level, Mr. Satan might grace you with a few words, but don't count on it. Just be grateful you get to practice being a punching bag for his students.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Umm, right. Thank you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	if true then
		player:takeQuest("akira_sushi", "completed")
		player.sushi_quest_awkward = 0
		shown_n0_c = [=[1]=]
		return shown_n0_c
	end
	player.sushi_quest_awkward = 1
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		local which = arm_n0_c(player)
		if which == [=[1]=] then return [=[Miss Piiza: ]=] end
		if which == [=[]=] then return [=[Miss Piiza: ]=] .. [=[Oh! Thank you, Mr. Satan does so enjoy his sushi. Umm...where is it?

]=] .. [=[(You realize that you don't have the sushi with you.)

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...I. Umm, guess I must have misplaced it.

]=] .. [=[(There is an awkward moment, and Miss Piiza looks at you strangely.)

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_d]=],
	text = [=[Miss Piiza scratches the back of her head and laughs politely.

]=] .. [=[Miss Piiza: ]=] .. [=[Oh! How very silly of me! I thought you were to delivery boy. Please accept my apologies. Now, if you'll excuse me, I have some things to attend to.

]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
