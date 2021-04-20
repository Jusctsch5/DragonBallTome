-------------------------- Basic shops --------------------------
new_store
{
	define_as = "store.STORE_MEGAMALL"
	name = "Mega Mall!"
	display = '1' color = color.LIGHT_UMBER
	max_obj = 13
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_DEFAULT
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		{ chance=50 item="& power bar~" },
		{ chance=50 item="& safety flashlight~" },
		{ chance=100 item="& flashlight~ #" },
		{ chance=50 item="& maglight~ #" },
		{ chance=50 item="& watch~" },
		{ chance=50 item="rice cooker" },
		{ chance=50 item="sewing kit" },
		{ chance=50 item="& bag~ of white rice" },
		{ chance=50 item="megaphone" },
		{ chance=50 item="fire extinguisher" },
		{ chance=50 item="chainsaw" },
		{ chance=50 item="nailgun" },
		{ chance=50 item="& box~ of nails" },
		{ chance=100 item="road flare" },
		{ chance=50 item="& slice~ of pizza" },
		{ chance=100 item="& piece~ of chocolate" },
		{ chance=50 item="& bottle~ of water" },
		{ chance=50 item="& can~ of Dr. Pepper" },
		{ chance=50 item="& pair of sunglasses" },
		{ chance=50 item="& pair of mirrored shades" },
		{ chance=50 item="& bathrobe~" },
		{ chance=50 item="& set~ of streetclothes" },
		{ chance=50 item="& hockey mask~" },
		{ chance=50 item="& knife~" },
		{ chance=50 item="& pair~ of golfing gloves" },
		{ chance=50 item="& pair~ of leather welding gloves" },
		{ chance=50 item="& pair~ of high heels" },
		{ chance=50 item="& pair~ of steel toed shoes" },
		{ chance=50 item="& pair~ of tennis shoes" },
		{ chance=50 item="& pair~ of inline skates" },
		{ chance=50 item="& set~ of earmuffs" },
		{ chance=50 item="pair of earplugs" },
		{ chance=50 item="& pair~ of ski gloves" },
		{ chance=100 item="& shovel~" },
		{ chance=50 item="first aid kit" },
		{ chance=100 item="& piece~ of catnip" },
	}
}


new_store
{
	define_as = "store.STORE_CLOTHING"
	name = "Clothing Store"
	display = '2' color = color.SLATE
	max_obj = 13
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_DEFAULT
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		{ chance=100 item="& pair of sunglasses" },
		{ chance=100 item="& pair of mirrored shades" },
		{ chance=100 item="& bathrobe~" },
		{ chance=100 item="& bathrobe~" },
		{ chance=100 item="& set~ of streetclothes" },
		{ chance=100 item="& set~ of streetclothes" },
		{ chance=100 item="& pair~ of high heels" },
		{ chance=100 item="& pair~ of tennis shoes" },
		{ chance=75 item="& leather jacket~" },
		{ chance=50 item="& qipao" },
		{ chance=50 item="& tuxedo" },
		{ chance=50 item="& pair~ crocodile skin boots" },
		{ chance=50 item="& leather trenchcoat~" },
		{ chance=50 item="& Australian duster~" },
	}
}

new_store
{
	define_as = "store.STORE_MARTIAL_ARTS_SUPPLIES"
	name = "Martial Arts Supply Store"
	display = '3' color = color.WHITE
	max_obj = 24
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_DEFAULT
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		-- GAHHH!!!! Why do 100 chance items not always appear?
		{ chance=100 item="& kubotan" },
		{ chance=100 item="& escrima stick~" },
		{ chance=100 item="& knife~" },
		{ chance=50 item="& nunchaku" },
		{ chance=100 item="& mini butterfly knife~" },
		{ chance=100 item="& sai" },
		{ chance=100 item="& tonfa" },
		{ chance=100 item="& kama" },

		{ chance=80 item="& spear~" },
		{ chance=100 item="& bo staff~" },
		{ chance=100 item="& waxwood staff~" },
		{ chance=70 item="& three sectional staff~" },
		{ chance=20 item="& pudao" },
		{ chance=50 item="& rounded hammer~" },

		{ chance=50 item="& whipchain~" },
		{ chance=20 item="& rope dart~" },

		{ chance=80 item="& butterfly knife~" },
		{ chance=80 item="& straightsword~" },
		{ chance=80 item="& sabre~" },
		{ chance=20 item="& wakazashi" },
		{ chance=100 item="& shinai" },
		{ chance=100 item="& bokken" },
		{ chance=100 item="& tai chi sword~" },

		{ chance=100 item="& headband~" },
		{ chance=100 item="& blindfold~" },

		{ chance=100 item="mouthguard" },
		{ chance=50 item="body oil" },

		{ chance=100 item="& pair~ of light boxing gloves" },
		{ chance=100 item="& pair~ of heavy boxing gloves" },

		{ chance=100 item="& pair~ of wrist braces" },

		{ chance=100 item="& lightweight gi" },
		{ chance=75 item="& mediumweight gi" },
		{ chance=50 item="& heavyweight gi" },
		{ chance=100 item="& tai chi uniform~" },
		{ chance=100 item="& dobak" },
		{ chance=50 item="& sanjobang" },
		{ chance=50 item="& set~ of sparring gear~" },
		{ chance=50 item="& mawashi" },


	}
}

