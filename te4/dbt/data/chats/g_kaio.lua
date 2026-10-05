-- dbt-generated-talk dialogue.KAIO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.kaio_state or 0) == 0 then
		player.kaio_state = 1
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.kaio_state or 0) == 1 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.kaio_state or 0) == 2 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.kaio_state or 0) == 3 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.kaio_state or 0) == 4 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.kaio_state or 0) == 5 then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.kaio_state or 0) == 999 then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	if (player.quests and player.quests.kami_to_kaio and player.quests.kami_to_kaio.status == "taken") then
		player:takeQuest("kami_to_kaio", "finished")
		shown_n0 = [=[8]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The North Kaio: ]=] .. [=[Well, hello! 

]=] end
		if which == [=[2]=] then return [=[The North Kaio: ]=] .. [=[Well? Do you have a good joke for me yet?

]=] end
		if which == [=[3]=] then return [=[The North Kaio: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[! What brings you back to my world?

]=] end
		if which == [=[4]=] then return [=[...]=] end
		if which == [=[5]=] then return [=[The North Kaio: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[! What brings you back to my world?

]=] end
		if which == [=[6]=] then return [=[...]=] end
		if which == [=[7]=] then return [=[...]=] end
		if which == [=[8]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{[=[Who are you? What is this place?]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Just visiting.]=], jump=[=[n0_g2_a]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[I'd like to train with you more, Kaio-sama!]=], jump=[=[n0_g2_b]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[Just visiting.]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[I'd like to train with you more, Kaio-sama!]=], jump=[=[n0_g4_b]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a]=],
	text = function(npc, player)
		return [=[The North Kaio: ]=] .. [=[You want to train? I'm sorry, I don't have any trains. You'll have to try somewhere else.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...umm, no. I meant...

]=] .. [=[The North Kaio: ]=] .. [=[Hahahah!!! It's a joke! Get it?!?!? :)

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...umm. Yeah. 'Train.'

]=] .. [=[The North Kaio: ]=] .. [=[Hmph. You don't have much of a sense of humor, do you?

]=] .. [=[The North Kaio: ]=] .. [=[Well, I absolutely refuse to train anyone without a good sense of humor. So if you want to train with me, you'll have to make me laugh first.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...what? Are you serious? I kind of went to a lot of trouble to come here.

]=] .. [=[The North Kaio: ]=] .. [=[Absolutely! Now, tell me a joke. Make it a good one!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = function(npc, player)
		return [=[The North Kaio: ]=] .. [=[I'm Overseer of the Northern quadrant of this galaxy. No need to stand on ceremony, though. I don't bite. Call me 'Kai.'

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Nice to meet you, Kai. I'm ]=] .. (player.name or "you") .. [=[.

]=] .. [=[The North Kaio: ]=] .. [=[It's a little strange to have a guest who doesn't already know about me. I'm guessing you're an adventurer?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes.

]=] .. [=[The North Kaio: ]=] .. [=[Ahhh...well, that explains it, then. Usually people who come here are here to train. 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Train? You're a trainer?

]=] .. [=[The North Kaio: ]=] .. [=[Me? No, I'm a Kaio. Hahahahah!!! Get it? Trainer? Kaio?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...umm...huh?

]=] .. [=[The North Kaio: ]=] .. [=[Hmph. You don't have much of a sense of humor, do you?

]=] .. [=[The North Kaio: ]=] .. [=[...uhh, I'm sorry. Did you tell a joke? I guess I...missed it.

]=] .. [=[The North Kaio: ]=] .. [=[Wow. No sense of humor whatsoever. Well, that's not so good. Because I have a steadfast rule: I don't train anyone unless they can make me laugh.

]=] .. [=[The North Kaio: ]=] .. [=[Make you laugh?

]=] .. [=[The North Kaio: ]=] .. [=[Yep! So, know any good jokes?

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c = nil
local function arm_n0_g0_c(player)
	if shown_n0_g0_c ~= nil then return shown_n0_g0_c end
	player.kaio_state = 2
	shown_n0_g0_c = [=[]=]
	return shown_n0_g0_c
end
newChat{ id=[=[n0_g0_c]=],
	text = function(npc, player)
		arm_n0_g0_c(player)
		return [=[The North Kaio: ]=] .. [=[Oh! You're a friend of Karin's?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes. I've trained with him. He said I should visit you sometime. Maybe challenge you to a game of chess.

]=] .. [=[The North Kaio: ]=] .. [=[...chess?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes. He said you're quite fond of the game.

]=] .. [=[The Kaio stares at you in shock...then his antennae twitch and a smile starts to creep across his face.

]=] .. [=[The North Kaio: ]=] .. [=[Hahahahahhahahaha!!! Chess! Me? Hahahahah!!!! Oh, I love it! That's the best joke I've heard in weeks! Oh...you really have to hand it to Karin, he's really the funniest cat I've ever met!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[You don't play chess?

]=] .. [=[The North Kaio: ]=] .. [=[Hahahahahhahahaha!!! No, of course not! It would be painfully easy, being a telepath, and all. I'd always know what my opponent was planning. It's bad enough knowing how to read moves when fighting, but I can only imagine how it would be in chess.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Huh. Yeah, I guess that makes sense. Say, you're a fighter then, right? Would you teach me?

]=] .. [=[The North Kaio: ]=] .. [=[Sure! Anyone with a sense of humor like yours really deserves my training.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[That's terrific! Thank you! When can we start?

]=] .. [=[The North Kaio: ]=] .. [=[How about right now?

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g2_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g2_c = nil
local function arm_n0_g2_c(player)
	if shown_n0_g2_c ~= nil then return shown_n0_g2_c end
	player:takeQuest("kaio_bubbles", "taken")
	player.kaio_state = 3
	shown_n0_g2_c = [=[]=]
	return shown_n0_g2_c
end
newChat{ id=[=[n0_g2_c]=],
	text = function(npc, player)
		arm_n0_g2_c(player)
		return [=[The North Kaio: ]=] .. [=[There's certainly more I could teach you, but I'm afraid you're being limited by the low gravity you're used to on earth. Your phsyical body has to channel your chi, and your body isn't strong enough to progress past the next level.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[So what can we do?

]=] .. [=[The North Kaio: ]=] .. [=[All you can do is strengthen your body. Me and Bubbles are used to the gravity here. It's time for you to get used to it, too.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Bubbles?

]=] .. [=[The North Kaio: ]=] .. [=[My pet monkey. Go ahead. Run around, and try to catch him. I think by the time you're able to you'll be accustumed to the gravity well enough that I can train you more.

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

newChat{ id=[=[n0_g4_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_c = nil
local function arm_n0_g4_c(player)
	if shown_n0_g4_c ~= nil then return shown_n0_g4_c end
	player:takeQuest("kaio_gregory", "taken")
	player.kaio_state = 5
	shown_n0_g4_c = [=[]=]
	return shown_n0_g4_c
end
newChat{ id=[=[n0_g4_c]=],
	text = function(npc, player)
		arm_n0_g4_c(player)
		return [=[The North Kaio: ]=] .. [=[Well, once again, there's certainly more I could teach you, but you're still being limited by your body. The training you did with Bubbles helped considerably, but you were only moving around your own body. Maybe if we put some weights on you...oh! I know.

]=] .. [=[Gregory!

]=] .. [=[Gregory: ]=] .. [=[Yes, Kaio-sama?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Whoa! Where did that voice coem from?

]=] .. [=[Gregory: ]=] .. [=[From me! I'm right here. Up HERE. I'm sitting on your head.

]=] .. [=[The North Kaio: ]=] .. [=[Gregory is in insect. A very strong one, I might add.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Oh. Nice to meet you, Gregory.

]=] .. [=[The North Kaio: ]=] .. [=[We'll do a repeat of your last excercise, but this time you'll be chasing Gregory. And to make it more difficult, rather than simply catching him...you'll have to hit him with this hammer. It weighs ]=] .. [=[ pounds. That should slow you down, some.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[ pounds?!?! But won't Gregory get hurt?

]=] .. [=[Gregory: ]=] .. [=[Ha! Not on your life. But it's not like you're ever going to catch me anyway. I'm too fast for you.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Really? Well, we'll see about that!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
