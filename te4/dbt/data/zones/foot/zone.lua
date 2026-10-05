return {
	name = "Foot Lair",
	level_range = {1, 7},
	max_level = 7,
	width = 66, height = 44,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = { map = {
		class = "mod.class.generator.map.Sewer",
		wall = "WALL", mud = "FLOOR", water = "FLOOR", swamp = "FLOOR",
		up = "UP_HOUSE", up_earth = "UP_EARTH", down = "DOWN_HOUSE",
	} },
	post_process = function(level)
		if game and game.stockDen then game:stockDen(level) end
	end,
	levels = {
		[1] = { width = 25, height = 16, generator = { map = { class = "engine.generator.map.Static", map = "!map" } } },
		[7] = { width = 36, height = 30, generator = { map = { class = "engine.generator.map.Static", map = "!sanctum" } } },
	},
}
