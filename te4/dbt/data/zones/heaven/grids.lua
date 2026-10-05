load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_The_sign_says_Welcome_to_Heaven",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The sign says 'Welcome to Heaven!'",
	show_tooltip = true,
}
