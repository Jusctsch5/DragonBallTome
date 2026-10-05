load("/data/general/npcs/races.lua")

local function resident(id, name, chat)
	newEntity{
		base = id,
		define_as = name,
		faction = "neutral",
		ai = "none",
		never_move = true,
		can_talk = chat,
	}
end

resident("RACE_SPLINTER", "SPLINTER", "splinter")
resident("RACE_LEONARDO", "LEONARDO")
resident("RACE_DONATELLO", "DONATELLO")
resident("RACE_MICHAELANGELO", "MICHAELANGELO")
resident("RACE_RAPHAEL", "RAPHAEL")
