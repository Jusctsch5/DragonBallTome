return {
	name = "Land of Karin",
	level_range = {1, 5},
	max_level = 5,
	width = 114, height = 144,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = { map = { class = "engine.generator.map.Static", map = "!map" } },
	levels = {
		[1] = { width = 80, height = 144 },
		[2] = { width = 23, height = 15, generator = { map = { class = "engine.generator.map.Static", map = "!l2" } } },
		[3] = { width = 109, height = 76, generator = { map = { class = "engine.generator.map.Static", map = "!l3" } } },
		[4] = { width = 114, height = 28, generator = { map = { class = "engine.generator.map.Static", map = "!l4" } } },
		[5] = { width = 37, height = 13, generator = { map = { class = "engine.generator.map.Static", map = "!l5" } } },
	},
}