new_store
{
	define_as = "store.STORE_GUNSTORE"
	name = "Gun Store"
	display = '+' color = color.LIGHT_GREEN
	max_obj = 10
	actions = { store.ACTION_BUY,	store.ACTION_SELL,
		    store.ACTION_EXAMINE,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_BILLY
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		{ chance=100 item="Firearms Guide" },
		{ chance=100 item="Firearms Guide" },
		{ chance=100 item="& pistol~" },
		{ chance=100 item="& pistol~" },
		{ chance=100 item="& rifle~" },
		{ chance=100 item="& rifle~" },
		{ chance=100 item="& clip~" },
		{ chance=100 item="& clip~" },
		{ chance=100 item="& clip~" },
		{ chance=100 item="& clip~" },
		{ chance=100 item="& shotgun~" },
		{ chance=100 item="& shotgun~" },
		{ chance=100 item="& lead slug~" },
		{ chance=100 item="& lead slug~" },
		{ chance=100 item="& scattershot~" },
		{ chance=100 item="& scattershot~" },
		{ chance=100 item="scope" },
		{ chance=100 item="scope" },
		{ chance=100 item="scope" },
	}
	buy =
	{
		TV_GUN,
		TV_CLIP,
		TV_SHOTGUN,
		TV_SHOTGUN_ROUND,
	},
}

new_store
{
	define_as = "store.STORE_RVAC"
	name = "R-Vac"
	display = '5' color = color.BLUE
	max_obj = 23
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_SELL,	store.ACTION_BUY,
		    store.ACTION_NONE,	store.ACTION_EXAMINE }
	owners = store.OWNER_DEFAULT
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		{ chance=100 item="& set~ of basic blueprints" },
		{ chance=100 item="& set~ of basic blueprints" },
		{ chance=50 item="& set~ of medium blueprints" },

		{ chance=50 item="& safety flashlight~" },
		{ chance=100 item="& flashlight~ #" },
		{ chance=50 item="& maglight~ #" },
		{ chance=50 item="megaphone" },
		{ chance=50 item="fire extinguisher" },
		{ chance=100 item="road flare" },
		{ chance=100 item="& shovel~" },

		{ chance=50 item="& canister~ of flame retardant" },
		{ chance=50 item="& propane tank~" },
		{ chance=100 item="& battery~" },
		{ chance=100 item="& battery~" },
		{ chance=80 item="& resistor~" },
		{ chance=80 item="& capacitor~" },
		{ chance=80 item="& circuit board~" },
		{ chance=80 item="& spool~ of wire" },
		{ chance=80 item="& spool~ of solder" },
		{ chance=80 item="& eprom~" },
		{ chance=50 item="mechanical toolkit" },
		{ chance=50 item="electrical toolkit" },
		{ chance=50 item="chemistry kit" },
		{ chance=50 item="sewing kit" },
	}
	buy =
	{
		TV_ELECTRONICS,
	},
}

