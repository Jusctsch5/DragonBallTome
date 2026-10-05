load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_This_long_workbench_is_cluttered_with_ha",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	does_block_move = true,
	desc = "This long workbench is cluttered with half finished projects.",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_Dr_Briefs_bed_hasn_t_been_made",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true,
	does_block_move = true,
	desc = "Dr. Briefs' bed hasn't been made.",
	show_tooltip = true,
}
