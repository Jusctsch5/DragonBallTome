-- dbt-generated-talk dialogue.TOXIC
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.toxic_state or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.toxic_state or 0) == 10 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.toxic_state or 0) == 11 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if not (((player.toxic_state or 0) == 0) or ((player.toxic_state or 0) == 10) or ((player.toxic_state or 0) == 11)) then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[
Customer Relations: ]=] .. [=[Hello! Thank you for your interest in our company! We are the largest supplier of widgets in this region, and our manufacturign processes are extremely high-tech! We are fully certified by both the national emmissions and environmental protection agencies to be an A-class non-polluter! That means that our products are completely safe, and cause absolutely no harm to the environment!

]=] end
		if which == [=[2]=] then return [=[
Customer Relations: ]=] .. [=[We're ruined because of you!

]=] end
		if which == [=[3]=] then return [=[
Customer Relations: ]=] .. [=[Good day, sir.

]=] end
		if which == [=[4]=] then return [=[Unknown dball_data.toxic_state!]=] end
		return "..."
	end,
	answers = {
		{[=[Ok. Thanks.]=], jump=[=[n0_g0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[What's a widget?]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = [=[Customer Relations: ]=] .. [=[I'm glad you asked! Widgets are our number one, best selling product! They come in a variety of colors, and at this particular plant we manufacture all twelve of the major varieties!

]=],
	answers = {
		{[=[Oh. Thank you.]=], jump=[=[n0_g0_b_a]=], action=function(npc, player) player.toxic_quest_desc = 3 end},
		{[=[Ok...but what is one?]=], jump=[=[n0_g0_b_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g0_b_a = nil
local function arm_n0_g0_b_a(player)
	if shown_n0_g0_b_a ~= nil then return shown_n0_g0_b_a end
	player.toxic_quest_desc = 3
	shown_n0_g0_b_a = [=[]=]
	return shown_n0_g0_b_a
end
newChat{ id=[=[n0_g0_b_a]=],
	text = function(npc, player)
		local which = arm_n0_g0_b_a(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b]=],
	text = [=[Customer Relations: ]=] .. [=[What's a widget, you ask? Why...widgets are the most absolutely useful devices ever mass produced! Every household and small business should have at least three or four on hand. How many widgets do you own?

]=],
	answers = {
		{[=[Me? I don't own any widgets.]=], jump=[=[n0_g0_b_b_a]=]},
		{[=[Oh, gee...I don't know, it's hard to keep track of how many I have.]=], jump=[=[n0_g0_b_b_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g0_b_b_a = nil
local function arm_n0_g0_b_b_a(player)
	if shown_n0_g0_b_b_a ~= nil then return shown_n0_g0_b_b_a end
	if (player.money or 0) > 99 then
		shown_n0_g0_b_b_a = [=[1]=]
		return shown_n0_g0_b_b_a
	end
	if not (((player.money or 0) > 99)) then
		shown_n0_g0_b_b_a = [=[2]=]
		return shown_n0_g0_b_b_a
	end
	shown_n0_g0_b_b_a = [=[]=]
	return shown_n0_g0_b_b_a
end
newChat{ id=[=[n0_g0_b_b_a]=],
	text = function(npc, player)
		local which = arm_n0_g0_b_b_a(player)
		if which == [=[1]=] then return [=[(He looks aghast)

]=] .. [=[Customer Relations: ]=] .. [=[You don't own a widget!?!? Not one? Oh dear, you poor ]=] .. [=[! No wonder you came here today. Here...since we here at Widget Co. care so deeply for our customers, let me sell you one of our floor models at the heavily discounted price of 100 zeni.

]=] end
		if which == [=[2]=] then return [=[(He looks aghast)

]=] .. [=[Customer Relations: ]=] .. [=[You don't own a widget!?!? Not one? Oh dear, you poor ]=] .. [=[! No wonder you came here today. Here...since we here at Widget Co. care so deeply for our customers, let me sell you one of our floor models at the heavily discounted price of 100 zeni.

]=] end
		if which == [=[]=] then return [=[(He looks aghast)

]=] .. [=[Customer Relations: ]=] .. [=[You don't own a widget!?!? Not one? Oh dear, you poor ]=] .. [=[! No wonder you came here today. Here...since we here at Widget Co. care so deeply for our customers, let me sell you one of our floor models at the heavily discounted price of 100 zeni.

]=] end
		return "..."
	end,
	answers = {
		{[=[Ok.]=], jump=[=[n0_g0_b_b_a_a]=], cond=function(npc, player) return arm_n0_g0_b_b_a(player) == [=[1]=] end},
		{[=[Gee, I'd love to, but I haven't 100 zeni on me right now.]=], jump=[=[n0_g0_b_b_a_b]=], cond=function(npc, player) return arm_n0_g0_b_b_a(player) == [=[2]=] end},
		{[=[No, thank you.]=], jump=[=[n0_g0_b_b_a_c]=], cond=function(npc, player) return arm_n0_g0_b_b_a(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b_a_a]=],
	text = [=[Customer Relations: ]=] .. [=[Excellent! Please come again soon!
]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b_a_b]=],
	text = [=[Customer Relations: ]=] .. [=[Ahh...well, I'm sorry, you'll have to just stare with empty longing and yearning through the display window...feeling the emptiness consume you as your heart and soul wrack in the agony of not owning a widget. I feel for you. I really do.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b_a_c]=],
	text = [=[Customer Relations: ]=] .. [=[No? Are you sure you're feeling ok? Not wanting to buy a widget is...well, sort of peculiar. Are you a terrorist or something?

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b_b]=],
	text = [=[Customer Relations: ]=] .. [=[Oh, how marvelous! Yes, we do so love customers like you! Please feel free to stop by anytime!

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c = nil
local function arm_n0_g0_c(player)
	if shown_n0_g0_c ~= nil then return shown_n0_g0_c end
	if player:effStat("chr") >= 20 then
		shown_n0_g0_c = [=[1]=]
		return shown_n0_g0_c
	end
	shown_n0_g0_c = [=[]=]
	return shown_n0_g0_c
end
newChat{ id=[=[n0_g0_c]=],
	text = function(npc, player)
		local which = arm_n0_g0_c(player)
		if which == [=[1]=] then return [=[Customer Relations: ]=] .. [=[I...you...umm, really? Huh. Maybe...maybe we can come to an understanding over this? You're a busy ]=] .. [=[ and I'm sure you have more important things to do than turn us in to the authorities. Of course, it must be inconvenient having important things to do...but lacking the funds to do them, right?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Are you trying to bribe me?]=] .. [=[Customer Relations: ]=] .. [=[Me? Bribe?!?! Why...'bribe' is such an unpleasant word. Call it just payment for your efforts to bring to our attention something we really didn't know about! Yes. Yes, that's it. Thank you so much! You've really done us a greaty service, and it would only be proper for us to reward you, say...umm, how does ]=] .. [=[ sound?

]=] end
		if which == [=[]=] then return [=[Customer Relations: ]=] .. [=[I...you...umm, really? Huh. Maybe...maybe we can come to an understanding over this? You're a busy ]=] .. [=[ and I'm sure you have more important things to do than turn us in to the authorities. Of course, it must be inconvenient having important things to do...but lacking the funds to do them, right?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Are you trying to bribe me?]=] .. [=[Customer Relations: ]=] .. [=[Me? Bribe?!?! Why...'bribe' is such an unpleasant word. Call it just payment for your efforts to bring to our attention something we really didn't know about! Yes. Yes, that's it. Thank you so much! You've really done us a greaty service, and it would only be proper for us to reward you, say...umm, how does ]=] .. [=[ sound?

]=] end
		return "..."
	end,
	answers = {
		{[=[(Persuade 20) I think ]=] .. [=[ is really an insignificant sum to stay in business. Don't you?]=], jump=[=[n0_g0_c_c]=], action=function(npc, player) player.toxic_state = 11 player:takeQuest("toxic_sludge", "finished") end, cond=function(npc, player) return arm_n0_g0_c(player) == [=[1]=] end},
		{[=[No. I'm turning you in.]=], jump=[=[n0_g0_c_a]=], action=function(npc, player) player.toxic_state = 10 player:takeQuest("toxic_sludge", "finished") end, cond=function(npc, player) return arm_n0_g0_c(player) == "" end},
		{[=[Yes, I think we understand each other. ]=] .. [=[ is a suitable reward.]=], jump=[=[n0_g0_c_a]=], action=function(npc, player) player.toxic_state = 10 player:takeQuest("toxic_sludge", "finished") end, cond=function(npc, player) return arm_n0_g0_c(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_g0_c_a = nil
local function arm_n0_g0_c_a(player)
	if shown_n0_g0_c_a ~= nil then return shown_n0_g0_c_a end
	player.toxic_state = 10
	player:takeQuest("toxic_sludge", "finished")
	shown_n0_g0_c_a = [=[]=]
	return shown_n0_g0_c_a
end
newChat{ id=[=[n0_g0_c_a]=],
	text = function(npc, player)
		arm_n0_g0_c_a(player)
		return [=[Customer Relations: ]=] .. [=[Wait! Can't we come to an arrangement?!!??

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Absolutely! Our arrangement is that I'm reporting you and you're going out of business. There will be no more radioactive waste in my local sewer.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c_b = nil
local function arm_n0_g0_c_b(player)
	if shown_n0_g0_c_b ~= nil then return shown_n0_g0_c_b end
	player.toxic_state = 11
	player:takeQuest("toxic_sludge", "finished")
	shown_n0_g0_c_b = [=[]=]
	return shown_n0_g0_c_b
end
newChat{ id=[=[n0_g0_c_b]=],
	text = function(npc, player)
		arm_n0_g0_c_b(player)
		return [=[Customer Relations: ]=] .. [=[Excellent! I assume cash will be acceptable?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Absolutely. It's been a pleasure doing business with you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c_c = nil
local function arm_n0_g0_c_c(player)
	if shown_n0_g0_c_c ~= nil then return shown_n0_g0_c_c end
	player.toxic_state = 11
	player:takeQuest("toxic_sludge", "finished")
	shown_n0_g0_c_c = [=[]=]
	return shown_n0_g0_c_c
end
newChat{ id=[=[n0_g0_c_c]=],
	text = function(npc, player)
		arm_n0_g0_c_c(player)
		return [=[Customer Relations: ]=] .. [=[I suppose you're right. Very well.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you. It's been a pleasure doing business with you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_d = nil
local function arm_n0_g0_d(player)
	if shown_n0_g0_d ~= nil then return shown_n0_g0_d end
	if (player.toxic_quest_desc or 0) < 6 then
		player.toxic_quest_desc = 5
		shown_n0_g0_d = [=[1]=]
		return shown_n0_g0_d
	end
	shown_n0_g0_d = [=[]=]
	return shown_n0_g0_d
end
newChat{ id=[=[n0_g0_d]=],
	text = function(npc, player)
		local which = arm_n0_g0_d(player)
		if which == [=[1]=] then return [=[Customer Relations: ]=] .. [=[Mutant rat? Turtles? What does that have to do with us? There are a number of perfectly natural causes for mutation. Why, maybe the sewer creatures are merely evolving! 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[You're joking, right?

]=] .. [=[Customer Relations: ]=] .. [=[Not at all! Why...I feel for those poor creatures, I really do! Thousands and thousands of years of crawling on their bellies, and now that they're finally starting to evolve into intelligent bipeds, here you come and try to pretend that they didn't do it on their own! That they had to have some sort of 'magic' help from some sort of fantasy nuclear waste products! You really are a rude and despicable person. Please leave. I just can't deal with how inconsiderate you are.

]=] end
		if which == [=[]=] then return [=[Customer Relations: ]=] .. [=[Mutant rat? Turtles? What does that have to do with us? There are a number of perfectly natural causes for mutation. Why, maybe the sewer creatures are merely evolving! 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[You're joking, right?

]=] .. [=[Customer Relations: ]=] .. [=[Not at all! Why...I feel for those poor creatures, I really do! Thousands and thousands of years of crawling on their bellies, and now that they're finally starting to evolve into intelligent bipeds, here you come and try to pretend that they didn't do it on their own! That they had to have some sort of 'magic' help from some sort of fantasy nuclear waste products! You really are a rude and despicable person. Please leave. I just can't deal with how inconsiderate you are.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_e = nil
local function arm_n0_g0_e(player)
	if shown_n0_g0_e ~= nil then return shown_n0_g0_e end
	if (player.toxic_quest_desc or 0) < 5 then
		player.toxic_quest_desc = 4
		shown_n0_g0_e = [=[1]=]
		return shown_n0_g0_e
	end
	shown_n0_g0_e = [=[]=]
	return shown_n0_g0_e
end
newChat{ id=[=[n0_g0_e]=],
	text = function(npc, player)
		local which = arm_n0_g0_e(player)
		if which == [=[1]=] then return [=[Customer Relations: ]=] .. [=[Nuclear waste? Nonsense! Our only by prodicts are the perfetly legal-oh. You have it with you? Let me see. Ahh. Hmm. Yes, this does appear to be ours. BUT! You see how it is in a perfetly secure container? This just proves how responsible our company is, going to such great lengths to protect the environment! Why, there's aren't ANY federal regulations requiring nuclear waste dumped in the sewers to be tightly secured like this!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Probably because you're not suposed to do it at all.]=] .. [=[Customer Relations: ]=] .. [=[That's totally besides the point. Here we are going above and beyond the call of duty to keep our products safe, and you're accusing uf os some sort of malfeasence? Don't you care about the environment?!!? I feel bad for you. I really do.

]=] end
		if which == [=[]=] then return [=[Customer Relations: ]=] .. [=[Nuclear waste? Nonsense! Our only by prodicts are the perfetly legal-oh. You have it with you? Let me see. Ahh. Hmm. Yes, this does appear to be ours. BUT! You see how it is in a perfetly secure container? This just proves how responsible our company is, going to such great lengths to protect the environment! Why, there's aren't ANY federal regulations requiring nuclear waste dumped in the sewers to be tightly secured like this!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Probably because you're not suposed to do it at all.]=] .. [=[Customer Relations: ]=] .. [=[That's totally besides the point. Here we are going above and beyond the call of duty to keep our products safe, and you're accusing uf os some sort of malfeasence? Don't you care about the environment?!!? I feel bad for you. I really do.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_f]=],
	text = [=[Customer Relations: ]=] .. [=[Toxic sludge? What toxic sludge? Oh! You mean our clean-air disposal process! That's not toxic sludge! That's environmentally-friendly manfacturing residue, certified by two separate federal entities to be acceptably benign and reasonably free of harmful contaminants! We at Widget Co. pride ourselves on our policy to absolutely conform to government regulations and our ability to surpass even the strictest requirements!

]=],
	answers = {
		{[=[Hmm. Ok, I guess that's ok then.]=], jump=[=[n0_g0_f_a]=], action=function(npc, player) player.toxic_quest_desc = 3 end},
		{[=[Look...I took poison damage just from walking through the stuff. Can you imagine what tons of that stuff sitting around for years in the open air is going to do?]=], jump=[=[n0_g0_f_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g0_f_a = nil
local function arm_n0_g0_f_a(player)
	if shown_n0_g0_f_a ~= nil then return shown_n0_g0_f_a end
	player.toxic_quest_desc = 3
	shown_n0_g0_f_a = [=[]=]
	return shown_n0_g0_f_a
end
newChat{ id=[=[n0_g0_f_a]=],
	text = function(npc, player)
		local which = arm_n0_g0_f_a(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_f_b]=],
	text = [=[Customer Relations: ]=] .. [=[Look, federal regulations say we're not allowed to discharge waste with more than 500 radioactive, toxic, or biologically active parts per thousand. Our by-products are only 498 parts per thousand. You know what the rest is? WATER! Water is totally harmless! You drink it every day, your own body is MADE of the stuff. Do you realize that YOU are roughly seventy percent water? That means our manufacturing by-products are only twenty percent away from matching the water concentration of your body! You could probably drink the stuff and it would be perfectly safe!

]=] .. [=[(He suddenly realizes something...and his eyes narrow)

]=] .. [=[Customer Relations: ]=] .. [=[Wait...did you say that you WALKED in it?

]=],
	answers = {
		{[=[Yes.]=], jump=[=[n0_g0_f_b_a]=], action=function(npc, player) player.toxic_quest_desc = 1 end},
		{[=[Me? No, you must have misheard me.]=], jump=[=[n0_g0_f_b_b]=], action=function(npc, player) player.toxic_quest_desc = 2 end},
		{"[Leave]"},
	},
}

local shown_n0_g0_f_b_a = nil
local function arm_n0_g0_f_b_a(player)
	if shown_n0_g0_f_b_a ~= nil then return shown_n0_g0_f_b_a end
	player.toxic_quest_desc = 1
	shown_n0_g0_f_b_a = [=[]=]
	return shown_n0_g0_f_b_a
end
newChat{ id=[=[n0_g0_f_b_a]=],
	text = function(npc, player)
		arm_n0_g0_f_b_a(player)
		return [=[(He backs up with a look of horror on his face, and quickly covers his mouth)

]=] .. [=[Customer Relations: ]=] .. [=[Contamination alert! I need security here NOW!

]=] .. [=[(Within seconds, three burly guards wearing full body radiation suits burst into the room, grab you and throw you outside.)

]=] .. [=[(Or at least they will...as soon as I figure out a way to remove you from the store myself. In the meantime though, if you could just press 'escape' a couple times that would be very helpful. Thank you.)

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_f_b_b = nil
local function arm_n0_g0_f_b_b(player)
	if shown_n0_g0_f_b_b ~= nil then return shown_n0_g0_f_b_b end
	player.toxic_quest_desc = 2
	shown_n0_g0_f_b_b = [=[]=]
	return shown_n0_g0_f_b_b
end
newChat{ id=[=[n0_g0_f_b_b]=],
	text = function(npc, player)
		arm_n0_g0_f_b_b(player)
		return [=[Customer Relations: ]=] .. [=[Good. Because the entire area surrounding the plant is private property. We could easily have you arrested and thrown away for a very long time if you were to trespass. Now, I suggest you get out of here before I have security throw you out. And kindly don't come back with these slanderous lies and ridiculous accusations.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
