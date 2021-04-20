-- Dragonball T: The starter Study quest

add_quest
{
	global = "QUEST_DOJO"
	name = "Choose a Style"
	desc = function()
		if quest(QUEST_DOJO).status == QUEST_STATUS_TAKEN then
			local line = {
				"#yChoose a Style",
				"Registration has begun for the World Tournament! You're excited about",
				"entering, but you've never actually studied martial arts. Ordinarily",
				"you wouldn't let a trivial little thing like that stop you, but since",
				"the World Tournament is for the best of the best, maybe you should at",
				"least take some classes before you register, right?"
			}
			return line
		end
	end
	level = 1
	hooks =
	{
		[hook.GAME_START] = function(new)
			if new == true then
				acquire_quest(QUEST_DOJO, true)
			end
		end
	}
}
