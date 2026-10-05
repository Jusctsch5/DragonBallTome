-- dbt-generated-talk dialogue.CQ_BALLET
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if player.female then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not ((player.female)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[
Sakura: ]=] .. [=[Wow, ]=] .. (player.name or "you") .. [=[, I'm really impressed with how quickly you've progressed!
]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you.
]=] .. [=[
Sakura: ]=] .. [=[I think it's time to let you in on the secret of our school.
]=] .. (player.name or "you") .. [=[: ]=] .. [=[...there's a secret?
]=] .. [=[
Sakura: ]=] .. [=[Yes. A very terrible secret.
]=] end
		if which == [=[2]=] then return [=[
Sakura: ]=] .. [=[Wow, ]=] .. (player.name or "you") .. [=[, I'm really impressed with how quickly you've progressed!
]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you.
]=] .. [=[
Sakura: ]=] .. [=[I think it's time to let you in on the secret of our school.
]=] .. (player.name or "you") .. [=[: ]=] .. [=[...there's a secret?
]=] .. [=[
Sakura: ]=] .. [=[Yes. A very terrible secret.
]=] end
		if which == [=[]=] then return [=[
Sakura: ]=] .. [=[Wow, ]=] .. (player.name or "you") .. [=[, I'm really impressed with how quickly you've progressed!
]=] .. (player.name or "you") .. [=[: ]=] .. [=[Thank you.
]=] .. [=[
Sakura: ]=] .. [=[I think it's time to let you in on the secret of our school.
]=] .. (player.name or "you") .. [=[: ]=] .. [=[...there's a secret?
]=] .. [=[
Sakura: ]=] .. [=[Yes. A very terrible secret.
]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
