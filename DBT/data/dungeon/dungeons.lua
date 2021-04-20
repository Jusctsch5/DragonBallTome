-- See also scripts/dungeon_aux.lua.

--------------------------------------------------------
---- Special Wilderness definition ---------------------
--------------------------------------------------------

new_dungeon_type
{
	__index__ = 0
	name = "Wilderness" short_name = "Wdn"
	desc = "*A BUG*YOU should see this message!*"
	mindepth = 0 maxdepth = 0
	min_player_level = 1
	size_y = 3 size_x = 3
	min_monsters = 14
	alloc_chance = 500
	flags =
		{
		FLAT=true NO_SHAFT=true NO_RECALL=true
		-- OBJ_THEME = getter.flags { THEME_TREASURE=100 }
		-- SAVE_LEVEL=true
		-- SAVED_LEVEL_DECAY_MONSTERS={100,400}
		-- SAVED_LEVEL_DECAY_OBJECTS={50,200}
		-- -- SAVED_LEVEL_DECAY_EFFECTS=true
		-- SAVED_LEVEL_DECAY_EXTRA=dungeons.maintain_decaying_level
	}
	floors =
	{
		[FEAT_GRASS] = 100
	}
	walls =
	{
		inner = FEAT_TREES,
		outer = FEAT_TREES,
		[FEAT_TREES] = 50
		[FEAT_GRASS] = 50
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_NUTCRACKER"
	name = "Warehouse" short_name = "WrH"
	desc = "a not-so-abandoned warehouse"
	mindepth = 7 maxdepth = 7
	min_player_level = 1
	size_y = 2 size_x = 1
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
		OBJ_THEME = getter.flags { THEME_FRENCH=100 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[7] =
		{
			name = "Stage"
			level_map = "maps/stage.map"
			desc = "Describe me! dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_NINJA_SEWERS"
	name = "Sewers" short_name = "Swr"
	desc = "The City Sewers"
	mindepth = 5 maxdepth = 9
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_MUD] = { 45, 45 }
		[FEAT_SHAL_WATER] = { 45, 45 }
		[FEAT_SWAMP_POOL] = { 10, 10 }
	}
	walls =
	{
		inner = FEAT_SOFT_WALL,
		outer = FEAT_SOFT_WALL,
		[FEAT_SOFT_WALL] = { 100, 100 }
		[FEAT_WALL_EXTRA] = { 0, 0 }
		[FEAT_WALL_EXTRA] = { 0, 0 }
	}
	flags =
	{
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_PLAIN=40 THEME_ACCESSORY=30 THEME_JUNK=5 THEME_GOLD=20 THEME_TOXIC=5 }
		LEVEL_GENERATE_POST = function()
			dball.purge_feats(FEAT_MUD)
			wiz_lite(true)
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_SEWERS=true
			}
		}
	}
	levels =
	{
		[9] =
		{
			name = "Turtles Lair"
			level_map = "maps/turtles.map"
			desc = "Turtles Lair"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true	
				DBT_LEVEL_FEELING=function()
					message(color.YELLOW, "You feel like this level has not been implemented.")
				end
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_NINJA_WAREHOUSE"
	name = "Foot Lair" short_name = "Fot"
	desc = "Foot Lair"
	mindepth = 15 maxdepth = 21
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 80
		[FEAT_MUD] = 20
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_MARTIAL=20 THEME_NINJA=60 THEME_GOLD=20 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_NINJA_WAREHOUSE=true
				ALLOW_IN_FOOT_LAIR=true
			}
		}
	}
	levels =
	{
		[15] =
		{
			name = "Juvinile Playground"
			level_map = "maps/juvinile.map"
			desc = "Juvinile Playground"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					if dball_data.has_visited_warehouse == 0 then
						dball_data.has_visited_warehouse = 1
						for i = 1, 4 do
							local flags = flag_new()
							flag_set(flags, FLAG_THEME_ELECTRONICS, 100)
							local obj = rand_obj.get_themed_obj(8, flags)
							make_item_fully_identified(obj)
							drop_near(obj, -1, i + 9, 23)
						end
					end
				end
			}
		}
		[21] =
		{
			name = "Inner Sanctum"
			level_map = "maps/foot_lair.map"
			desc = "Inner Sanctum"
			flags = {
				-- Inner Sanctum is a save level! 
				SAVE_LEVEL=true 
				-- NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					-- Un-annoy The Foot Clan
					if dball_data.foot_clan_rapport ~= 3 then
						dball.faction_unannoy(FACTION_FOOT)
					end
					-- Things to do only once
					if dball_data.has_visited_sanctum == 0 then
						dball_data.has_visited_sanctum = 1
						-- Stock the supply room

							local obj = create_object(TV_BODY_ARMOUR, SV_NINJA_UNIFORM)
							drop_near(obj, -1, 23, 6)
							local obj = create_object(TV_HEADPIECE, SV_NINJA_HOOD)
							drop_near(obj, -1, 24, 6)
							local obj = create_object(TV_BRACERS, SV_NINJA_BRACERS)
							drop_near(obj, -1, 25, 6)
							local obj = create_object(TV_BOOTS, SV_NINJA_TABI)
							drop_near(obj, -1, 26, 6)
							local obj = create_object(TV_BOOTS, SV_NINJA_CLIMBING_TABI)
							drop_near(obj, -1, 23, 5)
							local obj = create_object(TV_SMALLARM, SV_NINJA_CLAW)
							drop_near(obj, -1, 24, 5)
							local obj = create_object(TV_SWORDARM, SV_NINJA_TO)
							drop_near(obj, -1, 25, 5)
							local obj = create_object(TV_GLOVES, SV_NINJA_CLIMBING_CLAWS)
							drop_near(obj, -1, 26, 5)

						-- Place Turtles?
						-- Place Traps
						for i = 1, cur_wid - 2 do
							for j = 1, cur_hgt - 2 do
								if rng(5) <= 1 then
									-- Check light status?
									--place_trap(j, i, FACTION_DUNGEON, 20)
								end
							end
						end
					end
				end
			}
		}
	}
}

-- The Laborotory of Dr. Gero
new_dungeon_type
{
	define_as = "DUNGEON_GERO_LAB"
	name = "Dr. Gero's Lab" short_name = "Lab"
	desc = "Dr. Gero's Lab"
	mindepth = 80 maxdepth = 100
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 10
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_TECHNO=100 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_GERO_LAB=true
			}
		}
	}
	levels =
	{
		[80] =
		{
			name = "Dr. Gero's Lab"
			level_map = "maps/gerolair.map"
			desc = "Laboratory"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}





--*****************************************
--***********The World Tournament**********
--*****************************************

new_dungeon_type
{
	define_as = "DUNGEON_TOURNAMENT"
	name = "World Tournament" short_name = "W-T"
	desc = "World Tournament"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 2 size_x = 1
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
		SAVE_LEVEL=true 
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		NO_NEW_MONSTER=true
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
			name = "World Tournament"
			level_map = "maps/tournament.map"
			desc = "Describe me! I am a World Tournament!"
			flags = {
				LEVEL_GENERATE_POST = function()
					if dball_data.tourny_registered > 1 then
					end
				end
			}
		}
	}
}