new_store
{
	define_as = "store.STORE_ELECTRONICS_BAD"
	name = "Electronics Store"
	display = '6' color = color.RED
	max_obj = 24
	actions = { store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_GEORGE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}

new_store
{
	define_as = "store.STORE_ELECTRONICS_GOOD"
	name = "Electronics Store"
	display = '6' color = color.RED
	max_obj = 24
	actions = { store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_GEORGE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
			{ chance=100 item="& battery~" },
			{ chance=100 item="& battery~" },
			{ chance=50 item="compass" },
			{ chance=50 item="global positioning system" },
--			{ chance=50 item="cell phone" },
			{ chance=50 item="& watch~" },
			{ chance=100 item="television remote" },
			{ chance=100 item="television remote" },
			{ chance=50 item="metal detector" },
			{ chance=50 item="laser pointer" },
			{ chance=50 item="nailgun" },
			{ chance=20 item="SCUBA gear" },
			{ chance=50 item="laptop" },
			{ chance=50 item="& safety flashlight~" },
			{ chance=100 item="& flashlight~ #" },
			{ chance=50 item="& maglight~ #" },
			{ chance=50 item="megaphone" },
			{ chance=50 item="fire extinguisher" },
			{ chance=100 item="road flare" },
			{ chance=100 item="& shovel~" },
			{ chance=100 item="blowtorch" },

			{ chance=50 item="& canister~ of flame retardant" },
			{ chance=50 item="& propane tank~" },
	}
}

new_store
{
	define_as = "store.STORE_PAWNSHOP"
	name = "Pawn Shop"
	display = '7' color = color.LIGHT_DARK
	max_obj = 24
	actions = { store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_SELL,	store.ACTION_TALK,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_LAZARUS
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 5000
	}
	item_kinds =
	{
	}
	buy = function(obj) return true end
}

new_store
{
	define_as = "store.SUSHI_BAR"
	name = "Sushi Bar"
	display = '+' color = color.YELLOW
	max_obj        = 10
	actions = { store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TALK,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_AKIRA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& piece~ of unagi" },
                { chance=100 item="& piece~ of unagi" },
                { chance=100 item="& piece~ of anago" },
                { chance=100 item="& piece~ of anago" },
                { chance=100 item="& piece~ of saba" },
                { chance=100 item="& piece~ of saba" },
                { chance=100 item="& piece~ of takko" },
                { chance=100 item="& piece~ of takko" },
                { chance=100 item="& piece~ of fugu" },
	}
}

new_store
{
	define_as = "store.KARATE"
	name = "Karate Dojo"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_NAKAMURA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
			{ chance=100 item="& lightweight gi" },
			{ chance=100 item="& mediumweight gi" },
			{ chance=100 item="& heavyweight gi" },
			{ chance=100 item="& shinai" },
			{ chance=80 item="& bo staff~" },
			{ chance=50 item="& nunchaku" },
			{ chance=60 item="& sai" },
			{ chance=60 item="& tonfa" },
			{ chance=60 item="& bokken" },
			{ chance=50 item="& kama" },
	}
}


new_store
{
	define_as = "store.KUNGFU"
	name = "Kung-Fu Studio"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_FONG
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& tai chi uniform~" },
                { chance=80 item="& spear~" },
                { chance=80 item="& waxwood staff~" },
                { chance=80 item="& sabre~" },
                { chance=80 item="& straightsword~" },
                { chance=80 item="& three sectional staff~" },
                { chance=50 item="& whipchain~" },
                { chance=50 item="& rope dart~" },
                { chance=80 item="& butterfly knife~" },
                { chance=80 item="& hook sword~" },
                { chance=50 item="& pudao" },
                { chance=50 item="& rounded hammer~" },
	}
}

new_store
{
	define_as = "store.FENCING"
	name = "Fencing School"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_JACQUE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& epee~" },
                { chance=100 item="& rapier~" },
                { chance=100 item="& epee~" },
                { chance=100 item="& fencing mask~" },
                { chance=100 item="& fencing armor~" },


	}
}

new_store
{
	define_as = "store.TAEKWONDO"
	name = "Tae-Kwon Do Studio"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_LEE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& dobak" },
                { chance=100 item="& dobak" },
                { chance=100 item="& sanjobang" },
                { chance=100 item="& sanjobang" },
                { chance=100 item="& bo staff~" },
		    { chance=100 item="& set~ of sparring gear~" },
	}
}

new_store
{
	define_as = "store.NINJUTSU"
	name = "Ninja Training Camp"
	display = '+' color = color.GREEN
	max_obj        = 12
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_HATSUMI
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& ninja hood~" },
                { chance=100 item="& ninja hood~" },
                { chance=100 item="& pair~ of ninja tabi" },
                { chance=100 item="& pair~ of ninja tabi" },
                { chance=100 item="& ninja uniform~" },
                { chance=100 item="& ninja uniform~" },
                { chance=100 item="& pair~ of ninja bracers" },
                { chance=100 item="& pair~ of ninja bracers" },
                { chance=100 item="& ninja-to" },
                { chance=60 item="& ninja claw~" },
                { chance=60 item="& pair~ of ninja climbing claws" },
                { chance=60 item="& pair~ of ninja climbing tabi" },
                { chance=100 item="& blindfold~" },
                { chance=100 item="& blindfold~" },
                { chance=100 item="vial of poison" },
                { chance=100 item="vial of poison" },
	}		
}

