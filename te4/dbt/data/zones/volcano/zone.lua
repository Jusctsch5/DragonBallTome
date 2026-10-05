return {
	name = "Volcano",
	level_range = {1, 5},
	max_level = 5,
	width = 66, height = 44,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = { map = {
		class = "mod.class.generator.map.Sewer",
		wall = "LAVA_WALL", mud = "ASH", water = "ASH", swamp = "ASH",
		up = "UP_HOUSE", up_earth = "UP_EARTH", down = "DOWN_HOUSE",
	} },
	post_process = function(level)
		if game and game.stockDen then game:stockDen(level) end
	end,
	levels = {
		[5] = { width = 31, height = 21, generator = { map = { class = "engine.generator.map.Static", map = "!map" } } },
	},
}
