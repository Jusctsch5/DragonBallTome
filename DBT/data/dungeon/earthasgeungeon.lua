--[[
----------------------------------------------------------
-- Earth
----------------------------------------------------------
new_dungeon_type
{
	define_as = "DUNGEON_EARTH1"
	name = "Earth 1" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth1.map"
			desc = "Earth, southwest"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(1)
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_EARTH2"
	name = "Earth 2" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth2.map"
			desc = "Earth, south"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(1)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH3"
	name = "Earth 3" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth3.map"
			desc = "Earth, southeast"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(1)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH4"
	name = "Earth 4" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth4.map"
			desc = "Earth, west"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(1)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH5"
	name = "Earth 5" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth5.map"
			desc = "Earth"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(5)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH6"
	name = "Earth 6" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth6.map"
			desc = "Earth, east"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(6)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH7"
	name = "Earth 7" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth7.map"
			desc = "Earth, northwest"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(7)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH8"
	name = "Earth 1" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth8.map"
			desc = "Earth, north"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(8)
				end
			}
		}
	}
}new_dungeon_type
{
	define_as = "DUNGEON_EARTH9"
	name = "Earth 1" short_name = "Eth"
	desc = "The Planet Earth"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1	-- Using map_size...
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags {}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Earth"
			level_map = "maps/earth9.map"
			desc = "Earth, northeast"
			flags = {
				SPECIAL=true
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- dball.gen_earth(9)
				end
			}
		}
	}
}
----------------------------------------------------------
-- End Earth
----------------------------------------------------------
]]
