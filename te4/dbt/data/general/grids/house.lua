-- Stairs and furnishings shared by the static Earth interiors.

newEntity{
	define_as = "UP_HOUSE",
	name = "previous floor",
	display = '<', color=colors.WHITE, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	change_level = -1,
	desc = "Press < to go up.",
	show_tooltip = true,
}

newEntity{
	define_as = "DOWN_HOUSE",
	name = "next floor",
	display = '>', color=colors.WHITE, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	change_level = 1,
	desc = "Press > to go down.",
	show_tooltip = true,
}

newEntity{
	define_as = "GLASS",
	name = "glass wall",
	display = '#', color=colors.LIGHT_BLUE, back_color=colors.DARK_GREY,
	always_remember = true,
	does_block_move = true,
}

newEntity{
	define_as = "FIRE",
	name = "wall of fire",
	display = 'w', color=colors.LIGHT_RED, back_color=colors.RED,
	always_remember = true,
	does_block_move = true,
}

newEntity{
	define_as = "SNOW",
	name = "snow",
	display = '.', color=colors.WHITE, back_color=colors.DARK_BLUE,
}

newEntity{
	define_as = "SIGNPOST",
	name = "signpost",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	desc = "A signpost.",
	show_tooltip = true,
}

newEntity{
	define_as = "BUDDHA",
	name = "buddha",
	display = '&', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "DIRT",
	name = "dirt",
	display = '.', color=colors.UMBER, back_color=colors.DARK_UMBER,
}

newEntity{
	define_as = "DEEP_WATER",
	name = "deep water",
	display = '~', color=colors.BLUE, back_color=colors.DARK_BLUE,
	does_block_move = true,
}

newEntity{
	define_as = "FURNITURE",
	name = "furniture",
	display = '#', color=colors.UMBER, back_color=colors.DARK_UMBER,
	always_remember = true,
	does_block_move = true,
}

newEntity{
	define_as = "CARPET_RED",
	name = "carpet",
	display = '.', color=colors.RED, back_color=colors.RED,
}

newEntity{
	define_as = "CARPET_GREEN",
	name = "carpet",
	display = '.', color=colors.GREEN, back_color=colors.DARK_GREEN,
}

newEntity{
	define_as = "CARPET_BLUE",
	name = "carpet",
	display = '.', color=colors.LIGHT_BLUE, back_color=colors.DARK_BLUE,
}

newEntity{
	define_as = "TROPHY",
	name = "trophy",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	does_block_move = true,
	desc = "A trophy.",
	show_tooltip = true,
}

newEntity{
	define_as = "KAME_TV",
	name = "television",
	display = '=', color=colors.LIGHT_BLUE, back_color=colors.DARK_GREY,
	notice = true,
	on_move = function(self, x, y, who)
		if not who or not who.player or who.rosshi_student then return end
		who.rosshi_from_tv = true
		local Chat = require "engine.Chat"
		Chat.new("rosshi", who, who):invoke()
	end,
}

newEntity{
	define_as = "SKY",
	name = "sky",
	display = ' ', color=colors.LIGHT_BLUE, back_color=colors.DARK_BLUE,
	does_block_move = true,
}

newEntity{
	define_as = "SPACE",
	name = "space",
	display = '.', color=colors.WHITE, back_color=colors.BLACK,
	does_block_move = true,
}

newEntity{
	define_as = "NAMEK_GROUND",
	name = "namekian ground",
	display = '-', color=colors.LIGHT_GREEN, back_color=colors.DARK_GREEN,
}

newEntity{
	define_as = "NAMEK_MOUNTAIN",
	name = "mountain",
	display = '^', color=colors.WHITE, back_color=colors.DARK_GREEN,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "NAMEK_WATER",
	name = "water",
	display = 'W', color=colors.LIGHT_BLUE, back_color=colors.BLUE,
	does_block_move = true,
}

newEntity{
	define_as = "AJASA",
	name = "ajasa",
	display = ',', color=colors.GREEN, back_color=colors.DARK_GREEN,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "BUILDING",
	name = "building",
	display = '#', color=colors.WHITE, back_color=colors.DARK_UMBER,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "ASH",
	name = "ash",
	display = '.', color=colors.SLATE or colors.WHITE, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "LAVA",
	name = "lava",
	display = '~', color=colors.LIGHT_RED, back_color=colors.RED,
	does_block_move = true,
}

newEntity{
	define_as = "LAVA_WALL",
	name = "volcanic rock",
	display = '#', color=colors.RED, back_color=colors.DARK_GREY,
	does_block_move = true,
	block_sight = true,
}

newEntity{
	define_as = "CLOUD",
	name = "cloud",
	display = '*', color=colors.WHITE, back_color=colors.DARK_BLUE,
}

newEntity{
	define_as = "ROAD",
	name = "road",
	display = '.', color=colors.SLATE or colors.WHITE, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "TEMPLE_LOCK",
	name = "sturdy door",
	display = '+', color=colors.UMBER, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	does_block_move = true,
	block_sight = true,
	dbt_temple_lock = true,
}
