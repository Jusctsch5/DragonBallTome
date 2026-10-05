-- dbt-generated-talk dialogue.TRUNKS_EARLY
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.alignment or 0) >= 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[You are engulfed in the midst of a ball of energy!]=] .. [=[Trunks: ]=] .. [=[NOOOOOO!!!! STOP! I WON'T LET YOU DO IT!!!

]=] .. [=[Following the scream, you turn to see a teenage boy with platinum blonde hair, and wearing a large sword on his back, rushing towards you.

]=] .. [=[Trunks: ]=] .. [=[You monster! How could you do this?!?!?!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What are you talking about? Do what?

]=] .. [=[Trunks: ]=] .. [=[Don't play dumb! I know you stepped into that one way time machine and I know you're here to use Briefs' time machine to bring your android friends here to destroy the world!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Time machine? Android friends? What are you talking about?

]=] .. [=[Trunks: ]=] .. [=[Don't play dumb! You're a time traveller and I know perfectly well you're here to repair Dr. Briefs' time machine! I bet you even have the materials on you right now to do it!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What, these? Sure, I have some wire and solder...but how does that make me a time traveller?

]=] .. [=[Trunks: ]=] .. [=[Aha! So you admit it! You've never even spoken to Dr Briefs, or seen his time machine! So how could you know exactly what's needed to repair it if you're not a time traveller?!?!?

]=] end
		if which == [=[]=] then return [=[You are engulfed in the midst of a ball of energy!]=] .. [=[Trunks: ]=] .. [=[NOOOOOO!!!! STOP! I WON'T LET YOU DO IT!!!

]=] .. [=[Following the scream, you turn to see a teenage boy with platinum blonde hair, and wearing a large sword on his back, rushing towards you.

]=] .. [=[Trunks: ]=] .. [=[You monster! How could you do this?!?!?!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What are you talking about? Do what?

]=] .. [=[Trunks: ]=] .. [=[Don't play dumb! I know you stepped into that one way time machine and I know you're here to use Briefs' time machine to bring your android friends here to destroy the world!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Time machine? Android friends? What are you talking about?

]=] .. [=[Trunks: ]=] .. [=[Don't play dumb! You're a time traveller and I know perfectly well you're here to repair Dr. Briefs' time machine! I bet you even have the materials on you right now to do it!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[What, these? Sure, I have some wire and solder...but how does that make me a time traveller?

]=] .. [=[Trunks: ]=] .. [=[Aha! So you admit it! You've never even spoken to Dr Briefs, or seen his time machine! So how could you know exactly what's needed to repair it if you're not a time traveller?!?!?

]=] end
		return "..."
	end,
	answers = {
		{[=[...]=], jump=[=[n0_a]=], cond=function(npc, player) return arm_n0(player) == "" end},
		{[=[Hahahah! Yes! Bring them on! Androids! Androids!]=], jump=[=[n0_b]=], action=function(npc, player) player.trunks_hunt = 1 end, cond=function(npc, player) return arm_n0(player) == "" end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Trunks: ]=] .. [=[This is it for you!

]=] .. [=[Trunks draws his sword.

]=],
	answers = {
		{[=[No, we don't need to fight. I don't really want to bring the androids here.]=], jump=[=[n0_a_a]=], action=function(npc, player) player:takeQuest("android_you", "taken") player:takeQuest("return_trunks", "taken") player.ttq_tripped = 2 end},
		{[=[Ok. I'll fight you, blondie.]=], jump=[=[n0_a_b]=], action=function(npc, player) player.trunks_hunt = 1 end},
		{"[Leave]"},
	},
}

local shown_n0_a_a = nil
local function arm_n0_a_a(player)
	if shown_n0_a_a ~= nil then return shown_n0_a_a end
	player:takeQuest("android_you", "taken")
	player:takeQuest("return_trunks", "taken")
	player.ttq_tripped = 2
	shown_n0_a_a = [=[]=]
	return shown_n0_a_a
end
newChat{ id=[=[n0_a_a]=],
	text = function(npc, player)
		arm_n0_a_a(player)
		return [=[Trunks: ]=] .. [=[You...don't...?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[No.

]=] .. [=[Trunks: ]=] .. [=[That's a relief. I wasn't certain I could beat you. From what I've been told about you, you're a very powerful android. Though...I wouldn't have known it from looking at you. You look awfully weak. I guess you must be supressing your power to blend in.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...umm...right.

]=] .. [=[Trunks: ]=] .. [=[You really don't want to bring the other androids to the past?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Nope. Not one bit.

]=] .. [=[Trunks: ]=] .. [=[I'm not sure I believe you, but if you really don't want to bring your friends here then my mission is done. All I had to do was stop you. Tell you what...if you're really serious about not wanting to destroy the earth, then help me talk to my grandfather.

]=] .. [=[Trunks: ]=] .. [=[Dr. Briefs!

]=] .. [=[Dr Briefs: ]=] .. [=[Oh. Hello, youngster. What can I do for you?

]=] .. [=[Trunks: ]=] .. [=[You can destroy your time machine!

]=] .. [=[Dr Briefs: ]=] .. [=[Destroy my...whatever for?

]=] .. [=[Trunks glances at you.

]=] .. [=[Trunks: ]=] .. [=[I know this is going to be difficult to explain, but I'm...your grandson. Me and ]=] .. (player.name or "you") .. [=[ here are both from the future.

]=] .. [=[Over the next few hours Trunks explains a very complicated tale. It seems that he is from a future timeline in which you, ]=] .. (player.name or "you") .. [=[, are an adventurer who was transformed into a biomechanical android by the evil genius behind the Red Ribbon army, Dr Gero. Under his control, you and two other androids ran rampant across the globe, killing people in all corners of the world.

]=] .. [=[Eventually earths greatest fighter rose together to oppose you, and destroyed the other two of your trio. Enraged, but unable to defeat them on your own, you swore to travel to an earlier time and bring your android friends with you to destroy the earth before the fighters who eventually defeated you had been born.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Wait. I'm confused. If that's what happens, why would I be here now?

]=] .. [=[Trunks: ]=] .. [=[We tracked you down after that last battle, the time machine that you used wasn't portable. It could only be set to a specific time, and once you went in, it was a one way trip. We checked the date you went to, now, and realized you must have come to repair and steal Dr Brief's time machine, to use to recover the other Androids.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[So you came after me?

]=] .. [=[Trunks: ]=] .. [=[Yes. I figured I could destroy the time machine myself, but now that you've changed your mind and don't want to use it, I can use it myself to travel back to my own time.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Wait...you stepped into that time machine right after I did, right?

]=] .. [=[Trunks: ]=] .. [=[Well...I'm not sure, exactly. The machine was set to relative, not absolute time, so anyone who stepped into it would be sent back 17 years, three days, five hours back. But, we didn't know exactly when you went in, so there was no way to know exactly what time you were sent to. So we just subtracted a couple days and figured I'd get here before you did. Since you had already managed to gather the materials to repair the time machine when I got here, I guess we miscalculated.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[This is not good.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[I'm not the android you're after.

]=] .. [=[Trunks: ]=] .. [=[...what?

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Remeber that there had to have been a 'me' before I was transformed by Dr Gero? I'm that me! I haven't even met Dr Gero!

]=] .. [=[Trunks: ]=] .. [=[So that means...

]=] .. (player.name or "you") .. [=[: ]=] .. [=[That other 'me' android is stil out there someplace!

]=] .. [=[Dr Briefs: ]=] .. [=[Maybe ]=] .. [=[ hasn't arrived yet. Trunks, how many days back did you set the time machine before you used it?

]=] .. [=[Trunks: ]=] .. [=[Umm...I'm not sure. I was standing in the chamber when Piccolo adjusted the controls.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[...Piccolo...?

]=] .. [=[Trunks: ]=] .. [=[Yes. He said 'a couple days' but I didn't ask exactly how many. We were kind of in a rush.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[So how many is 'a couple?' Two? Three? Seven?

]=] .. [=[Trunks: ]=] .. [=[Yeah...something like that.

]=] .. [=[Dr Briefs: ]=] .. [=[So in 'two or three to seven days' an evil nasty ]=] .. (player.name or "you") .. [=[ android is going to show up and try to fix and steal my time machine.

]=] .. [=[He pulls out a short wave atomitizer and makes fast work of what's left of his time machine.

]=] .. [=[Trunks: ]=] .. [=[...but what about me!?!?

]=] .. [=[Dr Briefs: ]=] .. [=[I'm sorry. I know you were counting on this to get you back, but the fate of the entire planet is at stake.

]=] .. [=[Trunks is silent.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_a_b = nil
local function arm_n0_a_b(player)
	if shown_n0_a_b ~= nil then return shown_n0_a_b end
	player.trunks_hunt = 1
	shown_n0_a_b = [=[]=]
	return shown_n0_a_b
end
newChat{ id=[=[n0_a_b]=],
	text = function(npc, player)
		local which = arm_n0_a_b(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_b = nil
local function arm_n0_b(player)
	if shown_n0_b ~= nil then return shown_n0_b end
	player.trunks_hunt = 1
	shown_n0_b = [=[]=]
	return shown_n0_b
end
newChat{ id=[=[n0_b]=],
	text = function(npc, player)
		arm_n0_b(player)
		return [=[Trunks: ]=] .. [=[NO!!! I won't let it happen! Not again!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
