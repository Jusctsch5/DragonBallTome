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
	change_zone = "earth5",
	dbt_return = true,
	desc = "The way back outside. Press > to leave.",
	show_tooltip = true,
}

newEntity{
	define_as = "FLOOR",
	name = "floor",
	display = '.', color=colors.WHITE, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "CARPET_GREEN",
	name = "green carpet",
	display = '.', color=colors.GREEN, back_color=colors.DARK_GREEN,
}

newEntity{
	define_as = "CARPET_BLUE",
	name = "blue carpet",
	display = '.', color=colors.LIGHT_BLUE, back_color=colors.DARK_BLUE,
}

newEntity{
	define_as = "SAND",
	name = "sand",
	display = '.', color=colors.YELLOW, back_color=colors.DARK_UMBER,
}

newEntity{
	define_as = "RING",
	name = "fighting ring",
	display = '-', color=colors.RED, back_color=colors.DARK_GREY,
	dbt_ring = true,
	notice = true,
}

newEntity{
	define_as = "RING_EDGE",
	name = "edge of the ring",
	display = '.', color=colors.WHITE, back_color=colors.DARK_GREY,
	dbt_ring_edge = true,
}

newEntity{
	define_as = "OUTSIDE_RING",
	name = "outside of the ring",
	display = '.', color=colors.WHITE, back_color=colors.DARK_GREY,
	dbt_ring_out = true,
}

newEntity{
	define_as = "WT_DOOR",
	name = "backstage door",
	display = '+', color=colors.UMBER, back_color=colors.DARK_UMBER,
	dbt_wt_door = true,
	block_sight = true,
}

newEntity{
	define_as = "WT_BLOCKER",
	name = "door",
	display = '+', color=colors.UMBER, back_color=colors.DARK_UMBER,
	block_sight = true,
	desc = "You push through the door.",
}

newEntity{
	define_as = "UP_DOJO",
	name = "way out of the dojo",
	display = '<', color=colors.YELLOW, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	dbt_dojo_return = true,
	desc = "The way back to the street. Press > to leave.",
	show_tooltip = true,
}

newEntity{
	define_as = "URANAI_CELLAR",
	name = "floor",
	display = '.', color=colors.WHITE, back_color=colors.DARK_GREY,
	dbt_basement_spot = true,
}

newEntity{
	define_as = "DOWN_URANAI_CELLAR",
	name = "stairs down to the basement",
	display = '>', color=colors.YELLOW, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	dbt_uranai_down = true,
	desc = "Stairs into Uranai Baba's basement. Press > to go down.",
	show_tooltip = true,
}

newEntity{
	define_as = "UP_URANAI_CELLAR",
	name = "stairs up to the house",
	display = '<', color=colors.YELLOW, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
	dbt_uranai_return = true,
	desc = "The way back up to the house. Press > to leave.",
	show_tooltip = true,
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
