-- dbt-generated-talk dialogue.JOESEPHINE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.rosshi_lonely and player.quests.rosshi_lonely.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[
Joesephine: ]=] .. [=[Well, look who it isn't. I remember you. You're the idiot who convinced that rich pig to send all of us moochers away. Don't think I haven't forgotten. Because of you I've had to go back to working for a living. I'm a seamstress by trade, but not because I want to be. I can repair clothing, and reinforce cloth armors with extra sturdy padding. And...just because I hate you so much, I'm going to charge you ten times what I'd charge anyone else. That's what you get.

]=] end
		if which == [=[]=] then return [=[
Joesephine: ]=] .. [=[Well, look who it isn't. I remember you. You're the idiot who convinced that rich pig to send all of us moochers away. Don't think I haven't forgotten. Because of you I've had to go back to working for a living. I'm a seamstress by trade, but not because I want to be. I can repair clothing, and reinforce cloth armors with extra sturdy padding. And...just because I hate you so much, I'm going to charge you ten times what I'd charge anyone else. That's what you get.

]=] end
		return "..."
	end,
	answers = {
		{[=[(Not implemented, waiting on engine) Well, if you're really looking to find a man so you don't have to work for a living, I happen to have a friend I could introduce you to. He lives on an island near hear, and trust me...he's absolutely the most physically fit 300 year old you're ever going to meet!]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Hrrm.]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

return "n0"
