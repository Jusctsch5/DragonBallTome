-- dbt-generated-talk dialogue.CHICHI
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.chichi_state or 0) == 2 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.chichi_state or 0) == 4 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.chichi_state or 0) == 2) or ((player.chichi_state or 0) == 4)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Chichi: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[. It's so nice to see you again.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[How is Rosshi treating you?

]=] .. [=[Chichi: ]=] .. [=[Oh. He's, well...changed a bit from how I remember him when I was a little girl.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I don't know about that. I didn't know him when you were a little girl, but I've a sneaking suspicion that he was exactly the same sort of person back then...but rather, it's you who have changed.

]=] .. [=[Chichi: ]=] .. [=[...yes. That could be.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Well, in any case, I'm glad to hear you're doing well. I'll talk to you again some other time. Take care.

]=] end
		if which == [=[2]=] then return [=[Chichi: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[. It's so nice to see you again.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[How is Rosshi treating you?

]=] .. [=[Chichi: ]=] .. [=[Oh. He's, well...changed a bit from how I remember him when I was a little girl.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I don't know about that. I didn't know him when you were a little girl, but I've a sneaking suspicion that he was exactly the same sort of person back then...but rather, it's you who have changed.

]=] .. [=[Chichi: ]=] .. [=[...yes. That could be.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Well, in any case, I'm glad to hear you're doing well. I'll talk to you again some other time. Take care.

]=] end
		if which == [=[3]=] then return [=[Implement my dialogue!]=] end
		if which == [=[]=] then return [=[Chichi: ]=] .. [=[Hello, ]=] .. (player.name or "you") .. [=[. It's so nice to see you again.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[How is Rosshi treating you?

]=] .. [=[Chichi: ]=] .. [=[Oh. He's, well...changed a bit from how I remember him when I was a little girl.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I don't know about that. I didn't know him when you were a little girl, but I've a sneaking suspicion that he was exactly the same sort of person back then...but rather, it's you who have changed.

]=] .. [=[Chichi: ]=] .. [=[...yes. That could be.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Well, in any case, I'm glad to hear you're doing well. I'll talk to you again some other time. Take care.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
