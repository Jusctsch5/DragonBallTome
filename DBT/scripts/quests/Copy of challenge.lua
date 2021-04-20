-- The various School Challenge Quests (And Elizabeth's Mouse Hunt)

add_quest
{
	global = "QUEST_CHALLENGE_KARATE"
	name = "Defeat the Karate School"
	desc =
	{
		"Challenge the head instructor at the Karate school, and defeat him!",
	}
	level = 20
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_NAKAMURA) and dball_data.tourny_now == 0 then
				c_schools[FLAG_KARATE] = FLAG_SCHOOL_CLOSED
				trainer[FLAG_KICKBOXING] = 1
				if quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_TAKEN then
					message(color.YELLOW, "Yeah, you knew he'd be a pushover.")
					quest(QUEST_CHALLENGE_KARATE).status = QUEST_STATUS_COMPLETED
				else
					message(color.YELLOW, "Ashamed of his defeat, Nakamura returns to Japan to train.")
				end
			end
		end
	}
}

add_quest
{
	global = "QUEST_CHALLENGE_KICKBOXING"
	name = "Defeat the Kickboxing School"
	desc =
	{
		"Challenge the head instructor at the Kickboxing school, and defeat him!",
	}
	level = 20
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_BOB) and dball_data.tourny_now == 0 then
				c_schools[FLAG_KICKBOXING] = FLAG_SCHOOL_CLOSED
				trainer[FLAG_KARATE] = 1
				if quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_TAKEN then
					message(color.YELLOW, "Precision and control does indeed defeat callous, brute strength.")
					quest(QUEST_CHALLENGE_KICKBOXING).status = QUEST_STATUS_COMPLETED
				else
					message(color.YELLOW, "Ashamed of his defeat, Bob leaves town to train.")
				end
			end
		end
	}
}

add_quest
{
	global = "QUEST_CHALLENGE_KUNGFU"
	name = "Defeat the Kung-fu School"
	desc =
	{
		"Challenge the head instructor at the Kung-fu school, and defeat him!",
	}
	level = 20
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_FONG_SAI_YUK) and dball_data.tourny_now == 0 then
				c_schools[FLAG_KUNGFU] = FLAG_SCHOOL_CLOSED
				trainer[FLAG_FENCING] = 1
				if quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_TAKEN then			
					message(color.YELLOW, "Most excellent! Fong-Sai Yuk has been defeated!")
					quest(QUEST_CHALLENGE_KUNGFU).status = QUEST_STATUS_COMPLETED
				else
					message(color.YELLOW, "Ashamed of his defeat, Fong-Sai Yuk closes his school to train in the woods.")
				end
			end
		end
	}
}
add_quest
{
	global = "QUEST_CHALLENGE_FENCING"
	name = "Defeat the Fencing School"
	desc =
	{
		"Challenge the head instructor at the Fencing school, and defeat him!",
	}
	level = 20
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_JACQUE) and dball_data.tourny_now == 0 then
				c_schools[FLAG_FENCING] = FLAG_SCHOOL_CLOSED
				trainer[FLAG_KUNGFU] = 1
				if quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_TAKEN then			
					message(color.YELLOW, "Yup! Frenchie is gone!")
					quest(QUEST_CHALLENGE_FENCING).status = QUEST_STATUS_COMPLETED
				else
					message(color.YELLOW, "Ashamed of his defeat, Jacque closes his school and retires.")
				end
			end
		end
	}
}

add_quest
{
	global = "QUEST_CHALLENGE_TAEKWONDO"
	name = "Defeat the Tae Kwon Do School"
	desc =
	{
		"Challenge the head instructor at the Tae-Kwon-Do school, and defeat him!",
	}
	level = 20
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_MASTER_LEE) and dball_data.tourny_now == 0 then
				c_schools[FLAG_TAEKWONDO] = FLAG_SCHOOL_CLOSED
				-- trainer[FLAG_???] = 1
				if quest(QUEST_CHALLENGE_TAEKWONDO).status == QUEST_STATUS_TAKEN then			
					message(color.YELLOW, "Yeah...you didn't think it would be too tough.")
					quest(QUEST_CHALLENGE_TAEKWONDO).status = QUEST_STATUS_COMPLETED
				else
					message(color.YELLOW, "Accepting his defeat with courage, Master Lee closes his studio to train.")
				end
			end
		end
	}
}

