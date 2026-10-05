-- dbt-generated-talk dialogue.SHENRON
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[I respond, oh summoner, and I shall grant you any single wish that is within my power. What say you?

]=],
	answers = {
		{[=[How exactly does this work? It's been a lot of effort gathering up the dragonballs. I'd like to do this right.]=], jump=[=[n0_a]=]},
		{[=[I am ready to make my wish.]=], jump=[=[n0_b]=]},
		{"I wish...", action=function(npc, player) player:promptWish() end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[You are wise to ask such a question. Many who have preceeded you have not asked this simple thing. Very well, I will answer:

]=] .. [=[Wishes must begin with 'I wish'. I advise you to speak clearly, and to not garble your words. Understand that wishes are intelligent, and it is best to allow them to handle the details. Do not ask for specific numbers of anything. Your wish need not be simply for a physical object, though you may wish for such if it pleases you. Only one wish will be granted, and attempting to make multiple wishes through clever phrasing will generally result in disappointment. For a properly phrased wish, however, very little is beyond my power, but those few things which are may not be wished for. In particular I cannot cause anyone to die, and I cannot compell the hearts or minds of conscious beings against their will. Anything else is within my domain. Are you ready?

]=],
	answers = {
		{[=[I am ready.]=], jump=[=[n0_a_a]=]},
		{"[Leave]"},
	},
}

local shown_n0_a_a = nil
local function arm_n0_a_a(player)
	if shown_n0_a_a ~= nil then return shown_n0_a_a end
	if true then
		shown_n0_a_a = [=[1]=]
		return shown_n0_a_a
	end
	shown_n0_a_a = [=[]=]
	return shown_n0_a_a
end
newChat{ id=[=[n0_a_a]=],
	text = function(npc, player)
		local which = arm_n0_a_a(player)
		if which == [=[1]=] then return [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[I am uncertain what you are asking for. Try rephrasing it.

]=] end
		if which == [=[]=] then return [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Granted]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Enough of this nonsense! I shall waste my time with you no longer.

]=] end
		return "..."
	end,
	answers = {
		{[=[Yes.]=], jump=[=[n0_a_a_a]=], cond=function(npc, player) return arm_n0_a_a(player) == "" end},
		{[=[No, that's not what I meant.]=], jump=[=[n0_a_a_b]=], cond=function(npc, player) return arm_n0_a_a(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_a_a]=],
	text = [=[
Shenron, the Eternal Dragon of the Earth: ]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_a_b = nil
local function arm_n0_a_a_b(player)
	if shown_n0_a_a_b ~= nil then return shown_n0_a_a_b end
	if true then
		shown_n0_a_a_b = [=[1]=]
		return shown_n0_a_a_b
	end
	shown_n0_a_a_b = [=[]=]
	return shown_n0_a_a_b
end
newChat{ id=[=[n0_a_a_b]=],
	text = function(npc, player)
		local which = arm_n0_a_a_b(player)
		if which == [=[1]=] then return [=[
Shenron, the Eternal Dragon of the Earth: ]=] .. [=[My patience is growing thin. Make your wish and be done with it.

]=] end
		if which == [=[]=] then return [=[
Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Very well.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_b = nil
local function arm_n0_a_b(player)
	if shown_n0_a_b ~= nil then return shown_n0_a_b end
	if true then
		shown_n0_a_b = [=[1]=]
		return shown_n0_a_b
	end
	shown_n0_a_b = [=[]=]
	return shown_n0_a_b
end
newChat{ id=[=[n0_a_b]=],
	text = function(npc, player)
		local which = arm_n0_a_b(player)
		if which == [=[1]=] then return [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[I am uncertain what you are asking for. Try rephrasing it.

]=] end
		if which == [=[]=] then return [=[(Shenron looks a little annoyed)

]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Very well, mortal, but make haste. I do not relish my compulsory sojourns to this insubstantial realm. What would you ask of me?

]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Granted]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Enough of this nonsense! I shall waste my time with you no longer.

]=] end
		return "..."
	end,
	answers = {
		{[=[Yes.]=], jump=[=[n0_a_b_a]=], cond=function(npc, player) return arm_n0_a_b(player) == "" end},
		{[=[No, that's not what I meant.]=], jump=[=[n0_a_b_b]=], cond=function(npc, player) return arm_n0_a_b(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a_b_a]=],
	text = [=[
Shenron, the Eternal Dragon of the Earth: ]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_b_b = nil
local function arm_n0_a_b_b(player)
	if shown_n0_a_b_b ~= nil then return shown_n0_a_b_b end
	if true then
		shown_n0_a_b_b = [=[1]=]
		return shown_n0_a_b_b
	end
	shown_n0_a_b_b = [=[]=]
	return shown_n0_a_b_b
end
newChat{ id=[=[n0_a_b_b]=],
	text = function(npc, player)
		local which = arm_n0_a_b_b(player)
		if which == [=[1]=] then return [=[
Shenron, the Eternal Dragon of the Earth: ]=] .. [=[My patience is growing thin. Make your wish and be done with it.

]=] end
		if which == [=[]=] then return [=[
Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Very well.

]=] end
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
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[I am uncertain what you are asking for. Try rephrasing it.

]=] end
		if which == [=[]=] then return [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Granted]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Enough of this nonsense! I shall waste my time with you no longer.

]=] end
		return "..."
	end,
	answers = {
		{[=[Yes.]=], jump=[=[n0_b_a]=], cond=function(npc, player) return arm_n0_b(player) == "" end},
		{[=[No, that's not what I meant.]=], jump=[=[n0_b_b]=], cond=function(npc, player) return arm_n0_b(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b_a]=],
	text = [=[
Shenron, the Eternal Dragon of the Earth: ]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b_b = nil
local function arm_n0_b_b(player)
	if shown_n0_b_b ~= nil then return shown_n0_b_b end
	if true then
		shown_n0_b_b = [=[1]=]
		return shown_n0_b_b
	end
	shown_n0_b_b = [=[]=]
	return shown_n0_b_b
end
newChat{ id=[=[n0_b_b]=],
	text = function(npc, player)
		local which = arm_n0_b_b(player)
		if which == [=[1]=] then return [=[
Shenron, the Eternal Dragon of the Earth: ]=] .. [=[My patience is growing thin. Make your wish and be done with it.

]=] end
		if which == [=[]=] then return [=[
Shenron, the Eternal Dragon of the Earth: ]=] .. [=[Very well.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
