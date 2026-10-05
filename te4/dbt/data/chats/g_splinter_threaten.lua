-- dbt-generated-talk dialogue.SPLINTER_THREATEN
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if true then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Master Splinter: ]=] .. [=[Sent you to kill me, perhaps to join my disciples? My children? I will not fear death, when it comes...but do not think that I shall embrace it easily.

]=] end
		if which == [=[]=] then return [=[Michaelangelo: ]=] .. [=[Whoa, dude! This is not cool!

]=] .. [=[Leonardo: ]=] .. [=[Keep away from master Splinter!

]=] .. [=[Leonardo: ]=] .. [=[Splinter: ]=] .. [=[Hold, my pupils. No blood has been drawn, and for the moment this newcomer appears content to talk. Well, then...you have our attention. What have you to say?

]=] .. [=[Splinter: ]=] .. [=[I see. And why do you stop to tell me this? 

]=] end
		return "..."
	end,
	answers = {
		{[=[I am distrustful of Saki. I would like to hear your side of things before I decide which side is more deserving of my help.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I have not chosen a side. I have not even decided I want to be involved. However, I perceive more honor in clearly making these things known.]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[Oh, nothing. I just wanted you to know before I killed you, is all. (attack)]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[Some turtles killed path not implemented]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Splinter: ]=] .. [=[As with most things, there are more 'sides' than merely two. I cannot say which is best for you to to support, however, speaking for myself, I would not gladly accept the help of anyone who would so casually kill simply to promote the cause of one they believed more most worthy. I cannot say if this means you would be best serving the side of Saki, or not. But, it is clear that you lack the moral character that might otherwise have allowed you to serve ours.

Do as you will.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		return [=[Splinter: ]=] .. [=[There is wisdom in your words. Each of us must strive to do what we know in our hearts to be best. I cannot decide what is best for another, each must make that decision himself.]=] .. (player.name or "you") .. [=[: ]=] .. [=[Why does Saki want you dead?

]=] .. [=[Splinter: ]=] .. [=[Why would you kill a stranger merely because another wishes it?]=]
	end,
	answers = {
		{[=[You didn't answer my question.]=], jump=[=[n0_b_a]=]},
		{[=[Ok. You annoy me. I'm going to kill you after all. (attack)]=], jump=[=[n0_b_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_b_a = nil
local function arm_n0_b_a(player)
	if shown_n0_b_a ~= nil then return shown_n0_b_a end
	if (false or (player.trainers and player.trainers.NINJUTSU)) then
		shown_n0_b_a = [=[1]=]
		return shown_n0_b_a
	end
	shown_n0_b_a = [=[]=]
	return shown_n0_b_a
end
newChat{ id=[=[n0_b_a]=],
	text = function(npc, player)
		local which = arm_n0_b_a(player)
		if which == [=[1]=] then return [=[Splinter: ]=] .. [=[That is true. Very well. I shall answer you.

Oroku Saki is the leader of The Foot ninja clan. His students engage in regular thefts throughout the city in order to fund his clan. We oppose their misdeeds. We have killed none of his students, however we have interfered on many occassions, and I do not doubt that our interferance has caused substantial financial loss to his clan.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[So you are also a ninja master?

]=] .. [=[Splinter: ]=] .. [=[Suffice it to say that we study the martial arts, and we do interfere with the illegal actions of his clan.

]=] end
		if which == [=[]=] then return [=[Splinter: ]=] .. [=[That is true. Very well. I shall answer you.

Oroku Saki is the leader of The Foot ninja clan. His students engage in regular thefts throughout the city in order to fund his clan. We oppose their misdeeds. We have killed none of his students, however we have interfered on many occassions, and I do not doubt that our interferance has caused substantial financial loss to his clan.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[So you are also a ninja master?

]=] .. [=[Splinter: ]=] .. [=[Suffice it to say that we study the martial arts, and we do interfere with the illegal actions of his clan.

]=] end
		return "..."
	end,
	answers = {
		{[=[I see. Very well then. For reasons I will not disclose, I must remain neutral in this fued.]=], jump=[=[n0_b_a_b]=], cond=function(npc, player) return arm_n0_b_a(player) == [=[1]=] end},
		{[=[This sounds like warfare between two ninja clans. I don't think I want to be involved in this.]=], jump=[=[n0_b_a_a]=], cond=function(npc, player) return arm_n0_b_a(player) == "" end},
		{[=[So you are interfering with his clan. That's good enough reason for me. Thank you for explaining. I'm going to kill you now. (attack)]=], jump=[=[n0_b_a_c]=], cond=function(npc, player) return arm_n0_b_a(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a_b]=],
	text = [=[Splinter: ]=] .. [=[I understand.

]=] .. [=[Michaelangelo: ]=] .. [=[Whoa! Dude, is ]=] .. [=[ a ni-

]=] .. [=[Splinter: ]=] .. [=[Michaelangelo! Allow our guest some courtesy.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
