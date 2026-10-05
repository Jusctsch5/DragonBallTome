-- dbt-generated-talk dialogue.FOOT_HELPER
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.foot_clan_rapport or 0) < 2 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.foot_clan_rapport or 0) < 5 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.foot_clan_rapport or 0) == 5 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.foot_clan_rapport or 0) == 999 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if not (((player.foot_clan_rapport or 0) < 2) or ((player.foot_clan_rapport or 0) < 5) or ((player.foot_clan_rapport or 0) == 5) or ((player.foot_clan_rapport or 0) == 999)) then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[The ninja is silent, like all good ninja should be.]=] end
		if which == [=[2]=] then return [=[The Foot ninja nods in acknowledgement.]=] end
		if which == [=[3]=] then return [=[Your minion bows respectfully.]=] end
		if which == [=[4]=] then return [=[The ninja is silent, like all good ninja should be.]=] end
		if which == [=[5]=] then return [=[Error: Unknown foot clan rapport state. State is: ]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
