-- Totally miscellaneous quests

add_quest
{
	global = "QUEST_MOUNTAIN_LIONS"
	name = "Mountain Lions"
	desc =
	{
		"You've found lions in the mountains. You've no idea how many there are,",
		"but it might make travel a bit safer if you were to get rid of them.",
	}
	level = 17
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_TOXIC_RIVER"
	name = "Toxic River"
	desc = function()
		if quest(QUEST_TOXIC_RIVER).status == QUEST_STATUS_TAKEN then
			local line = {}

			if dball_data.toxic_quest_desc == 0 then
				line = {
					"#yToxic River (Danger level: 7)",
					"You've found what appears to be river of toxic sludge draining out of a",
					"manufacturing plant and feeding directly into the city sewers. Even just",
					"standing near it makes you nauseous, and the numerous dead trees in the",
					"area is a testament to the effect it's having on the local environment.",
					"Perhaps you could do something about it?"
				}
			elseif dball_data.toxic_quest_desc == 1 then
				line = {
					"#yToxic River (Danger level: 7)",
					"Widget Co. completely denies that their manufacturing process creates any",
					"problem, and they've suggested that they might have you arrested if you",
					"continue investigation. The creepy thing is that they probably really are",
					"adhering to the regulations. At least, on the surface. Maybe you could find",
					"more evidence of wrong doing?"
				}
			elseif dball_data.toxic_quest_desc == 2 then
				line = {
					"#yToxic River (Danger level: 7)",
					"Widget Co. completely denies that their manufacturing process creates any",
					"problem, but judging from their reaction when you confronted them on it,",
					"it's obvious that they know they're creating problems. Still, it's a large",
					"corporation and they probably really are adhering to regulations, however",
					"lax they may be. Maybe you could find more definitive evidence to use against",
					"them?"
				}
			elseif dball_data.toxic_quest_desc == 3 then
				line = {
					"#yToxic River (Danger level: 7)",
					"You've spoken with customer relations at Widget Co., and he has explained",
					"that their company completely conforms to all the relevant regulations. So",
					"that makes it ok, right?"
				}
			elseif dball_data.toxic_quest_desc == 4 then
				line = {
					"#yToxic River (Danger level: 7)",
					"You've shown a nuclear waste canister found in the sewers to the Widget",
					"Co. representative but they're still playing innocent. Apparently you",
					"need to not only demonstrate their pollution, but also that it has negative",
					"effects."
				}
			elseif dball_data.toxic_quest_desc == 5 then
				line = {
					"#yToxic River (Danger level: 7)",
					"You've reported the claims of Splinter that he and his turtles were",
					"mutated by nuclear waste, but the Widget Co. representative insists",
					"there must be some other cause. Maybe if you were to find an",
					"incriminating canister?"
				}
			end
			return line
		end
	end
	level = 7
	hooks =
	{
	}
}

add_quest
{
	global = "QUEST_ESCAPE_FROM_HELL"
	name = "Escape from Hell!"
	desc =
	{
		"As the greeter demons say 'Welcome to Hell!' But, surely there is a way out?",
		"Can you find it?",
	}
	level = 40
	hooks =
	{
	}
}
