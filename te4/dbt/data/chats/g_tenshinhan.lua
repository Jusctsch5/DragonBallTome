-- dbt-generated-talk dialogue.TENSHINHAN
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if game.zone and game.zone.name == [=[World Tournament]=] then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if player:isPartied("RACE_TENSHINHAN") then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.rosshi_student or (player.trainers and player.trainers.ROSSHI)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.crane_state or 0) == 0 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.crane_state or 0) == 1 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.crane_state or 0) == 2 then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if not ((game.zone and game.zone.name == [=[World Tournament]=]) or (player:isPartied("RACE_TENSHINHAN")) or ((player.rosshi_student or (player.trainers and player.trainers.ROSSHI))) or ((player.crane_state or 0) == 0) or ((player.crane_state or 0) == 1) or ((player.crane_state or 0) == 2)) then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[I will defeat you!]=] end
		if which == [=[2]=] then return [=[Tenshinhan: ]=] .. [=[Yes, ]=] .. (player.name or "you") .. [=[?

]=] end
		if which == [=[3]=] then return [=[tenshinhan: ]=] .. [=[Pffft. Turtle student. Slow and dumb.]=] end
		if which == [=[4]=] then return [=[Tenshinhan: ]=] .. [=[You must have come to train with our great master!]=] end
		if which == [=[5]=] then return [=[Tenshinhan: ]=] .. [=[I wonder if wolf would be good on pizza?

]=] end
		if which == [=[6]=] then return [=[Tenshinhan: ]=] .. [=[Hey, it's good to see you.

]=] end
		if which == [=[7]=] then return [=[...you should never see this...]=] end
		return "..."
	end,
	answers = {
		{[=[Just checking to see you're ok.]=], jump=[=[n0_g1_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Thank you for your help. But I must continue on my own.]=], jump=[=[n0_g1_b]=], action=function(npc, player) player:unparty("RACE_TENSHINHAN") end, cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Good to see you too.]=], jump=[=[n0_g5_a]=], cond=function(npc, player) return arm_n0(player) == [=[6]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g1_b = nil
local function arm_n0_g1_b(player)
	if shown_n0_g1_b ~= nil then return shown_n0_g1_b end
	player:unparty("RACE_TENSHINHAN")
	shown_n0_g1_b = [=[]=]
	return shown_n0_g1_b
end
newChat{ id=[=[n0_g1_b]=],
	text = function(npc, player)
		arm_n0_g1_b(player)
		return [=[Tenshinhan: ]=] .. [=[Yes, I understand. I shall remain here.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g5_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g5_b = nil
local function arm_n0_g5_b(player)
	if shown_n0_g5_b ~= nil then return shown_n0_g5_b end
	player:partyWith({define_as="RACE_TENSHINHAN", name="companion", level=1})
	shown_n0_g5_b = [=[]=]
	return shown_n0_g5_b
end
newChat{ id=[=[n0_g5_b]=],
	text = function(npc, player)
		arm_n0_g5_b(player)
		return [=[Tenshinhan: ]=] .. [=[Certainly. I'm always happy to help a fellow brother in Crane.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
