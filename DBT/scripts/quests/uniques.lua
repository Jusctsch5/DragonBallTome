-- Dragonball T: Quests relating to uniques

add_quest
{
	global = "QUEST_DESERT_BANDIT"
	name = "Desert Bandit"
	desc = function()
		if quest(QUEST_DESERT_BANDIT).status == QUEST_STATUS_TAKEN then
			local line = {}
			if player.get_sex() == "Female" then
				line = {
					"#yDesert Bandit (Danger level: 12)",
					"You've encountered a strange, but attractive man in the desert. He seems"
					"friendly...but ran off in terror the moment you appeared. Why? And why did",
					"he call you 'sir?'"
				}
			else
				line = {
					"#yDesert Bandit (Danger level: 12)",
					"There's a bandit in the desert robbing people blind. Maybe you could do"
					"something about it?",
				}
			end


			if dball_data.yamcha_girl_counter < 2 then
				local line = {
					"#yDesert Bandit (Danger level: 12)",
					"You've encountered a boy on the bridge roughly northeast of the World Tournament."
					"He seems friendly...but ran off in terror the moment you appeared. Why? Why",
					"did he call you 'sir?' Who was he talking to in the water?"
				}
			elseif dball_data.yamcha_girl_counter < 4 then
				local line = {
					"#yDesert Bandit (Danger level: 12)",
					"You're not sure why, but it seems that the boy on the bridge is scared of you!",
					"In a way it gives you a bit of a headrush feeling of power, but at the same time",
					"it draws all sorts of nagging questions to your mind, and every time you see him",
					"run away you can't help but feel a little bit rejected. Is that why he called you",
					"'sir?' He thinks you're so ugly you look like a boy, but when he sees that you're",
					"not he can't cope and runs from your hideousness? Your stomache churns at the thought."
				}
			else
				local line = {
					"#yDesert Bandit (Danger level: 12)",
					"At last you think you've figured it out. Yamcha is scared of girls. What a relief!",
					"He doesn't think you're ugly, he just has issues! How marvelous! It's been a while",
					"since you've had a boy with problems that needed solving. Now...how to convince him",
					"that he needs you to fix him?"
				}
			end
			return line
		end
	end
	level = 12
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_BOSS_RABBIT"
	name = "Vorpal Bunnies"
	desc = function()
		if quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_TAKEN then
			local line = {}
			line =
			{
				"#yVorpal Bunnies (Danger level: 4)",
				"The villagers of Aru have been plagued by a viscious, magical bunny rabbit",
				"that transforms their men into carrots and then eats them! Perhaps you could",
				"put a stop to this?",
			}
			return line
		elseif quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_COMPLETED then
			return "#GVorpal Bunnies (Completed - Unrewarded)"
		end
	end
	level = 4
	hooks =
	{
	}
}

