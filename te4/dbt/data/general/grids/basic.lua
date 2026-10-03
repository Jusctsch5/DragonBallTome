-- Terrain for the Earth 1 slice and Uranai Baba's house.

newEntity{
	define_as = "GRASS",
	name = "grass",
	display = '.', color=colors.LIGHT_GREEN, back_color=colors.DARK_GREEN,
}

newEntity{
	define_as = "ROAD",
	name = "road",
	display = '=', color=colors.SLATE, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "TREE",
	name = "tree",
	display = 'T', color=colors.GREEN, back_color=colors.DARK_GREEN,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "WATER",
	name = "water",
	display = '~', color=colors.BLUE, back_color=colors.DARK_BLUE,
	always_remember = true,
	does_block_move = true,
}

newEntity{
	define_as = "MOUNTAIN",
	name = "mountain",
	display = '^', color=colors.WHITE, back_color=colors.DARK_GREY,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "BUILDING",
	name = "building",
	display = '#', color=colors.WHITE, back_color=colors.DARK_UMBER,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "DOWN_URANAI",
	name = "path to Uranai Baba's house",
	display = '>', color=colors.YELLOW, back_color=colors.DARK_GREEN,
	notice = true,
	always_remember = true,
	change_level = 1,
	change_zone = "uranai",
	desc = "A path down to Uranai Baba's house. Use the change-level key to enter.",
	show_tooltip = true,
}

newEntity{
	define_as = "UP_EARTH",
	name = "exit to Earth",
	display = '<', color=colors.YELLOW, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	change_zone = "earth1",
	desc = "The way back outside. Use the change-level key to leave.",
	show_tooltip = true,
}

newEntity{
	define_as = "FLOOR",
	name = "floor",
	display = '.', color=colors.WHITE, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "FLOOR_ALT",
	name = "floor",
	display = ',', color=colors.SLATE, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "WALL",
	name = "wall",
	display = '#', color=colors.UMBER, back_color=colors.DARK_UMBER,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "MAP_BORDER",
	name = "map edge",
	display = '*', color=colors.DARK_GREY, back_color=colors.BLACK,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "DOOR",
	name = "door",
	display = '+', color=colors.UMBER, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "DOOR_OPEN",
	dig = "DOOR_OPEN",
}

newEntity{
	define_as = "DOOR_OPEN",
	name = "open door",
	display = "'", color=colors.UMBER, back_color=colors.DARK_GREY,
	always_remember = true,
	door_closed = "DOOR",
}

newEntity{
	define_as = "LAMP",
	name = "lantern",
	display = '|', color=colors.YELLOW, back_color=colors.DARK_GREY,
	notice = true,
	desc = "This old lantern provides some illumination.",
	show_tooltip = true,
}

newEntity{
	define_as = "PLACARD",
	name = "placard",
	display = '?', color=colors.LIGHT_RED, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	desc = "A placard reads 'Visitors will be turned to goo!'",
	show_tooltip = true,
}
