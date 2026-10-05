-- dbt-generated-talk dialogue.KAMI_RESSURECT
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.kami_state or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if not (((player.kami_state or 0) == 0)) then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[You ]=] .. [=[find yourself standing in an opulent room standing before Demon King Piccolo, who sits at a regal throne.

]=] .. [=[Demon King Piccolo: ]=] .. [=[You are a most troublesome person. I do hope I made the right decision in bringing you here.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Why have you brought me here? Why did you spare my life?

]=] .. [=[Demon King Piccolo: ]=] .. [=[An excellent question...and a mistaken one. You are not alive. 

]=] .. (player.name or "you") .. [=[: ]=] .. (player.name or "you") .. [=[: ]=] .. [=[You've answered one question. What of the other? Why am I here?

]=] .. [=[Demon King Piccolo: ]=] .. [=[Hmph. Troublesome and rude besides. I've kept you here on earth so you can fix the mess youv'e created by releasing Demon King Piccolo from his trappings.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[You want me to trap you in the rice cooker again? Yeah, I'm ok with that.

]=] .. [=[Demon King Piccolo: ]=] .. [=[No, you fool. Not me, Piccolo.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Umm, I'm confused. Aren't you Piccolo? You look just like him.

]=] .. [=[Demon King Piccolo...or maybe...Kami?: ]=] .. [=[No. I am the God of this earth. Piccolo and I look the same because we are the same...the same flesh, the same blood.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[How was I supposed to know there'd be a demon in a rice cooker? Seriously...who's idea was that?

]=] .. [=[Kami: ]=] .. [=[Did you not see the seals?!!? Did you expect to find nothing but crunchy old rice inside?!?!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Ahh. Seals. I do remember something about some seals. A certain feeling of foreboding and dread. Right.

]=] .. [=[Kami: ]=] .. [=[What you have done, you must undo. You have released a demon into the world, and you must remove him from it again.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Why me, exactly? I mean...I appreciate the, umm...offer, but aren't you God? Aren't you far more qualified to fix this than I am?

]=] .. [=[Kami: ]=] .. [=[I am merely the guardian of this world. There are countless powers above me, and it is not my place to act in this matter. I can, however, serve as a guide and teacher to those who may act.

]=] end
		if which == [=[2]=] then return [=[Kami: ]=] .. [=[Hello again ]=] .. (player.name or "you") .. [=[. It is a pleasure to see you again, though I really would prefer that the circumstances be different.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Hello, Kami. What happened? What am I doing here? I was fighting a horrible creature that looked just like you.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
