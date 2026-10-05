-- dbt-generated-talk dialogue.GOZ_MEZ
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if true then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if ((player.demon_comic_dialogue or 0) == 0) or ((player.demon_comic_dialogue or 0) == 999) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[: ]=] .. [=[Hey, ]=] .. (player.name or "you") .. [=[! What's up?

]=] .. [=[: ]=] .. [=[Yeah, what can we do for ya?

]=] .. [=[: ]=] .. [=[Hello again. 

]=] .. [=[: ]=] .. [=[Wow, ]=] .. (player.name or "you") .. [=[ again? ]=] .. [=[ must really like us.

]=] .. [=[: ]=] .. [=[Awww....how sweet! I'm touched. :)

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
