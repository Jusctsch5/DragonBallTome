-- dbt-generated-talk dialogue.ANDROID_INCEPTION
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if true then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Android 17: ]=] .. [=[Hahahahahaha!!!! That's it! That one puts me at 117 points! I'm in the lead!

]=] .. [=[Android 16: ]=] .. [=[Only by one points. All I have to do is kill a single measly human and we're tried again.

]=] .. [=[Android 17: ]=] .. [=[Yeah, but where are you going to find one? I think we're starting to run out.

]=] .. [=[Android 16: ]=] .. [=[What about that one over there?

]=] .. [=[They look at you.

]=] .. [=[Android 17: ]=] .. [=[Oh, I see ]=] .. [=[. I bet I can kill ]=] .. [=[ first!

]=] .. [=[Android 16: ]=] .. [=[I bet I can get ]=] .. [=[ first. How about whomever gets this one first, wins?

]=] .. [=[Android 17: ]=] .. [=[You're on.

]=] end
		if which == [=[]=] then return [=[Android 17: ]=] .. [=[Look...another human.

]=] .. [=[Android 16: ]=] .. [=[And ]=] .. [=[ doesn't seem to be running in terror like the rest of them.

]=] .. [=[Android 17: ]=] .. [=[...interesting...

]=] .. [=[Android 16: ]=] .. [=[Not really. Just kill ]=] .. [=[ and be done with it.

]=] .. [=[Android 17: ]=] .. [=[Ok.

]=] .. [=[Android 16: ]=] .. [=[I think I'm getting bored, 17.

]=] .. [=[Android 17: ]=] .. [=[Are you serious? How could ever get bored of this! Killing humans is fun!

]=] .. [=[Android 16: ]=] .. [=[I don't know. Maybe if they weren't so helpless and pathetic it would be more intersting.

]=] .. [=[Android 17: ]=] .. [=[What about that one over there?

]=] .. [=[They look at you.

]=] .. [=[Android 16: ]=] .. [=[Yeah, ]=] .. [=[ looks fun. Come on, let's try ]=] .. [=[out.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
