-- dbt-generated-talk dialogue.OXKING
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.chichi_state or 0) == 4 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.ring_of_fire and player.quests.ring_of_fire.status == "finished") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.ring_of_fire and player.quests.ring_of_fire.status == "taken") then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The Ox King: ]=] .. [=[Ahhh, ]=] .. (player.name or "you") .. [=[, I'm glad you could join us. Please, help yourself!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you. It's always nice to have a good home cooked meal.]=] .. [=[The Ox King: ]=] .. [=[Absolutely! Great 

]=] end
		if which == [=[2]=] then return [=[Thanks again! Wildebeast is so yummy!]=] end
		if which == [=[3]=] then return [=[
The Ox King: ]=] .. [=[Hello, ]=] .. [=[! I hate to trouble you, but you look like the adventuresome sort. I don't suppose you'd be willing to help out someone with a bit of a problem?

]=] end
		if which == [=[]=] then return [=[
The Ox King: ]=] .. [=[Hello, ]=] .. [=[! I hate to trouble you, but you look like the adventuresome sort. I don't suppose you'd be willing to help out someone with a bit of a problem?

]=] end
		return "..."
	end,
	answers = {
		{[=[Certainly. What can I do for you?]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[Maybe. What do you need?]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[No, sorry.]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if not player.female then
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[
The Ox King: ]=] .. [=[Well, ]=] .. [=[, it's like this...I live in that castle up there on Mount Frypan, with my daughter, Chichi. And that's where I'd like to be right now. At the moment I'm down here standing in the cold. I'm dressed for it, at least...but my little girl is up there all alone with a rather large pile of food we've spent the past several days cooking...and I'm not up there with them! It's awful, I tell you!

]=] .. [=[
The Ox King: ]=] .. [=[What's the problem!?!?!? All that food up there and me down here not- ...oh. You mean why aren't I up there? Well, there's the rub. You see, when we bought the castle it came pre-installed with some factory options. Moat, portcullis, that sort of thing. Most of it wasn't of any use, but there's a pour-hole in the courtyard that leads to the moat, so you can refill it without having to go out the front gate while you're under siege. At least, that's what I assumed it was for. I wasn't planning on having any sieges, just dinner parties, so I did some minor rennovations, and set it up as a grease drain from the kitchen. Well, that was about six months ago, and I kind of forgot about it, until a few hours ago I stepped outside to smoke a cigar, tossed my match and BOOOM!!!! Six months worth of grease fire erupted all at once around the entire castle! The moat is thirty feet wide, and the flames are ten feet high!

]=] end
		if which == [=[]=] then return [=[
The Ox King: ]=] .. [=[Well, ]=] .. [=[, it's like this...I live in that castle up there on Mount Frypan, with my daughter, Chichi. And that's where I'd like to be right now. At the moment I'm down here standing in the cold. I'm dressed for it, at least...but my little girl is up there all alone with a rather large pile of food we've spent the past several days cooking...and I'm not up there with them! It's awful, I tell you!

]=] .. [=[
The Ox King: ]=] .. [=[What's the problem!?!?!? All that food up there and me down here not- ...oh. You mean why aren't I up there? Well, there's the rub. You see, when we bought the castle it came pre-installed with some factory options. Moat, portcullis, that sort of thing. Most of it wasn't of any use, but there's a pour-hole in the courtyard that leads to the moat, so you can refill it without having to go out the front gate while you're under siege. At least, that's what I assumed it was for. I wasn't planning on having any sieges, just dinner parties, so I did some minor rennovations, and set it up as a grease drain from the kitchen. Well, that was about six months ago, and I kind of forgot about it, until a few hours ago I stepped outside to smoke a cigar, tossed my match and BOOOM!!!! Six months worth of grease fire erupted all at once around the entire castle! The moat is thirty feet wide, and the flames are ten feet high!

]=] end
		return "..."
	end,
	answers = {
		{[=[Uh-huh. Let me see if I have this right: damsel on the mountain behind a ring of fire...you wearing a viking helm and nordic furs...all I need to do to get past the fire is be really brave, right?]=], jump=[=[n0_a_b]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end, cond=function(npc, player) return arm_n0_a(player) == [=[1]=] end},
		{[=[Ok, so go home. What's the problem?]=], jump=[=[n0_a_a]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end, cond=function(npc, player) return arm_n0_a(player) == "" end},
		{[=[Hmm. Ok, but what do you want me to do about it?]=], jump=[=[n0_a_a]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end, cond=function(npc, player) return arm_n0_a(player) == "" end},
		{[=[No...sorry, I think you're on your own for this one.]=], jump=[=[n0_a_c]=], cond=function(npc, player) return arm_n0_a(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_a_a = nil
local function arm_n0_a_a(player)
	if shown_n0_a_a ~= nil then return shown_n0_a_a end
	player:takeQuest("ring_of_fire", "taken")
	shown_n0_a_a = [=[]=]
	return shown_n0_a_a
end
newChat{ id=[=[n0_a_a]=],
	text = function(npc, player)
		arm_n0_a_a(player)
		return [=[
The Ox King: ]=] .. [=[Well, I was thinking if somebody could get inside, all we have to do is lower the drawbridge. It's made of steel, and it covers the distance across the moat, so we could just walk across. I'm sure Chichi has already thought of that, but she's a bit on the skinny side, and I don't think she's strong enough to turn the drawbridge crank. So, all we need to do is figure out a way to get either one of us inside.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_b = nil
local function arm_n0_a_b(player)
	if shown_n0_a_b ~= nil then return shown_n0_a_b end
	player:takeQuest("ring_of_fire", "taken")
	shown_n0_a_b = [=[]=]
	return shown_n0_a_b
end
newChat{ id=[=[n0_a_b]=],
	text = function(npc, player)
		arm_n0_a_b(player)
		return [=[
The Ox King: ]=] .. [=[Are you kidding? This isn't some Wagnerian Opera, this is Japanese Anime! There's a world of difference! You can't just charge in their and expect your bravery-to-the-point-of-stupidity to save you just because you're the son of the All Father! No, you'll either have to go find some alternate quest that will provide you a solution which you'll have to decide whether to use now, or save for later...or you'll have to pump your constitution and hit points high enough that you can just walk through the flames. See? Not Wagnerian at all. World of difference.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_c]=],
	text = [=[
The Ox King: ]=] .. [=[Wait! Please! I beg you to reconsider! There's a huge feast waiting for us up there...two racks of lamb, roast mutton, a keg of 16 =month old mead, and another filled with ale! The good kind, too, with hearty chunks floating around in it! 

]=],
	answers = {
		{[=[Hmm. 'Chunky ale.' How can I refuse an offer like that?]=], jump=[=[n0_a_c_a]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end},
		{[=[Sorry.]=], jump=[=[n0_a_c_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a_c_a = nil
local function arm_n0_a_c_a(player)
	if shown_n0_a_c_a ~= nil then return shown_n0_a_c_a end
	player:takeQuest("ring_of_fire", "taken")
	shown_n0_a_c_a = [=[]=]
	return shown_n0_a_c_a
end
newChat{ id=[=[n0_a_c_a]=],
	text = function(npc, player)
		arm_n0_a_c_a(player)
		return [=[
The Ox King: ]=] .. [=[Thank you so much! I was really starting to worry dinner might get cold.]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_c_b]=],
	text = [=[
The Ox King: ]=] .. [=[Well, alright. I suppose that does leave more ale for me. If I can get to it.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	if not player.female then
		shown_n0_b = [=[1]=]
		return shown_n0_b
	end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[
The Ox King: ]=] .. [=[Well, ]=] .. [=[, it's like this...I live in that castle up there on Mount Frypan, with my daughter, Chichi. And that's where I'd like to be right now. At the moment I'm down here standing in the cold. I'm dressed for it, at least...but my little girl is up there all alone with a rather large pile of food we've spent the past several days cooking...and I'm not up there with them! It's awful, I tell you!

]=] .. [=[
The Ox King: ]=] .. [=[What's the problem!?!?!? All that food up there and me down here not- ...oh. You mean why aren't I up there? Well, there's the rub. You see, when we bought the castle it came pre-installed with some factory options. Moat, portcullis, that sort of thing. Most of it wasn't of any use, but there's a pour-hole in the courtyard that leads to the moat, so you can refill it without having to go out the front gate while you're under siege. At least, that's what I assumed it was for. I wasn't planning on having any sieges, just dinner parties, so I did some minor rennovations, and set it up as a grease drain from the kitchen. Well, that was about six months ago, and I kind of forgot about it, until a few hours ago I stepped outside to smoke a cigar, tossed my match and BOOOM!!!! Six months worth of grease fire erupted all at once around the entire castle! The moat is thirty feet wide, and the flames are ten feet high!

]=] end
		if which == [=[]=] then return [=[
The Ox King: ]=] .. [=[Well, ]=] .. [=[, it's like this...I live in that castle up there on Mount Frypan, with my daughter, Chichi. And that's where I'd like to be right now. At the moment I'm down here standing in the cold. I'm dressed for it, at least...but my little girl is up there all alone with a rather large pile of food we've spent the past several days cooking...and I'm not up there with them! It's awful, I tell you!

]=] .. [=[
The Ox King: ]=] .. [=[What's the problem!?!?!? All that food up there and me down here not- ...oh. You mean why aren't I up there? Well, there's the rub. You see, when we bought the castle it came pre-installed with some factory options. Moat, portcullis, that sort of thing. Most of it wasn't of any use, but there's a pour-hole in the courtyard that leads to the moat, so you can refill it without having to go out the front gate while you're under siege. At least, that's what I assumed it was for. I wasn't planning on having any sieges, just dinner parties, so I did some minor rennovations, and set it up as a grease drain from the kitchen. Well, that was about six months ago, and I kind of forgot about it, until a few hours ago I stepped outside to smoke a cigar, tossed my match and BOOOM!!!! Six months worth of grease fire erupted all at once around the entire castle! The moat is thirty feet wide, and the flames are ten feet high!

]=] end
		return "..."
	end,
	answers = {
		{[=[Uh-huh. Let me see if I have this right: damsel on the mountain behind a ring of fire...you wearing a viking helm and nordic furs...all I need to do to get past the fire is be really brave, right?]=], jump=[=[n0_b_b]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end, cond=function(npc, player) return arm_n0_b(player) == [=[1]=] end},
		{[=[Ok, so go home. What's the problem?]=], jump=[=[n0_b_a]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end, cond=function(npc, player) return arm_n0_b(player) == "" end},
		{[=[Hmm. Ok, but what do you want me to do about it?]=], jump=[=[n0_b_a]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end, cond=function(npc, player) return arm_n0_b(player) == "" end},
		{[=[No...sorry, I think you're on your own for this one.]=], jump=[=[n0_b_c]=], cond=function(npc, player) return arm_n0_b(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_b_a = nil
local function arm_n0_b_a(player)
	if shown_n0_b_a ~= nil then return shown_n0_b_a end
	player:takeQuest("ring_of_fire", "taken")
	shown_n0_b_a = [=[]=]
	return shown_n0_b_a
end
newChat{ id=[=[n0_b_a]=],
	text = function(npc, player)
		arm_n0_b_a(player)
		return [=[
The Ox King: ]=] .. [=[Well, I was thinking if somebody could get inside, all we have to do is lower the drawbridge. It's made of steel, and it covers the distance across the moat, so we could just walk across. I'm sure Chichi has already thought of that, but she's a bit on the skinny side, and I don't think she's strong enough to turn the drawbridge crank. So, all we need to do is figure out a way to get either one of us inside.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b_b = nil
local function arm_n0_b_b(player)
	if shown_n0_b_b ~= nil then return shown_n0_b_b end
	player:takeQuest("ring_of_fire", "taken")
	shown_n0_b_b = [=[]=]
	return shown_n0_b_b
end
newChat{ id=[=[n0_b_b]=],
	text = function(npc, player)
		arm_n0_b_b(player)
		return [=[
The Ox King: ]=] .. [=[Are you kidding? This isn't some Wagnerian Opera, this is Japanese Anime! There's a world of difference! You can't just charge in their and expect your bravery-to-the-point-of-stupidity to save you just because you're the son of the All Father! No, you'll either have to go find some alternate quest that will provide you a solution which you'll have to decide whether to use now, or save for later...or you'll have to pump your constitution and hit points high enough that you can just walk through the flames. See? Not Wagnerian at all. World of difference.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_c]=],
	text = [=[
The Ox King: ]=] .. [=[Wait! Please! I beg you to reconsider! There's a huge feast waiting for us up there...two racks of lamb, roast mutton, a keg of 16 =month old mead, and another filled with ale! The good kind, too, with hearty chunks floating around in it! 

]=],
	answers = {
		{[=[Hmm. 'Chunky ale.' How can I refuse an offer like that?]=], jump=[=[n0_b_c_a]=], action=function(npc, player) player:takeQuest("ring_of_fire", "taken") end},
		{[=[Sorry.]=], jump=[=[n0_b_c_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_b_c_a = nil
local function arm_n0_b_c_a(player)
	if shown_n0_b_c_a ~= nil then return shown_n0_b_c_a end
	player:takeQuest("ring_of_fire", "taken")
	shown_n0_b_c_a = [=[]=]
	return shown_n0_b_c_a
end
newChat{ id=[=[n0_b_c_a]=],
	text = function(npc, player)
		arm_n0_b_c_a(player)
		return [=[
The Ox King: ]=] .. [=[Thank you so much! I was really starting to worry dinner might get cold.]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_c_b]=],
	text = [=[
The Ox King: ]=] .. [=[Well, alright. I suppose that does leave more ale for me. If I can get to it.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c]=],
	text = [=[
The Ox King: ]=] .. [=[Mmm...alright, then. Sorry to trouble you.]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
