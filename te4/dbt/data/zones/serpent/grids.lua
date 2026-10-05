load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "TO_kaio",
	name = "North Kaio",
	display = '>', color=colors.YELLOW, back_color=colors.DARK_BLUE,
	notice = true, always_remember = true,
	change_level = 1, change_zone = "kaio",
	desc = "Press > to enter.",
}

newEntity{
	define_as = "TO_karin",
	name = "karin",
	display = '>', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, always_remember = true,
	change_level = 1, change_zone = "karin",
	desc = "Press > to enter.",
}
