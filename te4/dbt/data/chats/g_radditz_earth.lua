-- dbt-generated-talk dialogue.RADDITZ_EARTH
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player.have_we_met_radditz = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[NOTE: This dialogue is functional, but if you go with Radditz or annoy him he will take you to a place that is NOT implemented, and it's pretty much a dead end path. You have been warned.

]=] .. [=[Radditz: ]=] .. [=[Have you no shame, ]=] .. [=[? That was absolutely the most pathetic display of worthlessness I've seen in all the centuries I've lived! I don't understand what you're doing wasting your time with these humans and their ridiculous game to begin with, but if you're going to play along, why put up such a self-deprecating display?

]=]
	end,
	answers = {
		{[=[Hey, I did my best!]=], jump=[=[n0_a]=]},
		{[=[Umm...excuse me? What are you talking about?]=], jump=[=[n0_b]=]},
		{[=[It's, umm...all part of my master plan. And who are you, exactly?]=], jump=[=[n0_c]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Radditz: ]=] .. [=[You're joking, right? Come now, ]=] .. [=[, you have more power in your pinkie finger than all of those buffoons combined. Of course, from listening to you talk, they might have more brains in their fingers than you have in your head.

]=],
	answers = {
		{[=[I don't understand. I fought to win. What power are you talking about? ]=], jump=[=[n0_a_a]=]},
		{[=[Alright, that does it. One more nasty comment from you and I'm mopping up the pavement with you.]=], jump=[=[n0_a_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a]=],
	text = [=[Radditz: ]=] .. [=[You really don't remember, do you? How very interesting. I wonder what it is these humans have done to you,  ]=] .. [=[, but I have neither the time nor inclination to stay here to find out. My orders are to return with you to planet 79 and then resume preparations for the extermination of all sentient life on this planet. Come, let us leave this wretched planet.

]=],
	answers = {
		{[=[Alright.]=], jump=[=[n0_a_a_a]=]},
		{[=[No, I don't think so.]=], jump=[=[n0_a_a_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a_a]=],
	text = [=[Radditz takes you to a spacecraft hidden in the woods...]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a_b]=],
	text = [=[Radditz: ]=] .. [=[I wasn't *asking* you, ]=] .. [=[, but if you truly wish to stay and die with these humans it is no concern of mine. I would be glad to be rid of you. Still...we are of the same kind, and only a few of us remain. I think it would be best if you came with me.

]=],
	answers = {
		{[=[I will go with you.]=], jump=[=[n0_a_a_b_a]=]},
		{[=[No, I shall remain here.]=], jump=[=[n0_a_a_b_b]=], action=function(npc, player) player:takeQuest("impending_doom", "taken") end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a_b_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_a_b_b = nil
local function arm_n0_a_a_b_b(player)
	if shown_n0_a_a_b_b ~= nil then return shown_n0_a_a_b_b end
	player:takeQuest("impending_doom", "taken")
	shown_n0_a_a_b_b = [=[]=]
	return shown_n0_a_a_b_b
end
newChat{ id=[=[n0_a_a_b_b]=],
	text = function(npc, player)
		arm_n0_a_a_b_b(player)
		return [=[Radditz: ]=] .. [=[So be it, ]=] .. [=[. I cannot say I will miss you, but it does sadden my heart to see our numbers diminish even further.

]=] .. [=[Radditz sighs, shrugs, and then speaks softly into a small device on his wrist...then vanishes!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_b]=],
	text = [=[Radditz: ]=] .. [=[Hahahaha! You are pathetic, but at least you are funny! I don't know what has happened to you, ]=] .. [=[ but I have orders to bring you home if you're alive. Pity, though. I never really liked you.

]=] .. [=[(Radditz takes a step away from you, and a strange glow begins to emit from his hands...)

]=] .. [=[Radditz fires a burst of energy from his fingertips!]=] .. [=[(You feel weak, and you barely maintain consciousness. Your memory of subsequent events are fuzzy at best, but you vaguelly recall being dragged out of the wreckage of the World Tournament building, being strapped into a seat...sensations of motion...and then everything goes black for a long time.)

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = [=[Radditz: ]=] .. [=[I'm talking about YOU! What game are you playing here, ]=] .. [=[? Why are you wasting your time playing with children, and for that matter, why are they any children here for you to play with? It's been years! Freeza sent me to see why you had not returned from your mission yet. We assumed you had been killed, difficult as that was to believe given how utterly physically and technologically pathetic our preliminary reports showed the natives of this world to be: almost as pathetic as your display in that ridiculous tournament.

]=],
	answers = {
		{[=[Freeza? What mission?]=], jump=[=[n0_b_a]=]},
		{[=[I think I've had enough of your insults. Take a hike while you can still walk.]=], jump=[=[n0_b_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a]=],
	text = [=[Radditz: ]=] .. [=[You really don't remember, do you? How very interesting. I wonder what it is these humans have done to you,  ]=] .. [=[, but I have neither the time nor inclination to stay here to find out. My orders are to return with you to planet 79 and then resume preparations for the extermination of all sentient life on this planet. Come, let us leave this wretched planet.

]=],
	answers = {
		{[=[Alright.]=], jump=[=[n0_b_a_a]=]},
		{[=[No, I don't think so.]=], jump=[=[n0_b_a_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a_a]=],
	text = [=[Radditz takes you to a spacecraft hidden in the woods...]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a_b]=],
	text = [=[Radditz: ]=] .. [=[I wasn't *asking* you, ]=] .. [=[, but if you truly wish to stay and die with these humans it is no concern of mine. I would be glad to be rid of you. Still...we are of the same kind, and only a few of us remain. I think it would be best if you came with me.

]=],
	answers = {
		{[=[I will go with you.]=], jump=[=[n0_b_a_b_a]=]},
		{[=[No, I shall remain here.]=], jump=[=[n0_b_a_b_b]=], action=function(npc, player) player:takeQuest("impending_doom", "taken") end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a_b_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b_a_b_b = nil
local function arm_n0_b_a_b_b(player)
	if shown_n0_b_a_b_b ~= nil then return shown_n0_b_a_b_b end
	player:takeQuest("impending_doom", "taken")
	shown_n0_b_a_b_b = [=[]=]
	return shown_n0_b_a_b_b
end
newChat{ id=[=[n0_b_a_b_b]=],
	text = function(npc, player)
		arm_n0_b_a_b_b(player)
		return [=[Radditz: ]=] .. [=[So be it, ]=] .. [=[. I cannot say I will miss you, but it does sadden my heart to see our numbers diminish even further.

]=] .. [=[Radditz sighs, shrugs, and then speaks softly into a small device on his wrist...then vanishes!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_b]=],
	text = [=[Radditz: ]=] .. [=[Hahahaha! You are pathetic, but at least you are funny! I don't know what has happened to you, ]=] .. [=[ but I have orders to bring you home if you're alive. Pity, though. I never really liked you.

]=] .. [=[(Radditz takes a step away from you, and a strange glow begins to emit from his hands...)

]=] .. [=[Radditz fires a burst of energy from his fingertips!]=] .. [=[(You feel weak, and you barely maintain consciousness. Your memory of subsequent events are fuzzy at best, but you vaguelly recall being dragged out of the wreckage of the World Tournament building, being strapped into a seat...sensations of motion...and then everything goes black for a long time.)

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c]=],
	text = [=[Radditz: ]=] .. [=[Who am I...? Has it been so long that you don't recognize me? I'm your crib-mate! Radditz! Who are you, ]=] .. [=[, that you don't even recognize your own brother!  Have you become not only weak and pathetic, but stupid as well?

]=],
	answers = {
		{[=[You're my brother? Since when?]=], jump=[=[n0_c_a]=]},
		{[=[I don't like your tone. I think you'd best apologize. Now.]=], jump=[=[n0_c_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_a]=],
	text = [=[Radditz: ]=] .. [=[You really don't remember, do you? How very interesting. I wonder what it is these humans have done to you,  ]=] .. [=[, but I have neither the time nor inclination to stay here to find out. My orders are to return with you to planet 79 and then resume preparations for the extermination of all sentient life on this planet. Come, let us leave this wretched planet.

]=],
	answers = {
		{[=[Alright.]=], jump=[=[n0_c_a_a]=]},
		{[=[No, I don't think so.]=], jump=[=[n0_c_a_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_a_a]=],
	text = [=[Radditz takes you to a spacecraft hidden in the woods...]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_a_b]=],
	text = [=[Radditz: ]=] .. [=[I wasn't *asking* you, ]=] .. [=[, but if you truly wish to stay and die with these humans it is no concern of mine. I would be glad to be rid of you. Still...we are of the same kind, and only a few of us remain. I think it would be best if you came with me.

]=],
	answers = {
		{[=[I will go with you.]=], jump=[=[n0_c_a_b_a]=]},
		{[=[No, I shall remain here.]=], jump=[=[n0_c_a_b_b]=], action=function(npc, player) player:takeQuest("impending_doom", "taken") end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_a_b_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c_a_b_b = nil
local function arm_n0_c_a_b_b(player)
	if shown_n0_c_a_b_b ~= nil then return shown_n0_c_a_b_b end
	player:takeQuest("impending_doom", "taken")
	shown_n0_c_a_b_b = [=[]=]
	return shown_n0_c_a_b_b
end
newChat{ id=[=[n0_c_a_b_b]=],
	text = function(npc, player)
		arm_n0_c_a_b_b(player)
		return [=[Radditz: ]=] .. [=[So be it, ]=] .. [=[. I cannot say I will miss you, but it does sadden my heart to see our numbers diminish even further.

]=] .. [=[Radditz sighs, shrugs, and then speaks softly into a small device on his wrist...then vanishes!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c_b]=],
	text = [=[Radditz: ]=] .. [=[Hahahaha! You are pathetic, but at least you are funny! I don't know what has happened to you, ]=] .. [=[ but I have orders to bring you home if you're alive. Pity, though. I never really liked you.

]=] .. [=[(Radditz takes a step away from you, and a strange glow begins to emit from his hands...)

]=] .. [=[Radditz fires a burst of energy from his fingertips!]=] .. [=[(You feel weak, and you barely maintain consciousness. Your memory of subsequent events are fuzzy at best, but you vaguelly recall being dragged out of the wreckage of the World Tournament building, being strapped into a seat...sensations of motion...and then everything goes black for a long time.)

]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
