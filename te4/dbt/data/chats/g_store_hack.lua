-- dbt-generated-talk dialogue.STORE_HACK
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
		if which == [=[1]=] then return [=[We appreciates yous bizness. Anytin' else I can do's for ya?
]=] end
		if which == [=[]=] then return [=[Note: I am a TEMPORARY feature to make it easier to playtest Technomancers. Do not get attahced. I won't be here forever.

]=] .. [=[Man in Trenchcoat: ]=] .. [=[Psst. Ya wanna buy some sometin?
]=] .. [=['Dat looks to be jus' a lil' bit outta you's price range. Know what I mean?
]=] .. [=[(You have ]=] .. [=[ zeni)

]=] end
		return "..."
	end,
	answers = {
		{[=[No, thank you.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a resistor, please. (25 zeni)]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a capacitor, please. (25 zeni)]=], jump=[=[n0_c]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a circuit board, please. (25 zeni)]=], jump=[=[n0_d]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a spool of wire, please. (25 zeni)]=], jump=[=[n0_e]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a spool of solder, please. (25 zeni)]=], jump=[=[n0_f]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy an eprom, please. (25 zeni)]=], jump=[=[n0_g]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a mechanical toolkit, please. (600 zeni)]=], jump=[=[n0_h]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy an electrical toolkit, please. (600 zeni)]=], jump=[=[n0_i]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a chemistry set, please. (2500 zeni)]=], jump=[=[n0_j]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[I would like to buy a lathe, please. (7500 zeni)]=], jump=[=[n0_k]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	if (player.money or 0) > 24 then
		shown_n0_b = [=[1]=]
		return shown_n0_b
	end
	if not (((player.money or 0) > 24)) then
		shown_n0_b = [=[2]=]
		return shown_n0_b
	end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_c = nil
local function arm_n0_c(player)
	if shown_n0_c ~= nil then return shown_n0_c end
	if (player.money or 0) > 24 then
		shown_n0_c = [=[1]=]
		return shown_n0_c
	end
	if not (((player.money or 0) > 24)) then
		shown_n0_c = [=[2]=]
		return shown_n0_c
	end
	shown_n0_c = [=[]=]
	return shown_n0_c
end
newChat{ id=[=[n0_c]=],
	text = function(npc, player)
		local which = arm_n0_c(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_d = nil
local function arm_n0_d(player)
	if shown_n0_d ~= nil then return shown_n0_d end
	if (player.money or 0) > 24 then
		shown_n0_d = [=[1]=]
		return shown_n0_d
	end
	if not (((player.money or 0) > 24)) then
		shown_n0_d = [=[2]=]
		return shown_n0_d
	end
	shown_n0_d = [=[]=]
	return shown_n0_d
end
newChat{ id=[=[n0_d]=],
	text = function(npc, player)
		local which = arm_n0_d(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_e = nil
local function arm_n0_e(player)
	if shown_n0_e ~= nil then return shown_n0_e end
	if (player.money or 0) > 24 then
		shown_n0_e = [=[1]=]
		return shown_n0_e
	end
	if not (((player.money or 0) > 24)) then
		shown_n0_e = [=[2]=]
		return shown_n0_e
	end
	shown_n0_e = [=[]=]
	return shown_n0_e
end
newChat{ id=[=[n0_e]=],
	text = function(npc, player)
		local which = arm_n0_e(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_f = nil
local function arm_n0_f(player)
	if shown_n0_f ~= nil then return shown_n0_f end
	if (player.money or 0) > 24 then
		shown_n0_f = [=[1]=]
		return shown_n0_f
	end
	if not (((player.money or 0) > 24)) then
		shown_n0_f = [=[2]=]
		return shown_n0_f
	end
	shown_n0_f = [=[]=]
	return shown_n0_f
end
newChat{ id=[=[n0_f]=],
	text = function(npc, player)
		local which = arm_n0_f(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g = nil
local function arm_n0_g(player)
	if shown_n0_g ~= nil then return shown_n0_g end
	if (player.money or 0) > 24 then
		shown_n0_g = [=[1]=]
		return shown_n0_g
	end
	if not (((player.money or 0) > 24)) then
		shown_n0_g = [=[2]=]
		return shown_n0_g
	end
	shown_n0_g = [=[]=]
	return shown_n0_g
end
newChat{ id=[=[n0_g]=],
	text = function(npc, player)
		local which = arm_n0_g(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_h = nil
local function arm_n0_h(player)
	if shown_n0_h ~= nil then return shown_n0_h end
	if (player.money or 0) > 599 then
		shown_n0_h = [=[1]=]
		return shown_n0_h
	end
	if not (((player.money or 0) > 599)) then
		shown_n0_h = [=[2]=]
		return shown_n0_h
	end
	shown_n0_h = [=[]=]
	return shown_n0_h
end
newChat{ id=[=[n0_h]=],
	text = function(npc, player)
		local which = arm_n0_h(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_i = nil
local function arm_n0_i(player)
	if shown_n0_i ~= nil then return shown_n0_i end
	if (player.money or 0) > 599 then
		shown_n0_i = [=[1]=]
		return shown_n0_i
	end
	if not (((player.money or 0) > 599)) then
		shown_n0_i = [=[2]=]
		return shown_n0_i
	end
	shown_n0_i = [=[]=]
	return shown_n0_i
end
newChat{ id=[=[n0_i]=],
	text = function(npc, player)
		local which = arm_n0_i(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_j = nil
local function arm_n0_j(player)
	if shown_n0_j ~= nil then return shown_n0_j end
	if (player.money or 0) > 2499 then
		shown_n0_j = [=[1]=]
		return shown_n0_j
	end
	if not (((player.money or 0) > 2499)) then
		shown_n0_j = [=[2]=]
		return shown_n0_j
	end
	shown_n0_j = [=[]=]
	return shown_n0_j
end
newChat{ id=[=[n0_j]=],
	text = function(npc, player)
		local which = arm_n0_j(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_k = nil
local function arm_n0_k(player)
	if shown_n0_k ~= nil then return shown_n0_k end
	if (player.money or 0) > 7499 then
		shown_n0_k = [=[1]=]
		return shown_n0_k
	end
	if not (((player.money or 0) > 7499)) then
		shown_n0_k = [=[2]=]
		return shown_n0_k
	end
	shown_n0_k = [=[]=]
	return shown_n0_k
end
newChat{ id=[=[n0_k]=],
	text = function(npc, player)
		local which = arm_n0_k(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
