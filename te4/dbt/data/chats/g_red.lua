-- dbt-generated-talk dialogue.RED
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.rra_hq_state or 0) ~= 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.rra_shq_cam or 0) == 1 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if not (((player.rra_shq_cam or 0) == 1)) then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.rra_shq_cam or 0) == 0 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	player.rra_hq_state = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...but, there is more:

]=] .. [=[Commander Red: ]=] .. [=[...Adjutant...you've been my confidant all of these years. I think I'd like confide something in you that I...well, that I've kept to myself. Can I trust you?

]=] .. [=[Adjutant Black: ]=] .. [=[Absolutely, sir!

]=] .. [=[Commander Red: ]=] .. [=[Well, it's about the Dragonballs. As you know, when I first heard about the Dragonballs and set out to gather them up, I knew I'd need help and all...so that's why I put together the army. But really, no one's ever actually asked me what I was going to wish for.

]=] .. [=[Adjutant Black: ]=] .. [=[Well, sir, I think the men have always assumed that a great man like you had great ambitions. In fact, you've often mentioned the 'height' of your ambitions.

]=] .. [=[Commander Red: ]=] .. [=[...yes, but...

]=] .. [=[Adjutant Black: ]=] .. [=[...and so I think it's always simply been understand that you had the highest ambition in mind for us, to build an army and RULE THE WORLD!!! HAHAHAHA!!!!

]=] .. [=[Commander Red: ]=] .. [=[Umm...no, that's not it.

]=] .. [=[Adjutant Black: ]=] .. [=[HAHAHAHAHA...oh, no? It isn't...?

]=] .. [=[Commander Red: ]=] .. [=[No. I was being literal about the 'height' of my ambitions. That IS my ambition: Height. I've always wished I could be taller so girls would like me.

]=] .. [=[Adjutant Black: ]=] .. [=[...you...what...?

]=] end
		if which == [=[2]=] then return [=[As you approach the door, you hear a conversation taking place on the other side:

]=] .. [=[Adjutant Black: ]=] .. [=[Yes, sir. It appears that our covert operation was extremely succesful.

]=] .. [=[Commander Red: ]=] .. [=[That's all well and good, but I'm more concerned about our intruder. How far has ]=] .. [=[ progressed?

]=] .. [=[Adjutant Black: ]=] .. [=[I'm sorry sir. It's impossible to say, now that the internal security system has been destroyed. It's possible ]=] .. [=[ could be outside our door right now.

]=] .. [=[Commander Red: ]=] .. [=[This isn't good. Oh, I do so wish our troops would hurry up and find the remaining Dragonballs so I could make my wish and be done with it.

]=] .. [=[Adjutant Black: ]=] .. [=[Yes, sir! And then the Red Ribbon Army shall RULE THE WORLD!!! HAHAHAHAHA!!!!

]=] end
		if which == [=[3]=] then return [=[As you approach the door, you hear a frantic conversation taking place on the other side:

]=] .. [=[Adjutant Black: ]=] .. [=[Commander! The intruder has passed all of our defenses! He's right outside the door?

]=] .. [=[Commander Red: ]=] .. [=[WHAT!?!?! Already?!?!

]=] .. [=[Adjutant Black: ]=] .. [=[I'm afraid so, sir.

]=] .. [=[Commander Red: ]=] .. [=[...all our forces...all that money I spent on interior design...all destroyed...

]=] .. [=[Adjutant Black: ]=] .. [=[Don't worry, sir. There's still the two of us. And we do still have the slush fund.

]=] end
		if which == [=[4]=] then return [=[Commander Red: ]=] .. [=[Alright, Adjutant...time to defend the Red Ribbon Army! Lock and load!

]=] .. [=[Adjutant Black: ]=] .. [=[...but..sir...umm...

]=] end
		if which == [=[]=] then return [=[...but, there is more:

]=] .. [=[Commander Red: ]=] .. [=[...Adjutant...you've been my confidant all of these years. I think I'd like confide something in you that I...well, that I've kept to myself. Can I trust you?

]=] .. [=[Adjutant Black: ]=] .. [=[Absolutely, sir!

]=] .. [=[Commander Red: ]=] .. [=[Well, it's about the Dragonballs. As you know, when I first heard about the Dragonballs and set out to gather them up, I knew I'd need help and all...so that's why I put together the army. But really, no one's ever actually asked me what I was going to wish for.

]=] .. [=[Adjutant Black: ]=] .. [=[Well, sir, I think the men have always assumed that a great man like you had great ambitions. In fact, you've often mentioned the 'height' of your ambitions.

]=] .. [=[Commander Red: ]=] .. [=[...yes, but...

]=] .. [=[Adjutant Black: ]=] .. [=[...and so I think it's always simply been understand that you had the highest ambition in mind for us, to build an army and RULE THE WORLD!!! HAHAHAHA!!!!

]=] .. [=[Commander Red: ]=] .. [=[Umm...no, that's not it.

]=] .. [=[Adjutant Black: ]=] .. [=[HAHAHAHAHA...oh, no? It isn't...?

]=] .. [=[Commander Red: ]=] .. [=[No. I was being literal about the 'height' of my ambitions. That IS my ambition: Height. I've always wished I could be taller so girls would like me.

]=] .. [=[Adjutant Black: ]=] .. [=[...you...what...?

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
