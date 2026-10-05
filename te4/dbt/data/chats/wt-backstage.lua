newChat{ id="unregistered",
	text = [[Hey! How'd you get back here? You're not on my list. Go away!]],
	answers = { {"Fine."} },
}

newChat{ id="lost",
	text = [[Too bad. I really thought you had a chance to win. Maybe next year.]],
	answers = { {"Next year."} },
}

newChat{ id="ring",
	text = [[Your fighting's not bad, but stay in the ring next time.]],
	answers = { {"Yeah."} },
}

newChat{ id="cheat",
	text = [[What were you thinking? Didn't you read the brochure the ticket girl gave you?]],
	answers = { {"..."} },
}

newChat{ id="won",
	text = [[Congratulations!]],
	answers = { {"Thanks."} },
}

newChat{ id="fighting",
	text = [[You're in the middle of a match. Get back in the ring!]],
	answers = { {"Right."} },
}

newChat{ id="bump",
	text = [[Whoops. Looks like we have a no-show. I wonder why anyone would register and not show up? Well, that's good for you, at least. It means you automatically advance to the next round.]],
	answers = { {"I'll take it."} },
}

newChat{ id="ready",
	text = function(npc, player)
		return (player.tourny_intro or "Your next opponent is waiting.") .. "\n\nAre you ready?"
	end,
	answers = {
		{"Yes.", action=function(npc, player)
			if game.tournyBegin then game:tournyBegin(player) end
		end},
		{"Not quite yet.", cond=function(npc, player) return not player.tourny_death end},
	},
}

newChat{ id="death",
	text = function(npc, player)
		return (player.tourny_intro or "This fight is to the death.") .. "\n\nAre you ready?"
	end,
	answers = {
		{"...yes.", action=function(npc, player)
			if game.tournyBegin then game:tournyBegin(player) end
		end},
	},
}

return (function()
	local p = player
	local reg = p.tourny_registered or 0
	if reg == 0 then return "unregistered" end
	if reg == 2 then return "lost" end
	if reg == 3 then return "ring" end
	if reg == 4 then return "cheat" end
	if reg == 5 or (p.tourny_round or 0) > 18 then return "won" end
	local kind = game.tournyPrepare and game:tournyPrepare(p) or "victory"
	if kind == "victory" then return "won" end
	if kind == "fighting" then return "fighting" end
	if kind == "autobump" or kind == "bump" then
		if game.tournyAdvance then game:tournyAdvance(p) end
		return "bump"
	end
	if p.tourny_death then return "death" end
	return "ready"
end)()
