-- dbt-generated-talk dialogue.SPLINTER_STORY
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.quests and player.quests.toxic_river and player.quests.toxic_river.status == "taken") then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.quests and player.quests.toxic_river and player.quests.toxic_river.status == "taken"))) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	player.splinter_story = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return (player.name or "you") .. [=[: ]=] .. [=[A strange, glowing ooze? Hmm. The container...what did it look like?

]=] .. [=[Master Splinter: ]=] .. [=[It was a cylinder, perhaps one foot long, bearing the letters 'Widget' on it. I do not know what this means.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I do. It's the name of the manufacturing plant near here. Sounds to me like they're dumping radioactive waste into the sewers here.

]=] .. [=[Master Splinter: ]=] .. [=[From the look on your face, I see this is a matter of great import. Yet, in our case, it seems that the end result has not been entirely unfortunate.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Maybe.

]=] end
		if which == [=[2]=] then return [=[Yes, perhaps I should tell you the tale of how we came to be here. Many years ago I was a rat of ordinary size. The pet, of the Ninja Master Hamato Yoshi. My cage was kept in his training hall, and from my earliest years I watched Master Yoshi during his training sessions.

]=] .. [=[Seven years ago, Master Yoshi was assassinated in his home by the leader of a rival ninja clan known as The Foot. During the fight, my cage was broken, and I was freed. For days I wandered alone, and hungry, until I came here to these sewers. It was here that I found four baby turtles crawling in a strange, glowing ooze from a broken canister.

]=] .. [=[Michaelangelo: ]=] .. [=[That was us!

]=] .. [=[Master Splinter: ]=] .. [=[But, strangely, over the days that followed, all five of us began to change...to grow. Both in size, as well as intellect. I do not know what brought about our change, but fate is not to be frowned upon. And so, I began training the turtles you see here before you in the art of Ninja. We have made a home for ourselves here in these sewers, venturing up to the surface only on occassion.

]=] end
		if which == [=[]=] then return [=[Yes, perhaps I should tell you the tale of how we came to be here. Many years ago I was a rat of ordinary size. The pet, of the Ninja Master Hamato Yoshi. My cage was kept in his training hall, and from my earliest years I watched Master Yoshi during his training sessions.

]=] .. [=[Seven years ago, Master Yoshi was assassinated in his home by the leader of a rival ninja clan known as The Foot. During the fight, my cage was broken, and I was freed. For days I wandered alone, and hungry, until I came here to these sewers. It was here that I found four baby turtles crawling in a strange, glowing ooze from a broken canister.

]=] .. [=[Michaelangelo: ]=] .. [=[That was us!

]=] .. [=[Master Splinter: ]=] .. [=[But, strangely, over the days that followed, all five of us began to change...to grow. Both in size, as well as intellect. I do not know what brought about our change, but fate is not to be frowned upon. And so, I began training the turtles you see here before you in the art of Ninja. We have made a home for ourselves here in these sewers, venturing up to the surface only on occassion.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
