-- dbt-generated-talk dialogue.BALLET
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.ballet_pre and player.quests.ballet_pre.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.ballet_pre and player.quests.ballet_pre.status == "failed_done") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.quests and player.quests.ballet_pre and player.quests.ballet_pre.status == "finished") then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if not (player.quests and player.quests.ballet_pre) then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.ballet_pre and player.quests.ballet_pre.status == "taken")) or ((player.quests and player.quests.ballet_pre and player.quests.ballet_pre.status == "failed_done")) or ((player.quests and player.quests.ballet_pre and player.quests.ballet_pre.status == "finished")) or (not (player.quests and player.quests.ballet_pre))) then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[
Sakura: ]=] .. [=[Hello again. Thank you for your help, but one of the parents of a child that never came back was filed a lawsuit against me, and I don't think I'll be in business much longer. I'm sorry things turned out like this. Still, I'm gratefull for your help. Thank you.

]=] end
		if which == [=[3]=] then return [=[Hello! :) Nice to see you again.]=] end
		if which == [=[4]=] then return [=[
Sakura: ]=] .. [=[Hello. I'm terribly sorry. Our upcoming performance of Tchaikovsky's Nutcracker has been canceled. Please accept my apologies. And yes, tickets will be refunded in full.

]=] end
		if which == [=[5]=] then return [=[Error: quest status in actions.lua is a type I'm not using]=] end
		return "..."
	end,
	answers = {
		{[=[Sorry to hear it.]=], jump=[=[n0_g3_a]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[If you don't mind me asking, why was the performance canceled?]=], jump=[=[n0_g3_b]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_b]=],
	text = [=[
Sakura: ]=] .. [=[It's...umm...complicated. Oh, wait...you don't look like you're here for the performance. Are you an adventurer, by chance?

]=],
	answers = {
		{[=[Oh, goodness, no! Adventures are dreadful things that make one late for dinner.]=], jump=[=[n0_g3_b_a]=]},
		{[=[Actually, I was hoping to enroll for classes.]=], jump=[=[n0_g3_b_b]=]},
		{[=[Yes, I'm an adventurer. Is there anything I can do to help you?]=], jump=[=[n0_g3_b_c]=], action=function(npc, player) player:takeQuest("ballet_pre", "taken") end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_b_a]=],
	text = [=[
Sakura: ]=] .. [=[Oh, I'm sorry. My mistake. Please accept my apologies. I only hope I'll be able to keep my studio open after this catastrophe.
]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_b_b]=],
	text = [=[
Sakura: ]=] .. [=[Oh. I'd love to take you but I'm afraid I have a bit of a problem right now, and all classes are postponed until it has been resolved. Please come back again another time.
]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_b_c = nil
local function arm_n0_g3_b_c(player)
	if shown_n0_g3_b_c ~= nil then return shown_n0_g3_b_c end
	player:takeQuest("ballet_pre", "taken")
	shown_n0_g3_b_c = [=[]=]
	return shown_n0_g3_b_c
end
newChat{ id=[=[n0_g3_b_c]=],
	text = function(npc, player)
		arm_n0_g3_b_c(player)
		return [=[
Sakura: ]=] .. [=[Oh, how wonderful! I've a terrible problem! My dancer for the part of 'King Mouse' has gone completely insane! It's horrible! It happened during our final dress rehearsal before opening night. During his battle with the Nutcracker, when Clara threw her shoe she well, missed...sort of. Instead of hitting him in the head, in landed on the ground nearby, and he slipped on it and hit his head! When he came up he was frothing at the mouse and babbling nonsense. He ran out of the room and several of the boy and girl dancer mice followed right after him! That's exactly what they were choreographed to do, of course, but now a dozen children are missing, and parents are really starting to worry. Please, would you find them and bring them back? I'm ruined if they can't be found!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_c]=],
	text = function(npc, player)
		return [=[
Sakura: ]=] .. [=[...I...umm, steam?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Yes. Lots of it.

]=] .. [=[
Sakura: ]=] .. [=[...I don't know...I'm not very mechanically inclined. I just teach dance and theater here with the troupe. I mean, the school. Maybe it's the tenants next door?

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