--************************************************************
--***********Dungeon Arenas for the Challenge Quests**********
--************************************************************
new_dungeon_type
{
	define_as = "DUNGEON_D_KARA"
	name = "Duel vs Karate" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_JAPANESE=100 }
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			if race_info_idx(RACE_NAKAMURA, 0).max_num ~= 0 then
				dball_data.fled_karate = 1
				message(color.YELLOW, "You have fled like a coward!")
			end
			if quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_TAKEN then
				quest(QUEST_CHALLENGE_KARATE).status = QUEST_STATUS_FAILED
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_kara.map"
			desc = "Karate Dojo"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					message(color.YELLOW, "Good luck!")

					dball_data.teleport_dungeon = 1

					local obj = create_object(TV_BODY_ARMOUR, SV_MEDIUMWEIGHT_GI)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 14, 16)
					local obj = create_object(TV_BODY_ARMOUR, SV_HEAVYWEIGHT_GI)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 15, 16)
					local obj = create_object(TV_SWORDARM, SV_SHINAI)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 16, 16)
						-- Party
						dueling = 1 -- No intervention from party!
					DBT_LEVEL_FEELING=function()
						-- Party
						dueling = 1 -- No intervention from party!
						monster_counter_hack = 0
						for_each_monster(function(m_idx, monst)
							if monst.flags[FLAG_PARTY_PARTIED] and monst.flags[FLAG_PARTY_PARTIED] == true then
								monst.fy = 2
								monst.fx = monster_counter_hack + 2
								monster_counter_hack = monster_counter_hack + 1
							end
						end)
					end
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_KUNG"
	name = "Duel vs Kung Fu" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_CHINESE=100 }
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			if race_info_idx(RACE_FONG_SAI_YUK, 0).max_num ~= 0 then
				dball_data.fled_kungfu = 1
				message(color.YELLOW, "You have fled like a coward!")
			end
			if quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_TAKEN then
				quest(QUEST_CHALLENGE_KUNGFU).status = QUEST_STATUS_FAILED
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_kung.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					-- Party
					dueling = 1 -- No intervention from party!
					message(color.YELLOW, "Good luck!")
					dball_data.teleport_dungeon = 2
					local obj = create_object(TV_SWORDARM, SV_STRAIGHTSWORD)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 11, 23)
					local obj = create_object(TV_SWORDARM, SV_SABRE)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 11, 24)
					local obj = create_object(TV_POLEARM, SV_WAXWOOD_STAFF)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 12, 23)
					local obj = create_object(TV_BODY_ARMOUR, SV_TAI_CHI_UNIFORM)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 12, 24)
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_FENCE"
	name = "Duel vs Fencing" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_FRENCH=100 }
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			if race_info_idx(RACE_JACQUE, 0).max_num ~= 0 then
				dball_data.fled_fencing = 1
				message(color.YELLOW, "You have fled like a coward!")
			end
			if quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_TAKEN then
				quest(QUEST_CHALLENGE_FENCING).status = QUEST_STATUS_FAILED
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_fence.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					message(color.YELLOW, "It is dark. To create atmosphere, no?")
					dball_data.teleport_dungeon = 10
					local obj = create_object(TV_BODY_ARMOUR, SV_FENCING_ARMOR)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 1, 1)
					local obj = create_object(TV_HEADPIECE, SV_FENCING_MASK)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 2, 1)
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_KICK"
	name = "Duel vs Kickboxing" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_PLAIN=100 }
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			if race_info_idx(RACE_BOB, 0).max_num ~= 0 then
				dball_data.fled_kickboxing = 1
				message(color.YELLOW, "You have fled like a coward!")
			end
			if quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_TAKEN then
				quest(QUEST_CHALLENGE_KICKBOXING).status = QUEST_STATUS_FAILED
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_kick.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					message(color.YELLOW, "Good luck!")
					dball_data.teleport_dungeon = 3
					local obj = create_object(TV_BODY_ARMOUR, SV_BOXING_SHORTS)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 4, 17)
					local obj = create_object(TV_GLOVES, SV_LIGHT_BOXING_GLOVES)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 4, 18)
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_TAEK"
	name = "Duel vs TaeKwonDo" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_MARTIAL=100 }
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			if race_info_idx(RACE_MASTER_LEE, 0).max_num ~= 0 then
				dball_data.fled_taekwondo = 1
				message(color.YELLOW, "You have fled like a coward!")
			end
			if quest(QUEST_CHALLENGE_TAEKWONDO).status == QUEST_STATUS_TAKEN then
				quest(QUEST_CHALLENGE_TAEKWONDO).status = QUEST_STATUS_FAILED
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_taek.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					message(color.YELLOW, "Good luck!")
					dball_data.teleport_dungeon = 4
					local obj = create_object(TV_BODY_ARMOUR, SV_DOBAK)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 11, 12)
					local obj = create_object(TV_SMALLARM, SV_SANJOBANG)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 11, 13)
					local obj = create_object(TV_POLEARM, SV_BO_STAFF)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 11, 14)
				end
			}
		}
	}
}
new_dungeon_type
{
      define_as = "DUNGEON_D_SUMO"
      name = "Duel vs Sumo" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_JAPANESE=100 }
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			-- if race_info_idx(RACE_HONDA, 0).max_num ~= 0 then
			if dball_data.fled_sumo == 2 then
				-- Left the ring, may have been thrown, simply lost the match
			elseif dball.how_many_exist(RACE_HONDA) > 0 then
				-- Anyone who trips this is teleporting to the stairs, or out completely
				dball_data.fled_sumo = 1
				message(color.YELLOW, "You have fled like a coward!")
				if quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_TAKEN then
					quest(QUEST_CHALLENGE_SUMO).status = QUEST_STATUS_FAILED
					message(color.YELLOW, "Yawara will surely close her school in shame!")
				end
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_sumo.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					message(color.YELLOW, "Good luck!")
					dball_data.teleport_dungeon = 7
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_JUDO"
	name = "Duel vs Judo" short_name = "Dul"
	desc = "a duel"
	mindepth = 20 maxdepth = 20
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_JAPANESE=100 }
		LEFT_DUNGEON = function()
			if dball.how_many_exist(RACE_YAWARA) > 0 then
				dball_data.fled_judo = 1
				message(color.YELLOW, "You have fled from the duel!")
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[20] =
		{
			name = "Challenge"
			level_map = "maps/d_judo.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					-- Don't have to win to complete the quest for Honda...just have to get her to fight
					if quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_TAKEN then
						quest(QUEST_CHALLENGE_JUDO).status = QUEST_STATUS_COMPLETED
						message(color.YELLOW, "Yawara has a fiery look in her eyes. Looks like her dueling spirit has returned.")
					end
					dball_data.teleport_dungeon = 8
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_MARKS"
	name = "The Gun Store" short_name = "Dul"
	desc = "a duel"
	mindepth = 23 maxdepth = 23
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_BALLISTICS=100 }
							-- implement: guns and ammo only, no launchers
		LEFT_DUNGEON = function()
			-- Done this way to accomodate people who challenge without taking the quest
			if race_info_idx(RACE_CHARLETON, 0).max_num ~= 0 then
				dball_data.fled_marksmanship = 1
				message(color.YELLOW, "You have fled like a coward!")
			end
