-- dbt-generated-talk dialogue.GEORGE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.destroy_the_foot and player.quests.destroy_the_foot.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.destroy_the_foot and player.quests.destroy_the_foot.status == "completed") then
		player:takeQuest("destroy_the_foot", "finished")
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.destroy_the_foot and player.quests.destroy_the_foot.status == "finished") then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if not (player.quests and player.quests.stolen_goods) then
		player:takeQuest("stolen_goods", "taken")
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.quests and player.quests.stolen_goods and player.quests.stolen_goods.status == "taken") then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Please hurry! I'm losing money every day those ninja stay in operation!]=] end
		if which == [=[2]=] then return [=[George: ]=] .. [=[Hello! I just received my first shipment in months! You really did it! Thank you so much! Here, let me me pay in full all the money I agreed to give you. Now that I actually have something to sell, I should be able to get my business running again. ]=] .. [=[Of course, I hope it doesn't run so fast I can't catch it! ]=] .. [=[Hehe...that's a little joke. In any case, thank you for your help!]=] end
		if which == [=[3]=] then return [=[Thank you again for putting me back in business!]=] end
		if which == [=[4]=] then return [=[George: ]=] .. [=[Business has been tough lately. Half of my shipments are being hijacked en route. I have insurance, but I still need to have merchandise to sell! I don't know much about what's going on, but I'd pay a pretty penny to anyone who could find out.

]=] end
		if which == [=[5]=] then return [=[George: ]=] .. [=[Have you any new information for me on who's been hijacking my shipments?

]=] end
		return "..."
	end,
	answers = {
		{[=[No, nothing yet.]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
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
	if (player.goods_splinter or 0) == 2 then
		shown_n0_g4_c = [=[1]=]
		return shown_n0_g4_c
	end
	if (player.goods_akira or 0) == 2 then
		shown_n0_g4_c = [=[2]=]
		return shown_n0_g4_c
	end
	if not (((player.goods_splinter or 0) == 2) or ((player.goods_akira or 0) == 2)) then
		shown_n0_g4_c = [=[3]=]
		return shown_n0_g4_c
	end
	player.goods_lazarus = 2
	shown_n0_g4_c = [=[]=]
	return shown_n0_g4_c
end
newChat{ id=[=[n0_g4_c]=],
	text = function(npc, player)
		local which = arm_n0_g4_c(player)
		if which == [=[1]=] then return [=['Men in black' huh? That certainly would corroborate the story your rat friend gave us. I know we're on the right track, but I still don't have enough that I could go to the police with. What am I going to tell them? Some random mutant who's a ninja, but isn't bad, says that the guys who Lazarus is buying stuff from are also ninja...but are bad? I still need more.

]=] end
		if which == [=[2]=] then return [=['Men in black?' Hmm. I guess that would make sense if the ninja Akira mentioned have set up shop here. Oh dear...this sounds like it may be a lot more than just a bunch of thieves like I suspected. Still, so far it's all just speculation. Men in black...an event from years ago in Japan...you're doing well, but I really need something more substantial.

]=] end
		if which == [=[3]=] then return [=[Still...we have no idea who's actually responsible. 'Men in black' isn't exactly very helpful. I need more information than that.

]=] end
		if which == [=[]=] then return [=[George: ]=] .. [=[Lazarus! That rat! I should have known he'd be mixed up in this. You'd think anyone who's been around as long as he has would have learned to play nice by now. ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_d = nil
local function arm_n0_g4_d(player)
	if shown_n0_g4_d ~= nil then return shown_n0_g4_d end
	if (player.goods_splinter or 0) == 2 then
		shown_n0_g4_d = [=[1]=]
		return shown_n0_g4_d
	end
	if (player.goods_lazarus or 0) == 2 then
		shown_n0_g4_d = [=[2]=]
		return shown_n0_g4_d
	end
	if not (((player.goods_splinter or 0) == 2) or ((player.goods_lazarus or 0) == 2)) then
		shown_n0_g4_d = [=[3]=]
		return shown_n0_g4_d
	end
	player.goods_akira = 2
	shown_n0_g4_d = [=[]=]
	return shown_n0_g4_d
end
newChat{ id=[=[n0_g4_d]=],
	text = function(npc, player)
		local which = arm_n0_g4_d(player)
		if which == [=[1]=] then return [=[Hmm. I know Akira. He's a good man. And what he's saying does go along with the ninja story your rat gave you. Look, maybe I'm convinced...but we still don't have the kind of solid evidence I need if I were to go to the police. I need more.

]=] end
		if which == [=[2]=] then return [=[Ninja? I guess that would explain the 'men in black' that Lazarus said he was buying from. So far, this is all just speculation though. I need something solid.

]=] end
		if which == [=[3]=] then return [=[So you're saying that ninja are responsible for this? Sorry...I have a tough time buying that. Sure...some crazy stuff goes on in this world, but it seems to me there are far simpler explanations. Occam's Razor, and all. Look...let's pretend for a moment it really is ninja who are responsible. I need something substantial to prove it. I can't just go to the police and say 'Hey! Some random Japanese guy says this kind of resembled something that happened years ago in Japan! Go arrest somebody!' It just doesn't work that way. At this point, I'm losing so much money I really wouldn't care if it were ninja, you or the Easter Bunny responsible, but whomever it is, I need proof.

]=] end
		if which == [=[]=] then return [=[George: ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_e = nil
local function arm_n0_g4_e(player)
	if shown_n0_g4_e ~= nil then return shown_n0_g4_e end
	if (player.quests and player.quests.criminal and player.quests.criminal.status == "taken") then
		shown_n0_g4_e = [=[1]=]
		return shown_n0_g4_e
	end
	if true then
		shown_n0_g4_e = [=[2]=]
		return shown_n0_g4_e
	end
	if player:effStat("chr") >= 12 then
		shown_n0_g4_e = [=[3]=]
		return shown_n0_g4_e
	end
	player.goods_warehouse = 2
	shown_n0_g4_e = [=[]=]
	return shown_n0_g4_e
end
newChat{ id=[=[n0_g4_e]=],
	text = function(npc, player)
		local which = arm_n0_g4_e(player)
		if which == [=[1]=] then return [=[I hear they can't even catch that crazy ]=] .. [=[ who threatened Sakura. Poor girl. ]=] end
		if which == [=[2]=] then return [=[done ok, I guess.]=] end
		if which == [=[3]=] then return [=[George: ]=] .. [=[You actually saw ninja running around with boxes of electronics? Wow...maybe we're really on to something here. But what am I going to do about a band of ninja thieves? I don't think the police will be able to deal with this. ]=] .. [=[Well...I did promise you a reward for finding out what was going on, and you've ]=] .. [=[completely surpassed my expecations.]=] .. [=[done rather well.]=] .. [=[discovered some good information.]=] .. [=[ Here's ]=] .. [=[ zeni right now. You've earned it.

]=] .. [=[(Received ]=] .. [=[ zeni)

]=] .. [=[Unfortunately, even knowing who's responsible doesn't help me all that much. The police aren't going to buy our story, my shipments are still being hijacked, and I'm losing money every day. So let me make you a deal. If you can completely put a stop to their operation, I'll give you double what I've already given you. That's ]=] .. [=[ zeni on top of what I've already paid you. You interested?

]=] end
		if which == [=[]=] then return [=[George: ]=] .. [=[You actually saw ninja running around with boxes of electronics? Wow...maybe we're really on to something here. But what am I going to do about a band of ninja thieves? I don't think the police will be able to deal with this. ]=] .. [=[Well...I did promise you a reward for finding out what was going on, and you've ]=] .. [=[completely surpassed my expecations.]=] .. [=[done rather well.]=] .. [=[discovered some good information.]=] .. [=[ Here's ]=] .. [=[ zeni right now. You've earned it.

]=] .. [=[(Received ]=] .. [=[ zeni)

]=] .. [=[Unfortunately, even knowing who's responsible doesn't help me all that much. The police aren't going to buy our story, my shipments are still being hijacked, and I'm losing money every day. So let me make you a deal. If you can completely put a stop to their operation, I'll give you double what I've already given you. That's ]=] .. [=[ zeni on top of what I've already paid you. You interested?

]=] end
		return "..."
	end,
	answers = {
		{[=[(Persuade 12) Gee, I don't know. The money's ok, I guess, but we're talking an entire ninja clan...and like you say, you're losing money every day, and the police aren't going to help you. Is ]=] .. [=[ really all it's worth to you to stay in business?]=], jump=[=[n0_g4_e_b]=], action=function(npc, player) player:takeQuest("stolen_goods", "finished") player:takeQuest("destroy_the_foot", "taken") end, cond=function(npc, player) return arm_n0_g4_e(player) == [=[3]=] end},
		{[=[That's a good offer. Alright. I'll see what I can do.]=], jump=[=[n0_g4_e_a]=], action=function(npc, player) player:takeQuest("stolen_goods", "finished") player:takeQuest("destroy_the_foot", "taken") end, cond=function(npc, player) return arm_n0_g4_e(player) == "" end},
		{[=[No, I was happy to play detective for you, but I'm not about to take on an entire ninja clan]=], jump=[=[n0_g4_e_c]=], action=function(npc, player) player.goods_store_closed = 1 player:takeQuest("stolen_goods", "finished") end, cond=function(npc, player) return arm_n0_g4_e(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_g4_e_a = nil
local function arm_n0_g4_e_a(player)
	if shown_n0_g4_e_a ~= nil then return shown_n0_g4_e_a end
	player:takeQuest("stolen_goods", "finished")
	player:takeQuest("destroy_the_foot", "taken")
	shown_n0_g4_e_a = [=[]=]
	return shown_n0_g4_e_a
end
newChat{ id=[=[n0_g4_e_a]=],
	text = function(npc, player)
		arm_n0_g4_e_a(player)
		return [=[George: ]=] .. [=[Great! If things didn't get better soon, I probably would have had to close my shop, but once those shipments start coming again, I'll be back in business! Let me know as soon as those ninja are gone. The money will be as good as yours!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_e_b = nil
local function arm_n0_g4_e_b(player)
	if shown_n0_g4_e_b ~= nil then return shown_n0_g4_e_b end
	player:takeQuest("stolen_goods", "finished")
	player:takeQuest("destroy_the_foot", "taken")
	shown_n0_g4_e_b = [=[]=]
	return shown_n0_g4_e_b
end
newChat{ id=[=[n0_g4_e_b]=],
	text = function(npc, player)
		arm_n0_g4_e_b(player)
		return [=[George: ]=] .. [=[Well, I guess you're right. It's either you or...bankruptcy. Ok. I'll double my offer. That's ]=] .. [=[zeni. That's really the best I can do. Let me know when they're gone. If things don't improve soon I'm going to have to close down my shop.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_e_c = nil
local function arm_n0_g4_e_c(player)
	if shown_n0_g4_e_c ~= nil then return shown_n0_g4_e_c end
	player.goods_store_closed = 1
	player:takeQuest("stolen_goods", "finished")
	shown_n0_g4_e_c = [=[]=]
	return shown_n0_g4_e_c
end
newChat{ id=[=[n0_g4_e_c]=],
	text = function(npc, player)
		arm_n0_g4_e_c(player)
		return [=[George: ]=] .. [=[I...understand. Honestly, I wouldn't go near them myself. I'm sorry I can't offer you more money, but I'm just about broke from all this. I guess I'll just have to close up shop. Maybe I'll relocate to a safer area. Alright, well...thanks for your help. I appreciate it. I just wish things had turned out better.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
