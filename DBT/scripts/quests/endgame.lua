-- Dragonball T: End game quests

add_quest
{
	global = "QUEST_FREEZA"
	name = "A Cold Future for Earth"
	desc =
	{
		"The most evil and notorious villain in the galaxy, Freeza, has shown",
		"up on earth. His plan? To exterminate all life on the planet, and then",
		"sell it at auction to the highest bidder. Unfortunately for you, Freeza",
		"is not only a notorious villain, he is also a superhuman mutant, has a",
		"rather large band of ruffians at his beckon call, and happens to be an",
		"insanely powerful fighter. This is not good.",
	}
	level = 60
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_CELL"
	name = "Cell"
	desc =
	{
		"It seems that Dr. Gero had one last secret creation: the Bio-Android. This",
		"creature is crafted from the DNA of the worlds best fighters, and has the",
		"ability to absorb the life and power of any living being and integrate",
		"it into himself, thus becoming stronger. With every passing day, Cell",
		"absorbs the life and DNA of hundreds of creatures. You must find a way to",
		"defeat him before he becomes...invincible.",
	}
	level = 70
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_CELL_GAMES"
	name = "Cell Games"
	desc =
	{
		"The Bio Android, Cell, has challenged the worlds fighters to a duel, with",
		"the earth as the prize to the winner! Cell says he will destroy the planet",
		"if no one is able to defeat him in combat. You must try.",
	}
	level = 70
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_ANAMOLY"
	name = "Spatial Anamoly"
	desc = function()
		if quest(QUEST_ANAMOLY).status == QUEST_STATUS_TAKEN then
			local line = {}
			if dball_data.spacecraft_quest_status == 0 then
				line = {
					"#ySpatial Anamoly (Level: 75!)",
					"You've discovered evidence of a gravitational anamoly in orbit around the",
					"planet. Visual instruments reveal no objects, and Dr Gero's notes contain",
					"only speculation as to probably causes. According to the automated tracking",
					"system, this anamoly is curently located in sector 5:6, near earth."
				}
			elseif dball_data.spacecraft_quest_status == 1 then
				line = {
					"#ySpatial Anamoly (Level: 75!)",
					"Proximity alert sensors on your ship have warning of an object of approximately",
					"200 megatons in sector 5:6, near earth. You see nothing on your screen, but it",
					"would probably be best to investigate. You don't want to crash into something",
					"that large."
				}
			elseif dball_data.spacecraft_quest_status == 2 then
				line = {
					"#yMysterious Spacecraft (Level: 75!)",
					"You have discovered a massive spacecraft under cloak, in orbit near earth."
				}
			end
			return line
		end
	end
	level = 75
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_MAJIN_BUU"
	name = "Mighty Majin"
	desc =
	{
		"The wizard Babidi has conjured up Buu, the demon responsible for the",
		"destruction of one third of the populated worlds in this galaxy. Even",
		"Kami feared this demon, and rightfully so. Somehow, though, it has",
		"fallen on you to stop him.",
	}
	level = 80
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_EVIL_BUU"
	name = "Two Buud For You"
	desc =
	{
		"After the incident with the puppy, the demon Buu divided himself up",
		"into two separate and distinct personalities, one good, the other",
		"very...very bad. While the good one is sitting at home eating",
		"cheesy-poofs, the bad one is running amuck, destroying Earth,",
		"just as the fully integrated Buu had destroyed countless worlds.",
		"You must stop him. Somehow.",
	}
	level = 100
	hooks =
	{
	}
}