--			if quest(QUEST_CHALLENGE_MARKSMANSHIP).status == QUEST_STATUS_TAKEN then
--				quest(QUEST_CHALLENGE_MARKSMANSHIP).status = QUEST_STATUS_FAILED
--			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[23] =
		{
			name = "Challenge"
			level_map = "maps/d_marks.map"
			desc = "Gun Store"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					message(color.YELLOW, "Good luck!")

					dball_data.teleport_dungeon = 11
--[[
					local obj = create_object(TV_BODY_ARMOUR, SV_MEDIUMWEIGHT_GI)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 13, 15)
					local obj = create_object(TV_BODY_ARMOUR, SV_HEAVYWEIGHT_GI)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 14, 15)
					local obj = create_object(TV_SWORDARM, SV_SHINAI)
					make_item_fully_identified(obj)
					drop_near(obj, -1, 15, 15)
]]
				end
			}
		}
	}
}
-------------------------------
-- End Challenge Quest Dungeons
-------------------------------

new_dungeon_type
{
	define_as = "DUNGEON_SUSHI"
	name = "Sushi Bar" short_name = "Bar"
	desc = "Sushi Bar"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_SUSHI=100 }
		LEFT_DUNGEON = function()
					-- Details handled in dialogue
					-- message(color.YELLOW, "You have fled!")
				end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[1] =
		{
			name = "Sushi Bar"
			level_map = "maps/sushi.map"
			desc = "Sushi Bar"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				-- OBJ_THEME = getter.flags { THEME_FOOD=100 }
				LEVEL_GENERATE_POST = function()
					dball_data.teleport_dungeon = 9
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_NINJ"
	name = "A Ninja Duel" short_name = "Dul"
	desc = "A Ninja Duel"
	mindepth = 21 maxdepth = 21
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_NINJA=100 }
		-- No Leave level flag here?
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[21] =
		{
			name = "Challenge"
			level_map = "maps/d_ninj.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					for i = 1, cur_wid - 2 do
						for j = 1, cur_hgt - 2 do
							if rng(5) <= 1 then
								place_trap(j, i, FACTION_DUNGEON, 20)
							end
						end
					end

					message(color.YELLOW, "Good luck! Be careful. Ninja can be tricky.")
					dball_data.teleport_dungeon = 5
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_D_BALLET"
	name = "Mech Studio" short_name = "Dul"
	desc = "Mech Studio"
	mindepth = 21 maxdepth = 21
	min_player_level = 1
	size_y = 2 size_x = 1
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
		NO_RECALL=true NO_RECALL_OUT=true NO_EASY_MOVE=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_FRENCH=50 THEME_TECHNO=50 }
		-- No Leave level flag here?
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_DOJO=true
			}
		}
	}
	levels =
	{
		[21] =
		{
			name = "Challenge"
			level_map = "maps/d_ball.map"
			desc = "Describe me! dojo in dungeons.lua"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
						-- Party
						dueling = 1 -- No intervention from party!
					for i = 1, cur_wid - 2 do
						for j = 1, cur_hgt - 2 do
							if rng(5) <= 1 then
								place_trap(j, i, FACTION_DUNGEON, 20)
							end
						end
					end

					-- message(color.YELLOW, "Good luck! Be careful. Ninja can be tricky.")
					dball_data.teleport_dungeon = 6
				end
			}
		}
	}
}

-- Buddhist Temple
new_dungeon_type
{
	define_as = "DUNGEON_TEMPLE"
	name = "Buddhist Temple" short_name = "Tpl"
	desc = "Buddhist Temple"
	mindepth = 17 maxdepth = 23
	min_player_level = 1
	size_y = 4 size_x = 3
	min_monsters = 20
	alloc_chance = 160
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
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_MARTIAL=100 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_TEMPLE=true
			}
		}
	}
	levels =
	{
		[17] =
		{
			name = "Temple"
			level_map = "maps/temple.map"
			desc = "Buddhist Temple"
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				-- SAVED_LEVEL_DECAY_MONSTERS={100,400}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					dball.delete_monster("corrupt monk")
					dball.delete_monster("invader monk")
					dball.delete_monster("defiler monk")
					dball.delete_monster("ancient priest")
					--if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
					--	if dball.how_many_exist(RACE_ABBOT) < 1 then
					--		place_named_monster(7, 21, "The Abbot", 0)
					--	end
					--end
				end
			}
		}
		[18] =
		{
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
						dball.delete_monster("corrupt monk")
						dball.delete_monster("invader monk")
						dball.delete_monster("defiler monk")
						dball.delete_monster("ancient priest")
					end
				end
			}
		}
		[19] =
		{
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
						dball.delete_monster("corrupt monk")
						dball.delete_monster("invader monk")
						dball.delete_monster("defiler monk")
						dball.delete_monster("ancient priest")
					end
				end
			}
		}
		[20] =
		{
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
						dball.delete_monster("corrupt monk")
						dball.delete_monster("invader monk")
						dball.delete_monster("defiler monk")
						dball.delete_monster("ancient priest")
					end
				end
			}
		}
		[21] =
		{
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
						dball.delete_monster("corrupt monk")
						dball.delete_monster("invader monk")
						dball.delete_monster("defiler monk")
						dball.delete_monster("ancient priest")
					end
				end
			}
		}
		[22] =
		{
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					if quest(QUEST_SAVE_THE_TEMPLE).status ~= QUEST_STATUS_TAKEN then
						dball.delete_monster("corrupt monk")
						dball.delete_monster("invader monk")
						dball.delete_monster("defiler monk")
						dball.delete_monster("ancient priest")
					end
				end
			}
		}
		[23] =
		{
			name = "Temple"
			level_map = "maps/catacomb.map"
			desc = "Catacombs"
			flags = {
				SAVE_LEVEL=true 
				-- SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					if dball_data.only_once_porno == 0 then
						local obj = create_object(TV_MISC, SV_PORNO_MAGAZINE)
						make_item_fully_identified(obj)
						drop_near(obj, -1, 24, 50)
					end
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_SERPENT"
	name = "The Serpent's Path" short_name = "Spt"
	desc = "The Serpent's Path"
	mindepth = 80 maxdepth = 80
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 0
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_DEEP_SPACE,
		outer = FEAT_DEEP_SPACE,
		[FEAT_DEEP_SPACE] = { 100, 100 }
	}
	flags =
	{
		NO_SURFACE_ENTRY = true
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		NO_NEW_MONSTER=true
		OBJ_THEME = getter.flags { THEME_PLAIN=100 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[80] =
		{
			name = "Serpent"
			level_map = "maps/serpent.map"
			desc = "Serpent's Path"
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					map_area(20, 50, 200)
					-- Place Kami's portal
					if dball_data.serpert_teleport == 1 then
						if cave(27, 60).feat ~= FEAT_SERPENT_TO_KAMI then
							local c_ptr = cave(27, 60)
							c_ptr.info = 3
							flag_empty(c_ptr.flags)
							cave_set_feat(27, 60, FEAT_SERPENT_TO_KAMI)
						end
					end

				end
			}
		}
	}
}

