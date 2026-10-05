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
