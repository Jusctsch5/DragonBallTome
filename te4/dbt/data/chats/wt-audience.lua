newChat{ id="talk",
	text = function(npc, player)
		local reg = player.tourny_registered or 0
		local round = player.tourny_round or 0
		if reg == 4 then return "Oh, look! That's the one who cheated!" end
		if reg > 1 then
			if round == 0 then return "Oh, look! There's the clumsy idiot who couldn't even qualify!" end
			return "Oh, look! That's the one who lost in round " .. round .. "!"
		end
		if round > 5 then return "Wow! I think you're going to win!" end
		if round > 0 then return "You're a fighter! Wow!" end
		return "I'm so excited! Isn't this great!"
	end,
	answers = { {"..."} },
}

return "talk"
