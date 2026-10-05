-- dialogue.SPLINTER, the first meeting and the origin story.
-- The kill order and the theft questions wait on quests that are not in the game yet.

local function openTraining(player)
	player.splinter_state = 2
	game:loadTraining()
	local Trainer = require "mod.dialogs.Trainer"
	game:registerDialog(Trainer.new("SPLINTER", player))
end

newChat{ id="welcome",
	text = [[Greetings, my child. Welcome to our hidden home below the ground.]],
	answers = {
		{"Hello. My name is #{bold}#"..((game.player and game.player.name) or "someone").."#{normal}#. Who are you?", jump="named",
			cond=function(npc, player) return player:effStat("chr") > 9 end},
		{"Umm...what are you?", jump="low",
			cond=function(npc, player) return player:effStat("chr") <= 9 end},
	},
}

newChat{ id="named",
	text = [[Welcome. As you are the first from above to find our sacred training hall, I believe it is fate that has brought you here.

#{italic}#Michaelangelo:#{normal}# Whoa! Fate! That's totally awesome!

Sacred training hall? What do you train?

#{italic}#Leonardo:#{normal}# Ninjutsu!

The art of invisibility.]],
	answers = {
		{"Wow! You can turn invisible?", jump="unseen", action=function(npc, player) player.splinter_state = 1 end},
	},
}

newChat{ id="unseen",
	text = [[#{italic}#Raphael:#{normal}# Heh. Not so bright.

Raphael! Be courteous to our guest!

#{italic}#Raphael:#{normal}# ...ok. Sorry.

#{italic}#Michaelangelo:#{normal}# Hehe...Raphie wiped out!

The art of ninja, is the art of being unseen. When mind, heart, and body work together as one, anything is possible.

#{italic}#Michaelangelo:#{normal}# Dude, all this talking is making me hungry. I think I'm gonna order some pizza.

Only through this union can the spirit be as one.

#{italic}#Donatello:#{normal}# I want mushroom and pepperoni on mine!

#{italic}#Michaelangelo:#{normal}# I'm on it!]],
	answers = {
		{"Well, it's been a pleasure to have met the five of you. I'm sure I'll be seeing you...or 'not' seeing you, again.", jump="bye"},
		{"I don't mean to be rude, but what exactly are you?", jump="story",
			cond=function(npc, player) return (player.splinter_story or 0) == 0 end},
		{"(Persuade 16) You say it is fate that brought me here. And I agree. I have been brought here to train with you.", jump="accepted",
			cond=function(npc, player) return player:effStat("chr") >= 16 end},
		{"May I train with you?", jump="refused",
			cond=function(npc, player) return player:effStat("chr") < 16 end},
	},
}

newChat{ id="low",
	text = [[Do not be surprised by our form. Yes, you are speaking to a rat.]],
	answers = {
		{"...go on.", jump="story", action=function(npc, player) player.splinter_state = 1 end},
	},
}

newChat{ id="story",
	text = [[Yes, perhaps I should tell you the tale of how we came to be here. Many years ago I was a rat of ordinary size. The pet, of the Ninja Master Hamato Yoshi. My cage was kept in his training hall, and from my earliest years I watched Master Yoshi during his training sessions.

Seven years ago, Master Yoshi was assassinated in his home by the leader of a rival ninja clan known as The Foot. During the fight, my cage was broken, and I was freed. For days I wandered alone, and hungry, until I came here to these sewers. It was here that I found four baby turtles crawling in a strange, glowing ooze from a broken canister.

#{italic}#Michaelangelo:#{normal}# That was us!

But, strangely, over the days that followed, all five of us began to change...to grow. Both in size, as well as intellect. I do not know what brought about our change, but fate is not to be frowned upon. And so, I began training the turtles you see here before you in the art of Ninja. We have made a home for ourselves here in these sewers, venturing up to the surface only on occassion.]],
	answers = {
		{"Thank you for telling me.", action=function(npc, player)
			player.splinter_story = 1
			player.splinter_state = math.max(1, player.splinter_state or 0)
		end},
	},
}

newChat{ id="accepted",
	text = [[#{italic}#Leonardo:#{normal}# We're going to have new training parter!

#{italic}#Michaelangelo:#{normal}# Awesome!

It seems my students have taken a liking to you. Very well. You may study with us.]],
	answers = {
		{"I'll learn what you can teach.", action=function(npc, player) openTraining(player) end},
	},
}

newChat{ id="refused",
	text = [[No. Not at this time. I am dedicated to my current pupils, and they are not ready to ontinue on their own without my undivided attention.

#{italic}#Raphael:#{normal}# Yeah. We don't need some new ]]..( (game.player and (game.player.female or (game.player.descriptor and game.player.descriptor.sex == "Female"))) and "girl" or "guy" )..[[ messin' with our training.

#{italic}#Michaelangelo:#{normal}# Dude...but it would be so awesome to have a new sparring partner!

Perhaps in the future. But not now, my child.]],
	answers = {
		{"Leave.", action=function(npc, player) player.splinter_state = math.max(1, player.splinter_state or 0) end},
	},
}

newChat{ id="again",
	text = [[Hello again. What brings you once again to our hidden home?]],
	answers = {
		{"Just visiting.", jump="bye"},
		{"Curiosity. I don't mean to be rude, but what exactly are you?", jump="story",
			cond=function(npc, player) return (player.splinter_story or 0) == 0 end},
		{"(Persuade 16) I have been brought here to train with you.", jump="accepted",
			cond=function(npc, player) return (player.splinter_state or 0) < 2 and player:effStat("chr") >= 16 end},
		{"May I train with you?", jump="refused",
			cond=function(npc, player) return (player.splinter_state or 0) < 2 and player:effStat("chr") < 16 end},
	},
}

newChat{ id="pupil",
	text = [[Welcome, my pupil. Have you come for more training?]],
	answers = {
		{"No, I was just in the area and thought I'd say hello.", jump="hello_pupil"},
		{"Yes, please.", action=function(npc, player) openTraining(player) end},
		{"Would you tell me how the five of you came to be here?", jump="story",
			cond=function(npc, player) return (player.splinter_story or 0) == 0 end},
	},
}

newChat{ id="hello_pupil",
	text = [[You company is most welome.]],
	answers = {
		{"Leave."},
	},
}

newChat{ id="bye",
	text = [[Indeed. Take care, my child.]],
	answers = {
		{"Leave.", action=function(npc, player) player.splinter_state = math.max(1, player.splinter_state or 0) end},
	},
}

local state = game.player and game.player.splinter_state or 0
if state >= 2 then return "pupil"
elseif state >= 1 then return "again"
else return "welcome" end
