-- dbt-generated-talk dialogue.WHINY_ARU
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if ((player.oolong_resolution or 0) > 2) or ((player.quests and player.quests.oolong and player.quests.oolong.status == "completed")) then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if player.female then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not ((((player.oolong_resolution or 0) > 2) or ((player.quests and player.quests.oolong and player.quests.oolong.status == "completed"))) or (player.female)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.quests and player.quests.oolong and player.quests.oolong.status == "taken") then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Oh no! Who are we going to mooch off of now??!?!]=] .. [=[*sigh* I guess I didn't expect the gravy train to last forever.]=] .. [=[At least I got some good jewelery out of all this.]=] end
		if which == [=[2]=] then return [=[Oh look...another bimbo here to mooch off of Oolong. Sorry missy...there are too many of us as it is. Get lost.

]=] .. [=[...what, another one? Look here, we can't have any more getting in on this! Oolong's rich, but if there are too any of us, sooner or later he's going to catch on. I say, we were here first. So get lost.

]=] .. [=[We know why you're here! Get lost! Sooner or later the camel's back is going to break, and every one of you newbies who come in make it all the more difficult for the rest of us. Go away! We dont want you here!

]=] end
		if which == [=[3]=] then return [=[At last! It's been HOURS since we ordered! What took you so- ...oh. You're not the caterer. You don't look like a manicurist, either. Oolong doesn't have any friends, so you're not here to see him...who are you? What are you doing here?

]=] .. [=[Hey...hey you! Servant! I need new bedsheets! Some idiot left a pea under my bed! ...what? What are you looking at me like that for?

]=] .. [=[Well, it's about time you showed up! You didn't really expect me to make my own bed, did you! Get to it! Lazy servants. Why...I should have you fired!

]=] end
		if which == [=[4]=] then return [=[Aru Villagess: ]=] end
		if which == [=[]=] then return [=[Aru Villagess: ]=] end
		return "..."
	end,
	answers = {
		{[=[Actually, I'm here to rescue you. Marcos from Aru said that Oolong was kidnapping village girls.]=], jump=[=[n0_b]=], cond=function(npc, player) return arm_n0(player) == [=[4]=] end},
		{[=[...hi. I'm just exploring...saw the castle, thought I'd check it out.]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Aru Villagess: ]=] .. [=[Eeeewwww! An adventurer? What a buzz kill! How yucky! Go away! We don't want you here!

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	if (player.oolong_quest_helper or 0) == 0 then
		player.oolong_quest_helper = 1
		shown_n0_b = [=[1]=]
		return shown_n0_b
	end
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		local which = arm_n0_b(player)
		if which == [=[1]=] then return [=[Aru Villagess: ]=] .. [=[WHAT!?!? Marcos...that...grr! Of course, he's so stupid, he probably even believes that! Every girl in the village would give her right arm to be here. Well, most of us anyway. Oolong is one rich pig! A wimpy little pushover, too, and we can get anything we want out of him! No, we're all doing very well thank you, so just go back home and tell Marcos to deal with it! Why...even if it weren't for Oolong, no girl in her right mind would be interested in such a self-involved, arogant nerf-herder like him anyway!

]=] end
		if which == [=[]=] then return [=[Aru Villagess: ]=] .. [=[WHAT!?!? Marcos...that...grr! Of course, he's so stupid, he probably even believes that! Every girl in the village would give her right arm to be here. Well, most of us anyway. Oolong is one rich pig! A wimpy little pushover, too, and we can get anything we want out of him! No, we're all doing very well thank you, so just go back home and tell Marcos to deal with it! Why...even if it weren't for Oolong, no girl in her right mind would be interested in such a self-involved, arogant nerf-herder like him anyway!

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
