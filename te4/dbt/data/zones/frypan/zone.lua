return {
	name = "Mount Frypan",
	level_range = {1, 2},
	max_level = 2,
	width = 78, height = 56,
	all_remembered = true,
	all_lited = true,
	persistent = "zone",
	generator = {
		map = {
			class = "engine.generator.map.Static",
			map = "!map",
		},
	},
	levels = {
		[1] = { width = 78, height = 56 },
		[2] = { width = 41, height = 29,
			generator = { map = { class = "engine.generator.map.Static", map = "!house" } } },
	},
}
