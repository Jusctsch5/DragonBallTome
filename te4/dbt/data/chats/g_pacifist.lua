-- dbt-generated-talk dialogue.PACIFIST
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.rra_pacifist or 0) ~= 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	player.rra_pacifist = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[As you approach the door, you hear a curious conversation taking place on the other side:

]=] .. [=[General Blue: ]=] .. [=[What do you mean you won't fight?!?!?! Get out there and kill ]=] .. [=[!

]=] .. [=[Android 8: ]=] .. [=[No, sir. Killing is wrong.

]=] .. [=[General Blue: ]=] .. [=[Infernal machine! Why did we even bother building you?

]=] .. [=[Android 8: ]=] .. [=[My creator built me to kill, and to destroy.

]=] .. [=[General Blue: ]=] .. [=[Then fulfill your purpose! Get out there right now and get that intruder before ]=] .. [=[ kills us all!

]=] .. [=[Android 8: ]=] .. [=[No. I would sooner die than cause harm to another.

]=] .. [=[General Blue: ]=] .. [=[Unbelievable. Very well, if death is what you want, I'll give it to you. Right now.

]=] end
		if which == [=[]=] then return [=[As you approach the door, you hear a curious conversation taking place on the other side:

]=] .. [=[General Blue: ]=] .. [=[What do you mean you won't fight?!?!?! Get out there and kill ]=] .. [=[!

]=] .. [=[Android 8: ]=] .. [=[No, sir. Killing is wrong.

]=] .. [=[General Blue: ]=] .. [=[Infernal machine! Why did we even bother building you?

]=] .. [=[Android 8: ]=] .. [=[My creator built me to kill, and to destroy.

]=] .. [=[General Blue: ]=] .. [=[Then fulfill your purpose! Get out there right now and get that intruder before ]=] .. [=[ kills us all!

]=] .. [=[Android 8: ]=] .. [=[No. I would sooner die than cause harm to another.

]=] .. [=[General Blue: ]=] .. [=[Unbelievable. Very well, if death is what you want, I'll give it to you. Right now.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
