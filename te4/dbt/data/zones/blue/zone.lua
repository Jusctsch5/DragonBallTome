return {
	name = "Underwater Cavern",
	level_range = {1, 6},
	max_level = 6,
	width = 66, height = 44,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = { map = {
		class = "mod.class.generator.map.Sewer",
		wall = "WALL", mud = "DIRT", water = "DIRT", swamp = "DIRT",
		up = "UP_HOUSE", up_earth = "UP_EARTH", down = "DOWN_HOUSE",
	} },
	post_process = function(level)
		if game and game.stockDen then game:stockDen(level) end
	end,
	levels = {
		[6] = { width = 64, height = 22, generator = { map = { class = "engine.generator.map.Static", map = "!map" } } },
	},
}
