-- Dragonball T: Galaxy Map and Planets

new_wilderness_terrain
{
	name = "Deep Space"
	long_name = "Describe me!"
	char = 'X'
	feat = FEAT_WORLD_BORDER
	type = TERRAIN_EDGE
	level = 1
	generator= {
		FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE,
		FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE,
		FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE,
		FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE,
		FEAT_AESTHETIC_SPACE, FEAT_AESTHETIC_SPACE,
	}
}

new_wilderness_terrain
{
	name = "Deep Space"
	long_name = "Space"
	char = '.'
	feat = FEAT_DEEP_SPACE
	type = TERRAIN_GRASS
	level = 1
	generator= {
		FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE,
		FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE,
		FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE,
		FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE, FEAT_DEEP_SPACE,
		FEAT_DEEP_SPACE, FEAT_DEEP_SPACE,
	}
}

new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 1"
	char = '1'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 15
	entrance = 1
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_HARD=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 2"
	char = '2'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 15
	entrance = 2
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_HARD=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 3"
	char = '3'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 27
	entrance = 3
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_HARD=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 4"
	char = '4'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 5
	entrance = 4
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_EASY=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 5"
	char = '5'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 1
	entrance = 5
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_SAFE=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 6"
	char = '6'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 33
	entrance = 6
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_DEADLY=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 7"
	char = '7'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 1
	entrance = 7
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { AQUATIC=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 8"
	char = '8'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 5
	entrance = 8
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = { ALLOW_IN_EARTH_EASY=true } } }
}
new_wilderness_terrain
{
	name = "Dragonworld"
	long_name = "Earth 9"
	char = '9'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 17
	entrance = 9
	generator= {
		FEAT_DIRT, FEAT_DIRT, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS, FEAT_GRASS,
		FEAT_GRASS, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
		FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES, FEAT_TREES,
	}
	rules = { [{100, "or"}] = { flags = {
							ALLOW_IN_EARTH_HARD=true
							ALLOW_IN_EARTH_DEADLY=true
							} } }
}


new_wilderness_terrain
{
	name = "Namek"
	long_name = "southwest quadrant"
	char = 'A'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 33
	entrance = 10
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_NAMEK=true
			}
		}
	}
}
new_wilderness_terrain
{
	name = "Namek"
	long_name = "southeast quadrant"
	char = 'B'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 33
	entrance = 11
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_NAMEK=true
			}
		}
	}
}
new_wilderness_terrain
{
	name = "Namek"
	long_name = "northwest quadrant"
	char = 'C'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 33
	entrance = 12
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_NAMEK=true
			}
		}
	}
}
new_wilderness_terrain
{
	name = "Namek"
	long_name = "northeast quadrant"
	char = 'D'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 42
	entrance = 13
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_NAMEK=true
			}
		}
	}
}


new_wilderness_terrain
{
	name = "North Kaio's"

	long_name = "North Kaio's Planet"
	char = 'E'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 1
	entrance = 14
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_GRASS,
		FEAT_GRASS,
		FEAT_GRASS,
		FEAT_GRASS,
		FEAT_GRASS,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
		FEAT_TREES,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_KAIO_WORLD=true
			}
		}
	}
}

new_wilderness_terrain
{
	name = "Planet 79"

	long_name = "Planet 79"
	char = 'F'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 33
	entrance = 15
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_79=true
			}
		}
	}
}

-- Placeholder for the Ruins of Planet Plant
new_wilderness_terrain
{
	name = "Asteroid"

	long_name = "Asteroid Field"
	char = 'G'
	feat = FEAT_TOWN
	type = TERRAIN_TOWN
	level = 33
	entrance = 16
	generator= {
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DIRT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
		FEAT_DESERT,
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_ON_PLANT=true
			}
		}
	}
}
