load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_Dinner_Table",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	does_block_move = true,
	desc = "Dinner Table",
	show_tooltip = true,
}
