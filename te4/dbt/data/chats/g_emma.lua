-- dbt-generated-talk dialogue.EMMA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.emma_reincarnate or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.emma_state or 0) == 0 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.emma_state or 0) == 2 then
		player.emma_state = 4
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.emma_state or 0) == 3 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.emma_state or 0) == 4 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (((player.emma_state or 0) == 0) or ((player.emma_state or 0) == 2) or ((player.emma_state or 0) == 3) or ((player.emma_state or 0) == 4)) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[The Emma Daio: ]=] .. [=[Hmm? What are you doing here? You're alive. The module maintainer hasn't written a dialogue contingency for me if you're alive. So, I don't have much to say. But, since I am a Daio, I could kill you. That way you'd have a dialogue to read. Would you like that?

]=] end
		if which == [=[3]=] then return [=[The Emma Daio: ]=] .. [=[What? You AGAIN!?!? Goodness...would you make up your mind? Heaven or Hell, either way is fine...but seriously, would you just pick one and stay dead? You're really starting to bog down our system here. I think I'm going to have to report you Higher authorities. We really can't have mere mortals abusing the Celestial System like this. Go on...get out of here. But don't let me catch you here again.

]=] .. [=[Hmm. You look familiar. Haven't you...been here before?

]=] .. [=[The Emma Daio: ]=] .. (player.name or "you") .. [=[: ]=] .. [=[...what? I'm not dead? Where am I?

]=] .. [=[You hear a noise behind you, and turn to behold a massive red ogre in fancy clothes scrutinizing you intently.

]=] .. [=[The Emma Daio: ]=] .. [=[No, ]=] .. (player.name or "you") .. [=[. You are quite dead. Thouroughly. I checked you myself.

]=] .. [=[The Emma Daio: ]=] .. [=[I am the Daio responsible for determining which souls pass on to Heaven, and which souls are sent to Hell. You are here in the Celestial space, at approximately three ninety degree angles from anything you've previously known, pending judgement to determine your final destination.

]=] end
		if which == [=[4]=] then return [=[...]=] end
		if which == [=[5]=] then return [=[The Emma Daio: ]=] .. [=[Hello again.

]=] end
		if which == [=[6]=] then return [=[Unknown dialogue/death state. Please report this bug, and let me know how you got here, and what sort of 'death' you did or didn't have. Thank you.]=] end
		return "..."
	end,
	answers = {
		{[=[No...that's ok. Thank you, but I'm happy being alive.]=], jump=[=[n0_g1_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Yeah, sure. I came here to talk to you anyway.]=], jump=[=[n0_g1_b]=], action=function(npc, player) player.alive = 3 player.emma_state = 4 end, cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Why, no, Daio. This is the first time I've died.]=], jump=[=[n0_g2_a]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[What? I'm dead? Then where am I? Who are you?]=], jump=[=[n0_g2_a]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[Oh dear. You don't make it sound very pleasant. So what's my final destination?]=], jump=[=[n0_g2_a]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[Hey! You're the Daio that Karin mentioned!]=], jump=[=[n0_g2_b]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[I don't suppose you'd be willing to answer a few questions?]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[Umm...nevermind.]=], jump=[=[n0_g4_b]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b = nil
local function arm_n0_g1_b(player)
	if shown_n0_g1_b ~= nil then return shown_n0_g1_b end
	player.alive = 3
	player.emma_state = 4
	shown_n0_g1_b = [=[]=]
	return shown_n0_g1_b
end
newChat{ id=[=[n0_g1_b]=],
	text = function(npc, player)
		arm_n0_g1_b(player)
		return [=[The Emma Daio: ]=] .. [=[Wow. Really? Ok.

]=] .. [=[Emma touches you on the forehead.

]=] .. [=[The Emma Daio: ]=] .. [=[There you go. You're now dead. Go ahead and restart the conversation and we'll talk.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a]=],
	text = [=[The Emma Daio: ]=] .. [=[Well, that's something of a problem. You see, your soul is right on the cusp between good and evil. It's difficult to judge you. Really, you could go either way, but it can take a lot of effort to find out for certain in cases like yours. Ordinarily I wouldn't bother. I'd just recycle you back into the system, and let you start all over. Of course, doing that breaks down what you would consider your 'consciousness' into component parts, and it's very unlikely that they'd all all end up back together again. Not that that would really be much of a problem, from where I sit.

]=],
	answers = {
		{[=[That doesn't sound very pleasant.]=], jump=[=[n0_g2_a_a]=]},
		{[=[Umm...could we try it another way?]=], jump=[=[n0_g2_a_b]=]},
		{[=[Wow! That sounds cool! Ok, I'm in!]=], jump=[=[n0_g2_a_c]=], action=function(npc, player) player.recursive_death = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a]=],
	text = [=[The Emma Daio: ]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a_a]=],
	text = [=[No? I can't imgaine why not. It's perfectly painless. Of couse, it does mean that part of your soul may end up reincarnating as a fish, or something, but there are worse things that can happen. ]=] .. [=[In any case, yours is a special situation because not only are you on the alignment cusp, you're also sufficiently willed that you've managed to maintain cohesion of your mental body even here in the afterlife. That's extremely rare. In any case, the Grand Daio is very particular about honoring free will, and I can't recycle you without your permission. For souls unable to manifest will, that's not an issue, but in your case...I...uh, don't suppose you'd be ok with it? ]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a_a_a]=],
	text = [=[You might not end up as a fish, you know. And even if you did, it wouldn't be all of you. Some of your consciousness might become something really neat, like say...a giraffe.]=],
	answers = {
		{[=[No, I think I'd really rather we didn't do that.]=], jump=[=[n0_g2_a_a_a_a_a]=]},
		{[=[Yeah, ok. That's fine.]=], jump=[=[n0_g2_a_a_a_a_b]=], action=function(npc, player) player.recursive_death = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a_a_a_a]=],
	text = [=[The Emma Daio: ]=] .. [=[Very well. Then, since I'm unable to send you on to Heaven or Hell, and you don't want to be recycled, I'll leave your soul free to wander. Good luck to you.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_a_a_a_b = nil
local function arm_n0_g2_a_a_a_a_b(player)
	if shown_n0_g2_a_a_a_a_b ~= nil then return shown_n0_g2_a_a_a_a_b end
	player.recursive_death = 1
	shown_n0_g2_a_a_a_a_b = [=[]=]
	return shown_n0_g2_a_a_a_a_b
end
newChat{ id=[=[n0_g2_a_a_a_a_b]=],
	text = function(npc, player)
		arm_n0_g2_a_a_a_a_b(player)
		return [=[The Emma Daio: ]=] .. [=[Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.

]=] .. [=[He reaches out and touches you on the forehead.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a_b]=],
	text = [=[Yes, I figured you'd be less than thrilled about that. ]=] .. [=[In any case, yours is a special situation because not only are you on the alignment cusp, you're also sufficiently willed that you've managed to maintain cohesion of your mental body even here in the afterlife. That's extremely rare. In any case, the Grand Daio is very particular about honoring free will, and I can't recycle you without your permission. For souls unable to manifest will, that's not an issue, but in your case...I...uh, don't suppose you'd be ok with it? ]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a_b_a]=],
	text = [=[You might not end up as a fish, you know. And even if you did, it wouldn't be all of you. Some of your consciousness might become something really neat, like say...a giraffe.]=],
	answers = {
		{[=[No, I think I'd really rather we didn't do that.]=], jump=[=[n0_g2_a_a_b_a_a]=]},
		{[=[Yeah, ok. That's fine.]=], jump=[=[n0_g2_a_a_b_a_b]=], action=function(npc, player) player.recursive_death = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a_b_a_a]=],
	text = [=[The Emma Daio: ]=] .. [=[Very well. Then, since I'm unable to send you on to Heaven or Hell, and you don't want to be recycled, I'll leave your soul free to wander. Good luck to you.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_a_b_a_b = nil
local function arm_n0_g2_a_a_b_a_b(player)
	if shown_n0_g2_a_a_b_a_b ~= nil then return shown_n0_g2_a_a_b_a_b end
	player.recursive_death = 1
	shown_n0_g2_a_a_b_a_b = [=[]=]
	return shown_n0_g2_a_a_b_a_b
end
newChat{ id=[=[n0_g2_a_a_b_a_b]=],
	text = function(npc, player)
		arm_n0_g2_a_a_b_a_b(player)
		return [=[The Emma Daio: ]=] .. [=[Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.

]=] .. [=[He reaches out and touches you on the forehead.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b]=],
	text = [=[The Emma Daio: ]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_a]=],
	text = [=[No? I can't imgaine why not. It's perfectly painless. Of couse, it does mean that part of your soul may end up reincarnating as a fish, or something, but there are worse things that can happen. ]=] .. [=[In any case, yours is a special situation because not only are you on the alignment cusp, you're also sufficiently willed that you've managed to maintain cohesion of your mental body even here in the afterlife. That's extremely rare. In any case, the Grand Daio is very particular about honoring free will, and I can't recycle you without your permission. For souls unable to manifest will, that's not an issue, but in your case...I...uh, don't suppose you'd be ok with it? ]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_a_a]=],
	text = [=[You might not end up as a fish, you know. And even if you did, it wouldn't be all of you. Some of your consciousness might become something really neat, like say...a giraffe.]=],
	answers = {
		{[=[No, I think I'd really rather we didn't do that.]=], jump=[=[n0_g2_a_b_a_a_a]=]},
		{[=[Yeah, ok. That's fine.]=], jump=[=[n0_g2_a_b_a_a_b]=], action=function(npc, player) player.recursive_death = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_a_a_a]=],
	text = [=[The Emma Daio: ]=] .. [=[Very well. Then, since I'm unable to send you on to Heaven or Hell, and you don't want to be recycled, I'll leave your soul free to wander. Good luck to you.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_b_a_a_b = nil
local function arm_n0_g2_a_b_a_a_b(player)
	if shown_n0_g2_a_b_a_a_b ~= nil then return shown_n0_g2_a_b_a_a_b end
	player.recursive_death = 1
	shown_n0_g2_a_b_a_a_b = [=[]=]
	return shown_n0_g2_a_b_a_a_b
end
newChat{ id=[=[n0_g2_a_b_a_a_b]=],
	text = function(npc, player)
		arm_n0_g2_a_b_a_a_b(player)
		return [=[The Emma Daio: ]=] .. [=[Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.

]=] .. [=[He reaches out and touches you on the forehead.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_b]=],
	text = [=[Yes, I figured you'd be less than thrilled about that. ]=] .. [=[In any case, yours is a special situation because not only are you on the alignment cusp, you're also sufficiently willed that you've managed to maintain cohesion of your mental body even here in the afterlife. That's extremely rare. In any case, the Grand Daio is very particular about honoring free will, and I can't recycle you without your permission. For souls unable to manifest will, that's not an issue, but in your case...I...uh, don't suppose you'd be ok with it? ]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_b_a]=],
	text = [=[You might not end up as a fish, you know. And even if you did, it wouldn't be all of you. Some of your consciousness might become something really neat, like say...a giraffe.]=],
	answers = {
		{[=[No, I think I'd really rather we didn't do that.]=], jump=[=[n0_g2_a_b_b_a_a]=]},
		{[=[Yeah, ok. That's fine.]=], jump=[=[n0_g2_a_b_b_a_b]=], action=function(npc, player) player.recursive_death = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_b_a_a]=],
	text = [=[The Emma Daio: ]=] .. [=[Very well. Then, since I'm unable to send you on to Heaven or Hell, and you don't want to be recycled, I'll leave your soul free to wander. Good luck to you.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_b_b_a_b = nil
local function arm_n0_g2_a_b_b_a_b(player)
	if shown_n0_g2_a_b_b_a_b ~= nil then return shown_n0_g2_a_b_b_a_b end
	player.recursive_death = 1
	shown_n0_g2_a_b_b_a_b = [=[]=]
	return shown_n0_g2_a_b_b_a_b
end
newChat{ id=[=[n0_g2_a_b_b_a_b]=],
	text = function(npc, player)
		arm_n0_g2_a_b_b_a_b(player)
		return [=[The Emma Daio: ]=] .. [=[Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.

]=] .. [=[He reaches out and touches you on the forehead.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_c = nil
local function arm_n0_g2_a_c(player)
	if shown_n0_g2_a_c ~= nil then return shown_n0_g2_a_c end
	player.recursive_death = 1
	shown_n0_g2_a_c = [=[]=]
	return shown_n0_g2_a_c
end
newChat{ id=[=[n0_g2_a_c]=],
	text = function(npc, player)
		arm_n0_g2_a_c(player)
		return [=[The Emma Daio: ]=] .. [=[Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.

]=] .. [=[He reaches out and touches you on the forehead.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_b = nil
local function arm_n0_g2_b(player)
	if shown_n0_g2_b ~= nil then return shown_n0_g2_b end
	if true then
		shown_n0_g2_b = [=[1]=]
		return shown_n0_g2_b
	end
	player.alive = 0
	shown_n0_g2_b = [=[]=]
	return shown_n0_g2_b
end
newChat{ id=[=[n0_g2_b]=],
	text = function(npc, player)
		local which = arm_n0_g2_b(player)
		if which == [=[1]=] then return [=[The Emma Daio: ]=] .. [=[Yes...of course. Why do you sound so surprised?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...umm...that's odd. This isn't the dialogue path I expected.

]=] .. [=[The Emma Daio: ]=] .. [=[What? Were you expecting another freebie ressurection?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...well, yes, but...

]=] .. [=[The Emma Daio: ]=] .. [=[No buts! I said ONCE, remember?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...well, yes I remember, but how come YOU do?

]=] .. [=[The Emma Daio: ]=] .. [=[Well, I am a Daio. We're supposed to know this kind of thing.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Ok, so what happens now?

]=] .. [=[The Emma Daio: ]=] .. [=[Hmm. Well, I'm tempted to send you to Hell, or just perma-kill you outright for trying to trick me.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[But I wasn't trying to trick you! I just didn't realize that 'once' meant...REALLY only once. I mean, come on...this is a different character completely.

]=] .. [=[The Emma Daio: ]=] .. [=[Hmm. Yes, I see how you might have misunderstood. Very well. I'll forgive your transgression and let you wander the earth as a spirit.

]=] end
		if which == [=[]=] then return [=[The Emma Daio: ]=] .. [=[Oh...you're a friend of Karin? 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes, we train together often.

]=] .. [=[The Emma Daio: ]=] .. [=[Oh! Well, nice to meet you. I'm Emma. 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[So I guess that means I'm dead?

]=] .. [=[The Emma Daio: ]=] .. [=[Sadly, yes.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Oh dear. That's very sad. I really wasn't ready to be dead yet. Is there anything I can do?

]=] .. [=[The Emma Daio: ]=] .. [=[Hmm. Well, Ordinarily it takes the power of a wish to restore someone to life. I don't suppose you have a complete set of dragonballs on you, do you?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[No, I'm afraid not.

]=] .. [=[The Emma Daio: ]=] .. [=[Hmm. Well,  I suppose...maybe...I could bring you back myself. I mean, I AM a Daio, and all.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Oh, really! Would you please?

]=] .. [=[The Emma Daio: ]=] .. [=[Well, alright. Since you're a friend of Karin's. But, just this once. And I do mean ONCE!!! Understand?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Absolutely.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a]=],
	text = [=[The Emma Daio: ]=] .. [=[What would you like to know?

]=],
	answers = {
		{[=[Kaio? Local to my district? What does that mean?]=], jump=[=[n0_g4_a_a]=], action=function(npc, player) player.emma_mentioned_kaio = 1 end},
		{[=[Kaoishin? Who are they?]=], jump=[=[n0_g4_a_b]=]},
		{[=[Ok. And what's a Daio?]=], jump=[=[n0_g4_a_c]=]},
		{[=[Umm...so...the Daio are major, big-time OverGods...and you ARE one. So since I'm here can you tell me what the meaning of life is?]=], jump=[=[n0_g4_a_d]=]},
		{[=[Is there anything I should know about being dead?]=], jump=[=[n0_g4_a_e]=]},
		{[=[Where exactly is this place? How do I get out?]=], jump=[=[n0_g4_a_f]=]},
		{[=[What about Heaven?]=], jump=[=[n0_g4_a_g]=]},
		{[=[What about Hell?]=], jump=[=[n0_g4_a_h]=]},
		{[=[How do I get not-dead?]=], jump=[=[n0_g4_a_i]=]},
		{[=[Ok. Thank you for answering my questions.]=], jump=[=[n0_g4_a_j]=]},
		{"[Leave]"},
	},
}

local shown_n0_g4_a_a = nil
local function arm_n0_g4_a_a(player)
	if shown_n0_g4_a_a ~= nil then return shown_n0_g4_a_a end
	player.emma_mentioned_kaio = 1
	shown_n0_g4_a_a = [=[]=]
	return shown_n0_g4_a_a
end
newChat{ id=[=[n0_g4_a_a]=],
	text = function(npc, player)
		arm_n0_g4_a_a(player)
		return [=[The Emma Daio: ]=] .. [=[Your galaxy is divided into four cardinal districts: 'north' 'east' 'south' and 'west.' Each is overseen by a 'Kaio.' You might think of the Kaio as being a minor OverGod, one step up in the Celestial Hierarchy from planetary Gods, or 'Kami,' but one step below the universal overseers, the Kaioshin. Let's see...in your case, you're from earth, which is in the northern district of your native galaxy, so the eastern path (to your right) will take you to the North Kaio's planet.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_b]=],
	text = [=[The Emma Daio: ]=] .. [=[The Kaioshin are one step above the Kaio. While the countless Kaio oversee districts within each and every galaxy, there are only four Kaioshin in the universe, each looking after one quarter of the countless galaxies that exist. Primarily they perform supervisory functions, and act as liasons between the Kaio and us Daio. Only very rarely do they actually involve themselves in situations that arise. Instead, Kaio do most of the work within specific galaxies, and we Daio handle affairs of a more universal nature.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_c]=],
	text = [=[The Emma Daio: ]=] .. [=[We Daio are one step up in the Celestial Hierarchy from the Kaioshin. While the Kaioshin oversee galaxies, we Daio perform functions relating to All-That-Is. For example, in my case, I handle the processing of all souls, anywhere in all of Creation. It's a big job, but somebody has to do it.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_d]=],
	text = [=[The Emma Daio: ]=] .. [=[Life? Consciousness confined within particulate matter? Well, it varies, but in this particular universe...and I realize this might surprise you, the sole purpose of your being is actually to provide entertainment to somebody sitting at a computer in a universe somewhat adjacent to this one. You also get brownie points if you can reach dialogue branches that encourage them to think. I know...it sounds strange. It isn't. I assure you on the grander scheme of things there are far stranger universes. For example...take the universe the person you're supposed to be entertaining is in right now. That's a pretty twisted situation, there.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_e]=],
	text = [=[The Emma Daio: ]=] .. [=[Lots of things. Fortunately being dead comes with a manual. If you check your inventory, you should find it.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_f]=],
	text = [=[The Emma Daio: ]=] .. [=[We're standing in the middle of the Serpent's Path, a byway through extremely extra-dimensional space that connects various three dimensional spaces in the universe to one another. I'm afraid your soul isn't quite dense enough to be able to traverse its entire length, but you'd probably find its seven-dimensional nature a bit confusing to navigate anyway. The Serpent's Path will spatially manifest differently to each soul. In your case, as a third density soul, only three directions on the path will be accessible to you. If you go to the left, you'll wind up back on your homeworld, earth. If you go right, you'll end up at the planet of the Kaio local to your universal district. And, of course, if you fall off the path, you'll wind up in Hell.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_g]=],
	text = [=[The Emma Daio: ]=] .. [=[Heaven is where souls who have been deemed 'good' in life go. It's a nice place. The clouds are really quite lovely. You really should go visit sometime. Oh...wait, I guess you can't. Sorry.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_h]=],
	text = [=[The Emma Daio: ]=] .. [=[Hell is where souls who have been deemed 'evil' go. It's not exactly the nicest place in the universe. A bit dull, really. Oh, it's not as bad as your local superstitions would have you belive: The demons usually have much better things to do than sit around and torture souls. I think they got bored after the first few millenia. Really, the worst part of Hell is sitting around listening to all the other souls whine and complain all the time. Not much else to do there, I'm afraid. Oh...speaking of Hell, you should probably know that this portion of the path that you're standing on sits directly above it. If you were to fall off, that's where you'd end up. In Hell. I'd try to avoid that if I were you. Very dull.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_i]=],
	text = [=[The Emma Daio: ]=] .. [=[That generally doesn't happen. Oh, I'm not saying it can't. There are a couple ways, of course. But if you ask me, you'd really be better off just being recycled. It won't hurt one bit.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_j]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
