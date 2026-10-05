-- dbt-generated-talk dialogue.BRIEFS
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if false then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if false then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if false then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.android_plans and player.quests.android_plans.status == "taken") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.ttq_tripped or 0) == 2 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.briefs_state or 0) == 3 then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	if (player.quests and player.quests.briefs_satan and player.quests.briefs_satan.status == "taken") then
		shown_n0 = [=[7]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Dr Briefs: ]=] .. [=[Get out of here, you murderer!]=] end
		if which == [=[2]=] then return [=[Dr Briefs: ]=] .. [=[Get out of here, you murderer!]=] end
		if which == [=[3]=] then return [=[Dr Briefs: ]=] .. [=[Get out of here, you murderer!]=] end
		if which == [=[4]=] then return [=[Implement android plans branch]=] end
		if which == [=[5]=] then return [=[Dr Briefs: ]=] .. [=[Get out of here, you murderer!]=] end
		if which == [=[6]=] then return [=[Dr Briefs: ]=] .. [=[Hello. Nice to see you again.]=] end
		if which == [=[7]=] then return [=[Dr Briefs: ]=] .. [=[Still no battery? Hmm. Well, keep looking.]=] end
		if which == [=[]=] then return [=[Dr Briefs: ]=] .. [=[Get out of here, you murderer!]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
