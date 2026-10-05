return {
	name = "Crane Hermit",
	level_range = {1, 1},
	max_level = 1,
	width = 16, height = 12,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = {
		map = {
			class = "engine.generator.map.Static",
			map = "!map",
		},
	},
}
