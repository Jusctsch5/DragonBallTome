-- Talkers and the quest hook. Everyone else is a race from races.lua.

load("/data/general/npcs/races.lua")

newEntity{ base = "RACE_TENTACLE_DEMON",
	define_as = "TENTACLE_DEMON",
	on_die = function(self, src)
		local p = game.player
		local q = p and p.quests and p.quests.tentacle_demon
		if q and q.status == "taken" then
			q.status = "slain"
			game.log("The basement goes quiet. Uranai Baba will want to hear of this.")
		end
	end,
}

newEntity{
	define_as = "URANAI_BABA",
	name = "Uranai Baba",
	type = "humanoid", subtype = "earth",
	display = "B", color=colors.LIGHT_BLUE,
	desc = [[The fortune teller. She does not look pleased to see a guest.]],
	stats = { str=10, dex=10, con=10 },
	combat_armor = 50,
	max_life = 400,
	life = 400,
	level = 27,
	body = { INVEN = 1 },
	faction = nil,
	ai = "none",
	can_talk = "uranai-baba",
	never_move = true,
}
