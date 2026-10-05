-- dbt-generated-talk dialogue.PICCOLO_INCEPTION
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[You ]=] .. [=[struggle with the seal, but aren't able to open it. Odd. It looks like it's just paper.]=] .. [=[ As you contemplate the cooker, though, you start to get the distinct impression that you are being watched from far above. You look around you, but you see nothing. Still, you can't help but feel a bit uneasy.

]=] .. [=[You shrug it off and reach for the seal. Right as you do, lightning strikes in the distance.

]=] .. [=[Are you sure you want to open it?

]=],
	answers = {
		{[=[Yes. Open it.]=], jump=[=[n0_a]=], action=function(npc, player) player.piccolo_state = 1 end},
		{[=[No. I'm certain that something bad would happen. I don't really need to know what's inside. I'm sure it's better that it stay there.]=], jump=[=[n0_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player.piccolo_state = 1
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		arm_n0_a(player)
		return [=[You tear the seal and open the rice cooker. As you do you are swept with a wave of cold. Peering inside you see a swirling vortex of mist, accompanied with tiny bolts of colored lightning. You're not quite sure what to make of it, but before you have too much time to reflect the mist leaps from the rice pot and coelesces into a green humanoid creature!

]=] .. [=[Demon King Piccolo: ]=] .. [=[Hahahahaha!!! Wretched fool! You have released me from my confinement! And now, in thanks, I will kill you!!!

]=]
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
