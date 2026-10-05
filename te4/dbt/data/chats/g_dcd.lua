-- dbt-generated-talk dialogue.DCD
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.demon_comic_dialogue or 0) == 1 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.demon_comic_dialogue or 0) == 2 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.demon_comic_dialogue or 0) == 3 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.demon_comic_dialogue or 0) == 4 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.demon_comic_dialogue or 0) == 5 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if not (((player.demon_comic_dialogue or 0) == 1) or ((player.demon_comic_dialogue or 0) == 2) or ((player.demon_comic_dialogue or 0) == 3) or ((player.demon_comic_dialogue or 0) == 4) or ((player.demon_comic_dialogue or 0) == 5)) then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Goz ]=] .. [=[Oh, look. Another live one.

]=] .. [=[Mez ]=] .. [=[Yeah. How long do you think ]=] .. [=['ll last?

]=] .. [=[Goz ]=] .. [=[Hmm. 1000 zeni says ]=] .. [=[ makes ten seconds.

]=] .. [=[Mez ]=] .. [=[Heh. Ten seconds? You're on.

]=] end
		if which == [=[2]=] then return [=[Goz ]=] .. [=[Oh, look. Another live one.

]=] .. [=[Mez ]=] .. [=[You'd really think they'd learn after a while.

]=] .. [=[Goz ]=] .. [=[Nahh...adventurers usually aren't all that bright. They tend to focus their points in speed and constitution. Not so much in intelligence.

]=] .. [=[Mez ]=] .. [=[True.

]=] end
		if which == [=[3]=] then return [=[Mez ]=] .. [=[Hey, look Goz! It's another one! What are we going to do with all these people?

]=] .. [=[Goz ]=] .. [=[I don't know. Hell was really built for people who are still alive. Maybe we should open some tourist attractions?

]=] .. [=[Mez ]=] .. [=[That's a great idea! We could make a killing.

]=] .. [=[Goz ]=] .. [=[Heh. A 'killing.'

]=] end
		if which == [=[4]=] then return [=[Mez ]=] .. [=[Aaaggghhh!!! Watch out!

]=] .. [=[Goz ]=] .. [=[Hey! You idiot adventurer! You almost landed on me!

]=] .. [=[Mez ]=] .. [=[Wow! That one came out on nowhere! I never knew Hell could be so dangerous!

]=] end
		if which == [=[5]=] then return [=[Goz ]=] .. [=[Hey, look! Another one!

]=] .. [=[Mez ]=] .. [=[Yeah, I think those brochures we put out are really working.

]=] .. [=[Goz ]=] .. [=[Yeah, it really pays to advertise!

]=] end
		if which == [=[6]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
