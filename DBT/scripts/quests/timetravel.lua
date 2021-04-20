-- Dragonball T: Quests relating to the Time Travel plotlines

add_quest
{
	global = "QUEST_ANDROIDS"
	name = "Androids From the Future!"
	desc = function()
		if quest(QUEST_ANDROIDS).status == QUEST_STATUS_TAKEN then
			if dball_data.android_quest_status == 2 then
				-- Androids have been seen
				local line = {
					"#yAndroids From the Future! (Level: 65, at least.)",
					"The twin Androids, 16 and 17, have arrived many years ahead of the schedule",
					"predicted by Trunks. Day in, day out, without sleep or rest, they wander the",
					"planet seeking humans to kill. However, there is a faint glimmer of hope: If",
					"the entire unfolding of the timeline of the present has been changed merely by",
					"Trunks' arrival then surely it is also possible to change the present in order",
					"to prevent the horrible future that Trunks comes from, from ever occuring?"
				}
			else
				local line = {
					"#yAndroids From the Future! (Level: 65, at least.)\n",
					"The words of Trunks, the boy from the future, still haunt you. You do not know"
					"when the Androids will arrive, but you had best be prepared for them when they do."
				}
				
				local hm_days = dball.dayofyear() - dball_data.ttq_day_tripped 
				if hm_days == 1 then
					line = line .. {
						"It was only yesterday that Trunks came to the present, but you are still",
						"wary of Dr. Briefs' words: they could arrive at any moment."
					}
				else
					line = line .. {
						"It has been " .. hm_days .. " days since Trunks came to you. Every day that goes by is one",
						"less day left until the Androids arrive."
					}
				end
			end
			return line
		end
	end
	desc =
	{
	}
	level = 65
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_ANDROID_YOU"
	name = "You're an Android from the Future!"
	desc = function()
		if quest(QUEST_ANDROID_YOU).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yYou're an Android From the Future! (Level: 65)",
				"Trunks, the boy from the future, says that in a 'couple' days a future version",
				"of yourself is going to arrive with plans to steal a time machine and use it to",
				"bring back a pair of androids and destroy the earth! You've already convinced Dr",
				"Briefs to destroy the time machine, but even one psychotic suer-powerful android",
				"is more than enough. Also, Dr Briefs insists that the flow of time is not fixed,",
				"and the future is perpetually uncertain. Better be prepared for anything!"
			}
			return line
		end
	end
	desc =
	{
	}
	level = 65
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_ANDROID_PLANS"
	name = "Salvation!"
	desc =
	{
		"Perhaps there is information in Dr. Gero's secret laboratory pertaining to the",
		"Androids? He obviously knew how to build them...maybe he knew how to destroy",
		"them as well?"
	}
	level = 60
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_RETURN_TRUNKS"
	name = "Trunks"
	desc =
	{
		"Trunks, the boy from the future, is stranded in the current timeline with no way",
		"back. Dr Breifs has already destroyed his time machine. Is there any way to return",
		"Trunks to his own time?"
	}
	level = 60
	hooks =
	{
	}
}
