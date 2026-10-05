-- dbt-generated-talk dialogue.SUMMON_SHENRON
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = function(npc, player)
		return [=[You ]=] .. [=[gather the seven dragonballs together, and shout out: 

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Dragon! I summon you! I command you to come forth and grant my wish!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
