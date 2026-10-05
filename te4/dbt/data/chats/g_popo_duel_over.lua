-- dbt-generated-talk dialogue.POPO_DUEL_OVER
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.karin_kami or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.ever_been_evil or 0) == 1 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.karin_kami or 0) == 0) or ((player.ever_been_evil or 0) == 1)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	player.popo_state = 4
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return (player.name or "you") .. [=[: ]=] .. [=[Woohoo! I did it!

]=] .. [=[A voice echoes out: ]=] .. [=[Yes, warrior. You have defeated my guardian. You have earned an audience with me. Please, come inside.

]=] end
		if which == [=[2]=] then return (player.name or "you") .. [=[: ]=] .. [=[Woohoo! I did it! So I get to see Kami now?

]=] .. [=[Mr. Popo: ]=] .. [=[No. You not pure of heart. Only pure of heart can speak Kami.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[You can't be serious. Do you have any idea how difficult you were to beat? Don't I deserve something for this?

]=] .. [=[Mr. Popo: ]=] .. [=[Mr. Popo not make rules. Only Kami make rules. Only pure of heart see Kami.

]=] end
		if which == [=[3]=] then return (player.name or "you") .. [=[: ]=] .. [=[Woohoo! I did it! So I get to see Kami now?

]=] .. [=[A voice echoes out: ]=] .. [=[Yes. You have proven yourself. I will speak with you. Please, come inside.

]=] end
		if which == [=[]=] then return [=[Mr. Popo: ]=] .. [=[Mr. Popo lose.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
