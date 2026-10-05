load("/data/general/grids/basic.lua")
load("/data/general/grids/house.lua")

newEntity{
	define_as = "SIGN_The_sign_reads_Castle_of_the_Lord_of_the",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The sign reads 'Castle of the Lord of the Underworld'",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_The_sign_reads_East_not_implemented_yet_",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The sign reads 'East not implemented yet. Don't go east.'",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_The_sign_reads_This_way_to_the_lounge_ar",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The sign reads 'This way to the lounge areas'",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_The_sign_reads_Welcome_to_Hell",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The sign reads 'Welcome to Hell!'",
	show_tooltip = true,
}

newEntity{
	define_as = "SIGN_The_sign_reads_This_way_to_the_emergency",
	name = "sign",
	display = '!', color=colors.YELLOW, back_color=colors.DARK_UMBER,
	notice = true, does_block_move = true,
	desc = "The sign reads 'This way to the emergency escape escalator!'",
	show_tooltip = true,
}
