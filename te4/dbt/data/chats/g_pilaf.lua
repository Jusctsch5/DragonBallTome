-- dbt-generated-talk dialogue.PILAF
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if ((player.mai or 0) + (player.shuu or 0)) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if ((player.mai or 0) == 0) and ((player.shuu or 0) == 1) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if ((player.mai or 0) == 1) and ((player.shuu or 0) == 0) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if not ((((player.mai or 0) + (player.shuu or 0)) == 0) or (((player.mai or 0) == 0) and ((player.shuu or 0) == 1)) or (((player.mai or 0) == 1) and ((player.shuu or 0) == 0))) then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.dragonballs and next(player.dragonballs) ~= nil) then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.quests and player.quests.pilaf_execute and player.quests.pilaf_execute.status == "taken") then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.quests and player.quests.pilaf_return and player.quests.pilaf_return.status == "taken") then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	if (player.quests and player.quests.pilaf_rra and player.quests.pilaf_rra.status == "taken") then
		shown_n0 = [=[8]=]
		return shown_n0
	end
	if (player.quests and player.quests.pilaf_rra and player.quests.pilaf_rra.status == "completed") then
		shown_n0 = [=[9]=]
		return shown_n0
	end
	if (player.pilaf_interupted or 0) == 1 then
		player.pilaf_interupted = 0
		player:takeQuest("pilaf_rra", "taken")
		player:takeQuest("pilaf_dragonballs", "taken")
		shown_n0 = [=[10]=]
		return shown_n0
	end
	if (player.pilaf_polite_done or 0) == 1 then
		shown_n0 = [=[11]=]
		return shown_n0
	end
	if (player.pilaf_polite_done or 0) == 2 then
		shown_n0 = [=[12]=]
		return shown_n0
	end
	if (player.pilaf_polite_done or 0) == 3 then
		shown_n0 = [=[13]=]
		return shown_n0
	end
	if (player.quests and player.quests.pilaf_rubble and player.quests.pilaf_rubble.status == "taken") then
		player:takeQuest("pilaf_rubble", "finished")
		shown_n0 = [=[14]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Emperor Pilaf: ]=] .. [=[...I hope we can work past our previous misunderstandings...]=] end
		if which == [=[2]=] then return [=[Emperor Pilaf: ]=] .. [=[Mai! Kill this traitorous buffoon!]=] end
		if which == [=[3]=] then return [=[Emperor Pilaf: ]=] .. [=[Shuu! Kill this traitor!]=] end
		if which == [=[4]=] then return [=[Emperor Pilaf: ]=] .. [=[You will die terribly, horribly and painfully! Hahahah!!!]=] end
		if which == [=[5]=] then return [=[...]=] end
		if which == [=[6]=] then return [=[Implement path!]=] end
		if which == [=[7]=] then return [=[Implement path!]=] end
		if which == [=[8]=] then return [=[Emperor Pilaf: ]=] .. [=[Take your time. The Army is a powerful adversary, and I am willing to wait for results.

]=] end
		if which == [=[9]=] then return [=[Emperor Pilaf: ]=] .. [=[Hahah! Great victory! This should be implemented!]=] end
		if which == [=[10]=] then return [=[Emperor Pilaf: ]=] .. [=[See what I mean?!?! They're an absolute abomination, and running amuck everywhere! Servant, I command you to destroy the Red Ribbon Army and retrieve the Dragonballs!

]=] end
		if which == [=[11]=] then return [=[Emperor Pilaf: ]=] .. [=[Ahh...]=] .. [=[ returns to gape at my majesty.]=] end
		if which == [=[12]=] then return [=[Emperor Pilaf: ]=] .. [=[Get out of here you buffoon!]=] end
		if which == [=[13]=] then return [=[Emperor Pilaf: ]=] .. [=[Hello, again.]=] end
		if which == [=[14]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{[=[No, actually I didn't come to give you this.]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[(Sorry. Not implemented) Sure. Here you go, Oh Emperor Pilaf.]=], jump=[=[n0_g4_b]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[Oops. (Run!)]=], jump=[=[n0_g4_c]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a]=],
	text = [=[Emperor Pilaf: ]=] .. [=[Oh.

]=] .. [=[Mai: ]=] .. [=[I think that was the wrong answer, wasn't it?

]=] .. [=[Emperor Pilaf: ]=] .. [=[I think you're right, Mai. I think 'Of course, oh wise and noble Emperor Pilaf...SIR was the correct answer.

]=] .. [=[Mai: ]=] .. [=[Maybe...but I don't remember seeing that as one of the dialogue options.

]=] .. [=[Emperor Pilaf: ]=] .. [=[Ahhh! That explains it then. Let's try this again with that as an option, shall we?

]=],
	answers = {
		{[=[I'm not handing it over.]=], jump=[=[n0_g4_a_a]=]},
		{[=[(Also not implemented) Of course, oh wise and noble Emperor Pilaf...SIR!]=], jump=[=[n0_g4_a_b]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_a]=],
	text = [=[Emperor Pilaf: ]=] .. [=[Oh. That's ok. I don't mind. Mai! Shuu! Kill ]=] .. [=[!

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_b]=],
	text = [=[Delivered! (Implement branch)]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_c]=],
	text = [=[Emperor Pilaf: ]=] .. [=[Mai! Shuu! Kill ]=] .. [=[!]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_d]=],
	text = [=[(There is a few monets of silence.)

]=] .. [=[Emperor Pilaf: ]=] .. [=[Hmm. Maybe. Oh, I don't know...what do you think, Mai?

]=] .. [=[Mai: ]=] .. [=[I don't buy it. I think it's a trick.

]=] .. [=[Emperor Pilaf: ]=] .. [=[Of course, but come on...]=] .. [=[ charisma is ]=] .. [=[. That's got to be worth something?

]=] .. [=[Mai: ]=] .. [=[Oh, come now...the last person who tried that had a charisma of ]=] .. [=[ at least, and you didn't let her get away.

]=] .. [=[Emperor Pilaf: ]=] .. [=[Oh, all right. I was feeling generous, but if you insist. Kill ]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
