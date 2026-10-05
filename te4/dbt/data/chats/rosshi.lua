-- dialogue.ROSSHI. The female lessons and the television argument are the paths that enroll him.
-- Finding him a girl to keep is recorded, and it waits on someone who can actually stay.

local function female(player)
	return player.female or (player.descriptor and player.descriptor.sex == "Female")
end

local function hasPorn(player)
	local inven = player:getInven(player.INVEN_INVEN)
	if not inven then return false end
	for _, o in ipairs(inven) do
		if o.define_as == "PORNO_MAGAZINE" then return true end
	end
	return false
end

local function takePorn(player)
	local inven = player:getInven(player.INVEN_INVEN)
	if not inven then return end
	for i, o in ipairs(inven) do
		if o.define_as == "PORNO_MAGAZINE" then
			player:removeObject(player.INVEN_INVEN, i)
			return
		end
	end
end

local function openTraining(player)
	player.rosshi_student = true
	if (player.rosshi_shells or 0) < 1 then
		player.rosshi_shells = 1
		local o = game:cloneStock("TURTLE_SHELL")
		if o then
			o:resolve()
			o:resolve(nil, true)
			player:addObject(player.INVEN_INVEN, o)
			game.log("Master Rosshi gives you a turtle shell. It weighs fifty pounds.")
		end
	end
	game:loadTraining()
	local Trainer = require "mod.dialogs.Trainer"
	game:registerDialog(Trainer.new("ROSSHI", player))
end

