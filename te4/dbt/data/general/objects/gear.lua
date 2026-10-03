-- Starter kit from the ToME 3 birth descriptor: street clothes, a kubotan, shoes, and a note.

newEntity{
	define_as = "KUBOTAN",
	name = "kubotan",
	type = "weapon", subtype = "smallarm",
	display = "|", color=colors.SLATE,
	combat = { dam = 2 },
	desc = "A short striking stick.",
}

newEntity{
	define_as = "STREET_CLOTHES",
	name = "street clothes",
	type = "armor", subtype = "body",
	display = "(", color=colors.UMBER,
	combat_armor = 1,
	desc = "Ordinary clothes.",
}

newEntity{
	define_as = "TENNIS_SHOES",
	name = "tennis shoes",
	type = "armor", subtype = "feet",
	display = "]", color=colors.WHITE,
	desc = "A pair of tennis shoes.",
}

newEntity{
	define_as = "HIGH_HEELS",
	name = "high heels",
	type = "armor", subtype = "feet",
	display = "]", color=colors.LIGHT_RED,
	desc = "A pair of high heels.",
}

newEntity{
	define_as = "SLICE_NOTE",
	name = "note",
	type = "scroll", subtype = "paper",
	display = "?", color=colors.LIGHT_BLUE,
	desc = "This is the ToME 4 slice of Dragonball T. Chi, trainers, and the rest of the world are still ahead.",
}