new_store
{
	define_as = "store.KICKBOXING"
	name = "Kickboxing Gym"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_BOB
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& pair~ of boxing shorts" },
                { chance=100 item="& pair~ of boxing shorts" },
                { chance=100 item="& pair~ of light boxing gloves" },
                { chance=100 item="& pair~ of light boxing gloves" },
                { chance=100 item="& pair~ of heavy boxing gloves" },
                { chance=100 item="& pair~ of heavy boxing gloves" },
	}
}

new_store
{
	define_as = "store.BALLET"
	name = "Ballet School"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_SAKURA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& pair~ of ballet slippers" },
                { chance=100 item="& pair~ of ballet slippers" },
                { chance=100 item="& pair~ of ballet slippers" },
                { chance=100 item="& tutu~" },
                { chance=100 item="& tutu~" },
                { chance=100 item="& tutu~" },
                { chance=100 item="& pair~ of toe shoes" },
                { chance=100 item="& pair~ of toe shoes" },
                { chance=100 item="& pair~ of toe shoes" },
	}
}

new_store
{
	define_as = "store.SUMO"
	name = "Sumo Wrestling School"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_HONDA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		{ chance=100 item="& mawashi" },
		{ chance=100 item="& mawashi" },
		{ chance=100 item="& mawashi" },
		{ chance=100 item="body oil" },
		{ chance=100 item="body oil" },
	}
}
new_store
{
	define_as = "store.JUDO"
	name = "Judo School"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 10
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_CHALLENGE }
	owners = store.OWNER_YAWARA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& lightweight gi" },
                { chance=100 item="& mediumweight gi" },
	}
}
new_store
{
	define_as = "store.SHOOTING_RANGE"
	name = "Shooting Range"
	display = '4' color = color.LIGHT_GREEN
	max_obj        = 13
	actions = { store.ACTION_ENROLL,	store.ACTION_EXAMINE,
		    store.ACTION_BUY,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_CHALLENGE }
        owners = store.OWNER_CHARLETON
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="Firearms Guide" },
                { chance=100 item="Firearms Guide" },
	}
}

new_store
{
	define_as = "store.GYM"
	name = "24/7 Fitness"
	display = '9' color = color.ORANGE
	max_obj        = 10
	actions = { store.ACTION_BUY,	store.ACTION_APPLY,
		    store.ACTION_EXAMINE,	store.ACTION_WORKOUT,
		    store.ACTION_TALK,	store.ACTION_NONE }
	owners = store.OWNER_ARNOLD
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& power bar~" },
                { chance=100 item="& power bar~" },
                { chance=100 item="& power bar~" },
                { chance=100 item="& bottle~ of water" },
                { chance=100 item="& bottle~ of water" },
                { chance=100 item="& bottle~ of water" },
--                { chance=50 item="& pulse monitor~" },
	}
}

new_store
{
	define_as = "store.LIBRARY"
	name = "Library"
	display = '9' color = color.ORANGE
	max_obj        = 12
	actions = { store.ACTION_BUY,	store.ACTION_APPLY,
		    store.ACTION_STUDY,	store.ACTION_EXAMINE,
		    store.ACTION_TALK,	store.ACTION_NONE }  -- RESEARCH_MON?
	owners = store.OWNER_MISSELIOTT
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=50 item="& comic book~" },
                { chance=50 item="Guide to Dragonball T" },
                { chance=50 item="Pilot's Club Membership" },
                { chance=50 item="Barehanded or Weapons?" },
                { chance=50 item="Combat Math" },
                { chance=50 item="All About Acupuncture" },
                { chance=50 item="The World Tournament" },
                { chance=50 item="Weapons Guide" },
                { chance=50 item="Dragonball T V024 Release Notes" },
                { chance=50 item="Firearms Guide" },
                { chance=50 item="Dragonball T V029 Release Notes" },
                { chance=50 item="Dragonball T Translation Commentary" },
	}
}

new_store
{
        define_as = "store.EAU_DE_FRANCE"
        name = "Eau De France"
	display = '+' color = color.TAN
	max_obj        = 5
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_PIERRE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& bottle~ of perrier" },
                { chance=100 item="& bottle~ of wine" },
	}
}

