-- dbt-generated-talk dialogue.GERO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.gero_state or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.gero_state or 0) == 1 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.gero_state or 0) == 2 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Dr Gero: ]=] .. [=[Hmm? What do you want?  

]=] end
		if which == [=[2]=] then return [=[You fool! You shall die horribly!]=] end
		if which == [=[3]=] then return [=[You fool! You shall die horribly!]=] end
		if which == [=[]=] then return [=[You fool! You shall die horribly!]=] end
		return "..."
	end,
	answers = {
		{[=[Sorry to disturb you. I was exploring the woods and stumbled upon your lab.]=], jump=[=[n0_g0_a]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[I am here to rob you! Put your hands up and give me everything you have of value!]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Umm...nothing! Sorry! I must be lost!]=], jump=[=[n0_g0_c]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{"[Leave]"},
	},
}

local shown_n0_g0_a = nil
local function arm_n0_g0_a(player)
	if shown_n0_g0_a ~= nil then return shown_n0_g0_a end
	if player:effStat("chr") >= 16 then
		shown_n0_g0_a = [=[1]=]
		return shown_n0_g0_a
	end
	shown_n0_g0_a = [=[]=]
	return shown_n0_g0_a
end
newChat{ id=[=[n0_g0_a]=],
	text = function(npc, player)
		local which = arm_n0_g0_a(player)
		if which == [=[1]=] then return [=[Dr Gero: ]=] .. [=[Oh? How unfortunate for you. Minions! Kill this - hmm...no, wait. You could be useful. Now that my Red Ribbon Army lackeys are gone I am in need of a menial servant to run errands for me. Are you capable of following simple instructions?

]=] end
		if which == [=[]=] then return [=[Dr Gero: ]=] .. [=[Oh? How unfortunate for you. Minions! Kill this - hmm...no, wait. You could be useful. Now that my Red Ribbon Army lackeys are gone I am in need of a menial servant to run errands for me. Are you capable of following simple instructions?

]=] end
		return "..."
	end,
	answers = {
		{[=[(Persuade 16) Oh, dear...I'm afraid I really must be going. Fortunately my memory is VERY bad, so I'd never be able to tell anyone where this very nice, tastefully decorated secret lair of yours is.]=], jump=[=[n0_g0_a_e]=], cond=function(npc, player) return arm_n0_g0_a(player) == [=[1]=] end},
		{[=[Yes.]=], jump=[=[n0_g0_a_a]=], cond=function(npc, player) return arm_n0_g0_a(player) == "" end},
		{[=[Simple what...? Ins...inss...uhh...truck shuns?]=], jump=[=[n0_g0_a_b]=], cond=function(npc, player) return arm_n0_g0_a(player) == "" end},
		{[=[Capable, yes. Willing, no.]=], jump=[=[n0_g0_a_c]=], cond=function(npc, player) return arm_n0_g0_a(player) == "" end},
		{[=[So YOU were the evil mastermind behind the Red Ribbon Army! I must destroy you!]=], jump=[=[n0_g0_a_d]=], cond=function(npc, player) return arm_n0_g0_a(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_b]=],
	text = [=[Dr Gero: ]=] .. [=[Hmm. You're too stupid to allow to live. Minions...kill this buffoon.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_c]=],
	text = [=[Dr Gero: ]=] .. [=[Hmm. Interesting specimen. Intelligent and surprisingly strong willed. Yes, you could make an excellent subject. I will give you one last chance to enter into my service voluntarily. Will you serve me?

]=],
	answers = {
		{[=[Hmm. Perhaps allying with with an evil genius would serve my interests after all. I accept, for now.]=], jump=[=[n0_g0_a_c_a]=]},
		{[=[Nope. Not a chance.]=], jump=[=[n0_g0_a_c_b]=]},
		{[=[Oh dear, I'm afraid this is really all just a silly misunderstandting. I...umm...I'm really just here to sell Avon products. You obviously don't need any, so I'll just be on my way...]=], jump=[=[n0_g0_a_c_c]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_c_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_c_b]=],
	text = [=[Dr Gero: ]=] .. [=[Very well, we can do it the hard way. Minions! I want ]=] .. [=[ captured alive!]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_c_c]=],
	text = [=[Dr Gero: ]=] .. [=[No, I don't think so. Minions! I want ]=] .. [=[ captured alive!]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_d]=],
	text = [=[Dr Gero: ]=] .. [=[Oh really? Minions...get rid of this fool.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a_e]=],
	text = [=[Dr Gero: ]=] .. [=[Hmm. Very well. But do not come back.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_a__else]=],
	text = [=[Error: Invalid answer returned by dialogue.answer, location 1]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = [=[Dr Gero: ]=] .. [=[Oh really? Minions...get rid of this fool.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_c]=],
	text = [=[Dr Gero: ]=] .. [=[Well, get yourself lost again!]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0__else]=],
	text = [=[Error: Invalid answer returned by dialogue.answer, location 2]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
