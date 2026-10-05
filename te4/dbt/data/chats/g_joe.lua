-- dbt-generated-talk dialogue.JOE
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.aru_thugs and player.quests.aru_thugs.status == "finished") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.quests and player.quests.aru_thugs and player.quests.aru_thugs.status == "taken") then
		player:takeQuest("aru_thugs", "finished")
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (player.quests and player.quests.aru_thugs) then
		player:takeQuest("aru_thugs", "taken")
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.aru_thugs and player.quests.aru_thugs.status == "finished")) or ((player.quests and player.quests.aru_thugs and player.quests.aru_thugs.status == "taken")) or (not (player.quests and player.quests.aru_thugs))) then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Joe: ]=] .. [=[Hello! Good to see you again! Have you need of a carpenter?]=] end
		if which == [=[2]=] then return [=[
Joe: ]=] .. [=[You have defeated the thugs? Oh! Happy day! Thank you! Forgive me...I have no money to reward you with, but I am a carpenter by trade. Should you ever be in need of wood-working, please come to me and I will help you as best as I am able.

]=] .. [=[Joe: ]=] .. [=[You got one! Great! There's still the other one, though...]=] end
		if which == [=[3]=] then return [=[
Joe: ]=] .. [=[What a terrible place this is! I had heard good things about Aru Village, and came recently to settle, but when I arrived in the village I was attacked by two thugs! They beat me up and stole all my money. Fortunately there are houses to spare here, but after what happened I can't help but wonder what happened to the previous owners, and the local villagers won't talk about it. It's scary! The two thugs let me live, but I bet they've been killing people too! Why else would all these houses be empty? If something doesn't happen soon, I think I'll leave the village. It just isn't safe here.
]=] end
		if which == [=[4]=] then return [=[Error? Unknown Aru Thug quest status?]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
