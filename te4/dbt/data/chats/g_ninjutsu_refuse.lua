-- dbt-generated-talk dialogue.NINJUTSU_REFUSE
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = function(npc, player)
		return [=[Grandmaster Hatsumi eyes you coldly.

]=] .. [=[
Grandmaster Hatsumi: ]=] .. [=[You are not welcome here. You will leave now.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[But why?

]=] .. [=[
Grandmaster Hatsumi: ]=] .. [=[Surely you know why. Go, now.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[But I really don't know why.

]=] .. [=[
Grandmaster Hatsumi: ]=] .. [=[Then you are a fool.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
