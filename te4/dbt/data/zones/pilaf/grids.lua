load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_The_Glorious_Emperor_Pilaf_s_Castle_is_u",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	does_block_move = true,
	desc = "The Glorious Emperor Pilaf's Castle is under construction.",
	show_tooltip = true,
}
