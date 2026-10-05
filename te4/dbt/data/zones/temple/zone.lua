return {
	name = "Buddhist Temple",
	level_range = {1, 7},
	max_level = 7,
	width = 66, height = 44,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = {
		map = {
			class = "mod.class.generator.map.Sewer",
			wall = "WALL", mud = "FLOOR", water = "FLOOR", swamp = "FLOOR",
			up = "UP_HOUSE", up_earth = "UP_EARTH", down = "DOWN_HOUSE",
		},
	},
	post_process = function(level)
		if game and game.stockTemple then game:stockTemple(level) end
	end,
	levels = {
		[1] = { name = "Buddhist Temple", width = 43, height = 27,
			generator = { map = { class = "engine.generator.map.Static", map = "!map" } } },
		[7] = { name = "Catacombs", width = 55, height = 29,
			generator = { map = { class = "engine.generator.map.Static", map = "!catacomb" } } },
	},
}