-- The Rabbit Hole. Home of Boss Rabbit
new_dungeon_type
{
	define_as = "DUNGEON_RABBIT_HOLE"
	name = "Rabbit Hole" short_name = "Hol"
	desc = "Down the Rabbit Hole"
	mindepth = 1 maxdepth = 5
	min_player_level = 1
	size_y = 1 size_x = 2
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_MUD] = { 40, 40 }
		[FEAT_GRASS] = { 40, 40 }
		[FEAT_TREES] = { 20, 20 }
	}
	walls =
	{
		inner = FEAT_MUD,
		outer = FEAT_MUD,
		[FEAT_TREES] = { 20, 40 }
		[FEAT_MUD] = { 40, 30 }
		[FEAT_GRASS] = { 40, 30 }
	}
	flags =
	{
		-- NO_STREAMERS=true 
		NO_SURFACE_ENTRY = true
		NO_SHAFT=true
		NO_DOORS=true
		OBJ_THEME = getter.flags { THEME_PLAIN=25 THEME_ACCESSORY=25 THEME_JUNK=25 THEME_GOLD=25 }
--		DUNGEON_GUARDIAN = RACE_BOSS_RABBIT
		NO_TRAPS=true
		-- SURFACE_LITE=true
		LEVEL_END_GEN = function()
			wiz_lite(true)
		end
		GENERATOR_GET_QUANTITY = function(type, k)
			-- "traps"
			-- "objects_room"
			-- "objects_dun"
			-- "rubbles"
			-- "gold"
			if type == "objects_dun" then
				return true, 8
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_RABBIT_HOLE=true
			}
		}
	}
}
-- Castle Oolong
new_dungeon_type
{			 
	define_as = "DUNGEON_OOLONG"
	name = "Castle Oolong" short_name = "Ool"
	desc = "Castle Oolong"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		NO_GENO=true
		OBJ_THEME = getter.flags {THEME_GOLD=100}
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Castle Oolong"
			level_map = "maps/oolong.map"
			desc = "Castle Oolong"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					if quest(QUEST_OOLONG).status == QUEST_STATUS_COMPLETED or quest(QUEST_OOLONG).status == QUEST_STATUS_FINISHED or dball_data.oolong_resolution > 2 then
						dball.delete_monster(RACE_WHINY_ARU)
					end
					if dball_data.oolong_married == RACE_LUNCH and dball_data.oolong_lunch_only_once == 0 then
						-- Set by level feeling
						-- dball_data.oolong_lunch_only_once = 1
						dball.delete_monster(RACE_OOLONG)
						dball.delete_monster(RACE_LUNCH)
						-- Lunch's handicraft
						for i = 1, 15 do
							local yy = rng(3, cur_hgt - 2)
							local xx = rng(3, cur_wid - 2)
							for j = -1, 1 do
								for k = -1, 1 do
									if cave(yy + j, xx + k).feat == FEAT_PERMA_WALL then
										if rng.percent(50) then cave_set_feat(yy + j, xx + k, FEAT_RUBBLE) end
									elseif cave(yy + j, xx + k).feat == FEAT_RED_CARPET then
										if rng.percent(50) then cave_set_feat(yy + j, xx + k, FEAT_FLOOR) end
									elseif cave(yy + j, xx + k).feat == FEAT_BLUE_CARPET then
										if rng.percent(50) then cave_set_feat(yy + j, xx + k, FEAT_FLOOR) end
									elseif cave(yy + j, xx + k).feat == FEAT_DOOR then
										cave_set_feat(yy + j, xx + k, FEAT_BROKEN)
									end
									if rng.percent(10) then cave_set_feat(yy + j, xx + k, FEAT_RUBBLE) end
								end
							end
						
						end
					end
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_MUSCLE_TOWER"
	name = "Muscle Tower" short_name = "MsT"
	desc = "Red Ribbon Army Headquarters"
	mindepth = 21 maxdepth = 26
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 10
	alloc_chance = 160
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
		-- TOWER=true  -- This flag doesn't behave as I would expect it to
		NO_STREAMERS=true 
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_RRA=50 THEME_PLAIN=10 THEME_BATTERY=10 THEME_BLUEPRINTS=10 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
				-- Workaround for Engine Secret Door bug
				for i = 1, cur_wid - 2 do
					for j = 1, cur_hgt - 2 do
						if cave(j, i).feat == FEAT_SECRET
						 or cave(j, i).feat == FEAT_DOOR_LOCKED_HEAD then
							cave(j, i).feat = FEAT_DOOR
						end
						-- No Rubble in Muscle Tower
						if cave(j, i).feat == FEAT_RUBBLE then
							cave(j, i).feat = FEAT_FLOOR
						end
					end
				end
				-- Place security cameras
				if dun_level ~= 26 then
					local i, j
					for h = 1, 200 do
						j = rng(2, cur_hgt - 2)
						i = rng(2, cur_wid - 2)
						if cave(j, i).feat == FEAT_PERMA_WALL and feat_adjacent(j, i, FEAT_FLOOR) then
							cave(j, i).feat = FEAT_FLOOR
							place_named_monster(j, i, "security camera", 0)
						end
					end
				end
			end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_MUSCLE_TOWER=true
			}
		}
	}
	levels =
	{
		[26] =
		{
			name = "Tower HeadQuarters"
			level_map = "maps/towerhq.map"
			desc = "Command Headquarters of Muscle Tower"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					message(color.YELLOW, "This is it. Top floor. I bet there are some nasty suprises in here.")

					-- Since this is a SAVE level, and where we left does not match where we come in:
					teleport_player_to(10, 16)
				end
			}
		}
	}
}
-- Buyon's Lair: Special trap dungeon accessed from muscle tower
new_dungeon_type
{			 
	define_as = "DUNGEON_BUYON"
	name = "Buyon's Lair" short_name = "Pit"
	desc = "Buyon's Lair"
	mindepth = 30 maxdepth = 30
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_BONES=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[30] =
		{
			name = "Dark Pit"
			level_map = "maps/buyon.map"
			desc = "Dark Pit"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				DBT_LEVEL_FEELING=function()
					dialogue.BUYON_LAIR()
				end
				LEVEL_GENERATE_POST = function()
					local yy, xx
					for i = 1, 3 do
						local obj = create_object(TV_DBT_BONES, SV_FEMUR)
						yy = rng(1, cur_wid - 2)
						xx = rng(1, cur_hgt - 2)
						if cave(yy, xx).feat == FEAT_FLOOR then
							drop_near(obj, -1, yy, xx)
						end
					end
					for i = 1, 3 do
						local obj = create_object(TV_DBT_BONES, SV_RIBCAGE)
						yy = rng(1, cur_wid - 2)
						xx = rng(1, cur_hgt - 2)
						if cave(yy, xx).feat == FEAT_FLOOR then
							drop_near(obj, -1, yy, xx)
						end
					end
					for i = 1, 3 do
						local obj = create_object(TV_DBT_BONES, SV_SKULL)
						yy = rng(1, cur_wid - 2)
						xx = rng(1, cur_hgt - 2)
						if cave(yy, xx).feat == FEAT_FLOOR then
							drop_near(obj, -1, yy, xx)
						end
					end
					for i = 1, 3 do
						local obj = create_object(TV_MISC, SV_SKELETON)
						yy = rng(1, cur_wid - 2)
						xx = rng(1, cur_hgt - 2)
						if cave(yy, xx).feat == FEAT_FLOOR then
							drop_near(obj, -1, yy, xx)
						end
					end
				end
			}
		}
	}
}

