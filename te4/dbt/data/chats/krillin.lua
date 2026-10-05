-- dialogue.KRILLAN, through the offer to save the temple. He does not come with you.

local function takeQuest(player)
	player.krillan_state = 2
	player.temple_key = 1
	player:ensureQuests()
	player.quests.temple = {
		name = "Save the Temple",
		desc = "Krillan locked the invaders in the catacombs with the Abbot. The key opens the door at the east end of the hall. Rescue the Abbot.",
		status = "taken",
	}
	game.log("Krillan gives you the key to the catacombs.")
end

newChat{ id="welcome",
	text = function(npc, player)
		if (player.krillan_state or 0) == 1 then
			return [[Hello again! Have you decided to save the Temple?]]
		end
		if (player.krillan_state or 0) >= 2 then
			local q = player.quests and player.quests.temple
			if q and (q.status == "completed" or q.status == "finished") then
				return [[Hello, again. Has the Abbot been rescued?

Thank you. I knew you could do it.]]
			end
			return [[Hello, again. Has the Abbot been rescued?

Please hurry!]]
		end
		return [[Thank goodness help has arrived! Thank you so much for coming!

...you're welcome?

We had no idea how long we would remain hostage here. It was terrible!]]
	end,
	answers = {
		{"What are you talking about? This is a Buddhist Temple, isn't it?", jump="taoists",
			cond=function(npc, player) return (player.krillan_state or 0) == 0 end},
		{"Uhh...I just came here for training. If there's a hostage situation, I think I'll just leave.",
			cond=function(npc, player) return (player.krillan_state or 0) == 0 end},
		{"Yes.", jump="key", cond=function(npc, player) return (player.krillan_state or 0) == 1 end},
		{"No.", cond=function(npc, player) return (player.krillan_state or 0) == 1 end},
		{"Not yet.", cond=function(npc, player)
			local q = player.quests and player.quests.temple
			return (player.krillan_state or 0) >= 2 and not (q and (q.status == "completed" or q.status == "finished"))
		end},
		{"Leave."},
	},
}

newChat{ id="taoists",
	text = [[Yes! But several days ago a large group of rival Taoists came and locked our Abbot in the basement! It's terrible I tell you!

...umm...'rival Taoists?' That doesn't seem very plausible.

Well, ordinarily no, but they had help! Several monks of the Temple were corrupted by their philosophy and helped them!

I'm not buying this. Seriously...Buddhist monks are universally renowed for their fighting prowness. Taoist philosophy is about feminine passivity and acceptance.

Oh...that's right. I sort of forgot about that. Maybe they aren't Taoists.

You think?

I think you're confusing Buddhist monks with Shaolin monks though. Buddhism is also largely about acceptance of the world.

You don't train the martial arts here?

Of course we do! I just mean...in general.

Right. Well, look at it this way...do you want my help or not?

Oh! Yes! Please!

Ok. So explain to me what's going on.

Several days ago a large group of people arrived. They all wore robes and many of them carried martial arts weapons. Fearing trouble, we locked the gates and our Abbot and our highest ranking priests all went into private meditation, and requested that they be locked into their rooms until the situation was resolved. As soon as they did, several of our monks revealed that they were taking over the Temple, and let the invaders in.

When I realized what was going on, I played along. I told them about my secret stash of porno magazines in the lower levels. They all went downstairs to cleanse the Temple, and I locked the door behind them.

So that's the story. Will you help?]],
	answers = {
		{"Yes. This is too weird to turn down.", jump="key"},
		{"No. Obviously this is all a lesson for you. It would be wrong for me to interfere.", jump="lesson"},
	},
}

newChat{ id="key",
	text = [[Thank you so much! The entrance to the catacombs is at the end of the corridor to the east. Follow it around and you'll come to a door and stairs. Here's the key.

Wait...I'm about to go off and fight a horde of invaders, I'm rescuing you, your temple, and your Abbot...and you don't plan on helping?

What? Me? Help? But...I...umm...shouldn't I stay here to guard the, umm...guard the...oh! Sacred treasures! Yes! I should guard the sacred treasures. Definitely.]],
	answers = {
		{"Yeah, ok. You just stay here and I'll go deal with it. Silly monk.", action=takeQuest},
	},
}

newChat{ id="lesson",
	text = [[Hmm. Yes, I thought you might say that.]],
	answers = { {"Leave.", action=function(npc, player) player.krillan_state = 1 end} },
}

return "welcome"
