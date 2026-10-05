load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_This_old_lantern_provides_some_illuminat",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "This old lantern provides some illumination",
	show_tooltip = true,
}
