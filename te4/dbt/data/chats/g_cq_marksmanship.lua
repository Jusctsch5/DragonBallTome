-- dbt-generated-talk dialogue.CQ_MARKSMANSHIP
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.bear_thief and player.quests.bear_thief.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.bear_thief and player.quests.bear_thief.status == "taken"))) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[
Charleton: ]=] .. [=[(Quest completion not implemented)]=] .. [=[Hey, ]=] .. (player.name or "you") .. [=[! I sure would like to have a nice bearskin rug for my shop here at the range. I'd go and bag a bear myself, but I gotta stay and watch the shop. You're getting to be a good shot. How'd you like to hunt down a bear and drag her back for me to skin?

]=] end
		if which == [=[2]=] then return [=[
Charleton: ]=] .. [=[(Quest completion not implemented)]=] .. [=[Hey, ]=] .. (player.name or "you") .. [=[! I sure would like to have a nice bearskin rug for my shop here at the range. I'd go and bag a bear myself, but I gotta stay and watch the shop. You're getting to be a good shot. How'd you like to hunt down a bear and drag her back for me to skin?

]=] end
		if which == [=[]=] then return [=[
Charleton: ]=] .. [=[(Quest completion not implemented)]=] .. [=[Hey, ]=] .. (player.name or "you") .. [=[! I sure would like to have a nice bearskin rug for my shop here at the range. I'd go and bag a bear myself, but I gotta stay and watch the shop. You're getting to be a good shot. How'd you like to hunt down a bear and drag her back for me to skin?

]=] end
		return "..."
	end,
	answers = {
		{[=[I'd be delighted. In fact, I know just the bear.]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("taxidermy", "taken") end, cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Ok. I'll bring back a bear for you.]=], jump=[=[n0_a]=], action=function(npc, player) player:takeQuest("taxidermy", "taken") end, cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[No, bears are cuddly and cute. I wouldn't want to kill one.]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	player:takeQuest("taxidermy", "taken")
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = "...",
	answers = {
		{"[Leave]"},
	},
}

return "n0"
