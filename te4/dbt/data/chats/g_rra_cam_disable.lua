-- dbt-generated-talk dialogue.RRA_CAM_DISABLE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.rra_shq_cam or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if player:skillLevel("technology") > 4 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not ((player:skillLevel("technology") > 4)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The computer has been destroyed]=] end
		if which == [=[2]=] then return [=[This ]=] .. [=[computer appears to be the control system for the internal cameras throughout Red Ribbon Army Supreme Headquarters. You're fairly certain that by destroying it you'll be able to permanantly shut them all down. No doubt this would make infiltrating the rest of the complex much easier.

]=] end
		if which == [=[3]=] then return [=[There ]=] .. [=[is a large computer system here. You're not certain what it does, but it's probably important.

]=] end
		if which == [=[]=] then return [=[Would you like to destroy it?

]=] end
		return "..."
	end,
	answers = {
		{[=[Yes.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[No.]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if player:skillLevel("technology") > 4 then
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	if not ((player:skillLevel("technology") > 4)) then
		shown_n0_a = [=[2]=]
		return shown_n0_a
	end
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[You ]=] .. [=[instruct the computer to disable everything that it controls, and then selectively fry its internal circuitry. The beauty of this is that from the outside it appears that the power has simply been turned off, in reality all the control boards have been completely melted and fused to their casings. Every single one of them will need to be replaced...with a hacksaw. You smile at the thought of the Red Ribbon Army technology personell trying to figure out how to do this. It won't be easy.

]=] end
		if which == [=[2]=] then return [=[You ]=] .. [=[thoroughly smash it. Sometimes the direct approach is best.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
