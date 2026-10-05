-- dbt-generated-talk dialogue.KARIN
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.karin_fight or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.karin_state or 0) == 0 then
		player.karin_state = 1
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if ((player.quests and player.quests.curious_hole and player.quests.curious_hole.status == "taken")) and ((player.karin_hole or 0) == 0) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[I'm still waiting for you to kill me. Come now, at least try.]=] end
		if which == [=[2]=] then return [=[Karin: ]=] .. [=[I'm impressed. You're only the third person in over a hundred years to survive the long climb up my tower.

]=] end
		if which == [=[3]=] then return [=[Karin: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[! It's always good to see you! What brings you?

]=] end
		if which == [=[]=] then return [=[Karin: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[! It's always good to see you! What brings you?

]=] end
		return "..."
	end,
	answers = {
		{[=[Thank you. I do hope the trip will turn out to be worthwhile.]=], jump=[=[n0_g1_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Really? Who was the last one?]=], jump=[=[n0_g1_b]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Stupid cat! You'd get more company if you'd install an elevator!]=], jump=[=[n0_g1_c]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[What's with the hole up on the roof?]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[I have come to train with you.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I just wanted to see if you had any senzu beans to spare.]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if (player.karin_kinto or 0) == 0 then
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	if true then
		shown_n0_b = [=[1]=]
		return shown_n0_b
	end
	if true then
		shown_n0_b = [=[2]=]
		return shown_n0_b
	end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[Yes, I have a few senzu beans set aside for you. I hope you find them useful.

]=] end
		if which == [=[2]=] then return [=[Karin: ]=] .. [=[I'm sorry. Senzu beans grow extremely slowly. I'm happy to share them with fighters I have trained, but it takes time. Check back from time to time though, I should have more before long.

]=] end
		if which == [=[]=] then return [=[Karin: ]=] .. [=[Ahhh...looks like I have one senzu bean that just ripened today. Here you go.

]=] .. [=[Wow, it's really been a while since you've been by, hasn't it? I have ]=] .. [=[ senzu beans sitting here! Here, you can have them all.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	if (player.rosshi_student or (player.trainers and player.trainers.ROSSHI)) then
		player.karin_hole = 1
		shown_n0_c = [=[1]=]
		return shown_n0_c
	end
	if (player.crane_student or (player.trainers and player.trainers.CRANE_HERMIT)) then
		player.karin_hole = 10
		player:takeQuest("curious_hole", "finished")
		shown_n0_c = [=[2]=]
		return shown_n0_c
	end
	if not (((player.rosshi_student or (player.trainers and player.trainers.ROSSHI))) or ((player.crane_student or (player.trainers and player.trainers.CRANE_HERMIT)))) then
		shown_n0_c = [=[3]=]
		return shown_n0_c
	end
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		local which = arm_n0_c(player)
		if which == [=[1]=] then return [=[There's a hole in the roof...? Oh! You mean the nyoi-bo hole? That was made by a former student of mine by the name of Rosshi. He never learned to fly, but he wanted to speak to Kami, so he poked a hole in the stone with a finger, and used it to mount a magic staff he had. The staff could be made to extend to any length merely by speaking a command word. This was decades ago...but you might talk to Rosshi about it. I hear he's living on an island northeast of here.

]=] end
		if which == [=[2]=] then return [=[The Nyoi-bo hole? There's actually quite a story behind that, but it would hardly matter to a student of the Crane style like yourself. My last student was the master of the Turtle school, Rosshi. He wanted to speak to Kami, so he poked a hole in the stone with his finger and used it to mount a magic staff in his possession that was able to extend to any length, thus allowing him to climb up to Kami's Lookout.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Really? Maybe I should get myself a nyoibo.

]=] .. [=[Karin: ]=] .. [=[Not much point. As a student of Crane, you should be able to simply fly up to the Lookout. Plus, the last person to have the Nyoibo was Rosshi, and he's not likely to simply give it to a student of his rival.

]=] end
		if which == [=[3]=] then return [=[The Nyoi-bo hole? A former student of mine made it get to Kami.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[He spoke to Kami? How does the hole help? What's a Nyoi-bo?

]=] .. [=[Karin: ]=] .. [=[I don't think you're quite ready to be worrying about that yet. Try training a few more years, learn from a few more masters other than me, and maybe someday you'll be ready to see Kami. But, not today.

]=] end
		if which == [=[]=] then return [=[Karin: ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a]=],
	text = [=[Karin: ]=] .. [=[Of course! Nobody climbs my tower just to see the view. Which is a shame, really, because the view is really quite lovely from the roof. I highly recommend you take a look when you get the chance. ]=] .. [=[I suppose then, you have come to train with me?

]=],
	answers = {
		{[=[Would you tell me about yourself, and this place, first? I'm most curious.]=], jump=[=[n0_g1_a_a]=]},
		{[=[Yes. Yes, I would.]=], jump=[=[n0_g1_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[No, thank you. I'd much rather just kill you. (attack)]=], jump=[=[n0_g1_a_c]=], action=function(npc, player) player.karin_fight = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a_a]=],
	text = [=[Karin: ]=] .. [=[Of course. I'm a cat! I'm my favorite subject! As you've no doubt guessed, I'm the master of this tower, as well as the original architect. I became somewhat of a well known Chi Master about...oh...two hundred years ago, and eventually I tired of incompetants perpetually badgering me for training. Actually, I rather like badgers. Quite tasty. Anyway...so, at that time, Kami and I were spending a good deal of time together, and...

]=],
	answers = {
		{[=[Excuse me, but who's 'Kami?' (interupt)]=], jump=[=[n0_g1_a_a_a]=], action=function(npc, player) player.karin_kami = 1 end},
		{[=[(Keep listening)]=], jump=[=[n0_g1_a_a_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_a = nil
local function arm_n0_g1_a_a_a(player)
	if shown_n0_g1_a_a_a ~= nil then return shown_n0_g1_a_a_a end
	player.karin_kami = 1
	shown_n0_g1_a_a_a = [=[]=]
	return shown_n0_g1_a_a_a
end
newChat{ id=[=[n0_g1_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_a_a_a(player)
		return [=[Karin: ]=] .. [=[Who's Kami..? Kami! The God of this planet! Don't you keep up on current events? He's only been God of the earth for about, oh...hmm. Actually, I'm not even sure how long it's been. Several of my lifetimes, at least. You might ask Him. He lives a few hundred feet up from here, as I was about to explain]=] .. [=[...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.

]=]
	end,
	answers = {
		{[=[Wait...are you telling me that GOD lives above your tower?!?!?]=], jump=[=[n0_g1_a_a_a_a]=], action=function(npc, player) player.karin_kaio_chess = 1 end},
		{[=[Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?]=], jump=[=[n0_g1_a_a_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_a_a = nil
local function arm_n0_g1_a_a_a_a(player)
	if shown_n0_g1_a_a_a_a ~= nil then return shown_n0_g1_a_a_a_a end
	player.karin_kaio_chess = 1
	shown_n0_g1_a_a_a_a = [=[]=]
	return shown_n0_g1_a_a_a_a
end
newChat{ id=[=[n0_g1_a_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_a_a_a_a(player)
		return [=[(Karin looks at you strangely for a few moments)

]=] .. [=[Karin: ]=] .. [=[Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.

]=]
	end,
	answers = {
		{[=[You're telling me that God plays chess?]=], jump=[=[n0_g1_a_a_a_a_a]=], action=function(npc, player) player.karin_daio = 1 player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[What's a Namekkian?]=], jump=[=[n0_g1_a_a_a_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[I see. Yes, please continue.]=], jump=[=[n0_g1_a_a_a_a_c]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_a_a_a = nil
local function arm_n0_g1_a_a_a_a_a(player)
	if shown_n0_g1_a_a_a_a_a ~= nil then return shown_n0_g1_a_a_a_a_a end
	player.karin_daio = 1
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_a_a_a = [=[]=]
	return shown_n0_g1_a_a_a_a_a
end
newChat{ id=[=[n0_g1_a_a_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_a_a_a_a_a(player)
		return [=[Karin: ]=] .. [=[No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_a_a_b = nil
local function arm_n0_g1_a_a_a_a_b(player)
	if shown_n0_g1_a_a_a_a_b ~= nil then return shown_n0_g1_a_a_a_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_a_a_b = [=[]=]
	return shown_n0_g1_a_a_a_a_b
end
newChat{ id=[=[n0_g1_a_a_a_a_b]=],
	text = function(npc, player)
		arm_n0_g1_a_a_a_a_b(player)
		return [=[Karin: ]=] .. [=[A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_a_a_c = nil
local function arm_n0_g1_a_a_a_a_c(player)
	if shown_n0_g1_a_a_a_a_c ~= nil then return shown_n0_g1_a_a_a_a_c end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_a_a_c = [=[]=]
	return shown_n0_g1_a_a_a_a_c
end
newChat{ id=[=[n0_g1_a_a_a_a_c]=],
	text = function(npc, player)
		arm_n0_g1_a_a_a_a_c(player)
		return [=[Karin: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_a_b = nil
local function arm_n0_g1_a_a_a_b(player)
	if shown_n0_g1_a_a_a_b ~= nil then return shown_n0_g1_a_a_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_a_b = [=[]=]
	return shown_n0_g1_a_a_a_b
end
newChat{ id=[=[n0_g1_a_a_a_b]=],
	text = function(npc, player)
		arm_n0_g1_a_a_a_b(player)
		return [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a_a_b]=],
	text = [=[Karin: ]=] .. [=[...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.

]=],
	answers = {
		{[=[Wait...are you telling me that GOD lives above your tower?!?!?]=], jump=[=[n0_g1_a_a_b_a]=], action=function(npc, player) player.karin_kaio_chess = 1 end},
		{[=[Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?]=], jump=[=[n0_g1_a_a_b_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_b_a = nil
local function arm_n0_g1_a_a_b_a(player)
	if shown_n0_g1_a_a_b_a ~= nil then return shown_n0_g1_a_a_b_a end
	player.karin_kaio_chess = 1
	shown_n0_g1_a_a_b_a = [=[]=]
	return shown_n0_g1_a_a_b_a
end
newChat{ id=[=[n0_g1_a_a_b_a]=],
	text = function(npc, player)
		arm_n0_g1_a_a_b_a(player)
		return [=[(Karin looks at you strangely for a few moments)

]=] .. [=[Karin: ]=] .. [=[Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.

]=]
	end,
	answers = {
		{[=[You're telling me that God plays chess?]=], jump=[=[n0_g1_a_a_b_a_a]=], action=function(npc, player) player.karin_daio = 1 player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[What's a Namekkian?]=], jump=[=[n0_g1_a_a_b_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[I see. Yes, please continue.]=], jump=[=[n0_g1_a_a_b_a_c]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_b_a_a = nil
local function arm_n0_g1_a_a_b_a_a(player)
	if shown_n0_g1_a_a_b_a_a ~= nil then return shown_n0_g1_a_a_b_a_a end
	player.karin_daio = 1
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_b_a_a = [=[]=]
	return shown_n0_g1_a_a_b_a_a
end
newChat{ id=[=[n0_g1_a_a_b_a_a]=],
	text = function(npc, player)
		arm_n0_g1_a_a_b_a_a(player)
		return [=[Karin: ]=] .. [=[No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_b_a_b = nil
local function arm_n0_g1_a_a_b_a_b(player)
	if shown_n0_g1_a_a_b_a_b ~= nil then return shown_n0_g1_a_a_b_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_b_a_b = [=[]=]
	return shown_n0_g1_a_a_b_a_b
end
newChat{ id=[=[n0_g1_a_a_b_a_b]=],
	text = function(npc, player)
		arm_n0_g1_a_a_b_a_b(player)
		return [=[Karin: ]=] .. [=[A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_b_a_c = nil
local function arm_n0_g1_a_a_b_a_c(player)
	if shown_n0_g1_a_a_b_a_c ~= nil then return shown_n0_g1_a_a_b_a_c end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_b_a_c = [=[]=]
	return shown_n0_g1_a_a_b_a_c
end
newChat{ id=[=[n0_g1_a_a_b_a_c]=],
	text = function(npc, player)
		arm_n0_g1_a_a_b_a_c(player)
		return [=[Karin: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_a_b_b = nil
local function arm_n0_g1_a_a_b_b(player)
	if shown_n0_g1_a_a_b_b ~= nil then return shown_n0_g1_a_a_b_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_a_b_b = [=[]=]
	return shown_n0_g1_a_a_b_b
end
newChat{ id=[=[n0_g1_a_a_b_b]=],
	text = function(npc, player)
		arm_n0_g1_a_a_b_b(player)
		return [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_b = nil
local function arm_n0_g1_a_b(player)
	if shown_n0_g1_a_b ~= nil then return shown_n0_g1_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_a_b = [=[]=]
	return shown_n0_g1_a_b
end
newChat{ id=[=[n0_g1_a_b]=],
	text = function(npc, player)
		arm_n0_g1_a_b(player)
		return [=[Karin: ]=] .. [=[Wonderful! I haven't had a student in years!

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_a_c = nil
local function arm_n0_g1_a_c(player)
	if shown_n0_g1_a_c ~= nil then return shown_n0_g1_a_c end
	player.karin_fight = 1
	shown_n0_g1_a_c = [=[]=]
	return shown_n0_g1_a_c
end
newChat{ id=[=[n0_g1_a_c]=],
	text = function(npc, player)
		arm_n0_g1_a_c(player)
		return [=[Karin: ]=] .. [=[Ahh. Well, you're welcome to try, of course. In fact, just to keep it interesting, I'll even give you a senzu bean in case I get too excited and accidentally tear one of your arms off. That happens, sometimes.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_b]=],
	text = [=[Karin: ]=] .. [=[A Saiyan boy by the name of Goku. Took him three days. Well, the first time, anyway. He had something of an accident, and had to climb the tower two more times before I taught him anything. ]=] .. [=[I suppose then, you have come to train with me?

]=],
	answers = {
		{[=[Would you tell me about yourself, and this place, first? I'm most curious.]=], jump=[=[n0_g1_b_a]=]},
		{[=[Yes. Yes, I would.]=], jump=[=[n0_g1_b_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[No, thank you. I'd much rather just kill you. (attack)]=], jump=[=[n0_g1_b_c]=], action=function(npc, player) player.karin_fight = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_b_a]=],
	text = [=[Karin: ]=] .. [=[Of course. I'm a cat! I'm my favorite subject! As you've no doubt guessed, I'm the master of this tower, as well as the original architect. I became somewhat of a well known Chi Master about...oh...two hundred years ago, and eventually I tired of incompetants perpetually badgering me for training. Actually, I rather like badgers. Quite tasty. Anyway...so, at that time, Kami and I were spending a good deal of time together, and...

]=],
	answers = {
		{[=[Excuse me, but who's 'Kami?' (interupt)]=], jump=[=[n0_g1_b_a_a]=], action=function(npc, player) player.karin_kami = 1 end},
		{[=[(Keep listening)]=], jump=[=[n0_g1_b_a_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_a = nil
local function arm_n0_g1_b_a_a(player)
	if shown_n0_g1_b_a_a ~= nil then return shown_n0_g1_b_a_a end
	player.karin_kami = 1
	shown_n0_g1_b_a_a = [=[]=]
	return shown_n0_g1_b_a_a
end
newChat{ id=[=[n0_g1_b_a_a]=],
	text = function(npc, player)
		arm_n0_g1_b_a_a(player)
		return [=[Karin: ]=] .. [=[Who's Kami..? Kami! The God of this planet! Don't you keep up on current events? He's only been God of the earth for about, oh...hmm. Actually, I'm not even sure how long it's been. Several of my lifetimes, at least. You might ask Him. He lives a few hundred feet up from here, as I was about to explain]=] .. [=[...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.

]=]
	end,
	answers = {
		{[=[Wait...are you telling me that GOD lives above your tower?!?!?]=], jump=[=[n0_g1_b_a_a_a]=], action=function(npc, player) player.karin_kaio_chess = 1 end},
		{[=[Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?]=], jump=[=[n0_g1_b_a_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_a_a = nil
local function arm_n0_g1_b_a_a_a(player)
	if shown_n0_g1_b_a_a_a ~= nil then return shown_n0_g1_b_a_a_a end
	player.karin_kaio_chess = 1
	shown_n0_g1_b_a_a_a = [=[]=]
	return shown_n0_g1_b_a_a_a
end
newChat{ id=[=[n0_g1_b_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_b_a_a_a(player)
		return [=[(Karin looks at you strangely for a few moments)

]=] .. [=[Karin: ]=] .. [=[Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.

]=]
	end,
	answers = {
		{[=[You're telling me that God plays chess?]=], jump=[=[n0_g1_b_a_a_a_a]=], action=function(npc, player) player.karin_daio = 1 player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[What's a Namekkian?]=], jump=[=[n0_g1_b_a_a_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[I see. Yes, please continue.]=], jump=[=[n0_g1_b_a_a_a_c]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_a_a_a = nil
local function arm_n0_g1_b_a_a_a_a(player)
	if shown_n0_g1_b_a_a_a_a ~= nil then return shown_n0_g1_b_a_a_a_a end
	player.karin_daio = 1
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_a_a_a = [=[]=]
	return shown_n0_g1_b_a_a_a_a
end
newChat{ id=[=[n0_g1_b_a_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_b_a_a_a_a(player)
		return [=[Karin: ]=] .. [=[No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_a_a_b = nil
local function arm_n0_g1_b_a_a_a_b(player)
	if shown_n0_g1_b_a_a_a_b ~= nil then return shown_n0_g1_b_a_a_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_a_a_b = [=[]=]
	return shown_n0_g1_b_a_a_a_b
end
newChat{ id=[=[n0_g1_b_a_a_a_b]=],
	text = function(npc, player)
		arm_n0_g1_b_a_a_a_b(player)
		return [=[Karin: ]=] .. [=[A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_a_a_c = nil
local function arm_n0_g1_b_a_a_a_c(player)
	if shown_n0_g1_b_a_a_a_c ~= nil then return shown_n0_g1_b_a_a_a_c end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_a_a_c = [=[]=]
	return shown_n0_g1_b_a_a_a_c
end
newChat{ id=[=[n0_g1_b_a_a_a_c]=],
	text = function(npc, player)
		arm_n0_g1_b_a_a_a_c(player)
		return [=[Karin: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_a_b = nil
local function arm_n0_g1_b_a_a_b(player)
	if shown_n0_g1_b_a_a_b ~= nil then return shown_n0_g1_b_a_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_a_b = [=[]=]
	return shown_n0_g1_b_a_a_b
end
newChat{ id=[=[n0_g1_b_a_a_b]=],
	text = function(npc, player)
		arm_n0_g1_b_a_a_b(player)
		return [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_b_a_b]=],
	text = [=[Karin: ]=] .. [=[...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.

]=],
	answers = {
		{[=[Wait...are you telling me that GOD lives above your tower?!?!?]=], jump=[=[n0_g1_b_a_b_a]=], action=function(npc, player) player.karin_kaio_chess = 1 end},
		{[=[Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?]=], jump=[=[n0_g1_b_a_b_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_b_a = nil
local function arm_n0_g1_b_a_b_a(player)
	if shown_n0_g1_b_a_b_a ~= nil then return shown_n0_g1_b_a_b_a end
	player.karin_kaio_chess = 1
	shown_n0_g1_b_a_b_a = [=[]=]
	return shown_n0_g1_b_a_b_a
end
newChat{ id=[=[n0_g1_b_a_b_a]=],
	text = function(npc, player)
		arm_n0_g1_b_a_b_a(player)
		return [=[(Karin looks at you strangely for a few moments)

]=] .. [=[Karin: ]=] .. [=[Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.

]=]
	end,
	answers = {
		{[=[You're telling me that God plays chess?]=], jump=[=[n0_g1_b_a_b_a_a]=], action=function(npc, player) player.karin_daio = 1 player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[What's a Namekkian?]=], jump=[=[n0_g1_b_a_b_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[I see. Yes, please continue.]=], jump=[=[n0_g1_b_a_b_a_c]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_b_a_a = nil
local function arm_n0_g1_b_a_b_a_a(player)
	if shown_n0_g1_b_a_b_a_a ~= nil then return shown_n0_g1_b_a_b_a_a end
	player.karin_daio = 1
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_b_a_a = [=[]=]
	return shown_n0_g1_b_a_b_a_a
end
newChat{ id=[=[n0_g1_b_a_b_a_a]=],
	text = function(npc, player)
		arm_n0_g1_b_a_b_a_a(player)
		return [=[Karin: ]=] .. [=[No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_b_a_b = nil
local function arm_n0_g1_b_a_b_a_b(player)
	if shown_n0_g1_b_a_b_a_b ~= nil then return shown_n0_g1_b_a_b_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_b_a_b = [=[]=]
	return shown_n0_g1_b_a_b_a_b
end
newChat{ id=[=[n0_g1_b_a_b_a_b]=],
	text = function(npc, player)
		arm_n0_g1_b_a_b_a_b(player)
		return [=[Karin: ]=] .. [=[A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_b_a_c = nil
local function arm_n0_g1_b_a_b_a_c(player)
	if shown_n0_g1_b_a_b_a_c ~= nil then return shown_n0_g1_b_a_b_a_c end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_b_a_c = [=[]=]
	return shown_n0_g1_b_a_b_a_c
end
newChat{ id=[=[n0_g1_b_a_b_a_c]=],
	text = function(npc, player)
		arm_n0_g1_b_a_b_a_c(player)
		return [=[Karin: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_a_b_b = nil
local function arm_n0_g1_b_a_b_b(player)
	if shown_n0_g1_b_a_b_b ~= nil then return shown_n0_g1_b_a_b_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_a_b_b = [=[]=]
	return shown_n0_g1_b_a_b_b
end
newChat{ id=[=[n0_g1_b_a_b_b]=],
	text = function(npc, player)
		arm_n0_g1_b_a_b_b(player)
		return [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_b = nil
local function arm_n0_g1_b_b(player)
	if shown_n0_g1_b_b ~= nil then return shown_n0_g1_b_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_b_b = [=[]=]
	return shown_n0_g1_b_b
end
newChat{ id=[=[n0_g1_b_b]=],
	text = function(npc, player)
		arm_n0_g1_b_b(player)
		return [=[Karin: ]=] .. [=[Wonderful! I haven't had a student in years!

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b_c = nil
local function arm_n0_g1_b_c(player)
	if shown_n0_g1_b_c ~= nil then return shown_n0_g1_b_c end
	player.karin_fight = 1
	shown_n0_g1_b_c = [=[]=]
	return shown_n0_g1_b_c
end
newChat{ id=[=[n0_g1_b_c]=],
	text = function(npc, player)
		arm_n0_g1_b_c(player)
		return [=[Karin: ]=] .. [=[Ahh. Well, you're welcome to try, of course. In fact, just to keep it interesting, I'll even give you a senzu bean in case I get too excited and accidentally tear one of your arms off. That happens, sometimes.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_c]=],
	text = [=[Karin: ]=] .. [=[Hahaha! Yes, I'm sure I would. That's why I haven't. I enjoy my solitude, and prefer only to spend my time with those who are worthy of it. Which, by the way, is you...since you've succesfully climbed the tower even without an elevator. ]=] .. [=[I suppose then, you have come to train with me?

]=],
	answers = {
		{[=[Would you tell me about yourself, and this place, first? I'm most curious.]=], jump=[=[n0_g1_c_a]=]},
		{[=[Yes. Yes, I would.]=], jump=[=[n0_g1_c_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[No, thank you. I'd much rather just kill you. (attack)]=], jump=[=[n0_g1_c_c]=], action=function(npc, player) player.karin_fight = 1 end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_c_a]=],
	text = [=[Karin: ]=] .. [=[Of course. I'm a cat! I'm my favorite subject! As you've no doubt guessed, I'm the master of this tower, as well as the original architect. I became somewhat of a well known Chi Master about...oh...two hundred years ago, and eventually I tired of incompetants perpetually badgering me for training. Actually, I rather like badgers. Quite tasty. Anyway...so, at that time, Kami and I were spending a good deal of time together, and...

]=],
	answers = {
		{[=[Excuse me, but who's 'Kami?' (interupt)]=], jump=[=[n0_g1_c_a_a]=], action=function(npc, player) player.karin_kami = 1 end},
		{[=[(Keep listening)]=], jump=[=[n0_g1_c_a_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_a = nil
local function arm_n0_g1_c_a_a(player)
	if shown_n0_g1_c_a_a ~= nil then return shown_n0_g1_c_a_a end
	player.karin_kami = 1
	shown_n0_g1_c_a_a = [=[]=]
	return shown_n0_g1_c_a_a
end
newChat{ id=[=[n0_g1_c_a_a]=],
	text = function(npc, player)
		arm_n0_g1_c_a_a(player)
		return [=[Karin: ]=] .. [=[Who's Kami..? Kami! The God of this planet! Don't you keep up on current events? He's only been God of the earth for about, oh...hmm. Actually, I'm not even sure how long it's been. Several of my lifetimes, at least. You might ask Him. He lives a few hundred feet up from here, as I was about to explain]=] .. [=[...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.

]=]
	end,
	answers = {
		{[=[Wait...are you telling me that GOD lives above your tower?!?!?]=], jump=[=[n0_g1_c_a_a_a]=], action=function(npc, player) player.karin_kaio_chess = 1 end},
		{[=[Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?]=], jump=[=[n0_g1_c_a_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_a_a = nil
local function arm_n0_g1_c_a_a_a(player)
	if shown_n0_g1_c_a_a_a ~= nil then return shown_n0_g1_c_a_a_a end
	player.karin_kaio_chess = 1
	shown_n0_g1_c_a_a_a = [=[]=]
	return shown_n0_g1_c_a_a_a
end
newChat{ id=[=[n0_g1_c_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_c_a_a_a(player)
		return [=[(Karin looks at you strangely for a few moments)

]=] .. [=[Karin: ]=] .. [=[Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.

]=]
	end,
	answers = {
		{[=[You're telling me that God plays chess?]=], jump=[=[n0_g1_c_a_a_a_a]=], action=function(npc, player) player.karin_daio = 1 player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[What's a Namekkian?]=], jump=[=[n0_g1_c_a_a_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[I see. Yes, please continue.]=], jump=[=[n0_g1_c_a_a_a_c]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_a_a_a = nil
local function arm_n0_g1_c_a_a_a_a(player)
	if shown_n0_g1_c_a_a_a_a ~= nil then return shown_n0_g1_c_a_a_a_a end
	player.karin_daio = 1
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_a_a_a = [=[]=]
	return shown_n0_g1_c_a_a_a_a
end
newChat{ id=[=[n0_g1_c_a_a_a_a]=],
	text = function(npc, player)
		arm_n0_g1_c_a_a_a_a(player)
		return [=[Karin: ]=] .. [=[No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_a_a_b = nil
local function arm_n0_g1_c_a_a_a_b(player)
	if shown_n0_g1_c_a_a_a_b ~= nil then return shown_n0_g1_c_a_a_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_a_a_b = [=[]=]
	return shown_n0_g1_c_a_a_a_b
end
newChat{ id=[=[n0_g1_c_a_a_a_b]=],
	text = function(npc, player)
		arm_n0_g1_c_a_a_a_b(player)
		return [=[Karin: ]=] .. [=[A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_a_a_c = nil
local function arm_n0_g1_c_a_a_a_c(player)
	if shown_n0_g1_c_a_a_a_c ~= nil then return shown_n0_g1_c_a_a_a_c end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_a_a_c = [=[]=]
	return shown_n0_g1_c_a_a_a_c
end
newChat{ id=[=[n0_g1_c_a_a_a_c]=],
	text = function(npc, player)
		arm_n0_g1_c_a_a_a_c(player)
		return [=[Karin: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_a_b = nil
local function arm_n0_g1_c_a_a_b(player)
	if shown_n0_g1_c_a_a_b ~= nil then return shown_n0_g1_c_a_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_a_b = [=[]=]
	return shown_n0_g1_c_a_a_b
end
newChat{ id=[=[n0_g1_c_a_a_b]=],
	text = function(npc, player)
		arm_n0_g1_c_a_a_b(player)
		return [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_c_a_b]=],
	text = [=[Karin: ]=] .. [=[...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.

]=],
	answers = {
		{[=[Wait...are you telling me that GOD lives above your tower?!?!?]=], jump=[=[n0_g1_c_a_b_a]=], action=function(npc, player) player.karin_kaio_chess = 1 end},
		{[=[Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?]=], jump=[=[n0_g1_c_a_b_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_b_a = nil
local function arm_n0_g1_c_a_b_a(player)
	if shown_n0_g1_c_a_b_a ~= nil then return shown_n0_g1_c_a_b_a end
	player.karin_kaio_chess = 1
	shown_n0_g1_c_a_b_a = [=[]=]
	return shown_n0_g1_c_a_b_a
end
newChat{ id=[=[n0_g1_c_a_b_a]=],
	text = function(npc, player)
		arm_n0_g1_c_a_b_a(player)
		return [=[(Karin looks at you strangely for a few moments)

]=] .. [=[Karin: ]=] .. [=[Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.

]=]
	end,
	answers = {
		{[=[You're telling me that God plays chess?]=], jump=[=[n0_g1_c_a_b_a_a]=], action=function(npc, player) player.karin_daio = 1 player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[What's a Namekkian?]=], jump=[=[n0_g1_c_a_b_a_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{[=[I see. Yes, please continue.]=], jump=[=[n0_g1_c_a_b_a_c]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end player.trainers = player.trainers or {} 		player.trainers.KARIN = true 		if dbt_schools and dbt_schools.KARIN then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KARIN", player)) 		end end},
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_b_a_a = nil
local function arm_n0_g1_c_a_b_a_a(player)
	if shown_n0_g1_c_a_b_a_a ~= nil then return shown_n0_g1_c_a_b_a_a end
	player.karin_daio = 1
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_b_a_a = [=[]=]
	return shown_n0_g1_c_a_b_a_a
end
newChat{ id=[=[n0_g1_c_a_b_a_a]=],
	text = function(npc, player)
		arm_n0_g1_c_a_b_a_a(player)
		return [=[Karin: ]=] .. [=[No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_b_a_b = nil
local function arm_n0_g1_c_a_b_a_b(player)
	if shown_n0_g1_c_a_b_a_b ~= nil then return shown_n0_g1_c_a_b_a_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_b_a_b = [=[]=]
	return shown_n0_g1_c_a_b_a_b
end
newChat{ id=[=[n0_g1_c_a_b_a_b]=],
	text = function(npc, player)
		arm_n0_g1_c_a_b_a_b(player)
		return [=[Karin: ]=] .. [=[A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_b_a_c = nil
local function arm_n0_g1_c_a_b_a_c(player)
	if shown_n0_g1_c_a_b_a_c ~= nil then return shown_n0_g1_c_a_b_a_c end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_b_a_c = [=[]=]
	return shown_n0_g1_c_a_b_a_c
end
newChat{ id=[=[n0_g1_c_a_b_a_c]=],
	text = function(npc, player)
		arm_n0_g1_c_a_b_a_c(player)
		return [=[Karin: ]=] .. [=[Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_a_b_b = nil
local function arm_n0_g1_c_a_b_b(player)
	if shown_n0_g1_c_a_b_b ~= nil then return shown_n0_g1_c_a_b_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_a_b_b = [=[]=]
	return shown_n0_g1_c_a_b_b
end
newChat{ id=[=[n0_g1_c_a_b_b]=],
	text = function(npc, player)
		arm_n0_g1_c_a_b_b(player)
		return [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_b = nil
local function arm_n0_g1_c_b(player)
	if shown_n0_g1_c_b ~= nil then return shown_n0_g1_c_b end
	player.trainers = player.trainers or {}
			player.trainers.KARIN = true
			if dbt_schools and dbt_schools.KARIN then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KARIN", player))
			end
	shown_n0_g1_c_b = [=[]=]
	return shown_n0_g1_c_b
end
newChat{ id=[=[n0_g1_c_b]=],
	text = function(npc, player)
		arm_n0_g1_c_b(player)
		return [=[Karin: ]=] .. [=[Wonderful! I haven't had a student in years!

]=] .. [=[
Karin: ]=] .. [=[Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_c_c = nil
local function arm_n0_g1_c_c(player)
	if shown_n0_g1_c_c ~= nil then return shown_n0_g1_c_c end
	player.karin_fight = 1
	shown_n0_g1_c_c = [=[]=]
	return shown_n0_g1_c_c
end
newChat{ id=[=[n0_g1_c_c]=],
	text = function(npc, player)
		arm_n0_g1_c_c(player)
		return [=[Karin: ]=] .. [=[Ahh. Well, you're welcome to try, of course. In fact, just to keep it interesting, I'll even give you a senzu bean in case I get too excited and accidentally tear one of your arms off. That happens, sometimes.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
