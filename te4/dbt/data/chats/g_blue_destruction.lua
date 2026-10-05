-- dbt-generated-talk dialogue.BLUE_DESTRUCTION
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.rra_blue_sec or 0) ~= 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.rra_blue_sec or 0) ~= 0)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	player.rra_blue_submerge = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[ and obliterated my security network.]=] end
		if which == [=[2]=] then return [=[ and generally made quite the nuisance of yourself.]=] end
		if which == [=[]=] then return [=[General Blue: ]=] .. [=[Hello, my dear intruder. Welcome to my lair. It is very likely to be the last sight you ever see. You have defeated my guards]=] .. [=[ Fortunately I longer have any use for this facility. It will make an excellent underwater tomb.

]=] .. [=[He presses a small button. There is a tremendous rumble in the ground beneath you and you hear the sound of rushing water in the distance.

]=] .. [=[General Blue: ]=] .. [=[I have just set off the self destruct mechanism for this base. In a swift few minutes this room and all the floors above will be completely submerged. You will die.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What's to stop me from simply leaving?

]=] .. [=[General Blue: ]=] .. [=[Me.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
