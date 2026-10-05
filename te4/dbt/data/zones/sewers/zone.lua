return {
	name = "Sewers",
	level_range = {5, 9},
	max_level = 5,
	width = 66, height = 44,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = {
		map = {
			class = "mod.class.generator.map.Sewer",
			wall = "SOFT_WALL",
			mud = "MUD",
			water = "SHALLOW_WATER",
			swamp = "SWAMP",
			up = "UP_SEWER",
			up_earth = "UP_EARTH",
			down = "DOWN_SEWER",
		},
	},
	post_process = function(level)
		if game and game.stockSewer then game:stockSewer(level) end
	end,
	levels = {
		[5] = {
			name = "Turtles Lair",
			width = 34, height = 17,
			generator = {
				map = {
					class = "engine.generator.map.Static",
					map = "!turtles",
				},
			},
		},
	},
}
