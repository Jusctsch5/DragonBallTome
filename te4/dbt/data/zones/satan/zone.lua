return {
	name = "Mr. Satan's Estate",
	level_range = {1, 2},
	max_level = 2,
	width = 26, height = 19,
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
		[1] = { width = 26, height = 15 },
		[2] = { width = 23, height = 19,
			generator = { map = { class = "engine.generator.map.Static", map = "!house" } } },
	},
}
