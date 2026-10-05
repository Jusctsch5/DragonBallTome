-- dialogue.URANAI_BABA. The attack line needs alignment, which is not tracked yet.
-- The Rosshi-student lines wait until karin_hole is 2.

local function questStory(player)
	player.uranai_state = 2
	player:ensureQuests()
	local q = player.quests.tentacle_demon
	if not q or q.status == "untaken" then
		player.quests.tentacle_demon = {
			name = "The thing in the basement",
			desc = "Uranai Baba spilled lizard soup into a summoning. A tentacle demon took her stirring staff and is still in the basement. Get rid of it and she will let you keep the Nyoi-bo.",
			status = "taken",
		}
	end
	if game.openUranaiBasement then game:openUranaiBasement() end
end

newChat{ id="welcome",
	text = [[Go away! I've had a lousy day and I don't feel like having uninvited guests!]],
	answers = {
		{"Oh. Sorry. (leave)"},
		{"I'm a student of Rosshi's. He suggested I come see you.", jump="student", cond=function(npc, player) return (player.karin_hole or 0) == 2 end},
		{"(Persuade 20) I know what you mean! Stupid idiots showing up uninvited all the time! I just hate it when people do that!", jump="persuade1", cond=function(npc, player) return player.effStat and player:effStat("chr") >= 20 end},
		{"You've had a lousy day? Oh, well then let me put an end to it for you. (attack)", jump="attack", cond=function(npc, player) return (player.alignment or 0) < 0 end},
	},
}

