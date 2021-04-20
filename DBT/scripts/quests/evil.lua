-- Quests pertaining to the Evil paths
--[[
add_quest
{
	global = "QUEST_IMPENDING_DOOM"
	name = "Impending Doom"
	desc = function()
		if quest(QUEST_IMPENDING_DOOM).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yImpending Doom (Level: 50)",
				"The words of that madman you met outside the World Tournament still haunt",
				"you: 'resume preparations for the extermination of all sentient life on this",
				"planet.' Who was he? What was he talking about? Why did he keep calling you",
				"'" .. dball.get_seiyan_name() .. "?' You don't know...but you have a feeling that there",
				"was more to his words than merely the ravings of a lunatic."
			}
			return line
		end
	}
	level = 50
	hooks =
	{
	}
}
]]
add_quest
{
	global = "QUEST_ABSORB_AND_GROW"
	name = "Absorb and Grow"
	desc =
	{
		"Now that you have become a Bio-Android, your DNA has been altered, turned in a way,",
		"into a blank slate. Right now you are weak...weaker than you have ever been, and you",
		"must quickly absorb the life energy and DNA of as many creatures as possible!",
	}
	level = 50
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_KILL_NAMEK"
	name = "Exterminate the Nameks"
	desc =
	{
		"The natives of the planet Namek guard a set of dragonballs, but have refused to",
		"relinquish their secrets to your master. Kill them. All.",
	}
	level = 50
	hooks =
	{
	}
}
