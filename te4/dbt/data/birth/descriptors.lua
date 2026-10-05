-- Dragonball T: the player chooses gender only. Everything else develops in-game.

newBirthDescriptor{
	type = "base",
	name = "base",
	desc = {},
	experience = 1.0,
	copy = {
		max_level = 10,
		lite = 6,
		sight = 15,
		max_life = 10,
		life = 10,
		combat = { dam = 1 },
		combat_armor = 0,
	},
}

newBirthDescriptor{
	type = "sex",
	name = "Male",
	desc = "Gender does not effect stats in DBT, but it may have thematic consequences.",
	copy = { female = false },
}

newBirthDescriptor{
	type = "sex",
	name = "Female",
	desc = "Gender does not effect stats in DBT, but it may have thematic consequences.",
	copy = { female = true },
}