-- General Blue's Underwater Cavern
new_dungeon_type
{
	define_as = "DUNGEON_UNDERWATER_CAVERN"
	name = "Underwater Cavern" short_name = "Cvn"
	desc = "Underwater Cavern"
	mindepth = 31 maxdepth = 36
	min_player_level = 1
	size_y = 3 size_x = 3
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = { 70, 50 }
		[FEAT_DIRT] = { 30, 50 }
	}
	walls =
	{
		inner = FEAT_GROTTO,
		outer = FEAT_PERMA_WALL,
		[FEAT_GROTTO] = { 100, 100 }
	}
	flags =
	{
		-- NO_STREAMERS=true 
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_RRA=50 THEME_PLAIN=10 THEME_BATTERY=10 THEME_BLUEPRINTS=10 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
				-- Workaround for Engine Secret Door bug
				for i = 1, cur_wid - 2 do
					for j = 1, cur_hgt - 2 do
						if cave(j, i).feat == FEAT_SECRET then
							cave(j, i).feat = FEAT_DOOR
						end
					end
				end
			end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_BLUE_LAIR=true
			}
		}
	}
	levels =
	{
		[36] =
		{
			name = "Command Center"
			level_map = "maps/bluelair.map"
			desc = "Command Center"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
			}
		}
	}
}
-- Red Ribbon Army Supreme HQ, Building #1
new_dungeon_type
{
	define_as = "DUNGEON_RRA_SHQ1"
	name = "RRA Supreme HQ" short_name = "SHQ"
	desc = "RRA Supreme HQ"
	mindepth = 40 maxdepth = 45
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 10
	alloc_chance = 160
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
		-- NO_STREAMERS=true 
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_RRA=50 THEME_PLAIN=10 THEME_BATTERY=10 THEME_BLUEPRINTS=10 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
				-- Workaround for Engine Secret Door bug
				for i = 1, cur_wid - 2 do
					for j = 1, cur_hgt - 2 do
						if cave(j, i).feat == FEAT_SECRET then
							cave(j, i).feat = FEAT_DOOR
						end
					end
				end
			end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_MUSCLE_TOWER=true
			}
		}
	}
	levels =
	{
		[45] =
		{
			name = "Camera Control"
			level_map = "maps/control1.map"
			desc = "Camera Control"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
	}
}
-- Red Ribbon Army Supreme HQ, Building #2
new_dungeon_type
{
	define_as = "DUNGEON_RRA_SHQ2"
	name = "RRA Supreme HQ" short_name = "SHQ"
	desc = "RRA Supreme HQ"
	mindepth = 40 maxdepth = 45
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 10
	alloc_chance = 160
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
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_RRA=60 THEME_BATTERY=10 THEME_BLUEPRINTS=10 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
				-- Workaround for Engine Secret Door bug
				for i = 1, cur_wid - 2 do
					for j = 1, cur_hgt - 2 do
						if cave(j, i).feat == FEAT_SECRET then
							cave(j, i).feat = FEAT_DOOR
						end
					end
				end
			end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_MUSCLE_TOWER=true
			}
		}
	}
	levels =
	{
		[45] =
		{
			name = "Missile Control"
			level_map = "maps/control2.map"
			desc = "Missile Control"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
	}
}
-- Red Ribbon Army Supreme HQ, Building #3
new_dungeon_type
{
	define_as = "DUNGEON_RRA_SHQ3"
	name = "RRA Supreme HQ" short_name = "SHQ"
	desc = "RRA Supreme HQ"
	mindepth = 40 maxdepth = 45
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 10
	alloc_chance = 160
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
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_RRA=60 THEME_BATTERY=10 THEME_BLUEPRINTS=10 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
				-- Workaround for Engine Secret Door bug
				for i = 1, cur_wid - 2 do
					for j = 1, cur_hgt - 2 do
						if cave(j, i).feat == FEAT_SECRET then
							cave(j, i).feat = FEAT_DOOR
						end
					end
				end
			end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_MUSCLE_TOWER=true
			}
		}
	}
	levels =
	{
		[45] =
		{
			name = "Turret Control"
			level_map = "maps/control3.map"
			desc = "Turret Control"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
	}
}
-- Red Ribbon Army Supreme HQ, Building #4
new_dungeon_type
{
	define_as = "DUNGEON_RRA_SHQ4"
	name = "RRA Supreme HQ" short_name = "SHQ"
	desc = "RRA Supreme HQ"
	mindepth = 40 maxdepth = 46
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 10
	alloc_chance = 160
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
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_RRA=60 THEME_BATTERY=10 THEME_BLUEPRINTS=10 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
				-- Workaround for Engine Secret Door bug
				for i = 1, cur_wid - 2 do
					for j = 1, cur_hgt - 2 do
						if cave(j, i).feat == FEAT_SECRET then
							cave(j, i).feat = FEAT_DOOR
						end
					end
				end
			end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_MUSCLE_TOWER=true
			}
		}
	}
	levels =
	{
		[45] =
		{
			name = "Supreme HQ"
			level_map = "maps/shq.map"
			desc = "Supreme HQ"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
		[46] =
		{
			name = "Vault"
			level_map = "maps/vault.map"
			desc = "Vault"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_END_GEN = function()
					if dball_data.vault_gen == 0 then
						dball_data.vault_gen = 1
						for i = 10, 19 do
							for j = 23, 43 do
								local obj = new_object()
								object_prep(obj, lookup_kind(TV_GOLD, rng(10,18)))
								set_flag(obj, FLAG_GOLD_VALUE, rng(50,200))
								drop_near(obj, -1, i, j)
							end
						end
					end
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_KARIN"
	name = "Land of Karin" short_name = "Kar"
	desc = "Land of Karin"
	mindepth = 1 maxdepth = 5
	min_player_level = 1
	size_y = 4 size_x = 2
	min_monsters = 10
	alloc_chance = 160
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
		NO_STREAMERS=true 
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_PLAIN=100 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
	levels =
	{
		[1] =
		{
			name = "Land of Karin"
			level_map = "maps/k_land.map"
			desc = "The Long Climb"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
			}
		}
		[2] =
		{
			name = "Karin Tower"
			level_map = "maps/karinno.map"
			desc = "Karin's Home"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
			}
		}
		[3] =
		{
			name = "Roof"
			level_map = "maps/k_roof.map"
			desc = "Top of Karin Tower"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
			}
		}
		[4] =
		{
			name = "Lookout"
			level_map = "maps/lookout.map"
			desc = "Kami's Lookout"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_END_GEN=function()
					-- Always reset duel state upon entering level
					dialogue.POPO_DUEL_OFF()
				end
			}
		}
		[5] =
		{
			name = "Kami's House"
			level_map = "maps/kamino.map"
			desc = "Kami's House"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
			}
		}
	}
}

