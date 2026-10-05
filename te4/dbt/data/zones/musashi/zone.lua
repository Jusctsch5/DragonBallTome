return {
	name = "Musashi's Cave",
	level_range = {1, 1},
	max_level = 1,
	width = 25, height = 16,
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
