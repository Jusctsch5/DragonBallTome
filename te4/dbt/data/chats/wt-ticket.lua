-- Ticket girl. 100 zeni to register.

newChat{ id="poor",
	text = [[Welcome to the Tournament. Admission is free for the audience. It's 100 zeni to register.]],
	answers = { {"I'll be back."} },
}

newChat{ id="ask",
	text = [[Admission is free to watch. 100 zeni to register.

Are you here to fight?]],
	answers = {
		{"Yes.", action=function(npc, player)
			if (player.money or 0) < 100 then
				game.log("You don't have 100 zeni.")
				return
			end
			player.money = player.money - 100
			player.tourny_registered = 1
			if game.syncTournamentQuest then game:syncTournamentQuest(player) end
			game.log("You're registered for the 22nd World Tournament. Stay in the ring. When you're ready, go through the door to the east and speak to the Backstage Organizer.")
		end},
		{"Not today."},
	},
}

newChat{ id="cheat",
	text = [[That was awfully lousy of you to try to cheat like that.]],
	answers = { {"..."} },
}

newChat{ id="lost",
	text = [[Sorry you lost. Come again next year?]],
	answers = { {"Maybe."} },
}

newChat{ id="late",
	text = [[Wow! You really inspire me!]],
	answers = { {"Thanks."} },
}

newChat{ id="early",
	text = [[Wow! I didn't think you'd make it this far. Err...no, I didn't mean...umm...nevermind.]],
	answers = { {"Right."} },
}

newChat{ id="go",
	text = [[When you're ready, head backstage. Go through the door to the east.]],
	answers = { {"I will."} },
}

return (function()
	local p = player
	local reg = p.tourny_registered or 0
	if reg == 4 then return "cheat" end
	if reg > 1 then return "lost" end
	if reg == 0 then
		if (p.money or 0) >= 100 then return "ask" else return "poor" end
	end
	if (p.tourny_round or 0) > 5 then return "late" end
	if (p.tourny_round or 0) > 0 then return "early" end
	return "go"
end)()