-- Note: This is one of those quests I started working on the the very early days of the
-- dialogue system...so the data handling is somewhat awkward. Too many variables, too
-- many states, far too complicated. Caution is advised.
add_quest
{
	global = "QUEST_OOLONG"
	name = "Oolong, the Terrible"
	desc = function()
		if quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.oolong_quest_helper == 1 then
				line = {
					"#yOolong, the Troubled (Danger level: 5)",
					"You've found the Aru village girls at Oolong's Castle, but it appears that",
					"they've not been taken by force, but rather have been coming to mooch off of",
					"the poor little pig. So much for houses made of bricks."
				}
			elseif dball_data.oolong_quest_helper == 2 then
				line = {
					"#yOolong, the Troublesome (Danger level: 5)",
					"Unfortunately, Marcos doesn't believe that the Aru village girls would choose",
					"a life of comfort and ease at Castle Oolong over life as a poor village girl.",
					"You're not sure what the best course of action is, but somone should probably",
					"do something about all this."
				}
			elseif dball_data.oolong_quest_helper == 3 then
				line = {
					"#yOolong, the Dead (Danger level: 5)",
					"You have slain the horrible beast responsible for taking away the poor, innocent",
					"village girls. Surely Marcos will be pleased."
				}
			else
				line = {
					"#yOolong, the Terrible (Danger level: 5)",
					"There is an evil, horrible humanoid pig that has been stealing away all the",
					"women of Aru village. No one knows what unspeakable horrors befall those so",
					"taken but none of these women have ever returned. Perhaps you could put an end",
					"to this terrible travesty? Oolong, or 'Oolong the Terrible' as he likes to be",
					"called, lives in the fashionable, and expensive-looking castle to the northwest",
					"of Aru village."
				}
			end
			return line
		elseif quest(QUEST_OOLONG).status == QUEST_STATUS_COMPLETED then
			return "#GOolong, the Terrible (Completed - Unrewarded)"
		end
	end
	level = 5
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_OOLONG_LONELY"
	name = "Oolong, the Lonely?"
	desc = function()
		if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN then
			local line = {}
			line =
			{
				"#yOolong, the Lonely? (Danger level: 5)",
				"You've spoken with Oolong. Yes, he is the one responsible for the missing",
				"women of Aru village, but to say that he's kidnapping them is...perhaps",
				"not entirely accurate. Oolong is a poor, sad, lonely little pig who really",
				"just wants to be loved. Maybe you could help him find a wife?",
			}
			return line
		end
	end
	level = 5
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_VIDEL_LONELY"
	name = "Videl's Challenge"
	desc = function()
		if quest(QUEST_VIDEL_LONELY).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.satan_state == 3 then
				line = {
					"#yVidel's Challenge (Danger level: 37)",
					"You've challenged Mr Satan's status as the world's greatest fighter,",
					"and he has agreed to let you marry Videl if you can prove yourself by",
					"winning the World Tournament."
				}
			elseif dball_data.videl_never_marry == 1 then
				line = {
					"#yVidel's Challenge (Danger level: 15)",
					"You've told Mr. Satan that you're married, so you're no longer a marriage",
					"prospect for Videl, but perhaps you could set her up with someone else?"
				}
			else
				line = {
					"#yVidel's Challenge (Danger level: 10)",
					"Being the daughter of the man renowned as the world's greatest fighter is",
					"not easy. Especially when he announces that his daughter is so great that",
					"he'll only allow her to marry a man who can defeat him in a duel. Videl says",
					"she's only 17, and not interested in getting married right now, but she's even",
					"less interested in becoming a lonely old maid just because her father is an",
					"idiot. Since you've passed the gauntlet and made it this far, she's asked you",
					"to challenge her father to a duel to win the right to date her."
				}
			end
			return line
		end
	end
	level = 10
	hooks =
	{
	}
}