newChat{ id="student",
	text = [[Oh, did he now? I suppose my little baby brother is too proud to apologize himself, so he's sent you to do it for him?]],
	answers = {
		{"No, actually I was hoping I could convince you to give me the Nyoi-bo, so I can use it to talk to Kami", jump="nyoibo"},
		{"Umm...yes. He apologizes.", jump="apology_start"},
	},
}

newChat{ id="nyoibo",
	text = [[Oh, really? Why should I do that?

You want to speak to Kami? That sounds like a personal problem to me, and I have a rather large one of my own at the moment.]],
	answers = {
		{"What's that?", jump="story"},
	},
}

newChat{ id="apology_start",
	text = [[Oooohhhh...? Does he now? Well...how DARE he have someone else apologize for him! You go back to him right now and tell him that he'd better apologize himself, here, personally!

Hmph.]],
	answers = {
		{"Leave.", action=function(npc, player) player.rosshi_uranai_apology = 1 end},
	},
}

newChat{ id="persuade1",
	text = [[Yes, it's awful! They come in uninvited, they interupt during dinner, they ignore the warning sign and barge in anyway!]],
	answers = {
		{"And you know who's worst? Adventurers!", jump="persuade2"},
	},
}

newChat{ id="persuade2",
	text = [[Oh, absolutely! I detest adventurers! Constantly whining for quests, and demanding rewards!]],
	answers = {
		{"Yeah, can you believe the gall? I hate them too! Well, they're actually not bad with catsup, but otherwise, yes.", jump="persuade3"},
	},
}

newChat{ id="persuade3",
	text = [[Catsup? I'll have to try that. Say...we sure seem to see eye to eye about a lot of things. I wonder if you could do me a favor?]],
	answers = {
		{"What's that?", jump="persuade4"},
	},
}

newChat{ id="persuade4",
	text = [[Well, it's kind of a long story...]],
	answers = {
		{"Go on.", jump="story_persuade"},
	},
}

newChat{ id="story",
	text = [[I was trying to conjure up some minor tentacle demons recently for...well, for my own reasons, and unfortunately I acidentally spilled some lizard soup into my cauldron, and it sort of botched the spell.

'Sort of?'

Well, the critters I ended up with weren't quite the critters I wanted. First I noticed there was a problem was when a tentacle came out and grabbed the staff I was stirring with and yanked it from my grasp. Then about a thousand pounds of slithering stuff crawled out, and generallly ran amuck with my floral print tapestries. It's been in the basement ever since.

That doesn't sound so good.

It's not. Fortunately there's nothing down in the basement I really need, but hideous, tentacled demonic beasts aren't really the sort of thing you want lurking around, you know? I'll make you a deal. If you can get rid of that thing for me, I'll let you have the Nyoi-bo.

You won't need it to stir your cauldron anymore?

Not after this, I won't.]],
	answers = {
		{"I'll see what I can do.", action=function(npc, player) questStory(player) end},
	},
}

newChat{ id="story_persuade",
	text = [[I was trying to conjure up some minor tentacle demons recently for...well, for my own reasons, and unfortunately I acidentally spilled some lizard soup into my cauldron, and it sort of botched the spell.

'Sort of?'

Well, the critters I ended up with weren't quite the critters I wanted. First I noticed there was a problem was when a tentacle came out and grabbed the staff I was stirring with and yanked it from my grasp. Then about a thousand pounds of slithering stuff crawled out, and generallly ran amuck with my floral print tapestries. It's been in the basement ever since.

That doesn't sound so good.

It's not. Fortunately there's nothing down in the basement I really need, but hideous, tentacled demonic beasts aren't really the sort of thing you want lurking around, you know? I'll make you a deal. If you can get rid of that thing for me, I'll let you have the Nyoi-bo.

You won't need it to stir your cauldron anymore?

Not after this, I won't.

Yeah, I suppose I could look into that for you. But it sounds an awful lot like a quest.

Yes, I suppose it is. Still, I'd feel a lot better if you were to do it than one of those horrible adventurers who are constantly showing up at my door.]],
	answers = {
		{"I can understand that. Ok, I'll look into it.", action=function(npc, player) questStory(player) end},
	},
}

newChat{ id="attack",
	text = [[Hehe...good, watching the flesh be ripped from your bones will help me feel better.]],
	answers = {
		{"...", action=function(npc, player)
			player.uranai_state = 9
			npc.faction = "enemies"
			npc.ai = "simple"
			npc.ai_state = npc.ai_state or { talent_in = 3 }
			npc.never_move = false
		end},
	},
}

newChat{ id="working",
	text = [[It's still down there. I can smell it.]],
	answers = {
		{"Leave."},
	},
}

newChat{ id="slain",
	text = [[You got rid of the demon! Very good! You may keep the Nyoi-bo, like we agreed. In case you haven't figured it out already, the command to use the Nyoi-bo is 'u'. Experiment with it. You're sure to find it useful.]],
	answers = {
		{"Thanks.", action=function(npc, player)
			player.uranai_state = 8
			player:ensureQuests()
			local q = player.quests.tentacle_demon
			if q then q.status = "finished" end
			if game.giveNyoibo then game:giveNyoibo(player) end
		end},
	},
}

newChat{ id="done",
	text = [[Hello again.]],
	answers = {
		{"Hello."},
	},
}

newChat{ id="hostile",
	text = [[Hahaha!!! Die!]],
	answers = {
		{"...", action=function(npc, player)
			npc.faction = "enemies"
			npc.ai = "simple"
			npc.never_move = false
		end},
	},
}

newChat{ id="apology1",
	text = [[Go on! Go bring back Rosshi so he can apologize personally! I'm not wasting my time with a student!]],
	answers = {{"Leave."}},
}

newChat{ id="apology2",
	text = [[So where's my brother?

Ha! He forgot already! Why am I not surprised? Tell him that I'm the older one, and he's not allowed to go senile before me!

I don't care! Just tell him!]],
	answers = {
		{"Leave.", action=function(npc, player) player.rosshi_uranai_apology = 3 end},
	},
}

newChat{ id="apology3",
	text = [[What are you doing here? Don't tell me you've gone senile too! Go tell Rosshi that I'm his older sister and he's not allowed to go senile before I am!]],
	answers = {{"Leave."}},
}

newChat{ id="apology4",
	text = [[Well? What did he say?

He WHAT!?!?! He threw out that pie! What an ungrateful toad! Why, I should run right over there and turn him into one!

Of course it would! It would help me feel better! You go tell that fetid son of a worm that he's no better than the cochroach reared on the toe jelly on a corpse louse!

I have no desire to speak to that lumbering tankard of horse snot!]],
	answers = {
		{"Leave.", action=function(npc, player) player.rosshi_uranai_apology = 5 end},
	},
}

newChat{ id="apology5",
	text = [[What are you doing back here? I don't want to talk to you either!]],
	answers = {{"Leave."}},
}

newChat{ id="apology6",
	text = [[Go away! I don't want to talk to any student of my rapscalions' turd of a brother!

...he...what?

...why...he did...what...?

But that's what he called me when we were little!!! Oh! How adorable! Goodness, that does bring back some powerful memories. He really called me 'Sissy?'

That's so sweet of him! Why, that brings tears to my eyes. That's my little brother, Foozy, and I'm his big sister, Sissy!

That's what I called him when we were little. Go tell him that I forgive him, and that I love him.

I said go tell him!!!! RIGHT NOW, or I'll turn you into a hermaphroditic llama!]],
	answers = {
		{"Leave.", action=function(npc, player) player.rosshi_uranai_apology = 7 end},
	},
}

newChat{ id="apology7",
	text = [[Well? Go tell Foozy that I forgive and that I love him! Or else!]],
	answers = {{"Leave."}},
}

newChat{ id="apology8",
	text = [[Well, I feel much better now. Almost makes up for the monsters in my basement.

I did mention that I was having a bad day, didn't I?]],
	answers = {
		{"You have monsters in your basement?", jump="story", action=function(npc, player) player.rosshi_uranai_apology = 9 end},
	},
}

player.uranai_state = player.uranai_state or 0
player.rosshi_uranai_apology = player.rosshi_uranai_apology or 0
local rua = player.rosshi_uranai_apology
local state = player.uranai_state
if rua > 0 and rua < 8 and state ~= 2 and state ~= 8 then
	return "apology"..rua
end
if rua == 8 and state ~= 2 and state ~= 8 then
	return "apology8"
end
if state == 9 then return "hostile" end
if state == 8 then return "done" end
if state == 2 then
	local q = player.quests and player.quests.tentacle_demon
	if q and (q.status == "slain" or q.status == "finished") then
		if q.status == "finished" then return "done" end
		return "slain"
	end
	return "working"
end
return "welcome"
