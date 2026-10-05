-- dbt-generated-talk dialogue.KAMI
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (false) and (not (player.quests and player.quests.kami_to_kaio)) then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Kami: ]=] .. [=[Greetings, ]=] .. (player.name or "you") .. [=[. What may I do for you?

]=] end
		if which == [=[]=] then return [=[Kami: ]=] .. [=[Greetings, ]=] .. (player.name or "you") .. [=[. What may I do for you?

]=] end
		return "..."
	end,
	answers = {
		{[=[Do you have any advice on how I can further improve my training?]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Nothing right now, thank you. I'm just visiting.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[Would you help me to train?]=], jump=[=[n0_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.KAMI = true 		if dbt_schools and dbt_schools.KAMI then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("KAMI", player)) 		end end, cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[The North Kaio says he won't train me until I can make him laugh. Do you know any jokes?]=], jump=[=[n0_d]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	player.trainers = player.trainers or {}
			player.trainers.KAMI = true
			if dbt_schools and dbt_schools.KAMI then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("KAMI", player))
			end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	if (player.karin_kaio_chess or 0) == 1 then
		shown_n0_c = [=[1]=]
		return shown_n0_c
	end
	if (player.emma_mentioned_kaio or 0) == 1 then
		shown_n0_c = [=[2]=]
		return shown_n0_c
	end
	if not (((player.karin_kaio_chess or 0) == 1) or ((player.emma_mentioned_kaio or 0) == 1)) then
		shown_n0_c = [=[3]=]
		return shown_n0_c
	end
	if (player.times_died or 0) > 0 then
		shown_n0_c = [=[4]=]
		return shown_n0_c
	end
	if not (((player.times_died or 0) > 0)) then
		shown_n0_c = [=[5]=]
		return shown_n0_c
	end
	player:takeQuest("kami_to_kaio", "taken")
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		local which = arm_n0_c(player)
		if which == [=[1]=] then return (player.name or "you") .. [=[: ]=] .. [=[The North Kaio? I think Karin mentioned him. He's the guy who's really good at chess, right?

]=] .. [=[Kami: ]=] .. [=[Chess? Don't be silly. The North Kaio is a powerful telepath. But, he's an even more powerful Chi Master, and I will help you to see him for training.

]=] end
		if which == [=[2]=] then return (player.name or "you") .. [=[: ]=] .. [=[The North Kaio? That names sounds familiar. Where have I...OH! The North Kaio! The Galaxy Overseer, right? Emma mentioned him.

]=] .. [=[Kami: ]=] .. [=[I am impressed that you've spoken with a Daio about such things. Yes. And it is the Kaio with whom you must train to further your skills.

]=] end
		if which == [=[3]=] then return (player.name or "you") .. [=[: ]=] .. [=[North Kaio? Who's that?

]=] .. [=[Kami: ]=] .. [=[While Kami watch over mere planets, the Kaio watch over vast regions of space. There are four Kaio in our galaxy, each watching over a single quadrant, and training potential warriors to help guard them. Earth lies within the jurisdiction of the Northern Kaio, and it is He with whom you must train to advance to levels I cannot take you.

]=] end
		if which == [=[4]=] then return (player.name or "you") .. [=[: ]=] .. [=[Ehh. I've been there. Done that.

]=] .. [=[Kami: ]=] .. [=[Hmph.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Is there any way I can get there without dying though? It's terribly inconvenient.

]=] .. [=[Kami: ]=] .. [=[Indeed. I will open a portal for you from here. You may cross through it freely to the afterworld at any time.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Groovy.

]=] end
		if which == [=[5]=] then return (player.name or "you") .. [=[: ]=] .. [=[Will that be difficult?

]=] .. [=[Kami: ]=] .. [=[Indeed. The Serpent's Path is a treacherous byway through hyperdimensional space, and guarded by Jajoushin, the Snake Princess.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Sounds kind of scary.

]=] .. [=[Kami: ]=] .. [=[I have faith in ability to persevere. Here, I will open a portal for you to cross through into the afterworld. You may cross through it freely at any time.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you.

]=] end
		if which == [=[]=] then return [=[Kami: ]=] .. [=[Hmm. Yes, I do. You are right. You have learned much from me, but it is time for you to ascend even higher in your training. Higher than even I can take you. You must seek our the North Kaio, and train with him.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Sounds great. How do I get to him?

]=] .. [=[Kami: ]=] .. [=[To reach the North Kaio you must cross the Serpent's Path.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_d]=],
	text = function(npc, player)
		return [=[Kami: ]=] .. [=[Mmm. Yes, he has been known to be picky about his students. A joke? Let me see. How about: 'Why did the punk rocker cross the road?'

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Punk Rocker? Umm...I dont know. Why?

]=] .. [=[Because he was stapled to a chicken.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Hehe...umm, wow. Ok, I wasn't expecting that. But, will it make him laugh?

]=] .. [=[Kami: ]=] .. [=[I don't know. Maybe. It's difficult to judge, with Him. His sense of humor has always been a bit, peculiar.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I suppose it's worth a try, anyway.

]=] .. [=[Kami: ]=] .. [=[Don't worry. Even if this isn't the joke to do it, I'm sure you can find a way to make him laugh. Somehow.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