-- Should provide a desc change based on Miss Piiza's 'awkward' state
add_quest
{
	global = "QUEST_AKIRA_SUSHI"
	name = "Sushi Delivery"
	desc =
	{
		"Akira the Sushi Chef has asked you to deliver an order of mackeral to a",
		"wealthy patron who happens to be a famous tournament fighters who goes by",
		"the stage name of Mr. Satan. This could be your chance to size up the",
		"competition for the World Tournament! Maybe you could pick up a few pointers",
		"from him, too.",
	}
	level = 3
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_AKIRA_MISSING_BOY"
	name = "Missing Delivery Boy"
	desc =
	{
		"While discussing Sushi Delivery, Akira the Sushi Chef made casual mention of",
		"that fact that his delivery boy had gone missing. He didn't actually ask you to",
		"get involved, but you might keep an eye open for the boy, all the same.",
	}
	level = 23
	hooks =
	{
	}
}
-- This quest really doesn't need to exist. I'm just using it
-- as a workaround to allow me to have the Sushi Bar not place
-- during map load if Akira is dead, since there's is no
-- way to place map symbols based on independant variables
-- and this is easier than messing with the appropriate wild map
-- generation hook
add_quest
{
	global = "QUEST_AKIRA_INSULTED"
	name = "Iron Chef"
	desc =
	{
		"You have insulted Akira, and now he's going to try to make sushi out of you.",
	}
	level = 7
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_ARU_THUGS"
	name = "Ruthless Thugs"
	desc =
	{
		"It seems that a pair of thugs have taken an interest in the recent revival of",
		"Aru village, and have been preying upon the newly returned villagers. Perhaps",
		"you might have a word with them?",

	}
	level = 12
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_CURIOUS_HOLE"
	name = "Curious Hole"
	desc = function()
		if quest(QUEST_CURIOUS_HOLE).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.karin_hole == 0 then
				line = {
					"#yCurious Hole (Danger level: 35)",
					"There is a small, round hole on the roof of Karin's Tower. It's about an",
					"inch and a half wide, a few inches deep, and perfectly round. Obviously",
					"it's intended as a receptacle for something, but what? And what of the",
					"platform suspended in mid-air above the tower? Could it be related?"
				}
			else
				line = {
					"#yCurious Hole (Danger level: 35)",
					"There is a small, round hole on the roof of Karin's Tower. Karin says it",
					"was dug out by a guest who wanted to visit Kami's Lookout but hadn't leatned",
					"how to fly or jump sufficiently far yet. He also mentioned a magic staff",
					"called the 'Nyoi-bo' which was inserted into the hole and extended to reach",
					"the lookout."
				}
			end
			return line
		end
	end
	level = 35
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_NYOIBO"
	name = "The Nyoi-bo"
	desc = function()
		if quest(QUEST_NYOIBO).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.karin_hole == 10 then
				line = {
					"#yThe Nyoi-bo (Danger level: 35)",
					"Karin has explained that the hole in the roof of his tower was made by",
					"the master of the Turtle school, Rosshi, who used it to place a magic",
					"staff called the 'Nyoi-bo,' thus allowing him to climb to Kami's Lookout.",
					"Only a pathetic turtle would need to go to such lengths, but this Nyoi-bo",
					"sounds like a very powerful item that deserves better than to be in the",
					"hands of stupid turtle students. Perhaps you should retreive it?",
				}
			elseif dball_data.karin_hole == 11 then
				line = {
					"#yThe Nyoi-bo (Danger level: 35)",
					"That idiot, Rosshi, has misplaced the prized Nyoi-bo. Or, so he claims.",
					"Perhaps he has it and is lying. Or perhaps he is simply an incompetant",
					"senile old man. Either way, you would like to find it.",
				}
			else
			end
			return line
		end
	end
	level = 35
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_DEFEAT_MR_POPO"
	name = "Defeat Mr Popo"
	desc = function()
		if quest(QUEST_DEFEAT_MR_POPO).status == QUEST_STATUS_TAKEN then
			local line = {}
			line = {
				"#yDefeat Mr Popo (Danger level: 45)",
				"You have challenged Mr Popo to a duel. Can you defat him?",
			}
			return line
		end
	end
	level = 45
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_KAMI_TO_KAIO"
	name = "Train with the North Kaio"
	desc = function()
		if quest(QUEST_KAMI_TO_KAIO).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.kaio_state == 0 then
				line = {
					"#yTrain with the North Kaio (Danger level: 50)",
					"You have learned much from your time with Kami, but it is time for you to",
					"ascend even higher in your training. Kami has opened up a portal to the",
					"afterworld for you to cross the Serpent's Path and seek out training with",
					"the North Kaio, Supreme Overseer of the Northern Quadrant of this galaxy."
				}
			else
				line = {
					"#yTrain with the North Kaio (Danger level: 50)",
					"You have found the North Kaio on his planet at the end of the Serpent's Path,",
					"but he has refused to train with you unless you can make him laugh! Looks like",
					"you'll need to find some good jokes. Or, from what you've seen so far, maybe",
					"you need some bad jokes."
				}
			end
			return line
		end
	end
	level = 50
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_DRAGONBALLS"
	name = "Locate the Seven Dragonballs"
	desc =
	{
		"You've been told a tale of seven magical balls which, once gathered",
		"together, allow an individual to summon the great Dragon of the Earth,",
		"Shenron, who will then grant his summoner a wish! Surely you could think",
		"of a wish you'd like granted, yes?",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_BURUMA_DRAGONBALLS"
	name = "Retrieve the Dragonballs for Buruma"
	desc =
	{
		"Buruma has asked you to help her find the mystic Dragonballs so that she",
		"may summon Shenron and make wish.",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_PILAF_RUBBLE"
	name = "Clean up the rubble from Castle Pilaf"
	desc =
	{
		"Emperor Pilaf has ordered you to clean up the rubble from the floors of",
		"Castle Pilaf.",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_PILAF_DRAGONBALLS"
	name = "Return the Dragonballs to Emperor Pilaf"
	desc =
	{
		"Emperor Pilaf has charged you with the task of finding the six Dragonballs",
		"he doesn't have, and returning them to him.",
	}
	level = 35
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_PILAF_RETURN"
	name = "Return to Castle Pilaf"
	desc =
	{
		"Since Mai and Shuu were too busy to kill you, Emperor Pilaf has asked you",
		"to come back another time so that he may have you properly executed. What",
		"to do, what to do...?",
	}
	level = 13
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_PILAF_EXECUTE"
	name = "Execute...you?"
	desc =
	{
		"Emperor Pilaf has ordered you to put yourself immediately to death. He says",
		"that pressing shift-Q is extremely effective, and relatively painless.",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_PILAF_RRA"
	name = "Destroy the Red Ribbon Army!"
	desc =
	{
		"There is a bitter rivalry between the nefarious forces of Emperor Pilaf, and",
		"the nefarious forces of the Red Ribbon Army. It seems both groups have plans",
		"to rule the world, and whatever else you might say about them, apparantly they",
		"are at least intelligent enough to realize that they can't both rule the world.",
		"Emperor Pilaf has asked you to destroy the RRA by assassinating their leader,",
		"Commander Red, a task his two servants, Shuu and Mai have as-of-yet been unable",
		"to perform. In exchange for this small task, he has agreed to allow you the",
		"privilage of serving him in the future. What a guy, huh?",
	}
	level = 35
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_RING_OF_FIRE"
	name = "Ring of Fire"
	desc =
	{
		"The Ox King has inadvertantly started a massive grease fire that has surrounded",
		"his castle, and trapped his daughter, and his dinner inside! What can you do to",
		"get him inside?",
	}
	level = 16
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_OXKING_DINNER"
	name = "Invitation to Dinner"
	desc =
	{
		"In gratitude for your efforts, the Ox King has invited you to join him,"
		"his daughter, and a spit-roasted wildebeast for dinner. It's just dinner,",
		"right? What could possibly happen?",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_FAN_LADY"
	name = "Beautiful Fans"
	desc =
	{
		"You've met a charming woman who makes fans from the feathers of birds and other",
		"suitable materials. It might be nice to have a fan.",
	}
	level = 3
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_LITTER_BOX"
	name = "Clean Tama's Litter Box"
	desc =
	{
		"Dr. Briefs' cat, Tama, has nicely asked you to clean her litter box for her.",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_BEAR_THIEF"
	name = "Bear Thief"
	desc = function()
		if quest(QUEST_BEAR_THIEF).status == QUEST_STATUS_TAKEN then
			local line = "#yBear Thief (Danger level: 26)\n"
			if dball_data.bear_thief_dbs == 0 then
				line = line .. "A brown bear in a mask tried to steal something from you! You don't think " ..
					"you're missing anything, but after the attempt, the bear vanished! You've " ..
					"a sneaking suspicion you'll see him again."
			elseif dball_data.bear_thief_dbs == 1 then
				line = line ..
					"The Bear Thief has stolen one of your dragonballs, and vanished without" ..
					"a trace! You'd better find that bear and get the dragonball back."
			else
				line = line ..
					"The Bear Thief has now stolen " .. dball_data.bear_thief_dbs .. " dragonballs from you. You're" ..
					"fairly certain he's not going to still have them all by the time you finally do" ..
					"manage to track him down, but if you're ever going to gather them all together" ..
					"you'd really better find that bear and deal with him, permanently."
			end
			return line
		end
	end
	level = 26
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if monst.r_idx == RACE_BEAR_THIEF and quest(QUEST_BEAR_THIEF).status == QUEST_STATUS_TAKEN then
				if quest(QUEST_BEAR_THIEF).status == QUEST_STATUS_TAKEN then
					message(color.YELLOW, "At last! The Bear Thief is dead!")
					if dball_data.bear_thief_dbs > 1 then
						-- Implement check! This line should only occur if a dragonball is available!
						message(color.YELLOW, "Unfortuantely he only seems to have a single dragonball on him.")
					end
					change_quest_status(QUEST_BEAR_THIEF, QUEST_STATUS_FINISHED)
				end
			end
		end
	}
}
add_quest
{
	global = "QUEST_HASUKI"
	name = "Hasuki, the thief"
	desc = function()
		if quest(QUEST_HASUKI).status == QUEST_STATUS_TAKEN then
			if dball_data.hasuki_dbs == 0 then
				local line = {
					"#yHasuki, the thief (Danger level: 24)",
					"Hasuki, the mercenary thief, has tried to steal a dragonball from you!",
					"Fortunately you were able to stop him, but you're certain he'll try to",
					"strike again. You'd best be ready for him."
				}
			elseif dball_data.hasuki_dbs == 1 then
				local line = {
					"#yHasuki, the thief (Danger level: 24)",
					"Hasuki has stolen one of your dragonballs, and vanished without",
					"a trace! You'd better find him and get it dragonball back."
				}
			else
				local line = {
					"#yHasuki, the thief (Danger level: 24)",
					"Hasuki has now stolen " .. dball_data.hasuki_dbs .. " dragonballs from you. You're",
					"fairly certain he's not going to still have them all by the time you finally do",
					"manage to track him down, but if you're ever going to gather them all together",
					"you'd really better find him down and deal with him, permanently."
				}
			end
			return line
		end
	end
	level = 24
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if monst.r_idx == RACE_HASUKI and quest(QUEST_HASUKI).status == QUEST_STATUS_TAKEN then
				if quest(QUEST_HASUKI).status == QUEST_STATUS_TAKEN then
					message(color.YELLOW, "At last! Hasuki is dead!")
					if dball_data.bear_hasuki_dbs > 1 then
						message(color.YELLOW, "Unfortuantely he only seems to have a single dragonball on him.")
					end
					change_quest_status(QUEST_HASUKI, QUEST_STATUS_FINISHED)
				end
			end
		end
	}
}

--[[
add_quest
{
	global = "QUEST_HUNGRY_SWORDSMAN"
	name = "Hungry Swordman"
	desc =
	{
		"You've met a swordman in the mountains, Yajirobe who's, offered to...",
	}
	level = 7
	hooks =
	{
	}
}
]]

add_quest
{
	global = "QUEST_WHITE_WOLF"
	name = "Slay the White Wolf"
	desc =
	{
		"Tsuru Seni'Nin, the Crane Hermit, has offered to give you training if you can",
		"defeat the White Wolf that has been attacking his food deliveries.",
	}
	level = 27
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_TENTACLE_DEMON"
	name = "Tentacle Demon"
	desc =
	{
		"Uranai Baba has agreed to let you have the Nyoi-bo if you'll rid her basement of",
		"the tentacled horrors living there. Of course, it's those same horrors who have",
		"the Nyoi-bo right now anyway.",
	}
	level = 32
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_SAVE_THE_TEMPLE"
	name = "Save the Temple"
	desc = function()
		if quest(QUEST_SAVE_THE_TEMPLE).status == QUEST_STATUS_TAKEN then
			local line = {}
			line =
			{
				"#ySave the Temple (Danger level: 4)",
				"Orinji Buddhist Temple has been overrun by invaders. The Abbot and the",
				"highest raning priests have all been locked into their private meditation",
				"chambers at the bottom of the catacombs. You must rescue them from their",
				"follishness.",
			}
			return line
		--elseif quest(QUEST_SAVE_THE_TEMPLE).status == QUEST_STATUS_COMPLETED then
		--	return "#GSave the Temple (Completed - Unrewarded)"
		end
	end
	level = 20
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_KRILLANS_MAGAZINES"
	name = "Krillan's Magazines"
	desc = function()
		if quest(QUEST_KRILLANS_MAGAZINES).status == QUEST_STATUS_TAKEN then
			local line = {}
			line =
			{
				"#yKrillan's Magazines (Danger level: 10)",
				"You've found a stack of porno magazines hidden away in the catacombs of",
				"Orinji Temple. They obviously belong to Krillan. How to handle this?",
			}
			return line
		--elseif quest(QUEST_KRILLANS_MAGAZINES).status == QUEST_STATUS_COMPLETED then
		--	return "#GKrillan's Magazines (Completed - Unrewarded)"
		end
	end
	level = 4
	hooks =
	{
	}
}
