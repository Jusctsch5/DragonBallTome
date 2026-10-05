-- Templates cloned when a monster drops money, a corpse, or a Dragon Ball.

newEntity{
	define_as = "LOOT_ZENI",
	name = "zeni",
	type = "money", subtype = "money",
	display = "$", color = colors.YELLOW,
	encumber = 0,
	cost = 0,
	desc = "It's the love of money that's the root of all evil. So if you don't love it, it's safe to collect as much as you can, right?",
	dbt_zeni = 1,
}

newEntity{
	define_as = "LOOT_CORPSE",
	name = "corpse",
	type = "corpse", subtype = "corpse",
	display = "~", color = colors.LIGHT_UMBER,
	encumber = 80,
	cost = 0,
	dbt_use = "eat",
	heal = 12,
	desc = "Whatever happened with this one, it wasn't pretty.",
}

newEntity{
	define_as = "LOOT_DRAGONBALL",
	name = "Dragon Ball",
	type = "dragonball", subtype = "dragonball",
	display = "*", color = colors.ORANGE,
	encumber = 1000,
	cost = 10000,
	desc = "One of the seven Dragon Balls.",
}