new_store
{
        define_as = "store.PIZZA_KITCHEN"
        name = "Pizza Kitchen Franchise"
	display = '+' color = color.TAN
	max_obj        = 13
	actions = { store.ACTION_EAT,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_RUSTY
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& slice~ of pizza" },
                { chance=100 item="& slice~ of pizza" },
                { chance=100 item="& slice~ of pizza" },
                { chance=50 item="& can~ of Dr. Pepper" },
                { chance=50 item="& can~ of Mountain Dew" },
	}
}
--[[
new_store
{
        define_as = "store.CANDY"
        name = "Candy Store"
	display = '+' color = color.PINK
	max_obj        = 13
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_ADRIENNE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
		{ chance=100 item="& piece~ of chocolate" },
		{ chance=100 item="& piece~ of chocolate" },
		{ chance=100 item="& piece~ of licorice" },
		{ chance=100 item="& piece~ of licorice" },
		{ chance=100 item="& gummy bear~" },
		{ chance=100 item="& gummy bear~" },
		{ chance=100 item="& sour fish~" },
		{ chance=100 item="& sour fish~" },
	}
}
]]
new_store
{
	define_as = "store.WAREHOUSE"
	name = "Warehouse"
	display = '+' color = color.WHITE
	max_obj        = 13
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_EMPTY
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}

new_store
{
	define_as = "store.CAPSULE_CORP"
	name = "Capsule Corporation Corporate Headquarters"
	display = '+' color = color.WHITE
	max_obj        = 13
	actions = { store.ACTION_ABOUT,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_RECEPTIONIST
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="& capsule~" },
                { chance=100 item="& capsule~" },
                { chance=100 item="& capsule~" },
                { chance=100 item="& motorcycle~" },
                { chance=100 item="& motorcycle~" },
                { chance=100 item="& motorcycle helmet~" },
                { chance=100 item="& motorcycle helmet~" },
                { chance=100 item="& motorcycle helmet~" },
                { chance=100 item="& flight jacket~" },
                { chance=100 item="& flight jacket~" },
                { chance=100 item="& capsule flyer~" },
                { chance=100 item="& capsule flyer~" },
                { chance=100 item="& capsule boat~" },
                { chance=100 item="& capsule boat~" },
	}
}



new_store
{
	define_as = "store.BRIEFS_LAB"
	name = "Laboratory"
	display = '+' color = color.WHITE
	max_obj        = 13
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_DR_BRIEFS
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}

new_store
{
	define_as = "store.MILITARY_SURPLUS"
	name = "Military Surplus"
	display = '+' color = color.SLATE
	max_obj        = 13
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_BUY,	store.ACTION_EXAMINE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_DOUGLAS
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=50 item="& pistol~" },
                { chance=50 item="& rifle~" },
                { chance=50 item="& camoflague outfit~" },
                { chance=50 item="& infantry helmet~" },
                { chance=50 item="& gas mask~" },
                { chance=50 item="nightvision goggles" },
                { chance=50 item="infrared goggles" },
                { chance=50 item="& flak vest~" },
                { chance=50 item="& flak jacket~" },
                { chance=10 item="& riot shield~" },
	}
}

new_store
{
	define_as = "store.ACUPUNCTURE"
	name = "Acupuncture Clinic"
	display = '+' color = color.STEEL_BLUE
	max_obj        = 3
	actions = { store.ACTION_ENROLL,	store.ACTION_BUY,
		    store.ACTION_TALK,	store.ACTION_EXAMINE,
		    store.ACTION_HEAL,	store.ACTION_CHALLENGE }
	owners = store.OWNER_TOFU
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="acupuncture kit" },
                { chance=100 item="acupuncture kit" },
                { chance=100 item="blood coagulant" },
                { chance=100 item="blood coagulant" },
                { chance=100 item="first aid kit" },
                { chance=100 item="first aid kit" },
                { chance=100 item="zheng gu shui" },
	}
}

