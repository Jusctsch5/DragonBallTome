load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_A_sign_on_the_door_reads_Authorized_Pers",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "A sign on the door reads 'Authorized Personel -=Only=-",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_A_bed",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "A bed",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_The_floor_in_this_area_has_not_been_smoo",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The floor in this area has not been smoothed.",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_A_bed",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "A bed",
	show_tooltip = true,
}
