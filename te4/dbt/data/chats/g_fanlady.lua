-- dbt-generated-talk dialogue.FANLADY
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if not (player.quests and player.quests.fan_lady) then
		player:takeQuest("fan_lady", "taken")
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.money or 0) > 99 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.money or 0) > 99)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.alignment or 0) < 0 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The Fan Lady: ]=] .. [=[Hello. I make beautiful fans. If you can find some nice bird feathers, or some other appropriate material to work with, I'll make you a nice fan to keep you cool for only 100 zeni. 

]=] .. [=[The Fan Lady: ]=] .. [=[Hello. Would you like me to make a fan for you, for only 100 zeni? They're really beautiful!

]=] end
		if which == [=[2]=] then return [=[The Fan Lady: ]=] .. [=[Hello. I make beautiful fans. If you can find some nice bird feathers, or some other appropriate material to work with, I'll make you a nice fan to keep you cool for only 100 zeni. 

]=] .. [=[The Fan Lady: ]=] .. [=[Hello. Would you like me to make a fan for you, for only 100 zeni? They're really beautiful!

]=] end
		if which == [=[3]=] then return [=[The Fan Lady: ]=] .. [=[Hello. I make beautiful fans. If you can find some nice bird feathers, or some other appropriate material to work with, I'll make you a nice fan to keep you cool for only 100 zeni. 

]=] .. [=[The Fan Lady: ]=] .. [=[Hello. Would you like me to make a fan for you, for only 100 zeni? They're really beautiful!

]=] end
		if which == [=[4]=] then return [=[The Fan Lady: ]=] .. [=[Hello. I make beautiful fans. If you can find some nice bird feathers, or some other appropriate material to work with, I'll make you a nice fan to keep you cool for only 100 zeni. 

]=] .. [=[The Fan Lady: ]=] .. [=[Hello. Would you like me to make a fan for you, for only 100 zeni? They're really beautiful!

]=] end
		if which == [=[]=] then return [=[The Fan Lady: ]=] .. [=[Hello. I make beautiful fans. If you can find some nice bird feathers, or some other appropriate material to work with, I'll make you a nice fan to keep you cool for only 100 zeni. 

]=] .. [=[The Fan Lady: ]=] .. [=[Hello. Would you like me to make a fan for you, for only 100 zeni? They're really beautiful!

]=] end
		return "..."
	end,
	answers = {
		{[=[Yes, please.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[I'm sorry, I haven't 100 zeni.]=], cond=function(npc, player) return arm_n0(player) == [=[3]=] end},
		{[=[No, thank you.]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if true then
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	player:takeQuest("fan_lady", "finished")
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[The Fan Lady: ]=] .. [=[There you go!]=] end
		if which == [=[]=] then return [=[The Fan Lady: ]=] .. [=[There you go!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_d = nil
local function arm_n0_d(player)
	if shown_n0_d ~= nil then return shown_n0_d end
	if true then
		shown_n0_d = [=[1]=]
		return shown_n0_d
	end
	player:takeQuest("fan_lady", "finished")
	shown_n0_d = [=[]=]
	return shown_n0_d
end
newChat{ id=[=[n0_d]=],
	text = function(npc, player)
		local which = arm_n0_d(player)
		if which == [=[1]=] then return [=[The Fan Lady: ]=] .. [=[There you go!]=] end
		if which == [=[]=] then return [=[The Fan Lady: ]=] .. [=[There you go!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
