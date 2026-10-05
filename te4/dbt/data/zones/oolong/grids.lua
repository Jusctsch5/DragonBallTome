load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_A_beautiful_fountain",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	does_block_move = true,
	desc = "A beautiful fountain.",
	show_tooltip = true,
}
