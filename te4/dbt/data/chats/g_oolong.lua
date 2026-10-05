-- dbt-generated-talk dialogue.OOLONG
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.oolong_lonely and player.quests.oolong_lonely.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.oolong_sad_done or 0) == 1 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.oolong_sad_done or 0) == 2 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.oolong_sad_done or 0) == 3 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.oolong_resolution or 0) == 1 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if player.female then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "taken") then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Oolong, the thoughtful: ]=] .. [=[Hello again, ]=] .. (player.name or "you") .. [=[! It's so nice to see you again. Tell me...have you had any success finding, well...you know?

]=] end
		if which == [=[2]=] then return [=[Oolong, the troubled: ]=] .. [=[Please go. <sniff> I want to be alone right now. <pout>]=] end
		if which == [=[3]=] then return [=[Oolong, the troubled: ]=] .. [=[What do you want from me now? Go away!]=] end
		if which == [=[4]=] then return [=[Oolong, the terrible: ]=] .. [=[Go away!]=] end
		if which == [=[5]=] then return [=[Oolong, the terrible: ]=] .. [=[The village girls have returned home, I trust?]=] end
		if which == [=[6]=] then return [=[(Oolong jumps when he notices you...quickly wipes up his tears and tries to be intimidating)

]=] .. [=[Oolong, the terrible: ]=] .. [=[Foolish human! How dare you interupt the...umm...private thoughts of Oolong the TERRIBLE! Why, I should cast you into the pit with my very big, very mean, and very hungry 9-headed hydra just for being here! Didn't anyone ever teach you that it's polite to knock?

]=] end
		if which == [=[7]=] then return [=[(Oolong jumps when he notices you...quickly wipes up his tears and tries to be intimidating)

]=] .. [=[Oolong, the terrible: ]=] .. [=[Foolish human! How dare you interupt the...umm...private thoughts of Oolong the TERRIBLE! Why, I should cast you into the pit with my very big, very mean, and very hungry 9-headed hydra just for being here! Didn't anyone ever teach you that it's polite to knock?

]=] end
		if which == [=[]=] then return [=[(Oolong jumps when he notices you...quickly wipes up his tears and tries to be intimidating)

]=] .. [=[Oolong, the terrible: ]=] .. [=[Foolish human! How dare you interupt the...umm...private thoughts of Oolong the TERRIBLE! Why, I should cast you into the pit with my very big, very mean, and very hungry 9-headed hydra just for being here! Didn't anyone ever teach you that it's polite to knock?

]=] end
		return "..."
	end,
	answers = {
		{[=[No, sorry. Not yet.]=], jump=[=[n0_g0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[You're kind of cute. Are you seeing anybody?]=], cond=function(npc, player) return arm_n0(player) == [=[6]=] end},
		{[=[The villagers of Aru sent me to kill you. They say you've been stealing their women.]=], cond=function(npc, player) return arm_n0(player) == [=[7]=] end},
		{[=[Oh, forgive me...oh...Oolong.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[What hydra? I saw the sign, but there's nothing in there.]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[Die, pig! (attack)]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Oolong, the terrible: ]=] .. [=[Yes, very well. I forgive you. But please knock next time. Now go away before I - wait...you look like an adventurer.

]=],
	answers = {
		{[=[Yes, I am.]=], jump=[=[n0_a_a]=]},
		{[=[Yes, I'm here to kill you. Die, pig! (attack)]=], jump=[=[n0_a_b]=]},
		{[=[No, sorry...I'm actually just lost, and was looking for directions. Could you tell me how to get to...umm...to the World Tournament? Yes, the World Tournament. I came to see the World Tournament, but...umm...couldn't find it.]=], jump=[=[n0_a_c]=]},
		{"[Leave]"},
	},
}

local shown_n0_a_a = nil
local function arm_n0_a_a(player)
	if shown_n0_a_a ~= nil then return shown_n0_a_a end
	if (player.oolong_quest_helper or 0) == 0 then
		player.oolong_quest_helper = 1
		shown_n0_a_a = [=[1]=]
		return shown_n0_a_a
	end
	shown_n0_a_a = [=[]=]
	return shown_n0_a_a
end
newChat{ id=[=[n0_a_a]=],
	text = function(npc, player)
		local which = arm_n0_a_a(player)
		if which == [=[1]=] then return [=[Oolong, the tentative: ]=] .. [=[Say...maybe you could help me out, then? It's those Aru village women. Ever since they found out I was rich, they keep coming to my castle in droves! Day in, day out, they're all constantly trying to badger me into marrying them. I can't have guests over, they're eating me out of my fortune, and I can't help but think that any genuinely nice girl who saw them would completely get the wrong idea and be scared off! What's a pig to do?

]=] .. [=[Oolong, the trying: ]=] end
		if which == [=[]=] then return [=[Oolong, the tentative: ]=] .. [=[Say...maybe you could help me out, then? It's those Aru village women. Ever since they found out I was rich, they keep coming to my castle in droves! Day in, day out, they're all constantly trying to badger me into marrying them. I can't have guests over, they're eating me out of my fortune, and I can't help but think that any genuinely nice girl who saw them would completely get the wrong idea and be scared off! What's a pig to do?

]=] .. [=[Oolong, the trying: ]=] end
		return "..."
	end,
	answers = {
		{[=[Why don't you just tell them to leave?]=], jump=[=[n0_a_a_a]=], cond=function(npc, player) return arm_n0_a_a(player) == "" end},
		{[=[Ok. So what do you want me to do about it?]=], cond=function(npc, player) return arm_n0_a_a(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a_a]=],
	text = [=[You think I haven't tried! I tell them to leave all the time! They just laugh at me! I even tried to sic Snuggles, my hydra, on them, but they just scratch him behind his ears and give him hydra treats and he loves them all to death. Well...not to death, that would have solved the problem. ]=] .. [=[The way I see it, they're all hoping to ensnare me into marrying them, and the only thing that's going to convince them to go away is for me to get married! But I'm not just going to marry anyone. She has to be kind, and sweet, and loving. So that's what I want you to do. I want you to find a girl who's kind, and sweet, and loving...and ask her to marry me.

]=],
	answers = {
		{[=[Ok. I'll see what I can do.]=], jump=[=[n0_a_a_a_a]=], action=function(npc, player) player:takeQuest("oolong_lonely", "taken") end},
		{[=[No, I don't think I want to get involved with this one. You're on your own, little pig.]=], jump=[=[n0_a_a_a_b]=], action=function(npc, player) player.oolong_sad_done = 2 end},
		{[=[No, I think I'm just going to kill you. It will solve your problem, and it'll be a lot faster for me. (attack)]=], jump=[=[n0_a_a_a_c]=]},
		{"[Leave]"},
	},
}

local shown_n0_a_a_a_a = nil
local function arm_n0_a_a_a_a(player)
	if shown_n0_a_a_a_a ~= nil then return shown_n0_a_a_a_a end
	player:takeQuest("oolong_lonely", "taken")
	shown_n0_a_a_a_a = [=[]=]
	return shown_n0_a_a_a_a
end
newChat{ id=[=[n0_a_a_a_a]=],
	text = function(npc, player)
		arm_n0_a_a_a_a(player)
		return [=[Oolong, the thrilled: ]=] .. [=[Wow! Really? Thank you! Thank you so much! 

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_a_a_b = nil
local function arm_n0_a_a_a_b(player)
	if shown_n0_a_a_a_b ~= nil then return shown_n0_a_a_a_b end
	player.oolong_sad_done = 2
	shown_n0_a_a_a_b = [=[]=]
	return shown_n0_a_a_a_b
end
newChat{ id=[=[n0_a_a_a_b]=],
	text = function(npc, player)
		arm_n0_a_a_a_b(player)
		return [=[Oolong, the troubled: ]=] .. [=[I see. Well, then I suppose I'll get to what I was doing before you came in. If you'll excuse me.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a_a_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_c = nil
local function arm_n0_a_c(player)
	if shown_n0_a_c ~= nil then return shown_n0_a_c end
	if (player.akira_state or 0) == 0 then
		player.oolong_akira = 1
		shown_n0_a_c = [=[1]=]
		return shown_n0_a_c
	end
	player.oolong_sad_done = 2
	shown_n0_a_c = [=[]=]
	return shown_n0_a_c
end
newChat{ id=[=[n0_a_c]=],
	text = function(npc, player)
		local which = arm_n0_a_c(player)
		if which == [=[1]=] then return [=[Say hello to Akira for me when you pass through. He's a friendly chap. ]=] end
		if which == [=[]=] then return [=[Oolong, the terrible: ]=] .. [=[Oh. Yes. Quite alright. If you head directly southeast from my castle, you'll pass a most ridiculous village by the name of Aru. I'd avoid it if I were you, but south of Aru you'll find a road. Follow it south, then east, and you'll reach a rather large city. The World Tournament building is directly north of Akira's sushi bar. ]=] .. [=[Now, if you'll excuse me, I'd really like to be left alone.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = [=[(Oolong's bottom lip starts to quiver, and then all at once he bursts into uncontrollable tears.)

]=] .. [=[Oolong, the troubled: ]=] .. [=[...yes. I just don't know what to do! Implement dialogue branch

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "taken") then
		shown_n0_c = [=[1]=]
		return shown_n0_c
	end
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		local which = arm_n0_c(player)
		if which == [=[1]=] then return [=[Oolong, the terrible: ]=] .. [=[Oh. Umm. It...he...must be outside...grazing. Yes. Grazing. He likes to have a well balanced meal. He's very health conscious, you see. Adventurers are high in protein, but they're rather lacking in fiber, so he...grazes. Yes. Grazes.

]=] .. [=[(You notice that Oolong is slowly edging away, and looks like he's about to run.)

]=] end
		if which == [=[]=] then return [=[Oolong, the terrible: ]=] .. [=[Oh. Umm. It...he...must be outside...grazing. Yes. Grazing. He likes to have a well balanced meal. He's very health conscious, you see. Adventurers are high in protein, but they're rather lacking in fiber, so he...grazes. Yes. Grazes.

]=] .. [=[(You notice that Oolong is slowly edging away, and looks like he's about to run.)

]=] end
		return "..."
	end,
	answers = {
		{[=[Look, there's no need for theatrics. I'm here to rescue the Aru village women you've kidnapped. Let them go, and you can live.]=], jump=[=[n0_c_b]=], cond=function(npc, player) return arm_n0_c(player) == [=[1]=] end},
		{[=[No hydra, huh? Ok. Time to die, little pig. (attack)]=], jump=[=[n0_c_a]=], cond=function(npc, player) return arm_n0_c(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_b]=],
	text = [=[Oolong, the terrified: ]=] .. [=[Really? You promise? You'll let me go if I let the women go back to their village?

]=],
	answers = {
		{[=[Yes.]=], jump=[=[n0_c_b_a]=]},
		{[=[No, I'll probably kill you anyway.]=]},
		{"[Leave]"},
	},
}

local shown_n0_c_b_a = nil
local function arm_n0_c_b_a(player)
	if shown_n0_c_b_a ~= nil then return shown_n0_c_b_a end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "taken") then
		player:takeQuest("oolong", "completed")
		shown_n0_c_b_a = [=[1]=]
		return shown_n0_c_b_a
	end
	shown_n0_c_b_a = [=[]=]
	return shown_n0_c_b_a
end
newChat{ id=[=[n0_c_b_a]=],
	text = function(npc, player)
		local which = arm_n0_c_b_a(player)
		if which == [=[1]=] then return [=[Oolong, the tiny: ]=] .. [=[Alright. I'll tell all the village women to return home.

]=] end
		if which == [=[]=] then return [=[Oolong, the tiny: ]=] .. [=[Alright. I'll tell all the village women to return home.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a]=],
	text = [=[Oolong, the sad: ]=] .. [=[I understand. Please keep looking.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = function(npc, player)
		return [=[Oolong, the sad: ]=] .. [=[...really? I thought you said you were involved with someone.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I'm sorry. I lied. It's, well...I'm a human. And you're a pig. I wasn't comfortable with that at first. But, I've thought about it, and I really think I could live with it. I just needed time. Do you understand?

]=] .. [=[Oolong, the sad: ]=] .. [=[...I think so.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[And you've given me that time. And I'm grateful. And now I'd really like to marry you. If you'll have me. Oolong...will you marry me?

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c = nil
local function arm_n0_g0_c(player)
	if shown_n0_g0_c ~= nil then return shown_n0_g0_c end
	if (player.lunch_sneeze or 0) == 0 then
		player:takeQuest("oolong_lonely", "finished")
		player.oolong_resolution = 3
		player:unparty("RACE_LUNCH")
		shown_n0_g0_c = [=[1]=]
		return shown_n0_g0_c
	end
	if not (((player.lunch_sneeze or 0) == 0)) then
		shown_n0_g0_c = [=[2]=]
		return shown_n0_g0_c
	end
	shown_n0_g0_c = [=[]=]
	return shown_n0_g0_c
end
newChat{ id=[=[n0_g0_c]=],
	text = function(npc, player)
		local which = arm_n0_g0_c(player)
		if which == [=[1]=] then return (player.name or "you") .. [=[: ]=] .. [=[Oolong, let me introduce you to Lunch. Lunch, meet Oolong.

]=] .. [=[Lunch: ]=] .. [=[Oh, my! What a darling little pig! Hello, Oolong!

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Wow, you're really nice.

]=] .. [=[Lunch: ]=] .. [=[Oh, thank you! You're the sweetest little pig I've ever met! Do you have a kitchen? How about I bake us some yummy brownies?

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Yes, ma'am! It's right around the corner.

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Wow, ]=] .. (player.name or "you") .. [=[! I've never met a kinder, more charming woman!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...uhh...well...

]=] .. [=[Oolong, the thrilled: ]=] .. [=[I can't believe it! It's like she's too good to be true!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Hmm. You know, Oolong, there's really something you should know...

]=] .. [=[Lunch: ]=] .. [=[Oh! You have a little puggy tail! That's so precious! I've never seen anything so adorable!

]=] .. [=[Oolong, the thrilled: ]=] .. [=[I think I'm in love.

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Thank you so much for introducing us, ]=] .. (player.name or "you") .. [=[. I'm completely grateful. Never in my life did I dream of meeting such a girl...as beautiful on the inside as she is on the outside.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yeah...speaking of her inside beauty...

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Here, let me give you a reward. 100,000 zeni.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Wow. Thank you.

]=] .. [=[Oolong, the thrilled: ]=] .. [=[My pleasure! Now, what was it you were about to tell me?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Umm...I guess it wasn't that important. I'll just leave the two of you to get to know one another better. A lot better. Bye now.

]=] end
		if which == [=[2]=] then return [=[Lunch: ]=] .. [=[Who are ya callin' kind?!?! Come here an' I'll show you just what kind I am!

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_d]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_e]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_f = nil
local function arm_n0_g0_f(player)
	if shown_n0_g0_f ~= nil then return shown_n0_g0_f end
	player:takeQuest("oolong_lonely", "finished")
	player.oolong_resolution = 3
	player:unparty("RACE_BURUMA")
	shown_n0_g0_f = [=[]=]
	return shown_n0_g0_f
end
newChat{ id=[=[n0_g0_f]=],
	text = function(npc, player)
		arm_n0_g0_f(player)
		return (player.name or "you") .. [=[: ]=] .. [=[Oolong, let me introduce you to Buruma. Buruma, meet Oolong.

]=] .. [=[Buruma: ]=] .. [=[Excuse me?!?!?! What are you talking about?!!?

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Wow! What big boobs you have!

]=] .. [=[Buruma: ]=] .. [=[Arrgghhh! Get back you filfthy pig!

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Well, there's no need to be rude.

]=] .. [=[Buruma: ]=] .. [=[Says the dirty minded little pig staring at my chest!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[He just likes you, Buruma. What's the problem? You were hunting for the dragonballs to find a boyfriend, right? I've saved you all the trouble. You should be grateful.

]=] .. [=[Oolong, the thrilled: ]=] .. [=[I certainly am!

]=] .. [=[Buruma: ]=] .. [=[Get back! This isn't what I wanted! I'm leaving!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Wait, Buruma...hear me out. What if you do walk out that door like you're planning? What if you leave now, and go and find the dragonballs? And what if, through a weird set of unforseen circumstances you end up comforting some moody alien and get pregnant?

]=] .. [=[Buruma: ]=] .. [=[What? That would never happen!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[But what if it did? And what if that alien were a selfish monster who never really loved you? How would you feel? What if he cared nothing for all of humanity, least of all you? What if he killed people at random just for the thrill of it? What would that be like?

]=] .. [=[Buruma: ]=] .. [=[That would be horrible!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[You're right. It would be. And right now you have an opportunity to insure that none of that ever happens. By staying here, and marrying this nice little pig who might grow to love you.

]=] .. [=[Oolong, the thrilled: ]=] .. [=[I already love your boobs.

]=] .. [=[Buruma: ]=] .. [=[...

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Stay here, Buruma. Marry the pig.

]=] .. [=[Oolong, the thrilled: ]=] .. [=[Yeah! Marry the pig!

]=] .. [=[Buruma: ]=] .. [=[...I...I...don't know...

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What if the alien were named after vegetables?

]=] .. [=[Buruma: ]=] .. [=[Ok. I'll marry the pig.

]=] .. [=[(A few weeks later)

]=] .. [=[Oolong, the husband: ]=] .. [=[Wow! That was a terrific honey moon! ]=] .. (player.name or "you") .. [=[, I'd really like to thank you for setting me up with Buruma. We don't always see eye to eye on everything...

]=] .. [=[Buruma: ]=] .. [=[How can we? You're three feet tall!

]=] .. [=[Oolong, the husband: ]=] .. [=[...And sometimes she's maybe a little bit mean...

]=] .. [=[Buruma: ]=] .. [=[You better talk nice about me, mister. You don't know the half of it!

]=] .. [=[Oolong, the husband: ]=] .. [=[...but this is the first time I've ever been with anyone who didn't want me for my money.

]=] .. [=[Buruma: ]=] .. [=[Or any other reason, for that matter.

]=] .. [=[Oolong, the husband: ]=] .. [=[I'd like to thank you. Please accept this gift.

]=] .. [=[Buruma: ]=] .. [=[Don't you go giving away our money! We might need that for a rainy day!

]=] .. [=[Oolong, the husband: ]=] .. [=[It's only 100,000 zeni, but as an adventurer I'm sure you'll be able to put it to good use.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you.

]=] .. [=[Buruma: ]=] .. [=[*sigh*

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
