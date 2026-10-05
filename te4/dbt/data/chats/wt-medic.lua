local function line(player)
	local pct = 100
	if player.max_life and player.max_life > 0 then
		pct = math.floor(100 * player.life / player.max_life)
	end
	if pct < 20 then return "Whoa....cool! I haven't seen an arm bent backwards at quite that angle in...wow...at least a couple days." end
	if pct < 50 then return "Groovy. I love a little bloodshed. You don't mind if I take a few pictures, do you?" end
	if pct < 80 then return "Yeah...that's not bad. Next time, though, try not to spend so much time standing upright." end
	if (player.tourny_registered or 0) > 1 then
		return "Pity you're not in the Tournament anymore. You're just not as interesting when you're all in one piece like this."
	end
	return "What? You're not hurt. Oh, all right, I'll patch you up, you big sissy."
end

newChat{ id="busy",
	text = [[Get out there and fight! I want blood! GIMMEE BLOOD!!!]],
	answers = { {"..."} },
}

newChat{ id="heal",
	text = function(npc, player) return line(player) end,
	answers = {
		{"Thanks.", action=function(npc, player)
			if player.max_life and player.max_life > 0 then player.life = player.max_life end
			game.log("The medic patches you up.")
		end},
	},
}

return (function()
	if player.tourny_now then return "busy" end
	return "heal"
end)()
