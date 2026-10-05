-- dbt-generated-talk dialogue.MARKSMANSHIP
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.descriptor and player.descriptor.class == [=[Wannabe]=]) then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (false or (player.trainers and player.trainers.BALLET)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (player.trainers and player.trainers.MARKSMANSHIP) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if not (((player.descriptor and player.descriptor.class == [=[Wannabe]=])) or ((false or (player.trainers and player.trainers.BALLET))) or (not (player.trainers and player.trainers.MARKSMANSHIP))) then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[If you want to learn to shoot, this is the place.]=] end
		if which == [=[2]=] then return [=[
Charleton: ]=] end
		if which == [=[3]=] then return [=[
Charleton: ]=] .. [=[You're wastin' your time with those fighting classes. No punch in the world can match a dozen rounds in the forehead.

]=] end
		if which == [=[4]=] then return [=[Hey. Good to see you.]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
