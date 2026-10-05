-- dbt-generated-talk dialogue.AKIRA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.oolong_akira or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.stolen_goods and player.quests.stolen_goods.status == "taken") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if player:isPartied("RACE_DELIVERY_BOY") then
		player:takeQuest("akira_missing_boy", "finished")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.akira_state or 0) == 2 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.akira_sushi and player.quests.akira_sushi.status == "taken") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.quests and player.quests.akira_sushi and player.quests.akira_sushi.status == "completed") then
		player:takeQuest("akira_sushi", "finished")
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.oolong_akira or 0) == 2 then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	if (player.akira_state or 0) == 1 then
		shown_n0 = [=[8]=]
		return shown_n0
	end
	if not (player.quests and player.quests.akira_sushi) then
		shown_n0 = [=[9]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[
Akira: ]=] .. [=[Irasshaimase!

]=] end
		if which == [=[2]=] then return [=[
Akira: ]=] .. [=[Irasshaimase!

]=] end
		if which == [=[3]=] then return [=[
Akira: ]=] .. [=[You found him! How wonderful! I am eternally in your debt. And, I have the perfect reward for you. My father was a famous swordman back in Japan. But, I did not follow in his footsteps. When he died, I inherited all of his weapons and armor. But, I am not a warrior, and I have always believed it more proper for such tools to be in the hands of someone who will use them, than sitting collecting dust on a shelf.]=] .. [=[I would like you to have his sword.]=] .. [=[ You have proven yourself a more deserving keeper for it than I.

]=] end
		if which == [=[4]=] then return [=[Akira looks at you coldly.]=] end
		if which == [=[5]=] then return [=[Please hurry! Mr. Satan's estate is at the end of the road which goes north past the Airport.]=] end
		if which == [=[6]=] then return [=[
Akira: ]=] .. [=[Ahh! You have delivered the sushi. Thank you. Here, please accept this small payment for your services.

]=] end
		if which == [=[7]=] then return [=[#BAkira: #wIrasshaimase!]=] end
		if which == [=[8]=] then return [=[#BAkira: #wIrasshaimase!]=] end
		if which == [=[9]=] then return [=[
Akira: ]=] .. [=[Irasshaimase! Ii, o tenki desu, ne? Nani o tabemasu ka?

]=] end
		if which == [=[]=] then return [=[
Akira: ]=] .. [=[Irasshaimase!

]=] end
		return "..."
	end,
	answers = {
		{[=[Oolong says 'hello.']=], jump=[=[n0_b]=], action=function(npc, player) player.akira_state = 1 end, cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Hello, Akira! Hey...have you heard anything about any hijackings? George over at the electronics store has been having trouble lately.]=], jump=[=[n0_c]=], action=function(npc, player) player.goods_akira = 1 player.akira_state = 1 end, cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Fugu, onegai shimasu.]=], jump=[=[n0_g8_a]=], action=function(npc, player) player.akira_state = 1 end, cond=function(npc, player) return arm_n0(player) == [=[9]=] end},
		{[=[Anata no sushi wa oishikatta desu.]=], jump=[=[n0_g8_b]=], action=function(npc, player) player.akira_state = 2 player:takeQuest("akira_insulted", "taken") end, cond=function(npc, player) return arm_n0(player) == [=[9]=] end},
		{[=[I'm sorry...I don't speak Japanese.]=], jump=[=[n0_c]=], action=function(npc, player) player.goods_akira = 1 player.akira_state = 1 end, cond=function(npc, player) return arm_n0(player) == [=[9]=] end},
		{[=[Thank you.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
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
	player.akira_state = 1
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	player.goods_akira = 1
	player.akira_state = 1
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		arm_n0_c(player)
		return [=[
(Akira looks at you strangely for a moment, glances quickly in both directions, and speaks)

]=] .. [=[Akira: ]=] .. [=[Yes, I've heard about the hijackings. In fact, I am extremely concerned about them. In Japan, perhaps five or six years ago, there was an extremely similar set of hijackins that had the police completely at a loss for many years. Entire shipments would simply vanish without a trace. Truck drivers would stop for lunch, and discover their truck empty. Department stores were emptied overnight, with nothing recorded on the internal video cameras. It was a nightmare. Eventually it turned out that the group responsible was a revived ninja clan. It was...most peculiar, especially in this modern day and age. I don't know for a fact that there is any connection...all I know is that the pattern here is similar to what we saw back home. Again, I am most concerned about it. That is all I can say.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g8_a = nil
local function arm_n0_g8_a(player)
	if shown_n0_g8_a ~= nil then return shown_n0_g8_a end
	player.akira_state = 1
	shown_n0_g8_a = [=[]=]
	return shown_n0_g8_a
end
newChat{ id=[=[n0_g8_a]=],
	text = function(npc, player)
		arm_n0_g8_a(player)
		return [=[Akira: ]=] .. [=[Fugu? Honto? Kashikomarimashita!

]=] .. [=[Akira pulls a fresh fish off the ice and carefully cuts it into very thin slices. He's obviously very excited, but takes his time, and prepares the fish with the elegance of a master. The process takes about twenty minutes, but when he is done, he presents you with the result. It is quite a lovely presentation. It looks tasty, too.

]=] .. [=[(Received fugu)

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g8_b = nil
local function arm_n0_g8_b(player)
	if shown_n0_g8_b ~= nil then return shown_n0_g8_b end
	player.akira_state = 2
	player:takeQuest("akira_insulted", "taken")
	shown_n0_g8_b = [=[]=]
	return shown_n0_g8_b
end
newChat{ id=[=[n0_g8_b]=],
	text = function(npc, player)
		arm_n0_g8_b(player)
		return [=[Akira: ]=] .. [=[Watashi no?!?!?!? Aarrrrrggghhhh!!!!

]=] .. [=[Of all the things you could have said, this was obviously the wrong choice. You might have called him an idiot, and he would have forgiven you. You might have have asked him to lick your boots, and he might have thought someone was playing tricks with your translation dictionary. Any of a thousand things you *might* have said that wouldn't have really bothered him. But, no...you had to go and tell him his sushi wasn't very tasty. He is unforgivably insulted, pulls out a cleaver and attacks you.

]=] .. [=[press escape]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
