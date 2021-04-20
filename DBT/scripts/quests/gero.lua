-- Dragonball T: Quests and functions relating to Dr. Gero

add_quest
{
	global = "QUEST_GERO_RETRIEVE"
	name = "Errand for Dr. Gero"
	desc = function()
		if quest(QUEST_GERO_RETRIEVE).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.gero_current_quest == 0 then
				line =
				{
				"#yErrand for Dr. Gero (Dinosaur or whale)",
				"Dr. Gero has asked you to retreive the carcass of a large creature",
				"with strong cartilige. He is not particular about the details, but",
				"recommended a dinosaur or whale. Of course, from your impression,",
				"he seems like the type to be very vague about what he wants and still",
				"be annoyed when he doesn't get exactly what he had in mind.",
				}
			elseif dball_data.gero_current_quest == 2 then
				line =
				{
				"#yErrand for Dr. Gero",
				"",
				}
			else
				line =
				{
				"#yErrand for Dr. Gero",
				"Unknown quest?",
				}
			end
			return line
		end
	end
	level = 25
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_GERO_MASTERMIND"
	name = "Evil Mastermind"
	desc =
	{
		"With the Red Ribbon Army Supreme Commander, Red, now dead...the world is a",
		"safer place. Still, you have a difficult time believing that any man with",
		"ambitions no greater than wishing to be taller could single handedly build",
		"an organization as large and powerful as the Army. Where did they get their",
		"funding? Where did Android number 8 come from? Certainly no one you've seen",
		"in the Army could have built such a device. And with a name like 'number 8'",
		"there are probably others like him. In fact, he referred to the androids as",
		"'we.' Where are they? So many questions, but of this one thing you have no",
		"doubt: Whomever or whatever was behind the Red Ribbon Army is still lurking",
		"somewhere.",
	}
	level = 50
	hooks =
	{
	}
}

constant("drgero", {})

add_loadsave("drgero.quest_no", 0)
add_loadsave("drgero.annoyed", 0)
add_loadsave("drgero.capture", 0)

-- This makes Dr. Gero not like you
-- and sets his automatons after you
function drgero.annoy()
	drgero.annoyed = 1
	factions.set_friendliness(FACTION_GERO, FACTION_PLAYER, -100)
	factions.set_friendliness(FACTION_PLAYER, FACTION_GERO, -100)
	for_each_monster(function(m_idx, monst)
--		if monst.faction == FACTION_GERO then
		-- if monst.r_idx == RACE_WHIRLIGIG then
--			if monst.ai then
				monst.ai = ai.ZOMBIE
--			end
--		end
	end)
end

-- This puts the whirlgigs back on peaceful mode
function drgero.unannoy()
	drgero.annoyed = 0
	factions.set_friendliness(FACTION_GERO, FACTION_PLAYER, 0)
	factions.set_friendliness(FACTION_PLAYER, FACTION_GERO, 0)
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == RACE_WHIRLIGIG then
			monst.ai = ai.NEVER_MOVE
		end
	end)
end
