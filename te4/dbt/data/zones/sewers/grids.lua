load("/data/general/grids/basic.lua")

newEntity{
	define_as = "SOFT_WALL",
	name = "soft wall",
	display = '#', color=colors.UMBER, back_color=colors.DARK_UMBER,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "MUD",
	name = "mud",
	display = ',', color=colors.UMBER, back_color=colors.DARK_UMBER,
}

newEntity{
	define_as = "SHALLOW_WATER",
	name = "shallow water",
	display = '~', color=colors.LIGHT_BLUE, back_color=colors.DARK_BLUE,
}

newEntity{
	define_as = "SWAMP",
	name = "swamp pool",
	display = '~', color=colors.GREEN, back_color=colors.DARK_GREEN,
}

newEntity{
	define_as = "GLASS",
	name = "glass wall",
	display = '#', color=colors.LIGHT_BLUE, back_color=colors.DARK_BLUE,
	always_remember = true,
	does_block_move = true,
}

newEntity{
	define_as = "DOWN_SEWER",
	name = "stairs down",
	display = '>', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	change_level = 1,
	desc = "Press > to go deeper.",
	show_tooltip = true,
}

newEntity{
	define_as = "UP_SEWER",
	name = "stairs up",
	display = '<', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	change_level = -1,
	desc = "Press > to go back up.",
	show_tooltip = true,
}
