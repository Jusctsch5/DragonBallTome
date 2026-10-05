-- dbt-generated-talk dialogue.GERO_GET_QUEST
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.gero_quests or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.gero_quests or 0) == 0)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Dr Gero: ]=] .. [=[Excellent. I am on the verge of a breakthrough in my android designs, and-

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Android designs?

]=] .. [=[Dr Gero: ]=] .. [=[QUIET YOU FOOL! Yes, my android designs. I have had tremendous success overcoming limitations in previous models by integrating nano components into biological systems. These systems have their own limitations, however, and I must improve the basic structure if my specimens are to withstand the stress of my designs.

]=] .. [=[Dr Gero: ]=] .. [=[To solve the immediate problem, I need a genetic sample of a creature with extraordinarily strong cartilige. A dinosaur, or whale. 

]=] end
		if which == [=[2]=] then return [=[Dr Gero: ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
