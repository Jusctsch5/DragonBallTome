return {
	name = "Uranai Baba's basement",
	level_range = {30, 30},
	max_level = 1,
	width = 22, height = 10,
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