-- Heaven
new_dungeon_type
{			 
	define_as = "DUNGEON_HEAVEN"
	name = "Heaven" short_name = "Hvn"
	desc = "Heaven"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_PLAIN=50 THEME_JUNK=50 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Heaven"
			level_map = "maps/heaven.map"
			desc = "Heaven"
			flags =
			{
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_END_GEN = function()
--[[
					for i = 2, getn(r_info) do
						if r_info[i].flags[FLAG_UNIQUE] then
							local yy = rng(1, cur_wid - 2)
							local xx = rng(1, cur_hgt - 2)
							dball.place_monster(yy, xx, r_info[i].name
						end
					end
					-- Populate Heaven
					for i = 2, getn(r_info) do
						if r_info[i].flags[FLAG_UNIQUE] then
							if r_info[i].flags[FLAG_GOTO_HEAVEN] then
								if r_info[i].max_num == 1 then
									r_info[i].max_num = 1
									local must_place = false
									while must_place == false do
										local yy = rng(1, cur_wid - 2)
										local xx = rng(1, cur_hgt - 2)
										if dball.place_monster(yy, xx, r_info[i].name) then
											must_place = true
										end
									end
									r_info[i].max_num = 0
								end
							end
						end
					end
					for i = 1, getn(race_info_idx) do
						if race_info_idx(i,0).flags[FLAG_UNIQUE] then
							if race_info_idx(i,0).flags[FLAG_GOTO_HEAVEN] then
								if race_info_idx(i,0).max_num == 1 then
									race_info_idx(i,0).max_num = 1
									local must_place = false
									while must_place == false do
										local yy = rng(1, cur_wid - 2)
										local xx = rng(1, cur_hgt - 2)
										if dball.place_monster(yy, xx, race_info_idx(i,0).name) then
											must_place = true
										end
									end
									race_info_idx(i,0).max_num = 0
								end
							end
						end
					end
]]
				end
			}
		}
	}
}
-- Hell
new_dungeon_type
{			 
	define_as = "DUNGEON_HELL"
	name = "Hell" short_name = "Hel"
	desc = "Hell"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		NO_GENO=true
		OBJ_THEME = getter.flags { THEME_BONES=100 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Hell"
			level_map = "maps/hell.map"
			desc = "Hell"
			flags =
			{
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_END_GEN = function()
					message(color.YELLOW, "You fall for what seems like an eternity.")
					dball_data.steps_in_hell = 0
					if dball_data.hell_has_visited == 0 then
						dball_data.hell_has_visited = 1
						local obj = create_object(TV_MISC, SV_SKELETON)
						drop_near(obj, -1, 26, 58)
						local obj = create_object(TV_MISC, SV_SKELETON)
						drop_near(obj, -1, 29, 63)
					end
				end
			}
		}
	}
}

-- Castle Pilaf
new_dungeon_type
{			 
	define_as = "DUNGEON_PILAF"
	name = "Castle Pilaf" short_name = "Pil"
	desc = "Castle Pilaf"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_PLAIN=40 THEME_BLUEPRINTS=20 THEME_GOLD=20 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Castle Pilaf"
			level_map = "maps/pilaf.map"
			desc = "Castle Pilaf"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					if factions.get_friendliness(FACTION_PLAYER, FACTION_PILAF) >= 0 then
						for_each_monster(function(m_idx, monst)
							monst.ai = ai.NEVER_MOVE
						end)
					else
						-- Should be: except Pilaf
						for_each_monster(function(m_idx, monst)
							if monst.flags[FLAG_DBT_AI] then
								monst.ai = monst.flags[FLAG_DBT_AI]
							end
						end)
					end

					-- Place rubble
					if quest(QUEST_PILAF_RUBBLE).status ~= QUEST_STATUS_FINISHED then
						for i = 1, cur_wid - 2 do
							for j = 1, cur_hgt - 2 do
								if cave(j, i).feat == FEAT_FLOOR and rng(10) <= 1 then
									cave(j, i).feat = FEAT_RUBBLE
								end
							end
						end
					end
				end
			}
		}
	}
}
new_dungeon_type
{			 
	define_as = "DUNGEON_PILAF_UNDERGROUND"
	name = "Pilaf's Fortress" short_name = "Frt"
	desc = "Pilaf's Fortress"
	mindepth = 33 maxdepth = 40
	min_player_level = 1
	size_y = 3 size_x = 4
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_PLAIN=30 THEME_TECHNO=30 THEME_BLUEPRINTS=20 THEME_GOLD=20 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
--[[
		[33] =
		{
			name = "Castle Pilaf"
			level_map = "maps/pilaf.map"
			desc = "Castle Pilaf"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
]]
	}
}
-- Mr. Satan's Estate
new_dungeon_type
{			 
	define_as = "DUNGEON_SATAN_ESTATE"
	name = "Mr. Satan's Estate" short_name = "Stn"
	desc = "Mr. Satan's Estate"
	mindepth = 10 maxdepth = 15
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_FLOOR] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_SOFT_WALL] = 100
	}
	flags =
	{
		-- SURFACE_LITE=true
		NO_TRAPS=true
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		NO_GENO=true
		OBJ_THEME = getter.flags{ THEME_PLAIN=30 THEME_MARTIAL=50 THEME_GOLD=20 }
		GENERATOR_GET_QUANTITY = function(type, k)
			-- "traps"
			-- "objects_room"
			-- "objects_dun"
			-- "rubbles"
			-- "gold"
			if type == "objects_dun" then
				return true, 0
			end
		end
		LEVEL_END_GEN = function()
			-- Workaround for Engine Secret Door bug
			for i = 1, cur_wid - 2 do
				for j = 1, cur_hgt - 2 do
					if cave(j, i).feat == FEAT_SECRET then
						cave(j, i).feat = FEAT_DOOR
					end
					-- No Rubble
					if cave(j, i).feat == FEAT_RUBBLE then
						cave(j, i).feat = FEAT_FLOOR
					end
				end
			end
			-- well lit
			if dun_level < 18 then
				wiz_lite(true)
			end
		end
	}

	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_SATAN_ESTATE=true
			}
		}
	}
	levels =
	{
		[10] =
		{
			name = "Reception"
			level_map = "maps/satan_entry.map"
			desc = "Reception"
			flags =
			{
				NO_NEW_MONSTER=true
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_END_GEN = function()
--[[
					if dball_data.satan_trophies == 0 then
						dball_data.satan_trophies = 1
						local obj = create_object(TV_MISC, SV_TROPHY)
						drop_near(obj, -1, 4, 2)
						local obj = create_object(TV_MISC, SV_TROPHY)
						drop_near(obj, -1, 10, 2)
						for i = 1, 10 do
							local obj = create_object(TV_MISC, SV_TROPHY)
							drop_near(obj, -1, 2, (i * 2) + 1)
						end
						for i = 1, 10 do
							local obj = create_object(TV_MISC, SV_TROPHY)
							drop_near(obj, -1, 12, (i * 2) + 1)
						end
					end
]]
				end
			}
		}
		[15] =
		{
			name = "Training Room"
			level_map = "maps/satan.map"
			desc = "Training Room"
			flags =
			{
				NO_NEW_MONSTER=true
				SAVE_LEVEL=true 
				LEVEL_END_GEN = function()
					if dball_data.married == FLAG_MARRIED_VIDEL then
						flag_empty(cave(15, 19).flags)
						cave_set_feat(15, 19, FEAT_SHAFT_UP)
						cave(15, 19).flags[FLAG_LEVEL_CHANGER] = -4
						-- cave(15, 19).flags[FLAG_TERRAIN_NAME] = "Exit"
					end
				end
			}
		}
	}
}

