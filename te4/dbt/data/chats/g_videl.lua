-- dbt-generated-talk dialogue.VIDEL
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.videl_state or 0) == 5 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.videl_state or 0) == 8 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.videl_state or 0) == 7 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.videl_state or 0) == 9 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.videl_state or 0) == 4 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.videl_state or 0) == 6 then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.videl_state or 0) ~= 2 then
		player.videl_state = 1
		shown_n0 = [=[7]=]
		return shown_n0
	end
	if (player.videl_state or 0) == 2 then
		shown_n0 = [=[8]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Videl: ]=] .. [=[Please convince my father!]=] end
		if which == [=[2]=] then return [=[Hello, beloved!]=] .. [=[Buruma: ]=] .. [=[Well, look who it isn't. What brings you back? Haven't you caused enough trouble for me?

]=] end
		if which == [=[3]=] then return [=[Videl: ]=] .. [=[Is it TRUE?!!?? Did you win!?!?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes. So we can get married now, right?

]=] .. [=[Videl: ]=] .. [=[But...I...can't! I'm only 17!!! I'm...I...umm...

]=] .. [=[She look at you uncertaintly, but you simply hold her gaze and watch as she melts. After afew moments she starts to smile, and then slowly nods.

]=] .. [=[Videl: ]=] .. [=[...yes. Yes, ]=] .. (player.name or "you") .. [=[, I will marry you. We'd better talk to me father first, though. Just to make sure that he'll really allow it.

]=] end
		if which == [=[4]=] then return [=[Hello, beloved. :)]=] end
		if which == [=[5]=] then return [=[Videl: ]=] .. [=[Please convince my father!]=] end
		if which == [=[6]=] then return (player.name or "you") .. [=[: ]=] .. [=[He said 'ok.'

]=] .. [=[Videl: ]=] .. [=[...he what?

]=] .. [=[Mr. Satan: ]=] .. [=[Yep. This is a fine boy. You two love birds go right ahead.

]=] .. [=[Videl: ]=] .. [=[WHAT?!?!

]=] .. [=[Mr. Satan: ]=] .. [=[No, dear...it's alright. You can get married now. This one obviously appreciates the finer things in life. Me, for instance. So, Im suire he'll make a terrific husband.

]=] .. [=[Videl is speechless.

]=] end
		if which == [=[7]=] then return [=[Videl: ]=] end
		if which == [=[8]=] then return [=[Videl looks uncomfortable and shies away from conversation.]=] end
		if which == [=[]=] then return [=[Hello, beloved!]=] .. [=[Buruma: ]=] .. [=[Well, look who it isn't. What brings you back? Haven't you caused enough trouble for me?

]=] end
		return "..."
	end,
	answers = {
		{[=[So how's married life?]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_g6_a = nil
local function arm_n0_g6_a(player)
	if shown_n0_g6_a ~= nil then return shown_n0_g6_a end
	if player.female then
		shown_n0_g6_a = [=[1]=]
		return shown_n0_g6_a
	end
	if not ((player.female)) then
		shown_n0_g6_a = [=[2]=]
		return shown_n0_g6_a
	end
	player.videl_state = 3
	shown_n0_g6_a = [=[]=]
	return shown_n0_g6_a
end
newChat{ id=[=[n0_g6_a]=],
	text = function(npc, player)
		local which = arm_n0_g6_a(player)
		if which == [=[1]=] then return [=[Videl smiles happily.

]=] .. [=[Videl: ]=] .. [=[Oh, really? How wonderful! I have company so rarely! Thank you so much for visiting me! :)

]=] end
		if which == [=[2]=] then return [=[Videl smiles happily.

]=] .. [=[Videl: ]=] .. [=[Oh, really? How wonderful! I have company so rarely! Thank you so much for visiting me! :)

]=] end
		if which == [=[]=] then return [=[Videl smiles happily.

]=] .. [=[Videl: ]=] .. [=[Oh, really? How wonderful! I have company so rarely! Thank you so much for visiting me! :)

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g6_b]=],
	text = [=[Videl: ]=] .. [=[He's right there. Training, as usual. Go on in.]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g6_c = nil
local function arm_n0_g6_c(player)
	if shown_n0_g6_c ~= nil then return shown_n0_g6_c end
	if (player.videl_state or 0) == 0 then
		shown_n0_g6_c = [=[1]=]
		return shown_n0_g6_c
	end
	if not (((player.videl_state or 0) == 0)) then
		shown_n0_g6_c = [=[2]=]
		return shown_n0_g6_c
	end
	if (player.quests and player.quests.oolong_lonely and player.quests.oolong_lonely.status == "taken") then
		shown_n0_g6_c = [=[3]=]
		return shown_n0_g6_c
	end
	if (player.quests and player.quests.rosshi_lonely and player.quests.rosshi_lonely.status == "taken") then
		shown_n0_g6_c = [=[4]=]
		return shown_n0_g6_c
	end
	if (player.alignment or 0) < 0 then
		shown_n0_g6_c = [=[5]=]
		return shown_n0_g6_c
	end
	shown_n0_g6_c = [=[]=]
	return shown_n0_g6_c
end
newChat{ id=[=[n0_g6_c]=],
	text = function(npc, player)
		local which = arm_n0_g6_c(player)
		if which == [=[1]=] then return [=[...oh? That's a bit unusual. Honestly though, it's sort of a relief. I don't mean to unload on you, but it's not always the nicest thing...being the daughter of someone so famous. I can't remember the last time anyone came to visit me. It's...lonely.

]=] end
		if which == [=[2]=] then return [=[Just exploring? Oh, that's right. You're an adventurer. You're so nice, I sometimes forget about that. Yes, I suppose daddy's gauntlet would make a good place for that sort of thing. At least, if you hadn't already lived here all your life. Wow...it's really nice having you here to talk to. Sometimes I get so lonely here all by myself. I don't get much company.

]=] end
		if which == [=[3]=] then return [=[Videl: ]=] end
		if which == [=[4]=] then return [=[Videl: ]=] end
		if which == [=[5]=] then return [=[Videl: ]=] end
		if which == [=[]=] then return [=[Videl: ]=] end
		return "..."
	end,
	answers = {
		{[=[Really? Wow...you seem like such a sweet, kind, loving girl. I'd expect you'd have company all the time. Wait...did I say 'sweet, kind and loving?' Hmm. You know, there's someone I think I'd like to introduce you to.]=], jump=[=[n0_g6_c_b]=], action=function(npc, player) player:partyWith({define_as="RACE_VIDEL", name="companion", level=1}) player.videl_state = 8 end, cond=function(npc, player) return arm_n0_g6_c(player) == [=[3]=] end},
		{[=[Really? You know...I just happen to have a friend who's in a similar situation. He lives on an island all by himself, and is absolutely dying for company.]=], jump=[=[n0_g6_c_c]=], action=function(npc, player) player:partyWith({define_as="RACE_VIDEL", name="companion", level=1}) player.videl_state = 8 end, cond=function(npc, player) return arm_n0_g6_c(player) == [=[4]=] end},
		{[=[Hmm...? Look, I'm not here to see you. I'm just exploring. Get over yourself.]=], jump=[=[n0_g6_c_d]=], action=function(npc, player) player.videl_state = 1 end, cond=function(npc, player) return arm_n0_g6_c(player) == [=[5]=] end},
		{[=[Really? That surprises me. You seem like a nice girl.]=], jump=[=[n0_g6_c_a]=], cond=function(npc, player) return arm_n0_g6_c(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g6_c_a]=],
	text = [=[Videl blushes and smiles.

]=] .. [=[Videl: ]=] .. [=[Thank you, but that's not always enough to compete with all the testosterone floating around here. I'm glad to finally have company who isn't here just to oogle over my father or beg for an autograph. It was a pleasure talking with you. Please do come again!

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g6_c_b = nil
local function arm_n0_g6_c_b(player)
	if shown_n0_g6_c_b ~= nil then return shown_n0_g6_c_b end
	player:partyWith({define_as="RACE_VIDEL", name="companion", level=1})
	player.videl_state = 8
	shown_n0_g6_c_b = [=[]=]
	return shown_n0_g6_c_b
end
newChat{ id=[=[n0_g6_c_b]=],
	text = function(npc, player)
		arm_n0_g6_c_b(player)
		return [=[Videl: ]=] .. [=[Really? That sounds wonderful! Yes, I'd be delighted to meet him. I'll follow you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g6_c_c = nil
local function arm_n0_g6_c_c(player)
	if shown_n0_g6_c_c ~= nil then return shown_n0_g6_c_c end
	player:partyWith({define_as="RACE_VIDEL", name="companion", level=1})
	player.videl_state = 8
	shown_n0_g6_c_c = [=[]=]
	return shown_n0_g6_c_c
end
newChat{ id=[=[n0_g6_c_c]=],
	text = function(npc, player)
		arm_n0_g6_c_c(player)
		return [=[Videl: ]=] .. [=[Really? That sounds wonderful! Yes, I'd be delighted to meet him. I'll follow you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g6_c_d = nil
local function arm_n0_g6_c_d(player)
	if shown_n0_g6_c_d ~= nil then return shown_n0_g6_c_d end
	player.videl_state = 1
	shown_n0_g6_c_d = [=[]=]
	return shown_n0_g6_c_d
end
newChat{ id=[=[n0_g6_c_d]=],
	text = function(npc, player)
		arm_n0_g6_c_d(player)
		return [=[Videl looks shocked...starts to say something but just looks at the ground instead. She then turns away, fighting back tears.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g6_d]=],
	text = [=[Videl: ]=] .. [=[...you...what? Me? I'm a nobody!

]=] .. [=[(Videl looks moderately panic-stricken but at the same time can't take her eyes off of yours. The look in her eyes faintly resembles that of a deer in headlights, but after a her moments she calms...and blinks a few times.)

]=] .. [=[Videl: ]=] .. [=[...you're...serious?

]=],
	answers = {
		{[=[Yes.]=], jump=[=[n0_g6_d_a]=]},
		{[=[No. I just wanted to get your hopes up so I could dash them on the floor and stomp on them.]=], jump=[=[n0_g6_d_b]=], action=function(npc, player) player.videl_state = 2 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g6_d_a]=],
	text = [=[Videl continues to stare at you blankly for a few moments. You hold her gaze, and you watch her soften, then smile...then, after a few moment...she begins to look extraordinarily hopeful.

]=] .. [=[Videl: ]=] .. [=[...I...wow. You're amazing. Just looking at you I feel so wonderful! Look...honestly I'm not ready to get married, and I'm still not certain I believe you anyway. But...I'd like to.

Unfortunately, it would never work. My father is an idiot. He won't even let me date, let alone marry anyone. He says that nobody is good enough for me, and he insists that to earn the right to date me, he first has to defeat my father in combat. Have you ever heard anything so ridculous? My father' been the Champion of the World Tournament for the past three years running! I'm only 17, but sometimes I think I'm going to die an old maid!

]=],
	answers = {
		{[=[Hmm. You're right. That's dumb. But...if it's what I have to do...I'll do it.]=], jump=[=[n0_g6_d_a_a]=], action=function(npc, player) player:takeQuest("videl_lonely", "taken") player.videl_state = 4 end},
		{[=[Wow, yeah...I guess that's too much for me. Sorry.]=], jump=[=[n0_g6_d_a_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g6_d_a_a = nil
local function arm_n0_g6_d_a_a(player)
	if shown_n0_g6_d_a_a ~= nil then return shown_n0_g6_d_a_a end
	player:takeQuest("videl_lonely", "taken")
	player.videl_state = 4
	shown_n0_g6_d_a_a = [=[]=]
	return shown_n0_g6_d_a_a
end
newChat{ id=[=[n0_g6_d_a_a]=],
	text = function(npc, player)
		arm_n0_g6_d_a_a(player)
		return [=[Videl smiles hopefully at you.

]=] .. [=[Videl: ]=] .. [=[He's in there. Training, as usual. Go on in. And...good luck. :)

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g6_d_a_b]=],
	text = [=[Videl: ]=] .. [=[I don't really blame you. Nobody else is brave enough to face him, either. Still...thanks for being attracted to me. Please come visit me again sometime.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g6_d_b = nil
local function arm_n0_g6_d_b(player)
	if shown_n0_g6_d_b ~= nil then return shown_n0_g6_d_b end
	player.videl_state = 2
	shown_n0_g6_d_b = [=[]=]
	return shown_n0_g6_d_b
end
newChat{ id=[=[n0_g6_d_b]=],
	text = function(npc, player)
		arm_n0_g6_d_b(player)
		return [=[Videl's mouth drops for a few moments, and she begins to fight back tears. She stares at the ground and turns away, without speaking.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g6_e = nil
local function arm_n0_g6_e(player)
	if shown_n0_g6_e ~= nil then return shown_n0_g6_e end
	player.videl_state = 2
	shown_n0_g6_e = [=[]=]
	return shown_n0_g6_e
end
newChat{ id=[=[n0_g6_e]=],
	text = function(npc, player)
		arm_n0_g6_e(player)
		return [=[Videl: ]=] .. [=[Eeek! Daddy! Help!]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g6_f]=],
	text = function(npc, player)
		return [=[Videl: ]=] .. [=[Why thank you, ]=] .. (player.name or "you") .. [=[! Your friendship really means a lot to me. :)

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
