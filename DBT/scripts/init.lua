-- Dragonball T: Initialization

-- Subsystems
load_subsystem("dbt_hp")
-- load_subsystem("dbt_chi")		-- DBT Modified From Default Subsystem: workaround for fractional drain limitation
load_subsystem("player_sanity")
load_subsystem("dbthunger")		-- DBT Modified From Default Subsystem: extensive, but mostly cosmetic changes
load_subsystem("quaff")
load_subsystem("read")
load_subsystem("movement_mode")
load_subsystem("technomancy")		-- DBT Original Subsystem
load_subsystem("dialogue")		-- DBT Original Subsystem
load_subsystem("corruption")
load_subsystem("firearms")		-- DBT Original Subsystem
load_subsystem("dbt_id")		-- DBT Original Subsystem
load_subsystem("dbtinventory")	-- DBT Modified Subsystem: Minor tweaks to default system
-- load_subsystem("dbt_tunnel.lua")		-- Tunneling
load_subsystem("throwing")		-- DBT Original Subsystem
load_subsystem("party")			-- DBT: Party subsystem

-- load_subsystem("search")		-- Engine subsystem


-- Standard Scripts
tome_dofile("intro.lua")		-- Intro music
tome_dofile("colors.lua")		-- Colors
tome_dofile("slots.lua")		-- Wield Slots
tome_dofile("factions.lua")		-- Monster Factions
tome_dofile("dam_type.lua")		-- Damage Types
tome_dofile("flags.lua")		-- Flags
tome_dofile("object.lua")		-- Object Scripts
tome_dofile("object_theme.lua")	-- Object Themes
tome_dofile("player.lua")		-- Player helpers
tome_dofile("memory.lua")		-- Monster Memory
tome_dofile("combat.lua")		-- Combat System
tome_dofile("help.lua")			-- Ingame help
tome_dofile("features.lua")		-- Features
tome_dofile("ai/init.lua")		-- Monster AI
tome_dofile("dungeon.lua")		-- Dungeon stuff
tome_dofile("tunnel.lua")		-- Tunneling

-- New with alpha12, let's give it a try
tome_dofile("target.lua")		-- Targeting texts

-----------------------------------------------------------------
-- Load the various non raw-ified lua files in data/
-----------------------------------------------------------------
-- tome_dofile_anywhere(TENGINE_DIR_DATA, "player/corruptions.lua", false)	-- Player 'corruptions'
tome_dofile_anywhere(TENGINE_DIR_DATA, "magic/spells.lua", false)		-- Magic systems
tome_dofile_anywhere(TENGINE_DIR_DATA, "dungeon/traps.lua",    false)	-- Traps

tome_dofile("quests/init.lua")	-- Quests

tome_dofile("dbtdata.lua")		-- Data initializations and definitions
tome_dofile("dbtstuff.lua")		-- Functions and hooks all in one spot

tome_dofile("display.lua")		-- Knowledge Menu MUST be loaded after dbtstuff and dbt_calc

tome_dofile("3dfx.lua")			-- 3d effects
tome_dofile("tools.lua")		-- Tools
tome_dofile("dialogue.lua")		-- Dialogues
-- tome_dofile("charsheet.lua")		-- Alternate Character Sheet (not currently used)
tome_dofile("wish.lua")			-- Shenron's Wishing Script :)

tome_dofile_anywhere(TENGINE_DIR_DATA, "magic/chi_constant.lua", false)	-- Chi: Constant Effects
-- tome_dofile_anywhere(TENGINE_DIR_DATA, "magic/chi_instant", false)	-- Chi: Instant Effects

tome_dofile("options.lua")		-- Options (must occur below dbtdata.lua)
tome_dofile("enroll.lua")		-- DBT Enrollment/Skill system
tome_dofile("fusion.lua")		-- Chi Fusion