-- NOTE: See comments in quests/ninja.lua regarding this quest
add_quest
{
	global = "QUEST_KILL_SHREDDER"
	name = "Defeat the Shredder"
	desc =
	{
		"The leader of the Foot clan, Oroku Saki, has turned to a life of petty",
		"greed. Find him, and deal with him. It is not enough, though, that he",
		"simply be defeated. You must kill him.",
		"(Not implemented)",
	}
	level = 22
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_BALLET_PRE"
	name = "Missing Dancers"
	desc =
	{
		"One of the dancers at the local Ballet studio has gone insane, and disappeared with eight children.",
		"Can you find them and bring them back, alive?",
	}
	level = 15
	hooks =
	{
	}
}
add_quest
{
	global = "QUEST_CHALLENGE_NINJUTSU"
	name = "Destroy the Ninja!"
	desc =
	{
		"Elizabeth insists that there is a horrible, awful clan of ninja running amuck!",
		"Can you stop them?",
	}
	level = 25
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_TAXIDERMY"
	name = "Taxidermy"
	desc =
	{
		"Charles at the shooting range would really like to have a bearskin rug for his shop at the",
		"shooting range. He'd go out and bag a bear himself if he didn't have mind the shop.",
		"Maybe you could bring one back for him?", 
	}
	level = 27
	hooks =
	{
	}
}


add_quest
{
	global = "QUEST_CHALLENGE_JUDO"
	name = "Challenge Yawara to a Friendly Match"
	desc =
	{
		"You've been asked by Honda to engage the head instructor of a nearby Judo",
		"school in a friendly wrestling match. It doesn't matter if you win or lose,",
		"you just need to convince her to fight.",
	}
	level = 7
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_YAWARA) and dball_data.tourny_now == 0 then
				c_schools[FLAG_JUDO] = FLAG_SCHOOL_CLOSED
				trainer[FLAG_SUMO] = 1
				-- Because simply entering the ring completes the match...
				-- Quest will be untaken if this is to the death
				if quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_COMPLETED then
					message(color.YELLOW, "Yawara is saddened, but acknowledges her defeat and decides to close her school so that she may dedicate herself more completely to her training.")
					race_info(monst).max_num = 1
				else
					message(color.YELLOW, "With Yawara dead, her school will now close.")
				end
			end
		end
	}
}


add_quest
{
	global = "QUEST_CHALLENGE_SUMO"
	name = "Defeat Honda in a Friendly Match"
	desc =
	{
		"Your former Judo Instructor, Yawara, has been humiliated in the ring by",
		"a Sumo instructor named Honda. You've volunteered to defeat Honda in a",
		"friendly wrestling match to remind him that he is not invincible, and to",
		"restore some dignity to Yawara and her school.",
	}
	level = 15
	hooks =
	{
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			if (monst.r_idx == RACE_HONDA) and dball_data.tourny_now == 0 then
				c_schools[FLAG_SUMO] = FLAG_SCHOOL_CLOSED
				trainer[FLAG_JUDO] = 1
				if quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_TAKEN then
					message(color.YELLOW, "Congratulations! You've defeated Honda! Yawara will be exctatic, I'm sure! As for Honda, he is so shocked at his defeat by someone so much smaller than he, and he decides to close his school to dedicate himself more fully to his training.")
					race_info(monst).max_num = 1
					quest(QUEST_CHALLENGE_SUMO).status = QUEST_STATUS_COMPLETED
				else
					message(color.YELLOW, "With Honda dead, his school will now close.")
				end
			end
		end
	}
}


