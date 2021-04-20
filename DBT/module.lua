add_module
{
	name        = "Dragonball T",
	shortname   = "DBT",
	version     = { 0, 9, 1 },
	author      = { "LordBucket", "lordbucket@hotmail.com" },
	desc        =
	{
		"This module is for alpha 18",
		"",
		"Dragonball T is a total conversion module with a martial arts theme, based loosely on the Dragonball",
		"series of Japanese anime, though it contains material from other martial arts themed sources as well.",
		"",
		"Current Status:",
		"No win condition in place yet, but the module is very playable up to roughly level 50, and features:",
		" * Unique skill progression\character advancement system",
		" * Unique combat and magic systems",
		" * 21 Dungeons",
		" * 34 Special levels",
		" * Roughly 670K of in-game dialogue",
		"",
		"Much of Dragonball T is different from the ToME module. If this is your first time playing,",
		"it is highly recommended that you read through the in-game help files accessible via the '?' key",
		"Version-specific Release Notes area available from your inventory, in-game",
	},

	base_dungeon = 0,

	max_money = 99999999

	max_plev = 100,
	max_exp = 99999999

	allow_skill_raise = function(idx)
		return "Skills may not be purchased directly. Find a trainer."
	end,
	max_skill_level = 999,
	skill_per_level = function()
		return 6
	end,
}















