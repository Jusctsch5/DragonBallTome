-- Default bodies
constant("default_body", {})

default_body.none = { INVEN=23 WIELD=0 BODY=0 OUTER=0 HANDS=0 TOOL=0 RING=0 HEAD=0 WRIST=0 FEET=0 }
default_body.humanoid = { INVEN=23 WIELD=1 BODY=1 OUTER=1 HANDS=1 ARMS=1 TOOL=1 RING=2 WRIST=1 WRIST=1 FEET=1 }
default_body.blob = { INVEN=40 WIELD=0 BODY=2 OUTER=2 HANDS=0 TOOL=0 ARMS=1 RING=6 HEAD=0 WRIST=3 FEET=0 }
default_body.worms = { INVEN=35 WIELD=1 BODY=1 OUTER=1 HANDS=0 TOOL=1 ARMS=1 RING=3 HEAD=0 WRIST=2 FEET=0 }
default_body.insect = { INVEN=15 WIELD=0 BODY=1 OUTER=1 HANDS=0 TOOL=0 RING=2 HEAD=1 WRIST=1 FEET=0 }
default_body.bird = { INVEN=20 WIELD=0 BODY=1 OUTER=1 HANDS=1 TOOL=1 RING=0 HEAD=1 WRIST=1 FEET=0 }
default_body.quadruped = { INVEN=23 WIELD=0 BODY=1 OUTER=1 HANDS=0 ARMS=2 TOOL=0 RING=2 HEAD=1 WRIST=1 FEET=0 }
default_body.xorn = { INVEN=23 WIELD=0 BODY=1 OUTER=1 HANDS=0 TOOL=0 RING=2 HEAD=1 WRIST=1 WRIST=0 }
default_body.dragon = { INVEN=23 WIELD=0 BODY=1 OUTER=1 HANDS=0 TOOL=0 ARMS=1 RING=6 HEAD=1 WRIST=1 FEET=0 }
default_body.spider = { INVEN=23 WIELD=0 BODY=1 OUTER=1 HANDS=0 TOOL=0 ARMS=4 RING=2 HEAD=1 WRIST=1 FEET=0 }

-- Need a Player entry to be first
new_monster_race
{
	name = "player"
	race = '@'
	sval = 0
	color = color.WHITE
	speed = 0 life = { 1, 1 } ac = 0
	aaf = 0 sleep = 0
	level = 0 exp = 0
	rarity = 0
	weight = 100
	-- Shouldn't this match the one in descriptors?
	body = { INVEN=23 WIELD=1 BODY=1 OUTER=1 HANDS=1 ARMS=1 TOOL=1 RING=2 HEAD=1 WRIST=1 FEET=1 }
	flags = { OPEN_DOOR=true  }
}

tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/androids.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/animals.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/celestial.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/demons.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/dinosaurs.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/humans.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/monks.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/namek.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/ninja.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/OOT.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/planet79.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/rabbits.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/redarmy.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/shenron.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/snowy.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/space.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/special.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/tourny.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/trainers.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/uniques.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/volcano.lua")
tome_dofile_anywhere(TENGINE_DIR_DATA, "monsters/warehouse.lua")
