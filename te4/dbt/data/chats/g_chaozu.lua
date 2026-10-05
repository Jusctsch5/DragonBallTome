-- dbt-generated-talk dialogue.CHAOZU
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if game.zone and game.zone.name == [=[World Tournament]=] then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.rosshi_student or (player.trainers and player.trainers.ROSSHI)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.crane_state or 0) == 0 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.crane_state or 0) == 1 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.crane_state or 0) == 2 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not ((game.zone and game.zone.name == [=[World Tournament]=]) or ((player.rosshi_student or (player.trainers and player.trainers.ROSSHI))) or ((player.crane_state or 0) == 0) or ((player.crane_state or 0) == 1) or ((player.crane_state or 0) == 2)) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[I will defeat you!]=] end
		if which == [=[2]=] then return [=[Chaozu: ]=] .. [=[Oh, wow! You must be one of Rosshi's turtle students! I recognize the slow gait.

]=] end
		if which == [=[3]=] then return [=[Chaozu: ]=] .. [=[You must have come to train with our great master!]=] end
		if which == [=[4]=] then return [=[Chaozu: ]=] .. [=[I'm glad I'm a martial artist instead of a pizza delivery boy.

]=] end
		if which == [=[5]=] then return [=[Chaozu: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[.

]=] end
		if which == [=[6]=] then return [=[...you should never see this...]=] end
		return "..."
	end,
	answers = {
		{[=[Hi, Chaozu. I'm glad to see you're doing well.]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_b = nil
local function arm_n0_g4_b(player)
	if shown_n0_g4_b ~= nil then return shown_n0_g4_b end
	player:partyWith({define_as="RACE_CHAOZU", name="companion", level=1})
	shown_n0_g4_b = [=[]=]
	return shown_n0_g4_b
end
newChat{ id=[=[n0_g4_b]=],
	text = function(npc, player)
		arm_n0_g4_b(player)
		return [=[Chaozu: ]=] .. [=[Oh! That sounds like fun! Yes, I'd love to.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
