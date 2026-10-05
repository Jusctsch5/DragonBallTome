return {
	name = "Judo Dojo",
	level_range = {1, 1},
	max_level = 1,
	width = 25, height = 15,
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
