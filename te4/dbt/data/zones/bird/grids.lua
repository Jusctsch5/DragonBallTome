load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "TO_frypan",
	name = "frypan",
	display = '>', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, always_remember = true,
	change_level = 1, change_zone = "frypan",
	desc = "Press > to enter.",
}