-- The Aru Village Stores will probably go away and be
-- replaced by Aru Villagers, just as soon as the
-- fixed-monster-duplication bug has been resolved
-- I kind of need villagers wandering anyway, for the post
-- Quest, and for Rosshi Quest #2
new_store
{
	define_as = "store.ARU1"
	name = "A small house"
	display = '+' color = color.RED
	max_obj        = 3
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_IMELDA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}
new_store
{
	define_as = "store.ARU2"
	name = "A small house"
	display = '+' color = color.RED
	max_obj        = 3
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_MARCOS
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}
new_store
{
	define_as = "store.ARU3"
	name = "A small house"
	display = '+' color = color.RED
	max_obj        = 3
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_JOE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}
new_store
{
	define_as = "store.ARU4"
	name = "A small house"
	display = '+' color = color.RED
	max_obj        = 3
	actions = { store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_REINFORCE,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_JOESEPHINE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 1500
	}
	item_kinds =
	{
                { chance=100 item="scissors" },
                { chance=100 item="scissors" },
                { chance=100 item="sewing kit" },
                { chance=100 item="sewing kit" },
                { chance=100 item="& strips~ of cloth" },
                { chance=100 item="& strips~ of cloth" },
                { chance=100 item="& strips~ of cloth" },
	}
}
new_store
{
	define_as = "store.ARU5"
	name = "An empty house"
	display = '+' color = color.RED
	max_obj        = 3
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_EMPTY
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}

new_store
{
	define_as = "store.TOXIC_PLANT"
	name = "Manufacturing Plant"
	display = '+' color = color.RED
	max_obj        = 3
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_TALK,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_TOXIC_RECEPTIONIST
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	item_kinds =
	{
	}
}

new_store
{
	define_as = "store.SWORDSMITH"
	name = "Swordsmith"
	display = '+' color = color.GREEN
	max_obj        = 3
	actions = { store.ACTION_BUY,	store.ACTION_SHARPEN,
		    store.ACTION_EXAMINE,	store.ACTION_BALANCE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_NOBURO
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 5000
	}
	item_kinds =
	{
		{ chance=100 item="& katana" },
	}
}

new_store
{
	define_as = "store.MUSEUM"
	name = "The Martial Arts Museum"
	display = '+' color = color.LIGHT_BLUE
	max_obj = 100
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_NONE }
	owners = store.OWNER_DEFAULT
	flags =
	{
		MUSEUM=1
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}

new_store
{
	define_as = "store.ROBBINS"
	name = "The Robbins Foundation"
	display = '+' color = color.LIGHT_BLUE
	max_obj = 100
	actions = { store.ACTION_ENROLL,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_TONY
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	flags =
	{
	}
}
new_store
{
	define_as = "store.YMCA"
	name = "The YMCA"
	display = '+' color = color.LIGHT_WHITE
	max_obj = 100
	actions = { store.ACTION_ENROLL,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_YMCA
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
	flags =
	{
	}
}

new_store
{
	define_as = "store.AIRPORT"
	name = "Airport"
	display = '+' color = color.YELLOW
	max_obj        = 13
	actions = { store.ACTION_TALK,	store.ACTION_PAY_FEE,
		    store.ACTION_HOTEL,	store.ACTION_ENROLL,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_MIKE
	flags =
	{
		-- LEVEL=function() return rng.range(25, 50) end
		STORE_MAINTAIN_TURNS = 0
	}
}

------------------------------------
-- Houses
------------------------------------
new_store
{
	define_as = "store.STORE_HOME_CAPSULE"
	name = "Capsule House"
	display = '8' color = color.YELLOW
	max_obj = 5
	store_make_num = 0
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_DROP,	store.ACTION_GET,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_HOME_HANGER"
	name = "Home"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_NONE }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_HOME_OOLONG"
	name = "Home Sweet Castle"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TECH }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_HOME_ROSSHI"
	name = "Home"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TECH }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_HOME_CHICHI"
	name = "Home"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TECH }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_HOME_VIDEL"
	name = "Home"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TECH }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_WISHHOME_EARTH"
	name = "Home"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TECH }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_WISHHOME_NAMEK"
	name = "Home"
	display = '8' color = color.YELLOW
	max_obj = 24
	store_make_num = 0
	actions = { store.ACTION_GET,	store.ACTION_REST_FREE,
		    store.ACTION_DROP,	store.ACTION_NONE,
		    store.ACTION_EXAMINE,	store.ACTION_TECH }
	owners = store.OWNER_PLAYER
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
new_store
{
	define_as = "store.STORE_BURUMA"
	name = "Capsule Storage"
	display = '8' color = color.YELLOW
	max_obj = 5
	store_make_num = 0
	actions = { store.ACTION_NONE,	store.ACTION_NONE,
		    store.ACTION_DROP,	store.ACTION_GET,
		    store.ACTION_NONE,	store.ACTION_NONE }
	owners = store.OWNER_BURUMA
	flags =
	{
		FREE=1
		STORE_MAINTAIN_TURNS = 0
	}
}
