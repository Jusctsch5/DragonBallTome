-- The various "Members Only" Quests
-- (These aren't exactly quests...but they show up on the quest log
-- to make the players life easier

-- Gym	: Complete
-- Library	: Complete
-- Pilot	: Functional, but at present you can't 'fail' if you don't keep up payments

add_quest
{
	global = "QUEST_GYMMEMBER"
	name = "Working Out is Good for the Body"
	desc =
	{
		"Sure, everyone is a member of a gym, but how many people actually go",
		"work out? If you do, you're more likely to get stronger than if you",
		"don't.",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_LIBRARYMEMBER"
	name = "Reading is Good for the Mind"
	desc =
	{
		"Now that you're a member of the library, you should probably go read",
		"every now and then to help expand your knowledge.",
	}
	level = 1
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_PILOTMEMBER"
	name = "Pilot's Club and Hanger Rental"
	desc = function()
		if quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_TAKEN then
			local line = {}
			local days_left = dball_data.hanger_start_date + dball_data.hanger_rental - dball.dayofyear()
			if days_left > 0 then
				line = {
					"#yPilot's Club and Hanger Rental (Membership)",
					"You are a member of the Pilot's Club." ..
					-- hook.print("Your membership expires on " ..  .. "\n",
					"Your membership is good for " .. days_left .. " more days."
				}
			else
				line = {
					"#####yPilot's Club and Hanger Rental (Membership)",
					"You are a member of the Pilot's Club, but your membership fees are past due.",
					"You'd better hurry and catch up on your payements, or everything you have",
					"in storage is liable to be auctioned off!"
				}
			end
			return line
		elseif quest(QUEST_PILOTMEMBER).status == QUEST_STATUS_FAILED then
			local line = {
				"#yPilot's Club and Hanger Rental (Membership)",
				"You are a former member of the Pilot's Club, but your membership has expired."
			}
			return line
		end
	end
	level = 1
	hooks =
	{
	}
}
