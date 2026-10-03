-- Earth 1 hostiles and Uranai Baba. Melee uses the engine bump attack.

newEntity{
	define_as = "BASE_NPC_EARTH",
	type = "humanoid", subtype = "earth",
	display = "p", color=colors.WHITE,
	desc = [[Someone from Earth.]],
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
	combat = { dam=2 },
	body = { INVEN = 1 },
	life_rating = 8,
	rank = 1,
	exp_worth = 1,
	level_range = {1, 1},
}

newEntity{ base = "BASE_NPC_EARTH",
	define_as = "WOLF",
	name = "wolf",
	type = "animal", subtype = "canine",
	display = "w", color=colors.UMBER,
	desc = [[A wolf prowling the edge of the road.]],
	faction = "enemies",
	ai = "simple", ai_state = { talent_in=3 },
	max_life = 10,
	combat = { dam=2 },
}

newEntity{ base = "BASE_NPC_EARTH",
	define_as = "THUG",
	name = "street thug",
	display = "h", color=colors.LIGHT_RED,
	desc = [[A thug looking for an easy mark.]],
	faction = "enemies",
	ai = "simple", ai_state = { talent_in=3 },
	max_life = 16,
	combat_armor = 1,
	combat = { dam=2 },
}

newEntity{ base = "BASE_NPC_EARTH",
	define_as = "URANAI_BABA",
	name = "Uranai Baba",
	display = "B", color=colors.LIGHT_BLUE,
	desc = [[The fortune teller. She does not look pleased to see a guest.]],
	faction = nil,
	ai = "none",
	max_life = 40,
	can_talk = "uranai-baba",
	never_move = true,
}
