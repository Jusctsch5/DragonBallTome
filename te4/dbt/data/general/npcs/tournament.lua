load("/data/general/npcs/earth.lua")

local function spectator(base, id, chat)
	return { base = base, define_as = id, can_talk = chat, faction = "neutral", ai = "none", never_move = true }
end

newEntity(spectator("RACE_WT_TICKET_GIRL", "WT_TICKET", "wt-ticket"))
newEntity(spectator("RACE_WT_GUARD", "WT_GUARD", "wt-guard"))
newEntity(spectator("RACE_WT_BACKSTAGE_GUY", "WT_BACKSTAGE", "wt-backstage"))
newEntity(spectator("RACE_WT_MEDIC", "WT_MEDIC", "wt-medic"))
newEntity(spectator("RACE_WT_AUDIENCE_BLUE", "WT_CROWD_BLUE", "wt-audience"))
newEntity(spectator("RACE_WT_AUDIENCE_GREEN", "WT_CROWD_GREEN", "wt-audience"))
newEntity(spectator("RACE_WT_AUDIENCE_YELLOW", "WT_CROWD_YELLOW", "wt-audience"))
