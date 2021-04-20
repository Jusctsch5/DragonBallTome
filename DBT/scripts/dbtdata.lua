-- General Declarations, descriptions, and 'stuff'
-- for all the myriad data used by Dragonball T

declare_globals {
	"dball_data",
	"tourny_uniques",
	"earth_dragonballs",
	"namek_dragonballs",
	"ressurections",
	"cellphone",
	"enrollments",		-- Number of enrollments
	"trainer",			-- How 'happy' is each trainer
	"c_schools",		-- How many 'schools' have been closed?
	"skillcaps",		-- Skill cap bonuses
	"chi_masters",		-- How much has each master trained each skill in the alternate skill system?
	"reincarnation",		-- Data that is DELIBERATELY PRESERVED between characters
	"jokes",			-- Joke tracking for the North Kaio
	"namek_pollinate",	-- Tracking for Namek Pollination quest
	"namek_seeds",		-- Tracking for Namek seed gathering quest
	"buruma_obj",
}

dball_data = {}
tourny_uniques = {}
earth_dragonballs = {}
namek_dragonballs = {}
ressurections = {}
cellphone = {}
enrollments = {}
trainer = {}
c_schools = {}
skillcaps = {}
chi_masters = {}
reincarnation = {}
jokes = {}
namek_pollinate = {}
namek_seeds = {}
buruma_obj = {}

add_loadsave("dball_data", {})
add_loadsave("tourny_uniques", {})
add_loadsave("earth_dragonballs", {})
add_loadsave("namek_dragonballs", {})
add_loadsave("ressurections", {})
add_loadsave("cellphone", {})
add_loadsave("enrollments", {})
add_loadsave("trainer", {})
add_loadsave("c_schools", {})
add_loadsave("skillcaps", {})
add_loadsave("chi_masters", {})
add_loadsave("reincarnation", {})
add_loadsave("jokes", {})
add_loadsave("namek_pollinate", {})
add_loadsave("namek_seeds", {})
add_loadsave("buruma_obj", {})
