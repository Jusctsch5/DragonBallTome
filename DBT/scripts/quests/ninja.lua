-- The various Ninja quests
-- Most of these quests are comic references to the
-- Teenage Mutant Ninja Turtles
-- For TMNT fans...I'm going by the movie, not the manga,
-- or the TV series. The story premises were slightly
-- different in each.

add_quest
{
	global = "QUEST_STOLEN_GOODS"
	name = "Solve the Thefts"
	desc = function()
		if quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_TAKEN then
			local line = {
				"#ySolve the Thefts (Danger level: 15)",
				"The proprieter of the Electronics store has complained that his shipments are",
				"being hijacked en route. He has asked you to investigate, and report back to",
				"him once you know who is responsible. So far..."
			}

			local no_clues = 0
			local no_reported = 0
			if dball_data.goods_lazarus == 1 then
				no_clues = no_clues + 1
				tinsert(line," * The proprieter of the pawnshop, Lazarus, has admitted to buying stolen")
				tinsert(line,"   goods from a group of thugs dressed all in black.")
			elseif dball_data.goods_lazarus == 2 then
				no_reported = no_reported + 1
				tinsert(line," * You've reported that Lazarus has been buying stolen goods.")
			end
			if dball_data.goods_akira == 1 then
				no_clues = no_clues + 1
				tinsert(line," * Akira the sushi chef claims that the pattern of the thefts greatly")
				tinsert(line,"   resembles a crime wave that took place in Japan a few years ago. In")
				tinsert(line,"   that case, those responsible turned out to be ninja.")
			elseif dball_data.goods_akira == 2 then
				no_reported = no_reported + 1
				tinsert(line," * You've reported the similarities of these crimes to those Akira")
				tinsert(line,"   mentioned had been committed in Japan by a ninja clan.")
			end
			if dball_data.goods_splinter == 1 then
				no_clues = no_clues + 1
				tinsert(line," * A mutant rat by the name of Splinter claims that a rival ninja clan")
				tinsert(line,"   known as The Foot is responsible for these crimes.")
			elseif dball_data.goods_splinter == 2 then
				no_reported = no_reported + 1
				tinsert(line," * You've reported the words of the rat, Splinter, that it is the Foot")
				tinsert(line,"   ninja clan responsible for the thefts.")
			end
			if dball_data.goods_warehouse == 1 then
				no_clues = no_clues + 1
				tinsert(line," * You've found the lair of The Foot ninja clan in a warehouse on a")
				tinsert(line,"   nearby island, and you've even found a stash of consumer electronics")
				tinsert(line,"   still in their original packages.")
			end

			if no_clues + no_reported == 0 then
				tinsert(line," * You have no clues.")
			end
			return line
		end
	end
	level = 15
	hooks =
	{
	}
}


-- NOTE: there is overlap in some of the ninja quests.
-- KILL_SHREDDER, DEFEAT_THE_FOOT and FIND_THE_TURTLES
-- are all essentially the same quest, with slightly
-- different dialogues, rewards, and interactions from
-- the uniques. Each quest is issued in a different way,
-- and the three are mutually exclusive.

-- This quest can be issued completely on it's own, but is also
-- a logical progression from STOLEN_GOODS
add_quest
{
	global = "QUEST_BEING_WATCHED"
	name = "I Feel Like I'm Being Watched"
	desc = function()
		if quest(QUEST_BEING_WATCHED).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.foot_assassin == 0 then
				line = {
					"#yI Feel Like I'm Being Watched (Danger level: 15)",
					"Ever since you visited that warehouse on the island, you've had the strangest",
					"feeling that someone is following you. Watching you. Better keep your eyes open.",
					"Something could happen at any moment."
				}
			else
				line = {
					"#yI Feel Like I'm Being Watched (Danger level: 15)",
					"It seems that the Foot ninja clan have noticed your interferance in their",
					"affairs, and are monitoring your actions. Assassins may appear at any moment."
				}
			end
		end
	end
	level = 15
	hooks =
	{
	}
}

-- NOTE: There is much overlap amongst the various ninja quests
-- Read carefully

add_quest
{
	global = "QUEST_DESTROY_THE_FOOT"
	name = "Destroy the Foot Clan"
	desc =
	{
		"You've finally figured out that it's a ninja clan known as The Foot that's",
		"responsible for all the thefts. Now it's time to do something about it. But",
		"what?",
	}
	level = 22
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_KILL_SHREDDER_FOR_HATSUMI"
	name = "The Cleansing"
	desc =
	{
		"Grandmaster Hatsumi has asked you to purge the fallen Ninja Master,",
		"Oroku Saki, from this world.",
	}
	level = 22
	hooks =
	{
	}
}

-- NOTE: This is the variant for when the quest is issued by Splinter. If you go this route,
-- The Foot will fight you every step of the way, and when your reach the Shredder...(then what?)
-- Dead Turtles? Issue KILL_SPLINTER?

add_quest
{
	global = "QUEST_FIND_TURTLES"
	name = "Locate the Teenage Mutant Ninja Turtles"
	desc =
	{
		"The rat, Splinter, has asked you to find his pupils, Leonardo, Donatello,",
		"Michealangelo and Raphael. They had gone together to the warehouse on the",
		"island north of the City Sewers and have not been seen in several days. He",
		"fears the worst.",
	}
	level = 17
	hooks =
	{
	}
}


add_quest
{
	global = "QUEST_DESTROY_TURTULES"
	name = "Locate the Teenage Mutant Ninja Turtles"
	desc =
	{
		"The rat, Splinter, has asked you to find his pupils, Leonardo, Donatello,",
		"Michealangelo and Raphael. They had gone together to the warehouse on the",
		"island north of the City Sewers and have not been seen in several days. He",
		"fears the worst.",
	}
	level = 17
	hooks =
	{
	}
}


add_quest
{
	global = "QUEST_KILL_SPLINTER"
	name = "Kill the Rat, Splinter"
	desc =
	{
		"The leader of The Foot ninja clan, Oroku Saki, has asked you to find and",
		"kill a humanoid rat that has been creating problems for his clan. This rat",
		"goes by the name of Splinter. While Oroku Saki does not know for certain where",
		"to find Splinter, he says that ",
	}
	level = 17
	hooks =
	{
	}
}