newChat{ id="welcome",
	text = function(npc, player)
		player.rosshi_tv_open = player.rosshi_from_tv and true or false
		player.rosshi_from_tv = nil
		if player.crane_student then
			return [[Well, well, well! If it isn't the student of my rival. Come to do a little spying for that Crane bozo, Tsuru-what's-his-name? Well, I don't mind. But don't expect to get anything useful out of your visit.]]
		end
		if player.rosshi_student then
			return [[Hmm. Your form is better during practice.]]
		end
		if (player.rosshi_tv_open or player.rosshi_from_tv) and not female(player) then
			return [[Hey! Don't stand in the way of the television! I'm watching this.

Sorry. I couldn't seem to get your attention otherwise.

It's not like I didn't notice you. I just didn't want to talk. Who are you anyway, and what are you doing in my house?

I think I recognize you. You're Rosshi, aren't you? 'Master' Rosshi? The famous martial arts master?

So what if I am? I'm retired. Go away!]]
		end
		if female(player) then
			return [[Well, hello beautiful! What brings a luscious lady like yourself to my little island retreat?]]
		end
		return [[Master Rosshi is focused intently on a women's aerobics video on the television.

Hmm? Go away. Can't you see I'm busy?]]
	end,
	answers = {
		{"Train me.", action=openTraining, cond=function(npc, player) return player.rosshi_student end},
		{"You're Master Rosshi, right? You're a renowned martial artist, and I was hoping you could teach me a few special techniques.", jump="pumpkin",
			cond=function(npc, player) return female(player) and not player.rosshi_student and not player.crane_student end},
		{"Oh, just passing through.", jump="passing",
			cond=function(npc, player) return female(player) and not player.rosshi_student and not player.crane_student end},
		{"(Persuade 14) I just had to see the great master in person! Wow! You're even cuter than your headshots!", jump="cute",
			cond=function(npc, player) return female(player) and not player.rosshi_student and not player.crane_student and player:effStat("chr") >= 14 end},
		{"Is there anything I could do to convince you to take a student? Even just a few lessons?", jump="convince",
			cond=function(npc, player) return (player.rosshi_from_tv or player.rosshi_tv_open) and not female(player) and not player.rosshi_student and not player.crane_student end},
		{"Sorry, I was just exploring the area. I'm an adventurer. We tend do to that sort of thing.", jump="explorer",
			cond=function(npc, player) return (player.rosshi_from_tv or player.rosshi_tv_open) and not female(player) and not player.rosshi_student end},
		{"Leave."},
	},
}

newChat{ id="pumpkin",
	text = [[Well, pumpkin...I'm sure I could...but what's in it for me?

(You're not altogether certain you like the way he's looking you up and down.)]],
	answers = {
		{"Umm...I don't know. What do you want?", jump="peek"},
		{"(Persuade 16) Pumpkin?!?!?! That's so adorable! My grandfather used to call me that! Wow! You remind me of him! (Act untouchably innocent)", jump="innocent",
			cond=function(npc, player) return player:effStat("chr") >= 16 end},
	},
}

newChat{ id="peek",
	text = [[What do I want? Hmm...let me see...what do I want...

He starts sliding his cane up the inside of your thighs to lift your skirt. You instinctively bat his cane away and give him a dirty look.

Oh...come on. All I want's a quick peek.]],
	answers = {
		{"No! Are you some kind of pervert or something!?!?!", jump="prude"},
	},
}

newChat{ id="prude",
	text = [[What...are you some kind of prude? I thought you wanted you take some lessons with me. I must have misunderstood. Oh well. Do come again!]],
	answers = { {"Leave."} },
}

newChat{ id="innocent",
	text = [[Rosshi looks shocked for a moment...then disappointed...but finally he can't help but smile.

Hehehe...well, I've never been anyone's grandfather before. My daughter never had children. So you want to train with me? You know...now that I think about it, it sure would be nice to have some company. I get kind of lonely with just me and Umigame all the time. Ok. I'll do it!]],
	answers = { {"Thank you.", action=openTraining} },
}

newChat{ id="passing",
	text = [[Really? How delightful! I have company so rarely, it really is a delight to have you here. Stay as long as you'd like!]],
	answers = { {"Thanks."} },
}

newChat{ id="cute",
	text = [[Really? Wow...this is nothing. You should see me when I'm working out. Hey...you study martial arts, right? How'd you like to work out with me?]],
	answers = {
		{"With you? Definately!", action=openTraining},
		{"Maybe later, hot stuff.", jump="later"},
	},
}

newChat{ id="later",
	text = [[Just name the time!]],
	answers = { {"I will."} },
}

newChat{ id="explorer",
	text = [[Ehh? Yeah, I know the type. Go away and don't come back.]],
	answers = { {"Leave."} },
}

newChat{ id="convince",
	text = [[Not unless you have a cute younger sister you'd like to sell into domestic slavery. Your mother, maybe? Grandmother? I'm not picky.

...'domestic' slavery? Have you tried prostitutes?

Don't be so vulgar. I'm too old and dignified for that sort of thing. I just want to see some cute young thing from time to time. It's good for liver function.

...right. Liver function. And the aerobics videos are your only way of getting that, huh?

Hmph. If you're quite through, I'm a busy man. I'm sure you can find your way to the door.]],
	answers = {
		{"Ok. I'll leave. Sorry to trouble you."},
		{"What if I can find a nice domestic type of girl who'd be willing to stay here to cook and clean. That sort of thing?", jump="lonely"},
		{"Well, since you don't need to touch, you just want to see...I happen to have some nice magazines on me...", jump="magazine",
			cond=function(npc, player) return hasPorn(player) end},
	},
}

newChat{ id="lonely",
	text = [[A nice, cute young girl?

Yes.

With big boobs?

Yes.

Maybe...cute and young, but not so nice?

Sure. That will probably be easier to find anyway.

Done. Bring a girl like that to stay here with me, and I'll train you all you want.]],
	answers = {
		{"I'll look.", action=function(npc, player)
			player:ensureQuests()
			player.rosshi_state = 2
			player.quests.rosshi_lonely = {
				name = "Lonely Master",
				desc = "Master Rosshi will train you if you bring a girl to stay at Kame House and keep him company.",
				status = "taken",
			}
		end},
	},
}

newChat{ id="magazine",
	text = [[What!??! You have a nasty, filthy, disguting porno sex magazine with you? You DARE to bring something like that into the house of the great Master Rosshi?!!?]],
	answers = {
		{"Umm...no. I wouldn't do such a thing. It's really quite a tasteful magazine.", jump="tasteful"},
		{"Yep. Cosplay girls, tentacle rape, bukake...you name it, it's in here. You want it or not?", jump="deal"},
	},
}

newChat{ id="tasteful",
	text = [[Oh. Then I'm not interested. Get out of here before I thrown you out and then have to spend my evening patching up the hole in the wall.

But...I really want you to train me.

And I really want to have some female companionship. You go find some for me, and I'll train you.]],
	answers = {
		{"I'll look.", action=function(npc, player)
			player:ensureQuests()
			player.rosshi_state = 2
			player.quests.rosshi_lonely = player.quests.rosshi_lonely or {
				name = "Lonely Master",
				desc = "Master Rosshi will train you if you bring a girl to stay at Kame House and keep him company.",
				status = "taken",
			}
		end},
	},
}

newChat{ id="deal",
	text = [[Really!?!?! GIMME! GIMME! GIMME! PLEASE!

Sure. I have it right here. Just let me get it out of my pack.

Oh...hurry! Let me SEE!!!

Here you go. Nice, isn't it?

It's fantastic! The girls are so...shameless! I have to have it!

Agree to train me and it's yours.

Deal!]],
	answers = {
		{"Deal.", action=function(npc, player)
			takePorn(player)
			openTraining(player)
		end},
	},
}

return "welcome"
