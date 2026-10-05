load("/data/general/npcs/races.lua")
newEntity{ base = "RACE_MEDITATING_MONK", define_as = "RACE_MEDITATING_MONK", faction = "neutral", ai = "none", never_move = true }
newEntity{ base = "RACE_KRILLAN", define_as = "RACE_KRILLAN", faction = "neutral", ai = "none", never_move = true, can_talk = "krillin" }
newEntity{ base = "RACE_CORRUPT_MONK_D", define_as = "RACE_CORRUPT_MONK_D", faction = "enemies", ai = "simple", never_move = false }
newEntity{ base = "RACE_CORRUPT_MONK_B", define_as = "RACE_CORRUPT_MONK_B", faction = "enemies", ai = "simple", never_move = false }
newEntity{ base = "RACE_CORRUPT_MONK_C", define_as = "RACE_CORRUPT_MONK_C", faction = "enemies", ai = "simple", never_move = false }
newEntity{ base = "RACE_CORRUPT_MONK_A", define_as = "RACE_CORRUPT_MONK_A", faction = "enemies", ai = "simple", never_move = false }
newEntity{ base = "RACE_MONK_RINGLEADER", define_as = "RACE_MONK_RINGLEADER", faction = "enemies", ai = "simple", never_move = false, dbt_quest = "temple" }
newEntity{ base = "RACE_ABBOT", define_as = "RACE_ABBOT", faction = "neutral", ai = "none", never_move = true, can_talk = "abbot" }
