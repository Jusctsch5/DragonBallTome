-- Dragonball T: The quests of Namek


add_quest
{
	global = "QUEST_NAMEK_KAMI"
	name = "Lost Namek"
	desc =
	{
		"An Elder of Namek has asked you find the creator of the Earth dragonballs.",
	}
	level = 25
	hooks =
	{
	}
}


-- (1) Namek Northwest
add_quest
{
	global = "QUEST_NAMEK_WATER"
	name = "Water of Namek"
	desc = function()
		if quest(QUEST_NAMEK_WATER).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yWater of Namek (Danger level: 5)" ..
				"\nThe well in the first, and largest village on Namek has gone dry. They are digging a new" ..
				"one, but in the meantime they've been having to haul water quite some distance from the" ..
				"ocean. The Elder of the village has agreed to give you the dragonball in his possession" ..
				"if you are able to fill the old well with water."
			}
			return line
		elseif quest(QUEST_NAMEK_WATER).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GWater of Namek (completed)" ..
				"\nYou have filled the empty well with water."
			}
			return line
		end
	end
	level = 5
	hooks =
	{
	}
}
-- (2) Namek Northwest
add_quest
{
	global = "QUEST_NAMEK_POLLINATION"
	name = "Cross Pollination"
	desc = function()
		if quest(QUEST_NAMEK_POLLINATION).status == QUEST_STATUS_TAKEN then
			local foo = "You have not delivered any ajisa plants yet."
			if dball_data.namek_ajasa_deliver > 0 then
				foo = "You have delivered " .. dball_data.namek_ajasa_deliver .. " out of 6 ajisa plants."
			end
			local line = {
				"#y (Danger level: 5)" ..
				"\nThe Nameks of the second village have had a strong and beautiful growth season, and their Elder" ..
				"has asked you to carry a fully grown, potted ajisa plant to each of the other six settlements." ..
				foo
			}
			return line
		elseif quest(QUEST_NAMEK_POLLINATION).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#G (completed)\n" ..
				"You have delivered ajisa plants to all other six villages."
			}
			return line
		end
	end
	level = 3
	hooks =
	{
	}
}
-- (3) Namek Northwest
add_quest
{
	global = "QUEST_NAMEK_SEEDS"
	name = "Namekian Ajisa Seeds"
	desc = function()
		if quest(QUEST_NAMEK_SEEDS).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yNamekian Ajisa Seeds (Danger level: 5)" ..
				"\nA series of accidents has left the third village on Namek completely bereft of their precious " ..
				"ajisa seeds. The Elder of the village has asked you to retreive seeds from a neighboring village, " ..
				"and has agreed to give you the Dragonball in his possession if you do."
			}
			return line
		elseif quest(QUEST_NAMEK_SEEDS).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GNamekian Ajisa Seeds (completed)" ..
				"\nYou have give given seeds to return to the elder of the third village."
			}
			return line
		end
	end
	level = 3
	hooks =
	{
	}
}
-- (4) Namek Southwest
add_quest
{
	global = "QUEST_NAMEK_AJISA"
	name = "Lonely Ajisa"
	desc = function()
		if quest(QUEST_NAMEK_AJISA).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yLonely Ajisa (Danger level: 5)" ..
				"\nThe fourth Elder of Namek has agreed to give you his dragonball if you are able to plant " ..
				"an ajisa seed anywhere in the unpopulated portion of Namek, and tend to it until it blooms."
			}
			return line
		elseif quest(QUEST_NAMEK_AJISA).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GLonely Ajisa (completed)" ..
				"\nYou have successfully nurtured an ajisa plant to bloom."
			}
			return line
		end
	end
	level = 3
	hooks =
	{
	}
}
-- (5) Namek Southwest
add_quest
{
	global = "QUEST_NAMEK_ISOLATION"
	name = "Isloation"
	desc = function()
		if quest(QUEST_NAMEK_ISOLATION).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yIsolation (Danger level: 5)" ..
				"\nThe Elder of the fifth village of Namek has become so aged that he is no longer able to fly. " ..
				"He is due for a successor, but unfortunately this village is populated exclusively by farmers " ..
				"and no one is worthy to take his place. Neither are any of the farmers able to fly, and isolated " ..
				"as they are on an island, they've asked you to carry word to a neighboring village so that a " ..
				"suitable replacement may be found."
			}
			return line
		elseif quest(QUEST_NAMEK_ISOLATION).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GIsolation (completed)" ..
				"\nYou have found a suitable successor for the Elder of the fifth village."
			}
			return line
		end
	end
	level = 3
	hooks =
	{
	}
}
-- (6) Namek Southeast
add_quest
{
	global = "QUEST_NAMEK_LEVIATHAN"
	name = "Leviathan"
	desc = function()
		if quest(QUEST_NAMEK_LEVIATHAN).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yLeviathan (Danger level: 40)",
				"The sixth Elder of Namek has agreed to give you his dragonball if you",
				"can demonstrate that you are a worthy warrior. To prove this, you must",
				"defeat a sea beast in battle, and return with its carcass as proof."
			}
			return line
		elseif quest(QUEST_NAMEK_LEVIATHAN).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GLeviathan (completed)" ..
				"\nYou have slain a leviathan. Now you must deliver the corpse to the sixth Elder."
			}
			return line
		end
	end
	level = 40
	hooks =
	{
	}
}

-- (7) in Namek Southeast
add_quest
{
	global = "QUEST_NAMEK_GREAT_ELDER"
	name = "Great Elder"
	desc = function()
		if quest(QUEST_NAMEK_GREAT_ELDER).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yGreat Elder (Danger level: 5)" ..
				"\nThe Great Elder of Namek has agreed to give you the Dragonball is his possession only if " ..
				"you are able to convince the other six elders to give you their Dragonballs willingly. "
			}
			return line
		elseif quest(QUEST_NAMEK_GREAT_ELDER).status == QUEST_STATUS_COMPLETED then
			local line = {
				"#GGreat Elder (completed)" ..
				"\nYou have retreived the other six Dragonalls of Namek. Now you must show them to the ",
				"Great Elder to receive the seventh."
			}
			return line
		end
	end
	level = 45
	hooks =
	{
	}
}