-- Volcano in Fire Mountain
new_dungeon_type
{
	define_as = "DUNGEON_VOLCANO"
	name = "Volcano" short_name = "Vol"
	desc = "Volcano on Fire Mountain"
	mindepth = 46 maxdepth = 50
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_DEEP_LAVA] = { 40, 40 }
		[FEAT_SHAL_LAVA] = { 40, 40 }
		[FEAT_ASH] = { 20, 20 }
	}
	walls =
	{
		inner = FEAT_LAVA_WALL,
		outer = FEAT_LAVA_WALL,
		[FEAT_LAVA_WALL] = { 100, 100 }
		[FEAT_WALL_EXTRA] = { 0, 0 }
		[FEAT_WALL_EXTRA] = { 0, 0 }
	}
	flags =
	{
		CAVE=true LAVA_RIVER=true 
		OBJ_THEME = getter.flags { THEME_PLAIN=40 THEME_MARTIAL=40 THEME_GOLD=20 }
		LEVEL_END_GEN = function()
			dball.purge_feats(FEAT_ASH)
			for i = 1, cur_wid - 2 do
				for j = 1, cur_hgt - 2 do
					if cave(j, i).feat == FEAT_SECRET
					 or cave(j, i).feat == FEAT_DOOR
					  or cave(j, i).feat == FEAT_DOOR_LOCKED_HEAD then
						cave(j, i).feat = FEAT_ASH
					end
				end
			end
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_VOLCANO=true
			}
		}
	}
	levels =
	{
		[50] =
		{
			name = "Caldera"
			level_map = "maps/phoenix.map"
			desc = "Caldera"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}

-- Ox King's house on Mount Frypan
new_dungeon_type
{
	define_as = "DUNGEON_OXKING_HOUSE"
	name = "Mount Frypan" short_name = "Fry"
	desc = "Mount Frypan"
	mindepth = 1 maxdepth = 2
	min_player_level = 1
	size_y = 3 size_x = 3
	min_monsters = 0
	alloc_chance = 0
	flags =
		{
		FLAT=true NO_SHAFT=true NO_RECALL=true
		OBJ_THEME = getter.flags { THEME_PLAIN=50 THEME_JUNK=50 }
	}
	floors =
	{
		[FEAT_GRASS] = 100
	}
	walls =
	{
		inner = FEAT_TREES,
		outer = FEAT_TREES,
		[FEAT_TREES] = 50
		[FEAT_GRASS] = 50
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
	levels =
	{
		[1] =
		{
			name = "Mount Frypan"
			level_map = "maps/frypan.map"
			desc = "Mount Frypan"
			flags =
			{
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_END_GEN = function()
					if dball_data.oxking_drawbridge == 1 then
						for i = 18, 24 do
							cave_set_feat(i, 37, FEAT_PERMA_WALL)
							cave_set_feat(i, 38, FEAT_FLOOR)
							cave_set_feat(i, 39, FEAT_FLOOR)
							cave_set_feat(i, 40, FEAT_FLOOR)
							cave_set_feat(i, 41, FEAT_PERMA_WALL)
						end
					else
						for i = 37, 41 do
							cave_set_feat(18, i, FEAT_GRASS)
							cave_set_feat(19, i, FEAT_GRASS)
							cave_set_feat(20, i, FEAT_WALL_OF_FIRE)
							cave_set_feat(21, i, FEAT_WALL_OF_FIRE)
							cave_set_feat(22, i, FEAT_WALL_OF_FIRE)
							cave_set_feat(23, i, FEAT_WALL_OF_FIRE)
							cave_set_feat(24, i, FEAT_GRASS)
						end
					end
				end
			}
		}
		[2] =
		{
			name = "Castle"
			level_map = "maps/oxking.map"
			desc = "Ox King's House"
			flags =
			{
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_END_GEN = function()
					-- Re-place Uniques after quest resolution
					if dball_data.chichi_state == 3 then
						dball_data.chichi_state = 4
						dball.delete_monster(RACE_OXKING) -- Just in case
						dball.delete_monster(RACE_CHICHI)
						dball.place_named_monster(4, 15, "Chichi", 0)
						dball.place_named_monster(6, 13, "Ox King", 0)
					end
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_BEAR_CAVE"
	name = "Bear Cave" short_name = "Cav"
	desc = "Bear Cave"
	mindepth = 16 maxdepth = 16
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 1
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_DIRT] = { 75, 75 }
		[FEAT_GRASS] = { 25, 25 }
	}
	walls =
	{
		inner = FEAT_GROTTO,
		outer = FEAT_GROTTO,
		[FEAT_GROTTO] = { 100, 100 }
	}
	flags =
	{
		NO_SHAFT=true
		NO_DOORS=true
		OBJ_THEME = getter.flags { THEME_PLAIN=50 THEME_JUNK=50 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ANIMAL=true
			}
		}
	}
	levels =
	{
		[16] =
		{
			name = "Bear Cave"
			level_map = "maps/bearcave.map"
			desc = "Bear Cave"
			flags =
			{
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
					-- Place the bear
					-- if race_info(monst).max_num == 1 then
					local where_bear = rng(1,4)
					if where_bear == 1 then
						place_named_monster(6, 7, "Bear Thief", 255)
					elseif where_bear == 2 then
						place_named_monster(5, 15, "Bear Thief", 255)
					elseif where_bear == 3 then
						place_named_monster(9, 29, "Bear Thief", 255)
					else
						place_named_monster(16, 29, "Bear Thief", 255)
					end

					for i = 1, cur_wid - 2 do
						for j = 1, cur_hgt - 2 do
							if rng(5) <= 1 then
								place_trap(j, i, FACTION_DUNGEON, 10)
							end
						end
					end
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_NK_HOUSE"
	name = "North Kaio's House" short_name = "N-K"
	desc = "North Kaio's House"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
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
		OBJ_THEME = getter.flags { THEME_MARTIAL=100 }
		--LEFT_DUNGEON = function()
		--		end
	}
	levels =
	{
		[1] =
		{
			name = "North Kaio's House"
			level_map = "maps/kaiohouse.map"
			desc = "North Kaio's House"
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
	}
}

-- The Spaceport on Planet 79
new_dungeon_type
{			 
	define_as = "DUNGEON_SPACEPORT"
	name = "Spaceport" short_name = "Prt"
	desc = "Spaceport"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_TECHNO=100 }
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Spaceport"
			level_map = "maps/spaceport.map"
			desc = "Spaceport"
			flags = {
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
	}
}

-- Dr. Briefs' Laboratory at Capsule Corp
new_dungeon_type
{			 
	define_as = "DUNGEON_BRIEFS"
	name = "Dr. Briefs' Laboratory" short_name = "Lab"
	desc = "Dr. Briefs' Laboratory"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		NO_EASY_MOVE=true
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_TECHNO=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Dr. Briefs' Laboratory"
			level_map = "maps/briefs.map"
			desc = "Dr. Briefs' Laboratory"
			flags = {
				SAVE_LEVEL=true
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					if dball_data.has_visited_briefs == 0 then
						dball_data.has_visited_briefs = 1
						for i = 1, 10 do
							-- cur_hgt and cur_wid haven't been set yet???
							local yy, xx = rng(1, 2), rng(1, 19)
							if cave(yy, xx).feat == FEAT_FURNITURE then
								local flags = flag_new()
								flag_set(flags, FLAG_THEME_BRIEFS, 100)
								local obj = rand_obj.get_themed_obj(rng(40, 80), flags)
								if obj then
									-- Sometimes this fails to generate an item
									drop_near(obj, -1, yy, xx)
								end
							end
						end
					end

					-- To cope with SAVE_LEVEL=true
					-- Is Buruma in?
					local buruma_is_in = false
					if dball_data.buruma_state == 2 then
						buruma_is_in = true
						dball.place_monster(3, 11, "Buruma")
					end
					if buruma_is_in == false then
						dball.delete_monster(RACE_BURUMA)
					end
				end
			}
		}
	}
}

-- The Kame House, home to Master Rosshi
new_dungeon_type
{			 
	define_as = "DUNGEON_KAME_HOUSE"
	name = "Kame House" short_name = "KmH"
	desc = "Master Rosshi's Kame House"
	mindepth = 25 maxdepth = 25
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_MARTIAL=50 THEME_JUNK=50 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[25] =
		{
			name = "Kame House"
			level_map = "maps/rosshi.map"
			desc = "Kame House"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()

					-- None of this is neccessary because of SAVE_LEVEL=true, yes?
					-- Place Umigame?
					-- if player.lev < 29 or quest(QUEST_LOST_TURTLE).status == QUEST_STATUS_FINISHED then
						dball.place_monster(5, 5, "Umigame, the sea turtle")
					-- end

					-- Place Rosshi's Girl
					if dball_data.rosshi_girl == RACE_BURUMA then
						dball.place_monster(3, 5, "Buruma")
					elseif dball_data.rosshi_girl == RACE_VIDEL then
						dball.place_monster(3, 5, "Videl")
					elseif dball_data.rosshi_girl == RACE_CHICHI then
						dball.place_monster(3, 5, "Chichi")
					elseif dball_data.rosshi_girl == RACE_LUNCH then
						dball.place_monster(3, 5, "Lunch")
					end
				end
			}
		}
	}
}

