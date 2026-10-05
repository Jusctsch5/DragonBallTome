newChat{ id="talk",
	text = function(npc, player)
		local reg = player.tourny_registered or 0
		local round = player.tourny_round or 0
		if reg == 4 then return "The guard just shakes his head at you." end
		if reg > 1 then return "I respect anyone who fights in something like this, win or lose." end
		if reg == 0 then return "Get outta here. Fighters only." end
		if round > 5 then return "The backstage guard nods respectfully at you." end
		if round > 0 then return "Congratulations. You're doing well." end
		return "Good luck. Try not to get killed out there."
	end,
	answers = { {"Right."} },
}

return "talk"
