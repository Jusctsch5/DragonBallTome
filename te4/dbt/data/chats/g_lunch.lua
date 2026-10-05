-- dbt-generated-talk dialogue.LUNCH
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.lunch_state or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.lunch_state or 0) == 0)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if player:isPartied("RACE_LUNCH") then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.lunch_state or 0) < 3 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if not (((player.lunch_state or 0) < 3)) then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Lunch: ]=] .. [=[La, la la! Cooking is so fun! Yay for me! Happy, happy, yay for me!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Hello, Lunch. Good to see you're doing so well.

]=] .. [=[Lunch: ]=] .. [=[Oh, yes! Very much so. Thank you so much for introducing me to Mr. Rosshi. I've been so very comfortable here.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Really? He hasn't...umm, done anything...well, you know?

]=] .. [=[Lunch: ]=] .. [=[Oh, goodness no! Mr. Rosshi? Why, he's been a perfect gentleman to me! And I get to play house all day long, baking cookies, and running the kitchen any way I please! It's been such a delightful dream!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Of course, I suppose when you're at the stove, you're probably paying more attention to what you're doing than what he's doing.

]=] .. [=[Lunch: ]=] .. [=[Oh, I suppose I do get lost in my chores, but Mr. Rosshi is never far. He loves to watch me. He says it brings him great joy to see a young girl who appreciates the domestic life. 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I think there may be more to it than that, but so long as you're both happy with the arrangement.

]=] .. [=[Lunch: ]=] .. [=[Oh! The browines are done! Excuse me, please.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Certainly. Take care, Lunch. I'm glad you've found your happiness.

]=] .. [=[Lunch: ]=] .. [=[It's all thanks to you, ]=] .. (player.name or "you") .. [=[ I am forever grateful. Thank you so much. :)

]=] end
		if which == [=[2]=] then return [=[Lunch: ]=] .. [=[Hey, I remember you! You're that slimeball who stranded me on this God forsaken island with that old geezer!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...I, umm...

]=] .. [=[Lunch: ]=] .. [=[Lock and load!]=] end
		if which == [=[3]=] then return [=[...]=] end
		if which == [=[4]=] then return [=[...]=] end
		if which == [=[5]=] then return [=[Unknown dialogue state for Lunch?]=] end
		return "..."
	end,
	answers = {
		{[=[Yes. Very nice. Nice chatting with you.]=], jump=[=[n0_g3_a]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[Are you....ok?]=], jump=[=[n0_g3_b]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_a]=],
	text = [=[Lunch: ]=] .. [=[You too!]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_b = nil
local function arm_n0_g3_b(player)
	if shown_n0_g3_b ~= nil then return shown_n0_g3_b end
	if true then
		shown_n0_g3_b = [=[1]=]
		return shown_n0_g3_b
	end
	player.lunch_state = 2
	player.lunch_sneeze = 1
	shown_n0_g3_b = [=[]=]
	return shown_n0_g3_b
end
newChat{ id=[=[n0_g3_b]=],
	text = function(npc, player)
		local which = arm_n0_g3_b(player)
		if which == [=[1]=] then return (player.name or "you") .. [=[: ]=] .. [=[I understand. It sounds terribly inconvenient.

]=] .. [=[Lunch: ]=] .. [=[It is. But I feel so much worse for the people I hurt. As inconvenient as it is for me, it's all the more horrible that I impose on other people and do bad things. I don't want to be a bad person!

]=] end
		if which == [=[]=] then return [=[Lunch: ]=] .. [=[Oh dear. If you're asking me that, I must have done something bad, have I?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Ahh....well, I suppose you might say something...kind of like that. Maybe. But you seem ok now.

]=] .. [=[Lunch: ]=] .. [=[I'm terribly sorry. Please let me explain. Whenever I sneeze my personality and my appearance both change. Sometimes I'm like this, and other times I'm...well, I don't know, really. I never remember what happens.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Let's just say you become a mildly antisocial.

]=] .. [=[Lunch: ]=] .. [=[I'm sorry. I don't doubt it. Yes. I often wake up with whiskey, automatic weapons and large bundles of cash. Oh...I feel so awful! I really don't want to be this way. 

]=] .. [=[But whenever I...ahh....ahh....

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes?

]=] .. [=[Lunch: ]=] .. [=[...ahhh....CHOOO!

]=] end
		return "..."
	end,
	answers = {
		{[=[That's really too bad. You seem like a nice girl. I'm sorry I can't help you, but maybe it would be best if I didn't stay too close?]=], jump=[=[n0_g3_b_g0_a]=], cond=function(npc, player) return arm_n0_g3_b(player) == [=[1]=] end},
		{[=[Maybe you should travel with me? That way I could keep an eye on you and maybe keep you from accidentally hurting anyone.]=], jump=[=[n0_g3_b_g0_b]=], action=function(npc, player) player:partyWith({define_as="RACE_LUNCH", name="companion", level=1}) end, cond=function(npc, player) return arm_n0_g3_b(player) == [=[1]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_b_g0_a]=],
	text = [=[Lunch (Sadly): ]=] .. [=[Yes. Maybe that would be best.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_b_g0_b = nil
local function arm_n0_g3_b_g0_b(player)
	if shown_n0_g3_b_g0_b ~= nil then return shown_n0_g3_b_g0_b end
	player:partyWith({define_as="RACE_LUNCH", name="companion", level=1})
	shown_n0_g3_b_g0_b = [=[]=]
	return shown_n0_g3_b_g0_b
end
newChat{ id=[=[n0_g3_b_g0_b]=],
	text = function(npc, player)
		arm_n0_g3_b_g0_b(player)
		return [=[Lunch: ]=] .. [=[That's would be very kind of you, but I would hate to be such a burden!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[It's no trouble. Well, ok, maybe it is a little trouble, but I'm an adventurer and having you along will definately be adventuresome. Besides, if you're with me at least we'll know that you're not troubling anyone else.

]=] .. [=[Lunch: ]=] .. [=[Then, please forgive me if I accept. Oh, how wonderful! It will be so nice to have a friend! Thank you so much!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_b_g0_c]=],
	text = [=[Lunch: ]=] .. [=[Dragonballs? I'm not sure what those are, but if you can do anything to help me that would be wonderful! Thank you so much!

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_c = nil
local function arm_n0_g3_c(player)
	if shown_n0_g3_c ~= nil then return shown_n0_g3_c end
	player:partyWith({define_as="RACE_LUNCH", name="companion", level=1})
	shown_n0_g3_c = [=[]=]
	return shown_n0_g3_c
end
newChat{ id=[=[n0_g3_c]=],
	text = function(npc, player)
		arm_n0_g3_c(player)
		return [=[Lunch: ]=] .. [=[I would be delighted!]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_d = nil
local function arm_n0_g3_d(player)
	if shown_n0_g3_d ~= nil then return shown_n0_g3_d end
	player:partyWith({define_as="RACE_LUNCH", name="companion", level=1})
	shown_n0_g3_d = [=[]=]
	return shown_n0_g3_d
end
newChat{ id=[=[n0_g3_d]=],
	text = function(npc, player)
		arm_n0_g3_d(player)
		return [=[Lunch: ]=] .. [=[You'd like to introduce me to someone? How wonderful! I don't have very many friends. I'd be delighted.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_e = nil
local function arm_n0_g3_e(player)
	if shown_n0_g3_e ~= nil then return shown_n0_g3_e end
	player:partyWith({define_as="RACE_LUNCH", name="companion", level=1})
	shown_n0_g3_e = [=[]=]
	return shown_n0_g3_e
end
newChat{ id=[=[n0_g3_e]=],
	text = function(npc, player)
		arm_n0_g3_e(player)
		return [=[Lunch: ]=] .. [=[Oh! That sounds wonderful. I'd be delighted to meet him. You lead the way, and I'll follow you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