new_dungeon_type
{
	define_as = "DUNGEON_MUSASHI"
	name = "a cave" short_name = "Cav"
	desc = "a cave"
	mindepth = 30 maxdepth = 30
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_MUD] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_JAPANESE=100 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
	levels =
	{
		[30] =
		{
			name = "Musashi's Cave"
			level_map = "maps/musashi.map"
			desc = "Musashi's Cave"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}

-- Tsuru Seni'nin
new_dungeon_type
{
	define_as = "DUNGEON_CRANE"
	name = "Crane Hermit" short_name = "Crn"
	desc = "Crane Hermit"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 20
	alloc_chance = 160
	fill_method = 1
	flags =
		{
		FLAT=true NO_SHAFT=true NO_RECALL=true
		OBJ_THEME = getter.flags { THEME_MARTIAL=50 THEME_JUNK=50 }
	}
	floors =
	{
		[FEAT_GRASS] = 5
		[FEAT_ICE_WALL] = 5
		[FEAT_DIRT] = 20
		[FEAT_ICE] = 20
		[FEAT_SNOW] = 50
	}
	walls =
	{
		inner = FEAT_GLACIER,
		outer = FEAT_GLACIER,
		[FEAT_GLACIER] = 50
		[FEAT_MOUNTAIN] = 50
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
	levels =
	{
		[1] =
		{
			name = "Crane Hermit's House"
			level_map = "maps/crane.map"
			desc = "Crane Hermit"
			flags =
			{
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_END_GEN = function()
				end
			}
		}
	}
}
new_dungeon_type
{
	define_as = "DUNGEON_WOLFCAVE"
	name = "a cave" short_name = "Cav"
	desc = "a cave"
	mindepth = 30 maxdepth = 30
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 10
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_MUD] = 100
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		NO_STREAMERS=true 
		FLAT=true NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_BONES=100 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
	levels =
	{
		[30] =
		{
			name = "White Wolf's Cave"
			level_map = "maps/wolfcave.map"
			desc = "White Wolf's Cave"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}
-- Home of Uranai Baba, Rosshi's sister
new_dungeon_type
{			 
	define_as = "DUNGEON_URANAI"
	name = "Uranai Baba's House" short_name = "Ura"
	desc = "Uranai Baba's House"
	mindepth = 25 maxdepth = 26
	min_player_level = 1
	size_y = 2 size_x = 3
	min_monsters = 0
	alloc_chance = 0
	fill_method = 3
	floors =
	{
		[FEAT_MUD] = { 30, 30 }
		[FEAT_SHAL_WATER] = { 30, 30 }
		[FEAT_SWAMP_POOL] = { 40, 40 }
	}
	walls =
	{
		inner = FEAT_PERMA_WALL,
		outer = FEAT_PERMA_WALL,
		[FEAT_PERMA_WALL] = 100
	}
	flags =
	{
		OBJ_THEME = getter.flags { THEME_PLAIN=50 THEME_JUNK=50 }
--		DUNGEON_GUARDIAN = RACE_TENTACLE_DEMON
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_URANAI=true
			}
		}
	}
	levels =
	{
		[25] =
		{
			name = "Uranai Baba's House"
			level_map = "maps/uranai.map"
			desc = "Uranai Baba's House"
			flags = 
			{
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
					if dball_data.uranai_state == 9 then
						dball.annoy_map()
					end
				end
			}
		}
	}
}

-- The Houses of the Seven Elders of Namek
new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_ELDER1"
	name = "Elder's Yurt" short_name = "Eld"
	desc = "Namekian Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder1.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}
new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_ELDER2"
	name = "Elder's Yurt" short_name = "Eld"
	desc = "Namekian Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder2.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_ELDER3"
	name = "Elder's Yurt" short_name = "Eld"
	desc = "Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder3.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_ELDER4"
	name = "Elder's Yurt" short_name = "Eld"
	desc = "Namekian Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder4.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_ELDER5"
	name = "Elder's Yurt" short_name = "Eld"
	desc = "Namekian Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder5.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_ELDER6"
	name = "Elder's Yurt" short_name = "Eld"
	desc = "Namekian Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder6.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}new_dungeon_type
{			 
	define_as = "DUNGEON_NAMEK_GREAT_ELDER"
	name = "Great Elder's Yurt" short_name = "Eld"
	desc = "Great Elder's Yurt"
	mindepth = 1 maxdepth = 1
	min_player_level = 1
	size_y = 1 size_x = 1
	min_monsters = 0
	alloc_chance = 160
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
		OBJ_THEME = getter.flags { THEME_NAMEK=100 }
		LEFT_DUNGEON = function()
		end
	}
	rules =
	{
		[{100, "all"}] = {}
	}
	levels =
	{
		[1] =
		{
			name = "Elder's Yurt"
			level_map = "maps/nam_elder7.map"
			desc = "Elder's Yurt"
			flags = {
				SAVE_LEVEL=true
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
				NO_NEW_MONSTER=true
				LEVEL_GENERATE_POST = function()
				end
			}
		}
	}
}


-----------------------
-- No More Hikui bird cave as of V086. The Hikui bird is now found in the volcano
-----------------------

--[[
new_dungeon_type
{
	define_as = "DUNGEON_HIKUI_BIRD_CAVE"
	name = "Hikui Bird Cave" short_name = "Hik"
	desc = "Bird Cave"
	mindepth = 18 maxdepth = 18
	min_player_level = 1
	size_y = 2 size_x = 2
	min_monsters = 1
	alloc_chance = 160
	fill_method = 3
	floors =
	{
		[FEAT_DIRT] = { 50, 50 }
		[FEAT_GRASS] = { 50, 50 }
	}
	walls =
	{
		inner = FEAT_DEAD_TREE,
		outer = FEAT_TREES,
		[FEAT_TREES] = { 25, 70 }
		[FEAT_MUD] = { 50, 25 }
		[FEAT_DEAD_TREE] = { 25, 5 }
	}
	flags =
	{
		-- NO_STREAMERS=true 
		NO_SHAFT=true
		OBJ_THEME = getter.flags { THEME_TREASURE=100 }
	}
	rules =
	{
		[{100, "or"}] =
		{
			flags = {
				ALLOW_IN_EVERYWHERE=true
			}
		}
	}
	levels =
	{
		[18] =
		{
			name = "Hikui Bird Cave"
			level_map = "maps/birdcave.map"
			desc = "Hikui Bird Cave"
			flags =
			{
				SAVE_LEVEL=true 
				SAVED_LEVEL_DECAY_OBJECTS={50,200}
			}
		}
	}
}
]]

