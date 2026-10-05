return {
	name = "Sumo Dojo",
	level_range = {1, 1},
	max_level = 1,
	width = 36, height = 23,
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