-- NOTE: As of DBT V0.3.0 this quest is functional...there is just no way to complete it.
add_quest
{
	global = "QUEST_CRIMINAL"
	name = "Criminal!"
	desc =
	{
		"Threatening dance instructors isn't very bright. Now you're a wanted criminal!",
		"What can you do to clear your good name?",
	}
	level = 15
	hooks =
	{
		-- Police officer kill tally
		[hook.MONSTER_DEATH] = function(m_idx)
			local monst = monster(m_idx)
			
			if (monst.r_idx == RACE_POLICE) then
				dball_data.police_killed = dball_data.police_killed + 1
				quest_desc(QUEST_CRIMINAL, 0, "Threatening Elizabeth was bad enough, but now you're on the books for\nthe death of ".. dball_data.police_killed .. " police officers! It's going to be awfully\ndifficult to clear your name now.")
			end
		end
	}
}

add_quest
{
	global = "QUEST_DOJO_DESTROYER"
	name = "Dojo Destroyer"
	desc = function()
		if quest(QUEST_DOJO_DESTROYER).status == QUEST_STATUS_TAKEN then
			local line = "#yDojo Destroyer (Danger level: 23)\n"
			line = line .. "The fewer martial arts schools there are in the area, the larger the remaining schools will become and thus, the better training they will be able to offer. More schools means better variety, but fewer schools means higher skill. Which schools will you train at? Which schools will you destroy?\n"
			line = line .. "You are a student of:\n"
			if enrollments[FLAG_KARATE] > 0 then
				if quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_FINISHED then
					line = line .. " * Karate\n"
				else
					line = line .. " * Karate (Must defeat Kickboxing to qualify)"
				end
			end
			if enrollments[FLAG_KICKBOXING] > 0 then
				if quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_FINISHED then
					line = line .. " * Kickboxing\n"
				else
					line = line .. " * Kickboxing (Must defeat Karate to qualify)"
				end
			end
			if enrollments[FLAG_KUNGFU] > 0 then
				if quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_FINISHED then
					line = line .. " * Kung fu\n"
				else
					line = line .. " * Kung fu (Must defeat Fencing to qualify)"
				end
			end
			if enrollments[FLAG_FENCING] > 0 then
				if quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_FINISHED then
					line = line .. " * Fencing\n"
				else
					line = line .. " * Fencing (Must defeat Kung fu to qualify)"
				end
			end
			if enrollments[FLAG_SUMO] > 0 then
				if quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_FINISHED then
					line = line .. " * Sumo\n"
				else
					line = line .. " * Sumo (Must defeat Judo to qualify)"
				end
			end
			if enrollments[FLAG_JUDO] > 0 then
				if quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_FINISHED then
					line = line .. " * \n"
				else
					line = line .. " *  (Must defeat  to qualify)"
				end
			end
			if enrollments[FLAG_BALLET] > 0 then
				if quest(QUEST_CHALLENGE_NINJUTSU).status == QUEST_STATUS_FINISHED then
					line = line .. " * Ballet\n"
				else
					line = line .. " * Ballet (Must defeat Ninjutsu to qualify)"
				end
			end
			if enrollments[FLAG_NINJUTSU] > 0 then
				if quest(QUEST_CHALLENGE_BALLET).status == QUEST_STATUS_FINISHED then
					line = line .. " * Ninjutsu\n"
				else
					line = line .. " * Ninjustu (Must defeat Ballet to qualify)"
				end
			end
			line = line .. "Your training caps at these schools will increase by destroying:\n"
			if enrollments[FLAG_KARATE] == 0 then line = line .. " * Karate\n" end
			if enrollments[FLAG_KICKBOXING] == 0 then line = line .. " * Kickboxing\n" end
			if enrollments[FLAG_KUNGFU] == 0 then line = line .. " * Kung fu\n" end
			if enrollments[FLAG_FENCING] == 0 then line = line .. " * Fencing\n" end
			if enrollments[FLAG_SUMO] == 0 then line = line .. " * Sumo\n" end
			if enrollments[FLAG_JUDO] == 0 then line = line .. " * Judo\n" end
			if enrollments[FLAG_BALLET] == 0 then line = line .. " * Ballet\n" end
			if enrollments[FLAG_NINJUTSU] == 0 then line = line .. " * Ninjutsu\n" end
			line = line .."\n"
			return line
		end
	end
	level = 23
	hooks =
	{
	}
}
