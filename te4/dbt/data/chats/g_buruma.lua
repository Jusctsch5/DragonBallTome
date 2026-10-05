-- dbt-generated-talk dialogue.BURUMA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if player:isPartied("RACE_BURUMA") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.buruma_state or 0) == 0 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if ((player.buruma_state or 0) == 0) or ((player.buruma_state or 0) == 1) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.buruma_state or 0) == 2 then
		player.buruma_state = 3
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.buruma_state or 0) == 3 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Buruma: ]=] .. [=[Yes?

]=] end
		if which == [=[2]=] then return [=[You see an attractive young girl wandering around with a determined look on her face. She appears to be fiddling with some sort of device, and seems a bit frustrated.

]=] end
		if which == [=[3]=] then return [=[Buruma: ]=] .. [=[...no. ...no. ...maybe if I...no. Hmm.

]=] end
		if which == [=[4]=] then return [=[Buruma: ]=] .. [=[Hi, ]=] .. (player.name or "you") .. [=[. Thanks for letting me know daddy was done fixing my Dragon Radar. It will help a lot!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...Dragon Radar? You're looking for dragons?

]=] .. [=[Buruma: ]=] .. [=[No, silly! I'm looking for Dragonballs!

]=] .. [=[NOTE: ]=] .. [=[Buruma's dialogue has been somewhat mutiliated due to some code reverts, and much of it has not yet been recreated. For now, Buruma will just be happy. (I know, there's a first.) If you'd like to invite her to your party, just strike up a conversation with her again.

]=] end
		if which == [=[5]=] then return [=[Buruma: ]=] .. [=[Hello again, ]=] .. (player.name or "you") .. [=[! Shall we go look for the dragonballs?

]=] end
		if which == [=[]=] then return [=[Buruma: ]=] .. [=[Well, look who it isn't. What brings you back? Haven't you caused enough trouble for me?

]=] .. [=[Buruma: ]=] .. (player.name or "you") .. [=[! Please tell me you've found the dragonballs and you're here to wish me off this wretched island.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Heh. No such luck. How have you been? How is Rosshi treating you?

]=] .. [=[Buruma: ]=] .. [=[Don't even get me started about that horrible old geezer! He can't keep his hands off of me! It's terrible!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[But weren't you looking for the dragonballs in the first place so you could wish for a girlfriend?

]=] .. [=[Buruma: ]=] .. [=[But not like this!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Well, you know what they say. Be careful what you wish for. You may get it.

]=] end
		return "..."
	end,
	answers = {
		{[=[Never mind.]=], jump=[=[n0_g0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Thanks for joining me, but I'd like to continue on my own now.]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Are there any dragonballs nearby?]=], jump=[=[n0_g0_d]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Not right now.]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[Yes, please. I could use your help.]=], jump=[=[n0_g4_b]=], action=function(npc, player) player:partyWith({define_as="RACE_BURUMA", name="companion", level=1}) end, cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[So how's married life?]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[How would you like to take some time off and come adventuring with me?]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		return [=[Buruma: ]=] .. [=[Terrible! I'm so bored I don't know what to do with myself!

]=] .. [=[Oolong: ]=] .. [=[That's ok. I certainly know what to do with yourself.

]=] .. [=[Buruma: ]=] .. [=[Ahhhgghh! Get back! Three times in one day is enough already!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Heh. Well, I just thought I'd stop by to visit. Take care.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		return [=[Buruma: ]=] .. [=[Oh! I want to! I can't even begin to tell you how much I want to! But I can't. I'm...pregnant.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Wow! Really? You? With...Oolong?

]=] .. [=[Buruma: ]=] .. [=[Yes with my husband! What kind of girl do you think I am??!?!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Heh...sorry I asked. Well, good luck with the piglets!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = [=[Buruma: ]=] .. [=[What? You think you can get rid of me that easily? No way, bucko! I'm in this for good! I'm after the dragonballs, and I'm not going to let you beat me to them.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c = nil
local function arm_n0_g0_c(player)
	if shown_n0_g0_c ~= nil then return shown_n0_g0_c end
	player:unparty("RACE_BURUMA")
	shown_n0_g0_c = [=[]=]
	return shown_n0_g0_c
end
newChat{ id=[=[n0_g0_c]=],
	text = function(npc, player)
		arm_n0_g0_c(player)
		return [=[Buruma: ]=] .. [=[Dangerous? Like how dangerous? You don't think I might break a nail, do you?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Umm...yeah. Maybe.

]=] .. [=[Buruma: ]=] .. [=[...ehh...then maybe I should just go let you take care of it. I'll meet up with you later at my palce, ok?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Sounds good.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_d = nil
local function arm_n0_g0_d(player)
	if shown_n0_g0_d ~= nil then return shown_n0_g0_d end
	if true then
		shown_n0_g0_d = [=[1]=]
		return shown_n0_g0_d
	end
	shown_n0_g0_d = [=[]=]
	return shown_n0_g0_d
end
newChat{ id=[=[n0_g0_d]=],
	text = function(npc, player)
		local which = arm_n0_g0_d(player)
		if which == [=[1]=] then return [=[Buruma: ]=] .. [=[YES! There are ]=] .. [=[ dragonballs right near here!

]=] end
		if which == [=[]=] then return [=[Buruma: ]=] .. [=[No. I don't detect any dragonballs in the area.

]=] .. [=[Buruma: ]=] .. [=[Yes! We're very close to a dragonball right now!

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_e = nil
local function arm_n0_g0_e(player)
	if shown_n0_g0_e ~= nil then return shown_n0_g0_e end
	player.buruma_ever_carried = 1
	shown_n0_g0_e = [=[]=]
	return shown_n0_g0_e
end
newChat{ id=[=[n0_g0_e]=],
	text = function(npc, player)
		local which = arm_n0_g0_e(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a = nil
local function arm_n0_g2_a(player)
	if shown_n0_g2_a ~= nil then return shown_n0_g2_a end
	if (player.buruma_state or 0) == 1 then
		shown_n0_g2_a = [=[1]=]
		return shown_n0_g2_a
	end
	if not (((player.buruma_state or 0) == 1)) then
		shown_n0_g2_a = [=[2]=]
		return shown_n0_g2_a
	end
	player.buruma_state = 1
	shown_n0_g2_a = [=[]=]
	return shown_n0_g2_a
end
newChat{ id=[=[n0_g2_a]=],
	text = function(npc, player)
		local which = arm_n0_g2_a(player)
		if which == [=[1]=] then return [=[Yes. I remember you.

]=] end
		if which == [=[2]=] then return [=[Hello. I'm Buruma. I'm also extremely busy.

]=] end
		if which == [=[]=] then return [=[She answers disinterestedly, and doesn't look up from what she's doing.

]=] .. [=[Buruma: ]=] end
		return "..."
	end,
	answers = {
		{[=[Oh. Sorry to trouble you.]=], jump=[=[n0_g2_a_a]=], cond=function(npc, player) return arm_n0_g2_a(player) == "" end},
		{[=[Anything I can help with?]=], jump=[=[n0_g2_a_b]=], cond=function(npc, player) return arm_n0_g2_a(player) == "" end},
		{[=[Wow. You're awfully rude.]=], jump=[=[n0_g2_a_c]=], cond=function(npc, player) return arm_n0_g2_a(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_b = nil
local function arm_n0_g2_a_b(player)
	if shown_n0_g2_a_b ~= nil then return shown_n0_g2_a_b end
	if player:skillLevel("technology") > 3 then
		shown_n0_g2_a_b = [=[1]=]
		return shown_n0_g2_a_b
	end
	shown_n0_g2_a_b = [=[]=]
	return shown_n0_g2_a_b
end
newChat{ id=[=[n0_g2_a_b]=],
	text = function(npc, player)
		local which = arm_n0_g2_a_b(player)
		if which == [=[1]=] then return [=[She looks up at you.

]=] .. [=[Buruma: ]=] .. [=[Not unless you happen to have any experience rewiring tripolyacetane based tachyon field positronometers with tools roughly as precise as stone knives and bear skin. I need to increase the base inductance ratio of my radar by at least another .3 percent, and it's being very stubborn.

]=] end
		if which == [=[]=] then return [=[She looks up at you.

]=] .. [=[Buruma: ]=] .. [=[Not unless you happen to have any experience rewiring tripolyacetane based tachyon field positronometers with tools roughly as precise as stone knives and bear skin. I need to increase the base inductance ratio of my radar by at least another .3 percent, and it's being very stubborn.

]=] end
		return "..."
	end,
	answers = {
		{[=[You're using tachyons to detect positrons? Isn't that going about things the hard way to begin with?]=], jump=[=[n0_g2_a_b_b]=], cond=function(npc, player) return arm_n0_g2_a_b(player) == [=[1]=] end},
		{[=[Umm...no. I'm sorry, I don't think I can help with that.]=], jump=[=[n0_g2_a_b_a]=], cond=function(npc, player) return arm_n0_g2_a_b(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a_b_a]=],
	text = [=[Buruma: ]=] .. [=[I didn't think so. Now, if you'll excuse me...]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_b_b = nil
local function arm_n0_g2_a_b_b(player)
	if shown_n0_g2_a_b_b ~= nil then return shown_n0_g2_a_b_b end
	if not (player.quests and player.quests.dragonballs) then
		shown_n0_g2_a_b_b = [=[1]=]
		return shown_n0_g2_a_b_b
	end
	if not ((not (player.quests and player.quests.dragonballs))) then
		shown_n0_g2_a_b_b = [=[2]=]
		return shown_n0_g2_a_b_b
	end
	if player.female then
		shown_n0_g2_a_b_b = [=[3]=]
		return shown_n0_g2_a_b_b
	end
	if not ((player.female)) then
		shown_n0_g2_a_b_b = [=[4]=]
		return shown_n0_g2_a_b_b
	end
	shown_n0_g2_a_b_b = [=[]=]
	return shown_n0_g2_a_b_b
end
newChat{ id=[=[n0_g2_a_b_b]=],
	text = function(npc, player)
		local which = arm_n0_g2_a_b_b(player)
		if which == [=[1]=] then return [=[So basically you're looking to build a device capable of detecting the unique emmissions of a specific material from anywhere on the planet?

]=] end
		if which == [=[2]=] then return [=[So basically you're looking to build a device that will locate the dragonballs from anywhere on the entire planet?

]=] end
		if which == [=[3]=] then return [=[you're pretty smart. ]=] end
		if which == [=[4]=] then return [=[you're a really neat guy. ]=] end
		if which == [=[]=] then return [=[She pauses for a moment.

]=] .. [=[Buruma: ]=] .. [=[Well, yes. Unfortunately I've found no practical way to detect the unique tachyons emmitted by Dragonballs outside of laboratory conditions, and with very large apparatus. Checking for positrons is much easier, of course, but they don't have the same penetration as tachyons. Really, what I want to do is generate tachyons, which, as you know, will penetrate just about anything, and have more or less infinite range. Then, when a remote tachyon interacts with an appropriate positron, even on the opposite side of the planet...

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...the tachyons' quantuum partner will register the interaction, and since you've kept it here it's easy to measure.

]=] .. [=[Buruma: ]=] .. [=[Exactly!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Buruma: ]=] .. [=[Exactly! Hey, ]=] .. [=[Not many people understand what I'm talking about most of the time. Maybe you can help me with something. Do you know about the dragonballs? (Implement rest of branch)

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_a_c = nil
local function arm_n0_g2_a_c(player)
	if shown_n0_g2_a_c ~= nil then return shown_n0_g2_a_c end
	if player.female then
		shown_n0_g2_a_c = [=[1]=]
		return shown_n0_g2_a_c
	end
	if not ((player.female)) then
		shown_n0_g2_a_c = [=[2]=]
		return shown_n0_g2_a_c
	end
	shown_n0_g2_a_c = [=[]=]
	return shown_n0_g2_a_c
end
newChat{ id=[=[n0_g2_a_c]=],
	text = function(npc, player)
		local which = arm_n0_g2_a_c(player)
		if which == [=[1]=] then return [=[Buruma: ]=] .. [=[You would be too if you'd been single all your life.]=] end
		if which == [=[2]=] then return [=[She sighs and looks at the ground sadly.

]=] .. [=[Buruma: ]=] .. [=[You're not the first guy to tell me that.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_b = nil
local function arm_n0_g2_b(player)
	if shown_n0_g2_b ~= nil then return shown_n0_g2_b end
	player:takeQuest("briefs_find_buruma", "completed")
	player.buruma_state = 2
	shown_n0_g2_b = [=[]=]
	return shown_n0_g2_b
end
newChat{ id=[=[n0_g2_b]=],
	text = function(npc, player)
		arm_n0_g2_b(player)
		return [=[Instantly she is extremely excited.

]=] .. [=[Buruma: ]=] .. [=[He has?!?! Oh...thank you!

]=] .. [=[She pulls a capsule from her pocket and tosses it to the ground. Instantly a small jet materializes in front of you. She hops in, and is gone in an instant.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_b = nil
local function arm_n0_g4_b(player)
	if shown_n0_g4_b ~= nil then return shown_n0_g4_b end
	player:partyWith({define_as="RACE_BURUMA", name="companion", level=1})
	shown_n0_g4_b = [=[]=]
	return shown_n0_g4_b
end
newChat{ id=[=[n0_g4_b]=],
	text = function(npc, player)
		local which = arm_n0_g4_b(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
