-- Dragonball T: The Dialogues!

-------------------------------------------
-------------------------------------------
---- Pretty much completely not implemented
-------------------------------------------
-------------------------------------------
function dialogue.DTEST()
	term.gotoxy(0, 0)
	term.save()
	term.text_out(color.LIGHT_BLUE, "Monk: ")
	term.text_out("Hello. Welcome to Orinji Temple. What can I do for you?\n\n")
	-- dialogue.conclude()
	term.load()
end

function dialogue.YAJIROBE()
	term.gotoxy(0, 0)
	if dball.current_location() == "World Tournament" then
		message("He is too focused on cutting you to ribbons to say much.")
	end

	message("Implement me!")

end
function dialogue.DABURA()
	term.gotoxy(0, 0)
	message("Implement me!")
end
function dialogue.HILDEGARN()
	message("Implement me!")
end
function dialogue.SHREDDER()

	-- Redundant, but just in case
	quest(QUEST_BEING_WATCHED).status = QUEST_STATUS_COMPLETED

	term.gotoxy(0, 0)
	-- 0 = no formal contact
	-- 1 = spoken with greeter, agreed to speak
	-- 2 = spoken with shredder, neutral
	-- 3 = spoken with shredder, aligned (pending quest, right?)
	-- 4 = spoken with shredder, aligned and allow training
	-- 5 = player is leader of clan
	-- 999 = aggressive(sort of)
	if dball_data.foot_clan_rapport == 0 or dball_data.foot_clan_rapport == 1 then
		-- First contact
		dball_data.foot_clan_rapport = 2
		-- Shredder is only interested in certain player classes
		local foo = player.determine_class()

		term.save()

		if enrollments[FLAG_NINJUTSU] > 0 or foo == "Spiritualist" then
			-- Instant access
			term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
			term.text_out("Welcome, " .. player_name() .. ". I have been expecting you.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Forgive the cliche, but how do you know my name?\n\n")
			term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
			term.text_out("I know much about you. My eyes and ears have been abroad, watching, searching for one such as you. ")
			if enrollments[FLAG_NINJUTSU] > 0 then
				term.text_out("You have learned much of the art of ninja from Grandmaster Hatsumi, but there is much still for you to learn. He has held back much from you. Much that I could teach you.\n\n")
				dialogue.helper("I will train with you.", "a")
			else
				term.text_out("You and I are of a rare breed. One of the elect who learns to master not only the body, but also the mind and spirit as well. You are a powerful soul, and are are worthy of a place here. There is much we can learn from one another. Join me, and let us seek to perfect ourselves.\n\n")
				dialogue.helper("I accept.", "a")
			end
			dialogue.helper("No. Your offer intrigues me, but it is one I cannot accept.", "b")
			dialogue.helper("No. I have come to kill you, and I shall not be persuaded to abandon the task at hand.", "c")
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Excellent. Let us begin at once.\n\n")
				dialogue.conclude()
				dball_data.foot_clan_rapport = 4
				dball.enroll(FLAG_ENROLL_SHREDDER)
			elseif ans == "b" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Very well. Though it is unfortunate. Our paths might have remained mingled, but it is not to be. We are not friends, yet neither must we be enemies. I will have my guards escort you out. Do not return to this place, do not interfere with us, and we shall trouble you no more.\n\n")
				dialogue.conclude()
				dball_data.foot_clan_rapport = 2
				dball_data.teleport_dungeon = 12
				dball.planetary_teleport_helper("Earth")
			elseif ans == "c" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Then your fate is sealed. So be it.\n\n")
				dialogue.conclude()
				dialogue.FOOT_FIGHT_HELPER()
			end
			return
		elseif foo == "MartialArtist" then
			-- Have to complete a quest to gain access
			term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
			term.text_out("Welcome, " .. player_name() .. ". I have been expecting you.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Forgive the cliche, but how do you know my name?\n\n")
			term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
			term.text_out("My students cross-train at all of the major martial arts schools in the area. Not only does it expose them to the fighting styles of those who will oppose them, it also keeps me informed of potential enemies...as well as potential allies.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I see. And which do you take me for?\n\n")
			if player.lev > 20 then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("As my servant informed you, we of The Foot respect strength, and you have demonstrated yourself to possess it. It is unfortunate that you have not received proper instruction up until now, but this is a minor inconvenience for one such as I. ")
			else
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("You are not skilled enough to be any threat as an enemy. Nor to be particularly useful as an ally. However, with the proper training, perhaps someday you might grow to become useful. ")
			end
			term.text_out("I am a master like none you have seen. If you are willing and able to...prove yourself, I may be willing to accept you as a student. Does this interest you?\n\n")
			dialogue.helper("Train with you? What must I do to prove myself?", "a")
			dialogue.helper("No. Your offer intrigues me, but it is one I cannot accept.", "b")
			dialogue.helper("No. I have come to kill you, and I shall not be persuaded to abandon the task at hand.", "c")
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("The art of ninja is the highest path to the perfection of self. We strengthen not only our bodies, but also our minds and spirit. We augment our abilities with tools. We aspire to the greatest goal: enlightenment. However, there are those who do not share our goals. Those who seek to corrupt. Those who seek to shorten the path of ascension through artificial means.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Who?\n\n")
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Many are those who try to cheat spirit, but my spies have recently uncovered an especially grevious situation. The Widget factory to the south of here has been dumping radioactive waste into the city sewers. This has had disastrous consequences of the natural environment, and a number of lesser creatures have become corrupt, unnatural horrible beasts. They must be destroyed.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("You want me to kill mutants in the sewers?\n\n")
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("There is one mutant in particular I wish you to destroy.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("I have recently captured four humanoid turtle mutant who have been blasphemously trained in the art of Ninja. They have been reluctant to speak, but I have gathered that their master is another mutant. A rat that calls itself 'Splinter.' This unnatural abomination must be cleansed from the earth. Find the lair of this creature, and destroy it. Do this, and I will train you in the art of Ninja.\n\n")
				if dball_data.splinter_state == 0 then
					dialogue.helper("Very well. I will destroy this creature.", "a")
					dialogue.helper("I don't think this is a task I can accept.", "b")
				else
					dialogue.helper("Yes, I will destroy this creature. I think I know exactly where to look.", "a")
					dialogue.helper("Splinter? The rat? I've met him. You've captured the turtles?", "c")
				end
				dialogue.conclude()
				term.load()
				term.save()
				dball_data.foot_clan_rapport = 3
				acquire_quest(QUEST_KILL_SPLINTER)
			elseif ans == "b" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Very well. I should not be surprised that you do not understand the enormity of what I offer. But know that the offer will not be made again. I will honor our agreement, and have one of my minions escort you out. While you are not our enemy, neither have you chosen to become our ally. Do not return to this place. Do not interfere with us. Do these things, and we will allow you to live.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				dball_data.foot_clan_rapport = 2
				dball_data.teleport_dungeon = 12
				dball.planetary_teleport_helper("Earth")
			elseif ans == "c" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Then you are a fool.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				dialogue.FOOT_FIGHT_HELPER()
			end
			return
		else
			if foo == "Wannabe" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("Never have I seen such a pathetic excuse of a creature as you. How could one such as you have possibly made it past my guards? Obviously our training efforts have gone soft.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("...uhh, nice to meet you too.\n\n")
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("You are worthless and pathetic. I would be remiss in my service to this world if I did not remove you from it immediately. Prepare to die.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			else
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("So you have found our hidden lair. I am not surprised, but I am disgusted.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Disgusted? Why?\n\n")
			end

			if foo ~= "Wannabe" then
				term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
				term.text_out("All of your kind disgust me. We of the ninja have always embraced technology. But some, such as you, take it too far. Technology is a tool for our use. Man was not meant to serve the machine.\n\n")
				if foo == "Sniper" or foo == "Marksman" then
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("What are you talking about? My guns are no more technology than a sword. I don't see you complaining about those.\n\n")
					term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
					term.text_out("The sword is an extension of one's own body, one's own soul. A gun requires no skill to master, and any fool, such as you, may weild it.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Whoa! If you think hitting a target at a hundred yards doesn't take skill, you're sorely mistaken.\n\n")
					term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
					term.text_out("Such is your delusion. You seek to perfect a skill, whereas we seek to perfect our being. There is no hope for you. You must die now.\n\n")
				elseif foo == "Dancer" then
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("What are you talking about?\n\n")
					term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
					term.text_out("Your surprise seems...genuine. Could it be that you are so stupid that you truly don't know the monsters you have served? The monsters that you train with?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("I'm a dancer. What's so terrible about that?\n\n")
					term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
					term.text_out("...you do not appear to be lying. Therefore you are a fool. My heart greives for you, as you will meet your death without even understanding why. I will kill you now.\n\n")
				else
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("I don't serve machines. I'm just really good at using them.\n\n")
					term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
					term.text_out("Such is the delusion of your kind. You have abandoned the path of self perfection, the path of enlightenment, and replaced it with the mundane, and the mechanical. You are a menace, and I shall destroy you.\n\n")
				end
			end

			term.text_out("Whoa! I thought my safety was gaurunteed! I agreed to meet with you peacefully. You promised that I would not be harmed!\n\n")
			term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
			term.text_out("Yes. I lied.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			dialogue.FOOT_FIGHT_HELPER()
		end

	elseif dball_data.foot_clan_rapport == 2 then
		-- This shouldn't ever happen, right?
		term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
		term.text_out("Leave this place, and do not return.")
	elseif dball_data.foot_clan_rapport == 3 then
		term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
		term.text_out("Implement quest completion")
	elseif dball_data.foot_clan_rapport == 4 then
		term.text_out(color.LIGHT_RED, "Oroku Saki, the Shredder: ")
		term.text_out("Greetings, pupil. Have you come to train?\n\n")
		dialogue.helper("Yes.", "a")
		dialogue.helper("Not at this time.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			dball.enroll(FLAG_ENROLL_SHREDDER)
		else
			-- do nothing
		end
	elseif dball_data.foot_clan_rapport == 5 then
		message("Error: Shredder is dead, and you rule The Foot. How are you talking to him?")
	else
		-- angry?
		message("The Shredder ignores your words.")
	end
end
function dialogue.FOOT_FIGHT_HELPER()
	place_monster_one(4, 18, RACE_FOOT_HIGH, 0, 0, FACTION_FOOT)
	place_monster_one(4, 21, RACE_FOOT_HIGH, 0, 0, FACTION_FOOT)
	place_monster_one(7, 18, RACE_FOOT_HIGH, 0, 0, FACTION_FOOT)
	place_monster_one(7, 21, RACE_FOOT_HIGH, 0, 0, FACTION_FOOT)
	dball.place_monster(8, 20, "Tatsu")
	dball.faction_annoy(FACTION_FOOT)
	dball.annoy_map()
	dball_data.foot_clan_rapport = 999
end

function dialogue.EVIL_MONK()
	term.save()
	term.text_out(color.LIGHT_BLUE, "As ")
	term.text_out("the ringleader falls you see the shiny metal glint of a keyring. You quickly snatch it from him. The doors to the meditation chambers will now open for you.\n\n")
	dialogue.conclude()
	term.load()
	cave_set_feat(9, 3, FEAT_DOOR)
	cave_set_feat(9, 8, FEAT_DOOR)
	cave_set_feat(9, 13, FEAT_DOOR)
	cave_set_feat(9, 39, FEAT_DOOR)
	cave_set_feat(9, 44, FEAT_DOOR)
	cave_set_feat(9, 49, FEAT_DOOR)
	cave_set_feat(11, 3, FEAT_DOOR)
	cave_set_feat(11, 8, FEAT_DOOR)
	cave_set_feat(11, 13, FEAT_DOOR)
	cave_set_feat(11, 39, FEAT_DOOR)
	cave_set_feat(11, 44, FEAT_DOOR)
	cave_set_feat(11, 49, FEAT_DOOR)
	cave_set_feat(19, 3, FEAT_DOOR)
	cave_set_feat(19, 8, FEAT_DOOR)
	cave_set_feat(19, 13, FEAT_DOOR)
	cave_set_feat(19, 39, FEAT_DOOR)
	cave_set_feat(19, 44, FEAT_DOOR)
	cave_set_feat(19, 49, FEAT_DOOR)
	cave_set_feat(21, 3, FEAT_DOOR)
	cave_set_feat(21, 8, FEAT_DOOR)
	cave_set_feat(21, 13, FEAT_DOOR)
	cave_set_feat(21, 39, FEAT_DOOR)
	cave_set_feat(21, 44, FEAT_DOOR)
	cave_set_feat(21, 49, FEAT_DOOR)
end
function dialogue.ABBOT()

	-- 0 = no contact
	-- 1 = fighting invaders (not used)
	-- 2 = all done
	if dball_data.abbot_state == 0 then

		local bad_guy_count = dball.how_many_exist(RACE_CORRUPT_MONK_A) + dball.how_many_exist(RACE_CORRUPT_MONK_B) + dball.how_many_exist(RACE_CORRUPT_MONK_C) + dball.how_many_exist(RACE_CORRUPT_MONK_D)

		term.save()
		term.text_out(color.LIGHT_BLUE, "Abbot: ")
		term.text_out("Ahh...the situation has resolved itself, I see. Excellent.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		if bad_guy_count > 0 then
			term.text_out("Umm...not exactly.\n\n")
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("No? Then why have you released me? I gave explicit instruction that I was to be kept here until the situation was resolved. If it is not, then I must resume my meditations.\n\n")
			term.text_out("The Abbot pauses and looks you over.\n\n")
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("You are not a monk of this temple.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("No. The invaders were helped by insiders to completely take over the temple. Krillan trapped them in the catacombs here, and asked me to rescue you. \n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("I see. And what is the present state of affairs?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I've defeated their ringleader and fought my way in here, but there are still minions here. We'll have to fight our way out.\n\n")
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("No. There will be no more violence.\n\n")
			term.text_out("The Abbot steps outside and asks the remaining rebels to cease their wrong-doing. When they see that he has been freed, they turn and run. It seems that no more fighting will be necessary.\n\n")
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("Thank you for your help stranger. But please forgive my rudeness. I must attend to the wounded.\n\n")
			dball.delete_monster(RACE_CORRUPT_MONK_A)
			dball.delete_monster(RACE_CORRUPT_MONK_B)
			dball.delete_monster(RACE_CORRUPT_MONK_C)
			dball.delete_monster(RACE_CORRUPT_MONK_D)
		else
			term.text_out("Yes. The invaders managed to overrun the temple, but Krillan trapped them in here and recruited me to deal with them.\n\n")
			if party.qty_partied(RACE_KRILLAN) > 0 then
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("Hey! I helped too. We had to beat up a LOT of them. It was really hard.\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("Krillan...you beat these people up?\n\n")
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("Absolutely!\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("Krillan, you know the rule: those we train are not allowed to commit violence. You have committed much violence. You will have to leave the temple.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("But...but, I saved the temple!\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("Krillan, do not disgrace yourself with such immodesty. We monks must live humble, peaceful lives.\n\n")
				term.text_out("The Abbot turns to you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("Thank you, stranger, for your self. I am sorry to have troubled you. Since you have expressed an interest in him, perhaps you might allow Krillan to accompany you in your journy. Perhaps he was meant to live the life of an adventurer, rather than a monk. Now, if you'll excuse me, I must look after the wounded.\n\n")
			else
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("I suppose you could say that the situation has been resolved, yes.\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("You look troubled, stranger. Please share your burden with me.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("I think the burden part is pretty much over with. To recap: the invaders were let into the temple by some of the monks who wanted to take over. Krillan managed to trap them here in the catacombs, and then recruiter me to convince them to change their minds.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("I see. Was anyone injured?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("You might say that.\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("A most unfortunate turn of events. Loss of life is always tragic. And the look on your face tells me that there was much tragedy.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yeah, well...just try not to trip on the corpses on the way out. It's kind of dark in here.\n\n")
				term.text_out(color.LIGHT_BLUE, "Abbot: ")
				term.text_out("I see. Then I must check to see if any survived, and tend to the wounded. Thank you for your help\n\n")
			end
		end
		dialogue.conclude()
		term.load()
		change_quest_status(QUEST_SAVE_THE_TEMPLE, QUEST_STATUS_FINISHED)
		dball_data.krillan_state = 3
		dball.delete_monster(RACE_ABBOT)
		dball_data.abbot_state = 2
		return
		
	elseif dball_data.abbot_state == 1 then
		-- Implement me! Finish dialogue branch!
	elseif dball_data.abbot_state == 2 then
		local greeting = ", stranger."
		if dball_data.krillan_state == 4 then
			greeting = ", " .. player_name() .. "."
		end

		term.save()
		term.text_out(color.LIGHT_BLUE, "Abbot: ")
		term.text_out("Hello again" .. greeting .. "\n\n")
		dialogue.helper("Hello. Just stopping by.", "a")
		if dball_data.alignment > 99 then
			dialogue.helper("(Alignment: 100) Hello, Abbot. Would you train me in the arts of this temple?", "b")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			dball.enroll(FLAG_ENROLL_ABBOT)
		end
	end
end

function dialogue.KRILLAN()
	-- dball_data.krilan_state
	-- 0 = no contact
	-- 1 = contact, didn't accept quest
	-- 2 = accepted quest
	-- 3 = completed quest, pending thank you
	-- 4 = all done, generic
	term.gotoxy(0, 0)
	if party.is_partied(RACE_KRILLAN) > 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("It's scary going adventuring like this.\n\n")
		dialogue.helper("You'll be ok. Let's just keep at it.", "a")
		dialogue.helper("Maybe you'd like to stay here for a while and rest some?", "b")
		if has_ability(AB_FUSION) then
	--		dialogue.helper("EXPERIMENTAL: Induce Fusion", "c")
		end
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Ok.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Well...if you insist. I suppose I could stay here for a while.\n\n")
			dialogue.conclude()
			term.load()
			party.unparty(RACE_KRILLAN)
		elseif ans == "c" then
	--		dball.fusion(RACE_KRILLAN)
		end
	elseif dball_data.krillan_state == 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Thank goodness help has arrived! Thank you so much for coming!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...you're welcome? \n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("We had no idea how long we would remain hostage here. It was terrible!\n\n")

		dialogue.helper("What are you talking about? This is a Buddhist Temple, isn't it?", "a")
		dialogue.helper("Uhh...I just came here for training. If there's a hostage situation, I think I'll just leave.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			return
		end

		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Yes! But several days ago a large group of rival Taoists came and locked our Abbot in the basement! It's terrible I tell you!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...umm...'rival Taoists?' That doesn't seem very plausible.\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Well, ordinarily no, but they had help! Several monks of the Temple were corrupted by their philosophy and helped them!\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("I'm not buying this. Seriously...Buddhist monks are universally renowed for their fighting prowness. Taoist philosophy is about feminine passivity and acceptance.\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Oh...that's right. I sort of forgot about that. Maybe they aren't Taoists.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You think?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("I think you're confusing Buddhist monks with Shaolin monks though. Buddhism is also largely about acceptance of the world.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You don't train the martial arts here?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Of course we do! I just mean...in general.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Right. Well, look at it this way...do you want my help or not?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Oh! Yes! Please!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Ok. So explain to me what's going on.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Several days ago a large group of Tao...I mean people arrived. They all wore robes and many of them carried martial arts weapons. Fearing trouble, we locked the gates and our Abbot and our highest ranking priests all went into private meditation, and requested that they be locked into their rooms until the situation was resolved. As soon as they did, several of our monks revealed that they were taking over the Temple, and let the invaders in.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...asked to be locked into their meditation chambers? Whatever for?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("It was a form of passive self-denial. The hope was to meditate until the problem resolved itself, and to express commitment to that resolution.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Wow. I sure am glad I'm not a monk. Ok. Go on.\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("When I realized what was going on, I played along, pretended to be one of them and-\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("'Pretended?' You mean you lied? That doesn't seem very monk-ly.\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("I'm just an initiate!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...ok. Sorry. Please continue.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("...well, I knew I had to do something, so I...umm...told them about my secret stash of porno magazines that I keep in the lower levels, and invited them to go see.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...are you serious?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("I had to do SOMETHING!!!!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("They berated me for my transgression, of course, and insisted that I show them, so they could get rid of them and cleanse the Temple.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...so the invaders and 'corrupt' monks wanted to purify the Temple of your unholiness? Wow. Sure is a good thing that you were here to rescue everyone.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("At first only a few of them came with me, but I pretended I couldn't find them, and before long a massive search was called, and every single last one of the invaders and traitor monks went downstairs to search every last nook and cranny of the catacombs. Once they were all in, I snuck back up and locked the door, trapping them all inside.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...ahh. It all comes together now. So you're the only one up here?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("No. There are a few others who were in meditation upstairs here when all this happened.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Good! So we won't be alone in all this. Where are they? Have they gone to get help?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("...no, they're still aitation.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You're telling me that the entire Temple has been overrun by invaders, corrupt monks are running loose, the Abbot is being held hostage...and everyone other than you is too busy meditating to help?\n\n")
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("It's a very deep meditation that we do here.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("So that's the story. Will you help?\n\n")
		dialogue.helper("Yes. This is too weird to turn down.", "a")
		dialogue.helper("No. Obviously this is all a lesson for you. It would be wrong for me to interfere. You must learn to accept whatever the universe gives to you. Only in this way will you find true enlightenment.", "b")
		if dball_data.alignment < 0 then
			dialogue.helper("No, I think I'm going to side with the invaders. I'll keep it simple though, and just kill you. (Attack)", "c")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Thank you so much! The entrance to the catacombs is at the end of the corridor to the east. Follow it around and you'll come to a door and stairs. Here's the key.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wait...I'm about to go off and fight a horde of invaders, I'm rescuing you, your temple, and your Abbot...and you don't plan on helping?\n\n")
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("What? Me? Help? But...I...umm...shouldn't I stay here to guard the, umm...guard the...oh! Sacred treasures! Yes! I should guard the sacred treasures. Definitely.\n\n")
			dialogue.helper("Yeah, ok. You just stay here and I'll go deal with it. Silly monk.", "a")
			if dball.persuade(20) then
				dialogue.helper("(Persuade 20) Krillan, you're coming with me. Just accept it.", "b")
			else
				dialogue.helper("No way. You're coming with me.", "c")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				change_quest_status(QUEST_SAVE_THE_TEMPLE, QUEST_STATUS_TAKEN)
				dball_data.krillan_state = 2
				dball_data.temple_key = 1
			elseif ans == "b" then
				dball_data.persuades = dball_data.persuades + 1
				party.party(RACE_KRILLAN)
				change_quest_status(QUEST_SAVE_THE_TEMPLE, QUEST_STATUS_TAKEN)
				dball_data.krillan_state = 2
				dball_data.temple_key = 1
			elseif ans == "c" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("But...won't it be dangerous?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yes, probably. And your point?\n\n")
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("I don't really like danger.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("And you think I do?\n\n")
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("Of course! You're an adventurer. Adventurers are just as renowed for throwing themelves into dangerous situations as Buddhist monks are for being fantastic fighters!\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("You mean Shaolin monks?\n\n")
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("Oh, that's right! And I'm a Buddhist monk, not a Shaolin monk, so I have absolutely no business putting myself into a situation where I have to fight anyone. In fact, I think it's even against our vows to cause harm to anyone.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("You're really not coming with?\n\n")
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("Nope. This is what you get for neglecting charisma.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Oh. You mean there was a persuade option I didn't see?\n\n")
				term.text_out(color.LIGHT_BLUE, "Krillan: ")
				term.text_out("Yes. You needed a 20. You only have " .. player.stat(A_CHR) .. ". Sorry.\n\n")
				dialogue.helper("Ok. Well, I'll help you anyway.", "a")
				dialogue.helper("Wait...isn't there an option to decline the quest now so I can equip some designer clothes and come back later with the 20 charisma so you'll join me?", "b")
				local ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Krillan: ")
					term.text_out("Thank you so much!\n\n")
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Krillan: ")
					term.text_out("No.\n\n")
				end
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_SAVE_THE_TEMPLE, QUEST_STATUS_TAKEN)
				dball_data.krillan_state = 2
				dball_data.temple_key = 1
			end
			
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Hmm. Yes, I thought you might say something like that.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "c" then
			dball.annoy_map()
		end
	elseif dball_data.krillan_state == 1 then
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Hello again! Have you decided to save the Temple?\n\n")
		dialogue.helper("Yes.", "a")
		dialogue.helper("No.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Wonderful! Here's the key to the catacombs. The stairs are at the end of the hallway east of where we're standing. Just follow it around to the north. All you really need to do is rescue the Abbot. He's a fantastic martial arts master, and once he's out I'm sure hel'l be able to put everything back to normal.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("But aren't you Buddhist monks, but Shaolin monks? How can he be such a master?\n\n")
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Ok! I confess! We're both. Orinji Temple trains Shaolin Buddhist monks.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Thank you. It's nice to have that cleared up.\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_SAVE_THE_TEMPLE, QUEST_STATUS_TAKEN)
			dball_data.krillan_state = 2
			dball_data.temple_key = 1
		elseif ans == "b" then
		end
	elseif dball_data.krillan_state == 2 then
		-- If we're here, we're NOT partied.
		term.save()
		term.text_out(color.LIGHT_BLUE, "Krillan: ")
		term.text_out("Hello, again. Has the Abbot been rescued?\n\n")
		if quest(QUEST_SAVE_THE_TEMPLE).status == QUEST_STATUS_TAKEN then
			dialogue.helper("No. Not yet.", "a")
			if dball_data.krillan_ever_partied > 0 then
				dialogue.helper("No. Would you come with me to help?", "b")
			end
		elseif quest(QUEST_SAVE_THE_TEMPLE).status == QUEST_STATUS_COMPLETED then
			dialogue.helper("Yes.", "c")
		end

		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Please hurry!")
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Yes, I'll come with you.")
			party.party(RACE_KRILLAN)
			if dball_data.krillan_ever_partied == 0 then
				-- Note use of both 1 and 2
				dball_data.krillan_ever_partied = 1
			end
		elseif ans == "c" then
		end
	elseif dball_data.krillan_state == 3
	 or dball_data.krillan_state == 4 then
		term.save()
		if dball_data.krillan_state == 3 then
			dball_data.krillan_state = 4
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("You've rescued the Abbot! Thank you so much!\n\n")
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("Yes, thank you, stranger. You were truly the answer to my meditations.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("My name is " .. player_name() .. ".\n\n")
			term.text_out(color.LIGHT_BLUE, "Abbot: ")
			term.text_out("And you are indeed no stranger to this temple, " .. player_name() .. ".\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("I suppose now that everything is back to normal, I'll get back to fasting and meditating, and training when I'm able. Please do come back and visit me sometime!\n\n")
			dialogue.helper("Certainly. Take care, you two.", "a")
		else
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Hello, " .. player_name() .. "! Wow, it's been so dull since you saved the Abbot. I know I'm just a monk, but I really crave some excitement.\n\n")
			dialogue.helper("Maybe, but us adventurers tend to have lots of people trying to kill us all the time. Being a monk isn't so bad.", "a")
		end
		if dball_data.krillan_ever_partied == 0 then
			if dball.persuade(20) then
				dialogue.helper("(Persuade: 20) Krillan, why don't you join me in my adventures? Training here at the temple is good, but you'll improve a lot more quickly as an adventurer. Remember how I saved the temple? You could become that strong too, if you try.", "b")
			else
				dialogue.helper("Krillan, why don't you join me in my adventures? I'm sure it will be more exciting than fasting and meditating. Seriously...starve yourself, and then sit and try to not think about it? Come with me.", "c")
			end
		else
			dialogue.helper("Hey, Krillan. How'd you like to come adventuring with me again?", "d")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Hey, you're right! More than anything I want to get stronger. I'd be happy to come with you.\n\n")
			dialogue.conclude()
			term.load()
			party.party(RACE_KRILLAN)
			dball_data.krillan_ever_partied = 2
		elseif ans == "c" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Oh, I could never do that. Adventuring is dangerous.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("But aren't you bored sitting around here at the temple?")
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("...maybe a little. But there are scary demons and monsters out there! I think I'll just stay here where it's nice and safe until I've trained more and and stronger.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "d" then
			term.text_out(color.LIGHT_BLUE, "Krillan: ")
			term.text_out("Absolutely!")
			party.party(RACE_KRILLAN)
			dball_data.krillan_ever_partied = 2
		end

	end
end
function dialogue.MONK_ONE()
	term.gotoxy(0, 0)
	term.save()
	term.text_out(color.LIGHT_BLUE, "Monk: ")
	if dball_data.ofuda == 0 then
		term.text_out("Hello. Welcome to Orinji Temple. What can I do for you?\n\n")
		dialogue.helper("Oh, nothing much. I'm just exploring. Thanks, though.", "a")
		if dball_data.alignment > 99 then
			dialogue.helper("Do you sell souvinirs?", "b")
		end
	else
		term.text_out("Hello again.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Hello. May I buy another ofuda?\n\n")
		term.text_out(color.LIGHT_BLUE, "Monk: ")
		term.text_out("You still haven't used the last one I gave you.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Is that a problem?\n\n")
		term.text_out(color.LIGHT_BLUE, "Monk: ")
		term.text_out("Not at all. It is excellent that you haven't had the need to protect yourself from evil spirits or demons. But it would be inviting misfortune to be too prepared for such things. Water gathers in deep pits, and too much preparation for bad events may aid them in finding you. One ofuda is all you need.\n\n")
		dialogue.conclude()
		term.load()
	end
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
	elseif ans == "b" then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Monk: ")
		term.text_out("I could paint an ofuda for you, if you'd like. If you're willing to donate 100zn to the Temple, that is.\n\n")
		dialogue.helper("What's an ofuda?", "a")
		if player.au > 99 then
			dialogue.helper("Yes, please.", "b")
		else
			dialogue.helper("I'm sorry. I don't have 100zn. I'll come back another time.", "c")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Monk: ")
			term.text_out("Ofuda are charms, written out of paper to evoke a particular change in one's life, or for protection, and so on. A very popular choice is 'Akuryo Taisan,' which means 'Evil Spirit Begone!' Should you encounter any evil spirits or demons, it will surely help you to avoid harm. Simply read out the words on the ofuda, and smack the demon on the forehead with it. Works every time.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...uhh, your name wouldn't happen to be Mars would it?\n\n")
			term.text_out(color.LIGHT_BLUE, "Monk: ")
			term.text_out("Mars? No. Why do you ask?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("No reason. Thanks for explaining.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			player.au = player.au - 100
			player.redraw[FLAG_PR_BASIC] = true
			local obj = create_object(TV_MISC, SV_OFUDA)
			make_item_fully_identified(obj)
			dball.reward(obj)
		elseif ans == "c" then
		end
	end
end
function dialogue.MONK_TWO()
	term.gotoxy(0, 0)
	term.save()
	term.text_out(color.LIGHT_BLUE, "Monk: ")
	term.text_out("...oooommmmmmm....oooommmmmmm...oooommmmmmm.....")
	dialogue.helper("Hello.", "a")
	if dball_data.monk_two_state == 1 then
		dialogue.helper("(Bonk him on the head to get his attention)", "b")
	end
	dialogue.helper("(Just leave)", "c")
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
		term.text_out("There is no answer other than 'om.'")
	elseif ans == "b" then
		term.text_out("Still no answer. Wow. Good concentration.")
	elseif ans == "c" then
	end
end
function dialogue.GREGORY()
	term.gotoxy(0, 0)
	if quest(QUEST_KAIO_GREGORY).status == QUEST_STATUS_TAKEN then
		message("You have to hit with with the hammer, bozo.")
	else
		message("Wow! You didn't have to hit my so hard!")
	end
end
function dialogue.EAST_KAIOSHIN()
	term.gotoxy(0, 0)
	message("Implement me!")
end
function dialogue.RADDITZ_79()
	message("Implement me!")
end
function dialogue.VEGITA_EARTH()
	message("Implement me!")
end
function dialogue.VEGITA_79()
	message("Implement me!")
end
function dialogue.PICCOLO()
	message("Implement me!")
end
function dialogue.DEMON_KING_PICCOLO()
	message("Implement me!")
end
function dialogue.JAJOUSHIN()
	message("I sssshould be implemented sssssooon.")
end
function dialogue.FREEZA()
	message("Implement me!")
end
function dialogue.BABIDI()
	message("Implement me!")
end

------------------------------------------
------------------------------------------
---- Functional --------------------------
------------------------------------------
------------------------------------------

-- For when he's removed from his Rice Cooker
-- NOTE: This one returns a true/false to the tool script!
function dialogue.PICCOLO_INCEPTION()
	term.gotoxy(0, 0)
	local yy, xx = dball.find_open_space(player.py, player.px, 3)
	if yy == -1 then
		term.save()
		term.text_out(color.GREEN, "You ")
		term.text_out("struggle with the seal, but aren't able to open it. Odd. It looks like it's just paper.")
		dialogue.conclude()
		term.load()
		return
	end


	local rice_text = "You don't have any rice, but you figure you can at least remove the seal and take a look inside. After all, there could be something inside."

-- *sigh* Implement me
--[[
		if dball.player_has_item_with_flag(FLAG_WHITE_RICE) == true then
			rice_text = "Admiring the fine artifact rice cooker before you, you open your bag of rice and get ready to prepare a delicious meal."
		elseif dball.player_has_item_with_flag(FLAG_BROWN_RICE) == true then
			rice_text = "Admiring the fine artifact rice cooker before you, you open your bag of rice and get ready to prepare a delicious meal."
		end
]]

	term.save()
	term.text_out(rice_text .. " As you contemplate the cooker, though, you start to get the distinct impression that you are being watched from far above. You look around you, but you see nothing. Still, you can't help but feel a bit uneasy.\n\n")
	term.text_out("You shrug it off and reach for the seal. Right as you do, lightning strikes in the distance.\n\n")
	term.text_out("Are you sure you want to open it?\n\n")
	dialogue.helper("Yes. Open it.", "a")
	dialogue.helper("No. I'm certain that something bad would happen. I don't really need to know what's inside. I'm sure it's better that it stay there.", "b")
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
		dball_data.piccolo_state = 1 -- Demon King Piccolo has been released!
		term.save()
		term.text_out("You tear the seal and open the rice cooker. As you do you are swept with a wave of cold. Peering inside you see a swirling vortex of mist, accompanied with tiny bolts of colored lightning. You're not quite sure what to make of it, but before you have too much time to reflect the mist leaps from the rice pot and coelesces into a green humanoid creature!\n\n")
		term.text_out(color.LIGHT_GREEN, "Demon King Piccolo: ")
		term.text_out("Hahahahaha!!! Wretched fool! You have released me from my confinement! And now, in thanks, I will kill you!!!\n\n")
		dialogue.conclude()
		term.load()
			-- NOTE: Doing it this way because _place_named_monster
		-- interprets 'Demon King' as a double ego and fails
			m_allow_special[RACE_DEMON_KING_PICCOLO + 1] = true
		place_monster_one(yy, xx, RACE_DEMON_KING_PICCOLO, 0, 0, FACTION_DUNGEON)
		m_allow_special[RACE_DEMON_KING_PICCOLO + 1] = false

		-- place_named_monster_near(player.py, player.px, RACE_DEMON_KING_PICCOLO, 0)
		-- place_named_monster_near(player.py, player.px, "mafoo", 0)
		-- place_named_monster(3, 14, "Snuggles, the 9 headed hydra", 0)
		-- dball.place_monster(4, 8, "Trunks")
		-- dball.place_monster_near(player.py, player.px, "mafoo")
		return true
	elseif ans == "b" then
		return false
	end
end

function dialogue.JOESEPHINE()
	term.gotoxy(0, 0)
	term.save()
	term.text_out(color.LIGHT_BLUE, "\nJoesephine: ")
	term.text_out("Well, look who it isn't. I remember you. You're the idiot who convinced that rich pig to send all of us moochers away. Don't think I haven't forgotten. Because of you I've had to go back to working for a living. I'm a seamstress by trade, but not because I want to be. I can repair clothing, and reinforce cloth armors with extra sturdy padding. And...just because I hate you so much, I'm going to charge you ten times what I'd charge anyone else. That's what you get.\n\n")
	dialogue.helper("Hrrm.", "a")
	if quest(QUEST_ROSSHI_LONELY).status == QUEST_STATUS_TAKEN then
		dialogue.helper("(Not implemented, waiting on engine) Well, if you're really looking to find a man so you don't have to work for a living, I happen to have a friend I could introduce you to. He lives on an island near hear, and trust me...he's absolutely the most physically fit 300 year old you're ever going to meet!", "b")
	end
	local ans = dialogue.answer()
	term.load()
end
function dialogue.TENSHINHAN()
	term.gotoxy(0, 0)
	-- Tsuru Seni'nin's students are mostly just comic dialogue for now
	-- At least until fusion has been implemented
	if dball.current_location() == "World Tournament" then
		message("I will defeat you!")
	elseif party.is_partied(RACE_TENSHINHAN) > 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
		term.text_out("Yes, " .. player_name() .. "?\n\n")
		dialogue.helper("Just checking to see you're ok.", "a")
		dialogue.helper("Thank you for your help. But I must continue on my own.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
			term.text_out("Yes, I understand. I shall remain here.\n\n")
			dialogue.conclude()
			term.load()
			party.unparty(RACE_TENSHINHAN)
		end
		

	elseif enrollments[FLAG_ENROLL_ROSSHI] > 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "tenshinhan: ")
		term.text_out("Pffft. Turtle student. Slow and dumb.")
		dialogue.conclude()
		term.load()
	elseif dball_data.crane_state == 0 then
		term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
		term.text_out("You must have come to train with our great master!")
	elseif dball_data.crane_state == 1 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
		term.text_out("I wonder if wolf would be good on pizza?\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.crane_state == 2 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
		term.text_out("Hey, it's good to see you.\n\n")
		dialogue.helper("Good to see you too.", "a")
		if dball.may_i_party(RACE_TENSHINHAN) == FLAG_PARTY_ALLOWED then
			dialogue.helper("Hey, Ten. I'm having a tough time on my own. Would you help me?", "b")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			-- local try = dball.may_i_party(RACE_TENSHINHAN)
			-- if try == FLAG_PARTY_ALLOWED then
				term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
				term.text_out("Certainly. I'm always happy to help a fellow brother in Crane.\n\n")
				dialogue.conclude()
				party.party(RACE_TENSHINHAN)
			-- else
			--	term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
			--	term.text_out("I'm sorry. I am at a critical moment of my training, and I cannot abandon it now.\n\n")
			--	dialogue.conclude()
			-- end
			term.load() 
		end 
	else
		--should never happen, right?
		message("...you should never see this...")
	end
end
function dialogue.CHAOZU()
	term.gotoxy(0, 0)
	-- Tsuru Seni'nin's students are mostly just comic dialogue
	-- At least until fusion has been implemented
	if dball.current_location() == "World Tournament" then
		message("I will defeat you!")
	elseif enrollments[FLAG_ENROLL_ROSSHI] > 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Chaozu: ")
		term.text_out("Oh, wow! You must be one of Rosshi's turtle students! I recognize the slow gait.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.crane_state == 0 then
		term.text_out(color.LIGHT_BLUE, "Chaozu: ")
		term.text_out("You must have come to train with our great master!")
	elseif dball_data.crane_state == 1 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Chaozu: ")
		term.text_out("I'm glad I'm a martial artist instead of a pizza delivery boy.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.crane_state == 2 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Chaozu: ")
		term.text_out("Hello, " .. player_name() .. ".\n\n")
		dialogue.helper("Hi, Chaozu. I'm glad to see you're doing well.", "a")
		if dball.may_i_party(RACE_CHAOZU) == FLAG_PARTY_ALLOWED then
			dialogue.helper("Hey, Chaozu. I'm having a tough time on my own. Would you help me?", "b")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			-- local try = dball.may_i_party(RACE_CHAOZU)
			-- if try == FLAG_PARTY_ALLOWED then
				term.text_out(color.LIGHT_BLUE, "Chaozu: ")
				term.text_out("Oh! That sounds like fun! Yes, I'd love to.\n\n")
				dialogue.conclude()
				party.party(RACE_CHAOZU)
			-- else
			--	term.text_out(color.LIGHT_BLUE, "Chaozu: ")
			--	term.text_out("I'm sorry. I am at a critical moment of my training, and I cannot abandon it now.\n\n")
			--	dialogue.conclude()
			-- end
			term.load() 
		end 
	else
		--should never happen, right?
		message("...you should never see this...")
	end
end

function dialogue.CHI_CRANE()
	term.gotoxy(0, 0)
	if quest(QUEST_CHI_CRANE).status == QUEST_STATUS_UNTAKEN then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tsuru-Seni'nin: ")
		term.text_out("Excellent, " .. player_name() .. "! I am very pleased with your progress. But there is still much for you to learn. I believe you are ready to learn advanced techniques, but I require proof of your worthiness.\n\n")
		term.text_out("On an island northwest of here lives an old rival of mine. Rosshi. He practices the slow and dimwitted art of Turtle fighting. Defeat Rosshi and I will teach you greater things.\n\n")
		dialogue.conclude()
		term.load()
		change_quest_status(QUEST_CHI_CRANE, QUEST_STATUS_TAKEN)
	end
end

function dialogue.CRANE_HERMIT()
	term.gotoxy(0, 0)
	-- First handle special cases
	if enrollments[FLAG_ENROLL_ROSSHI] > 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tsuru Sen'nin: ")
		term.text_out("Ahhh...the student of my nemesis, Rosshi. Come to change over to the right side? No? Well, you are a fool. Rosshi's art is nothing compared to mine! May you suffer a lifetime of adequecy for your foolish decision to study with him. Hahahaha!!!\n\n")
		dialogue.conclude()
		term.load()
		return
	end

	-- dball_data.crane_state
	-- 0=nocontact, or default
	-- 1=on white wolf quest
	-- 2=accepted as student

	local fall_through = 0

	if dball_data.crane_state == 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tsuru Sen'nin: ")
		term.text_out("Ahhh...have you come to train with the great Tsuru Seni'nin? I am accepting students who are able to prove their worth to me.\n\n")
		dialogue.helper("What can you tell me about your style?", "a")
		dialogue.helper("Yes, I would like to train with you.", "b")
		dialogue.helper("No, sorry. Just exploring the area.", "c")
		if dball_data.alignment < 0 then
			dialogue.helper("I am here to make you all very dead. (attack)", "d")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
			term.text_out("I teach the fighting style of the Crane! It is from the crane, most beautiful, that I have acquired my namesake: the Crane Hermit. Crane emphasizes grace and elegance over brute strength. Crane stylists often choose to study the weapon arts as well, as a sword is nothing more than an extension of one's own body, much like the elegant neck of the crane.\n\n")
			dialogue.helper("Yes, I would like to study Crane style.", "a")
			dialogue.helper("Hmm. No, that sounds all well and good, but 'brute strength' is more my style.", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				fall_through = 1
			elseif ans == "b" then
			end
		elseif ans == "b" then
			fall_through = 1
		elseif ans == "c" then
		elseif ans == "d" then
			dball.annoy_map()
		end
	elseif dball_data.crane_state == 1 then
		if quest(QUEST_WHITE_WOLF).status == QUEST_STATUS_COMPLETED then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
			term.text_out("Ahhh! You have slain the white wolf!\n\n")
			term.text_out(color.LIGHT_BLUE, "Chaozu: ")
			term.text_out("Yay! I'll order a pizza to celebrate!\n\n")
			term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
			term.text_out("You have proven your value to me as a student.\n\n")
--[[
			term.text_out("You have proven your value to me as a student.")
			term.text_out(color.LIGHT_BLUE, "Chaozu: ")
			term.text_out("Hello? I'd like to order one large pizza, please.\n\n")
			term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
			term.text_out("And so I will teach you the magnificent art of Crane.\n\n")
			term.text_out(color.LIGHT_BLUE, "Chaozu: ")
			term.text_out("What do you mean 'what am I doing in your head?' I'm ordering a pizza telepathically. We don't have a phone out here.\n\n")
]]
			dialogue.conclude()
			dball_data.crane_state = 2
			term.load()
			dball.enroll(FLAG_ENROLL_CRANE_HERMIT)
		else
			term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
			term.text_out("Return to me after you have slain the white wolf!")
		end
	elseif dball_data.crane_state == 2 then
		dball.enroll(FLAG_ENROLL_CRANE_HERMIT)
	end

	if fall_through == 1 then
		dball_data.crane_state = 1
		term.save()
		term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
		term.text_out("I am pleased to hear it. But first you must prove your worth to me. Somewhere in the mountains near here there is a white wolf who has been preying upon travellers.\n\n")
		term.text_out(color.LIGHT_BLUE, "Chaozu: ")
		term.text_out("Including the pizza delivery man.\n\n")
		term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
		term.text_out("It is most distressing.\n\n")
		term.text_out(color.LIGHT_BLUE, "Chaozu: ")
		term.text_out("Especially if you're a pizza delivery man.\n\n")
		term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
		term.text_out("Do you have any idea how difficult it is to get Rusty's pizza kitchen to deliver out here?\n\n")
		term.text_out(color.LIGHT_BLUE, "Tsuru Seni'nin: ")
		term.text_out("Return to me after you have slain this beast and I will train you in the art of Crane.\n\n")
		dialogue.conclude()
		term.load()
		change_quest_status(QUEST_WHITE_WOLF, QUEST_STATUS_TAKEN)
	end
end

function dialogue.EMMA()
	term.gotoxy(0, 0)
	-- To overcome leftover cursor positioning from the level feeling caller
	term.blank_print("",0,0)
	-- Only ever increment this once per character
	if dball_data.emma_reincarnate == 0 then
		reincarnation.emma_counter = reincarnation.emma_counter + 1
	end

	-- dball_data.emma_state
	-- 0=nocontact, state not set by death (Therefore, if the player is dead, he found his way here on his own)
	-- 1=
	-- 2=immediate post-death dialogue pending for the first time
	-- 3=post death dialogue pending, but has died previously
	-- 4=post-death dialogue complete

	term.save()

	if dball_data.emma_state == 0 then
		term.text_out(color.LIGHT_RED, "The Emma Daio: ")
		term.text_out("Hmm? What are you doing here? You're alive. The module maintainer hasn't written a dialogue contingency for me if you're alive. So, I don't have much to say. But, since I am a Daio, I could kill you. That way you'd have a dialogue to read. Would you like that?\n\n")
		dialogue.helper("No...that's ok. Thank you, but I'm happy being alive.", "a")
		dialogue.helper("Yeah, sure. I came here to talk to you anyway.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("Wow. Really? Ok.\n\n")
			term.text_out("Emma touches you on the forehead.\n\n")
			dball_data.alive = 3
			dball_data.emma_state = 4
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("There you go. You're now dead. Go ahead and restart the conversation and we'll talk.\n\n")
			dialogue.conclude()
			term.load()
				dball.cure_cond()
				player.calc_bonuses()
				player.calc_hitpoints()
				counter.state(counter.LIFE, "silent", true)
				player.chp(player.mhp())
				player.redraw[FLAG_PR_BASIC] = true
		end
	elseif dball_data.emma_state == 2 then
		dball_data.emma_state = 4
		if reincarnation.emma_counter > 2 then
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("What? You AGAIN!?!? Goodness...would you make up your mind? Heaven or Hell, either way is fine...but seriously, would you just pick one and stay dead? You're really starting to bog down our system here. I think I'm going to have to report you Higher authorities. We really can't have mere mortals abusing the Celestial System like this. Go on...get out of here. But don't let me catch you here again.\n\n")
			dialogue.conclude()
			term.load()
		elseif reincarnation.emma_counter == 2 then
			term.text_out("Hmm. You look familiar. Haven't you...been here before?\n\n")
			dialogue.helper("Why, no, Daio. This is the first time I've died.", "a")
			dialogue.answer()
			term.load()
			term.save()
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("\n\n")
		elseif reincarnation.emma_counter < 2 then -- (should never by zero, but just in case...)
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...what? I'm not dead? Where am I?\n\n")
			term.text_out("You hear a noise behind you, and turn to behold a massive red ogre in fancy clothes scrutinizing you intently.\n\n")
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("No, " .. player_name() .. ". You are quite dead. Thouroughly. I checked you myself.\n\n")
			dialogue.helper("What? I'm dead? Then where am I? Who are you?", "a")
			dialogue.answer()
			term.load()
			term.save()
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("I am the Daio responsible for determining which souls pass on to Heaven, and which souls are sent to Hell. You are here in the Celestial space, at approximately three ninety degree angles from anything you've previously known, pending judgement to determine your final destination.\n\n")
			dialogue.helper("Oh dear. You don't make it sound very pleasant. So what's my final destination?", "a")
			if dball_data.karin_daio ~= 0 and reincarnation.emma_freebie_ress < 2 then
				dialogue.helper("Hey! You're the Daio that Karin mentioned!", "b")
			end
			local ans = dialogue.answer()
			if ans == "a" then
			elseif ans == "b" then
				if reincarnation.emma_freebie_ress == 0 then
					reincarnation.emma_freebie_ress = 1
					term.load()
					term.save()
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Oh...you're a friend of Karin? \n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Yes, we train together often.\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Oh! Well, nice to meet you. I'm Emma. \n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("So I guess that means I'm dead?\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Sadly, yes.\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Oh dear. That's very sad. I really wasn't ready to be dead yet. Is there anything I can do?\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Hmm. Well, Ordinarily it takes the power of a wish to restore someone to life. I don't suppose you have a complete set of dragonballs on you, do you?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("No, I'm afraid not.\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Hmm. Well,  I suppose...maybe...I could bring you back myself. I mean, I AM a Daio, and all.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Oh, really! Would you please?\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Well, alright. Since you're a friend of Karin's. But, just this once. And I do mean ONCE!!! Understand?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Absolutely.\n\n")
					dialogue.conclude()
					term.load()
					dball_data.alive = 0
					dball.planetary_teleport_helper("Earth")
					return
				else
					reincarnation.emma_freebie_ress = 2
					term.load()
					term.save()
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Yes...of course. Why do you sound so surprised?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("...umm...that's odd. This isn't the dialogue path I expected.\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("What? Were you expecting another freebie ressurection?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("...well, yes, but...\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("No buts! I said ONCE, remember?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("...well, yes I remember, but how come YOU do?\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Well, I am a Daio. We're supposed to know this kind of thing.\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Ok, so what happens now?\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Hmm. Well, I'm tempted to send you to Hell, or just perma-kill you outright for trying to trick me.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("But I wasn't trying to trick you! I just didn't realize that 'once' meant...REALLY only once. I mean, come on...this is a different character completely.\n\n")
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Hmm. Yes, I see how you might have misunderstood. Very well. I'll forgive your transgression and let you wander the earth as a spirit.\n\n")
					dialogue.conclude()
					term.load()
					return
				end
			end
			term.load()
			term.save()
			term.text_out(color.LIGHT_RED, "The Emma Daio: ")
			term.text_out("Well, that's something of a problem. You see, your soul is right on the cusp between good and evil. It's difficult to judge you. Really, you could go either way, but it can take a lot of effort to find out for certain in cases like yours. Ordinarily I wouldn't bother. I'd just recycle you back into the system, and let you start all over. Of course, doing that breaks down what you would consider your 'consciousness' into component parts, and it's very unlikely that they'd all all end up back together again. Not that that would really be much of a problem, from where I sit.\n\n")
			dialogue.helper("That doesn't sound very pleasant.", "a")
			dialogue.helper("Umm...could we try it another way?", "b")
			dialogue.helper("Wow! That sounds cool! Ok, I'm in!", "c")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" or ans == "b" then
				term.save()
				term.text_out(color.LIGHT_RED, "The Emma Daio: ")
				if ans == "a" then
					term.text_out("No? I can't imgaine why not. It's perfectly painless. Of couse, it does mean that part of your soul may end up reincarnating as a fish, or something, but there are worse things that can happen. ")
				elseif ans == "b" then
					term.text_out("Yes, I figured you'd be less than thrilled about that. ")
				end
				term.text_out("In any case, yours is a special situation because not only are you on the alignment cusp, you're also sufficiently willed that you've managed to maintain cohesion of your mental body even here in the afterlife. That's extremely rare. In any case, the Grand Daio is very particular about honoring free will, and I can't recycle you without your permission. For souls unable to manifest will, that's not an issue, but in your case...I...uh, don't suppose you'd be ok with it? ")
				if ans == "a" then
					term.text_out("You might not end up as a fish, you know. And even if you did, it wouldn't be all of you. Some of your consciousness might become something really neat, like say...a giraffe.")
				end
				term.text_out("\n\n")
				dialogue.helper("No, I think I'd really rather we didn't do that.", "a")
				dialogue.helper("Yeah, ok. That's fine.", "b")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					term.save()
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Very well. Then, since I'm unable to send you on to Heaven or Hell, and you don't want to be recycled, I'll leave your soul free to wander. Good luck to you.\n\n")
					dialogue.conclude()
					term.load()
				elseif ans == "b" then
					term.save()
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.\n\n")
					term.text_out("He reaches out and touches you on the forehead.\n\n")
					dialogue.conclude()
					term.load()
					reincarnation.emma_component = 1
					dball_data.recursive_death = 1
				end
			elseif ans == "c" then
				term.save()
				term.text_out(color.LIGHT_RED, "The Emma Daio: ")
				term.text_out("Wow. Really? Thank you! That really makes my job much easier! This will just take a moment. Oh...and you're toes might feel a little funny. Don't worry about that.\n\n")
				term.text_out("He reaches out and touches you on the forehead.\n\n")
				dialogue.conclude()
				term.load()
				reincarnation.emma_component = 1
				dball_data.recursive_death = 1
			end
		end
	elseif dball_data.emma_state == 3 then
		term.text_out("\n\n")
	elseif dball_data.emma_state == 4 then
		term.save()
		term.text_out(color.LIGHT_RED, "The Emma Daio: ")
		term.text_out("Hello again.\n\n")
		dialogue.helper("I don't suppose you'd be willing to answer a few questions?", "a")
		dialogue.helper("Umm...nevermind.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			local kaio_check = 0
			-- term.save()
			-- term handling within while do loops is odd
			while not nil do
				-- term.save()
				-- term.clear()
				dialogue.store_hack()
				term.text_out(color.LIGHT_RED, "The Emma Daio: ")
				term.text_out("What would you like to know?\n\n")
				if kaio_check == 1 then
					dialogue.helper("Kaio? Local to my district? What does that mean?", "a")
				end
				if kaio_check == 2 then
					dialogue.helper("Kaoishin? Who are they?", "b")
				end
				if kaio_check == 3 then
					dialogue.helper("Ok. And what's a Daio?", "c")
				end
				if kaio_check == 4 then
					dialogue.helper("Umm...so...the Daio are major, big-time OverGods...and you ARE one. So since I'm here can you tell me what the meaning of life is?", "d")
				end
				dialogue.helper("Is there anything I should know about being dead?", "e")
				dialogue.helper("Where exactly is this place? How do I get out?", "f")
				dialogue.helper("What about Heaven?", "g")
				dialogue.helper("What about Hell?", "h")
				dialogue.helper("How do I get not-dead?", "i")
				dialogue.helper("Ok. Thank you for answering my questions.", "j")
				local ans = dialogue.answer()
				term.load()
				term.save()
				term.clear()
				if ans == "a" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Your galaxy is divided into four cardinal districts: 'north' 'east' 'south' and 'west.' Each is overseen by a 'Kaio.' You might think of the Kaio as being a minor OverGod, one step up in the Celestial Hierarchy from planetary Gods, or 'Kami,' but one step below the universal overseers, the Kaioshin. Let's see...in your case, you're from earth, which is in the northern district of your native galaxy, so the eastern path (to your right) will take you to the North Kaio's planet.\n\n")
					dball_data.emma_mentioned_kaio = 1
					kaio_check = 2
				elseif ans == "b" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("The Kaioshin are one step above the Kaio. While the countless Kaio oversee districts within each and every galaxy, there are only four Kaioshin in the universe, each looking after one quarter of the countless galaxies that exist. Primarily they perform supervisory functions, and act as liasons between the Kaio and us Daio. Only very rarely do they actually involve themselves in situations that arise. Instead, Kaio do most of the work within specific galaxies, and we Daio handle affairs of a more universal nature.\n\n")
					kaio_check = 3
				elseif ans == "c" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("We Daio are one step up in the Celestial Hierarchy from the Kaioshin. While the Kaioshin oversee galaxies, we Daio perform functions relating to All-That-Is. For example, in my case, I handle the processing of all souls, anywhere in all of Creation. It's a big job, but somebody has to do it.\n\n")
					kaio_check = 4
				elseif ans == "d" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Life? Consciousness confined within particulate matter? Well, it varies, but in this particular universe...and I realize this might surprise you, the sole purpose of your being is actually to provide entertainment to somebody sitting at a computer in a universe somewhat adjacent to this one. You also get brownie points if you can reach dialogue branches that encourage them to think. I know...it sounds strange. It isn't. I assure you on the grander scheme of things there are far stranger universes. For example...take the universe the person you're supposed to be entertaining is in right now. That's a pretty twisted situation, there.\n\n")
					kaio_check = 0
				elseif ans == "e" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Lots of things. Fortunately being dead comes with a manual. If you check your inventory, you should find it.\n\n")
				elseif ans == "f" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("We're standing in the middle of the Serpent's Path, a byway through extremely extra-dimensional space that connects various three dimensional spaces in the universe to one another. I'm afraid your soul isn't quite dense enough to be able to traverse its entire length, but you'd probably find its seven-dimensional nature a bit confusing to navigate anyway. The Serpent's Path will spatially manifest differently to each soul. In your case, as a third density soul, only three directions on the path will be accessible to you. If you go to the left, you'll wind up back on your homeworld, earth. If you go right, you'll end up at the planet of the Kaio local to your universal district. And, of course, if you fall off the path, you'll wind up in Hell.\n\n")
					kaio_check = 1
				elseif ans == "g" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Heaven is where souls who have been deemed 'good' in life go. It's a nice place. The clouds are really quite lovely. You really should go visit sometime. Oh...wait, I guess you can't. Sorry.\n\n")
				elseif ans == "h" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("Hell is where souls who have been deemed 'evil' go. It's not exactly the nicest place in the universe. A bit dull, really. Oh, it's not as bad as your local superstitions would have you belive: The demons usually have much better things to do than sit around and torture souls. I think they got bored after the first few millenia. Really, the worst part of Hell is sitting around listening to all the other souls whine and complain all the time. Not much else to do there, I'm afraid. Oh...speaking of Hell, you should probably know that this portion of the path that you're standing on sits directly above it. If you were to fall off, that's where you'd end up. In Hell. I'd try to avoid that if I were you. Very dull.\n\n")
				elseif ans == "i" then
					term.text_out(color.LIGHT_RED, "The Emma Daio: ")
					term.text_out("That generally doesn't happen. Oh, I'm not saying it can't. There are a couple ways, of course. But if you ask me, you'd really be better off just being recycled. It won't hurt one bit.\n\n")
				elseif ans == "j" then
					-- term.load()
					break
				end
				dialogue.conclude()
				-- term.load()
			end
			term.load()
		elseif ans == "b" then
			term.load()
		end
	else
		term.load()
		message("Unknown dialogue/death state. Please report this bug, and let me know how you got here, and what sort of 'death' you did or didn't have. Thank you.")
	end
end

function dialogue.GERO()
	term.gotoxy(0, 0)
	if drgero.annoyed == 1 then
		message("You fool! You shall die horribly!")
	elseif dball_data.gero_state == 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("Hmm? What do you want?  \n\n")
		dialogue.helper("Sorry to disturb you. I was exploring the woods and stumbled upon your lab.", "a")
		dialogue.helper("I am here to rob you! Put your hands up and give me everything you have of value!", "b")
		dialogue.helper("Umm...nothing! Sorry! I must be lost!", "c")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
			term.text_out("Oh? How unfortunate for you. Minions! Kill this - hmm...no, wait. You could be useful. Now that my Red Ribbon Army lackeys are gone I am in need of a menial servant to run errands for me. Are you capable of following simple instructions?\n\n")
			dialogue.helper("Yes.", "a")
			dialogue.helper("Simple what...? Ins...inss...uhh...truck shuns?", "b")
			dialogue.helper("Capable, yes. Willing, no.", "c")
			dialogue.helper("So YOU were the evil mastermind behind the Red Ribbon Army! I must destroy you!", "d")
			if dball.persuade(16) then
				dialogue.helper("(Persuade 16) Oh, dear...I'm afraid I really must be going. Fortunately my memory is VERY bad, so I'd never be able to tell anyone where this very nice, tastefully decorated secret lair of yours is.", "e")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				dball.chalign(-25)
				-- player.redraw[FLAG_PR_BASIC] = true
				-- term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
				-- term.text_out("Very good.")
				-- dialogue.GERO_GET_QUEST()
			elseif ans == "b" then -- Minions attack, but not permanant
				term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
				term.text_out("Hmm. You're too stupid to allow to live. Minions...kill this buffoon.")
				drgero.annoy()
				drgero.annoyed = 0
			elseif ans == "c" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
				term.text_out("Hmm. Interesting specimen. Intelligent and surprisingly strong willed. Yes, you could make an excellent subject. I will give you one last chance to enter into my service voluntarily. Will you serve me?\n\n")
				dialogue.helper("Hmm. Perhaps allying with with an evil genius would serve my interests after all. I accept, for now.", "a")
				dialogue.helper("Nope. Not a chance.", "b")
				dialogue.helper("Oh dear, I'm afraid this is really all just a silly misunderstandting. I...umm...I'm really just here to sell Avon products. You obviously don't need any, so I'll just be on my way...", "c")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					-- term.save()
					-- term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
					-- term.text_out("I am glad you have chosen the path of reason.\n\n")
					dialogue.GERO_GET_QUEST()
				elseif ans == "b" then
					drgero.capture = 1 -- Capture, not kill. See dbstuff.lua
					term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
					term.text_out("Very well, we can do it the hard way. Minions! I want " .. gendernouns.himher .. " captured alive!")
					drgero.annoy()
				elseif ans == "c" then
					drgero.capture = 1
					term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
					term.text_out("No, I don't think so. Minions! I want " .. gendernouns.himher .. " captured alive!")
					drgero.annoy()
				end

			elseif ans == "d" then
				dball.chalign(10)
				player.redraw[FLAG_PR_BASIC] = true
				term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
				term.text_out("Oh really? Minions...get rid of this fool.")
				drgero.annoy()
			elseif ans == "e" then -- Lets you go, but he's annoyed from now on
				term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
				term.text_out("Hmm. Very well. But do not come back.")
				drgero.annoyed = 1
			else
				message("Error: Invalid answer returned by dialogue.answer, location 1")
			end


		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
			term.text_out("Oh really? Minions...get rid of this fool.")
			drgero.annoy()
		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
			term.text_out("Well, get yourself lost again!")
		else
			message("Error: Invalid answer returned by dialogue.answer, location 2")
		end
	elseif dball_data.gero_state == 1 then
	elseif dball_data.gero_state == 2 then
		dialogue.GERO_FINISH_QUEST()

	end
end

function dialogue.GERO_GET_QUEST()
	dball_data.gero_state = 2
	if dball_data.gero_quests == 0 then
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("Excellent. I am on the verge of a breakthrough in my android designs, and-\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Android designs?\n\n")
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("QUIET YOU FOOL! Yes, my android designs. I have had tremendous success overcoming limitations in previous models by integrating nano components into biological systems. These systems have their own limitations, however, and I must improve the basic structure if my specimens are to withstand the stress of my designs.\n\n")
		if get_skill(SKILL_TECHNOLOGY) >= 30 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Have you tried genetic alteration of your subjects? It should be relatively simple to harden the base type, while simultaneously minmizing chance of tissue rejection.\n\n")
			term.text_out("(Dr. Gero's eyes focus on you for the first time.)\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
			term.text_out("I see that I will have to keep an eye on you. Your the first person in many years to understand. That makes you valuable...but dangerous as well.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Hmm? Don't mind me. I'm harmless. Really.\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
			term.text_out("We'll see about that. In any case, yes. That's exactly what I've been doing. And you are going to help me.\n\n")
		else
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Uhh...ok. What do you need me to do?\n\n")
		end
		dialogue.conclude()
		term.load()
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("To solve the immediate problem, I need a genetic sample of a creature with extraordinarily strong cartilige. A dinosaur, or whale. \n\n")
	else
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("\n\n")
	end
end

function dialogue.GERO_FINISH_QUEST()

end

function dialogue.GERO_REMOTE_STOP()
	term.gotoxy(0, 0)
	term.save()
	term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
	term.text_out("Awake, my creation! Hahaha! I have some marvelous news for you. I have planted a remote controlled bomb inside your brain. From now on you will obey me, or I will press this little red button on this device here in my hand, and you will die! Hahahah! Oh, I suppose I should mention, unfortuantely I had to remove a rather large section of your brain to make room for the bomb. It's ok, you weren't using it. I've installed a powerful computer in its place, and downloaded your memories into it. You'll hardly notice the difference. So...my minion, are you ready to do my bidding?\n\n")
	dialogue.helper("I hear and obey, master.", "a")
	dialogue.helper("I...I shall do as you say...for now, but do not believe for a second that you have conquered me.", "b")
	dialogue.helper("Never! (Attempt to rush him before he can activate the device)", "c")
	local ans = dialogue.answer()
	if ans == "a" then
		term.load()
		dball.chalign(-100)
		player.redraw[FLAG_PR_BASIC] = true
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("Very good.")
		dialogue.GERO_QUESTS()
	elseif ans == "b" then
		term.load()
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("Hahahah! So be it. Now, let us get down to business.")
		dialogue.GERO_QUESTS()
	elseif ans == "c" then
		term.load()
		dball.chalign(50)
		player.redraw[FLAG_PR_BASIC] = true
		term.text_out(color.LIGHT_BLUE, "Dr Gero: ")
		term.text_out("*sigh* (He presses the button.) (Not implemented)")
		drgero.annoy()
		-- take_hit(25000, "Cerebral Bomb") -- Recursive...
	end
end

function dialogue.BRIEFS()
	term.gotoxy(0, 0)

	-- Tama's litter box is used as time goes on...
	dball_data.tama_litterbox = dball_data.tama_litterbox + 1

	local fall_through = 0

	local briefs_friends_dead = 0

	-- Note: This is not entirely correct. It should be possible for Buruma, at least,
	-- to be killed by monsters

	if race_info_idx(RACE_BURUMA, 0).max_num < 1 then
		briefs_friends_dead = briefs_friends_dead + 1
	elseif race_info_idx(RACE_TRUNKS, 0).max_num < 1 then
		briefs_friends_dead = briefs_friends_dead + 1
	elseif race_info_idx(RACE_TAMA, 0).max_num < 1 then
		briefs_friends_dead = briefs_friends_dead + 1
	end

	if briefs_friends_dead > 0 then
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("Get out of here, you murderer!")
		return

	elseif quest(QUEST_ANDROID_PLANS).status == QUEST_STATUS_TAKEN then
		message("Implement android plans branch")

	elseif dball_data.ttq_tripped == 2 then
		term.save()
		if dball_data.android_quest_status == 2 then
			if quest(QUEST_ANDROID_PLANS).status == QUEST_STATUS_UNTAKEN then
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("How is your secret weapon coming along?\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Not good, I'm afraid. We know what they're capable of, but we know very little about their weaknesses.\n\n")
			else
			end
		else
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("I'm sorry, I haven't much time to talk. I'm preparing a special weapon to use against the Androids. Of course, it's just my best guess as to what will work against them...but I really must try. Please excuse me.\n\n")
		end
		dialogue.conclude()
		term.load()
		return
	-- Other TTQ possibliities...


	elseif dball_data.briefs_state == 3 then -- polite done
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("Hello. Nice to see you again.")
		return

	elseif quest(QUEST_BRIEFS_SATAN).status == QUEST_STATUS_TAKEN then
		-- Check for battery
		local item
		local obj
		for i = 1, player.inventory_limits(INVEN_INVEN) do
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.k_idx == lookup_kind(TV_BATTERY, SV_BATTERY_BATTERY) then
				item = i
			end
		end

		if not item then
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Still no battery? Hmm. Well, keep looking.")
		else
			term.save()
			obj = player.inventory[INVEN_INVEN][item]
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
			term.load()
			term.save()
			quest(QUEST_BRIEFS_SATAN).status = QUEST_STATUS_FINISHED
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Ahh! Excellent. This will just take a moment.\n\n")
			term.text_out("(Dr. Briefs dismantles the muscle stimulator, installs the battery, and makes some minor adjustments.)\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Excellent! It works! Here...I'll let you run it over to him. Since you're both martial artists I'm sure you'll both get along swell. His estate is a short ways east and a bit north of here. Just mention my name and the guard will let you in.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("How did you learn all this techno stuff? It all seems so complicated.\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("It's like everything else. It's not difficult. You just have to take the time to learn. Are you interested?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("In learning? Sure. It's all very interesting to me.\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Well, in that case, once you've delivered the stimulator to Mr Satan, why don't you come on back, and I'll teach you some basics?\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_BRIEFS_SATAN_DELIVERY, QUEST_STATUS_TAKEN)
			local obj = create_object(TV_ELECTRONICS, SV_MUSCLE_STIMULATOR)
			make_item_fully_identified(obj)
			dball.reward(obj)
		end
		return

	elseif quest(QUEST_BRIEFS_SATAN_DELIVERY).status == QUEST_STATUS_TAKEN then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("Please hurry with that delivery! Mr. Satan isn't the most patient of people, and I do hate to keep him waiting. He's training for the World Tournament, you know!\n\n")
		dialogue.conclude()
		term.load()
		return
	elseif quest(QUEST_BRIEFS_SATAN_DELIVERY).status == QUEST_STATUS_COMPLETED or dball_data.satan_comic_state == 3 then
		quest(QUEST_BRIEFS_SATAN_DELIVERY).status = QUEST_STATUS_FINISHED
		term.save()
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		if dball_data.satan_comic_state == 3 then
			term.text_out("Oh. Hello. Umm...I just received a very strange voice message from Mr. Satan. Something about being thrilled that the Muscle Stimulator was 'thrown away...?' I'm not sure I understand, but in any case, he seemed very grateful for your involvement, and a happy customer is the important thing. Thank you for your help. And, ")
		else
			term.text_out("Ahhh! Welcome back. Mr. Satan just called to say he was very pleased with the muscle stimulator, and that he feels certain he'll win the World Tournament again this year. Thank you for taking care of that for me. I get so busy sometimes, it's difficult to keep track of everything. But ")
		end
				-- don't capitalize me: 'now'
		term.text_out("now that that's been taken care of, let's see about teaching you a little technology, shall we?\n\n")
		dialogue.conclude()
		term.load()
		dball.enroll(FLAG_ENROLL_BRIEFS_SOME)
		return

	elseif quest(QUEST_BRIEFS_SATAN_DELIVERY).status == QUEST_STATUS_FAILED then
		term.save()
		term.text_out("Dr. Briefs shakes his head\n\n")
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("I'm sorry. I was considering offering you work, but if you couldn't handle a simple delivery, I really don't think I want to trust you with more important work.\n\n")
		dialogue.conclude()
		term.load()
		return

	elseif quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status == QUEST_STATUS_COMPLETED then
		quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status = QUEST_STATUS_FINISHED
		term.save()
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("Wow! That was spectacular! Thank you so much, you made watching this years Tournament an absolute delight. I taped the whole thing and I'm sure I'll be pulling out those tapes from time to time. So, now you've proven that you're the world's best fighter, and with the Tournament prize money, you're rich. What else could you possibly want? This:\n\n")
		term.text_out("(Dr. Briefs pulls out a very ordinarly-looking set of clothes: jeans, a t-shirt and a jacket, and hands them to you.)\n\n")
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("Look pretty plain, don't they? They're actually woven from a nearly-indestructible nano-fabric that will give near-total immunity to any form cutting or piercing! They'll even stop bullets! I figured that bullets are a martial artists number one enemy...after spending a lifetime studying, training, perfecting your body, any idiot with a gun can shoot you dead. Hardly seems fair. With this...that won't happen.\n\n")
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("Well, thanks again for the show, enjoy your clothes, and I'll be looking to see you at the Tournament again next year!\n\n")
		dialogue.conclude()
		term.load()
		local obj = create_artifact(ART_BRIEFS_ARMOR)
		make_item_fully_identified(obj)
		dball.reward(obj)
		return
	elseif quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status == QUEST_STATUS_FINISHED then
		message("Wow! Hello! I still watch the videos of those last few fights. You were great!")
		return
	elseif quest(QUEST_BRIEFS_TOURNAMENT_REWARD).status == QUEST_STATUS_TAKEN then
		if dball_data.tourny_registered == 0 then
			message("What are you waiting for! Hurry up and go register!")
		elseif dball_data.tourny_registered == 1 then
			message("We're all rooting for you!")
		elseif dball_data.tourny_registered == 2 then
			message("Ahh...that's too bad. Looks like you lost. Oh well. Maybe next year?")
		elseif dball_data.tourny_registered == 3 then
			message("What happened? Why'd you let yourself get pushed out of the ring like that?")
		elseif dball_data.tourny_registered == 4 then
			message("That was really quite a blow that knocked you out of the Tournament.")
		else	-- If won should be handled by QUEST_COMPLETED
			message("Error in Briefs tourny quest: unacceptable registration status")
		end
		return

	-- Archaic, yes?
	--elseif dball_data.briefs_state == 4 then
	--	-- Performing Technomancer assemble quests
	--	fall_through = 1

	elseif dball_data.briefs_state == 1 or dball_data.briefs_state == 5 then
		-- Handle Buruma first
		if quest(QUEST_BRIEFS_FIND_BURUMA).status == QUEST_STATUS_COMPLETED then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Yes, Buruma mentioned she spoke to you. Thank you for finding her for me. The girl does tend to lose track of time when she's out. Come to think of it, here. Let me give you this, so you'll never lose track of time yourself.\n\n")
			dialogue.conclude()
			term.load()
			local obj = create_object(TV_BRACELET, SV_WATCH)
			make_item_fully_identified(obj)
			dball.reward(obj)
 			change_quest_status(QUEST_BRIEFS_FIND_BURUMA, QUEST_STATUS_FINISHED)
			return

		-- Handle upgrade quest next
		elseif quest(QUEST_BRIEFS_UPGRADE).status == QUEST_STATUS_TAKEN then
			if drbriefs.upgrade_check() then
				quest(QUEST_BRIEFS_UPGRADE).status = QUEST_STATUS_FINISHED
				-- Archaic?
				-- dball_data.briefs_state = 4
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("You have tools? Excellent!\n\n")
				term.text_out("Over the next several hours, Dr. Briefs give you a complete crash course in each of the technical disciplines. Briefs is obviously a technological genius, and he is an excellent instructor. You learn a great deal.\n\n")
				skill(SKILL_TECHNOLOGY).value = skill(SKILL_TECHNOLOGY).value + 10000
				skill(SKILL_CONSTRUCTION).value = skill(SKILL_CONSTRUCTION).value + 10000
				skill(SKILL_DISASSEMBLY).value = skill(SKILL_DISASSEMBLY).value + 10000
				skill(SKILL_TECHNOLOGY).dev = true
				term.text_out(color.YELLOW, "All Technology skills increased by 10!\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("It will be good to have an assistant. I've been so swamped with work lately, I've scarcely had time to work on projects of my own.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out("(You are interupted by a knock on the door.\n\n")
				term.text_out(color.LIGHT_BLUE, "Capsule Corp Delivery Boy: ")
				term.text_out("Hello, Dr Briefs. I have the parts you requested. Full set of electronics components.\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("What? I requested these three weeks ago!\n\n")
				term.text_out(color.LIGHT_BLUE, "Capsule Corp Delivery Boy: ")
				term.text_out("Would you sign here, sir?\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Unbelievable. Well, " .. player_name() .. ", now you see what I have to put up with around here. Three weeks! At least this batch arrived. Sometimes they don't. In any case, now that you'll be helping me, I'm really looking forward to be able to spend more time on my own projects. I have something really fantastic in the works! Maybe eventually I'll let you help me with that, but in the meantime, filling out electronics requisition requests for Capsule Corp will be excellent practice for you. Incidentally, please feel free to to use anything the delivery people manage to deliver, and to use the lab here to store tools and parts of your own. Now, let's get to work, shall we?\n\n")
				dialogue.conclude()
				term.load()
				local obj = create_object(TV_CIRCUITRY, SV_RESISTER)
				obj.number = 10
				drop_near(obj, -1, 3, 3)
				local obj = create_object(TV_CIRCUITRY, SV_CAPACITOR)
				obj.number = 10
				drop_near(obj, -1, 4, 3)
				local obj = create_object(TV_CIRCUITRY, SV_CIRCUIT_BOARD)
				obj.number = 10
				drop_near(obj, -1, 5, 3)
				local obj = create_object(TV_CIRCUITRY, SV_SPOOL_OF_WIRE)
				obj.number = 10
				drop_near(obj, -1, 3, 4)
				local obj = create_object(TV_CIRCUITRY, SV_SPOOL_OF_SOLDER)
				obj.number = 10
				drop_near(obj, -1, 4, 4)
				local obj = create_object(TV_CIRCUITRY, SV_EPROM)
				obj.number = 10
				drop_near(obj, -1, 5, 4)

				fall_through = 1

			else
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("You still need a complete set of tools.")
			end

		-- Otherwise, just go to retrieve quest handling
		elseif drbriefs.quest_issued > 0 then
			drbriefs.quest_qty1 = drbriefs.quest_qty1 - drbriefs.deliver_item(drbriefs.quest_kidx1, drbriefs.quest_qty1)
			drbriefs.quest_qty2 = drbriefs.quest_qty2 - drbriefs.deliver_item(drbriefs.quest_kidx2, drbriefs.quest_qty2)

			if drbriefs.quest_qty1 > 0 then
				local obj = new_object()
				object_prep(obj, drbriefs.quest_kidx1)
				obj.number = drbriefs.quest_qty1
				make_item_fully_identified(obj)
				message("I still need " .. drbriefs.quest_qty1 .. " " .. object_desc(obj))
				delete_object(obj)
			end
			if drbriefs.quest_qty2 > 0 then
				local obj = new_object()
				object_prep(obj, drbriefs.quest_kidx2)
				obj.number = drbriefs.quest_qty2
				make_item_fully_identified(obj)
				message("I still need " .. drbriefs.quest_qty2 .. " " .. object_desc(obj))
				delete_object(obj)
			end

			if drbriefs.quest_qty1 + drbriefs.quest_qty2 == 0 then
				-- Quest completed:
				drbriefs.quest_issued = 0

				-- Was this the Time machine quest we just completed?
				if quest(QUEST_BRIEFS_FIRST).status == QUEST_STATUS_TAKEN then
					quest(QUEST_BRIEFS_FIRST).status = QUEST_STATUS_FINISHED
					drbriefs.quest_issued = 0
					term.save()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Thank you! Now, all I need to do is take these and...\n\n")
					term.text_out("Dr. Briefs dismantles a small device on his workbench and conducts repairs.)\n\n")
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("\n\nExcellent! It works!\n\n")

					local turn = time.display_turn(turn)
					local hour = time(time.HOUR, turn)
					local minute = time(time.MINUTE, turn)
					local ampm = " am"
					if hour > 12 then
						hour = hour - 12
						ampm = " pm"
					end
					local cur_time = hour .. ":" .. minute .. ampm

					term.text_out("(Dr. Briefs presses a small button on his 'Time Machine' and the display is turned on. It is now " .. cur_time .. ". Oops. THAT kind of 'Time' machine. You feel a little silly over the misunderstanding, but Dr. Briefs seems not to notice.\n\n")
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Well, now...I've been wanting that fixed for a while. I tend to lose track of time when I'm here in the lab, and Buruma sometimes worries about me. By the way...I appreciate your help. Whenever I submit inventory requests to the parts department it takes a week for them to get back to me. Here, let me teach you something in return...\n\n")
					dialogue.conclude()
					term.load()
					dball.enroll(FLAG_ENROLL_BRIEFS_SOME)
					return
				else
					-- This was a Technomancer quest
					drbriefs.quest_issued = 0
					term.save()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Ahhh...excellent. I'm sure the requisitions department will be delighted.\n\n")
					-- dialogue.helper("I'm glad to be of help.", "a")
					dialogue.helper("Would you teach me more?", "b")
					dialogue.helper("I'm ready to fill another order.", "c")
					local ans = dialogue.answer()
					term.load()
					if ans == "a" then
					elseif ans == "b" then
						dball.enroll(FLAG_ENROLL_BRIEFS_ALL)
						fall_through = 1
					elseif ans == "c" then 
						fall_through = 1
					end
				end
			end
		else
			-- First quest done, but not a Technomancer
			term.save()
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Hello again.\n\n")
			dialogue.helper("Hello. You look busy. Sorry to bother you.", "a")
			if skill(SKILL_TECHNOLOGY).value < 20000 then
				dialogue.helper("Would you teach me more?", "b")
			else
				dialogue.helper("I really appreciate everything you've taught me, but I think I'd like to make a real vocation out of it. What would you suggest if I wanted to take the next step?", "c")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
			elseif ans == "b" then
				dball.enroll(FLAG_ENROLL_BRIEFS_SOME)
				return
			elseif ans == "c" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Hmm. Now that you mention it...I really could use an assistant. We've had a difficult time finding competant technicians recently, and I've found myself personally filling requsitions requests for a lot of very simple pieces of equipment. Would you be interested in an unpaid internship? You can fill whatever requests come in, and in return I'll teach you what I know. All I ask is that you procure your own tools. Have we a deal?\n\n")
				dialogue.helper("Yes, that sounds good to me.", "a")
				dialogue.helper("No...that's not really a direction I want to go in. Thank you for the offer, though.", "b")
				local ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Excellent! Let me know when you have a full set of tools, and we'll begin!\n\n")
					dialogue.conclude()
					term.load()
					acquire_quest(QUEST_BRIEFS_UPGRADE)
					return
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("That's ok. It's not for everybody. Let me know if you change your mind.\n\n")
					dialogue.conclude()
					term.load()
					return
				end
			end
		end
	elseif dball_data.briefs_state == 2 then
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("You again? Leave, now!")
		return
	elseif dball_data.briefs_state == 0 then
		dball_data.briefs_state = 1
		term.save()
		term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
		term.text_out("...test result positive, with residual indications of a relay overcharge ratio of...zero?. Curious. I'm flooding the relay. That would imply a - oh! Of course! There's simply a break in the conduit! It was so obvious! All I need to conduct repairs is...oh...hello. I'm sorry, I didn't see you come in. Who are you?\n\n")
		dialogue.helper("My name is " .. player_name() .. ". Nice to meet you. What's that you're working on?", "a")
		if quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_UNTAKEN then
			dialogue.helper("I am the world's greatest martial artist! Who are you?", "b")
		end
		if dball_data.alignment < 0 then
			dialogue.helper("I am a thief, and a murderer. I am here to kill and rob you. (Attack)", "c")
		end
		dialogue.helper("Nobody in particular. Sorry, I must be lost. I'll leave now.", "d")

		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			term.save()
			term.text_out("(Dr. Briefs looks back and forth a few times, then leans in and whispers:)\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("It's a time machine. I built it several years ago, but it broke from constant use. But now, I've just figured out what the problem is! Hmm. You seem like a reliable " .. gendernouns.guygirl .. ". Perhaps you'd be willing to help me fix it? It's silly, really...all I need is some wire and solder. Would you run out to R-VAC and grab me some?\n\n")
			dialogue.helper("Sure.", "a")
			dialogue.helper("I think I'll 'past,' thanks.", "b")
			if dball_data.alignment < 0 then
				dialogue.helper("No, I'm actually here from the future to stop you. After you fixed your machine you inadvertantly brought on a horrible, earth shattering catastrophe.\n", "c")
			end
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Excellent! Oh...also, since you're headed out anyway, if you happen to see my daughter, Buruma, could you let her know that I've finished the repairs she asked me to do? Thanks!\n\n")
				dball_data.briefs_state = 1
				dialogue.conclude()
				term.load()
 				change_quest_status(QUEST_BRIEFS_FIRST, QUEST_STATUS_TAKEN)
 				change_quest_status(QUEST_BRIEFS_FIND_BURUMA, QUEST_STATUS_TAKEN)
				-- Briefs first quest if fixed
				drbriefs.quest_no = 1		-- Quest number one, fixed: QUEST_TIME_MACHINE
				drbriefs.quest_rating = 2	-- Two items to retrieve (...not used for this quest...)
				drbriefs.quest_issued = 1	-- Yes
				drbriefs.quest_kidx1 = lookup_kind(TV_CIRCUITRY, SV_SPOOL_OF_WIRE)
				drbriefs.quest_qty1 = 1
				drbriefs.quest_kidx2 = lookup_kind(TV_CIRCUITRY, SV_SPOOL_OF_SOLDER)
				drbriefs.quest_qty2 = 1

				return
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Hmm...well, alright. I'll see if I can find someone from the mail room to make the trip for me.\n\n")
				dball_data.briefs_state = 3
				dialogue.conclude()
				term.load()
				return
			elseif ans == "c" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Oh, dear! Goodness! How terrible! What happens?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("It is indeed terrible! five years from now the entire world is a horrible, shattered place! Entire societies genocided, most major cities destroyed, people and children starving and dying in the streets...the very survival of our race is uncertain! All you because of your time machine!\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("No! I cannot be! I won't let it happen...I'll destroy this infernal machine!\n\n")
				term.text_out("Dr. Briefs pulls out a short-wave atomitizer and immediately begins disintegrating the delicate innards of his machine.\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("There. That should do it. It would take six months to rebuild it now, and I've no intention of ever touching it again.\n\n")
				term.text_out("Right at that moment, a teenage boy with platinum blonde hair bursts into the room...\n\n")
				dialogue.conclude()
				term.load()
				dball.place_monster(4, 8, "Trunks")
				term.save()
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("Dr. Briefs!\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Oh. Hello, youngster. What can I do for you?\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("I'm here to help avert a terrible tragedy! Is mother in?\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Tragedy? Mother? What are you talking about? Who are you?\n\n")
				term.text_out("There is a moment of silence in the room before the boy speaks.\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("I'm...your grandson.\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Grandson? Impossible! I don't have any grandchildren. I only have one girl, my daughter Buruma, and she's not even married yet!\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("You're right, grandfather. Not...not yet.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out("Over the next few hours Trunks explains a very complicated tale. It seems that he is from 17 years in the future. When he was a small boy, perhaps 3 or 4 years old, a pair of Androids suddenly appeared from nowhere and went on a massive killing spree, destroying most of the populated centers of the entire planet. For nearly his entire life the human race has lived in fear as this dastardly duo continuously ravaged the planet. Noone knew where they came from, until a scant few months before Trunks' departure, when the present caught up with the future, and it was discovered that the Androids were created by a certain Dr. Gero for the purpose of controlling the world. Bad enough, but apparantly they broke free of their creators control, and discovered that Gero had built into each of them a 'Remote Stop' self destruct device to allow him to destroy them should they ever betray him. So, to avoid their own demise, they stole his time machine and travelled into their own past, Trunks childhood, and killed Dr Gero and the entire puppet Red Ribbon Army organization under his control.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("And ever since then they've hated and murdered any human they come across! It's so horrble! I can't stand living like this! Constantly being afraid that the Androids will appear, powerless to stop them!\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("And so you need Dr Briefs' time machine to save the world, right?\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("Hmm? No, I already have one. Why do you ask?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Really? Umm...are you sure?\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("Of course, you idiot! I just explained that I came to the past in a time machine. What would I need another one for?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Hmm. No reason, I guess. I just sort of assumed you would...for some reason.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("No. My plan was to go back before the Androids arrival and help prepare so that the worlds greatest fighters will be ready and waiting for them.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Well, from what you've explained, it soudns like we have several years to prepare. Five or six, from the sound of it. That should be plenty.\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("Yes.\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("No...not necessarily.\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("What? Why not?\n\n")
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Time is not a static thing.  It's very flexible, very...delicate. It's like water. And, just like how when you toss a stone into a lake it creates ripples that effect the entire surface of the lake, so too does the slightest perturbation cause ripples in the fabric of time.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("What would cause ripples in this case?\n\n")
				term.text_out(color.LIGHT_BLUE, "Trunks: ")
				term.text_out("...me. My arrival. My being here. I haven't even been born yet! Mother hasn't even met my father yet!\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Exactly. And every single person who knows about you, knows what's to come, is going to make the ripple even bigger. We'd best keep quiet about our preparations. I hope you're right, and that we do have several years to prepare, but we'd better not count on it. It's possible...it's just possible...that...\n\nThe Androids could arrive at any moment.\n\n")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_ANDROIDS, QUEST_STATUS_TAKEN)
				dball_data.ttq_tripped = 2	-- (Cause of trigger)
				dball_data.ttq_day_tripped = dball.dayofyear()
				return
			end
		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			if dball_data.tourny_registered == 0 then
				term.text_out("Oh? You must be here for the Tournament, then. So you're the best, huh? And you're going to win? Well, maybe it's fate that brought you here. It just so happens that I'm quite a fan of competetive tournaments. Not participating, I'm afraid, just watching. This year I've decided to contribute a very special prize to the winning fighter. Extremely special. I'm not going to say what it is, but I think you'll be quite pleased with it...AFTER you've won the Tournament. In the meantime, you'll just have to wait. So go ahead and put on a good show for us! Come back after you've won.\n\n")
				dialogue.conclude()
				term.load()
				acquire_quest(QUEST_BRIEFS_TOURNAMENT_REWARD)
			elseif dball_data.tourny_registered == 1 then
				term.text_out("Oh, yes. Now that you mention it, I do recall seeing you in the World Tournament on television recently. Nice to meet you. My name's Briefs. I suppose you might say I'm a tinker, of sorts. Hey...since you're a martial artist, how would you like to run an errand for me? It happens that there's a professional fighter who goes by the name of Mr. Satan who lives nearby, and he recently asked me to fix an electric muscle stimulator for him. I'm working on it now. Turns out it uses an internal battery to maintain its timing, and it just needs to be replaced. All I need is a standard battery, purchasable at any electronixs store. How'd you like to go pick one up for me?\n\n")
				dialogue.helper("Certainly.", "a")
				dialogue.helper("No, thank you.", "b")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Excellent. Thank you.")
	 				change_quest_status(QUEST_BRIEFS_SATAN, QUEST_STATUS_TAKEN)
					return
				elseif ans == "b" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("That's ok. I probably have one lying around here anyway.")
					dball_data.briefs_state = 3
					return
				end
			elseif dball_data.tourny_registered == 5 then
				term.load()
				message("Won the Tournament conversation path not implemented")
			elseif dball_data.tourny_registered == 2 then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Really? That's quite a claim. Oh...I recognize you now. I saw you on television recently. Weren't you defeated recently in the World Tournament?\n\n")
				dialogue.helper("Yes, I'm afraid that was me.", "a")
				dialogue.helper("No, must have been someone else.", "b")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Conversation Path not implemented")
					-- dball_data.briefs_state = 3
					return
				elseif ans == "b" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Hmm. Ok. Looked just like you. Well, anyway...I must get back to work. Excuse me.")
					dball_data.briefs_state = 3
					return
				end
			else
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
				term.text_out("Oh? How very interesting that you say so. I think I remember seeing you on television recently. Weren't you disqualified from the World Tournament\n\n")
				dialogue.helper("Yes, I'm afraid that was me.", "a")
				dialogue.helper("No, must have been someone else.", "b")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Conversation Path not implemented")
					-- dball_data.briefs_state = 3
					return
				elseif ans == "b" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
					term.text_out("Hmm. Ok. Looked just like you, I guess. Well, anyway...I must get back to work. Excuse me.")
					dball_data.briefs_state = 3
					return
				end
			end
		elseif ans == "c" then
			term.load()
			dball_data.briefs_state = 2
			dball.chalign(-50)
			player.redraw[FLAG_PR_BASIC] = true
			dball.faction_annoy(FACTION_GOOD)
			return
		elseif ans == "d" then
			term.load()
			dball_data.briefs_state = 3
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("No problem. Have a good day.")
			return
		end
	end


	if fall_through == 0 then
		return
	end

	-- Handler causes this to only ever be reached if no quest is currently pending, yes?

	dball_data.briefs_assemble_quest_counter = dball_data.briefs_assemble_quest_counter + 1

	-- Gah! Old! Necessary, but let's move away from this!
	drbriefs.quest_issued = 1

	-- local item_kidx, desc = dball.get_technomancer_quest(dball_data.briefs_assemble_quest_counter)
	local item_kidx = dball.get_technomancer_quest(dball_data.briefs_assemble_quest_counter)

	local obj_bp = new_object()
	object_prep(obj_bp, lookup_kind(TV_BLUEPRINTS, SV_EASY_BLUEPRINTS))
	make_item_fully_identified(obj_bp)
	obj_bp.number = 1
	obj_bp.flags[FLAG_TECHNO_PLANS] = item_kidx + 1
	obj_bp.flags[FLAG_ID_VALUE] = 0
	drbriefs.quest_issued = dball_data.briefs_assemble_quest_counter
	drbriefs.quest_kidx1 = item_kidx
	drbriefs.quest_qty1 = 1
	local desc = k_info[item_kidx + 1].name
	term.save()
	term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
	term.text_out("Let's see...I have here an order for one " .. desc .. ". Oh, good. ")
	if tech_known[item_kidx] == false then
		term.text_out("It will be useful for you to know how to build those. Here. let me give you a set of blueprints to work from. ")
	else
		term.text_out("I see you already know how to build those. This should go quickly then. ")
	end
	term.text_out("Let me know when you're finished. Thanks!\n\n")
	dialogue.conclude()
	term.load()

	change_quest_status(QUEST_BRIEFS_RANDOM, QUEST_STATUS_TAKEN)
	dball_data.briefs_state = 5

	if tech_known[item_kidx] == true then
		delete_object(obj_bp)
	else
		dball.reward(obj_bp)
	end
end

function dialogue.PILAF_KILL()
	term.gotoxy(0, 0)
	factions.set_friendliness(FACTION_PILAF, FACTION_PLAYER, -100)
	factions.set_friendliness(FACTION_PLAYER, FACTION_PILAF, -100)
	for_each_monster(function(m_idx, monst)
		if monst.r_idx ~= RACE_PILAF then
			monst.ai = ai.ZOMBIE
		end
	end)
end

function dialogue.PILAF_EXECUTE()
	term.gotoxy(0, 0)
	if dball_data.pilaf_execute == 1 and quest(QUEST_PILAF_EXECUTE).status == QUEST_STATUS_TAKEN then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Such loyalty!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Wow. " .. gendernouns.heshe .. " really did it. Not very bright.\n\n")
		dialogue.conclude()
		term.load()
	end
end

function dialogue.PILAF()
	term.gotoxy(0, 0)

	if factions.get_friendliness(FACTION_PLAYER, FACTION_PILAF) < 0 then
		if dball_data.mai + dball_data.shuu == 0 then
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("...I hope we can work past our previous misunderstandings...")
		elseif dball_data.mai == 0 and dball_data.shuu == 1 then
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Mai! Kill this traitorous buffoon!")
			dialogue.PILAF_KILL()
		elseif dball_data.mai == 1 and dball_data.shuu == 0 then
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Shuu! Kill this traitor!")
			dialogue.PILAF_KILL()
		else
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("You will die terribly, horribly and painfully! Hahahah!!!")
			dialogue.PILAF_KILL()
			return
		end
	end

	-- Does the player have a Dragonball?
	if dball.dragonballs_carried() > 0 then
		if quest(QUEST_PILAF_DRAGONBALLS).status == QUEST_STATUS_TAKEN then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Ahh! You have returned with a Dragonball! This is most excellent!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Uh-oh. Looks like you're out of a job, Shuu.\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("Wow! Really? Do you promise?!!?!?\n\n")
		else
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Ahhh! Another unworthy subject arrives at the palace to heap praise upon me!\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("Psst. ...Pilaf...\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Very well, if you insist, I will listen to you tell me how great and powerful I am!\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("Pilaf...there's something you should know...\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("It does bore me to hear it over and over, day in day out, of course...\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Try calling him 'Emperor,' Shuu. He always responds better to that.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("...but I...the GREAT EMPEROR PILAF am a wise and humble emperor...\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("I know, but I really prefer not to encourage him.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("...and in my magnanimity allow my subjects the esteemed privilage of basking me in the supreme light of my own glory!\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("HEY PILAF!!! " .. gendernouns.heshe .. "'s got a DRAGONBALL!!!\n\n")
			term.text_out("(There is a moment of silence as all eyes are on you.)\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("A dragonball, you say?\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("Yes. In " .. gendernouns.hisher .. " pack.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("How do you know?\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("Well...I AM a ninja. It's sort of our job to be snoopy and pay attention to things like that.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("I see. Well then...how wonderful! This lowly peasant has found a dragonball, and in " .. gendernouns.hisher .. " uncommon wisdom, for a peasant, come to give it to the most worthy being on the planet! Me. Thank you, servant! I accept your gift. You may give me the dragonball.\n\n")
		end

		-- Whether or not has quest, same options:

		dialogue.helper("No, actually I didn't come to give you this.", "a")
		dialogue.helper("(Sorry. Not implemented) Sure. Here you go, Oh Emperor Pilaf.", "b")
		dialogue.helper("Oops. (Run!)", "c")
		if dball.persuade(14) then
			dialogue.helper("(Persuade 14) Oh, magnificent Emperor Pilaf! I am here to humbly obey, but would it not perhaps be best to keep such a precious prize safely hidden away? The Red Army is so close, and it would be a shame to lose this great artifact! I happen to know a place...not far from here...very safe...", "d")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Oh.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("I think that was the wrong answer, wasn't it?\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("I think you're right, Mai. I think 'Of course, oh wise and noble Emperor Pilaf...SIR was the correct answer.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Maybe...but I don't remember seeing that as one of the dialogue options.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Ahhh! That explains it then. Let's try this again with that as an option, shall we?\n\n")
			dialogue.helper("I'm not handing it over.", "a")
			dialogue.helper("(Also not implemented) Of course, oh wise and noble Emperor Pilaf...SIR!", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Oh. That's ok. I don't mind. Mai! Shuu! Kill " .. gendernouns.himher .. "!\n\n")
				dialogue.conclude()
				term.load()
				dialogue.PILAF_KILL()
				return
			elseif ans == "b" then
			end
		elseif ans == "b" then
			local ndbs = dball.dragonballs_deliver()
			dball_data.pilaf_dragonballs = dball_data.pilaf_dragonballs + ndbs
			message("Delivered! (Implement branch)")
		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Mai! Shuu! Kill " .. gendernouns.himher .. "!")
			dialogue.PILAF_KILL()
		elseif ans == "d" then
			-- Implement: decide whether this counts to increment the persuade counter
			-- dball_data.persuades = dball_data.persuades + 1
			term.save()
			term.text_out("(There is a few monets of silence.)\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Hmm. Maybe. Oh, I don't know...what do you think, Mai?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("I don't buy it. I think it's a trick.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Of course, but come on..." .. gendernouns.hisher .. " charisma is " .. player.stat(A_CHR) .. ". That's got to be worth something?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Oh, come now...the last person who tried that had a charisma of " .. player.stat(A_CHR) + 7 .. " at least, and you didn't let her get away.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Oh, all right. I was feeling generous, but if you insist. Kill " .. gendernouns.himher .. "\n\n")
			dialogue.conclude()
			term.load()
			dialogue.PILAF_KILL()
		end

		return
	end

	if quest(QUEST_PILAF_EXECUTE).status == QUEST_STATUS_TAKEN then
		message("Implement path!")

	elseif quest(QUEST_PILAF_RETURN).status == QUEST_STATUS_TAKEN then
		message("Implement path!")


	elseif quest(QUEST_PILAF_RRA).status == QUEST_STATUS_TAKEN then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Take your time. The Army is a powerful adversary, and I am willing to wait for results.\n\n")
		dialogue.conclude()
		term.load()
		return
	elseif quest(QUEST_PILAF_RRA).status == QUEST_STATUS_COMPLETED then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Hahah! Great victory! This should be implemented!")
		dialogue.conclude()
		term.load()
		return
	end
		

	if dball_data.pilaf_interupted == 1 then
		term.save()
		if race_info_idx(RACE_MAI, 0).max_num > 0 then
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Oh...I think I broke a nail.\n\n")
		end
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("See what I mean?!?! They're an absolute abomination, and running amuck everywhere! Servant, I command you to destroy the Red Ribbon Army and retrieve the Dragonballs!\n\n")
		dialogue.conclude()
		term.load()
		dball_data.pilaf_interupted = 0
		change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
		change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
		if factions.get_friendliness(FACTION_PLAYER, FACTION_PILAF) >= 0 then
			for_each_monster(function(m_idx, monst)
				monst.ai = ai.NEVER_MOVE
			end)
		end
		return
	end

	if dball_data.pilaf_polite_done == 1 then
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Ahh..." .. gendernouns.heshe .. " returns to gape at my majesty.")
		return
	elseif dball_data.pilaf_polite_done == 2 then
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Get out of here you buffoon!")
		return
	elseif dball_data.pilaf_polite_done == 3 then
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Hello, again.")
		return
	end

	if quest(QUEST_PILAF_RUBBLE).status == QUEST_STATUS_TAKEN then
		local rubble_check = 0
		for i = 1, cur_wid - 2 do
			for j = 1, cur_hgt - 2 do
				if cave(j, i).feat == FEAT_RUBBLE then
					rubble_check = 1
				end
			end
		end

		if rubble_check == 0 then
			-- if dball_data.pilaf_dungeon_for_ms == 0 then
				-- change_quest_status(QUEST_PILAF_RUBBLE, QUEST_STATUS_FINISHED)
				quest(QUEST_PILAF_RUBBLE).status = QUEST_STATUS_FINISHED
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Excellent! For your loyalty, I hereby promote you to the rank of 'Moderately-Pathetic Lowly Servant'! \n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Hey, that's pretty good. It took me a couple days to get that rank.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("And now, for your third task, I order you to throw Mai and Shuu into the dungeon!\n\n")
				dialogue.helper("Umm...what dungeon?", "a")
				local ans = dialogue.answer()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("What do you mean 'what dungeon?' THE DUNGEON YOU JUST UNCOVERED FROM UNDER THE RUBBLE, YOU IDIOT!!!")
				dialogue.helper("I removed all the rubble, but I never found a dungeon.", "a")
				local ans = dialogue.answer()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("WHAT!?!?! No dungeon!?!?! MAI!!!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Yes?\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Where is the dungeon!?!?!?\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Well...we did say that we had only STARTED building it, didn't we? I thought it was pretty clear that we didn't get very far. Hmm. As I recall...we were still trying to decide where to put it when the roof collpased...\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("I thought we decided to start digging in the southeast corner over there.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("The southeast corner? No, I don't like that corner. Too much light from the windows. A proper dungeon entrance should be dark and gloomy. It would be bad feng shui, otherwise.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Alright, I get the idea. Mai, you go build the dungeon. Shuu, once Mai is done, throw her into the dungeon and lose the key. " .. player_name() .. ", I have a special task for you.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("I have recently learned that an evil organization known as the Red Ribbon Army is roving the countryside is search of the Legendary Dragonballs! Seven mystic orbs crafted by Kami, the God of the Earth, Himself. Orbs that once gathered together allow their master to bring forth the Eternal Dragon of the Earth, Shenron, to grant his summoner a single wish. The Red Ribbon Army cannot be allowed to wield such power! Only I am entitled to the power of the Dragonballs, and only I am deserving of the Dragon's wish! ")
				term.text_out("And so, my trusted servant, I charge you with these tasks: You must recover the Dragonballs for me before the Army succeeds in their quest! Further, it is likely that they have already recovered some of them, so I further entrust to you the task of obliterating the Red Ribbon Army, and slaying their leader, Commander Red, so that noe may ever again oppose my greatness! Go, now, and heaven speed to you!\n\n")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
				change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
				if quest(QUEST_DRAGONBALLS).status == QUEST_STATUS_UNTAKEN then
					change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)
				end
			return
		else
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("There is still rubble to be cleared.")
			return
		end
	end

	term.save()
	term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
	term.text_out("Ahhh! Another of my unworthy subjects arrives at the castle to heap praise upon me! Very well, if you insist, I will listen to you tell me how great and powerful I am! It does so bore me to hear it over and over all day, day in day out, of course, but I...the GREAT EMPEROR PILAF am a wise and humble emperor, and in my magnanimity allow my subjects the esteemed privilage of basking me in the supreme light of my own glory! So, very well...since your heart is very obviously bursting with joy and passion at my divine magnifigance, I will listen to your praise. You may begin. \n\n")
	dialogue.helper("Oh! Great Emperor! I am awestruck by your supreme majesty! This is truly the greatest day of my life!", "a")
	dialogue.helper("Umm...forgive me, your majesty...I must...be...umm...incapable of truly appreciating your...qualities.", "b")
	dialogue.helper("You're not serious, are you?", "c")
	dialogue.helper("No, actually I was just exploring the forest. Who are you and where am I?", "d")
	dialogue.helper("Hmm. I think I'm going to kill you now. (Attack)", "e")
	local ans = dialogue.answer()
	if ans == "a" then
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Wow...you're not very bright, are you?\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("It is just appearances, Mai. For, whose spirit could possibly shine brightly enough to even be visible in the hall of my supreme luminosity?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("How about Darth Vader?\n\n")
		term.text_out(color.LIGHT_BLUE, "Shuu: ")
		term.text_out("Or what about that guy from The Black Hole?\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Silence!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Oh! I know! Ingerr Borgman!\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("I said SILENCE!\n\n")
		dialogue.helper("(Sneak off while they're arguing.)", "a")
		dialogue.helper("(Stay)", "b")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			return
		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("The headless horseman from Sleepy Hollow?\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("No...bad example. His pumpkins glowed in the dark.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Oh, right. \n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("There shall be SILENCE! Even though you are the highest ranked of my servants...\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Of course we are. We're your only servants. \n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("...if you do not be respectful and silent immediately I will order you both cast into the dungeon, forever!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("We don't have a dungeon, yet. We're still rebuilding from when the giant monkey destroyed it. Remember?\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("And who would carry out the order, anyway?\n\n")
			dialogue.helper("(Sneak off while they're arguing.)", "a")
			dialogue.helper("(Stay)", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				return
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Wait...I thought we built the dungeon last week?\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("We started on it, but then the second story collapsed and filled in the hole we had starting digging, remember?\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Oh, that's right. What if we --\n\n")
				term.text_out("(While Mai and Shuu continue their discussion, Emperor Pilaf turns to you)\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("As you can see, it is sometimes difficult for a person in my position to find quality servants. Most people are so overwhelmed by my power and glory that they cannot bring themselves to enter into my light, even though in the very depths of their heart they know it is the highest possible avenue of service available in this world, or the next. Consequently, sometimes I must make do with servants of somewhat questionable ability. \n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("...why would we want to rebuild the dungeon? He's just going to order us thrown into it.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("You, however, have come to me of your own free will, and so you are obviously somewhat less unworthy than most.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Right, but like you said, neither of us are actually going to throw the other into it, so we'd be perfectly safe.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Thus, I offer you a chance for glory beyond any other you might know! Serve me, love me, obey me...do my bidding to your dying day, and you shall know reward beyond any other! Do you accept?\n\n")
				dialogue.helper("Yes", "a")
				dialogue.helper("No", "b")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Excellent! Your first task is to throw these two fools into the dungeon!\n")
					term.text_out(color.LIGHT_BLUE, "Shuu: ")
					term.text_out("We don't HAVE a dungeon.\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Of course we don't have a dungeon! Who said anything about a dungeon?\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("You did.\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Buffoons! I said nothing about a dungeon! You will learn to pay attention once you've been thrown into the dungeon! " .. player_name() .. ", for your first task, you must build a dungeon and then throw these fools into it!\n")
					term.text_out(color.LIGHT_BLUE, "Shuu: ")
					term.text_out("Build a dungeon? Isn't that kind of a lot to ask the new " .. gendernouns.guygirl .. "?\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Well, if " .. gendernouns.heshe .. " starts by cleaning up all the rubble that filled the old hole, " .. gendernouns.heshe .. " could pick up the work where we left off. Save a lot of time that way.\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("SILENCE YOU FOOLS! Were you not paying attention? I just ordered the cleanup of the castle rubble! I said nothing about dungeons!\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Yes you did. I can see it on the screen right now. The dialogue doesn't clear right away. See that line up top, where it says 'Emperor Pilaf: Excellent! For your first -.\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Quickly, " .. player_name() .. "! I order you to press a key!\n\n")
					dialogue.helper("Umm...ok.", "a")
					local ans = dialogue.answer()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Hey! I wasn't finished reading!\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Haha! And now, my glorious servant! I give you your second task! Clean up all the rubble from the castle floor, and find that dungeon!\n\n")
					dialogue.conclude()
					term.load()
	 				change_quest_status(QUEST_PILAF_RUBBLE, QUEST_STATUS_TAKEN)
				elseif ans == "b" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Excellent! Since you have so eagerly come into my service, unlike certain other incompetant buffoons who had to be coerced, I shall grant you the leniency of a simple first task to complete on my behalf.\n\n")
					dialogue.helper("No, I said 'no.'", "a")
					local ans = dialogue.answer()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Yes, and I'm very glad you said yes. For your first task, I would like you to run a simple errand for me. As you know, such a grand and glorious Emperor as myself is destined to rule the world, but it seems that a foolish and incompetant little band of children who call themselves the 'Red Ribbon Army' have decided to try to rule the world themselves. At first I dismissed them, simply because I am so kind and forgiving. But, as time has passed, their activities have increasingly become an insult to my greatness, and I believe the world would be a better place if their activities were halted. I would like for you to arrange this.\n\n")
					dialogue.helper("Pilaf...you're not listening. I'm not going to help you.", "a")
					local ans = dialogue.answer()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Ahh, yes...I appreciate your enthusiasm to do my bidding. Since you are such a loyal servant, I will grant you the opportunity to please me even further by giving you a second task as well. It seems that in their boyish recklessness, the Red Ribbon Army has accidentally stumbled upon a great secret. The Dragonballs.\n\n")
					dialogue.helper("I SAID I'M NOT GOING TO...Dragonballs?", "a")
					local ans = dialogue.answer()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					if quest(QUEST_DRAGONBALLS).status == QUEST_STATUS_TAKEN then
						term.text_out("Yes, my ninja-spy, Shuu, has discovered that not only has the Red Army discovered the secret...but they have actually recovered one of the Dragonballs already!\n\n")
						term.text_out(color.LIGHT_BLUE, "Shuu: ")
						term.text_out("I'm a good kitty, aren't I?\n\n")
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("Yes, a very good kitty. And sneaky, too.\n\n")
						term.text_out(color.LIGHT_BLUE, "Shuu: ")
						term.text_out("...purr...purr...\n\n")
					else
						term.text_out("Yes, the Dragonballs. They are a magical set of spheres made by the God of the Earth Himself. Seven mystic orbs that, once gathered together allow their master to summon the Eternal Drgaon of the Earth, Shenron, to grant his summoner a single wish. The Red Ribbon Army cannot be allowed to wield such power! Only I am entitled to the power of the Dragonballs, and only I am deserving of the Dragon's wish! ")
					end
					term.text_out("And so, my trusted servant, I charge you with the task of destroying the Red Ribbon Army, and returning to me the Dragonball they have in their possession!\n\n")
					dialogue.helper("Hmm. Thank you for the clarification. I'll...look into it.", "a")
					dialogue.helper("That's all very interesting, but I'm still not going to help you.", "b")
					local ans = dialogue.answer()
					if ans == "a" then
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("Excellent. The RRA is a very large organization and you should have no difficulty finding them. They have three primary installations that I am aware of. First, Muscle Tower in the snowy mountains across the ocean to the southwest. Somehwere in that ocean there is reputed to be an underwater submarine base. And finally, the Supreme Headquarters of the RRA is just slightly east of Muscle Toewr. It is highly defended, and I recommend extreme caution.\n\n")
						dialogue.conclude()
						term.load()
						change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
						change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
						if quest(QUEST_DRAGONBALLS).status == QUEST_STATUS_UNTAKEN then
							change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)
						end
					elseif ans == "b" then
						term.load()
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("I see. Very well. Mai, Shuu...kill " .. gendernouns.himher)
						quest(QUEST_DRAGONBALLS).status = QUEST_STATUS_TAKEN
						factions.set_friendliness(FACTION_PILAF, FACTION_PLAYER, -100)
						factions.set_friendliness(FACTION_PLAYER, FACTION_PILAF, -100)
						dialogue.PILAF_KILL()
					end
				end
			end
		end
	elseif ans == "b" then
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Don't worry, then. You're in good company.\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Yes! You are in the Greatest Company! Mine! Say...I think I rather like this new one. Perhaps " .. gendernouns.heshe .. " is worthy of the esteemed privilage of serving me! What say you, my unworthy advisors?\n\n")
		term.text_out(color.LIGHT_BLUE, "Shuu: ")
		term.text_out("Meow...?\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Excellent! It is decided then! You shall be exalted in the world with the rank of 'Utterly-Pathetic Lowly Servant'! And, as I am wise and all-knowing, I know you are craving down to the very depths of your heart a task...a service to perform for your Great Lord! And, such a Lord am I, that I will grant your request and bestow upon you such a task! Aren't I kind and just?\n\n")
		dialogue.helper("'Kind and just' Like no other", "a")
		dialogue.helper("Kind of just a loon, maybe", "b")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Indeed I am! I am so kind, and so just, that I will take pity on you and offer you a position on my staff! \n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Great. Another one.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("You're just envious, Mai. " .. player_name() .. ", I hereby induct you into my service, and grant you the rank of 'Utterly-Pathetic Lowly Servant!' See? Not only am I kind and just, I am also gracious, and humble!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("'Like no other,' yes, we covered this already.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Hmm. Since you're now my servant, perhaps I should give you some orders, hmm?\n\n")
			dialogue.helper("Yes, please.", "a")
			dialogue.helper("Orders? ...umm...well...don't feel like you need to, uhh...go out of your way for me, or anything.", "b")
			dialogue.helper("What? I'm not your servant, and I'm not taking any order from you.", "c")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Ahhhh! Such enthusiams!\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Such silliness.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Yes, are you sure you're feeling well " .. player_name() .. "? Would you like to lie down for a bit?\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Nonsense! " .. player_name() .. " wishes with all " .. gendernouns.hisher .. " heart to rush right out and retreive the dragonballs for me!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Oh, dear...not this again. Are you sure you wouldn't like to lie down yourself, 'oh-emperor?'\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Hmm. Actually a nap sounds rather nice right now, but I'm busy giving orders, and you know how much I enjoy giving orders.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Yes...don't I just.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("*ahem* And so, " .. player_name() .. " I entrust you with the following task:\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("A short distance east of my Castle lies Muscle Tower, the despicable home of the Red Ribbon Army!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Despicable? Actually, it's a rather nice place, I thought. Certainty cleaner than ours.\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Late 18th century architecture. It's quite a treat, really.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("The Red Army is ruled with an iron fist by Commander Red, the most horrible dictator ever to wield such power! Why, at this very moment he's trying to position the Red Army to take over the entire world! Can you imagine? The nerve! Nobody is allowed to rule my planet but me! Now, ordinarily I wouldn't tolerate such foolishness, but it also happens that the army is, well...kind of a little bit powerful, and despite all the efforts of my worthy servants, I have yet to mitigate the threat that they pose...\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Mai! He called us 'worthy!' Wow! Could we get that in writing?\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("'Worthy.' Us. Wow, I feel so warm and happy inside. :)\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("...for the Red Ribbon Army has in its position one of the legendary dragonballs, sacred orbs conjured by the God of the Earth himself, and capable of summoning Shenon, the Eternal Dragon, to grant their summon a single wish. Once they army gathers up all seven dragonballs, they will wield the power of heaven and earth itself, and be unstoppable! Therefore, I entrsut you with the task of stopping them, and saving my world!\n\n")
				dialogue.conclude()
				term.load()
				if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
	 				change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)
				end
 				change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
 				change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
				return
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Believe me. He wouldn't.\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Not if his life counted on it.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Silence, you fools! I'm trying to think of a Quest sufficiently easy for the new " .. gendernouns.guygirl .. ".\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("I wouldn't mind having my claws sharpened.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("No, I can barely afford to keep us in furniture as it is.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("How about have " .. gendernouns.himher .. " clean up this mess? I've tripped on the debris three times since the second floor caved in. Stupid monkeys.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("No, that was your assignment. Oh! I know! I'll have " .. gendernouns.himher .. " go fetch that Dragonball over in Muscle Tower for me!\n\n")
				dialogue.helper("Dragonball?", "a")
				local ans = dialogue.answer()
				term.load()
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Yes. Our neighbors to the east are generally a fairly quiet bunch. Just a moderately sized military organization bent on world domination. Friendly chaps, all in all. But, this is, after all, MY world, and I can't have anyone conquering it.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Perish the thought.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Indeed. Ordinarily I wouldn't so much as take notice of such a ragtag group as themselves, but it seems that their leader, a gentleman by the name of Commander Red, has retrieved one of the lost Dragonballs, magical orbs which, once all seven are gathered together, allow anyone...\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("...even someone as dense as Commander Red...\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("...to summon the Eternal Dragon of the Earth, Shenron, to grant a wish! Mai and Shuu can deal with the Red Ribbon Army, but nothing can stop a Dragon!\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Except a few squirts of Dragon-B-Gone\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("I bet the junk in here would scare him off. Dragons like things tidy.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("And so, my pathetic, lowly servant...\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("'Utterly-Pathetic.' Pathetic Lowly Servant is two ranks above that.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("I entrust you with this task! Destroy the Red Ribbon Army, assassinate thier leader, and return to me the Dragonball in their possession!\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Could you get me a new chew toy while you're out?\n\n")
				dialogue.conclude()
				term.load()
				if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
	 				change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)
				end
 				change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
 				change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
				return
			elseif ans == "c" then
				term.load()
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("No? Not even a little one? Just a little, itty bitty order...come on. It won't hurt a bit.\n\n")
				dialogue.prep()
				dialogue.helper("Hmm. Well, ok. But just a small one, mind you.", "a")
				dialogue.helper("No, not interested.", "b")
				ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Ahhh...excellent! Very well, I hereby entrust you with the following, small, little task: Infiltrate the inner sanctum of the worlds largest evil military organization, the Red Ribbon Army, assassinate their leader, Commander Red, and return to me the legendary dragonball they have in their possession!\n\n")
					dialogue.prep()
					dialogue.helper("That's a 'small' order?", "a")
					dialogue.helper("That's three orders. I said one.", "b")
					dialogue.helper("Yeah, ok. I have some time after I walk the dog tonight.", "c")
					ans = dialogue.answer()
					if ans == "a" then
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, "Mai: ")
						term.text_out("Relatively speaking, yes. Last week, for instance, he ordered me to clean Shuu's litter box.\n\n")
						term.text_out(color.LIGHT_BLUE, "Shuu: ")
						term.text_out("HEY! It's not THAT bad!\n\n")
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("Wait, it's been a whole week since we've done that?\n\n")
						dialogue.conclude()
					elseif ans == "b" then
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("Three?\n\n")
						term.text_out(color.LIGHT_BLUE, "Mai: ")
						term.text_out("He doesn't count very well.\n\n")
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("What are you talking about? I said it in a single breath, so that was one order. Now, get to it, servant!\n\n")
						dialogue.conclude()
					elseif ans == "c" then
					end

					-- Same quest and leave regardless of which of above three
					term.load()
					if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
		 				change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)	
					end
	 				change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
	 				change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
					return

				elseif ans == "b" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("*sigh* Ok.\n\n")
					dball_data.pilaf_polite_done = 3
					dialogue.conclude()
					term.load()
					return
				end
			end
		elseif ans == "b" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Ahh, yes... indeed I am a -\n\n")
			term.text_out("(Pilad stops and thinks a moment.)\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("A loon? What's a loon? Is that a good thing? Keep in mind that I have two powerful, heavily armed servants at my beckon call, and one of them happens to be a deadly, super-fast ninja cat who could carve you into anchovies before you took your second step towards the stairs. Now, tell me...what's a loon?\n\n")
			dialogue.helper("Umm...a loon is a...umm...divine, God-like creature of absolute beauty and grace...and stuff...", "a")
			dialogue.helper("It's an idiot. Like you.", "b")
			local ans = dialogue.answer()
			term.load()
			term.save()
			dialogue.prep()
			if ans == "a" then
				term.text_out("(Emperor Pilaf relaxes again.)\n\n")
			end
			term.text_out(color.LIGHT_BLUE, "Mai: ")
			term.text_out("Not true...a 'loon' is a colloquillism dating from the days when insane people were associated with howling at the moon like dogs. 'Luna' in the proper name for the moon, and over time, people so associated with it came to be known as 'loonies' or 'loon' for short. It's also a type of bird.\n\n")
			term.text_out("(Emperor Pilaf is silent for a few moments.)\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("So..." .. gendernouns.heshe .. " just implied that I was insane? \n\n")
			dialogue.helper("Hmm. I guess so. You know, I had never stopped to ponder the etymology of the word.", "a")
			dialogue.helper("No! No! Not at all! It's also a BIRD, remember! Mai said it's a bird! A beautiful, graceful bird, just like I said!!!", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Hmph. Ignorance is no excuse. Kill " .. gendernouns.himher .. ".")
				dialogue.PILAF_KILL()
			elseif ans == "b" then
				term.load()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("I hate birds. Mai! Shuu! Exterminate this fool!")
				dialogue.PILAF_KILL()
			end
		end

	elseif ans == "c" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Am I serious? Of course! Oh, I know it's difficult to imagine that anyone in my position of glory would allow a nobody like you the HONOR of appreciating me, but I am indeed serious, and yes, I will allow it. You may praise me. I will tolerate it, but only because I am such a kind, and loving emperor.\n\n")
		dialogue.helper("Oh, verily I am awestruck with the magnificence that is the Grand and Glorious Emperor Pilaf!", "a")
		dialogue.helper("Umm...ok: 'Yay for Pilaf, he's nifty, yay?'", "b")
		dialogue.helper("No, sorry. I think I'll pass, thanks.", "c")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Shuu (whispering): ")
			term.text_out("Wow, " .. gendernouns.heshe .. "'s really laying it on thick.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Ahh...how delightful to hear such heartfelt enthusiasm for my favorite person: me!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mai (whispering): ")
			term.text_out("Yeah...we'd better be careful with this one. Might get us into trouble.\n\n")
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("So, " .. player_name() .. ", tell me more about me.\n\n")
			dialogue.prep()
			dialogue.helper("Oh! Pilaf! Oh! Emperor! What Divine wisdom has blessed us mere mortals with the transcendant splendor that is your presence!", "a")
			dialogue.helper("Oh...I'm sorry, I just can't do this anymore. You're a silly looking little blue midget with delusions of adequecy. Get over yourself.", "b")
			ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Wow...that's creative.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("It's...poetic.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("And it's all true.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Well, up until 'Oh! Pilaf! Oh!' it was true, at least.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Very well! It is decided! You, " .. player_name() .. " shall be my new servant!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Lucky you. Now maybe you'll know better for next time.\n\n")
				dialogue.conclude()
				term.load()
				message("Implement tree!")
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("...I...you...whhaa did you say!?!??\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("The truth?\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Blasphemer! Infidel! You shall die horribly! Mai, KILL THIS WRETCH!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Hmm. Gee, I don't know. I just did my nails and they haven't dried yet.\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("SHUU! KILL THIS-\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Don't look at me. It's my nap time. Can't you hear me sleeping? 'Zzzzzzzz.' See?\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Hmm. Ordinarily I would be having you killed right now, but it seems that my loyal servants are...preoccupied. I don't suppose...would you mind, well...could you come back later? When they're not so busy? I'm sure they'll be available to kill you in an hour or two.\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Make it three. I'm behind on my nap schedule.\n\n")
				dialogue.prep()
				dialogue.helper("Umm, sure. I can come back later. No problem. I'll just be going now...see you! (leave)", "a")
				dialogue.helper("No, I'm sorry. I'm a busy " .. gendernouns.guygirl .. ", and I have plans for later. You'll just have to kill me now.", "b")
				ans = dialogue.answer()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Oh, very good! Thank you! Thank you so much. We'll be seeing you again soon, then.\n\n")
					dialogue.conclude()
					term.load()
 					change_quest_status(QUEST_PILAF_RETURN, QUEST_STATUS_TAKEN)
				elseif ans == "b" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Oh dear, this is terribly embarrassing. Umm. I...don't suppose, hmm. How about...since both of my regular servants are busy, I was thinking earlier that, given all the flattery you were able to heap upon me, that you'd make a good servant yourself. And, since Mai and Shuu are both busy right now-\n\n")
					term.text_out(color.LIGHT_BLUE, "Mai and Shuu: ")
					term.text_out("Yes. Very busy.\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("...how about I recruit you into my services? That way, I would have a servant available to order to kill you. Would that be ok?\n\n")
					dialogue.prep()
					dialogue.helper("Let me see if I understand this correctly: You want me to become your servant, so you can order me to kill myself?", "a")
					dialogue.helper("Umm...no. Like I said, I'm a busy " .. gendernouns.guygirl .. ". I have better things to do.", "b")
					ans = dialogue.answer()
					if ans == "a" then
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("Yes. Please.\n\n")
						dialogue.prep()
						dialogue.helper("Umm...ok, sure...?", "a")
						dialogue.helper("...nope, sorry.", "b")
						ans = dialogue.answer()
						if ans == "a" then
							term.load()
							term.save()
							term.text_out(color.LIGHT_BLUE, "Mai: ")
							term.text_out("I take back what I said ealier about having to keep an eye on this one.\n\n")
							term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
							term.text_out("Excellent! I hereby induct you into my service, and grant you the rank of 'Generally-Worthless-But-Still-A-Bit-Above-Pathetic' servant! For your first task, I hereby order you to put yourself to death!\n\n")
							term.text_out(color.LIGHT_BLUE, "Shuu: ")
							term.text_out("Want some of my ninja poison? It's fast acting.\n\n")
							term.text_out(color.LIGHT_BLUE, "Mai: ")
							term.text_out("If you promise to clean it afterwards, you can borrow my nail filer to slash your wrists with.\n\n")
							term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
							term.text_out("Nonsense! We'll do this the fast and easy way! Servant, press Q to end your life!\n\n")
							dialogue.conclude()
							term.load()
		 					change_quest_status(QUEST_PILAF_EXECUTE, QUEST_STATUS_TAKEN)
						elseif ans == "b" then
							term.load()
							term.save()
							term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
							term.text_out("Oh, very well. Spoilsport.\n\n")
							dialogue.conclude()
							term.load()
							dball_data.pilaf_polite_done = 1
						end
					elseif ans == "b" then
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, "Mai: ")
						term.text_out("Yes. Don't we all?\n\n")
						term.text_out(color.LIGHT_BLUE, "Shuu: ")
						term.text_out("...zzzzzzzz...\n\n")
						term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
						term.text_out("Oh, very well. I guess you'll just have to live then. I'm really very sorry about this.\n\n")
						dialogue.conclude()
						term.load()
						dball_data.pilaf_polite_done = 1
					end
				end
			end

		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Hmm. You don't sound very awestruck to me. Here...be Shuu-struck instead. Shuu...kill " .. gendernouns.himher)
			dialogue.PILAF_KILL()
			dialogue.conclude()
			term.load()
			return
		elseif ans == "c" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			if player.get_sex() == "Female" then
				term.text_out("Ahhh...so overwhelmed by my masculine charm that she can't even speak. How touching. Very well, I forgive you your weakness. Perhaps if you dedicate your life to overcoming it, I might one day allow you the privilage of joining my harem.\n\n")
			else
				term.text_out("Ahhh...so overwhelmed by my power and glory that he cannot even speak it. Very well. Few can even behold me without cowering in awe, so I shall forgive your inability to articulate the joy you feel in your heart at beholding my grace.\n\n")
			end
			dball_data.pilaf_polite_done = 1
			dialogue.conclude()
			term.load()
		end
		
	elseif ans == "d" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Ahhh! Then it is Divine Providence which has brought you to me! I am the GREAT EMPEROR PILAF! I am the Supreme Ruler of the Entire World!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Going to be.\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Don't interupt me, Mai. Besides...you know what that Anthony Robbins guy says. You have to clearly imagine your goals in the here and now to properly realize them. Now...where was I?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Same place as usual.\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Oh, right. So, as Supreme Emperor of the Entire World, I entrust you with the following task! \n\n")
		term.text_out("(Emperor Pilaf thinks for a few moments)\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Shuu: ")
		term.text_out("To pet me?\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("No. You get enough attention as it is.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("To clean up this mess of a castle?\n\n")
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("No. That's your job, Mai. Oh! I know! I will entrust you with the task of retreiving for me the other six Dragonballs!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mai: ")
		term.text_out("Oh, no....not this again.\n\n")
		dialogue.helper("Dragonballs?", "a")
		dialogue.helper("Very well, I accept.", "b")
		if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_UNTAKEN then
			dialogue.helper("No, sorry. I am already looking for the Dragonballs for myself.", "c")
		end
		if quest(QUEST_BURUMA_DRAGONBALLS).status ~= QUEST_STATUS_UNTAKEN then
			dialogue.helper("No, sorry. I've already agreed to help Buruma find the Dragonballs.", "d")
		end
		local ans = dialogue.answer()
		if ans == "a" then
			-- This branch establishes for fact that Pilaf has a dragonball!
			-- We need to check to see if that is possible!
			dball_data.pilaf_dragonballs = dball_data.pilaf_dragonballs + 1

			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Yes, the Dragonballs. They are a magical set of spheres made by the God of the Earth Himself. Seven mystic orbs that, once gathered together allow their master to summon the Eternal Drgaon of the Earth, Shenron, to grant his summoner a single wish. I have one Dragonball already in my possession, but that leaves six more to be found! It is with this task I entrust you: find the remaining Dragonballs and bring them to me!\n\n")
			dialogue.helper("Ok. I'll help you find the Dragonballs.", "a")
			dialogue.helper("Forgive me, my lord, I don't think I am up to this task.", "b")
			dialogue.helper("Wait...did you say that you have a Dragonball? Right now? On you?", "c")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Excellent! It happens that another Dragonball may be found very near here, in Muscle Tower, the headquarters of the evil, dastardly, Red Ribbon Army. The RRA has been a thorn in my side for quite some time, and it's founder, a fool who calls himself 'Commander Red,' seems to have designs on ruling my planet. Can you believe the audacity??! You must destroy the Red Army, kill it's Commander, and return to me the Dragonball in their possession. Go, my faithful servant! Bring me glory!\n\n")
				dialogue.conclude()
				term.load()
				if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
	 				change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)
				end
 				change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
 				change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
			elseif ans == "b" then
				term.load()
				term.save()
				dialogue.prep()
				dball_data.pilaf_dungeon_for_ms = 1
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Hmm. I suppose if you are so pathetic you cannot do such a simple thing, perhaps I can find a lesser task for you. Come to think of it, I do happen to have another task that needs doing. As you may have noticed, my other servants are rather lazy, and -\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Hey! We are not lazy! Shuu! Tell him we're not lazy!\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("...zzzz...hmm? Sorry, I dozed off. What?\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("See? I can understand Shuu, after all, he is a cat. But Mai has no excuse. Therefore...\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("I do so have an excuse for being...no! Wait! I'm not lazy!\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("...I offer you her share of glory, and give her current assignment to you!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("Oh! In that case, I'm definately lazy! '...zzz...' See how lazy I am? Sleeping on the job! Wow!\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("As you can see, the castle is still under reconstruction. We had a most terrible incident with an overgrown monkey recently. Mai had just managed to clean up most of the debris and right as we began digging a new dungeon the roof caved in on us and it's really become quite a mess again. Clean up all the debris in the castle and you will have proven yourself worthy of the quest to retrieve the Dragonballs!\n\n")
				term.text_out(color.LIGHT_BLUE, "Shuu: ")
				term.text_out("Yep! I'm a cat! See me sleeping? 'sleep' ... 'sleep' ...\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("I'm a cat, too! See? '...zzz...'\n\n")
				dialogue.helper("Hmm. Ok. Could you at least give me a shovel?", "a")
				dialogue.helper("No, I'm not going to clean up your castle, either.", "b")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Sure. Here's mine.")
					dialogue.conclude()
	 				change_quest_status(QUEST_PILAF_RUBBLE, QUEST_STATUS_TAKEN)
					dball.reward(create_artifact(ART_MAI_SHOVEL))
				elseif ans == "b" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("What? You refuse me TWICE? Mai! Shuu! Kill this imbecile!\n\n")
					dialogue.conclude()
					term.load()
					dialogue.PILAF_KILL()
					if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
						quest(QUEST_DRAGONBALLS).status = QUEST_STATUS_TAKEN
					end
				end
			elseif ans == "c" then
				term.load()
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Of course! I did mention that I was the extreme majestic one, did I not? Where else should such a mystic device be but in my hands? Here...let me show you.\n\n")
				term.text_out("(Emperor Pilaf reaches into a pocket and pulls out a translucent orange orb, with what appears to be stars floating inside of it.)\n\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Is it not beautiful! Does this not prove how powerful and worthy I am to rule the world?\n\n")
				dialogue.helper("Yes. I am impressed. I will serve you.", "a")
				dialogue.helper("Are you kidding? It looks like a snow globe. Sorry, I think you're on your own.", "b")
				dialogue.helper("Wow...that's just amazing. That's so amazingly amazing, I think I'm going to steal it. (Grab it and run)", "c")
				dialogue.helper("I wantssses it...my precioussss... (Attack)", "d")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.save()
					dialogue.prep()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Excellent! Ok...I hereby dub thee my eternal slave and servant, and grant you the rank of 'Utterly-Pathetic Lowly Servant!'\n\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Oh, come on! You made me scrub dishes for two days straight before you awarded me that rank!\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Yes, but this one is special. I can feel it. In fact, I will gave " .. gendernouns.himher .. " a task to prove it! To the east of here is the military headquarters of the Red RIbbon Army. They are an evil military organization bent on wold domination. Now, ordinarily I'd expect to those to be exactly my kind of people. Good neighbors, even, but their leader, Commander Red, has insulted me by attempting to take control of MY world! Can you imagine! The gall!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("I thought that was supposed to make them good neighbors. If not this one...which world were they supposed to be trying to rule?\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("I don't know...but that's not my problem! This is MY world to conquer. If they want to conquer one themselves, that's all well and good..but they'd better find their own!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Of course. Silly me.\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Yes, well, that's why I'm the Emperor and you're the lowly slave.\n\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("No, 'moderately' lowly slave. You promoted me yesterday, remember?\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Oh, yes, that's right. Well...back to business. " .. player_name() .. ", I would like you to infiltrate this Red Ribbon Army encampment, find and assassinate their Supremem Commander, Red, and return to me the Dragonball in his possession! Do this, and there will be a promotion in it for you.\n\n")
					dialogue.conclude()
					term.load()
					if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
		 				change_quest_status(QUEST_DRAGONBALLS, QUEST_STATUS_TAKEN)
					end
	 				change_quest_status(QUEST_PILAF_RRA, QUEST_STATUS_TAKEN)
 					change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
					return
				elseif ans == "b" then
					term.load()
					term.save()
					dialogue.prep()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("What?!?!? This is one of the seven greatest magic artifacts in the entrie world!!! You must be a moron! Get out of my sight!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mai: ")
					term.text_out("Hey..." .. gendernouns.heshe .. "'s right. It does kind of look like a snow globe. Here, let me shake it and see if it snows!\n\n")
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Arrrgghhh! Does no one comprehend my greatness?!?!?!\n\n")
					dball_data.pilaf_polite_done = 2
					dialogue.conclude()
					term.load()
					return
				elseif ans == "c" then
					term.load()
					term.save()
					dialogue.prep()
					term.text_out("(Your timing is perfect, and you grab the Dragonball!\n\n")
					local obj = dball.request_dragonball()
					dball.reward(obj)
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("THIEF!!!\n\n")
					dialogue.conclude()
					term.load()
					dialogue.PILAF_KILL()
					dball.chalign(-10)
					player.redraw[FLAG_PR_BASIC] = true
					return
				elseif ans == "d" then
					term.load()
					term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
					term.text_out("Mai! Shuu! HELP!\n\n")
					dialogue.PILAF_KILL()
					project(WHO_TRAP, 0, 2, 19, 50, dam.FEAR, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
					dball.chalign(-10)
					player.redraw[FLAG_PR_BASIC] = true
					return
				end
			end
		elseif ans == "b" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("Very good. I do not know where the other Dragonballs may be found, but I do know that there are others searching for them as well. For instance, there is that detestable Red Ribbon Army under the command of Commander Red. Their primary headquarters is located a short ways east of here. I would recommend begining your search there. In fact, servant, I think I shall issue you another task as well: Destory the Red Ribbon Army! They have been a tremendous nuisance, with all their ridiculous posturing nonsense about trying to take over the world. Ha! What foolishness! Only I shall rule the world. Why, just the other day I ran into one of their Colonel's and he -\n\n")
			term.text_out("(Shuu's ears twitch)\n\n")
			term.text_out(color.LIGHT_BLUE, "Shuu: ")
			term.text_out("What's that sound?\n\n")
			dball_data.pilaf_interupted = 1
			dialogue.conclude()
			term.load()
			message(color.YELLOW, "Several Red Ribbon Army soldiers burst into the castle!")
			place_named_monster(16, 18, "red ribbon army private", 0)
			place_named_monster(16, 20, "red ribbon army private", 0)
			place_named_monster(15, 18, "red ribbon army private", 0)
			place_named_monster(15, 19, "red ribbon army private", 0)
			place_named_monster(15, 20, "red ribbon army private", 0)
			-- Does the who matter, and what are our other options?
			project(WHO_TRAP, 0, 3, 15, 50, dam.FEAR, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			project(WHO_TRAP, 0, 3, 23, 50, dam.FEAR, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
			for_each_monster(function(m_idx, monst)
				if monst.r_idx ~= RACE_PILAF then
					monst.ai = ai.ZOMBIE
				end
			end)

		elseif ans == "c" or ans == "d" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
			term.text_out("What?!?!? You dare to disobey a direct order from your sovereign lord?\n\n")
			dialogue.helper("No! Not at all! Of course I will find the Dragonballs for you!", "a")
			dialogue.helper("Yes, I really must decline. Sorry.", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Excellent! Then, get to it!")
				change_quest_status(QUEST_PILAF_DRAGONBALLS, QUEST_STATUS_TAKEN)
				if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
	 				quest_status(QUEST_DRAGONBALLS).status = QUEST_STATUS_TAKEN
				end
			elseif ans == "b" then
				term.load()
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("Whaa??? The audacity!!! Mai! Shuu! KILL THIS IMPERTANANT FOOL!!!!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("I think you mean 'impertinant.'\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("What? KILL HIM!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mai: ")
				term.text_out("There's only one 'a' in impertinant. It's: i, m, p, e, r, t, i, n, a, n, t. 'Impertinant.'\n")
				term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
				term.text_out("GAHHHH!!!! Shuu! Throw them both in the dungeon!\n\n")
				dialogue.conclude()
				if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_TAKEN then
	 				quest_status(QUEST_DRAGONBALLS).status = QUEST_STATUS_TAKEN
				end
				dball_data.pilaf_dungeon = 1
				message("Pilaf dungeon path not implemented")
				-- Teleport to the dungeon beneath Castle Pilaf
			end
		end
	elseif ans == "e" then
		term.load()
		term.text_out(color.LIGHT_BLUE, "Emperor Pilaf: ")
		term.text_out("Traitor! Mai! Shuu! Exterminate this fool!")
		dialogue.PILAF_KILL()
	end
end

function dialogue.JOE()
	term.gotoxy(0, 0)
	local thugs = dball_data.ginkako + dball_data.kinkaku
	if quest(QUEST_ARU_THUGS).status == QUEST_STATUS_FINISHED then
		term.text_out(color.LIGHT_BLUE, "Joe: ")
		term.text_out("Hello! Good to see you again! Have you need of a carpenter?")
	elseif quest(QUEST_ARU_THUGS).status == QUEST_STATUS_TAKEN then
		if thugs == 2 then
			dialogue.store_hack(15)
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "\nJoe: ")
			term.text_out("You have defeated the thugs? Oh! Happy day! Thank you! Forgive me...I have no money to reward you with, but I am a carpenter by trade. Should you ever be in need of wood-working, please come to me and I will help you as best as I am able.\n\n")
			dialogue.conclude()
			change_quest_status(QUEST_ARU_THUGS, QUEST_STATUS_FINISHED)
		elseif thugs == 1 then
			term.text_out(color.LIGHT_BLUE, "Joe: ")
			term.text_out("You got one! Great! There's still the other one, though...")
		else
			term.text_out(color.LIGHT_BLUE, "Joe: ")
			term.text_out("Those thugs are still out there!")
		end
	elseif quest(QUEST_ARU_THUGS).status == QUEST_STATUS_UNTAKEN then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nJoe: ")
		term.text_out("What a terrible place this is! I had heard good things about Aru Village, and came recently to settle, but when I arrived in the village I was attacked by two thugs! They beat me up and stole all my money. Fortunately there are houses to spare here, but after what happened I can't help but wonder what happened to the previous owners, and the local villagers won't talk about it. It's scary! The two thugs let me live, but I bet they've been killing people too! Why else would all these houses be empty? If something doesn't happen soon, I think I'll leave the village. It just isn't safe here.\n")
		dialogue.conclude()
		change_quest_status(QUEST_ARU_THUGS, QUEST_STATUS_TAKEN)
	else
		message("Error? Unknown Aru Thug quest status?")
	end
end

function dialogue.IMELDA()
	term.gotoxy(0, 0)
	if quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_UNTAKEN then
		if dball_data.bossrabbit == 1 then
			term.text_out(color.LIGHT_BLUE, "\nImelda: ")
			term.text_out("Hello. Welcome to Aru village!")
		else
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "\nImelda: ")
			term.text_out("Oh, alas! Woe is me! All of the men of Aru village have been transformed into carrots by a giant, evil rabbit! Whatever will I do? I am so lonely! I suppose I could still date that Marcos guy, but I wouldn't touch him if he were the last man in the village. Oh...wait. He is. Hmm. This is not good. Please, oh adventurer! Save me from my plight!\n\n")
			if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN or quest(QUEST_ROSSHI_LONELY).status == QUEST_STATUS_TAKEN then
				dialogue.helper("Sure. I'll look into that.", "a")
				if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN then
					dialogue.helper("Hey...you know, if you're looking to meet men it just happens that I know a single guy. He's a little short, but caring and affectionate. He also happens to be extremely wealthy. Shall I introduce you?", "b")
				end
				if quest(QUEST_ROSSHI_LONELY).status == QUEST_STATUS_TAKEN then
					dialogue.helper("Wow, so you're single? Looking for that special someone? What a coincidence! I just happen to have a, umm...friend. And he's absolutely the most physically fit 300 year old you're ever going to meet!", "c")
				end
				local ans = dialogue.answer()
				dialogue.store_hack(15)
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "\nImelda: ")
					term.text_out("Thank you!")
					change_quest_status(QUEST_BOSS_RABBIT, QUEST_STATUS_TAKEN)
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "\nImelda: ")
					term.text_out("What? You mean that little pink pig that all the young village girls have been running after? I think not! A lady must have standards, and Oolong is entirely beneath mine.\n\n")
					dialogue.conclude()
					change_quest_status(QUEST_BOSS_RABBIT, QUEST_STATUS_TAKEN)
				elseif ans == "c" then
					term.text_out(color.LIGHT_BLUE, "\nImelda: ")
					term.text_out("You don't mean...ROSSHI?!?!? That sicko PERVERT!??! No thank you!")
					dialogue.conclude()
					change_quest_status(QUEST_BOSS_RABBIT, QUEST_STATUS_TAKEN)
				end
			else
				dialogue.conclude()
				change_quest_status(QUEST_BOSS_RABBIT, QUEST_STATUS_TAKEN)
			end
		end
	elseif quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_TAKEN then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nImelda: ")
		term.text_out("I'm sorry...I just can't do it. I can't go out with that Marcos guy. Please find the evil rabbit and...oh, wait. He already ate the carrots, it's not like you can rescue them. Hmm. Well, could you kill him anyway, just to make me feel better? Plus, that way if any new men come to the village, they won't get eaten too.\n")
		dialogue.conclude()
	elseif quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_COMPLETED then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nImelda: ")
		term.text_out("You have killed the evil rabbit! Oh! Happy day! Thank you! Now maybe some decent men will come to this village! ")
		if player.get_sex() ~= "Female" then
			term.text_out("No offense to you, but adventurers don't make very good husbands, you know. ")
		end

		-- What to do if player has artifact shoes?
		local obj_shoe = new_object()
		if player.inventory[INVEN_FEET][1] and player.inventory[INVEN_FEET][1].k_idx then
			term.text_out("I'm sorry I haven't much to give in the way of rewards. I'm an avid shoe collector, but I haven't much else. Here, let me give you a pair. I have a fairly new pair, only worn once and similar to the style you're wearing now, but maybe a bit more stylish.\n")
			local shoe_kidx = player.inventory[INVEN_FEET][1].k_idx
			object_prep(obj_shoe, shoe_kidx)
			obj_shoe.ego_id[1] = dball.find_ego_idx("designer")
			apply_magic(obj_shoe, 99, FALSE, true, FALSE)
			make_item_fully_identified(obj_shoe)
			obj_shoe.number = 1
			-- obj_shoe.to_a = obj_shoe.to_a + 5
		else
			term.text_out("\n\nYou turn to leave, but just as you reach the door, Imelda calls out to you: \n\n")
			term.text_out(color.LIGHT_BLUE, "Imelda: ")
			term.text_out("Oh, dear! You poor " .. gendernouns.boygirl .. "! You haven't any shoes! Your poor feet! I'm so sorry I didn't notice before. Here...it just so happens that I'm something of a shoe collector. Let me give you a pair.")
			if player.get_sex() == "Female" then
				obj_shoe = create_object(TV_BOOTS, SV_HIGH_HEELS)
			else
				obj_shoe = create_object(TV_BOOTS, SV_TENNIS_SHOES)
			end
			obj_shoe.ego_id[1] = dball.find_ego_idx("designer")
			apply_magic(obj_shoe, 99, FALSE, true, FALSE)
			obj_shoe.to_a = 7
		end
		term.text_out("\n(Received shoes)\n")
		obj_shoe.found = OBJ_FOUND_REWARD
		make_item_fully_identified(obj_shoe)
		dball.reward(obj_shoe)
		dialogue.conclude()
		change_quest_status(QUEST_BOSS_RABBIT, QUEST_STATUS_FINISHED)

	elseif quest(QUEST_BOSS_RABBIT).status == QUEST_STATUS_FINISHED then
		message("Thanks again for killing that horrible, evil Boss Rabbit!")
	end
end

function dialogue.MARCOS()
	term.gotoxy(0, 0)
	if dball_data.oolong_quest_helper == 1 and dball_data.oolong_resolution == 0 then
		term.text_out(color.LIGHT_BLUE, "\nMarcos: ")
		term.text_out("Excuse me? You're saying the village girls went to Castle Oolong by choice? No way! I don't buy it! He must be using some sort of evil, dark magic to warp their minds! Get back there and bring back those village girls! \n")
		dball_data.oolong_quest_helper = 2
		dialogue.conclude()

	elseif quest(QUEST_OOLONG).status == QUEST_STATUS_FINISHED then
		message("Thank you for returning the women to the village!")

	-- Hack: Fix me! Implement! Is alpha11 no longer processing ON_DEATH flag functions???
	elseif race_info_idx(RACE_OOLONG, 0).max_num == 0 then
		term.text_out(color.LIGHT_BLUE, "\nMarcos: ")
		term.text_out("The village girls have returned! They're all very grumpy, though. I suppose it must have been hard to have endured captivity at the hands of that beast. Here, let me give you a reward. This knife has been in my family for generations, but I'd like you to have it. Thanks again.\n")
		local obj_knife = create_object(TV_SMALLARM, SV_KNIFE)
		obj_knife.number = 1
		obj_knife.to_d = rng(3, 5)
		make_item_fully_identified(obj_knife)
		dialogue.conclude()
		change_quest_status(QUEST_OOLONG, QUEST_STATUS_FINISHED)
		dball.reward(obj_knife)

	elseif quest(QUEST_OOLONG).status == QUEST_STATUS_COMPLETED then
		if dball_data.oolong_resolution == 1 then
			term.text_out(color.LIGHT_BLUE, "\nMarcos: ")
			term.text_out("You simply *asked* him to retrn the girls and he agreed? Wow...that surprises me. ")
		else
			term.text_out(color.LIGHT_BLUE, "\nMarcos: ")
			term.text_out("So...the village girls actually went to Castle Oolong by choice? Wow. They preferred a rich pig to me? That's pretty harsh. ")
		end
		term.text_out("Still, they're back now and I'm grateful. Here, let me give you a reward. This knife has been in my family for generations, but I'd like you to have it. Thanks again.\n")
		dball_data.oolong_quest_helper = 3 -- Done?
		local obj_knife = create_object(TV_SMALLARM, SV_KNIFE)
		obj_knife.number = 1
		obj_knife.to_d = rng(3, 5)
		make_item_fully_identified(obj_knife)
		dialogue.conclude()
		change_quest_status(QUEST_OOLONG, QUEST_STATUS_FINISHED)
		dball.reward(obj_knife)
	elseif dball_data.oolong_quest_helper == 2 then
		message("What are you waiting for? Those girls are still waiting to be rescued!")

	elseif quest(QUEST_OOLONG).status == QUEST_STATUS_UNTAKEN then
		if dball_data.oolong == 1 then
			term.text_out(color.LIGHT_BLUE, "Marcos: ")
			term.text_out("Hello. Welcome to Aru village!")
		else
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "\nMarcos: ")
			term.text_out("Oh, alas! Woe is me! All of the women of Aru have been kidnapped by an evil, humanoid pig creature who calls himself Oolong the Terrible! It's awful! Who knows what sort of tortures they must endure? Does he eat them alive? I know not, because I am not an adventurer. Only adventurers go and look into these matters. I'm just a village NPC and all we do is sit around and whine about problems so you people can solve them for us. That's how this works, you see. So get to it, please.\n\n")
			dialogue.conclude()
			change_quest_status(QUEST_OOLONG, QUEST_STATUS_TAKEN)
		end
	elseif quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
		message("Please hurry! Some of the women may still be alive!")
	end
end

function dialogue.URANAI_BABA()
	local fall_through = 0

	-- Special case, 'apology' thread:
	if dball_data.rosshi_uranai_apology > 0 then
		term.save()
		local rua = dball_data.rosshi_uranai_apology
		if rua == 1 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Go on! Go bring back Rosshi so he can apologize personally! I'm not wasting my time with a student!\n\n")
		elseif rua == 2 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("So where's my brother?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("He...umm...wants to know what exactly he's supposed to be apologizing for.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Ha! He forgot already! Why am I not surprised? Tell him that I'm the older one, and he's not allowed to go senile before me!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...umm...\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Go tell him!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...I don't think that...\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("I don't care! Just tell him!\n\n")
			dball_data.rosshi_uranai_apology = 3
		elseif rua == 3 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("What are you doing here? Don't tell me you've gone senile too! Go tell Rosshi that I'm his older sister and he's not allowed to go senile before I am!\n\n")
		elseif rua == 4 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Well? What did he say?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("He says he apologizes for throwing out the pie you made him last August.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("He WHAT!?!?! He threw out that pie! What an ungrateful toad! Why, I should run right over there and turn him into one!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I don't think that would help.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Of course it would! It would help me feel better! You go tell that fetid son of a worm that he's no better than the cochroach reared on the toe jelly on a corpse louse!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I don't think I want to be involved in this anymore. It wasn't so good to begin with, but it's kind of gone downhill from when I came in. Maybe we'd all be better off if you two just spoke in person.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("I have no desire to speak to that lumbering tankard of horse snot!\n\n")
			dball_data.rosshi_uranai_apology = 5
		elseif rua == 5 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("What are you doing back here? I don't want to talk to you either!\n\n")
		elseif rua == 6 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Go away! I don't want to talk to any student of my rapscalions' turd of a brother!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Umm...he, uhh...remembered what he did to upset you, and asked me to please come apologize for calling you 'Sissy.'\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("...he...what?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Apologizes.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("...why...he did...what...?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Called you 'Sissy.'\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("But that's what he called me when we were little!!! Oh! How adorable! Goodness, that does bring back some powerful memories. He really called me 'Sissy?'\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes, I heard him say it with my own two ears.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("That's so sweet of him! Why, that brings tears to my eyes. <pout> <sniff> That's my little brother, Foozy, and I'm his big sister, Sissy!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...umm...'Foozy?'\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("That's what I called him when we were little. Go tell him that I forgive him, and that I love him.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I'm sort of afraid to, at this point. Everything seems all better now. Maybe we should just let things stand as they are.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("I said go tell him!!!! RIGHT NOW, or I'll turn you into a hermaphroditic llama!\n\n")
			dball_data.rosshi_uranai_apology = 7
		elseif rua == 7 then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Well? Go tell Foozy that I forgive and that I love him! Or else!\n\n")
		elseif rua == 8 then
			-- Success!
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Well, I feel much better now. Almost makes up for the monsters in my basement.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You have monsters in your basement?\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("I did mention that I was having a bad day, didn't I?\n\n")
			dball_data.uranai_state = 999
			fall_through = 1
		elseif rua == 9 then
			fall_through = 1
		end

		dialogue.conclude()
		term.load()
		if dball_data.uranai_state ~= 2 and dball_data.uranai_state ~= 999 then
			return
		end
	end


	-- This dialogue is contingent upon others, but...
	-- dball_data.uranai_state
	-- 0=no contact
	-- 1=
	-- 2=working on quest
	-- 8=Done, go to enrollment
	-- 9=aggressive
	-- 999=temp assignment to bypass main body and go straight to fall_through, where it's set to =2

	if dball_data.uranai_state == 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
		term.text_out("Go away! I've had a lousy day and I don't feel like having uninvited guests!\n\n")
		dialogue.helper("Oh. Sorry. (leave)", "a")
		if dball_data.karin_hole == 2 then
			dialogue.helper("I'm a student of Rosshi's. He suggested I come see you.", "b")
		end
		if dball.persuade(20) then
			dialogue.helper("(Persuade 20) I know what you mean! Stupid idiots showing up uninvited all the time! I just hate it when people do that!", "c")
		end
		if dball_data.alignment < 0 then
			dialogue.helper("You've had a lousy day? Oh, well then let me put an end to it for you. (attack)", "d")
		end
		local ans = dialogue.answer()
		term.load()
		term.save()
		dialogue.prep()
		if ans == "a" then
			term.load()
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Oh, did he now? I suppose my little baby brother is too proud to apologize himself, so he's sent you to do it for him?\n\n")
			dialogue.helper("No, actually I was hoping I could convince you to give me the Nyoi-bo, so I can use it to talk to Kami", "a")
			dialogue.helper("Umm...yes. He apologizes.", "b")
			ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
				term.text_out("Oh, really? Why should I do that?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("So I can speak to Kami?\n\n")
				term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
				term.text_out("You want to speak to Kami? That sounds like a personal problem to me, and I have a rather large one of my own at the moment.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("What's that?\n\n")
				fall_through = 1
			elseif ans =="b" then
				term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
				term.text_out("Oooohhhh...? Does he now? Well...how DARE he have someone else apologize for him! You go back to him right now and tell him that he'd better apologize himself, here, personally!\n\nHmph.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.rosshi_uranai_apology = 1
			end
		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Yes, it's awful! They come in uninvited, they interupt during dinner, they ignore the warning sign and barge in anyway!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("And you know who's worst? Adventurers! \n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Oh, absolutely! I detest adventurers! Constantly whining for quests, and demanding rewards!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yeah, can you believe the gall? I hate them too! Well, they're actually not bad with catsup, but otherwise, yes.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Catsup? I'll have to try that. Say...we sure seem to see eye to eye about a lot of things. I wonder if you could do me a favor?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("What's that?\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Well, it's kind of a long story...\n\n")
			dialogue.conclude()
			term.load()
			fall_through = 2
		elseif ans == "d" then
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Hehe...good, watching the flesh be ripped from your bones will help me feel better.\n\n")
			dialogue.conclude()
			term.load()
			dball_data.uranai_state = 9
			dball.annoy_map()
		end
	elseif dball_data.uranai_state == 2 then 
		if race_info_idx(RACE_TENTACLE_DEMON, 0).max_num == 0 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("You got rid of the demon! Very good! You may keep the Nyoi-bo, like we agreed. In case you haven't figured it out already, the command to use the Nyoi-bo is 'u'. Experiment with it. You're sure to find it useful.\n\n")
			dialogue.conclude()
			term.load()
			quest(QUEST_TENTACLE_DEMON).status = QUEST_STATUS_FINISHED
			dball_data.uranai_state = 8
		else
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("It's still down there. I can smell it.")
		end
	elseif dball_data.uranai_state == 8 then
		term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
		term.text_out("Hello again.")
		-- dball.enroll(FLAG_ENROLL_URANAI_BABA)
	elseif dball_data.uranai_state == 9 then
		message("Hahaha!!! Die!")
	end

	if fall_through > 0 then
		-- term.save()
		dball_data.uranai_state = 2
		term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
		term.text_out("I was trying to conjure up some minor tentacle demons recently for...well, for my own reasons, and unfortunately I acidentally spilled some lizard soup into my cauldron, and it sort of botched the spell.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("'Sort of?'\n\n")
		term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
		term.text_out("Well, the critters I ended up with weren't quite the critters I wanted. First I noticed there was a problem was when a tentacle came out and grabbed the staff I was stirring with and yanked it from my grasp. Then about a thousand pounds of slithering stuff crawled out, and generallly ran amuck with my floral print tapestries. It's been in the basement ever since.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("That doesn't sound so good.\n\n")
		term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
		term.text_out("It's not. Fortunately there's nothing down in the basement I really need, but hideous, tentacled demonic beasts aren't really the sort of thing you want lurking around, you know? I'll make you a deal. If you can get rid of that thing for me, I'll let you have the Nyoi-bo.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You won't need it to stir your cauldron anymore?\n\n")
		term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
		term.text_out("Not after this, I won't.\n\n")
		dialogue.conclude()
		term.load()
		if fall_through == 2 then
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yeah, I suppose I could look into that for you. But it sounds an awful lot like a quest.\n\n")
			term.text_out(color.LIGHT_BLUE, "Uranai Baba: ")
			term.text_out("Yes, I suppose it is. Still, I'd feel a lot better if you were to do it than one of those horrible adventurers who are constantly showing up at my door.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I can understand that. Ok, I'll look into it.\n\n")
			dialogue.conclude()
			term.load()
		end
		if quest(QUEST_TENTACLE_DEMON).status == QUEST_STATUS_UNTAKEN then
			change_quest_status(QUEST_TENTACLE_DEMON, QUEST_STATUS_TAKEN)
		end
		local c_ptr = cave(14, 9)
		c_ptr.info = 3
		flag_empty(c_ptr.flags)
		cave_set_feat(15, 10, FEAT_MORE)
		-- c_ptr.flags[FLAG_LEVEL_CHANGER] = -1
		-- c_ptr.flags[FLAG_TERRAIN_NAME] = FEAT_MORE
	end
end
function dialogue.ROSSHI(called_by)
	-- Hack
	if enrollments[FLAG_ENROLL_CRANE_HERMIT] > 0 then
		dball_data.rosshi_state = 7
	end

	-- Handle some special cases
	if dball.current_location() == "World Tournament" then
		--if dball_data.married == FLAG_MARRIED_ROSSHI then
		if player.get_sex() == "Female" then
			monster_random_say
				{
					"You look good all sweaty like that.",
					"Hey, hot stuff!",
					"I'm really more of a lover than a fighter.",
					"You wanna put me in a choke hold? I don't mind.",
				}
		elseif trainer[RACE_ROSSHI] > 0 then 
			monster_random_say
				{
					"Is the student ready to surpass the master?",
					"Hmm. Your form is better during practice.",
				}
		else
			message("Rosshi ignores you and keeps fighting.")
		end
		return
	end

	-- Special case, 'apology' thread:
	local rua = dball_data.rosshi_uranai_apology

	-- Odd is Rosshi's turn, even is Uranai Baba's
	-- Allow rest of Rosshi dialogue if speaking to Rosshi while waiting
	-- for Uranai to reply
	if rua > 0 and (2 * (rua / 2)) ~= rua then
		term.save()
		if rua == 1 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I...uh...spoke with your sister. She says she'd like you to come over to see her.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Me? What for?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Umm...to apologize for something.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("WHAT?!!? I'm not going to apologize to that old hag for anything! What is she unhappy about?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("She didn't say.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmph. Figures.\n\n")
			dball_data.rosshi_uranai_apology = 2
		elseif rua == 3 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Uranai Baba says she's your older sister, and so you're not allowed to go senile before she does.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Ha! No risk of that! She went batty ages ago!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You really have no idea why she's so angry?\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Well, I'd be pretty upset too, if I were as old and as ugly as she is.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("No, I mean angry at you.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmm. Well, I suppose it might have something to do with that pie she baked for me last August. It was supposed to be a birthday pie, but I think she dropped some of her cauldron goo into it, and it tasted awful. So I threw it away. She's sensitive about that kind of thing. Look...if that's really it, I apologize. She was trying to do something nice for me and I didn't appreciate it. Go and tell her I'm sorry.\n\n")
			dball_data.rosshi_uranai_apology = 4
		elseif rua == 5 then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("So did she accept my apology?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Umm...not exactly. Apparantly she was upset for some other reason, and finding out about the pie just upset her even more.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmph. Figures. Sissy never was very easy to please.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("'Sissy?'\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmm? Oh, that was my childhood playname for her. I guess I still call her that from time to time.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I see.\n\n")
			dball_data.rosshi_uranai_apology = 6
		elseif rua == 7 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Hello again.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Now what? You still have only two legs, so she couldn't have been too upset.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("No, she melted at hearing that you called her Sissy.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("That's a surprise. It usually takes water to make witches melt. \n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I won't tell her you said that.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Good idea.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Did she say anything else?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes...she said that she forgives you, she loves you, and she called you Foozy.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("...Foozy?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("She said it was her pet name for you when you were younger.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmm. I don't remember that.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You're not upset, or anything, are you?\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Me? No. She's certainly called me stranger things than 'Foozy.'\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I believe it.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("In any case, now that she's happy maybe you can talk to her about the Nyoi-bo so you can go visit with Kami.\n\n")
			dball_data.rosshi_uranai_apology = 8
		end
		dialogue.conclude()
		term.load()
		return
	end

	-- Marrying Rosshi cuts off other possibilities
	if dball_data.married == FLAG_MARRIED_ROSSHI then
		monster_random_say
			{
			"Rosshi peeks up your skirt.",
			"Rosshi says 'I love your tits!'",
			"Rosshi licks his lips at you.",
			"Rosshi says he's just happy to see you.",
			}
		return
	end

	-- Do we allow training?
	local fall_through = 0

	-- Proceed to main dialogue
	-- Rosshi States
	-- 0 = no contact and unsuccesfull loops
	-- 1 = Annoyed
	-- 2 = Success via a seduction path		(Note 'dball_data.rosshi_seduction' counter)
	-- 2: !!! Code doesn't seem to agree with the notes. This appears to be 'Lonely Master quest pending'
	-- 3 = Success via Lonely Master quest (found Rosshi a girl) (Auto fallthrough, no case)
	-- 6 = Defeated Rosshi via Duel from Crane Hermit
	-- 7 = On the mutually exclusive Tsuru Seni'nin tree
	-- 8 = Perma aggressive
	-- 9 = Other succesfull resolution (Porn, or untouchable innocence) (Auto fallthrough, no case)

	term.save()

	if dball_data.rosshi_state == 1 then
		term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
		term.text_out("Go away.")
	elseif dball_data.rosshi_state == 2 then
		if party.girls_in_party() > 0 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Hello again, Master Rosshi. I've brought someone I'd like you to meet.\n\n")
			if party.qty_partied(RACE_LUNCH) > 0 then
				if dball_data.lunch_sneeze == 0 then
					term.text_out(color.LIGHT_BLUE, "Lunch: ")
					term.text_out("Hello, sir. It's so nice to meet you!\n\n")
				else
					term.text_out(color.LIGHT_RED, "Lunch: ")
					term.text_out("Hey, fugly! What's a gal gotta do ta getta drink around here?\n\n")
				end
			end
			if party.qty_partied(RACE_VIDEL) > 0 then
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("Hey.\n\n")
			end
			if party.qty_partied(RACE_CHICHI) > 0 then
				term.text_out(color.LIGHT_BLUE, "Chichi: ")
				term.text_out("...oh, I'm always so embarrased about meeting new people!\n\n")
			end
			if party.qty_partied(RACE_BURUMA) > 0 then
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Who's the creepy old man?\n\n")
				term.text_out(color.LIGHT_RED, "Dragon Radar: ")
				term.text_out("BEEP!\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("What's that? The Dragon Radar! It's detecting a Dragonball right near here!\n\n")
				term.text_out(color.LIGHT_RED, "Dragon Radar: ")
				term.text_out("BEEP!\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("You, old man!\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("I'm not so old. Why, I'm scarcely two hundred. That's not old at all. Why, geologicallys speaking, the earth is-\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("I don't care! You have a dragonball!\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("A what?\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("A Dragonball! It will be small and round, orange with some red floating stars inside.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Oh. You mean my snowglobe?\n\n")
				term.text_out("Master Rosshi walks over to his dresser and pulls out a dragonball.")
				term.text_out(color.LIGHT_RED, "Dragon Radar: ")
				term.text_out("BEEP!\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("That it! That's a dragonball! May I have it? Please?\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Hmm. From how excited you're getting, obviously this little trinket must be of some value. What would you do for it?\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("ANYTHING!\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("...anything...?\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("YES!\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("I see. Well then, would you...\n\n")
				term.text_out(color.LIGHT_RED, "Dragon Radar: ")
				term.text_out("BEEP!\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("If I do, will you give me the Dragonball?!\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Definitely, miss. And I'll even give your friend the training " .. gendernouns.heshe .. " wants too.\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Deal!\n\n")
				term.text_out("Buruma lifts her shirt and happily flashes Rosshi to his hearts' content.\n\n")
				if party.qty_partied(RACE_CHICHI) > 0 then
					term.text_out(color.LIGHT_BLUE, "Chichi: ")
					term.text_out("Oh, dear...this is even more embarassing than usual.\n\n")
				end
				if party.qty_partied(RACE_LUNCH) > 0 then
					if dball_data.lunch_sneeze == 0 then
					else
						term.text_out(color.LIGHT_RED, "Lunch: ")
						term.text_out("Heh. Cool party. Where's da drinks?\n\n")
					end
				end
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Well, " .. player_name() .. ", you've far exceeded my expectations. I think it's time to start training. Don't you agree?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Sounds good to me.\n\n")
				dialogue.conclude()
				dball_data.rosshi_state = 3
				fall_through = 1
			end
			-- Hackish, but does what we want.
			if fall_through ~= 1 then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("...ahh...so cute...so sexy...\n\n")
				if party.qty_partied(RACE_LUNCH) > 0 then
					if dball_data.lunch_sneeze == 0 then
						dialogue.helper("Lunch, Rosshi here is looking for some help with cooking and cleaning. ", "a")
					else
						dialogue.helper("So, Lunch here is pretty sexy, right?", "b")
					end
				end
				if party.qty_partied(RACE_VIDEL) > 0 then
					dialogue.helper("Videl, this is the lonely gentleman I mentioned.", "c")
				end
				if party.qty_partied(RACE_CHICHI) > 0 then
					dialogue.helper("Chichi, I believe you already know Master Rosshi.", "d")
				end
				local ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					party.unparty(RACE_LUNCH)
					dball_data.rosshi_girl = RACE_LUNCH
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Yes, I've been living alone on this island for about a century now. It's been rather lonely. It would be nice to have a bit of a feminine touch around here.\n\n")
					term.text_out(color.LIGHT_BLUE, "Lunch: ")
					term.text_out("That sounds so nice. Because of my circumstances I haven't been able to stay in one place very long for quite some time. I would dearly love to see the same roof over my head, night after night. To lead a simple life. It would be a true joy.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Well, I would love to have your company. You may stay here as long as you'd like. But, forgive my curiosity, what 'circumstances' could possibly keep such a beautiful woman as yourself on the run?\n\n")
					term.text_out(color.LIGHT_BLUE, "Lunch: ")
					term.text_out("Well, it's just that when I sn-\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("...ahh, nothing, really. Nothing that should be discussed in front of company, if you catch my meaning.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Well, it can't be anything important then. Yes, please do stay, Lunch.\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Well, " .. player_name() .. ", you've far exceeded my expectations. I think it's time to start training. Don't you agree?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Sounds good to me.\n\n")
				elseif ans == "b" then
					party.unparty(RACE_LUNCH)
					dball_data.rosshi_girl = RACE_LUNCH
					term.text_out("Lunch pulls out an uzi and points it at your head.\n\n")
					term.text_out(color.LIGHT_RED, "Lunch: ")
					term.text_out("Who ya talkin' so familiarly to, buster?\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("My...where did you get that uzi? You couldn't possibly have had that hidden in your blouse. Or if you did...I wonder what else might be in there. Maybe I should check, just to be safe...\n\n")
					term.text_out(color.LIGHT_RED, "Lunch: ")
					term.text_out("Come any closer and it'll be brains you's is inspectin!\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Trust me, she means it.\n\n") 
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("...ahh, maybe we should resume this conversation outside...\n\n")
					term.text_out("(Lunch lets off a dozen rounds with the uzi\n\n")
					term.text_out(color.LIGHT_RED, "Lunch: ")
					term.text_out("Stop or I'll shoot!\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "You ")
					term.text_out("and Rosshi both jump behind the couch as Lunch unloads the rest of her clip in the walls.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("...so, uhh...Rosshi? You did say very specifically that you wanted a not-so-nice girl, right?\n\n") 
					term.text_out(color.LIGHT_RED, "Lunch: ")
					term.text_out("Bwahahaha!!! This is so fun! But damn it I'm not drunk enough! I needa nutter bottle a jaggermeister\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Hmm. Perhaps I was mistaken.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Still, a deal is a deal, right?\n\n") 
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Yes, a deal is a deal. In fact, maybe should we should begin training right now. Maybe off in the woods someplace?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("That's probably a good idea.\n\n")
					term.text_out(color.LIGHT_RED, "Lunch: ")
					term.text_out("Aarrghghghghghgh!!!! Banzai!!!!\n\n")
				elseif ans == "c" then
					party.unparty(RACE_VIDEL)
					dball_data.rosshi_girl = RACE_VIDEL
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("Hello! It's so nice to meet you. I'm Mr. Satan's daughter. Yes, I know. It's so difficult being the daughter of such a famous person. Nobody really ever gives me credit for being me. I'm always just an afterthought, a shadow in everyone's mind. It's so frustrating.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("You're who's daughter?\n\n")
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("Mr. Satan.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("You're the devil's daughter?\n\n")
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("What? No! It's a stage name. Mr. Satan? The martial artist?\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Never heard of him.\n\n")
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("...you've never heard of my father? Ever? ...really...?\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Nope. No clue who who is.\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("Wow! You've really never heard of my father?\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Really. Why? Does it matter? I'm really more interested in you, anyway. Tell me about yourself.\n\n")
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("Oh, gladly! Yay! Oh, " .. player_name() .. ", thank you! Somebody who's never heard of my father! I could stay here forever!\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("That could be arranged.\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Well, " .. player_name() .. ", you've far exceeded my expectations. I think it's time to start training. Don't you agree?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Sounds good to me.\n\n")
				elseif ans == "d" then
					party.unparty(RACE_CHICHI)
					dball_data.rosshi_girl = RACE_CHICHI
					term.text_out(color.LIGHT_BLUE, "Chichi: ")
					term.text_out("Oh! This is Rosshi? I'm so sorry, sir! I didn't recognize you. I haven't seen you since I was a little girl. Do you recognzie me? I'm Chichi! Ox King's daughter.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("My, my...Chichi, you've certainly grown out. I mean up. Well, both, really.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Rosshi was hoping to have somebody stay with him. He could really use some help with cooking and cleaning, since he's so old and-\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Ahem. Actually, I feel postively young and spritely! Why, just look at me. I could almost pass for Chichi's older brother. No, wait...that's not right. I could pass for " .. player_name() .. "'s brother!\n\n")
					term.text_out(color.LIGHT_BLUE, "Chichi: ")
					term.text_out("Oh, Rosshi! You're so silly! Of course I'll stay with you. Daddy wouldn't want you to be all alone like this.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Excellent! Of course, there's only one bedroom here, so...\n\n")
					term.text_out(color.LIGHT_BLUE, "Chichi: ")
					term.text_out("Oh, that's ok. I can sleep on the couch.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("...oh, there's no need for that. We'll come up with a comfortable arrangement, I'm sure.\n\n")
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Well, " .. player_name() .. ", you've far exceeded my expectations. I think it's time to start training. Don't you agree?\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Sounds good to me.\n\n")
				end
				dialogue.conclude()
				dball_data.rosshi_state = 3
				fall_through = 1
			end

		else
			term.text_out("Master Rosshi is completely transfixed on television, and ignores you completely.\n\n")
			term.text_out(color.LIGHT_BLUE, "Aerobics Girl: ")
			term.text_out("Lift that leg higher! Count with me now: one, two! One, two! Feel the burn!\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("...one, two...one, two...\n\n")
			dialogue.conclude()
			term.load()
			return
		end
		dialogue.conclude()
		term.load()
		fall_through = 1
	elseif dball_data.rosshi_state == 6 then
		term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
		term.text_out("Ahh...yes. Hello. The new guard does replace the old. Twenty years ago I'd be out training to defeat you in a rematch, but I think I've had my share of dueling. It's just time to move on.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.rosshi_state == 7 then
		if quest(QUEST_CHI_CRANE).status == QUEST_STATUS_TAKEN then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Well, well, well! If it isn't the student of my rival. Come to do a little spying for that Crane bozo, Tsuru-what's-his-name? Well, I don't mind. But don't expect to get anything useful out of your visit.\n\n")
			dialogue.helper("It pays to keep close to one's enemies.", "a")
			dialogue.helper("I am here to prove the superiority of Crane by defeating you in combat.", "b")
			if dball_data.karin_hole == 10 then
				dialogue.helper("Karin says you have the Nyoi-bo. Give it to me.", "c")
				if player.stat(A_CHR) > 14 then
					dialogue.helper("We don't have to be enemies. We've both trained under the great Karin. That makes us peers, in a way.", "d")
				end
			elseif dball_data.karin_hole == 11 then
				dialogue.helper("Hello, Rosshi. I just stopped by to say hello. Any news on the Nyoi-bo?", "e")
			elseif dball_data.karin_hole == 12 then
				dialogue.helper("Hey, Rosshi! Guess what? I found the Nyoi-bo!", "f")
			end
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Indeed it does.\n\n") 
			elseif ans == "b" then
				term.text_out("\n\n") 
				if player.get_sex() == "Female" then
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("...oh? You want to fight me? Hmm. How about I'll agree to fight you if you let me fondle your boobs.\n\n") 
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("WHAT!?!!?\n\n") 
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Just a little feel.\n\n") 
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Die, old man!\n\n") 
				else
					term.text_out("Very well. I knew this day would come. Come at me.\n\n") 
				end
				dball.annoy_monster(RACE_ROSSHI)

			elseif ans == "c" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Ha! The Nyoi-bo? Turtle may be slow but at least it's not stupid! Do you see a magic staff anywhere? Wouldn't that be an obvious thing if I had it just lying around? Go crawl or fly back to your master and ask him to teach you some smarts. And some manners.\n\n") 
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			elseif ans == "d" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Peers? That's awfully presumptuous of you. But, you've trained with Karin, huh? That's not easy. \n\n") 
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yes. And he said that his most recent student, you...used a magic staff to gain entry to Kami's Lookout above his tower. That's an even more impressive feat.\n\n") 
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Speaking to Kami? Yes, I suppose it is. Wow...that was ages ago. I wonder what happened to the Nyoi-bo after all these years.\n\n") 
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Karin seemed to think that you had it.\n\n") 
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Me? No, I traded it away decades ago for an aerobics video with some most delicious-looking young girls in it.\n\n") 
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("You SOLD the Nyoi-bo to buy a workout video...to watch the girls?\n\n") 
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				if player.get_sex() == "Female" then
					term.text_out("Well, I wouldn't have needed to if you had come into my life sooner. But since you have, let's celebrate! What color panties are you wearing right now? No, don't tell me...let me see.\n\n")
				else
					term.text_out("Yes, exactly. It's important to have priorities. This was twenty, maybe thirty years ago. I've no idea where it would be now.\n\n")
				end
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("...umm...excuse me...I have to go. I suddenly feel a bit ill.\n\n") 
			elseif ans == "e" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Still looking for it? No, I have no idea. I wouldn't even know where to start. The market I sold it at was torn down to make a parking lot almost ten years ago. It could be anywhere.\n\n") 
			elseif ans == "f" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Wow, really? That's terrific! ") 
				if player.get_sex() == "Female" then
					term.text_out("Of course, it was really a waste of time, you know.") 
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("In a way, yes, since all Crane students learn to fly. But I wanted to have it anyway.\n\n") 
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("No, that's not what I meant. The Nyoi-bo is just a staff that extends. And I've had one of those all along I'd have been happy to have given you.") 
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("What? Another Nyoi-bo?\n\n") 
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Not exactly. But since you're so eager to see it...why don't you come over here and unbutton my pants, and I'll show you!") 
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Gah! You pevert!\n\n") 
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Always.") 
				else
					term.text_out("\n\n") 
				end
			end
			dialogue.conclude()
			term.load()
		else
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Well, well, well! If it isn't the student of my rival. Come to do a little spying for that Crane bozo, Tsuru-what's-his-name? Well, I don't mind. But don't expect to get anything useful out of your visit.\n\n")
			dialogue.conclude()
			term.load()
		end
	elseif dball_data.rosshi_state == 8 then
		term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
		term.text_out("Die, you monster!")
		-- agression handling via dungeon level gen hook
	elseif dball_data.rosshi_state == 9 then
		term.load()
		fall_through = 1
	elseif dball_data.rosshi_state == 0 then
		if enrollments[FLAG_ENROLL_CRANE_HERMIT] > 0 then
			-- Not used. Handled above, yes?
		else
			-- term.text_out(color.LIGHT_GREEN, "You ")
			-- term.text_out("get goosebumps as you approach the famous fighting Master Rosshi. Renowed worldwide as the 'God of Martial Arts,' you can only imagine what sort of fantastic training he must constantly subject himself and his students to. He seems to be watching television.\n\n")
			-- term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
		end


		if player.get_sex() == "Female" then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Well, hello beautiful! What brings a luscious lady like yourself to my little island retreat?\n\n")
			dialogue.helper("You're Master Rosshi, right? You're a renowned martial artist, and I was hoping you could teach me a few special techniques.", "a")
			dialogue.helper("Oh, just passing through.", "b")
			if dball.persuade(14) then
				dialogue.helper("(Persuade 14) I just had to see the great master in person! Wow! You're even cuter than your headshots!", "c")
			end
		else
			if called_by == "television" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Hey! Don't stand in the way of the television! I'm watching this.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Sorry. I couldn't seem to get your attention otherwise.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("It's not like I didn't notice you. I just didn't want to talk. Who are you anyway, and what are you doing in my house?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("I think I recognize you. You're Rosshi, aren't you? 'Master' Rosshi? The famous martial arts master?\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("So what if I am? I'm retired. Go away!\n\n")
				dialogue.helper("Is there anything I could do to convince you to take a student? Even just a few lessons?", "d")
				-- NOTE: 'e' 'when the student is ready the teacher will appear' has been removed
				dialogue.helper("Sorry, I was just exploring the area. I'm an adventurer. We tend do to that sort of thing.", "f")
			else
				term.text_out("Master Rosshi is focused intently on a women's aerobics video on the television. \n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Hmm? Go away. Can't you see I'm busy?\n\n")
				dialogue.conclude()
				term.load()
				return
			end
		end

		if dball_data.karin_hole == 1 then
			dialogue.helper("Hello. I'm a student of Karin and he suggested that I ask you about the Nyoi-bo.", "g")
		end

		local ans = dialogue.answer()
		term.load()
		term.save()
		dialogue.prep()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Well, pumpkin...I'm sure I could...but what's in it for me?\n\n")
			term.text_out("(You're not altogether certain you like the way he's looking you up and down.)\n\n")
			dialogue.helper("Umm...I don't know. What do you want? ", "a")
			if dball_data.alignment < 0 then
				dialogue.helper("How about I let you keep the panties I'm wearing? Unfortunately my hands are real tired from the swim over to your island. Maybe you could help a girl out and take them off for me? Say...with your teeth?", "b")
			end
				if dball_data.alignment > 9 then
				dialogue.helper("You'll be building good karma, conributing to the world, and feel an immense sense of personal satisfaction for having helped another human being!", "c")
			end
			if dball.persuade(16) then
				dialogue.helper("(Persuade 16) Pumpkin?!?!?! That's so adorable! My grandfather used to call me that! Wow! You remind me of him! (Act untouchably innocent)", "d")
			end
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("What do I want? Hmm...let me see...what do I want...\n\n")
				-- term.text_out("(He starts to peek under your skirt.)\n\n")
				term.text_out("He starts sliding his cane up the inside of your thighs to lift your skirt. You instinctively bat his cane away and give him a dirty look.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Oh...come on. All I want's a quick peek.\n\n")
				if dball_data.alignment < 0 then
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("No! Are you some kind of pervert or something!?!?!\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("What...are you some kind of prude? I thought you wanted you take some lessons with me. I must have misunderstood. Oh well. Do come again!\n\n")
					dialogue.conclude()
					term.load()
					return
				end
				term.text_out("(Implement negative alignment option)\n\n")
				dialogue.conclude()
				term.load()
				
			elseif ans == "b" then
				term.text_out("There is a brief moment of silence and Rosshi's mouth drops open. He blinks a few times. Clearly a deer in headlights. You wave a hand in front of his face a few times, and get no response. So tug you suggestively at your blouse a few times and that wakes up him.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("...umm, ok!\n\n")
				term.text_out("Rosshi takes you up on your offer, thoroughly savoring and enjoying every moment. Surprisingly, he seems content to honor the deal exactly as proposed without taking any liberties with your nakedness, though he does manage to stretch it out over about five minutes. Five obviously very joyful minutes to him, and he looks years younger afterwards. To your horror, however, rather than taking your panties and putting them discretely into a drawer someplace, he pulls a picture frame from a cupbaord and mounts them on the wall.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("That glass will help keep the scent fresh! Well then, my dear...how about those lessons?\n\n")
				dialogue.conclude()
				dball_data.rosshi_state = 2
				dball_data.rosshi_seduction = dball_data.rosshi_seduction + 5
				fall_through = 1
			elseif ans == "c" then
				term.text_out("A look of abject confusion slowly comes over his face as he tries to comprehend your meaning. It obviously takes a great deal of effort, but then all at once he 'gets it' and then laughs at you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("You mean...like, just to be 'nice?'\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yes! I find that kindness and generosity makes the whole world a better place! There's nothing as completely satisfying as helping somebody! :)\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("...right. I, on the other hand, find that they make for a lonely retirement, and if there's any body I'm going to help myself to...it's going to be YOURS.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("...umm...I'm not sure I'm ok with that.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("That's ok. You just sit there and be undecided as long as you'd like. Please. Take a long time.\n\n")
				term.text_out("He happily sits himself in a chair and proceeds to stare at your boobs.\n\n")
				dialogue.conclude()
				dball_data.rosshi_state = 0
			elseif ans == "d" then
				term.text_out("Rosshi looks shocked for a moment...then disappointed...but finally he can't help but smile.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Hehehe...well, I've never been anyone's grandfather before. My daughter never had children. So you want to train with me? You know...now that I think about it, it sure would be nice to have some company. I get kind of lonely with just me and Umigame all the time. Ok. I'll do it!\n\n")
				dialogue.conclude()
				term.load()
				fall_through = 1
				dball_data.rosshi_state = 9
			end
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Really? How delightful! I have company so rarely, it really is a delight to have you here. Stay as long as you'd like!\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Really? Wow...this is nothing. You should see me when I'm working out. Hey...you study martial arts, right? How'd you like to work out with me?\n\n")
			dialogue.helper("With you? Definately!", "a")
			dialogue.helper("Maybe later, hot stuff.", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				fall_through = 1
				dball_data.rosshi_state = 2
				dball_data.rosshi_seduction = dball_data.rosshi_seduction + 2
			elseif ans == "b" then
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Just name the time!")
			end
		elseif ans == "d" then
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Not unless you have a cute younger sister you'd like to sell into domestic slavery. Your mother, maybe? Grandmother? I'm not picky.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...'domestic' slavery? Have you tried prostitutes?\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Don't be so vulgar. I'm too old and dignified for that sort of thing. I just want to see some cute young thing from time to time. It's good for liver function.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...right. Liver function. And the aerobics videos are your only way of getting that, huh? \n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmph. If you're quite through, I'm a busy man. I'm sure you can find your way to the door.\n\n")
			dialogue.helper("Ok. I'll leave. Sorry to trouble you.", "a")
			dialogue.helper("What if I can find a nice domenstic type of girl who'd be willing to stay here to cook and clean. That sort of thing?", "b")
			if dball.player_has_item_with_flag(FLAG_PORN) > 0 then
				dialogue.helper("Well, since you don't need to touch, you just want to see...I happen to have some nice magazines on me...", "c")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
			elseif ans == "b" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("A nice, cute young girl?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yes.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("With big boobs?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yes.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Maybe...cute and young, but not so nice?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Sure. That will probably be easier to find anyway.\n\n")
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("Done. Bring a girl like that to stay here with me, and I'll train you all you want.\n\n")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_ROSSHI_LONELY, QUEST_STATUS_TAKEN)
				dball_data.rosshi_state = 2
			elseif ans == "c" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
				term.text_out("What!??! You have a nasty, filthy, disguting porno sex magazine with you? You DARE to bring something like that into the house of the great Master Rosshi?!!?\n\n")
				dialogue.helper("Umm...no. I wouldn't do such a thing. It's really quite a tasteful magazine.", "a")
				dialogue.helper("Yep. Cosplay girls, tentacle rape, bukake...you name it, it's in here. You want it or not?", "b")
				local ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("Oh. Then I'm not interested. Get out of here before I thrown you out and then have to spend my evening patching up the hole in the wall.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("But...I really want you to train me.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
					term.text_out("And I really want to have some female companionship. You go find some for me, and I'll train you.\n\n")
					dialogue.conclude()
					term.load()
					change_quest_status(QUEST_ROSSHI_LONELY, QUEST_STATUS_TAKEN)
					dball_data.rosshi_state = 2
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")	
					term.text_out("Really!?!?! GIMME! GIMME! GIMME! PLEASE!\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Sure. I have it right here. Just let me get it out of my pack.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")	
					term.text_out("Oh...hurry! Let me SEE!!!\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Here you go. Nice, isn't it?\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")	
					term.text_out("It's fantastic! The girls are so...shameless! I have to have it!\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Agree to train me and it's yours.\n\n")
					term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")	
					term.text_out("Deal!\n\n")
					dialogue.conclude()
					term.load()
					dball_data.rosshi_state = 9
					fall_through = 1
					dball.remove_items_with_flag(FLAG_PORN, 1)
				end
				
			end

		elseif ans == "f" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Ehh? Yeah, I know the type. Go away and don't come back.\n\n")
			dialogue.conclude()
			term.load()
			return
		end
	end

	-- Train
	if fall_through ~= 0 then
		if dball_data.karin_hole == 1 then
			dball_data.karin_hole = 2
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Hello! Do you remember anything about a hole in Karin's Tower? Karin says you made it so you could climb a staff and talk to Kami.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Yes, though that was ages ago. I wanted to talk to Kami and I had a magic staff that could be made to extend by speaking a command word. I take it you'd like to speak to Kami yourself?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes.\n\n")
			term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
			term.text_out("Hmm, well, unfortunately I gave the Nyoi-bo to my sister, Uranai Baba, after an argument a few years back. She lives on the neighboring island of this lake. You might ask her if she still has it, but don't expect anything. She can be a bit difficult.\n\n")
			dialogue.conclude()
			term.load()
		else
			if dball_data.rosshi_turtle_shells == 0 then
				dialogue.ROSSHI_SHELL_ONE()
			end
			dball.enroll(FLAG_ENROLL_ROSSHI)
		end
	end
end
function dialogue.ROSSHI_SHELL_ONE()
	term.save()
	term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
	term.text_out("Before we begin, let me give you this turtle shell to wear on your back. It weighs fifty pounds, and will help you to train more quickly.\n\n")
	dialogue.conclude()
	term.load()
	dball_data.rosshi_turtle_shells = 1
	local obj = create_object(TV_CLOAK, SV_TURTLE_SHELL)
	make_item_fully_identified(obj)
	dball.reward(obj)
end
function dialogue.ROSSHI_SHELL_TWO()
	term.save()
	term.text_out(color.LIGHT_BLUE, "Master Rosshi: ")
	term.text_out("I see you've grown much stronger in the time you've been training with me. I think it's time for you to wear a heavier shell. Here, wear this 100 pound shell. It will help you train more quickly.\n\n")
	dialogue.conclude()
	term.load()
	dball_data.rosshi_turtle_shells = 2
	local obj = create_object(TV_CLOAK, SV_HEAVY_TURTLE_SHELL)
	make_item_fully_identified(obj)
	dball.reward(obj)
end

function dialogue.KARIN()
--[[
	-- Badger Check
	local found = {}
	-- local material_check = 0

	for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
		function(obj, i, j, item)
			if obj.tval == TV_CORPSE then
				if obj.sval == SV_CORPSE_CORPSE then
					--race_info(obj.flags[FLAG_MONSTER_IDX]).flags[FLAG_I_AM_A_BIRD] then
					local race = r_info[1 + get_flag(obj, FLAG_MONSTER_IDX)]
					if has_flag(race, FLAG_I_AM_A_BADGER) then
						-- %material_check = 1
						%found.obj  = obj
						%found.item = item
						return
					end
				end
			end
		end)

	if found.obj then
		term.load()
		term.save()
		term.text_out("Karin's nose twitches.\n")
		term.text_out(color.LIGHT_BLUE, "Karin: ")
		term.text_out("You've brought me a badger! How nice!")
		dialogue.prep()
		dialogue.helper("Why yes, here you go.", "a")
		dialogue.helper("No, sorry. ", "b")
	end
]]


	if dball_data.karin_fight == 1 then
		message("I'm still waiting for you to kill me. Come now, at least try.")
		return
	end

	local elevator_comment = 0

	if dball_data.karin_state == 0 then -- First contact
		dball_data.karin_state = 1

		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Karin: ")
		term.text_out("I'm impressed. You're only the third person in over a hundred years to survive the long climb up my tower.\n\n")
		dialogue.helper("Thank you. I do hope the trip will turn out to be worthwhile.", "a")
		dialogue.helper("Really? Who was the last one?", "b")
		dialogue.helper("Stupid cat! You'd get more company if you'd install an elevator!", "c")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Of course! Nobody climbs my tower just to see the view. Which is a shame, really, because the view is really quite lovely from the roof. I highly recommend you take a look when you get the chance. ")
		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("A Saiyan boy by the name of Goku. Took him three days. Well, the first time, anyway. He had something of an accident, and had to climb the tower two more times before I taught him anything. ")
		elseif ans == "c" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Hahaha! Yes, I'm sure I would. That's why I haven't. I enjoy my solitude, and prefer only to spend my time with those who are worthy of it. Which, by the way, is you...since you've succesfully climbed the tower even without an elevator. ")
			elevator_comment = 1
		end
	
		-- (All three responses fall through to here)

		term.text_out("I suppose then, you have come to train with me?\n\n")
		dialogue.prep()
		dialogue.helper("Would you tell me about yourself, and this place, first? I'm most curious.", "a")
		dialogue.helper("Yes. Yes, I would.", "b")
		dialogue.helper("No, thank you. I'd much rather just kill you. (attack)", "c")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Of course. I'm a cat! I'm my favorite subject! As you've no doubt guessed, I'm the master of this tower, as well as the original architect. I became somewhat of a well known Chi Master about...oh...two hundred years ago, and eventually I tired of incompetants perpetually badgering me for training. Actually, I rather like badgers. Quite tasty. Anyway...so, at that time, Kami and I were spending a good deal of time together, and...\n\n")
			dialogue.helper("Excuse me, but who's 'Kami?' (interupt)", "a")
			dialogue.helper("(Keep listening)", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Karin: ")
				term.text_out("Who's Kami..? Kami! The God of this planet! Don't you keep up on current events? He's only been God of the earth for about, oh...hmm. Actually, I'm not even sure how long it's been. Several of my lifetimes, at least. You might ask Him. He lives a few hundred feet up from here, as I was about to explain")
				dball_data.karin_kami = 1
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Karin: ")
			end
			dialogue.prep()
			term.text_out("...He mentioned to me one day that while He never tired of looking down on the earth, He sometimes felt disconnected from it, and wanted to give humanity more opportunity to meet Him face to face. Not just anybody, mind you, only those who proved themselves worthy, but at least a few, every now and then. I couldn't relate to His wanting to speak to MORE people when I wanted to speak to LESS people, but after some conversation we found a way to solve both our problems at once: Build this tower, beneath Kami's Lookout to serve as a test for those who wished to see either of us, and to act as a physical conduit to Him for those who passed the test. It been a few hunded years now, and it's worked out rather well for the both of us.\n\n")
			dialogue.helper("Wait...are you telling me that GOD lives above your tower?!?!?", "a")
			dialogue.helper("Thank you. That clears everything up. I'm here to see you though, not Kami. Shall we train?", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out("(Karin looks at you strangely for a few moments)\n\n")
				term.text_out(color.LIGHT_BLUE, "Karin: ")
				term.text_out("Well, yes. The God of this planet, anyway. Where else would you expect Him to live? The moon, perhaps? I suppose no one ever explained to you the dynamics of the Celestial Hierarchy? No? Hmm. Well, I'm not the most well-versed in the details, but I'll give you the general overview. You see, every populated planet in the universe is assigned an Overseer, a 'God' if you will. Could be anybody. Curiously, ours happens to be a Namekkian, but it could have been anybody. The position vacates every once in a while, and when it does somebody has to take the old God's place. Personally, I wouldn't want the job, but some people are more ambitious than me. Anyway, next up, depending on size, each galaxy in the univese is divided up into regional districts, each of which has it's own 'Kaio' assigned to it. In our case, our galaxy is divided up into four cardinal districts: north, east, south and west, with a Kaio in charge of each. If you get the chance, I do highly recommend visiting the North Kaio. He's a friendly chap, and an excellent chess player.\n\n")
				dball_data.karin_kaio_chess = 1
				dialogue.prep()
				dialogue.helper("You're telling me that God plays chess?", "a")
				dialogue.helper("What's a Namekkian?", "b")
				dialogue.helper("I see. Yes, please continue.", "c")
				local ans = dialogue.answer()
				if ans == "a" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Karin: ")
					term.text_out("No, not Kami. He doesn't care for chess. It's the North Kaio who likes chess. Well, not professionally, or anything, but all in all, He's rather good. ")
					dball_data.karin_daio = 1
				elseif ans == "b" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Karin: ")
					term.text_out("A Namekkian? As in...someone from the planet Namek? You have heard of Namek, haven't you? Green skin, antennae, you've seen them. No...? Never? Wow. You really need to get out more often. Earth's really a rather tiny planet in the universe, and there's a lot you're missing out on if you never even leave your own backyard. Go see the North Kaio. Tell him I said hello. But, to get back to the hierarchy: ")
				elseif ans == "c" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Karin: ")
				end
				-- Both answers fall through
				term.text_out("Above the Kaio are the Kaioshin, of whom there are four in the universe, which is also divided up into cardinal districts. Since the Kaioshin each oversee countless galaxies, it is very rare to meet one, but it can happen. Finally, above the four Kaioshin is the Supreme Grand Daio, also known as 'The Supreme Kai' Who oversees All-That-Is. I hear He holds a tournament every billion millenia or so, but you probably won't get to meet Him, but there are Daio other than the Grand Daio who perform other functions, and they're generally more accessible if you'd like to meet one. For instance, you could always swing by Emma's place on the Serpent's Path. Not that there's any rush, you'll get to see Him when you die anyway, since he's the one who judges souls and determines who goes to Heaven, and who goes to Hell. Of course, most humans aren't sufficiently strong willed to remember much of the afterlife. If you become a practitioner of Chi, though, you'll at least stand a good chance. Just practice, strengthen your will as much as possible, and you may be able to maintain the integrity of your spirit after death. Speaking of practitioners of Chi...shall we begin our lessons?\n\n")
				dialogue.conclude()
				term.load()

			elseif ans == "b" then
				term.load()
			end

		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Wonderful! I haven't had a student in years!\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "c" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Ahh. Well, you're welcome to try, of course. In fact, just to keep it interesting, I'll even give you a senzu bean in case I get too excited and accidentally tear one of your arms off. That happens, sometimes.\n\n")
			dialogue.conclude()
			term.load()
			local s_obj = create_object(TV_FOOD, SV_SENZU_BEAN)
			make_item_fully_identified(s_obj)
			dball.reward(s_obj)
			dball_data.karin_fight = 1
			dball_data.karin_senzu = dball_data.karin_senzu + 1
			return
		end

		-- Do only once:
		-- Let the enrollment script do it thing
		dball.enroll(FLAG_ENROLL_KARIN)

		term.save()
		-- Senzu count begins from first training
		dball_data.karin_first_visit = player.lev
		term.text_out(color.LIGHT_BLUE, "\nKarin: ")
		term.text_out("Please feel free to come back anytime you'd like to train. Also, let me share with you a secret that I generally reserve only for fighters I have trained. You see my greenhouse? I grow a very special sort of magic bean, the 'Senzu Bean.' They have unique and powerful healing properties. Eat one...and your body will be instantly rejuvenated! They can even grow back lost limbs! Unfortunately, they are equally rare as powerful, and it takes about a hundred years for a single bean to ripen. Fortunately, I have several thousand senzu plants growing in my greenhouse, but even so, it's sometimes days or weeks between ripenings. But, then at other times, several ripen at once. I don't have them evenly staggered. In any case, it happens that I do have one ripe bean on hand, and I'd like to give it to you. Use it wisely.\n\n")
		dialogue.conclude()
		term.load()
		local s_obj = create_object(TV_FOOD, SV_SENZU_BEAN)
		make_item_fully_identified(s_obj)
		dball.reward(s_obj)
		dball_data.karin_senzu = dball_data.karin_senzu + 1
		return
	end -- First contact

	term.save()
	term.text_out(color.LIGHT_BLUE, "Karin: ")
	term.text_out("Hello, " .. player_name() .. "! It's always good to see you! What brings you?\n\n")
	dialogue.helper("I have come to train with you.", "a")
	dialogue.helper("I just wanted to see if you had any senzu beans to spare.", "b")
	if quest(QUEST_CURIOUS_HOLE).status == QUEST_STATUS_TAKEN and dball_data.karin_hole == 0 then
		dialogue.helper("What's with the hole up on the roof?", "c")
	end

	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
		dball.enroll(FLAG_ENROLL_KARIN)
	elseif ans == "b" then
		local senzu_bean = player.lev - dball_data.karin_first_visit - dball_data.karin_senzu
		if senzu_bean > 0 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			if senzu_bean == 1 then
				term.text_out("Ahhh...looks like I have one senzu bean that just ripened today. Here you go.\n\n")
				dialogue.conclude()
			elseif senzu_bean > 7 then
				term.text_out("Wow, it's really been a while since you've been by, hasn't it? I have " .. senzu_bean .. " senzu beans sitting here! Here, you can have them all.\n\n")
				dialogue.conclude()
			else
				term.text_out("Yes, I have a few senzu beans set aside for you. I hope you find them useful.\n\n")
				dialogue.conclude()
			end
			term.load()
			local s_obj = create_object(TV_FOOD, SV_SENZU_BEAN)
			make_item_fully_identified(s_obj)
			s_obj.number = senzu_bean
			dball.reward(s_obj)
			dball_data.karin_senzu = dball_data.karin_senzu + senzu_bean
		else		
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("I'm sorry. Senzu beans grow extremely slowly. I'm happy to share them with fighters I have trained, but it takes time. Check back from time to time though, I should have more before long.\n\n")
			dialogue.conclude()
			term.load()
		end
	elseif ans == "c" then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Karin: ")
		if enrollments[FLAG_ENROLL_ROSSHI] > 0 then
			term.text_out("There's a hole in the roof...? Oh! You mean the nyoi-bo hole? That was made by a former student of mine by the name of Rosshi. He never learned to fly, but he wanted to speak to Kami, so he poked a hole in the stone with a finger, and used it to mount a magic staff he had. The staff could be made to extend to any length merely by speaking a command word. This was decades ago...but you might talk to Rosshi about it. I hear he's living on an island northeast of here.\n\n")
			dball_data.karin_hole = 1
			dialogue.conclude()
			term.load()
		elseif enrollments[FLAG_ENROLL_CRANE_HERMIT] > 0 then
			term.text_out("The Nyoi-bo hole? There's actually quite a story behind that, but it would hardly matter to a student of the Crane style like yourself. My last student was the master of the Turtle school, Rosshi. He wanted to speak to Kami, so he poked a hole in the stone with his finger and used it to mount a magic staff in his possession that was able to extend to any length, thus allowing him to climb up to Kami's Lookout.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Really? Maybe I should get myself a nyoibo.\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Not much point. As a student of Crane, you should be able to simply fly up to the Lookout. Plus, the last person to have the Nyoibo was Rosshi, and he's not likely to simply give it to a student of his rival.\n\n")
			dball_data.karin_hole = 10
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_CURIOUS_HOLE, QUEST_STATUS_FINISHED)
		else
			term.text_out("The Nyoi-bo hole? A former student of mine made it get to Kami.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("He spoke to Kami? How does the hole help? What's a Nyoi-bo?\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("I don't think you're quite ready to be worrying about that yet. Try training a few more years, learn from a few more masters other than me, and maybe someday you'll be ready to see Kami. But, not today.\n\n")
			dialogue.conclude()
			term.load()
		end
	end

	-- Kinto Un check regardless of reason for visit (but must be a student to get here)
	if dball_data.karin_kinto == 0 then
		if dball_data.alignment > 99 and dball_data.ever_been_evil == 0 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("By the way, even though it's good training I'm sure it must get old climbing the tower. Since you've already done it, there's not much point in cointinuing the tedium. Here, let me give you a Kinto Un.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("A what?\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("...Kinto Un. It's a magic, flying cloud. Only the pure of heart are able to ride them, but I've seen into your heart, and I think you qualify.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...why, thank you karin!\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Hey! Don't be so sentimental. Just take the cloud and get out of here.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out(":P\n\n")
			dialogue.conclude()
			term.load()
			local obj = create_artifact(ART_KINTO_UN)
			make_item_fully_identified(obj)
			drop_near(obj, -1, player.py, player.px)
			--dball.reward(obj)
			dball_data.karin_kinto = 1
		elseif dball_data.alignment < -99 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("You know, I'm teaching you out of principal, but it saddens me greatly that you've chosen to embrace evil.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Me?\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("YES YOU! Don't feign ignorance. I know all about you. Still, I am a teacher and you are a student. Just because I disapprove of you doesn't change the obligation I have to teach.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("What a curious predicament. I'm glad I don't feel such moral obligations.\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("I bet.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("I'm going to give you something.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Give me...? What, a scolding for my wretchedness?\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Yes, that too. But, I have something that I have no use for, that you might.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("What's that?\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("It's an evil Kinto Un.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("A what...?\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Kinto Un. Tuned to evil. Most Kinto Un may only be ridden by the supremely pure of heart. But some few, such as this one, choose to refine themselves differently. I'd like to give it to you. It will allow you to fly, so long as you remain evil. Which, I hope is not very long.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wow. Thank you, Karin. That's very kind of you.\n\n")
			term.text_out(color.LIGHT_BLUE, "Karin: ")
			term.text_out("Yes. I pray that you learn from my example.\n\n")
			dialogue.conclude()
			term.load()
			local obj = create_artifact(ART_EVIL_KINTO_UN)
			make_item_fully_identified(obj)
			dball.reward(obj)
			dball_data.karin_kinto = 2
		end
	end
end

function dialogue.KAMI()
	term.save()
	term.text_out(color.LIGHT_GREEN, "Kami: ")
	term.text_out("Greetings, " .. player_name() .. ". What may I do for you?\n\n")
	dialogue.helper("Nothing right now, thank you. I'm just visiting.", "a")
	dialogue.helper("Would you help me to train?", "b")
	if enrollments[FLAG_ENROLL_KAMI] > 14 and quest(QUEST_KAMI_TO_KAIO).status == QUEST_STATUS_UNTAKEN then
		dialogue.helper("Do you have any advice on how I can further improve my training?", "c")
	end
	if dball_data.kaio_state == 1 and jokes[2] == 0 then
		-- Note that the player does NOT need to be formally issued the quest by Kami to train
		-- with the Kaio, not to get the joke from Kami
		dialogue.helper("The North Kaio says he won't train me until I can make him laugh. Do you know any jokes?", "d")
	end
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
	elseif ans == "b" then
		dball.enroll(FLAG_ENROLL_KAMI)
	elseif ans == "c" then
		term.save()
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("Hmm. Yes, I do. You are right. You have learned much from me, but it is time for you to ascend even higher in your training. Higher than even I can take you. You must seek our the North Kaio, and train with him.\n\n")
		if dball_data.karin_kaio_chess == 1 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("The North Kaio? I think Karin mentioned him. He's the guy who's really good at chess, right?\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("Chess? Don't be silly. The North Kaio is a powerful telepath. But, he's an even more powerful Chi Master, and I will help you to see him for training.\n\n")
		elseif dball_data.emma_mentioned_kaio == 1 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("The North Kaio? That names sounds familiar. Where have I...OH! The North Kaio! The Galaxy Overseer, right? Emma mentioned him.\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("I am impressed that you've spoken with a Daio about such things. Yes. And it is the Kaio with whom you must train to further your skills.\n\n")
		else
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("North Kaio? Who's that?\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("While Kami watch over mere planets, the Kaio watch over vast regions of space. There are four Kaio in our galaxy, each watching over a single quadrant, and training potential warriors to help guard them. Earth lies within the jurisdiction of the Northern Kaio, and it is He with whom you must train to advance to levels I cannot take you.\n\n")
		end
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Sounds great. How do I get to him?\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("To reach the North Kaio you must cross the Serpent's Path.\n\n")
		if dball_data.times_died > 0 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Ehh. I've been there. Done that.\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("Hmph.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Is there any way I can get there without dying though? It's terribly inconvenient.\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("Indeed. I will open a portal for you from here. You may cross through it freely to the afterworld at any time.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Groovy.\n\n")
		else
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Will that be difficult?\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("Indeed. The Serpent's Path is a treacherous byway through hyperdimensional space, and guarded by Jajoushin, the Snake Princess.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Sounds kind of scary.\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("I have faith in ability to persevere. Here, I will open a portal for you to cross through into the afterworld. You may cross through it freely at any time.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Thank you.\n\n")
		end
		dialogue.conclude()
		term.load()
		change_quest_status(QUEST_KAMI_TO_KAIO, QUEST_STATUS_TAKEN)
		local c_ptr = cave(4, 15)
		c_ptr.info = 3
		flag_empty(c_ptr.flags)
		cave_set_feat(4, 15, FEAT_KAMI_TO_SERPENT)
	elseif ans == "d" then
		term.save()
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("Mmm. Yes, he has been known to be picky about his students. A joke? Let me see. How about: 'Why did the punk rocker cross the road?'\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Punk Rocker? Umm...I dont know. Why?\n\n")
		term.text_out(color.YELLOW, "Because he was stapled to a chicken.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Hehe...umm, wow. Ok, I wasn't expecting that. But, will it make him laugh?\n\n")
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("I don't know. Maybe. It's difficult to judge, with Him. His sense of humor has always been a bit, peculiar.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("I suppose it's worth a try, anyway.\n\n")
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("Don't worry. Even if this isn't the joke to do it, I'm sure you can find a way to make him laugh. Somehow.\n\n")
		dialogue.conclude()
		term.load()
		jokes[2] = 1
	end
end


function dialogue.KAMI_RESSURECT()
	dball_data.piccolo_hurt_player = 0
	dball_data.death_dialogue = 0
	term.gotoxy(0, 0)
	term.save()
	if dball_data.kami_state == 0 then
		term.text_out(color.LIGHT_BLUE, "You ")
		term.text_out("find yourself standing in an opulent room standing before Demon King Piccolo, who sits at a regal throne.\n\n")
		term.text_out(color.LIGHT_GREEN, "Demon King Piccolo: ")
		term.text_out("You are a most troublesome person. I do hope I made the right decision in bringing you here.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Why have you brought me here? Why did you spare my life?\n\n")
		term.text_out(color.LIGHT_GREEN, "Demon King Piccolo: ")
		term.text_out("An excellent question...and a mistaken one. You are not alive. \n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		if dball_data.times_died < 2 then -- Remember we had to die once to get here
			term.text_out("What? I'm dead?\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("Yes. I have brought you, your soul, here to my home rather than allowing it to continue to Judgement by the Daio.\n\n")
		else
			term.text_out("Hmm. I really need to stop dying. It's annoying. There are really much better uses for dragonball wishes.\n\n")
		end
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You've answered one question. What of the other? Why am I here?\n\n")
		term.text_out(color.LIGHT_GREEN, "Demon King Piccolo: ")
		term.text_out("Hmph. Troublesome and rude besides. I've kept you here on earth so you can fix the mess youv'e created by releasing Demon King Piccolo from his trappings.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You want me to trap you in the rice cooker again? Yeah, I'm ok with that.\n\n")
		term.text_out(color.LIGHT_GREEN, "Demon King Piccolo: ")
		term.text_out("No, you fool. Not me, Piccolo.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Umm, I'm confused. Aren't you Piccolo? You look just like him.\n\n")
		term.text_out(color.LIGHT_GREEN, "Demon King Piccolo...or maybe...Kami?: ")
		term.text_out("No. I am the God of this earth. Piccolo and I look the same because we are the same...the same flesh, the same blood.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		if dball_data.karin_kami ~= 0 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Oh! You're Kami! Karin told me about you. We must be in the Lookout, above Karin's Tower right now.\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("Yes. It bodes well that you already know of me. I was concerned that this worlds hero might have been a complete idiot. Of course, having released a demon into the world, I'm not yet entirely convinced that you are not.\n\n")
		else
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("You are surprised by this? This world is no different than any countless others like it. And each has a guardian appointed to it. A guardian for a time. I am not the first, nor will I be the last guardian of Earth. But, countless generations ago I aspired to become the current guardian. I approached the Kami before me...and he refused.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Refused?\n\n")
			term.text_out(color.LIGHT_GREEN, "Kami: ")
			term.text_out("To step down. He saw the evil in my heart and was wise to refuse me the position. But, so great was my desire that I drew the evil from my heart and cast it aside so I could fill this post. But, sadly, the evil that was within me was not destroyed, merely cast out. And it formed the Demon you have fought. The demon that you RELEASED.\n\n")
		end
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("How was I supposed to know there'd be a demon in a rice cooker? Seriously...who's idea was that?\n\n")
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("Did you not see the seals?!!? Did you expect to find nothing but crunchy old rice inside?!?!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Ahh. Seals. I do remember something about some seals. A certain feeling of foreboding and dread. Right.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("What you have done, you must undo. You have released a demon into the world, and you must remove him from it again.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Why me, exactly? I mean...I appreciate the, umm...offer, but aren't you God? Aren't you far more qualified to fix this than I am?\n\n")
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("I am merely the guardian of this world. There are countless powers above me, and it is not my place to act in this matter. I can, however, serve as a guide and teacher to those who may act.\n\n")
	else
		-- Player has visited Kami previously
		term.text_out(color.LIGHT_GREEN, "Kami: ")
		term.text_out("Hello again " .. player_name() .. ". It is a pleasure to see you again, though I really would prefer that the circumstances be different.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Hello, Kami. What happened? What am I doing here? I was fighting a horrible creature that looked just like you.\n\n")
	end
	dialogue.conclude()
	term.load()
end

function dialogue.POPO()
	--dball_data.popo_state 0=nocontact 1=contactnofight 2=startfight 3=fighthasoccurred 4=allowkami(if) 999=aggressive
	--	note that state = 4 may occur via piccolo thread too, skipping much of this
	--

	if dball_data.popo_state == 0 then
		if dball_data.piccolo_state == 0 then
			term.save()
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("I am Mr. Popo. Who are you? You no belong here.\n\n")
			dialogue.helper("Oh. Sorry. I'll leave.", "a")
			if dball_data.karin_kami == 1 then
				dialogue.helper("Hello. I'm " .. player_name() .. ". I'm here to see Kami.", "b")
			else
				dialogue.helper("Nice to meet you, Mr. Popo. I'm " .. player_name() .. ".", "c")
			end
			if dball_data.alignment < 0 then
				dialogue.helper("I don't? Oh. Then I must be a bad person. I guess I'll have to kill you then.", "d")
			end
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.load()
			elseif ans == "b" then
				term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
				if dball_data.ever_been_evil == 1 then
					if dball_data.alignment < 0 then
						term.text_out("That not possible. You are very bad. Kami no speak to bad people like you.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("But I'm a student of Karin in the tower below. Doesn't that count for anything?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("No. You go away now.\n\n")
						dialogue.helper("No, I don't think so. I intend to see Kami, and you're not going to stop me.", "a")
					else
						term.text_out("That not possible. You not pure of heart. Must be pure of heart see Kami.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("That's a little harsh isn't it?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Is true.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("What if I go do some goods deeds and then come back?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("What good deed? Go kill mean people? That not help.\n\n")
						dialogue.conclude()
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("So you're saying that there's absolutely nothing I can do that will allow me to speak with Kami?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Mr. Popo not make rules. Kami make rules. Only Kami change rules.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("Karin says that the tower serves as a test for fighters to see Kami. I've climbed the tower, I've trained with Karin, and I've made it here. I've passed all the tests, so why can't I see Kami?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Mr. Popo already explain. Must be pure of heart see Kami.\n\n")
						dialogue.helper("What if I prove myself to be a tremendous warrior? Say, by defeating you in a duel?", "a")
					end
				else
					term.text_out("That not possible. You are weak. Kami not speak to weaklings like you.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("That's a little harsh isn't it?\n\n")
					term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
					term.text_out("Harsh but true. I not waste your time. You too weak to see Kami. You go away now.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("What if I can prove to you that I am strong?\n\n")
					term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
					term.text_out("You are not. Can not prove what not true.\n\n")
					dialogue.helper("What if I can defeat you in combat? Would that prove I'm strong enough to see Kami?", "a")
				end
				dialogue.helper("Wow. Ok. Umm, I think I'll just leave now.", "b")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					term.save()
					if dball_data.ever_been_evil == 0 then
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Yes. But you no can beat Mr. Popo. Go away.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("I would like to try.\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Ok. You try. Then go away.\n\n")
					else
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Mr. Popo not make rules. Mr. Popo not make deals. Kami say only pure of heart. Only Kami change rules.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("Well, then you can't say for sure that Kami won't agree to see me if I can defeat you, right?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("That true. Mr. Popo not know for sure.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("So you don't mind if I try, then?\n\n")
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("Mr. Popo not mind.\n\n")
					end
					dialogue.conclude()
					term.load()
					dball_data.popo_state = 2
				elseif ans == "b" then
					dball_data.popo_state = 1
				end
			elseif ans == "c" then
				term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
				term.text_out("You are polite. But you still no belong here. Mr. Popo be polite too. Go away...please.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.popo_state = 1
			elseif ans == "d" then
				term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
				term.text_out("Mr. Popo not know who you are, but you not very bright. Go away.\n\n")
				dball_data.popo_state = 999
				dball.chalign(-100)
				dialogue.conclude()
				term.load()
			end

			
		elseif dball_data.piccolo_state == 1 then
			dball_data.popo_state = 4 -- Free access 
			term.save()
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("I am Mr. Popo. I know you. You are foolish human release Demon King Piccolo. This very bad thing. If up to me I punish you. But not up to me. Up to Kami.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Hey! How was I supposed to know there'd be a demon in there? Anyway, Kami has tasked me with hunting Piccolo down and killing him, so give me some time and I'll make everything right again.\n\n")
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("No. Must not kill Piccolo. Is bad.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Maybe, but what's going to happen to the world if he's not stopped? I'm sure that won't be good either.\n\n")
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out(player_name() .. " not understand. Mr. Popo not mean 'killing is wrong.' Is true, but killing Piccolo even more bad.")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Why is that?\n\n")
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Mr. Popo say to much. " .. player_name() .. " not kill Piccolo. " .. player_name() .. " must find other way.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You're joking, right?\n\n")
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Mr. Popo not joke. Kill Piccolo make bad thing happen.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Great. As if things weren't already difficult enough.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("So do you at least have any helpful advice?\n\n")
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Yes. No get killed.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Uhh...yeah. I'll do my best. Look, Kami asked me to do something. Can't you help me in some way?\n\n")
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Yes. Mr. Popo help.\n\n")
			dialogue.conclude()
			term.load()
		elseif dball_data.piccolo_state == 2 then
			term.save()
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("I am a very sad Mr. Popo. I serve Kami but now Kami dead. Kami die when Demon King Piccolo die. I very sad.\n\n")
			dialogue.helper("Yes, it is sad. But it was necessary.", "a")
			dialogue.helper("Uhh...what? Kami died?", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
			elseif ans == "b" then
				term.save()
				term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
				term.text_out("Yes, Kami die. Kami-sama and Piccolo are of same. Connected in spirit. When one die so do other. Earth have no Kami no. Only have Mr. Popo. Not good.\n\n")
				dialogue.helper("Huh. Well, that's too bad.", "a")
				dialogue.helper("Thats no problem. I'll just bring Kami back to life using the Dragonballs.", "b")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
				elseif ans == "b" then
					term.save()
					term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
					term.text_out("No. Kami create Dragonballs. No Kami mean no Dragonballs. Dragonballs useless stone with no Kami. Very sad is Mr. Popo.\n\n")
					if dball_data.namek_know_db ~= 0 then
						term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
						term.text_out("No, not the Earth Dragonballs. The NAMEK Dragonballs, made by the Great Elder of Namek.\n\n")
					end
				end
			end
			dialogue.conclude()
			
		end
	elseif dball_data.popo_state == 1 then
		-- Contact, but no fight yet
		term.save()
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out(player_name() .. " come back?\n\n")
		dialogue.helper("Don't mind me. I'm just here to enjoy the garden.", "a")
		dialogue.helper("I would like to challenge you to a duel.", "b")
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Mr. Popo not mind.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Ok. Mr. Popo accept. Fight when you ready.\n\n")
			dialogue.conclude()
			term.load()
			dialogue.POPO_DUEL_ON()
		end
	elseif dball_data.popo_state == 2 then
		-- Start Fight. No training yet.
		term.save()
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out(player_name() .. " not defeat Mr. Popo.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.popo_state == 3 then
		-- Fight has commenced, but player has not made progress
		-- Is allowed to train
		term.save()

		if dball_data.popo_fight_now == 0 then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Hello " .. player_name() .. ".\n\n")
			dialogue.helper("Hello. I'm just visiting the garden. Don't mind me.", "a")
			dialogue.helper("You are very strong. Will you help me to become stronger also?", "b")
			dialogue.helper("I am ready to defeat you to earn my way to Kami.", "c")
		else
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Done already?\n\n")
			dialogue.helper("No. But, maybe a little rest...just for a while...", "a")
			dialogue.helper("No! I won't give up. But I must become stronger first if I'm to win.", "b")
		end
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Mr Popo not mind.\n\n")
			dialogue.conclude()
			term.load()
			dialogue.POPO_DUEL_OFF()
		elseif ans == "b" then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Mr Popo help you.\n\n")
			dialogue.conclude()
			term.load()
			dball.enroll(FLAG_ENROLL_POPO)
		elseif ans == "c" then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Mr Popo not believe you. But Mr Popo appreciate diligence.\n\n")
			dialogue.conclude()
			term.load()
			dialogue.POPO_DUEL_ON()
		end
	elseif dball_data.popo_state == 4 then
		-- Allow full access and Kami
		term.save()
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out("Hello " .. player_name() .. ".\n\n")
		dialogue.helper("Hello, Mr. Popo. Nice to see you again.", "a")
		dialogue.helper("Would you train with me?", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
			term.text_out("Nice see you too " .. player_name())
		elseif ans == "b" then
			dball.enroll(FLAG_ENROLL_POPO)
		end
	elseif dball_data.popo_state == 999 then
		-- Genuinely aggressive
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out("You are bad. You go away.")
	end
end

function dialogue.POPO_INJURED()
	term.save()
	term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
	term.text_out("Mr. Popo feel that. Maybe Mr. Popo underestimate you.\n\n")
	dialogue.conclude()
	term.load()
	dball_data.popo_state = 3
end

function dialogue.POPO_DUEL_OVER()
	term.save()
	term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
	term.text_out("Mr. Popo lose.\n\n")
	if dball_data.karin_kami == 0 then
		-- SURPRISE! The Pure of Heart requirement only applies if you KNOW about it...
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Woohoo! I did it!\n\n")
		term.text_out(color.YELLOW, "A voice echoes out: ")
		term.text_out("Yes, warrior. You have defeated my guardian. You have earned an audience with me. Please, come inside.\n\n")
		local c_ptr = cave(12, 58)
		c_ptr.info = 3
		flag_empty(c_ptr.flags)
		cave_set_feat(12, 58, FEAT_MORE)
	elseif dball_data.ever_been_evil == 1 then
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Woohoo! I did it! So I get to see Kami now?\n\n")
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out("No. You not pure of heart. Only pure of heart can speak Kami.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You can't be serious. Do you have any idea how difficult you were to beat? Don't I deserve something for this?\n\n")
		term.text_out(color.LIGHT_GREEN, "Mr. Popo: ")
		term.text_out("Mr. Popo not make rules. Only Kami make rules. Only pure of heart see Kami.\n\n")
	else
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Woohoo! I did it! So I get to see Kami now?\n\n")
		term.text_out(color.YELLOW, "A voice echoes out: ")
		term.text_out("Yes. You have proven yourself. I will speak with you. Please, come inside.\n\n")
		local c_ptr = cave(12, 58)
		c_ptr.info = 3
		flag_empty(c_ptr.flags)
		cave_set_feat(12, 58, FEAT_MORE)
	end
	dialogue.conclude()
	term.load()
	dball_data.popo_state = 4
end

-- Change Mr. Popo's faction
function dialogue.POPO_DUEL_ON()
	-- if wizard then message("Duel on") end
	dueling = 1 -- No party members!
	dball_data.popo_fight_now = 1
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == RACE_MR_POPO then
			monst.faction = FACTION_DUEL
			monst.flags[FLAG_KILLED_VERB] = "defeated"
			monst.hp = monst.maxhp -- Hack, but should do what is intended
		end
	end)
end
function dialogue.POPO_DUEL_OFF()
	dball_data.popo_fight_now = 0
	dueling = 0 -- Restore party
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == RACE_MR_POPO then
			monst.faction = FACTION_DUEL
			monst.flags[FLAG_KILLED_VERB] = "defeated"
			monst.hp = monst.maxhp -- Hack, but should do what is intended
		end
	end)
	if dball_data.popo_state == 2 then
		dball_data.popo_state = 1
	end
	if dball_data.popo_injured == 1 then
		-- If time based regeneration heals Mr Popo
		-- continue fight even though healed,
		-- but remmeber that we've been injured
		-- at least once
		dball_data.popo_injured = 2
	end
	-- if wizard then message("Duel off") end
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == RACE_MR_POPO then
			monst.faction = FACTION_KAMI
			monst.flags[FLAG_KILLED_VERB] = "killed"
		end
	end)
end

function dialogue.KAIO()
	-- dball_data.kaio_state
	-- 0=no contact
	-- 1=pending joke
	-- 2=in training
	-- 3=pending Bubbles
	-- 4=training again
	-- 5=pending Gregory
	-- 6=training again

	-- Used uniqeuly by each kaio_state!
	local fall_through = 0

	if dball_data.kaio_state == 0 then
		dball_data.kaio_state = 1
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Well, hello! \n\n")
		if quest(QUEST_KAMI_TO_KAIO).status == QUEST_STATUS_TAKEN then
			dialogue.helper("Greetings. I have been sent by Kami to train with you.", "a")
		else
			dialogue.helper("Hello. I am here to train with you.", "a")
		end
		dialogue.helper("Who are you? What is this place?", "b")
		if dball_data.karin_kaio_chess == 1 then
			dialogue.helper("Hello. Nice to meet you. Karin says 'hi.' ", "c")
		end
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("You want to train? I'm sorry, I don't have any trains. You'll have to try somewhere else.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...umm, no. I meant...\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hahahah!!! It's a joke! Get it?!?!? :)\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...umm. Yeah. 'Train.'\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hmph. You don't have much of a sense of humor, do you?\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Well, I absolutely refuse to train anyone without a good sense of humor. So if you want to train with me, you'll have to make me laugh first.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...what? Are you serious? I kind of went to a lot of trouble to come here.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Absolutely! Now, tell me a joke. Make it a good one!\n\n")
			dialogue.KAIO_JOKE_CHECK()

		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("I'm Overseer of the Northern quadrant of this galaxy. No need to stand on ceremony, though. I don't bite. Call me 'Kai.'\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Nice to meet you, Kai. I'm " .. player_name() .. ".\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("It's a little strange to have a guest who doesn't already know about me. I'm guessing you're an adventurer?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Ahhh...well, that explains it, then. Usually people who come here are here to train. \n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Train? You're a trainer?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Me? No, I'm a Kaio. Hahahahah!!! Get it? Trainer? Kaio?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...umm...huh?\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hmph. You don't have much of a sense of humor, do you?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("...uhh, I'm sorry. Did you tell a joke? I guess I...missed it.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Wow. No sense of humor whatsoever. Well, that's not so good. Because I have a steadfast rule: I don't train anyone unless they can make me laugh.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Make you laugh?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Yep! So, know any good jokes?\n\n")
			dialogue.KAIO_JOKE_CHECK()

		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Oh! You're a friend of Karin's?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes. I've trained with him. He said I should visit you sometime. Maybe challenge you to a game of chess.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("...chess?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes. He said you're quite fond of the game.\n\n")
			term.text_out("The Kaio stares at you in shock...then his antennae twitch and a smile starts to creep across his face.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hahahahahhahahaha!!! Chess! Me? Hahahahah!!!! Oh, I love it! That's the best joke I've heard in weeks! Oh...you really have to hand it to Karin, he's really the funniest cat I've ever met!\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You don't play chess?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hahahahahhahahaha!!! No, of course not! It would be painfully easy, being a telepath, and all. I'd always know what my opponent was planning. It's bad enough knowing how to read moves when fighting, but I can only imagine how it would be in chess.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Huh. Yeah, I guess that makes sense. Say, you're a fighter then, right? Would you teach me?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Sure! Anyone with a sense of humor like yours really deserves my training.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("That's terrific! Thank you! When can we start?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("How about right now?\n\n")
			dialogue.conclude()
			term.load()
			trainer[FLAG_ENROLL_NORTH_KAIO] = 1
			dball_data.kaio_state = 2
			fall_through = 999
		end


	elseif dball_data.kaio_state == 1 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Well? Do you have a good joke for me yet?\n\n")
		dialogue.KAIO_JOKE_CHECK()
	elseif dball_data.kaio_state == 2 then
		-- In training
		term.save()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Hello, " .. player_name() .. "! What brings you back to my world?\n\n")
		dialogue.helper("Just visiting.", "a")
		dialogue.helper("I'd like to train with you more, Kaio-sama!", "b")
		if enrollments[FLAG_ENROLL_NORTH_KAIO] > 9 then
			dialogue.helper("Kaio-sama, I appreciate the training you've given me. Is there anything we can do to step up the level a bit?", "c")
		end

		-- Implement ask for telepathy (pending cellphone code)
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			fall_through = 999
		elseif ans == "c" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("There's certainly more I could teach you, but I'm afraid you're being limited by the low gravity you're used to on earth. Your phsyical body has to channel your chi, and your body isn't strong enough to progress past the next level.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("So what can we do?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("All you can do is strengthen your body. Me and Bubbles are used to the gravity here. It's time for you to get used to it, too.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Bubbles?\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("My pet monkey. Go ahead. Run around, and try to catch him. I think by the time you're able to you'll be accustumed to the gravity well enough that I can train you more.\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_KAIO_BUBBLES, QUEST_STATUS_TAKEN)
			dball_data.kaio_state = 3
		end

	elseif dball_data.kaio_state == 3 then
		if quest(QUEST_KAIO_BUBBLES).status == QUEST_STATUS_COMPLETED then
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Ahh! You caught Bubbles! Very good. Let's see how much farther you can train!\n\n")
			dialogue.conclude()
			term.load()
			dball_data.kaio_state = 4
			trainer[FLAG_ENROLL_NORTH_KAIO] = 2
			fall_through = 999
		else
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hmm. You still haven't been able to catch Bubbles? Well, keep at it.\n\n")
			dialogue.helper("Alright.", "a")
			dialogue.helper("Could we do a little more training first? I know I'll catch Bubbles eventually, but...", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
			elseif ans == "b" then
				fall_through = 999
			end
		end
	elseif dball_data.kaio_state == 4 then
		-- In training
		term.save()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Hello, " .. player_name() .. "! What brings you back to my world?\n\n")
		dialogue.helper("Just visiting.", "a")
		dialogue.helper("I'd like to train with you more, Kaio-sama!", "b")
		if enrollments[FLAG_ENROLL_NORTH_KAIO] > 19 then
			dialogue.helper("Kaio-sama, this is terrific! I've never met a trainer as good as you. But, can we go even farther?", "c")
		end

		-- Implement ask for telepathy (pending cellphone code)
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			fall_through = 999
		elseif ans == "c" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Well, once again, there's certainly more I could teach you, but you're still being limited by your body. The training you did with Bubbles helped considerably, but you were only moving around your own body. Maybe if we put some weights on you...oh! I know.\n\n")
			term.text_out("Gregory!\n\n")
			term.text_out(color.LIGHT_BLUE, "Gregory: ")
			term.text_out("Yes, Kaio-sama?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Whoa! Where did that voice coem from?\n\n")
			term.text_out(color.LIGHT_BLUE, "Gregory: ")
			term.text_out("From me! I'm right here. Up HERE. I'm sitting on your head.\n\n")
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Gregory is in insect. A very strong one, I might add.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Oh. Nice to meet you, Gregory.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			local hammer_weight = dball.kaio_hammer_weight() / 10
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("We'll do a repeat of your last excercise, but this time you'll be chasing Gregory. And to make it more difficult, rather than simply catching him...you'll have to hit him with this hammer. It weighs " .. hammer_weight .. " pounds. That should slow you down, some.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out(hammer_weight .. " pounds?!?! But won't Gregory get hurt?\n\n")
			term.text_out(color.LIGHT_BLUE, "Gregory: ")
			term.text_out("Ha! Not on your life. But it's not like you're ever going to catch me anyway. I'm too fast for you.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Really? Well, we'll see about that!\n\n")
			dialogue.conclude()
			term.load()
			local obj = create_artifact(ART_KAIO_HAMMER)
			make_item_fully_identified(obj)
			dball.reward(obj)
			dball.place_monster(36, 107, "Gregory")
			change_quest_status(QUEST_KAIO_GREGORY, QUEST_STATUS_TAKEN)
			dball_data.kaio_state = 5
		end
	elseif dball_data.kaio_state == 5 then
		if quest(QUEST_KAIO_GREGORY).status == QUEST_STATUS_COMPLETED then
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Ahh! You caught Gregory! Very good. Let's see how much farther you can train!\n\n")
			dialogue.conclude()
			term.load()
			dball_data.kaio_state = 4
			trainer[FLAG_ENROLL_NORTH_KAIO] = 3
			fall_through = 999
		else
			term.save()
			term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
			term.text_out("Hmm. You still haven't been able to catch Gregory? Well, keep at it.\n\n")
			dialogue.helper("Alright.", "a")
			dialogue.helper("Could we do a little more training first? I know I'll catch Gregory eventually, but...", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
			elseif ans == "b" then
				fall_through = 999
			end
		end
	elseif dball_data.kaio_state == 999 then
	end

	-- And, the actual trainer script
	if fall_through == 999 then
		dball.enroll(FLAG_ENROLL_NORTH_KAIO)
		if quest(QUEST_KAMI_TO_KAIO).status == QUEST_STATUS_TAKEN then
			change_quest_status(QUEST_KAMI_TO_KAIO, QUEST_STATUS_FINISHED)
		end
	end
end

function dialogue.KAIO_JOKE_CHECK()
	local first, second
	dialogue.helper("I don't know any jokes.", "a")
	for i = 0, dball_data.joke_total do
		if jokes[i] == 1 then
		first, second = dball.joke_text(i)
		dialogue.helper(first, strchar(i + 64 + 1)) end
	end
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
		term.save()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Well, I won't train you until you make me laugh.\n\n")
		dialogue.conclude()
		term.load()
		if quest(QUEST_KAIO_LAUGH).status == QUEST_STATUS_UNTAKEN then
			change_quest_status(QUEST_KAIO_LAUGH, QUEST_STATUS_TAKEN)
		end
	elseif ans == strchar(dball_data.joke_answer) then
		-- Got it right: Kaio-sama liked the joke
		first, second = dball.joke_text(i)
		term.save()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("I don't know.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out(second .. "\n\n")
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Pffff...hmm....hehe....hahaahaha!!! That's hilarious! Hahahaha!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Heh. I'm glad you liked it. So, you'll train me now?\n\n")
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Absolutely!\n\n")
		dialogue.conclude()
		term.load()
		dball_data.kaio_state = 2
		dball.enroll(FLAG_ENROLL_NORTH_KAIO)
		if quest(QUEST_KAMI_TO_KAIO).status == QUEST_STATUS_TAKEN then
			change_quest_status(QUEST_KAMI_TO_KAIO, QUEST_STATUS_FINISHED)
		end
	else
		-- Didn't like the joke
		first, second = dball.joke_text(i)
		term.save()
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("I don't know.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out(second .. "\n\n")
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Pffff...hmm....that's not really very funny.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...yeah, I guess you're right. Still, it was worth a try.\n\n")
		term.text_out(color.LIGHT_BLUE, "The North Kaio: ")
		term.text_out("Well, I appreciate the attempt, but you'll just have to do better.\n\n")
		dialogue.conclude()
		term.load()
	end
end

function dialogue.RADDITZ_EARTH()
	-- This allows the various Freeza minions to participate in the WT
	dball_data.have_we_met_radditz = 1

	term.save()
	dialogue.prep()
	term.text_out(color.YELLOW, "NOTE: This dialogue is functional, but if you go with Radditz or annoy him he will take you to a place that is NOT implemented, and it's pretty much a dead end path. You have been warned.\n\n")
	term.text_out(color.LIGHT_RED, "Radditz: ")
	term.text_out("Have you no shame, " .. dball.get_saiyan_name() .. "? That was absolutely the most pathetic display of worthlessness I've seen in all the centuries I've lived! I don't understand what you're doing wasting your time with these humans and their ridiculous game to begin with, but if you're going to play along, why put up such a self-deprecating display?\n\n")
	dialogue.helper("Hey, I did my best!", "a")
	dialogue.helper("Umm...excuse me? What are you talking about?", "b")
	dialogue.helper("It's, umm...all part of my master plan. And who are you, exactly?", "c")
	local ans = dialogue.answer()
	if ans == "a" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_RED, "Radditz: ")
		term.text_out("You're joking, right? Come now, " .. dball.get_saiyan_name() .. ", you have more power in your pinkie finger than all of those buffoons combined. Of course, from listening to you talk, they might have more brains in their fingers than you have in your head.\n\n")
		dialogue.helper("I don't understand. I fought to win. What power are you talking about? ", "a")
		dialogue.helper("Alright, that does it. One more nasty comment from you and I'm mopping up the pavement with you.", "b")
	elseif ans == "b" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_RED, "Radditz: ")
		term.text_out("I'm talking about YOU! What game are you playing here, " .. dball.get_saiyan_name() .. "? Why are you wasting your time playing with children, and for that matter, why are they any children here for you to play with? It's been years! Freeza sent me to see why you had not returned from your mission yet. We assumed you had been killed, difficult as that was to believe given how utterly physically and technologically pathetic our preliminary reports showed the natives of this world to be: almost as pathetic as your display in that ridiculous tournament.\n\n")
		dialogue.helper("Freeza? What mission?", "a")
		dialogue.helper("I think I've had enough of your insults. Take a hike while you can still walk.", "b")
	elseif ans == "c" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_RED, "Radditz: ")
		term.text_out("Who am I...? Has it been so long that you don't recognize me? I'm your crib-mate! Radditz! Who are you, " .. dball.get_saiyan_name() .. ", that you don't even recognize your own brother!  Have you become not only weak and pathetic, but stupid as well?\n\n")
		dialogue.helper("You're my brother? Since when?", "a")
		dialogue.helper("I don't like your tone. I think you'd best apologize. Now.", "b")
	end

	-- Fall through. All dialogue up to this point is cosmetic

	local ans = dialogue.answer()

	if ans == "a" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_RED, "Radditz: ")
		term.text_out("You really don't remember, do you? How very interesting. I wonder what it is these humans have done to you,  " .. dball.get_saiyan_name() .. ", but I have neither the time nor inclination to stay here to find out. My orders are to return with you to planet 79 and then resume preparations for the extermination of all sentient life on this planet. Come, let us leave this wretched planet.\n\n")
		dialogue.helper("Alright.", "a")
		dialogue.helper("No, I don't think so.", "b")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			message(color.YELLOW, "Radditz takes you to a spacecraft hidden in the woods...")
			player.wilderness_y = 16
			player.wilderness_x = 44
			player.leaving = true
			return
		elseif ans == "b" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_RED, "Radditz: ")
			term.text_out("I wasn't *asking* you, " .. dball.get_saiyan_name() .. ", but if you truly wish to stay and die with these humans it is no concern of mine. I would be glad to be rid of you. Still...we are of the same kind, and only a few of us remain. I think it would be best if you came with me.\n\n")
			dialogue.helper("I will go with you.", "a")
			dialogue.helper("No, I shall remain here.", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				player.wilderness_y = 34
				player.wilderness_x = 98
				player.leaving      = true
				return
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_RED, "Radditz: ")
				term.text_out("So be it, " .. dball.get_saiyan_name() .. ". I cannot say I will miss you, but it does sadden my heart to see our numbers diminish even further.\n\n")
				term.text_out("Radditz sighs, shrugs, and then speaks softly into a small device on his wrist...then vanishes!\n\n")
				dball.delete_monster(RACE_RADDITZ)
				dialogue.conclude()
				term.load()
				acquire_quest(QUEST_IMPENDING_DOOM)
				return
			end
		end
	elseif ans == "b" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_RED, "Radditz: ")
		term.text_out("Hahahaha! You are pathetic, but at least you are funny! I don't know what has happened to you, " .. dball.get_saiyan_name() .. " but I have orders to bring you home if you're alive. Pity, though. I never really liked you.\n\n")
		term.text_out("(Radditz takes a step away from you, and a strange glow begins to emit from his hands...)\n\n")
		dialogue.conclude()
		term.load()
		-- fire_cloud(dam.PLITE, player.py -1, player.px, 5, 3, player.speed()) --Speed? What's that for?
		dball.devastate(player.py, player.px, 7)
		term.save()
		term.text_out(color.YELLOW, "Radditz fires a burst of energy from his fingertips!")
		dialogue.conclude()
		term.load()
		
		player.wilderness_y = 34
		player.wilderness_x = 98
		player.leaving = true
		term.save()
		term.text_out("(You feel weak, and you barely maintain consciousness. Your memory of subsequent events are fuzzy at best, but you vaguelly recall being dragged out of the wreckage of the World Tournament building, being strapped into a seat...sensations of motion...and then everything goes black for a long time.)\n\n")
		dialogue.conclude()
		term.load()
	end
end

function dialogue.OOLONG()
	if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Oolong, the thoughtful: ")
		term.text_out("Hello again, " .. player_name() .. "! It's so nice to see you again. Tell me...have you had any success finding, well...you know?\n\n")
		dialogue.helper("No, sorry. Not yet.", "a")
		if dball_data.married == 0 and player.get_sex() == "Female" and dball.persuade(16) then
			dialogue.helper("(Persuade 16) I've tried to find another girl for you...but I just can't se you with anyone...other than me.", "b")
		end
		if party.qty_partied(RACE_LUNCH) > 0 then
			dialogue.helper("Yes, I've found a girl who is charming and kind, and...no, actually she's more the exotic party type. Well, actually...she's kind of both. Just not at the same time. You'll like her. Really.", "c")
		end
		if party.qty_partied(RACE_VIDEL) > 0 then
			dialogue.helper("(Videl not implemented)", "d")
		end
		if party.qty_partied(RACE_CHICHI) > 0 then
			dialogue.helper("Chichi not implemented)", "e")
		end
		if party.qty_partied(RACE_BURUMA) > 0 then
			dialogue.helper("Yes, I've found a lovely girl desperately looking for a boyfriend. And, she's rich, so you can be sure she's not here for your money.", "f")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Oolong, the sad: ")
			term.text_out("I understand. Please keep looking.")
		elseif ans == "b" then -- Player
			term.save()
			term.text_out(color.LIGHT_BLUE, "Oolong, the sad: ")
			term.text_out("...really? I thought you said you were involved with someone.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I'm sorry. I lied. It's, well...I'm a human. And you're a pig. I wasn't comfortable with that at first. But, I've thought about it, and I really think I could live with it. I just needed time. Do you understand?\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the sad: ")
			term.text_out("...I think so.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("And you've given me that time. And I'm grateful. And now I'd really like to marry you. If you'll have me. Oolong...will you marry me?\n\n")
			dialogue.conclude()
			term.load()
			dialogue.OOLONG_MARRY_PLAYER()
		elseif ans == "c" then -- Lunch
			if dball_data.lunch_sneeze == 0 then
				-- Nice Lunch
				term.save()
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Oolong, let me introduce you to Lunch. Lunch, meet Oolong.\n\n")
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("Oh, my! What a darling little pig! Hello, Oolong!\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Wow, you're really nice.\n\n")
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("Oh, thank you! You're the sweetest little pig I've ever met! Do you have a kitchen? How about I bake us some yummy brownies?\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Yes, ma'am! It's right around the corner.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Wow, " .. player_name() .. "! I've never met a kinder, more charming woman!\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("...uhh...well...\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("I can't believe it! It's like she's too good to be true!\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Hmm. You know, Oolong, there's really something you should know...\n\n")
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("Oh! You have a little puggy tail! That's so precious! I've never seen anything so adorable!\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("I think I'm in love.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Thank you so much for introducing us, " ..player_name() .. ". I'm completely grateful. Never in my life did I dream of meeting such a girl...as beautiful on the inside as she is on the outside.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yeah...speaking of her inside beauty...\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Here, let me give you a reward. 100,000 zeni.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Wow. Thank you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("My pleasure! Now, what was it you were about to tell me?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Umm...I guess it wasn't that important. I'll just leave the two of you to get to know one another better. A lot better. Bye now.\n\n")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_OOLONG_LONELY, QUEST_STATUS_FINISHED)
				player.au = player.au + 100000
				player.redraw[FLAG_PR_BASIC] = true
				-- Some old stuff in here...retaining compatibility
				dball_data.oolong_resolution = 3
				dball_data.oolong_married = RACE_LUNCH
				party.unparty(RACE_LUNCH)
			else
				-- Mean Lunch
				term.text_out(color.LIGHT_RED, "Lunch: ")
				term.text_out("Who are ya callin' kind?!?! Come here an' I'll show you just what kind I am!\n\n")
			end
			
		elseif ans == "d" then -- Videl
		elseif ans == "e" then -- Chichi
		elseif ans == "f" then -- Buruma
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Oolong, let me introduce you to Buruma. Buruma, meet Oolong.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Excuse me?!?!?! What are you talking about?!!?\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
			term.text_out("Wow! What big boobs you have!\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Arrgghhh! Get back you filfthy pig!\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
			term.text_out("Well, there's no need to be rude.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Says the dirty minded little pig staring at my chest!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("He just likes you, Buruma. What's the problem? You were hunting for the dragonballs to find a boyfriend, right? I've saved you all the trouble. You should be grateful.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
			term.text_out("I certainly am!\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Get back! This isn't what I wanted! I'm leaving!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wait, Buruma...hear me out. What if you do walk out that door like you're planning? What if you leave now, and go and find the dragonballs? And what if, through a weird set of unforseen circumstances you end up comforting some moody alien and get pregnant?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("What? That would never happen!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("But what if it did? And what if that alien were a selfish monster who never really loved you? How would you feel? What if he cared nothing for all of humanity, least of all you? What if he killed people at random just for the thrill of it? What would that be like?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("That would be horrible!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You're right. It would be. And right now you have an opportunity to insure that none of that ever happens. By staying here, and marrying this nice little pig who might grow to love you.\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
			term.text_out("I already love your boobs.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("...\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Stay here, Buruma. Marry the pig.\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
			term.text_out("Yeah! Marry the pig!\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("...I...I...don't know...\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("What if the alien were named after vegetables?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Ok. I'll marry the pig.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "(A few weeks later)\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the husband: ")
			term.text_out("Wow! That was a terrific honey moon! " .. player_name() .. ", I'd really like to thank you for setting me up with Buruma. We don't always see eye to eye on everything...\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("How can we? You're three feet tall!\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the husband: ")
			term.text_out("...And sometimes she's maybe a little bit mean...\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("You better talk nice about me, mister. You don't know the half of it!\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the husband: ")
			term.text_out("...but this is the first time I've ever been with anyone who didn't want me for my money.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Or any other reason, for that matter.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Oolong, the husband: ")
			term.text_out("I'd like to thank you. Please accept this gift.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Don't you go giving away our money! We might need that for a rainy day!\n\n")
			term.text_out(color.LIGHT_BLUE, "Oolong, the husband: ")
			term.text_out("It's only 100,000 zeni, but as an adventurer I'm sure you'll be able to put it to good use.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Thank you.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("*sigh*\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_OOLONG_LONELY, QUEST_STATUS_FINISHED)
			player.au = player.au + 100000
			player.redraw[FLAG_PR_BASIC] = true
			-- Some old stuff in here...retaining compatibility
			dball_data.oolong_resolution = 3
			dball_data.oolong_married = RACE_BURUMA
			party.unparty(RACE_BURUMA)
		end
		return
	elseif dball_data.oolong_sad_done == 1 then
		term.text_out(color.LIGHT_BLUE, "Oolong, the troubled: ")
		term.text_out("Please go. <sniff> I want to be alone right now. <pout>")
		return
	elseif dball_data.oolong_sad_done == 2 then
		term.text_out(color.LIGHT_BLUE, "Oolong, the troubled: ")
		term.text_out("What do you want from me now? Go away!")
		return
	elseif dball_data.oolong_sad_done == 3 then
		term.text_out(color.LIGHT_BLUE, "Oolong, the terrible: ")
		term.text_out("Go away!")
		return
	elseif dball_data.oolong_resolution == 1 then
		term.text_out(color.LIGHT_BLUE, "Oolong, the terrible: ")
		term.text_out("The village girls have returned home, I trust?")
		return
	elseif dball_data.married == FLAG_MARRIED_OOLONG then
		monster_random_say
			{
			"Oolong kisses you tenderly.",
			"Oolong says 'Hello, my beloved.'",
			"Oolong smiles happily at you.",
			"Oolong wonders aloud if maybe you'd like to go to bed early tonight.",
			}
		return
	end

	term.save()
	dialogue.prep()
	term.text_out("(Oolong jumps when he notices you...quickly wipes up his tears and tries to be intimidating)\n\n")
	term.text_out(color.LIGHT_BLUE, "Oolong, the terrible: ")
	term.text_out("Foolish human! How dare you interupt the...umm...private thoughts of Oolong the TERRIBLE! Why, I should cast you into the pit with my very big, very mean, and very hungry 9-headed hydra just for being here! Didn't anyone ever teach you that it's polite to knock?\n\n")
	dialogue.helper("Oh, forgive me...oh...Oolong.", "a")
--	if dball_data.oolong_quest_helper > 0 then
--		dialogue.helper("I've spoken with the girls in your castle. Kind of sounds like they're taking advantage of you.", "b")
--	end	
	if cave(3,23).feat == FEAT_OPEN then
		dialogue.helper("What hydra? I saw the sign, but there's nothing in there.", "c")
	end
	if player.get_sex() == "Female" then
		dialogue.helper("You're kind of cute. Are you seeing anybody?", "d")
	end
	if quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
		dialogue.helper("The villagers of Aru sent me to kill you. They say you've been stealing their women.", "e")
	end	
	dialogue.helper("Die, pig! (attack)", "f")
	local ans = dialogue.answer()
	if ans == "a" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Oolong, the terrible: ")
		term.text_out("Yes, very well. I forgive you. But please knock next time. Now go away before I - wait...you look like an adventurer.\n\n")
		dialogue.helper("Yes, I am.", "a")
		dialogue.helper("Yes, I'm here to kill you. Die, pig! (attack)", "b")
		dialogue.helper("No, sorry...I'm actually just lost, and was looking for directions. Could you tell me how to get to...umm...to the World Tournament? Yes, the World Tournament. I came to see the World Tournament, but...umm...couldn't find it.", "c")
		local ans = dialogue.answer()
		if ans == "a" then
			if dball_data.oolong_quest_helper == 0 then
				dball_data.oolong_quest_helper = 1
			end
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Oolong, the tentative: ")
			term.text_out("Say...maybe you could help me out, then? It's those Aru village women. Ever since they found out I was rich, they keep coming to my castle in droves! Day in, day out, they're all constantly trying to badger me into marrying them. I can't have guests over, they're eating me out of my fortune, and I can't help but think that any genuinely nice girl who saw them would completely get the wrong idea and be scared off! What's a pig to do?\n\n")
			dialogue.helper("Why don't you just tell them to leave?", "a")
			dialogue.helper("Ok. So what do you want me to do about it?", "b")
			local ans = dialogue.answer()
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Oolong, the trying: ")
			if ans == "a" then
				term.text_out("You think I haven't tried! I tell them to leave all the time! They just laugh at me! I even tried to sic Snuggles, my hydra, on them, but they just scratch him behind his ears and give him hydra treats and he loves them all to death. Well...not to death, that would have solved the problem. ")
			end
			term.text_out("The way I see it, they're all hoping to ensnare me into marrying them, and the only thing that's going to convince them to go away is for me to get married! But I'm not just going to marry anyone. She has to be kind, and sweet, and loving. So that's what I want you to do. I want you to find a girl who's kind, and sweet, and loving...and ask her to marry me.\n\n")
			dialogue.helper("Ok. I'll see what I can do.", "a")
			dialogue.helper("No, I don't think I want to get involved with this one. You're on your own, little pig.", "b")
			dialogue.helper("No, I think I'm just going to kill you. It will solve your problem, and it'll be a lot faster for me. (attack)", "c")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Wow! Really? Thank you! Thank you so much! \n\n")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_OOLONG_LONELY, QUEST_STATUS_TAKEN)
			elseif ans == "b" then
				term.load()
				term.text_out(color.LIGHT_BLUE, "Oolong, the troubled: ")
				term.text_out("I see. Well, then I suppose I'll get to what I was doing before you came in. If you'll excuse me.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.oolong_sad_done = 2
			elseif ans == "c" then
				term.load()
				dialogue.OOLONG_ATTACK_HELPER()
			end
		elseif ans == "b" then
			term.load()
			dialogue.OOLONG_ATTACK_HELPER()
		elseif ans == "c" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Oolong, the terrible: ")
			term.text_out("Oh. Yes. Quite alright. If you head directly southeast from my castle, you'll pass a most ridiculous village by the name of Aru. I'd avoid it if I were you, but south of Aru you'll find a road. Follow it south, then east, and you'll reach a rather large city. The World Tournament building is directly north of Akira's sushi bar. ")
			if dball_data.akira_state == 0 then
				term.text_out("Say hello to Akira for me when you pass through. He's a friendly chap. ")
				dball_data.oolong_akira = 1
			end
			term.text_out("Now, if you'll excuse me, I'd really like to be left alone.\n\n")
			dialogue.conclude()
			dball_data.oolong_sad_done = 2
			term.load()
		end
	elseif ans == "b" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out("(Oolong's bottom lip starts to quiver, and then all at once he bursts into uncontrollable tears.)\n\n")
		term.text_out(color.LIGHT_BLUE, "Oolong, the troubled: ")
		term.text_out("...yes. I just don't know what to do! Implement dialogue branch\n\n")
		dialogue.conclude()
		term.load()
	elseif ans == "c" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Oolong, the terrible: ")
		term.text_out("Oh. Umm. It...he...must be outside...grazing. Yes. Grazing. He likes to have a well balanced meal. He's very health conscious, you see. Adventurers are high in protein, but they're rather lacking in fiber, so he...grazes. Yes. Grazes.\n\n")
		term.text_out("(You notice that Oolong is slowly edging away, and looks like he's about to run.)\n\n")
		dialogue.helper("No hydra, huh? Ok. Time to die, little pig. (attack)", "a")
		if quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
			dialogue.helper("Look, there's no need for theatrics. I'm here to rescue the Aru village women you've kidnapped. Let them go, and you can live.", "b")
		end	
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			dialogue.OOLONG_ATTACK_HELPER()
		elseif ans == "b" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Oolong, the terrified: ")
			term.text_out("Really? You promise? You'll let me go if I let the women go back to their village?\n\n")
			dialogue.helper("Yes.", "a")
			dialogue.helper("No, I'll probably kill you anyway.", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Oolong, the tiny: ")
				term.text_out("Alright. I'll tell all the village women to return home.\n\n")
				dialogue.conclude()
				term.load()
				if quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
					quest(QUEST_OOLONG).status = QUEST_STATUS_COMPLETED
				end
				dball_data.oolong_resolution = 1 -- peaceful
			elseif ans == "b" then
				term.load()
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Oolong, the terrified: ")
				term.text_out("Waaaahhhhh! I wanna live! Help! Help! He- oh...hello, Snuggles. Back from grazing?\n\n")
				term.text_out(color.LIGHT_RED, "Snuggles: ")
				term.text_out("Growwwrrr...*munch* *munch* Grawrrw rawwwrrr?\n\n")
				term.text_out(color.LIGHT_BLUE, "Oolong, the thrilled: ")
				term.text_out("Yes. Please.\n\n")
				dialogue.conclude()
				term.load()
				local throwaway = place_named_monster(3, 14, "Snuggles, the 9 headed hydra", 0)
				dball_data.oolong_sad_done = 3 -- hostile
			end
		end
	elseif ans == "d" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out("(Oolong sighs)\n\n")
		term.text_out(color.LIGHT_BLUE, "Oolong, the troubled: ")
		term.text_out("Another one? You weren't dressed like a villager, so I was hoping you were an adventurer coming to kill me and put me out of my misery. No such luck for me. Alright, well...see if you can find a spare room with the others.\n\n")
		dialogue.conclude()
		term.load()
		dball_data.oolong_sad_done = 2
	elseif ans == "e" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Oolong, the trepidated: ")
		term.text_out("Oh...umm, that. Well...it's like...umm. You see...I...well...hmm. Yes, I did...well, sort of, anyway. I, umm...DID sort of, well...kidnap one girl...kind of. In a way. Almost. Well...it was really more like 'tried to.' I, umm...sort of didn't get very far. You humans are really tall and big, and I couldn't carry the girl, so it sort of didn't turn out very well.\n\n")
		dialogue.helper("Oh. So you *are* bad. Ok, I'll kill you now. (attack)", "a")
		dialogue.helper("You *tried* to kidnap one girl? And failed? Ok, so how do you explain the half dozen village girls running around your castle?", "b")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			dialogue.OOLONG_ATTACK_HELPER()
		elseif ans == "b" then
			if dball_data.oolong_quest_helper == 0 then
				dball_data.oolong_quest_helper = 1
			end
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Oolong, the timid: ")
			term.text_out("Oh. Them. Well...I'm not sure exactly. I was sort of a nobody at the time, but after the...'incident' word somehow got out that I was the owner of this castle...and, well...kind of really, really wealthy. Sort of. A bit. After that, village girls just started showing up at my portcullis, and...well, I'm a terrible tyrant...not a heartless one, so what could I do? Turn away these poor innocent girls? At least...that's how it seemed at first. After the first five or six, though...I kind of started to wonder if maybe they were taking advantage of me.\n\n")
			dialogue.helper("Hmm. Interesting. Ok, I understand what's going on, but I think I'm going to kill you anway. (attack)", "a")
			dialogue.helper("Wow...you're really pathetic.", "b")
			dialogue.helper("I think you should get rid of them, and find yourself a kind, sweet, loving girl.", "c")
			local ans = dialogue.answer()
			if ans == "a" then
				term.load()
				dialogue.OOLONG_ATTACK_HELPER()
			elseif ans == "b" then
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Oolong, the timid: ")
				term.text_out("I...I know. <sniff> I just...<sniff>...don't know what to do. <pout> I'm sorry. I really need to be alone right now.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.oolong_sad_done = 1
			elseif ans == "c" then
				term.load()
				term.save()
				dialogue.prep()
				if player.get_sex() == "Female" then
					term.text_out(color.LIGHT_BLUE, "Oolong, the tender: ")
					term.text_out("...that has to be the kindest, sweetest, most loving advice anyone has ever given me. Are you...umm...seeing anyone?\n\n")
					dialogue.helper("Umm, yes. Yes I am. Sorry.", "a")
					if dball_data.married == 0 then
						if dball.persuade(15) then
							dialogue.helper("(Persuade 15) No...I'm single...and EXTREMELY available...are you, umm...interested? I...umm...well...(blush)(smile)(blush)", "b")
						end
					end
					local ans = dialogue.answer()
					if ans == "a" then
						term.load()
						term.save()
						term.text_out(color.LIGHT_BLUE, "Oolong, the teary-eyed: ")
						term.text_out("Yes, I'm sorry. I should have guessed. The good ones are always taken. If...if it doesn't work out, well...I would be good to you. I'm sorry, that was rude. I apologize. I guess I'll just have to find myself a sweet, kind and loving girl someplace else. You're right though, I'll send away all the Aru villagers. They're just using me for my money. Thank you for your help. I wish you happiness, truly.\n\n")
						dialogue.conclude()
						term.load()
						change_quest_status(QUEST_OOLONG, QUEST_STATUS_COMPLETED)
						change_quest_status(QUEST_OOLONG_LONELY, QUEST_STATUS_TAKEN)
					elseif ans == "b" then
						dialogue.OOLONG_MARRY_PLAYER()
					end
				else
					term.text_out(color.LIGHT_BLUE, "Oolong, the titillated: ")
					term.text_out("Hmm. You know...that's really good advice. Thank you. You're right. You're absolutely right. I'm not sure where I'll find a kind, sweet and loving girl in this part of the forest...but that's what I'll do. Thank you, so much. I'll send them all away...and, well...umm, if you happen to meet a, well...you know, the 'right' sort of girl. Would you let me know?\n\n")
					dialogue.conclude()
					term.load()
					change_quest_status(QUEST_OOLONG, QUEST_STATUS_COMPLETED)
					change_quest_status(QUEST_OOLONG_LONELY, QUEST_STATUS_TAKEN)
					dball_data.oolong_quest_helper = 3
				end
			end
		end
	elseif ans == "f" then
		term.load()
		dialogue.OOLONG_ATTACK_HELPER()
	end

end

function dialogue.OOLONG_MARRY_PLAYER()
	dball_data.persuades = dball_data.persuades + 1
	term.load()
	term.save()
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "Oolong, the triumphant: ")
	term.text_out("Oh! Dear me, yes!\n\n")
	term.text_out("Oolong cries happy tears and immediately comes and sweeps you off your feet. Or, tries to anyway. Instead he knocks you over and the two of you fall into a ridicuous pile on the ground and come up laughing. It's a precious moment, both sweet and playful, and it sets the two of you off on a delightful, but brief courtship, which leads to the most beautiful wedding any girl marrying a pig could ever ask for. You feel immensely happy.\n\n")
	dialogue.helper("Retire to a beautiful, happy life of love, joy, and raising adorable little baby piglets", "a")
	dialogue.helper("Hold off on children for now.", "b")
	local ans = dialogue.answer()

	quest(QUEST_OOLONG).status = QUEST_STATUS_COMPLETED
	quest(QUEST_OOLONG_LONELY).status = QUEST_STATUS_FINISHED
	dball_data.oolong_quest_helper = 3

	dball_data.married = FLAG_MARRIED_OOLONG
	-- dball_data.winner_state = 1
	
	dball.delete_monster(RACE_WHINY_ARU)
	local obj = create_artifact(ART_RING_OOLONG)
	make_item_fully_identified(obj)
	dball.reward(obj)

	-- What about Snuggles?
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == RACE_OOLONG then
			monst.flags[FLAG_FACTION] = FACTION_PLAYER
			monst.flags[FLAG_NEVER_MOVE] = false
			monst.ai = ai.ZOMBIE
		end
	end)

	factions.set_friendliness(FACTION_PLAYER, FACTION_NEUTRAL, 100)
	factions.set_friendliness(FACTION_NEUTRAL, FACTION_PLAYER, 100)

	if ans == "a" then
		term.load()
		winner_state = WINNER_NORMAL
		has_won = WINNER_NORMAL
		player.redraw[FLAG_PR_TITLE] = true
		message(color.YELLOW, "You live happily ever after. You may retire when ready.")
		local throwaway = place_named_monster(4, 9, "darling little girl", 0)
		local throwaway = place_named_monster(1, 8, "darling little girl", 0)
		local throwaway = place_named_monster(9, 15, "darling little girl", 0)
		local throwaway = place_named_monster(4, 10, "darling little boy", 0)
		local throwaway = place_named_monster(9, 22, "darling little boy", 0)
		local throwaway = place_named_monster(4, 19, "darling little boy", 0)
		cave_set_feat(16, 19, FEAT_RED_CARPET)
	elseif ans == "b" then
		term.load()
	end
end
function dialogue.OOLONG_ATTACK_HELPER()
	dball.neutral_annoy()
	if cave(3,23).feat == FEAT_DOOR then
		term.text_out(color.LIGHT_BLUE, "Oolong, the terrified: ")
		term.text_out("Snuggles! Help!\n\n")
		cave_set_feat(3, 23, FEAT_DOOR_OPEN)
		place_named_monster(3, 24, "Snuggles, the 9 headed hydra", 0)
	else
		term.text_out(color.LIGHT_BLUE, "Oolong, the terrified: ")
		term.text_out("Arrrgghhhh! Help! Help!\n\n")
	end
end

function dialogue.DELIVERY_BOY()
	term.save()
	term.text_out(color.LIGHT_BLUE, "Delivery Boy: ")
	if race_info_idx(RACE_SHREDDER, 0).max_num < 1 then
		term.text_out("Awww, man! This is way not cool. I don't think I want to be a part of this anymore.\n\n")
		dialogue.helper("Follow me. I'll take you back to Akira.", "a")
		dialogue.helper("Sounds like a personal problem to me. Deal with it, punk.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Delivery Boy: ")
			term.text_out("Dude! You serious? Wow, that's so great. Thanks, man! I'll follow you. But let's be careful. There's some dangerous people runnin' around here, you know.\n\n")
			dialogue.conclude()
			term.load()
			party.party(RACE_DELIVERY_BOY)
		elseif ans == "b" then
		end
	else
		term.text_out("Hey, dude. You shouldn't be back here.\n\n")
		dialogue.helper("Oh. Sorry.", "a")
		dialogue.helper("Akira was worried about you. I'm here to take you home.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Delivery Boy: ")
			term.text_out("No way, man! It's way cool here. I'm not goin' anywhere!\n\n")
			dialogue.conclude()
			term.load()
		end
	end
end

function dialogue.AKIRA()
	term.gotoxy(0, 0)
	local fall_through = 0

	if party.is_partied(RACE_DELIVERY_BOY) > 0 then
		dball.delete_monster(RACE_DELIVERY_BOY)
		term.save()
		term.text_out(color.LIGHT_BLUE, "\nAkira: ")
		term.text_out("You found him! How wonderful! I am eternally in your debt. And, I have the perfect reward for you. My father was a famous swordman back in Japan. But, I did not follow in his footsteps. When he died, I inherited all of his weapons and armor. But, I am not a warrior, and I have always believed it more proper for such tools to be in the hands of someone who will use them, than sitting collecting dust on a shelf.")
		local obj = new_object()
		if get_skill(SKILL_WEAPONS) > get_skill(SKILL_HAND) then
			term.text_out("I would like you to have his sword.")
			obj = create_object(TV_SWORDARM, SV_KATANA)
		else
			term.text_out("I would like you to have his armor.")
			obj = create_object(TV_BODY_ARMOUR, SV_SAMURAI_DO)
		end
		term.text_out(" You have proven yourself a more deserving keeper for it than I.\n\n")
		dialogue.conclude()
		term.load()
		change_quest_status(QUEST_AKIRA_MISSING_BOY, QUEST_STATUS_FINISHED)
		make_item_fully_identified(obj)
		dball.reward(obj)

	elseif dball_data.akira_state == 2 then
		message("Akira looks at you coldly.")

	elseif quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_TAKEN then
		message("Please hurry! Mr. Satan's estate is at the end of the road which goes north past the Airport.")

	elseif quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_COMPLETED then
		term.save()
		term.text_out(color.LIGHT_BLUE, "\nAkira: ")
		term.text_out("Ahh! You have delivered the sushi. Thank you. Here, please accept this small payment for your services.\n\n")
		dialogue.conclude()
		term.load()
		change_quest_status(QUEST_AKIRA_SUSHI, QUEST_STATUS_FINISHED)
		player.au = player.au + (player.stat(A_CHR) * 10)
		player.redraw[FLAG_PR_BASIC] = true

	elseif dball_data.oolong_akira == 1 or (quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_TAKEN and dball_data.goods_akira == 0) then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nAkira: ")
		term.text_out("Irasshaimase!\n\n")
		dialogue.helper("Thank you.", "a")
		if dball_data.oolong_akira == 1 then
			dialogue.helper("Oolong says 'hello.'", "b")
		end
		if quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_TAKEN then
			dialogue.helper("Hello, Akira! Hey...have you heard anything about any hijackings? George over at the electronics store has been having trouble lately.", "c")
		end

		local ans = dialogue.answer()
		if ans == "a" then
		elseif ans == "b" then
			dball_data.akira_state = 1
			fall_through = 1
		elseif ans == "c" then
			dball_data.goods_akira = 1
			dball_data.akira_state = 1
			dialogue.store_hack(15)
			term.text_out("\n(Akira looks at you strangely for a moment, glances quickly in both directions, and speaks)\n\n")
			term.text_out(color.LIGHT_BLUE, "Akira: ")
			term.text_out("Yes, I've heard about the hijackings. In fact, I am extremely concerned about them. In Japan, perhaps five or six years ago, there was an extremely similar set of hijackins that had the police completely at a loss for many years. Entire shipments would simply vanish without a trace. Truck drivers would stop for lunch, and discover their truck empty. Department stores were emptied overnight, with nothing recorded on the internal video cameras. It was a nightmare. Eventually it turned out that the group responsible was a revived ninja clan. It was...most peculiar, especially in this modern day and age. I don't know for a fact that there is any connection...all I know is that the pattern here is similar to what we saw back home. Again, I am most concerned about it. That is all I can say.\n\n")
			dialogue.conclude()
			return
		end

	elseif dball_data.oolong_akira == 2 then
		message("#BAkira: #wIrasshaimase!")

	elseif dball_data.akira_state == 1 then
		message("#BAkira: #wIrasshaimase!")

	elseif quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_UNTAKEN then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nAkira: ")
		term.text_out("Irasshaimase! Ii, o tenki desu, ne? Nani o tabemasu ka?\n\n")
		dialogue.helper("Fugu, onegai shimasu.", "a")
		dialogue.helper("Anata no sushi wa oishikatta desu.", "b")
		dialogue.helper("I'm sorry...I don't speak Japanese.", "c")
		if dball_data.oolong_akira == 1 then
			dialogue.helper("Oolong says 'hello.'", "d")
		end
		local ans = dialogue.answer()
		dialogue.store_hack(15)
		if ans == "a" then
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Akira: ")
			term.text_out("Fugu? Honto? Kashikomarimashita!\n\n")
			term.text_out("Akira pulls a fresh fish off the ice and carefully cuts it into very thin slices. He's obviously very excited, but takes his time, and prepares the fish with the elegance of a master. The process takes about twenty minutes, but when he is done, he presents you with the result. It is quite a lovely presentation. It looks tasty, too.\n\n")
			term.text_out("(Received fugu)\n\n")
			dball.reward(create_object(TV_SUSHI, SV_SUSHI_FUGU))
			dball_data.akira_state = 1
			dialogue.conclude()
		elseif ans == "b" then
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Akira: ")
			term.text_out("Watashi no?!?!?!? Aarrrrrggghhhh!!!!\n\n")
			term.text_out("Of all the things you could have said, this was obviously the wrong choice. You might have called him an idiot, and he would have forgiven you. You might have have asked him to lick your boots, and he might have thought someone was playing tricks with your translation dictionary. Any of a thousand things you *might* have said that wouldn't have really bothered him. But, no...you had to go and tell him his sushi wasn't very tasty. He is unforgivably insulted, pulls out a cleaver and attacks you.\n\n")
			dball_data.akira_state = 2
			dialogue.conclude()
			message("press escape")
			quest(QUEST_AKIRA_INSULTED).status = QUEST_STATUS_TAKEN
			dball.dungeon_teleport("Sushi Bar")
		elseif ans == "c" then
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Akira: ")
			term.text_out("Oh! I'm so sorry. You probably aren't here for sushi, then?\n\n")
			dialogue.helper("Not right now, thank you.", "a")
			dialogue.helper("No, I'm sorry...I'm an adventurer. I'm new to the area and was just exploring.", "b")
			local ans = dialogue.answer()
			dialogue.store_hack(15)
			if ans == "a" then
				message("#BAkira:#W Quite alright. Come again.")
				dball_data.akira_state = 1
			elseif ans == "b" then
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Akira: ")
				term.text_out("An adventurer, you say? Hmm. Would you, perhaps, be interested in doing me a favor, then? A regular customer of mine ordered delivery just a few minutes ago, but my delivery boy has gone missing, and I can't leave the store myself. Would you make the delivery for me?\n\n")
				dialogue.helper("Certainly.", "a")
				dialogue.helper("I think I'll have to pass, thanks.", "b")
				local ans = dialogue.answer()
				dialogue.store_hack(15)
				if ans == "a" then
					dialogue.prep()
					term.text_out(color.LIGHT_BLUE, "Akira: ")
					term.text_out("Oh, thank you! His name is Mr. Satan. At least, that's his stage name. He's a former tournament fighter, I belive. If you take the road north past the airport and follow it, you'll end up at his front door. Ring the bell, and they should let you in. Thanks so much!\n\n")
					dialogue.conclude()
					change_quest_status(QUEST_AKIRA_SUSHI, QUEST_STATUS_TAKEN)
					dball.reward(create_object(TV_SUSHI, SV_SUSHI_SABA))
					change_quest_status(QUEST_AKIRA_MISSING_BOY, QUEST_STATUS_TAKEN)
				elseif ans == "b" then
					message("#BAkira:#W Quite alright. I understand.")
					change_quest_status(QUEST_AKIRA_MISSING_BOY, QUEST_STATUS_TAKEN)
					dball_data.akira_state = 1
				end
			end
		elseif ans == "d" then
			fall_through = 1
		end
	else
		message("Thank you again for your help!")
	end

	if fall_through ~= 1 then
		return
	end

	-- Oolong referral
	term.text_out(color.LIGHT_BLUE, "Akira: ")
	term.text_out("Ahhh! Oolong-sama is one of my most loyal customers. I am always delighted to be of service to any friend of his.\n\n")
	dialogue.conclude()
	dball_data.oolong_akira = 2

end

function dialogue.BUYON_TRAP()
	term.save()
	term.text_out(color.LIGHT_BLUE, "General White: ")
	term.text_out("Hahahahah!!! You fool! You fell for my trap! You shall now die horribly!!!\n\n")
	term.text_out("General White presses a small red button on a device in his hand, and instantly the floor drops out from beneath your feet. You plunge down a shaft into darkness and after a fall that is entirely too long, you plunge into solid concrete with a sickening thunk. \n\n")
	take_hit(rng(100, 300), "Buyon trap")
	dialogue.conclude()
	term.load()
	-- dball.dungeon_teleport("Buyon's Lair")
end	
function dialogue.BUYON_LAIR()
	term.save()
	term.gotoxy(0, 0)
	term.text_out("You look around and see...not much. It is terribly dark, and the trap door seems to have closed above you. The floor is littered with half eaten bones, and you get the distinct impression that there is something lurking in the darkness...watching you.\n\n")
	dialogue.conclude()
	term.load()
end	
function dialogue.BUYON_TRAP_FAIL()
	term.save()
	term.text_out(color.LIGHT_BLUE, "General White: ")
	term.text_out("Hahahahah!!! You fool! You fell for my trap! You shall now die horribly!!!\n\n")
	term.text_out("General White presses a small red button on a device in his hand, and instantly the floor beneath you disappears, revealing a dark, and foul-smelling pit. Of course, since you're floating in the air off the ground, this doesn't phase you in the least.\n\n")
	term.text_out(color.LIGHT_BLUE, "General White: ")
	term.text_out("...uh oh. Guards! Help! help!\n\n")
	term.text_out("Unfortuantely for the general, there aren't many soldiers left to come to his aid. Realizing this, he quickly closes the trap door again and draws his pistol")
	dialogue.conclude()
	term.load()
end	

--[[
function dialogue.PACIFIST()
	if dball_data.rra_pacifist ~= 0 then
		return
	end

	dball_data.rra_pacifist = 1

	term.save()
	dialogue.prep()
	term.text_out("As you approach the door, you hear a curious conversation taking place on the other side:\n\n")
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("What do you mean you won't fight?!?!?! Get out there and kill " .. gendernouns.himher .. "!\n\n")
	term.text_out(color.LIGHT_BLUE, "Android 8: ")
	term.text_out("No, sir. Killing is wrong.\n\n")
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("Infernal machine! Why did we even bother building you?\n\n")
	term.text_out(color.LIGHT_BLUE, "Android 8: ")
	term.text_out("My creator built me to kill, and to destroy.\n\n")
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("Then fulfill your purpose! Get out there right now and get that intruder before " .. gendernouns.heshe .. " kills us all!\n\n")
	term.text_out(color.LIGHT_BLUE, "Android 8: ")
	term.text_out("No. I would sooner die than cause harm to another.\n\n")
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("Unbelievable. Very well, if death is what you want, I'll give it to you. Right now.\n\n")
	dialogue.conclude()
	term.load()
end
]]

-- Note lack of term.save()! This is called from multiple locations depending on how the player enters Blue's lair!
function dialogue.BLUE_DESTRUCTION()
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("Hello, my dear intruder. Welcome to my lair. It is very likely to be the last sight you ever see. You have defeated my guards")
	if dball_data.rra_blue_sec ~= 0 then
		term.text_out(" and obliterated my security network.")	
	else
		term.text_out(" and generally made quite the nuisance of yourself.")	
	end
	term.text_out(" Fortunately I longer have any use for this facility. It will make an excellent underwater tomb.\n\n")
	term.text_out("He presses a small button. There is a tremendous rumble in the ground beneath you and you hear the sound of rushing water in the distance.\n\n")
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("I have just set off the self destruct mechanism for this base. In a swift few minutes this room and all the floors above will be completely submerged. You will die.\n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("What's to stop me from simply leaving?\n\n")
	term.text_out(color.LIGHT_BLUE, "General Blue: ")
	term.text_out("Me.\n\n")
	dialogue.conclude()
	term.load()
	dball_data.rra_blue_submerge = 1
end

--[[
function dialogue.ANDROID8()
	if dball_data.rra_android8 == 0 then
		term.text_out(color.LIGHT_BLUE, "Android 8: ")
		term.text_out("Please stop fighting! All of you!")
	elseif dball_data.rra_android8 == 1 then
		-- Set by General Blue's death
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Android 8: ")
		term.text_out("Such sorrow. Such sadness. Such death. I was created to partake in such horrors as this, but I cannot. I will not. But despite my fortitude, it seems the world around me is made of death. Very well. I will accept the world how it is, but I simply choose not to live in it.\n\n")
		term.text_out(color.LIGHT_RED, "BEEP!\n\n")
		term.text_out(color.LIGHT_BLUE, "Android 8: ")
		term.text_out("There. It will all be over soon. I have initiated an irrevocable countdown to trigger my Remote Stop Device. They're intended to be used only to stop us should we get out of control, but we're all able to activate them ourselves, as well. I will self destruct in a few minutes. Please, leave while there's still time. Escape...live.\n\n")
		dialogue.conclude()
		dball_data.rra_android8 = 2
		term.load()
	elseif dball_data.rra_android8 == 2 then
		term.text_out(color.LIGHT_BLUE, "Android 8: ")
		term.text_out("Please hurry. There isn't much time left.")
	end
end
]]

function dialogue.RRA_INT_DISABLE()
	if dball_data.rra_shq_int == 1 then
		message("The computer has been destroyed")
		return
	end
	term.save()

	if skill(SKILL_TECHNOLOGY).value > 4 then
		term.text_out(color.LIGHT_GREEN, "This ")
		term.text_out("computer appears to be the control system for the internal autoturret defense system for the various facilities here at Red Ribbon Army Supreme Headquarters. You're fairly certain that by destroying it you'll be able to permanantly shut down every autoturret in the entire complex.\n\n")

	else
		term.text_out(color.LIGHT_GREEN, "There ")
		term.text_out("is a large computer system here. You're not certain what it does, but it's probably important.\n\n")
	end

	term.text_out("Would you like to destroy it?\n\n")
	dialogue.helper("Yes.", "a")
	dialogue.helper("No.", "b")
	local ans = dialogue.answer()
	term.load()
	term.save()
	if ans == "a" then
		dball_data.rra_shq_int = 1
		if skill(SKILL_TECHNOLOGY).value > 4 then
			term.text_out(color.LIGHT_GREEN, "You ")
			term.text_out("instruct the computer to disable everything that it controls, and then selectively fry its internal circuitry. The beauty of this is that from teh outside it appears that the power has simply been turned off, in reality all the control boards have been completely melted and fused to their casings. Every single one of them will need to be replaced...with a hacksaw. You smile at the thought of the Red Ribbon Army technology personell trying to figure out how to do this. It won't be easy.\n\n")
		else
			term.text_out(color.LIGHT_GREEN, "You ")
			term.text_out("thoroughly smash it. Sometimes the direct approach is best.\n\n")
		end
	elseif ans == "b" then
	end

	term.load()
end
function dialogue.RRA_EXT_DISABLE()
	if dball_data.rra_shq_ext == 1 then
		message("The computer has been destroyed")
		return
	end
	term.save()

	if skill(SKILL_TECHNOLOGY).value > 4 then
		term.text_out(color.LIGHT_GREEN, "This ")
		term.text_out("computer appears to be the control system for the external missile defense system surrounding Red Ribbon Army Supreme Headquarters. You're fairly certain that by destroying it you'll be able to permanantly shut them down.\n\n")

	else
		term.text_out(color.LIGHT_GREEN, "There ")
		term.text_out("is a large computer system here. You're not certain what it does, but it's probably important.\n\n")
	end

	term.text_out("Would you like to destroy it?\n\n")
	dialogue.helper("Yes.", "a")
	dialogue.helper("No.", "b")
	local ans = dialogue.answer()
	term.load()
	term.save()
	if ans == "a" then
		dball_data.rra_shq_ext = 1
		if skill(SKILL_TECHNOLOGY).value > 4 then
			term.text_out(color.LIGHT_GREEN, "You ")
			term.text_out("instruct the computer to disable everything that it controls, and then selectively fry its internal circuitry. The beauty of this is that from teh outside it appears that the power has simply been turned off, in reality all the control boards have been completely melted and fused to their casings. Every single one of them will need to be replaced...with a hacksaw. You smile at the thought of the Red Ribbon Army technology personell trying to figure out how to do this. It won't be easy.\n\n")
		else
			term.text_out(color.LIGHT_GREEN, "You ")
			term.text_out("thoroughly smash it. Sometimes the direct approach is best.\n\n")
		end
	elseif ans == "b" then
	end

	term.load()
end
function dialogue.RRA_CAM_DISABLE()
	if dball_data.rra_shq_cam == 1 then
		message("The computer has been destroyed")
		return
	end
	term.save()

	if skill(SKILL_TECHNOLOGY).value > 4 then
		term.text_out(color.LIGHT_GREEN, "This ")
		term.text_out("computer appears to be the control system for the internal cameras throughout Red Ribbon Army Supreme Headquarters. You're fairly certain that by destroying it you'll be able to permanantly shut them all down. No doubt this would make infiltrating the rest of the complex much easier.\n\n")

	else
		term.text_out(color.LIGHT_GREEN, "There ")
		term.text_out("is a large computer system here. You're not certain what it does, but it's probably important.\n\n")
	end

	term.text_out("Would you like to destroy it?\n\n")
	dialogue.helper("Yes.", "a")
	dialogue.helper("No.", "b")
	local ans = dialogue.answer()
	term.load()
	term.save()
	if ans == "a" then
		dball_data.rra_shq_cam = 1
		if skill(SKILL_TECHNOLOGY).value > 4 then
			term.text_out(color.LIGHT_GREEN, "You ")
			term.text_out("instruct the computer to disable everything that it controls, and then selectively fry its internal circuitry. The beauty of this is that from the outside it appears that the power has simply been turned off, in reality all the control boards have been completely melted and fused to their casings. Every single one of them will need to be replaced...with a hacksaw. You smile at the thought of the Red Ribbon Army technology personell trying to figure out how to do this. It won't be easy.\n\n")
		else
			term.text_out(color.LIGHT_GREEN, "You ")
			term.text_out("thoroughly smash it. Sometimes the direct approach is best.\n\n")
		end
	elseif ans == "b" then
	end

	term.load()
end



function dialogue.RED()
	if dball_data.rra_hq_state ~= 0 then
		return
	end

	dball_data.rra_hq_state = 1

	term.save()
	dialogue.prep()
	if dball_data.rra_shq_cam == 1 then
		-- Cameras destroyed
		term.text_out("As you approach the door, you hear a conversation taking place on the other side:\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("Yes, sir. It appears that our covert operation was extremely succesful.\n\n")
		term.text_out(color.LIGHT_BLUE, "Commander Red: ")
		term.text_out("That's all well and good, but I'm more concerned about our intruder. How far has " .. gendernouns.heshe .. " progressed?\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("I'm sorry sir. It's impossible to say, now that the internal security system has been destroyed. It's possible " .. gendernouns.heshe .. " could be outside our door right now.\n\n")
		term.text_out(color.LIGHT_BLUE, "Commander Red: ")
		term.text_out("This isn't good. Oh, I do so wish our troops would hurry up and find the remaining Dragonballs so I could make my wish and be done with it.\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("Yes, sir! And then the Red Ribbon Army shall RULE THE WORLD!!! HAHAHAHAHA!!!!\n\n")
	else
		-- Cameras functioning
		term.text_out("As you approach the door, you hear a frantic conversation taking place on the other side:\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("Commander! The intruder has passed all of our defenses! He's right outside the door?\n\n")
		term.text_out(color.LIGHT_BLUE, "Commander Red: ")
		term.text_out("WHAT!?!?! Already?!?!\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("I'm afraid so, sir.\n\n")
		term.text_out(color.LIGHT_BLUE, "Commander Red: ")
		term.text_out("...all our forces...all that money I spent on interior design...all destroyed...\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("Don't worry, sir. There's still the two of us. And we do still have the slush fund.\n\n")
	end
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out("...but, there is more:\n\n")
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out(color.LIGHT_BLUE, "Commander Red: ")
	term.text_out("...Adjutant...you've been my confidant all of these years. I think I'd like confide something in you that I...well, that I've kept to myself. Can I trust you?\n\n")
	term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
	term.text_out("Absolutely, sir!\n\n")
	term.text_out(color.LIGHT_BLUE, "Commander Red: ")
	term.text_out("Well, it's about the Dragonballs. As you know, when I first heard about the Dragonballs and set out to gather them up, I knew I'd need help and all...so that's why I put together the army. But really, no one's ever actually asked me what I was going to wish for.\n\n")
	term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
	term.text_out("Well, sir, I think the men have always assumed that a great man like you had great ambitions. In fact, you've often mentioned the 'height' of your ambitions.\n\n")
	term.text_out(color.LIGHT_BLUE, "Commander Red: ")
	term.text_out("...yes, but...\n\n")
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
	term.text_out("...and so I think it's always simply been understand that you had the highest ambition in mind for us, to build an army and RULE THE WORLD!!! HAHAHAHA!!!!\n\n")
	term.text_out(color.LIGHT_BLUE, "Commander Red: ")
	term.text_out("Umm...no, that's not it.\n\n")
	term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
	term.text_out("HAHAHAHAHA...oh, no? It isn't...?\n\n")
	term.text_out(color.LIGHT_BLUE, "Commander Red: ")
	term.text_out("No. I was being literal about the 'height' of my ambitions. That IS my ambition: Height. I've always wished I could be taller so girls would like me.\n\n")
	term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
	term.text_out("...you...what...?\n\n")

	if dball_data.rra_shq_cam == 0 then
		term.text_out(color.LIGHT_BLUE, "Commander Red: ")
		term.text_out("Alright, Adjutant...time to defend the Red Ribbon Army! Lock and load!\n\n")
		term.text_out(color.LIGHT_BLUE, "Adjutant Black: ")
		term.text_out("...but..sir...umm...\n\n")
	end

	dialogue.conclude()
	term.load()
end

function dialogue.KARATE()
	term.gotoxy(0, 0)
	if dball_data.fled_karate == 1 then
		term.text_out(color.LIGHT_BLUE, "\nNakamura Sensei: ")
		term.text_out("Only a coward would flee from battle as you did.\n\n")
		dialogue.conclude()
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_TAKEN then
		term.text_out(color.LIGHT_BLUE, "\nNakamura Sensei: ")
		term.text_out("The Kickboxing school is right next door in suite 101. Go wipe them out!\n\n")
		dialogue.conclude()
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nNakamura Sensei: ")
		term.text_out("Congratulations on your victory! I hear Bob didn't give you much of a fight. I'm not surprised. But now that they're gone, and we're the only school around here that focuses on barehanded fighting, our student base will surely double! It will be very good for the school, and I'm the quality of instruction will improve, too!\n\n")
		trainer[FLAG_KARATE] = 1
		dialogue.conclude()
		change_quest_status(QUEST_CHALLENGE_KICKBOXING, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_FAILED then
		message("I'm not talking to you.")
		message("You really embarrassed me when you lost to that Bob guy.")
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_FINISHED then
		message("Thanks again for getting rid of that kickboxing school!")
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("You should sign up for classes!")
		elseif enrollments[FLAG_KICKBOXING] >  0 then
			term.text_out(color.LIGHT_BLUE, "\nNakamura Sensei: ")
			term.text_out("I'm sorry. I don't take students who have previously studied kickboxing. Karate requires precision and control. With all the time spent wearing pads and gloves, kickboxing students have a difficult time learning control, and tend to harm other students.\n\n") 
			dialogue.conclude()
		elseif enrollments[FLAG_KARATE] == 0 then
			message("I don't usually like taking students from other styles,")
			message("But you look willing to learn. Care to sign up?")
		else
			message("You're doing very well! Keep training!")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
end

function dialogue.CQ_KARATE()
	term.gotoxy(0, 0)
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nNakamura Sensei: ")
	term.text_out("I've been following your training very closely, and I must say that I'm impressed! Fortunately you chose to study here instead of that kickboxing school next door. So many people who don't know any better study there...it's such a waste! Kickboxing is just mindless punching and kicking. No discipline, no control, no balance. Sure, it's a good workout and repetition is good, but it's very limiting in the long run. Why, I bet even a student like you could defeat their instructor, Bob. Hmm. That might not be a bad idea. I could do it myself, of course, but as the master of this school, it wouldn't mean anything. Of *course* I could beat him. But if you, a mere student did...that would really prove to people the value of mind and discipline in the martial arts.\n\n")
	dialogue.helper("Yes, Sensei! I will defeat him in honorable combat!", "a")
	dialogue.helper("No, sorry. I don't think that's such a good idea.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_CHALLENGE_KICKBOXING)
	elseif ans == "b" then
	end
end

function dialogue.KUNGFU()
	term.gotoxy(0, 0)
	if dball_data.fled_kungfu == 1 then
		message("Only a coward would flee from battle as you did.")
	elseif quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_TAKEN then
		message("The fencing school is in the suite next door.")
		message("Go wipe them out!")
	elseif quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nFong-Sai Yuk: ")
		term.text_out("Excellent! With that fool Jacques out of the way, and our studio being the only one in this area, I'm sure we'll do much better, and the quality of instruction will improve, too!\n\n")
		trainer[FLAG_KUNGFU] = 1
		dialogue.conclude()
		change_quest_status(QUEST_CHALLENGE_FENCING, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_FAILED then
		message("I'm not talking to you.")
		message("You really embarrassed me when you lost to that fencer.")
	elseif quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_FINISHED then
		message("Thanks again for getting rid of that fencing school!")
	elseif quest(QUEST_CHALLENGE_FENCING).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("You should sign up for classes!")
		elseif enrollments[FLAG_FENCING] >  0 then
			term.text_out(color.LIGHT_BLUE, "\nFong-Sai Yuk: ")
			term.text_out("I'm sorry. I don't take students who have previously studied fencing. The fundamentals are completely different, and it's entirely too much work to un-teach what has already been learned to make room for something new.\n\n") 
			dialogue.conclude()
		elseif enrollments[FLAG_KUNGFU] == 0 then
			message("I don't usually like taking students from other styles,")
			message("But you look willing to learn. Care to sign up?")
		else
			message("You're doing very well! Keep training!")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
end
function dialogue.CQ_KUNGFU()
	term.gotoxy(0, 0)
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nFong-Sai Yuk: ")
	term.text_out("I'm very pleased with your progress! You've come a long ways. Fortuantely you chose to study here instead of that ridiculous fencing school next door. Great martial arts always comes from a strong initial foundation. You can't just build the top floor of a building and expect it to stand. Fencing is kind of like that. Still, a lot of people in this area to study there, and honestly I think it's detracted from the quality of martial arts in the whole city. Say...maybe you could challenge Jacques to a duel? I'm so much better than he is, it wouldn't mean nyathing if I did...but if you, as a student were to beat him...wow! That would show everybody how worthless fencing is! What do you say?\n\n")
	dialogue.helper("Absolutely! I will prove to them the superiority of Kung-Fu!", "a")
	dialogue.helper("No, sorry. I don't think that's such a good idea.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_CHALLENGE_FENCING)
	elseif ans == "b" then
	end
end

function dialogue.FENCING()
	term.gotoxy(0, 0)
	if dball_data.fled_kungfu == 1 then
		message("Only a coward would flee from battle as you did.")
	elseif quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_TAKEN then
		message("The kung fu school is right next door.")
	elseif quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nJacques: ")
		term.text_out("Ahhh, " .. gendernouns.french .. "! You have defeated Fong-Sai Yuk, and he has indeed closed his school! It is most excellent! Many of his former students have signed up here already, and I'm certain that as our school continues to grow, the quality of our instruction shall improve as well!\n\n")
		trainer[FLAG_FENCING] = 1
		dialogue.conclude()
		change_quest_status(QUEST_CHALLENGE_KUNGFU, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_FAILED then
		message("Ahhh, you did not do so well. How sad.")
	elseif quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_FINISHED then
		message("Thanks again for getting rid of that kung fu school!")
	elseif quest(QUEST_CHALLENGE_KUNGFU).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("Bon jour, " .. gendernouns.french .. ". Are you here to enroll?")
		elseif enrollments[FLAG_KUNGFU] >  0 then
			term.text_out(color.LIGHT_BLUE, "\nJacques: ")
			term.text_out("Pardon, " .. gendernouns.french .. ", I do not take students who have previously studied kungfu. The fundamentals are completely different, and it's entirely too much work to un-teach what has already been learned to make room for something new.\n\n") 
			dialogue.conclude()
		elseif enrollments[FLAG_FENCING] == 0 then
			message("I don't usually like taking students from other styles,")
			message("But you look willing to learn. Care to sign up?")
		else
			message("You're doing very well! Keep training!")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
end
function dialogue.CQ_FENCING()
	term.gotoxy(0, 0)
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nJacques: ")
	term.text_out("Ahhh..." .. gendernouns.french .. "! You have improved so much! I am most pleased with your progress! Sadly, ours is but a poor, small school and I do not think you will be able to progress much further here. At least, as things are now. You see, the kung fu school next door robs me of my business! It is the television, I think. People see Bruce Lee, and want to fight like he does. Ahhh...the young ones do not appreciate our fine traditions! If only that school were to go away, I am certain that our school would improve very much. Perhaps...you might be willing to challenge their instructor to a duel? If you were to defeat him, I am sure he would close his school from shame!\n\n")
	dialogue.helper("Me, oui! (yes)", "a")
	dialogue.helper("No. (no)", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_CHALLENGE_KUNGFU)
	elseif ans == "b" then
	end
end
function dialogue.KICKBOXING()
	term.gotoxy(0, 0)
	if dball_data.fled_kickboxing == 1 then
		message("Oh, look. It's the clumsy buffoon who thought he could fight me!")
	elseif quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_TAKEN then
		message("The Karate school is right next door in suite 100. Don't make too")
		message("much of a mess of the pavement with them.")
	elseif quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nBobi: ")
		term.text_out("You beat Nakamura, huh? Yeah, I didn't think he'd be too much trouble for you. Looks like his studio will be closing, too! That's terrific! I'm sure the quality of martial arts around here will improve considerably.\n\n")
		trainer[FLAG_KICKBOXING] = 1
		dialogue.conclude()
		change_quest_status(QUEST_CHALLENGE_KARATE, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_FAILED then
		message("I don't understand how you could of lost to TKD. Guess I should")
		message("have made you do more bag work.")
	elseif quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_FINISHED then
		message("Hey! Great to see you again!")
	elseif quest(QUEST_CHALLENGE_KARATE).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("New student? Great! Press e to sign up!")
		elseif enrollments[FLAG_KARATE] >  0 then
			term.text_out(color.LIGHT_BLUE, "\nBobi: ")
			term.text_out("Sorry. I don't take students who have previously studied karate. It's just too difficult to overcome all the ridiculous training habits. Seriously, can you explain to me deliberately practicing NOT hitting your opponent? It's ridiculous, and experience has shown me that not only are karate practitioners forever damaged as real fighters, they're genuinely happier somewhere else, so let's both save ourselves the hassle.\n\n")
			dialogue.conclude()
		elseif enrollments[FLAG_KICKBOXING] == 0 then
			message("You have previous martial arts experience? That's great!")
			message("I always encourage people to cross-train.")
		else
			message("Hello! Always good to see you!")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
end
function dialogue.CQ_KICKBOXING()
	term.gotoxy(0, 0)
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nBob: ")
	term.text_out("Hey, " ..player_name() .. "! I'm really impressed with your progress! Fortunately you decided to study here instead of that karate school next door. Yeah, it's really too bad that so many people fall into that trap. I know, everybody thinks 'karate' when they think of martial arts, but most people don't realize karate is all about forms and tradition rather than actually fighting. We lose a lot of business to them. Hey...here's a thought: how'd you like to prove yourself by challenging their head instructor? I'd do it myself, but it wouldn't mean as much as if you did. I've been tournament fighting for years, but you're just a student. Think of it as your chance to break into the big league. How does that sound to you?\n\n")
	dialogue.helper("Yeah, sure. I need a cool-down from my last workout anyway.", "a")
	dialogue.helper("No, sorry. I don't think that's such a good idea.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_CHALLENGE_KARATE)
	elseif ans == "b" then
	end
end

function dialogue.TAEKWONDO()
	term.gotoxy(0, 0)
	message("Tae Kwon Do is disabled for V083")
	return
--[[
	if dball_data.fled_taekwondo == 1 then
		message("You are both a coward and a fool. Go away.")
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_TAKEN then
		message("The kickboxing school is right scross the street.")
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nMaster Lee: ")
		term.text_out("Ahhh! You have demonstrated that heart is triumphant over the mere fist! Looks like the Kickboxing school has closed. Excellent! I'm sure the quality of martial arts around here will improve as a result.\n\n")
		trainer[FLAG_TAEKWONDO] = 1
		dialogue.conclude()
		change_quest_status(QUEST_CHALLENGE_KICKBOXING, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_FAILED then
		message("You have no heart! How else could you have lost to such a brute?")
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_FINISHED then
		message("Thank you again for getting rid of that kickboxing school!")
	elseif quest(QUEST_CHALLENGE_KICKBOXING).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("Care to sign up? We're having a family special right now!")
		elseif enrollments[FLAG_TAEKWONDO] == 0 then
			message("Looks like you've studied before. Well, that's ok.")
			message("Why not sign up, though, and learn Tae Kwon Do?")
		else
			message("Hello!")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
]]
end
function dialogue.CQ_TAEKWONDO()
	term.gotoxy(0, 0)
	message("Tae Kwon Do is disabled for V083")
	return
--[[
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nMaster Lee:")
	term.text_out("I'm really glad that you chose to study here instead of at that kickboxing school across the street. It shows that you have true heart, true soul. Kickboxing is a good workout, but it's all martial and no art! There's no history, no culture, no moral training, just a bunch of guys hitting bags and each other all day long. It's really a shame. Say, now that I think about it, I have a great idea! Why don't you challenge their head instructor to a duel? It would prove to the world that a pure heart will conquer a hardened body any day!\n\n")
	dialogue.helper("Yes, the heart is stronger than the fist. I will do it.", "a")
	dialogue.helper("No, sorry. I don't think that's such a good idea.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_CHALLENGE_KICKBOXING)
	elseif ans == "b" then
	end
]]
end

function dialogue.NINJUTSU_REFUSE()
	term.gotoxy(0, 0)
	term.text_out("Grandmaster Hatsumi eyes you coldly.\n\n")
	term.text_out(color.LIGHT_RED, "\nGrandmaster Hatsumi: ")
	term.text_out("You are not welcome here. You will leave now.\n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("But why?\n\n")
	term.text_out(color.LIGHT_RED, "\nGrandmaster Hatsumi: ")
	term.text_out("Surely you know why. Go, now.\n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("But I really don't know why.\n\n")
	term.text_out(color.LIGHT_RED, "\nGrandmaster Hatsumi: ")
	term.text_out("Then you are a fool.\n\n")
	dialogue.conclude()
end
function dialogue.NINJUTSU()
	term.gotoxy(0, 0)
	-- Should Grandmaster Hatsumi care if you flee from challenging him?
	if quest(QUEST_KILL_SHREDDER).status == QUEST_STATUS_TAKEN then
		message("The Shredder is a skilled opponent. Do not take him lightly.")
	elseif quest(QUEST_CHALLENGE_BALLET).status == QUEST_STATUS_TAKEN then
		term.text_out("\n")
		if dball_data.ballet_vent_state == 0 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Grandmaster, I have seen this school, but they reveal nothing to me. What shall I do?\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("Perhaps the direct approach will not be effective here. You are ninja. Seek the less obvios path.\n\n")
			dialogue.conclude()
		elseif dball_data.ballet_vent_state == 1 then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Grandmaster, I have found a suspicious vent in the back of the school. It vents large amounts of hot steam.\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("Indeed. The refuse of their cursed machinery. You must put an end to this.\n\n")
			dialogue.conclude()
		elseif dball_data.ballet_vent_state > 1 then
			local senshi = 0
			local sakura = 0
			if race_info_idx(RACE_SAKURA_SENSHI, 0).max_num == 0 then senshi = senshi + 1 sakura = sakura + 1 end
			if race_info_idx(RACE_SUMIRE_SENSHI, 0).max_num == 0 then senshi = senshi + 1 end
			if race_info_idx(RACE_MARIA_SENSHI, 0).max_num == 0 then senshi = senshi + 1 end
			if race_info_idx(RACE_IRIS_SENSHI, 0).max_num == 0 then senshi = senshi + 1 end

			if sakura > 0 then
				if senshi < 4 then
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Grandmaster, I have done battle with our enemies, and slain their leader, Sakura.\n\n")
					term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
					term.text_out("This is most excellent news. However, our task is not finished while the enemy still lives. You may have slain the leader, but if the followers are not slain as well, one of them will surely take her place.\n\n")
					dialogue.conclude()
				else
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Grandmaster, I have done battle with our enemies, and slain them all.\n\n")
					term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
					term.text_out("Indeed, you have done well. I am most pleased with you, my student. Already I have received gifts of praise from the neighbnoring clans. You have done much for the honor of this school, and we will surely grow stronger because of it.\n\n")
					dialogue.conclude()
					trainer[FLAG_NINJUTSU] = 1
					c_schools[FLAG_BALLET] = FLAG_SCHOOL_CLOSED
					change_quest_status(QUEST_CHALLENGE_BALLET, QUEST_STATUS_FINISHED)
					dball.cqcq_check()
				end
			elseif senshi > 0 then
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Grandmaster, I have done battle with our enemies. Much blood has been spilled this day.\n\n")
				term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
				term.text_out("Indeed, you have done well. But the task is not complete. You must slay them all, and return me.\n\n")
				dialogue.conclude()
			else
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Grandmaster, I have entered the hall of our enemies. They have much technology at their disposal, just as you have said.\n\n")
				term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
				term.text_out("Indeed. You must return and do battle with them. Slay them, and then return to me.\n\n")
				dialogue.conclude()
			end

		else
			message("Error: Unknown steam vent state in Ninja Challenge quest. State is: " .. dball_data.ballet_vent_state)
		end
	elseif quest(QUEST_KILL_SHREDDER).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nHamato Yoshi: ")
		term.text_out("The vile one has been destroyed. You have done well. With his corruption gone, at last our art will flourish.\n\n")
		trainer[FLAG_NINJUTSU] = 1
		dialogue.conclude()
		change_quest_status(QUEST_KILL_SHREDDER, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_KILL_SHREDDER).status == QUEST_STATUS_FINISHED then
		message("It is an honor to see you again.")
	elseif quest(QUEST_CHALLENGE_BALLET).status == QUEST_STATUS_FINISHED then
		message("It is an honor to see you again.")
	else
		if dball_data.p_class == "Wannabe" then
			message("Hmm. You look like you would make a good pupil.")
		elseif enrollments[FLAG_NINJUTSU] == 0 then
			term.text_out(color.LIGHT_BLUE, "\nHamato Yoshi: ")
			term.text_out("You have some skill. But perhaps you would like to truly test your mettle by signing up for classes?\n\n")
			dialogue.conclude()
		else
			message("Greetings, disciple.")
		end
	end
end 
function dialogue.CQ_NINJUTSU()
	term.gotoxy(0, 0)
	term.text_out(color.LIGHT_BLUE, "\nGrandmaster Hatsumi: ")
	term.text_out("I am pleased with you. You have trained diligently, and you have been rewarded plentifully in strength and skill. Perhaps it is time to put these to the test. I have a task for you. It is not an easy one, but I believe you are ready. Do you accept?\n\n")
	dialogue.helper("Yes, master. I am ready.", "a")
	dialogue.helper("Forgive me, master. I am but a seed. Please allow me to train further before I am burdened with such things", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		dialogue.store_hack(10)
		term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
		if quest(QUEST_BALLET_PRE).status == QUEST_STATUS_UNTAKEN then
			-- Ninjutsu CQ is against Ballet
			if dball_data.alignment < 0 then
				term.text_out("Ahh...my disciple, your heart swells with such hatred and evil, you will have a dark and twisted future indeed. And it shall be put to excellent use.\n\n")
				term.text_out("For nearly a hundred years our clan has fought the forces of good from behind the shadows. Forces of good which have recently taken a new form. As we have done, our enemy has cloaked itself so as to remain hidden from curious eyes.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Then our enemies are wise.")
				term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
				term.text_out("Indeed they are. However, while they may be cunnign in intellect, they are weak of body. They have chosen, rather thanto augment and train their bodies, to use tools to aid them. Tools of technology. Though it is a powerful crutch, it is a crutch nonetheless. A weakness, which we shall exploit.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Who is this enemy? What must I do?\n\n")
			else		
				term.text_out("It is believed by many that we ninja are forces of evil, of destruction. While it is true that some clans do revel in evil, for ours it is not so.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("That's good to know.\n\n")
				term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
				term.text_out("But now, an evil has grown that must be confronted. It hides in the shadows, and as such, only we ninja are equiped to deal with it.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("What is this enemy that we must face?\n\n")
				term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
				term.text_out("As you know, the art of ninja does not limit itself to mere mastery of the body. Rather, it is the art of perfection of the whole self. It is the path to enlightenment of being. All of humanity yearns for a return to our rightful place in the heavens. Or rather, most. There are some who reject the power of spirit, and instead choose to revel in the mere physical. Choosing to enhance their body with mere tools, thus becoming tools themselves.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("What must I do?\n\n")
			end
			dialogue.conclude()
			dialogue.store_hack(20)
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("In the town to the southwest, there is what appears to be a very ordinary dance and theater school.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Sakura's school?\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("You already know of it. This is good. Go there, and see with your own eyes the horrors that they bring upon humanity.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...the dance school...?\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("Do not give in to deception, for there is much that is hidden from those who perceive shallowly. Go to this 'dance' school. Find the secrets that they hide. Put an end to them.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Very well. I will do as you ask.\n\n")
			dialogue.conclude()
			change_quest_status(QUEST_CHALLENGE_BALLET, QUEST_STATUS_TAKEN)
		else
			-- Ninjutsu CQ is against Shredder
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("As well you know, we ninja train not merely the body, but also the mind, heart and spirit.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes.\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("But with a strong heart and a strong spirit comes great power. And alas, there are always some who fall short of the path of wisdom, and use this power for mere material gains. Such a one exists right now.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Who is this one?\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("He is a talented practitioner, some would call him a master. His name is Oroku Saki. He is the leader of The Foot ninja clan, and they operate out of what appears from the outside to be an adbandoned warehouse on a small island to the southwest.\n\n")
			dialogue.conclude()
			term.save()
			term.load()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("What must I do?\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("We are all connected, " .. player_name() .. ". You, and I...all of us. Like fingers next to one another, perceiving ourselves to be separate because we do not know that we part are a single hand. This connection we sahre gives us great responsibility. This man, Saki, is like a diseased leaf on tree. He is poisoning all of us, and he must be pruned.\n\n")
			term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
			term.text_out("You must find Oroku Saki, and kill him.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I understand. It will be done.\n\n")
			dialogue.conclude()
			term.save()
			term.load()
			change_quest_status(QUEST_KILL_SHREDDER_FOR_HATSUMI, QUEST_STATUS_TAKEN)
		end
	elseif ans == "b" then
		dialogue.store_hack(10)
		term.text_out(color.LIGHT_BLUE, "Grandmaster Hatsumi: ")
		term.text_out("Very well. One cannot compell a flower to bloom before its time.\n\n")
		dialogue.conclude()
	end

end

function dialogue.BALLET_REFUSE()
	term.gotoxy(0, 0)
	term.text_out("Sakura eyes you cautiously.\n\n")
	term.text_out(color.LIGHT_RED, "\nSakura: ")
	term.text_out("...I'm sorry, I don't think that would be...entirely proper.\n\n")
	term.text_out("Instantly, three performers are standing silently at her side, as if waiting for you to leave. It is very awkward.\n\n")
	dialogue.conclude()
end
function dialogue.BALLET()
	term.gotoxy(0, 0)
	-- Must complete King Mouse quest before Ballet is available as a school
	-- Once that's done, Ballet follows the regular Challenge Quest model

	if quest(QUEST_BALLET_PRE).status == QUEST_STATUS_TAKEN then
		if race_info_idx(RACE_KING_MOUSE, 0).max_num < 1 then
			dball_data.monster_counter = 0
			for_each_monster(function(m_idx, monst)
				if monst.r_idx == RACE_CUTE_LITTLE_GIRLMOUSE or monst.r_idx == RACE_CUTE_LITTLE_BOYMOUSE then
					dball_data.monster_counter = dball_data.monster_counter + 1
					delete_monster_idx(m_idx)
				end
			end)
			if dball_data.monster_counter < 8 then
				local fail_mess
				local remaining = 8 - dball_data.monster_counter
				if dball_data.monster_counter == 0 then
					fail_mess = "Where are they? What do you mean they didn't make it? ALL of them!?!? All eight children are GONE!?!?!? How horrible! What a lousy adventurer you are! Oh, goodness...I'll be ruined! I don't know what to do. Maybe I should just shoot myself before one of the parents does. This is awful. I don't think I can deal with this. Please go away."
				elseif dball_data.monster_counter < 4 then
					fail_mess = "Where are they? I only see " .. dball_data.monster_counter .. " children with you. What? The other " .. remaining .. " are all GONE?!?!? How terrible! What am I going to tell their parents? They just got lost? I'm ruined! And the poor children! Oh, this is so terrible. Still...it could have been worse. At least some of them did make it back. Thank you for your help."
				else
					fail_mess = "Let me see, "
					for i = 1, dball_data.monster_counter do
						fail_mess = fail_mess .. ", " .. i
					end
					fail_mess = fail_mess .. ". Umm...is that all? " .. remaining .. " are missing? Gone? Dead?!?! Oh no! This is awful! Well, at least you brought most of them back. I'm sure their parents will be thrilled, but I'm not sure what to say to the other parents. I'm sure I'll have a lawsuit on my hands. I guess I'll just tell them what happened and hope for the best. Thank you so much for your help!"
				end
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("You found the children? How wonderful! " .. fail_mess .. "\n\n")
				dialogue.conclude()
				change_quest_status(QUEST_BALLET_PRE, QUEST_STATUS_FAILED_DONE)
				c_schools[FLAG_BALLET] = FLAG_SCHOOL_CLOSED
			else
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("The missing children! Oh, how wonderful! Thank you so much! Their parents have been so worried. And now that things have returned to normal I'll be able to start teaching regular classes again. It's really quite a relief. Thank you so much.\n\n")
				dialogue.conclude()
				change_quest_status(QUEST_BALLET_PRE, QUEST_STATUS_FINISHED)
			end
		else
			message("Please find the children! Their parents are really worried!")
		end
	elseif quest(QUEST_BALLET_PRE).status == QUEST_STATUS_FAILED_DONE then
		term.text_out(color.LIGHT_BLUE, "\nSakura: ")
		term.text_out("Hello again. Thank you for your help, but one of the parents of a child that never came back was filed a lawsuit against me, and I don't think I'll be in business much longer. I'm sorry things turned out like this. Still, I'm gratefull for your help. Thank you.\n\n")
		dialogue.conclude()
	elseif quest(QUEST_BALLET_PRE).status == QUEST_STATUS_FINISHED then
		message("Hello! :) Nice to see you again.")
	elseif quest(QUEST_BALLET_PRE).status == QUEST_STATUS_UNTAKEN then
		term.text_out(color.LIGHT_BLUE, "\nSakura: ")
		term.text_out("Hello. I'm terribly sorry. Our upcoming performance of Tchaikovsky's Nutcracker has been canceled. Please accept my apologies. And yes, tickets will be refunded in full.\n\n")
		dialogue.helper("Sorry to hear it.", "a")
		dialogue.helper("If you don't mind me asking, why was the performance canceled?", "b")
		if dball_data.ballet_vent_state == 1 then
			dialogue.helper("Why do you have such a large steam vent in the back of your studio?", "c")
		end
		local ans = dialogue.answer()
		if ans == "a" then
		elseif ans == "b" then
			dialogue.store_hack(15)
			term.text_out(color.LIGHT_BLUE, "\nSakura: ")
			term.text_out("It's...umm...complicated. Oh, wait...you don't look like you're here for the performance. Are you an adventurer, by chance?\n\n")
			dialogue.helper("Oh, goodness, no! Adventures are dreadful things that make one late for dinner.", "a")
			dialogue.helper("Actually, I was hoping to enroll for classes.", "b")
			dialogue.helper("Yes, I'm an adventurer. Is there anything I can do to help you?", "c")
			local ans = dialogue.answer()
			if ans == "a" then
				dialogue.store_hack(15)
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("Oh, I'm sorry. My mistake. Please accept my apologies. I only hope I'll be able to keep my studio open after this catastrophe.\n")
				dialogue.conclude()
			elseif ans == "b" then
				dialogue.store_hack(15)
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("Oh. I'd love to take you but I'm afraid I have a bit of a problem right now, and all classes are postponed until it has been resolved. Please come back again another time.\n")
				dialogue.conclude()
			elseif ans == "c" then
				dialogue.store_hack(15)
				term.text_out(color.LIGHT_BLUE, "\nSakura: ")
				term.text_out("Oh, how wonderful! I've a terrible problem! My dancer for the part of 'King Mouse' has gone completely insane! It's horrible! It happened during our final dress rehearsal before opening night. During his battle with the Nutcracker, when Clara threw her shoe she well, missed...sort of. Instead of hitting him in the head, in landed on the ground nearby, and he slipped on it and hit his head! When he came up he was frothing at the mouse and babbling nonsense. He ran out of the room and several of the boy and girl dancer mice followed right after him! That's exactly what they were choreographed to do, of course, but now a dozen children are missing, and parents are really starting to worry. Please, would you find them and bring them back? I'm ruined if they can't be found!\n\n")
				dialogue.conclude()
				change_quest_status(QUEST_BALLET_PRE, QUEST_STATUS_TAKEN)
			end
		elseif ans == "c" then
			dialogue.store_hack(15)
			term.text_out(color.LIGHT_BLUE, "\nSakura: ")
			term.text_out("...I...umm, steam?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes. Lots of it.\n\n")
			term.text_out(color.LIGHT_BLUE, "\nSakura: ")
			term.text_out("...I don't know...I'm not very mechanically inclined. I just teach dance and theater here with the troupe. I mean, the school. Maybe it's the tenants next door?\n\n")
			dialogue.conclude()
		end 
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
end
function dialogue.CQ_BALLET()
	term.gotoxy(0, 0)
	term.text_out(color.LIGHT_BLUE, "\nSakura: ")
	term.text_out("Wow, " .. player_name() .. ", I'm really impressed with how quickly you've progressed!\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("Thank you.\n")
	term.text_out(color.LIGHT_BLUE, "\nSakura: ")
	term.text_out("I think it's time to let you in on the secret of our school.\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("...there's a secret?\n")
	term.text_out(color.LIGHT_BLUE, "\nSakura: ")
	term.text_out("Yes. A very terrible secret.\n")
	dialogue.conclude()
	term.save()
	term.load()
	if player.get_sex() == "Female" then
	else
	end
	dialogue.conclude()
end
function dialogue.MARKSMANSHIP()
	term.gotoxy(0, 0)
	if dball_data.p_class == "Wannabe" then
		message("If you want to learn to shoot, this is the place.")
	elseif enrollments[FLAG_BALLET] >  0 then
		term.text_out(color.LIGHT_BLUE, "\nCharleton: ")
		if player.get_sex() ~= "Female" then
			term.text_out("What are you, some kind of fruit or something? Get out of my shop before I throw you out!\n\n")
		else
			term.text_out("Well, hello little lady. Come to see some real men in action?\n\n")
		end
		dialogue.conclude()
	-- else carrying bear?
	elseif enrollments[FLAG_MARKSMANSHIP] == 0 then
		term.text_out(color.LIGHT_BLUE, "\nCharleton: ")
		term.text_out("You're wastin' your time with those fighting classes. No punch in the world can match a dozen rounds in the forehead.\n\n")
		dialogue.conclude()
	else
		message("Hey. Good to see you.")
	end
end
function dialogue.CQ_MARKSMANSHIP()
	term.gotoxy(0, 0)
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nCharleton: ")
	term.text_out(color.YELLOW, "(Quest completion not implemented)")
	term.text_out("Hey, " .. player_name() .. "! I sure would like to have a nice bearskin rug for my shop here at the range. I'd go and bag a bear myself, but I gotta stay and watch the shop. You're getting to be a good shot. How'd you like to hunt down a bear and drag her back for me to skin?\n\n")
	if quest(QUEST_BEAR_THIEF).status == QUEST_STATUS_TAKEN then
		dialogue.helper("I'd be delighted. In fact, I know just the bear.", "a")
	else
		dialogue.helper("Ok. I'll bring back a bear for you.", "a")
	end
	dialogue.helper("No, bears are cuddly and cute. I wouldn't want to kill one.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_TAXIDERMY)
	elseif ans == "b" then
	end
end

function dialogue.SUMO()
	term.gotoxy(0, 0)
	if dball_data.fled_sumo == 1 then
		message("You again? No reason to run like that. It was just a friendly match.")
	elseif quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_TAKEN then
		message("The Judo school is right next door. You can't miss it.")
		message("Please don't hurt Yawara.")
	elseif quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nHonda: ")
		term.text_out("You convinced her to duel? Excellent! It's a pity she's decided to close her school to train in the mountains, but the path of martial prowess is not always an easy one. I'll miss her. Still, with her school gone, I bet all her students will come over here. I'll be able to afford better training tools, and I'm sure the quality of training here will improve considerably.\n\n")
		dialogue.conclude()
		trainer[FLAG_SUMO] = 1
		change_quest_status(QUEST_CHALLENGE_JUDO, QUEST_STATUS_FINISHED)
		dball.cqcq_check()
	elseif quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_FAILED then
		term.text_out(color.LIGHT_BLUE, "\nHonda: ")
		term.text_out("I'm happy that you were able to convince her to duel, but honestly it never occurred to me that you might not win it.\n\n")
	elseif quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_FINISHED then
		message("Hey! Great to see you again!")
	elseif quest(QUEST_CHALLENGE_JUDO).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("We welcome new students. Even ones as small as you.")
		elseif enrollments[FLAG_SUMO] == 0 then
			message("You've studied before? That's good. It will save us training time")
			message("when it comes to learning basics.")
		else
			message("Hello.")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
	return
end
function dialogue.CQ_SUMO()
	term.gotoxy(0, 0)
	dball_data.yawara_wt = 1	-- She can't participate in the Tourny if her wrist in broken
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nHonda: ")
	if race_info_idx(RACE_YAWARA, 0).max_num == 0 then
		term.text_out("I'm thrilled with your progress! You've really managed to put on some decent weight! That will help you tremendously in your fights. You have no idea how important that can be. Take Yawara, for instance. She was the instructor at the Judo school. Nice girl, kind heart, and a strong spirit! I really miss her. Unfortuantely she was a bit on the slender side, and some big, mean nasty scumbag took advantage of that, and went and killed her in a fight. I sure do wish I could lay my hands on that guy, whomever he was.\n\n")
		dialogue.conclude()
	else
		term.text_out("I'm thrilled with your progress! You've really managed to put on some decent weight! That will help you tremendously in your fights. Still though, take someone like me...I still have a good 200 pounds on you. No matter how skilled you are, it's always going to be tough to overcome s bigger fighter. Take the girl next door, for instance, Yawara. We had a friendly match about a week ago, and she tried some sort of new technique she's been working on, and it just didn't work. I think I understand the principal she was working from, but she's just too small to move someone as big as me. Anyway, I didn't want to embarass her, so I fought her as if she were a real opponent, and unfortunately she got hurt. It was very embarassing all around. Anyway, she's been sulking and hasn't gone into the ring since. It's unhealthy. She's a fiery-spirited girl, and she really needs to get over it. Our schools have often competed with one another, but now it's all very awkward. I wonder if you might do us both a favor, and go challenge her to a friendly match? You're new, so she wouldn't associate you with me. She might accept, and, win or lose, it would be healthy for her to fight again.\n\n")
		dialogue.helper("Yes, I can appreciate the situation. I'll do what I can.", "a")
		dialogue.helper("Beat up on a little girl? No, thanks.", "b")
		local ans = dialogue.answer()
		if ans == "a" then
			acquire_quest(QUEST_CHALLENGE_JUDO)
		elseif ans == "b" then
		end
	end
end

function dialogue.JUDO()
	term.gotoxy(0, 0)
	if dball_data.fled_judo == 1 then
		message("Yawara smiles and says 'Hello!'")
	elseif dball_data.fled_sumo == 2 then -- left/removed from ring
		message("It's really a shame you lost to Honda.")
	elseif quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_TAKEN then
		message("Honda's sumo school is right next door. It's really not a big")
		message("deal, though. Why don't we all just let it go?")
	elseif quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_COMPLETED then
		term.text_out(color.LIGHT_BLUE, "\nYawara: ")
		term.text_out("So you really defeated Honda, huh? That's impressive. You know, I really didn't have anything against him personally. Apparantly he's feeling awfully humiliated about having been defeated by one of my students, though, and he's decided to close his school so he can dedicate himself full time to his training. It's not how I planned things, but I have to admit it will be good for us. Honda's school gave us a lot of competition, and now that they're gone, I'm sure our school will do much better.\n\n")
		dialogue.conclude()
		trainer[FLAG_JUDO] = 1
		quest(QUEST_CHALLENGE_SUMO).status = QUEST_STATUS_FINISHED
	elseif quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_FINISHED then
		message("Hey! Great to see you again!")
	elseif quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_UNTAKEN then
		if dball_data.p_class == "Wannabe" then
			message("Welcome! Here to study Judo?")
		elseif enrollments[FLAG_JUDO] == 0 then
			message("I can tell you've studied before. You look good.")
--[[
			if race_info_idx(RACE_HONDA, 0).max_num < 1 then
				term.text_out(color.LIGHT_BLUE, "\nYawara: ")
				term.text_out("You've really been a wonderful student! You know, I think I'm going to confide in you about something that's been bothering me. The instructor of the Sumo school that used to be across the street, Honda. He and I were really good friends. We used to spar all the time, but some mean and bad person went and killed him! It's...I...<sniff> It's difficult. <cry> I really miss him. <sigh> I'm sorry. I really shouldn't be burdening you with this, I just...needed someone to talk to. Thank you for listening.\n\n")
				dialogue.conclude()
			end
]]
		else
			message("Hello!")
		end
	else
		message("Error: quest status in actions.lua is a type I'm not using")
	end
	return
end
function dialogue.CQ_JUDO()
	term.gotoxy(0, 0)
	dball_data.yawara_wt = 1	-- She can't participate in the Tourny if her wrist in broken
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nYawara: ")
	term.text_out("You've really been a wonderful student! You know, I think I'm going to confide in you about something that's been bothering me. I've always wanted to participate in the World Tournament, and over the past year I've developed a special technique to help me win! Unfortunately last week I had what was supposed to be a friendly match with Honda, the sumo instructor next door. He took it a little too seriously, and threw me to the floor hard enough that I broke my wrist. It will heal, but not in time for the Tournament. These things happen, I know...but ever since he's been parading around town telling everyone what a helpless girl I am. I can't help but wonder if the 'accident' was intentional. Anyway, I think I'm over it...mostly, but sometimes I think maybe it would be best if someone would remind Honda that he makes mistakes too. Still, though...I guess it's really not that important. He did beat me, after all, so maybe I should just get over it.\n\n")
	dialogue.helper("No...I think someone should really go teach him some manners.", "a")
	dialogue.helper("Yes, you're right. It's not such a big deal.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		acquire_quest(QUEST_CHALLENGE_SUMO)
	elseif ans == "b" then
	end
end

-- Nice little text for once the character school build has been finalized
-- (Player is either a student of, or has closed, all eight of the schools)
function dialogue.BUILD_FINALIZED()
	term.save()
	term.text_out(color.LIGHT_GREEN, "Congratulations!\n")
	term.text_out("Through much patience and diligent training you have finalized your personal style of martial arts, and destroyed the schools of all unworthy pratitioners. You have settled on your basics. There may still be some room for growth at this level, but to advance much further than your current level you will need to seek out highly specialized masters, capable of taking your power to the next level.\n\n")
	dialogue.conclude()
	term.load()
	change_quest_status(QUEST_DOJO_DESTROYER, QUEST_STATUS_FINISHED)
end

function dialogue.MUSASHI()
	term.save()
	dialogue.prep()

	-- State: 0=he's not talking to you
	--        1=he's talking to you
	--        2=he's accepted you as a student
	--        3=attack on sight

	if dball_data.musashi_state == 0 or dball_data.musashi_state == 1 then
		if dball_data.musashi_state == 0 then
			term.text_out("You see an old, balding Japanese swordsman sitting in seiza. He is wearing a sword on either side of his waist, one short and one long, with the handles crossed in front of his stomahce. \n\n")
		else
			term.text_out("You have returned once again to the meditative retreat of Miyamoto Musashi. \n\n")
		end
		term.text_out("His eyes are closed, and he is clearly in a deep, meditative state.\n\n")
		dialogue.helper("Wait.", "a")
		dialogue.helper("Wake him.", "b")
		dialogue.helper("Kill him while he's helpless.", "c")
		local ans = dialogue.answer()
		term.load()
		term.save()
		dialogue.prep()
		if ans == "a" then
			term.text_out("Time passes.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			term.text_out("In the fraction of an instant after opening your mouth, but before any sound comes out, his eyes suddenly open. For about two seconds he looks you over, examining your body language.\n\n")
			if skill(SKILL_WEAPONS).value < 40000 then
				term.text_out("Apparantly his conclusion is that you are not yet skilled enough even to bother speaking to: he closes his eyes without saying a word, and resumes his meditation.\n\n")
				dialogue.conclude()
				term.load()
			else
				term.text_out(color.LIGHT_BLUE, "Musashi: ")
				if dball_data.musashi_state == 0 then
					term.text_out("Your posture is weak, and lacks discipline. I see no strength in your eyes. You appear worthless as a fighter. Why are you here?\n\n")
				else
					term.text_out("You again?\n\n")
				end
				if dball_data.musashi_state == 0 then
					dialogue.helper("Just exploring. Sorry to bother you.", "a")
				end
				dialogue.helper("I would like to train with you.", "b")
				dialogue.helper("I have come to challenge you to a duel.", "c")
				ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					term.text_out("He shrugs, closes his eyes without a further word, and resumes his meditation.\n\n")
					dialogue.conclude()
					term.load()
					dball_data.musashi_state = 1
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Musashi: ")
					if dball_data.musashi_state == 0 then
						term.text_out("And I would like to acheive enlightenment. Yet, I have been sitting here in this cave for ten years, attempting it. Perhaps I shall make you wait ten years before I train you?\n\n")
					else
						term.text_out("It has not been ten years. Why have you come?\n\n")
					end
					dialogue.helper("Ok. I'll come back in ten years.", "a")
					dialogue.helper("I would prefer not to wait that long.", "b")
					if dball.persuade(17) then
						dialogue.helper("(Persuade 17) You have sat here for ten years, and not gained enlightenment. Do you really wish to sit here for twenty, and not gain enlightenment?", "c")
					end
					ans = dialogue.answer()
					term.load()
					term.save()
					if ans == "a" then
						dball_data.musashi_state = 1
						term.load()
					elseif ans == "b" then
						dball_data.musashi_state = 1
						term.text_out(color.LIGHT_BLUE, "Musashi: ")
						term.text_out("Nor would I.\n\n")
						dialogue.conclude()
						term.load()
					elseif ans == "c" then
						dball_data.musashi_state = 2
						term.text_out("Musashi considers that for a moment.\n\n")
						term.text_out(color.LIGHT_BLUE, "Musashi: ")
						term.text_out("Very well. I will train you.\n\n")
						dialogue.conclude()
						term.load()
						dball.enroll(FLAG_ENROLL_MUSASHI)
					end
				elseif ans == "c" then
					term.text_out("He shrugs, with a bored expression on his face.\n\n")
					term.text_out(color.LIGHT_BLUE, "Musashi: ")
					term.text_out("Very well.\n\n")
					dialogue.conclude()
					term.load()
					dialogue.MUSASHI_DUEL()
				end
			end
		elseif ans == "c" then
			dialogue.MUSASHI_DUEL()
			term.text_out("Sensing your intent, Musashi is on his feet in an instant, with both swords drawn and a look of sheer boredom on his face.\n\n")
			dialogue.conclude()
			term.load()
		end
	elseif dball_data.musashi_state == 2 then
		term.text_out(color.LIGHT_BLUE, "Musashi: ")
		term.text_out("You have returned.\n\n")
		dialogue.helper("I wish to train.", "a")
		dialogue.helper("It is time for the student to surpass the teacher. I have come to challenge you.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			dball.enroll(FLAG_ENROLL_MUSASHI)
		elseif ans == "b" then
			term.save()
			term.text_out("He nods.\n\n")
			term.text_out(color.LIGHT_BLUE, "Musashi: ")
			term.text_out("Very well. Perhaps I shall finally acheive enlightenment.\n\n")
			dialogue.conclude()
			term.load()
			dialogue.MUSASHI_DUEL()
		end
	elseif dball_data.musashi_state == 3 then
		message("Musashi ignores your words")
	end
end

-- Musashi attack helper
function dialogue.MUSASHI_DUEL()
	dball_data.musashi_state = 3
	for_each_monster(function(m_idx, monst)
		if monst.r_idx == RACE_MUSASHI then
			monst.faction=FACTION_DUNGEON
			monst.flags[FLAG_PERMANENT]=true
		end
	end)
end

-- Demon Comic Dialogue
-- dball_data.demon_comic_dialogue MUST be assigned before coming here!
function dialogue.DCD()
	term.blank_print("", 0, 0) -- To place the cursor
	if dball_data.demon_comic_dialogue == 1 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Oh, look. Another live one.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("Yeah. How long do you think " .. gendernouns.heshe .. "'ll last?\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Hmm. 1000 zeni says " .. gendernouns.heshe .. " makes ten seconds.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("Heh. Ten seconds? You're on.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.demon_comic_dialogue == 2 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Oh, look. Another live one.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("You'd really think they'd learn after a while.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Nahh...adventurers usually aren't all that bright. They tend to focus their points in speed and constitution. Not so much in intelligence.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("True.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.demon_comic_dialogue == 3 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("Hey, look Goz! It's another one! What are we going to do with all these people?\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("I don't know. Hell was really built for people who are still alive. Maybe we should open some tourist attractions?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("That's a great idea! We could make a killing.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Heh. A 'killing.'\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.demon_comic_dialogue == 4 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("Aaaggghhh!!! Watch out!\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Hey! You idiot adventurer! You almost landed on me!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("Wow! That one came out on nowhere! I never knew Hell could be so dangerous!\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.demon_comic_dialogue == 5 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Hey, look! Another one!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez ")
		term.text_out("Yeah, I think those brochures we put out are really working.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz ")
		term.text_out("Yeah, it really pays to advertise!\n\n")
		dialogue.conclude()
		term.load()
	else
		-- None. Dialogue has already happened once this game
	end
end
function dialogue.DCD_POST_DEATH()
	if dball_data.alive == 0 then
		-- if comic dialogue is zero, then not in Hell, do nothing
		if dball_data.demon_comic_dialogue == 1 then
			message("Goz says 'Ha! that was only " .. dball_data.steps_in_hell .. " seconds! Pay up!'")
		elseif dball_data.demon_comic_dialogue == 2 then
			message("Goz says 'Ahh, well, " .. gendernouns.heshe .. " died, so at least the gene pool has improved.'")
		elseif dball_data.demon_comic_dialogue == 3 then
			message("Goz says 'Well, if they lived long enough to pay for them, anyway.'")
		elseif dball_data.demon_comic_dialogue == 4 then
			message("Goz says 'No kidding.'")
		end
	end
end

-- The WT EMT
function dialogue.WT_MEDIC()
	local how_hurt = (100 * player.chp()) / player.mhp()
	term.save()

	-- Deal with winners and flyers
	if dball_data.tourny_now ~= 0 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Get out there and fight! I want blood! GIMMEE BLOOD!!!\n\n")
		dialogue.conclude()
		term.load()
		return false
	end

	if dball_data.alive ~= 0 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Well, that's disappointing. You're dead, but where's the gore? No gushing blood...no look of horror on your face...no intestines trailing on the ground behind you. I mean, I guess it's cool that you're dead, and stuff, but seriously, I expected more.\n\n")
		dialogue.conclude()
		term.load()
		return
	end

	if how_hurt < 5 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Wow! That's a ten. Definitely. Yep. You want some fries with that hamburger meat? Hey...speaking of hamburger meat, have you seen that PETA video where they show what goes on in slaughterhouses? No? Wow...you've gotta see it!\n\n")
		if player.get_sex() ~= "Female" then
			term.text_out("Her eyelids lower, seductively...and she speaks in a soft voice:\n\n")
			term.text_out(color.LIGHT_RED, "EMT: ")
			term.text_out("I have it on DVD. You know...if you're not doing anything later, we could go back to my place and watch it. It makes a really good first date movie.\n\n")
		end
	elseif how_hurt < 10 then
		term.text_out("The EMT pats you on the back encouragingly.\n\n")
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Hey, I'm impressed! That was a great fight! Still...it's tough for a tourny fight like this on padded mats to compete with some of the stuff I see in the field. Like that guy who took a shotgun blast to the testicles at close range. Then there was the time that couple left their two-month-old on the kitchen stove overnight. Yeah, that one was a mess. Still, you're doing good out there. Keep it up!\n\n")
	elseif how_hurt < 20 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Whoa....cool! I haven't seen an arm bent backwards at quite that angle in...wow...at least a couple days.\n\n")
	elseif how_hurt < 30 then
		term.text_out("The EMT looks over you approvingly.\n\n")
		term.text_out(color.LIGHT_RED, "EMT: ")
		if player.get_sex() ~= "Female" then
			term.text_out("You look good like that. Hey, are you seeing anyone? You got anything going on later?\n\n")
		else
			term.text_out("Oh...I really love how that looks on you. Yeah, no eye shadow can compare to a good case of head trauma.\n\n")
		end
	elseif how_hurt < 40 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Whoa...cool! Did you break anything?\n\n")
	elseif how_hurt < 50 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Groovy. I love a little bloodshed. You don't mind if I take some home with me, do you? You've got plenty.\n\n")
	elseif how_hurt < 60 then
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Groovy. I love a little bloodshed. You don't mind if I take a few pictures do you?\n\n")
	elseif how_hurt < 70 then
		term.text_out("The EMT nods approvingly.\n\n")
		term.text_out(color.LIGHT_RED, "EMT: ")
		term.text_out("Yeah...that's not bad. Next time, though, try not to spend so much time standing upright. You could probably double your blunt trauma if you were to just get knocked to the ground a few times.\n\n")
	elseif how_hurt < 80 then
		if player.get_sex() ~= "Female" then
			term.text_out("The EMT smiles seductively at you.\n\n")
			term.text_out(color.LIGHT_RED, "EMT: ")
			term.text_out("Mmm....I like it rough. Fights like this are like foreplay. They turn me on.\n\n")
		else
			term.text_out("The EMT smiles at you, then looks at the ground, as if recalling a cherished memory.\n\n")
			term.text_out(color.LIGHT_RED, "EMT: ")
			term.text_out("You know, that fight kind of reminded me of my ex-boyfriend. Ahh...how I miss him.\n\n")
		end
	else
		term.text_out(color.LIGHT_RED, "EMT: ")
		if dball_data.tourny_registered > 1 then
			term.text_out("Pity you're not in the Tournament anymore. You're just not as interesting when you're all in one piece like this.\n\n")
		else
			term.text_out("What? You're not hurt. Oh, come on...you don't really want me to bother fixing that, do you? It's just a scratch. Yeah...ok, so you're dripping blood on the floor. What's the big deal? Oh, allright, I'll patch you up, you big sissy.\n\n")
		end
	end
	dialogue.conclude()
	term.load()

	dball.cure_cond()
	counter.state(counter.LIFE, "silent", true)
	player.chp(player.mhp())
	player.redraw[FLAG_PR_BASIC] = true

end


-- World Tournament handler
function dialogue.WT_BACKSTAGE()
	local intro, m_name, r_flag
	if dball_data.alive ~= 0 then
		message("Aaaaaaggghhhh! A ghost!")
	elseif dball_data.tourny_registered == 0 then
		message("Hey! How'd you get back here? You're not on my list. Go away!")
		elseif dball_data.tourny_registered == 2 then
		message("Too bad. I really thought you had a chance to win. Maybe next year.")
	elseif dball_data.tourny_registered == 3 then
		message("Your fighting's not bad, but stay in the ring next time.")
	elseif dball_data.tourny_registered == 4 then
		message("What were you thinking? Didn't you read the brochure the ticket girl gave you?")
	else
		-- Get an opponent
		intro, m_name, r_flag = dball.get_tourny_fighter()
		-- Have we already won the Tournament?
		if intro == "victory" then
			message(color.YELLOW, "Congratutions!")
			return
		end

		-- Are we bumping a freebie round?
		if intro == "autobump" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "\nThe Backstage Organizer: ")
			term.text_out("Whoops. Looks like we have a no-show. I wonder why anyone would register and not show up? Well, that's good for you, at least. It means you automatically advance to the next round. Just give me a moment to file the results and I'll see who your next opponent will be.\n\n")
			dball_data.tourny_round = dball_data.tourny_round + 1
			dialogue.conclude()
			term.load()
			return
		elseif intro == "bump" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "\nThe Backstage Organizer: ")
			term.text_out("Whoops. That's strange. I have a note here that " .. m_name .. " is a no-show. I wonder why anyone would register and not show up? Well, that's good for you, at least. It means you automatically advance to the next round. Just give me a moment to file the results and I'll see who your next opponent will be.\n\n")
			dball_data.tourny_round = dball_data.tourny_round + 1
			dialogue.conclude()
			term.load()
			return
		end

		-- Nope! All is well. Offer the match!
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nThe Backstage Organizer: ")
		term.text_out(intro .. "\n\nAre you ready?\n\n")
		if dball_data.tourny_type_of_fight == 1 then	-- Fight is to the death
			dialogue.helper("...yes.", "a")
		else
			dialogue.helper("Yes.", "a")
			dialogue.helper("Not quite yet.", "b")
		end
		local ans = dialogue.answer()
		term.load()

		if ans == "a" then
			-- To allow uniques on save levels to appear
			if race_info_idx(r_flag, 0).max_num == 1 then
				race_info_idx(r_flag, 0).max_num = 2
			end
			
			local place_midx = dball.place_monster(13, 26, m_name)

			if place_midx and place_midx > 0 then
				dueling = 1 -- No party members!
				local monst = monster(place_midx)
				monst.faction = FACTION_DUEL
				if has_flag(monst, FLAG_DBT_AI) then
					monst.ai = monst.flags[FLAG_DBT_AI]
				end
				monst.flags[FLAG_KILLED_VERB] = "defeated"

				cave_set_feat(20, 10, FEAT_PERMA_WALL)
				dball_data.tourny_now = 1
				teleport_player_to(13, 18)
				message(color.YELLOW, "Good luck!")
				if dball_data.tourny_round > 5 then sound.play_sample("gong") end
			else
				-- message("Error in Tourny selection: See WT Backstage Dialogue")
				dialogue.quickie("Error in Tourny selection! Most likely your next opponent already exists on a SAVE_LEVEL someplace, and so the engine is not allowing me to summon him here. Which is a bit annoying since I've specified max_num = 2, so you'd think that it would allow there to be another one. In any case, I'm going to try to resolve the problem by auto-bumping you to the next round. Hopefully that will resolve the problem. Sorry for the inconvenience.")
				dball_data.tourny_current_opponent = FLAG_AUTO_BUMP
				if dball_data.tourny_round > 18 then
					dialogue.WT_WINNER()
				end

			end
		elseif ans == "b" then
			message("No worries. Lots of participants, so plenty of time. Let me know when you're ready.")
		end
	end
end

function dialogue.WT_WINNER()
	term.save()
	term.clear()
	term.drop_text_left(color.YELLOW, " C O N G R A T U L A T I O N S ! ! ! ", 1, 0)
	term.text_out(color.LIGHT_BLUE, "\n\nThe ")
	term.text_out("journey has been long and harrowing, but at long last you have fulfilled your childhood dream! You have won the World Tournament, and proven yourself to be the strongest, most skilled fighter on the entire planet!\n\n")
	term.text_out(color.LIGHT_BLUE, "The ")
	term.text_out("applause and cheers continue unabated for quite some time, and you cherish each moment of it. A pair of ")
	if player.get_sex() == "Female" then
		term.text_out("sexy young studs")
	else
		term.text_out("beautiful young girls")
	end
	term.text_out(" present you with the most magnificent trophy you have ever seen. Inside it you find the prize money for winning the tournament: one hundred thousand zeni.\n\n")

	-- Implement Cell Games, too...

	-- Now what?
	if dball_data.android_quest_status == 2 then
		term.text_out(color.LIGHT_BLUE, "The ")
		term.text_out("audience cries as you raise the trophy triumphantly aloft! It is a proud, and glorious moment. You revel in it gleefully, content for this moment to endure forever. And yet, it is not to be. After a scant few minutes a ripple of sound begins to work through the crowd. People are talking...murmuring to one another. And it is catching. It doesn't take long for you to figure out what is being said. And then all at once the crowd is chanting in unison...chanting words that make your spine tingle:\n\n")
		term.text_out("...kill...the...an...droids...\n...kill...the...an...droids...\n...kill...the...and...roids...\n\n")
		term.text_out("Over, and over...and over. It seems clear that as the worlds greatest fighter, the task falls on you to save the world.\n\n")
	elseif quest(QUEST_FREEZA).status == QUEST_STATUS_TAKEN then
		term.text_out(color.LIGHT_BLUE, "The ")
		term.text_out("audience cries as you raise the trophy triumphantly aloft! It is a proud, and glorious moment. You revel in it gleefully, content for this moment to endure forever. And yet, it is not to be. After a scant few minutes a ripple of sound begins to work through the crowd. People are talking...murmuring to one another. And it is catching. It doesn't take long for you to figure out what is being said. And then all at once the crowd is chanting in unison...chanting words that make your spine tingle:\n\n")
		term.text_out("...kill...Free...za...\n...kill...Free...za...\n...kill...Free...za...\n\n")
		term.text_out("Over, and over...and over. It seems clear that as the worlds greatest fighter, the task falls on you to save the world.\n\n")
	else
		term.text_out(color.LIGHT_BLUE, "The ")
		term.text_out("audience cries as you raise the trophy triumphantly aloft! It is a proud, glorious moment. And, yet...a dark fear creeps over you as you wonder what the future could possibly hold in store for you. How can the next day to come possibly compete with this moment? The next week? The next year? You have fulfilled your life's greatest ambition...\n\nNow what?\n\n")
	end
	dialogue.conclude()
	term.load()
end

function dialogue.GOZMEZ_PAYUP()
	term.save()
	term.text_out(color.LIGHT_BLUE, "Goz: ")
	term.text_out("YES!!! Ten seconds! Gimmee 1000 zeni!\n\n")
	term.text_out(color.LIGHT_BLUE, "Mez: ")
	term.text_out("Darn it! Stupid human had to live. <sigh>\n\n")
	dialogue.conclude()
	term.load()
	dball_data.demon_comic_dialogue = 999
end

-- Goz and Mez, the Greeter demons of Hell
function dialogue.GOZ_MEZ(whom)
	local whom1, whom2 = " ", " "
	if whom == "Goz" then
		whom1 = "Goz"
		whom2 = "Mez"
	else
		whom1 = "Mez"
		whom2 = "Goz"
	end

	term.save()

	if dball_data.demon_comic_dialogue == 0 or dball_data.demon_comic_dialogue == 999 then
		local which = rng(1,3)
		if which == 1 then
			term.text_out(color.LIGHT_BLUE, whom1 .. ": ")
			term.text_out("Hey, " .. player_name() .. "! What's up?\n\n")
			term.text_out(color.LIGHT_BLUE, whom2 .. ": ")
			term.text_out("Yeah, what can we do for ya?\n\n")
		elseif which == 2 then
			term.text_out(color.LIGHT_BLUE, whom2 .. ": ")
			term.text_out("Hello again. \n\n")
			term.text_out(color.LIGHT_BLUE, whom1 .. ": ")
			term.text_out("Wow, " .. player_name() .. " again? " .. gendernouns.heshe .. " must really like us.\n\n")
			term.text_out(color.LIGHT_BLUE, whom2 .. ": ")
			term.text_out("Awww....how sweet! I'm touched. :)\n\n")
		else
			term.text_out(color.LIGHT_BLUE, whom1 .. ": ")
			term.text_out("Welcome to Hell!\n\n")
			term.text_out(color.LIGHT_BLUE, whom2 .. ": ")
			term.text_out("No, Goz..." .. gendernouns.heshe .. "'s been here before.\n\n")
			term.text_out(color.LIGHT_BLUE, whom1 .. ": ")
			term.text_out("Yeah...I remember. but I like saying it, you know?\n\n")
			term.text_out(color.LIGHT_BLUE, whom2 .. ": ")
			term.text_out("Oh. Well, in that case, feel free.\n\n")
			term.text_out(color.LIGHT_BLUE, whom1 .. ": ")
			term.text_out("Really? Ok!\n\n")
			term.text_out("(" .. whom1 .. " clears his throat)\n\n")
			term.text_out(color.LIGHT_BLUE, whom1 .. ": ")
			term.text_out("Welcome to Hell!\n\n")
		end

	elseif dball_data.demon_comic_dialogue == 1 then
		dball_data.gozmez_done_dcd = 1
		if whom1 == "Goz" then
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Come on! You can make it! I've got 1000 zeni riding on you!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("No! No! No! Only a few more seconds! If you die now, I'll split the money with you!\n\n")
		else
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Die! Die! Hurry up and die! 1000 zeni doesn't just grow on trees!\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Come on! You can make it! I've got 1000 zeni riding on you!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("...not that there are any trees down here anyway.\n\n")
		end
		dialogue.conclude()
		term.load()
		return
	elseif dball_data.demon_comic_dialogue == 2 then
		if whom1 == "Goz" then
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Don't look at me. I just work here.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Don't confuse the poor " .. gendernouns.boygirl .. ", Goz. Remember: 'adventurer.' Not that bright.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Oh...yeah. Sorry.\n\n")
		else
			term.text_out("Mez speaks very slowly, enunciating each word very carefully.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Hi...earth human. Me 'Mez.' Welcome to Hell.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Oh, come now, Mez. They can't be THAT dumb.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Are you kidding? Coming to Hell while still alive?\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Hmm. Well, ok.\n\n")
		end
	elseif dball_data.demon_comic_dialogue == 3 then
		if whom1 == "Goz" then
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Welcome to Hell, best tourist attraction in the Universe!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Well...going to be. Once we build some attractions.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Oh, right. 'Going to be.'\n\n")
		else
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Welcome to Hell, best tourist attraction in the Universe!\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Well...going to be. Once we build some attractions.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Oh, right. 'Going to be.'\n\n")
		end
	elseif dball_data.demon_comic_dialogue == 4 then
		if whom1 == "Goz" then
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("That was really rude!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Yeah! Dropping in unannounced like that. Call ahead next time you almost land on Goz's head.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("...wmm...actually...I don't mind the 'unannounced' part nearly so much as the 'landing on my head' part.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Oh. But it's not rude to land on peoples heads. Just to show up without calling ahead.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Are you sure about that?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Of course! Who ever heard anyone say it's rude to land on somebody's head?\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Hmm. I guess you're right.\n\n")
		else
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("You shold really be more careful where you fall. You almost landed on Goz here.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("I saw my whole life passing right before my eyes!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Yeah, next time be more considerate and land in that pool of lava over there.\n\n")
		end
	elseif dball_data.demon_comic_dialogue == 5 then
		if whom1 == "Goz" then
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("So what brings you to Hell?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("It was the advertising wasn't it! Yes? I knew it! Woohoo! Paid brochures! Wow!\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Hehe...yeah, who'd have figured? Good call, Mez. That was the best 10,000 zeni I ever spent on printing.\n\n")
		else
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("So...here to see the sights?\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Come to bask in the warm glow of Hell?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Maybe get a nice tan?\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Not even Tahiti can compete with a good lava tan!\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("Yep! Best tan of your life!\n\n")
			term.text_out("(He glances at his watch)\n\n")
		end
	elseif dball_data.demon_comic_dialogue == 999 then
		-- Standard 'has already been greeted' dialogue
	else
		-- Fall through?
	end

	dball_data.demon_comic_dialogue = 0

	-- Does this work? DCD should be zero if the player is dead, right?
	if dball.alive == 3 then
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Oooohhhhh! Look at the pretty halo, Goz! It's an angel!\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Why... <sniff> that's the most beautiful thing <sniff> I've ever seen!\n\n")
	elseif dball.alive == 4 then
		-- This is the standard 'died and was evil'
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Heads up, Goz. New recruit.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Hello. Welcome to Hell. \n\n")
	end

	if dball_data.gozmez_done_dcd == 0 then
		dball_data.gozmez_done_dcd = 1
		dialogue.helper("Umm...hello. This is Hell?", "a")
	else
		dialogue.helper("Hey, guys. Nice to see you again.", "b")
		if dball_data.hell_escalator_state == 0 then
			dialogue.helper("Is there any way out of here?", "c")
		elseif dball_data.hell_escalator_state == 1 then
			dialogue.helper("I found an escalator, but it's out of order.", "d")
		end
	end

	local ans = dialogue.answer()
	term.load()
	term.save()
	if ans == "a" then
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Yep! This is Hell! Welcome to Hell!\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Wow! Figured that out all on " .. gendernouns.hisher .. " own! This is a smart one, Mez.\n\n")
		dialogue.conclude()
		term.load()
	elseif ans == "b" then
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Aww... " .. gendernouns.heshe .. " came just to say hi!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("How sweet!\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Can you feel the love?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Why, that brings tears to my eyes.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Oh, come on Mez. You know there's no crying in Hell.\n\n")
		dialogue.conclude()
		term.load()
	elseif ans == "c" then
		term.text_out("Goz and Mez giggle at you.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Heheh...'is there any way out of here.'\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Haha! Yeah. They all ask that.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Ok, human...\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("...yes...\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("...there is a way out...\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("...at least one. Maybe more. In fact, not only is there a way out of Hell...\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("...we even know what it is.\n\n")
		term.text_out("(They smile)\n\n")
		dialogue.conclude()
		term.load()
	elseif ans == "d" then
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Escalator? What escalator?\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("I think " .. gendernouns.heshe .. " means the service escalator.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Oh. That escalator.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("But it doesn't work.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("Yes, it does. It's just been disabled.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Oh. Stupid game. You'd think something important like that should be made available.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("No, I don't mean that kind of disabled.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Oh. You mean it's disabled, as in, it gets free parking and stuff?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("No, it's disabled as in, it's just turned off.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Yeah, I bet it's pretty difficult to turn on an escalator. Is it a girl or boy escalator?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("I'm not sure. I've never checked.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Me neither.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("I bet we could turn it on though.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("How?\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("By pressing the 'on' button.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("Oh. Yeah, that might work. But do we really WANT to do that?\n\n")
		term.text_out("They look at you. Then each other. Then back at you. And smile.\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("...tell you what...\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("...we'll make you a deal...\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("...if you can beat us at a game...\n\n")
		term.text_out(color.LIGHT_BLUE, "Mez: ")
		term.text_out("...any game...\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz: ")
		term.text_out("...of our choosing...\n\n")
		term.text_out(color.LIGHT_BLUE, "Goz and Mez together: ")
		term.text_out("...we'll turn on the escalator for you.\n\n")
		dialogue.helper("Ok. What game?", "a")
		dialogue.helper("Hmm. No, I think I'll keep looking for other ways out on my own.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Goz and Mez together: ")
			term.text_out("Rock Paper Scissors!!!!\n\n")
			term.text_out("They look at you evilly.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz: ")
			term.text_out("Here's how it works. Two of us each secretly pick one: rock, paper or scissors, and then reveal our choice to the other simultaneously.\n\nRock beats scissors\nScissors beat paper\nPaper beats rock\n\n")
			term.text_out(color.LIGHT_BLUE, "Mez: ")
			term.text_out("You'll have to play us both, and win both times.\n\n")
			term.text_out(color.LIGHT_BLUE, "Goz and Mez together: ")
			term.text_out("Are you in?\n\n")
			dialogue.helper("Sure.", "a")
			dialogue.helper("No, I'm not that desperate yet. Thanks anyway.", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("Haha! Poor fool. We never lose!\n\n")
				term.text_out(color.LIGHT_BLUE, "Goz: ")
				term.text_out("I'm up first! Ok, here we go! 1...2...3...GO!!!\n\n")
				dialogue.helper("Rock", "a")
				dialogue.helper("Paper", "b")
				dialogue.helper("Scissors", "c")
				local ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Goz: ")
					term.text_out("Hahaha!!! I chose Scissors! I win!!!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mez: ")
					term.text_out("...umm.\n\n")
					term.text_out(color.LIGHT_BLUE, "Goz: ")
					term.text_out("I'm am so great! I am so neat! I'm incredible! Yay for me!!!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mez: ")
					term.text_out("Goz...? Rock beats scissors.\n\n")
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Goz: ")
					term.text_out("Hahaha!!! I chose Rock! I win!!!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mez: ")
					term.text_out("...umm.\n\n")
					term.text_out(color.LIGHT_BLUE, "Goz: ")
					term.text_out("I'm am so great! I am so neat! I'm incredible! Yay for me!!!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mez: ")
					term.text_out("Goz...? Paper beats rock.\n\n")
				elseif ans == "c" then
					term.text_out(color.LIGHT_BLUE, "Goz: ")
					term.text_out("Hahaha!!! I chose Paper! I win!!!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mez: ")
					term.text_out("...umm.\n\n")
					term.text_out(color.LIGHT_BLUE, "Goz: ")
					term.text_out("I'm am so great! I am so neat! I'm incredible! Yay for me!!!\n\n")
					term.text_out(color.LIGHT_BLUE, "Mez: ")
					term.text_out("Goz...? Scissors beat paper.\n\n")
				end
				term.text_out(color.LIGHT_BLUE, "Goz: ")
				term.text_out("Hahah...huh? Oh. " .. gendernouns.heshe .. " won? That's weird. That's not supposed to happen. Hmm.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("Ehhh...must have been luck. But don't worry, " .. gendernouns.heshe .. "'ll never beat ME!!! Ready? 1...2...3...GO!!!\n\n")
				dialogue.helper("Rock", "a")
				dialogue.helper("Paper", "b")
				dialogue.helper("Scissors", "c")
				local ans = dialogue.answer()
				term.load()
				term.save()
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("What?!!?!? That's impossible! I chose ")
				if ans == "a" then
					term.text_out("scissors!!!\n\n")
				elseif ans == "b" then
					term.text_out("rock!!!\n\n")
				elseif ans == "c" then
					term.text_out("paper!!!\n\n")
				end
				term.text_out(color.LIGHT_BLUE, "Goz: ")
				term.text_out("Hmm. This one must be a mind reader. The odds are only one in four to have beat us both like that.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("Well, that's not impossible. Just got lucky, is all. <shrug>\n\n")
				term.text_out(color.LIGHT_BLUE, "Goz: ")
				term.text_out("Guess we have to enable the escalator, then?\n\n")
				term.text_out("Mez pulls out a small handheld device and presses a button on it.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("There you go. The escalator should be working now. No idea where it goes, though.\n\n")
				term.text_out(color.LIGHT_BLUE, "Goz: ")
				term.text_out("Yeah, could be someplace worse than here. You might want to just stick around with us.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("Yeah! We could play rock-paper-scissors some more!\n\n")
				term.text_out(color.LIGHT_BLUE, "Goz: ")
				term.text_out("Yeah! And when we rock you this time, ")
				term.text_out(color.YELLOW, "we won't even make you pay-per the scissors!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mez: ")
				term.text_out("Heheh...that's a real funny joke, Goz! Hey..." .. player_name() .. ", where are you going?\n\n")
				dialogue.conclude()
				jokes[1] = 1
				term.load()
				dball_data.hell_escalator_state = 2
				flag_empty(cave(37, 110).flags)
				cave_set_feat(37, 110, FEAT_HELL_ESCALATOR)

			elseif ans == "b" then
			end
		elseif ans == "b" then
		end
	
	end

end

-- Ox King
function dialogue.OXKING()

	if quest(QUEST_OXKING_DINNER).state == QUEST_STATUS_TAKEN then

	elseif dball_data.chichi_state == 4 then
		-- Post-quest completeion
		term.save()
		term.text_out(color.LIGHT_BLUE, "The Ox King: ")
		term.text_out("Ahhh, " .. player_name() .. ", I'm glad you could join us. Please, help yourself!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Thank you. It's always nice to have a good home cooked meal.")
		term.text_out(color.LIGHT_BLUE, "The Ox King: ")
		term.text_out("Absolutely! Great \n\n")
		dialogue.conclude()
		term.load()
	elseif quest(QUEST_RING_OF_FIRE).status == QUEST_STATUS_FINISHED then
		message("Thanks again! Wildebeast is so yummy!")
		return
	elseif quest(QUEST_RING_OF_FIRE).status == QUEST_STATUS_TAKEN then
		if dball_data.chichi_state == 3 then
			-- Chichi dead
			message("Implement dialogue for: player killed Chichi")
--[[
			term.save()
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("I heard gunshots! What happened?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("There was a crazy woman in your house. She attacked me.")
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("A crazy woman?")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes.")
			dialogue.conclude()
			term.load()
]]
			dball.delete_monster(RACE_OXKING)
			change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_FINISHED)


		elseif dball_data.oxking_drawbridge == 1 and dball_data.chichi_state == 2 then
			-- Lowered drawbridge, Chichi in tow
			dball_data.chichi_state = 3 -- <-- Chichi no longer aggressive
			term.save()
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Welcome back, " .. gendernouns.ladlass .. ".\n\n")
			term.text_out(color.LIGHT_RED, "Chichi: ")
			term.text_out("Be careful, father! " .. gendernouns.heshe .. "'s a pervert!\n\n")
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Hmm?\n\n")
			term.text_out(color.LIGHT_RED, "Chichi: ")
			term.text_out("Stand back! I'll take care of " .. gendernouns.himher .. "!\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Chichi, may I introduce " .. player_name() .. "? I asked " .. gendernouns.himher .. " to rescue us.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Nice to meet you.\n\n")
			term.text_out(color.LIGHT_RED, "Chichi: ")
			term.text_out("RESCUE!?!?!? What are you takling about! " .. gendernouns.heshe .. " walked in on me, NAKED!!!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Umm, yes. Sorry about that. I was hoping you could tell me where the drawbridge lever was.")
			term.text_out(color.LIGHT_RED, "Chichi: ")
			term.text_out("Drawbridge? Rescue? What are you two talking about? Why were you out here all alone, daddy?\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Oh dear...you mean you didn't know about the grease fire?\n\n")
			term.text_out(color.LIGHT_RED, "Chichi: ")
			term.text_out("What grease fire? I was just coming out of the shower when this pervert walked in on me! And he saw me naked! OH!!! I'm so confused!!!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Well, not completely. You were wearing a towel.\n\n")
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("It's ok, dear. I'll explain it all later.\n\n")
			term.text_out("(He turns to you.)\n\n")
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Thank you so much for saving my daughter, myself, and our dinner. Especially for the dinner. Please, would you join us tonight?\n\n")
			dialogue.helper("Yes, of course. I love spit-roasted wildebeast.", "a")
			dialogue.helper("No, I'm sorry. I have...other plans for this evening.", "b")
			local ans = dialogue.answer()
			term.load()

			dball.delete_monster(RACE_OXKING)
			dball.delete_monster(RACE_CHICHI)

			if ans == "a" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "The Ox King: ")
				term.text_out("Excellent! We'll go on ahead. Please join us whenever you're ready.\n\n")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_FINISHED)
				change_quest_status(QUEST_OXKING_DINNER, QUEST_STATUS_TAKEN)
				return
			elseif ans == "b" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "The Ox King: ")
				term.text_out("Ahh, how very sad for you. Well, thank you all the same for your help. Here, let me give you my helmet as a reward. It's not much, but you seem like the type who could make good use of it. Come, Chichi. Dinner awaits!\n\n")
				dialogue.conclude()
				term.load()
				local obj = create_artifact(ART_OX_HELM)
				make_item_fully_identified(obj)
				dball.reward(obj)
				change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_FINISHED)
			end
		elseif dball_data.oxking_drawbridge == 1 then
			-- Lowered drawbridge, no Chichi
			term.save()
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Any luck yet, " .. gendernouns.ladlass .. "?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Yes. I found the lever, and the drawbridge is down.\n\n")
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Oh? How marvelous! Thank you so much for your help! I was positively starving out here. Please feel free to stop by to join us for dinner anytime. NOT IMPLEMENTED\n\n")
			dialogue.conclude()
			term.load()
			dball.delete_monster(RACE_OXKING)
			change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_FINISHED)
			change_quest_status(QUEST_OXKING_DINNER, QUEST_STATUS_TAKEN)
		else
			-- No change
			term.save()
			term.text_out(color.LIGHT_BLUE, "The Ox King: ")
			term.text_out("Any luck yet, " .. gendernouns.ladlass .. "? I hate to rush you...but spit-roasted wildebeast doesn't reheat in the microwave very well.\n\n")
			dialogue.conclude()
			term.load()
		end
		return
	end

	term.save()
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
	term.text_out("Hello, " .. gendernouns.ladlass .. "! I hate to trouble you, but you look like the adventuresome sort. I don't suppose you'd be willing to help out someone with a bit of a problem?\n\n")
	dialogue.helper("Certainly. What can I do for you?", "a")
	dialogue.helper("Maybe. What do you need?", "b")
	dialogue.helper("No, sorry.", "c")
	local ans = dialogue.answer()
	if ans == "a" or ans == "b" then
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
		term.text_out("Well, " .. gendernouns.ladlass .. ", it's like this...I live in that castle up there on Mount Frypan, with my daughter, Chichi. And that's where I'd like to be right now. At the moment I'm down here standing in the cold. I'm dressed for it, at least...but my little girl is up there all alone with a rather large pile of food we've spent the past several days cooking...and I'm not up there with them! It's awful, I tell you!\n\n")
		dialogue.helper("Ok, so go home. What's the problem?", "a")
		local ans = dialogue.answer()
		term.load()
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
		term.text_out("What's the problem!?!?!? All that food up there and me down here not- ...oh. You mean why aren't I up there? Well, there's the rub. You see, when we bought the castle it came pre-installed with some factory options. Moat, portcullis, that sort of thing. Most of it wasn't of any use, but there's a pour-hole in the courtyard that leads to the moat, so you can refill it without having to go out the front gate while you're under siege. At least, that's what I assumed it was for. I wasn't planning on having any sieges, just dinner parties, so I did some minor rennovations, and set it up as a grease drain from the kitchen. Well, that was about six months ago, and I kind of forgot about it, until a few hours ago I stepped outside to smoke a cigar, tossed my match and BOOOM!!!! Six months worth of grease fire erupted all at once around the entire castle! The moat is thirty feet wide, and the flames are ten feet high!\n\n")
		dialogue.helper("Hmm. Ok, but what do you want me to do about it?", "a")
		if player.get_sex() == "Male" then
			dialogue.helper("Uh-huh. Let me see if I have this right: damsel on the mountain behind a ring of fire...you wearing a viking helm and nordic furs...all I need to do to get past the fire is be really brave, right?", "b")
		end
		dialogue.helper("No...sorry, I think you're on your own for this one.", "c")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
			term.text_out("Well, I was thinking if somebody could get inside, all we have to do is lower the drawbridge. It's made of steel, and it covers the distance across the moat, so we could just walk across. I'm sure Chichi has already thought of that, but she's a bit on the skinny side, and I don't think she's strong enough to turn the drawbridge crank. So, all we need to do is figure out a way to get either one of us inside.\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_TAKEN)
		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
			term.text_out("Are you kidding? This isn't some Wagnerian Opera, this is Japanese Anime! There's a world of difference! You can't just charge in their and expect your bravery-to-the-point-of-stupidity to save you just because you're the son of the All Father! No, you'll either have to go find some alternate quest that will provide you a solution which you'll have to decide whether to use now, or save for later...or you'll have to pump your constitution and hit points high enough that you can just walk through the flames. See? Not Wagnerian at all. World of difference.\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_TAKEN)
		elseif ans == "c" then
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
			term.text_out("Wait! Please! I beg you to reconsider! There's a huge feast waiting for us up there...two racks of lamb, roast mutton, a keg of 16 =month old mead, and another filled with ale! The good kind, too, with hearty chunks floating around in it! \n\n")
			dialogue.helper("Hmm. 'Chunky ale.' How can I refuse an offer like that?", "a")
			dialogue.helper("Sorry.", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
				term.text_out("Thank you so much! I was really starting to worry dinner might get cold.")
				dialogue.conclude()
				term.load()
				change_quest_status(QUEST_RING_OF_FIRE, QUEST_STATUS_TAKEN)
			elseif ans == "b" then
				term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
				term.text_out("Well, alright. I suppose that does leave more ale for me. If I can get to it.\n\n")
			end
		end
	elseif ans == "c" then
		term.load()
		term.text_out(color.LIGHT_BLUE, "\nThe Ox King: ")
		term.text_out("Mmm...alright, then. Sorry to trouble you.")
	end

end

function dialogue.BALANCE_GOD()
	term.save()
	term.text_out(color.LIGHT_BLUE, "\nThe God of Game Balance: ")
	term.text_out("Now, now...that was bad! There we were...putting in a cute little joke artifact for your amusement, and then you had to go and start using it abusively. Shame on you!\n\n")
	dialogue.conclude()
	term.load()
end

function dialogue.BURUMA()
	term.save()

	-- If Buruma marries Oolong:
	if dball_data.oolong_married == RACE_BURUMA  then
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Well, look who it isn't. What brings you back? Haven't you caused enough trouble for me?\n\n")
	 	dialogue.helper("So how's married life?","a")
	 	dialogue.helper("How would you like to take some time off and come adventuring with me?","b")
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Terrible! I'm so bored I don't know what to do with myself!\n\n")
			if dball.how_many_exist(RACE_OOLONG) > 0 then
				term.text_out(color.LIGHT_BLUE, "Oolong: ")
				term.text_out("That's ok. I certainly know what to do with yourself.\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Ahhhgghh! Get back! Three times in one day is enough already!\n\n")
			end
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Heh. Well, I just thought I'd stop by to visit. Take care.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Oh! I want to! I can't even begin to tell you how much I want to! But I can't. I'm...pregnant.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wow! Really? You? With...Oolong?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Yes with my husband! What kind of girl do you think I am??!?!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Heh...sorry I asked. Well, good luck with the piglets!\n\n")
			dialogue.conclude()
			term.load()
		end
		return
	elseif dball_data.rosshi_girl == RACE_BURUMA then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out(player_name() .. "! Please tell me you've found the dragonballs and you're here to wish me off this wretched island.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Heh. No such luck. How have you been? How is Rosshi treating you?\n\n")
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Don't even get me started about that horrible old geezer! He can't keep his hands off of me! It's terrible!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("But weren't you looking for the dragonballs in the first place so you could wish for a girlfriend?\n\n")
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("But not like this!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Well, you know what they say. Be careful what you wish for. You may get it.\n\n")
		dialogue.conclude()
		term.load()
		return
	end
	
	-- If Buruma is partied
	if party.is_partied(RACE_BURUMA) > 0 then
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Yes?\n\n")
	 	dialogue.helper("Never mind.","a")
		if  player.stat(A_CHR) < 15  then
		 	dialogue.helper("Thanks for joining me, but I'd like to continue on my own now.","b")
		else
		 	dialogue.helper("I need to do something dangerous. Maybe we should split up and regoup later?","c")
		end
	 	dialogue.helper("Are there any dragonballs nearby?","d")
		if dball_data.buruma_ever_carried == 0 then
			dialogue.helper("Could you use your capsules to carry something for me? It's heavy.","e")
		else
			dialogue.helper("May I access capsule storage please?","e")
		end
	 	-- dialogue.helper("Would you bring out your capsule flyer? We need to take to the air.","g")
	 	-- dialogue.helper("Would you bring out your capsule submarine? We need to cross water.","h")
	 	-- dialogue.helper("Would you...(not implemented)","i")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("What? You think you can get rid of me that easily? No way, bucko! I'm in this for good! I'm after the dragonballs, and I'm not going to let you beat me to them.\n\n")
			dialogue.conclude()
			term.load()
			-- party.unparty(RACE_BURUMA)
		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Dangerous? Like how dangerous? You don't think I might break a nail, do you?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Umm...yeah. Maybe.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("...ehh...then maybe I should just go let you take care of it. I'll meet up with you later at my palce, ok?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Sounds good.\n\n")
			dialogue.conclude()
			party.unparty(RACE_BURUMA)
			dball.delete_monster(RACE_BURUMA)
		elseif ans == "d" then
			local balls = dball.dragon_radar()
			term.save()
			if balls == 0 then
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("No. I don't detect any dragonballs in the area.\n\n")
			elseif balls == 1 then
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Yes! We're very close to a dragonball right now!\n\n")
				sound.play_sample("radarblip", 1, 99, 1)

			else
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("YES! There are " .. balls .. " dragonballs right near here!\n\n")
				sound.play_sample("radarblip", 1, 3, 1)
			end
			dialogue.conclude()
			term.load()
		elseif ans == "e" then
			dball_data.buruma_ever_carried = 1
			store.display(store.STORE_BURUMA)

--[[
		elseif ans == "e" then
			local ret, item = get_item("Give what to Buruma?",
				"You don't have any useable devices or tools.",
				USE_INVEN | USE_EQUIP | USE_FLOOR,
				function(o)
					return true
				end)
				if not ret or not item then return nil end

				-- Get the item (in the pack)
				buruma_obj = object_dup(get_object(item))
				dball_data.buruma_carrying = 1
				item_increase(item, -99)
				item_optimize(item)
		elseif ans == "f" then
				local obj = object_dup(buruma_obj)
				dball_data.buruma_carrying = 0
				buruma_obj = {}
				dball.reward(obj)
]]
		end
		return
	end

	if dball_data.buruma_state == 0 then
		term.text_out("You see an attractive young girl wandering around with a determined look on her face. She appears to be fiddling with some sort of device, and seems a bit frustrated.\n\n")
	end

	if dball_data.buruma_state == 0 or dball_data.buruma_state == 1 then
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("...no. ...no. ...maybe if I...no. Hmm.\n\n")
		dialogue.prep()
		if dball_data.buruma_state == 1 then
		 	dialogue.helper("Hello. I'm " .. player_name() .. ". We met earlier.","a")
		else
		 	dialogue.helper("Hello. I'm " .. player_name(),"a")
		end
		if quest(QUEST_BRIEFS_FIND_BURUMA).status == QUEST_STATUS_TAKEN then
		 	dialogue.helper("Dr. Briefs says he's finished the work you asked him to do.","b")
		end

		local ans = dialogue.answer()
		term.load()

		if ans == "a" then
			term.save()
			term.text_out("She answers disinterestedly, and doesn't look up from what she's doing.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			if dball_data.buruma_state == 1 then
				term.text_out("Yes. I remember you.\n\n")
			else
				term.text_out("Hello. I'm Buruma. I'm also extremely busy.\n\n")
			end
		 	dialogue.helper("Oh. Sorry to trouble you.","a")
		 	dialogue.helper("Anything I can help with?","b")
		 	dialogue.helper("Wow. You're awfully rude.","c")

			-- This needs to happen down here
			dball_data.buruma_state = 1

			local ans = dialogue.answer()
			term.load()
			dialogue.prep()
			if ans == "a" then
				return
			elseif ans == "b" then
				term.save()
				term.text_out("She looks up at you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Not unless you happen to have any experience rewiring tripolyacetane based tachyon field positronometers with tools roughly as precise as stone knives and bear skin. I need to increase the base inductance ratio of my radar by at least another .3 percent, and it's being very stubborn.\n\n")
			 	dialogue.helper("Umm...no. I'm sorry, I don't think I can help with that.","a")
				if skill(SKILL_TECHNOLOGY).value > 3 then
				 	dialogue.helper("You're using tachyons to detect positrons? Isn't that going about things the hard way to begin with?","b")
				end
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Buruma: ")
					term.text_out("I didn't think so. Now, if you'll excuse me...")
					return
				elseif ans == "b" then
					term.save()
					dialogue.prep()
					dball_data.seduce_buruma = dball_data.seduce_buruma + 1
					term.text_out("She pauses for a moment.\n\n")
					term.text_out(color.LIGHT_BLUE, "Buruma: ")
					term.text_out("Well, yes. Unfortunately I've found no practical way to detect the unique tachyons emmitted by Dragonballs outside of laboratory conditions, and with very large apparatus. Checking for positrons is much easier, of course, but they don't have the same penetration as tachyons. Really, what I want to do is generate tachyons, which, as you know, will penetrate just about anything, and have more or less infinite range. Then, when a remote tachyon interacts with an appropriate positron, even on the opposite side of the planet...\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("...the tachyons' quantuum partner will register the interaction, and since you've kept it here it's easy to measure.\n\n")
					term.text_out(color.LIGHT_BLUE, "Buruma: ")
					term.text_out("Exactly!\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					if quest(QUEST_DRAGONBALLS).status == QUEST_STATUS_UNTAKEN then
						term.text_out("So basically you're looking to build a device capable of detecting the unique emmissions of a specific material from anywhere on the planet?\n\n")
					else
						term.text_out("So basically you're looking to build a device that will locate the dragonballs from anywhere on the entire planet?\n\n")
					end
					term.text_out(color.LIGHT_BLUE, "Buruma: ")
					term.text_out("Exactly! Hey, ")
					if player.get_sex() == "Female" then
						term.text_out("you're pretty smart. ")
					else
						term.text_out("you're a really neat guy. ")
					end
					term.text_out("Not many people understand what I'm talking about most of the time. Maybe you can help me with something. Do you know about the dragonballs? (Implement rest of branch)\n\n")
					dialogue.conclude()
					term.load()
				end
				
			elseif ans == "c" then
				dball_data.seduce_buruma = dball_data.seduce_buruma - 1
				if player.get_sex() == "Female" then
					term.text_out(color.LIGHT_BLUE, "Buruma: ")
					term.text_out("You would be too if you'd been single all your life.")
				else
					term.save()
					term.text_out("She sighs and looks at the ground sadly.\n\n")
					term.text_out(color.LIGHT_BLUE, "Buruma: ")
					term.text_out("You're not the first guy to tell me that.\n\n")
					dialogue.conclude()
					term.load()
				end
			end
		elseif ans == "b" then
			term.save()
			term.text_out("Instantly she is extremely excited.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("He has?!?! Oh...thank you!\n\n")
			term.text_out("She pulls a capsule from her pocket and tosses it to the ground. Instantly a small jet materializes in front of you. She hops in, and is gone in an instant.\n\n")
			dialogue.conclude()
			term.load()
			dball.delete_monster(RACE_BURUMA)
			change_quest_status(QUEST_BRIEFS_FIND_BURUMA, QUEST_STATUS_COMPLETED)
			dball_data.buruma_state = 2
		end
	elseif dball_data.buruma_state == 2 then
		dball_data.buruma_state = 3
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Hi, " .. player_name() .. ". Thanks for letting me know daddy was done fixing my Dragon Radar. It will help a lot!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...Dragon Radar? You're looking for dragons?\n\n")
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("No, silly! I'm looking for Dragonballs!\n\n")

		term.text_out(color.LIGHT_BLUE, "NOTE: ")
		term.text_out("Buruma's dialogue has been somewhat mutiliated due to some code reverts, and much of it has not yet been recreated. For now, Buruma will just be happy. (I know, there's a first.) If you'd like to invite her to your party, just strike up a conversation with her again.\n\n")
		dialogue.conclude()
		term.load()
		
		
		
		
		
		
		
		
		
--[[

		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Hi, " .. player_name() .. ". Thanks for letting me know daddy was done fixing my Dragon Radar. It will help a lot!\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("...Dragon Radar? You're looking for dragons?\n\n")
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("No, silly! I'm looking for Dragonballs!\n\n")
		if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_UNTAKEN then
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Really? What a coincidence. I'm looking for them too.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Are you? Wow! That's fantastic! If we work together we can find them twice as fast!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("That sounds good to me. There's only one problem. There are two of us and the dragon will only grant one wish.\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Oh. You're right. Hmm. What do you suggest?\n\n")
		else
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Dragonballs? What are those?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("You've never heard of the dragonballs? Wow! I thought everyone knew the legend.\n\n")
			term.text_out("It is said that when the current God of the Earth, Kami, took his place in charge of the Earth, he was displeased with the immorality of man. So, to test us, and to give us hope he created the dragonballs! Seven mystic orbs that once gathered together would summon Shenron, the Dragon of the Earth, to grant his summoner a single wish.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wow. Any wish?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("Well, I hope so. I want to wish for something especially difficult.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("What's that?\n\n")
			term.text_out(color.LIGHT_BLUE, "Buruma: ")
			term.text_out("I want to wish for a boyriend! It's really difficult being as smart and pretty as me. I mean, just look at my figure! Look at my chest! .\n\n")
			dialogue.helper("Has it ever occurred to you that maybe boys would like you if you weren't such an arogant snob?", "a")
			dialogue.helper("You want to use a wish to get a boyfriend? Isn't that a bit...excessive?", "b")
			if player.get_sex() == "Female" then
				if dball.persuade(15) then
					dialogue.helper("(Persuade 15) I'm envious. I wish I had your figure. Still, I understand how difficult it must be for you.", "c")
				end
			else
				dialogue.helper("Umm...ok.", "d")
				if  player.stat(A_CHR) < 11  then
					dialogue.helper("Wow. You're hot. I would totally go out with you.", "e")
				elseif dball.persuade(15) then
					dialogue.helper("(Persuade 15) I'd really like to see you get your wish.", "f")
				end
			end
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("There's no need to be rude!\n\n")
			elseif ans == "b" then
			elseif ans == "c" then
			elseif ans == "d" then
			elseif ans == "e" then
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Ewww! I said look, not STARE! What are you, some kind of pervert?!?!.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("No. Just male, and breathing. Seriously, any guy would go out with you. What's the problem?\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("...well, I have to be into him too, you know.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Oh. Now we're getting somewhere. So you're saying that you're so particular that you need to find a magic dragon who grants wishes just to get somebody to live up to your expectations?\n\n")
				term.text_out(color.LIGHT_BLUE, "Buruma: ")
				term.text_out("Are you going to help me or not?\n\n")
			elseif ans == "f" then
			end
			
			dialogue.conclude()
		end
		dialogue.conclude()
		term.load()
	
]]	
	
	elseif dball_data.buruma_state == 3 then
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Hello again, " .. player_name() .. "! Shall we go look for the dragonballs?\n\n")
		dialogue.helper("Not right now.", "a")
		dialogue.helper("Yes, please. I could use your help.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			party.party(RACE_BURUMA)
		end
	end
end

function dialogue.VIDEL()
	local fall_through = 0
	-- Are we married to Videl?
	if dball_data.married == FLAG_MARRIED_VIDEL then
		message("Hello, beloved!")
		return
	elseif dball_data.oolong_married == RACE_VIDEL  then
		term.text_out(color.LIGHT_BLUE, "Buruma: ")
		term.text_out("Well, look who it isn't. What brings you back? Haven't you caused enough trouble for me?\n\n")
	 	dialogue.helper("So how's married life?","a")
	elseif dball_data.rosshi_girl == RACE_VIDEL then

	end

	-- Is Videl married to Oolong or Rosshi?

	-- States:
	-- 0 = no contact
	-- 1 = Casual contact
	-- 2 = Unfriendly
	-- 3 = Perma-platonic
	-- 4 = Videl's Challenge Issued
	-- 5 = Received Response from Mr Satan, pending
	-- 6 = (Persuaded) Mr Satan
	-- 7 = Dueled and won
	-- 8 = Currently following character
	-- 9 = Married

	if dball_data.videl_state == 5 then
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("Please convince my father!")
	elseif dball_data.videl_state == 8 then
		monster_random_say
			{
				"I'm so excited!",
				"How much farther is it?",
				"Are we there yet?",
			}
	elseif dball_data.videl_state == 7 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("Is it TRUE?!!?? Did you win!?!?\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Yes. So we can get married now, right?\n\n")
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("But...I...can't! I'm only 17!!! I'm...I...umm...\n\n")
		term.text_out("She look at you uncertaintly, but you simply hold her gaze and watch as she melts. After afew moments she starts to smile, and then slowly nods.\n\n")
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("...yes. Yes, " .. player_name() .. ", I will marry you. We'd better talk to me father first, though. Just to make sure that he'll really allow it.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.videl_state == 9 then
		message("Hello, beloved. :)")
	elseif dball_data.videl_state == 4 then
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("Please convince my father!")
	elseif dball_data.videl_state == 6 then
		term.save()
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("He said 'ok.'\n\n")
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("...he what?\n\n")
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		term.text_out("Yep. This is a fine boy. You two love birds go right ahead.\n\n")
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		term.text_out("WHAT?!?!\n\n")
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		term.text_out("No, dear...it's alright. You can get married now. This one obviously appreciates the finer things in life. Me, for instance. So, Im suire he'll make a terrific husband.\n\n")
		term.text_out("Videl is speechless.\n\n")
		dialogue.conclude()
		term.load()

	elseif dball_data.videl_state ~= 2 then
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Videl: ")
		if dball_data.videl_state == 0 then
			-- First contact
			term.text_out("Hello. Here to see my father?\n\n")
			dialogue.helper("Mr. Satan is your father? Yes, I'm here to see him.", "b")
			dialogue.helper("No, just exploring, really.", "c")
			-- With Videl, it has to be love at first sight
			if player.get_sex() ~= "Female" and dball.persuade(12) then
				dialogue.helper("(Persuade 12) No, dear. I've come to sweep you off your lovely feet.", "d")
			end
		else
			term.text_out("Hello, again. Here to see my father?\n\n")
			dialogue.helper("No, I was just in the area and thought I'd come visit with you.", "a")
			dialogue.helper("Yes.", "b")
			dialogue.helper("No. Not specifically. I was just sort of wandering around, not really making a social call.", "c")
		end
		if player.get_sex() ~= "Female" and player.stat(A_CHR) > 11 then
			if dball_data.videl_state == 3 then
				dialogue.helper("(Persuade 12) Videl...can we talk? We've known each other for a while, and you're a really nice girl and I like you a lot...", "f")
			end
		end
		if dball_data.alignment < 0 then
			dialogue.helper("No. I'm a bad person and I'm here to kill you all. (attack)", "e")
		end

		dball_data.videl_state = 1

		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			-- Haha! Poor fool!
			dball_data.videl_state = 3
			term.save()
			term.text_out("Videl smiles happily.\n\n")
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			term.text_out("Oh, really? How wonderful! I have company so rarely! Thank you so much for visiting me! :)\n\n")
			if player.get_sex() == "Female" then
				if dball_data.married == 0 then
					term.text_out("The two of you chat for a few hours, and generally catch up on girl talk. Videl is really a hoot, and lots of fun. Plus, she's single too, so the two of you can commiserate and fantasize together. It's good times.\n\n")
				else
					term.text_out("The two of you chat for a few hours, and generally catch up on girl talk. She's especially interested to hear you talk about married life, and you detect more than just a hint of envy")
					if dball_data.married == FLAG_MARRIED_OOLONG then
						term.text_out(". You feel really good about your marriage. Oolong is tender, loving, and you feel that he genuinely loves you. You really are a lucky girl to have stumbled onto such a wonderful pig at exactly the right moment.\n\n")
					elseif dball_data.married == FLAG_MARRIED_OOLONG then
						term.text_out(", which helps you not feel so bad about being Rosshi's girl. It's true that you enjoy his letchery, but sometimes you're a bit embarrassed that you do.\n\n")
					end
				end
			else
				if dball_data.married == 0 then
					term.text_out("You spend the next few hours listening to Videl unload on you about how terribly lonely and unhappy she is, and how nobody ever comes to visit her and nobody wants to talk to her. She cries on your shoulder and thanks you for being such a good friend, and says she hopes you visit her again soon.\n\n")
					local wrt = rng(1,3)
					if wrt == 1 then
						term.text_out("Clearly you are doing something wrong.\n\n")
					elseif wrt == 2 then
						term.text_out("Pondering the irony of the situation, you briefly consider changing your name to 'Nobody.'\n\n")
					else
						term.text_out("You feel rather empty inside.\n\n")
					end
				else
					term.text_out("You chat with Videl for a few hours. She listens wide-eyed as you tell her of your latest adventurer, and she tells you about her life, and her ambitions. Videl's a good girl.\n\n")
				end
			end
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			term.text_out("He's right there. Training, as usual. Go on in.")
			return
		elseif ans == "c" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			if dball_data.videl_state == 0 then
				term.text_out("...oh? That's a bit unusual. Honestly though, it's sort of a relief. I don't mean to unload on you, but it's not always the nicest thing...being the daughter of someone so famous. I can't remember the last time anyone came to visit me. It's...lonely.\n\n")
			else
				term.text_out("Just exploring? Oh, that's right. You're an adventurer. You're so nice, I sometimes forget about that. Yes, I suppose daddy's gauntlet would make a good place for that sort of thing. At least, if you hadn't already lived here all your life. Wow...it's really nice having you here to talk to. Sometimes I get so lonely here all by myself. I don't get much company.\n\n")
			end
			dialogue.helper("Really? That surprises me. You seem like a nice girl.", "a")
			if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN then
				dialogue.helper("Really? Wow...you seem like such a sweet, kind, loving girl. I'd expect you'd have company all the time. Wait...did I say 'sweet, kind and loving?' Hmm. You know, there's someone I think I'd like to introduce you to.", "b")
			end
			if quest(QUEST_ROSSHI_LONELY).status == QUEST_STATUS_TAKEN then
				dialogue.helper("Really? You know...I just happen to have a friend who's in a similar situation. He lives on an island all by himself, and is absolutely dying for company.", "c")
			end
			if dball_data.alignment < 0 then
				dialogue.helper("Hmm...? Look, I'm not here to see you. I'm just exploring. Get over yourself.", "d")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.save()
				term.text_out("Videl blushes and smiles.\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("Thank you, but that's not always enough to compete with all the testosterone floating around here. I'm glad to finally have company who isn't here just to oogle over my father or beg for an autograph. It was a pleasure talking with you. Please do come again!\n\n")
				dialogue.conclude()
				term.load()
			elseif ans == "b" or ans == "c" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("Really? That sounds wonderful! Yes, I'd be delighted to meet him. I'll follow you.\n\n")
				dialogue.conclude()
				term.load()
				party.party(RACE_VIDEL)
				dball_data.videl_state = 8 --?
			elseif ans == "d" then
				term.text_out("Videl looks shocked...starts to say something but just looks at the ground instead. She then turns away, fighting back tears.\n\n")
				dialogue.conclude()
				term.load()
				dball.chalign(-50)
				player.redraw[FLAG_PR_BASIC] = true
				dball_data.videl_state = 1
			end
		elseif ans == "d" then
			dball_data.persuades = dball_data.persuades + 1
			term.save()
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			term.text_out("...you...what? Me? I'm a nobody!\n\n")
			term.text_out("(Videl looks moderately panic-stricken but at the same time can't take her eyes off of yours. The look in her eyes faintly resembles that of a deer in headlights, but after a her moments she calms...and blinks a few times.)\n\n")
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			term.text_out("...you're...serious?\n\n")
			dialogue.prep()
			dialogue.helper("Yes.", "a")
			dialogue.helper("No. I just wanted to get your hopes up so I could dash them on the floor and stomp on them.", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.save()
				term.text_out("Videl continues to stare at you blankly for a few moments. You hold her gaze, and you watch her soften, then smile...then, after a few moment...she begins to look extraordinarily hopeful.\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("...I...wow. You're amazing. Just looking at you I feel so wonderful! Look...honestly I'm not ready to get married, and I'm still not certain I believe you anyway. But...I'd like to.\n\nUnfortunately, it would never work. My father is an idiot. He won't even let me date, let alone marry anyone. He says that nobody is good enough for me, and he insists that to earn the right to date me, he first has to defeat my father in combat. Have you ever heard anything so ridculous? My father' been the Champion of the World Tournament for the past three years running! I'm only 17, but sometimes I think I'm going to die an old maid!\n\n")
				dialogue.prep()
				dialogue.helper("Hmm. You're right. That's dumb. But...if it's what I have to do...I'll do it.", "a")
				dialogue.helper("Wow, yeah...I guess that's too much for me. Sorry.", "b")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					term.save()
					term.text_out("Videl smiles hopefully at you.\n\n")
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("He's in there. Training, as usual. Go on in. And...good luck. :)\n\n")
					dialogue.conclude()
					term.load()
					change_quest_status(QUEST_VIDEL_LONELY, QUEST_STATUS_TAKEN)
					dball_data.videl_state = 4
				elseif ans == "b" then
					term.save()
					term.text_out(color.LIGHT_BLUE, "Videl: ")
					term.text_out("I don't really blame you. Nobody else is brave enough to face him, either. Still...thanks for being attracted to me. Please come visit me again sometime.\n\n")
					dialogue.conclude()
					term.load()
				end
			elseif ans == "b" then
				dball.chalign(-50)
				dball_data.videl_state = 2
				term.save()
				term.text_out("Videl's mouth drops for a few moments, and she begins to fight back tears. She stares at the ground and turns away, without speaking.\n\n")
				dialogue.conclude()
				term.load()
			end
		elseif ans == "e" then
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			term.text_out("Eeek! Daddy! Help!")
			dball.neutral_annoy()
			dball_data.videl_state = 2
		elseif ans == "f" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Videl: ")
			term.text_out("Why thank you, " .. player_name() .. "! Your friendship really means a lot to me. :)\n\n")
			dialogue.conclude()
			term.load()
		end
	elseif dball_data.videl_state == 2 then
		message("Videl looks uncomfortable and shies away from conversation.")
	end
end

function dialogue.MISS_PIIZA()
	local paper_cup = false

	-- piiza_state: 0 = no contact 1=has spoken

	if dball_data.piiza_state == 0 then
		dball_data.piiza_state = 1
		term.save()
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Why, hello! I'm Miss Piiza! Welcome to the private estate and training dojo of the most powerful fighter in the whole world: the magnificient Mr. Satan! If you're here to gape in awe, please feel free to peruse the trophy room.\n\n")

	elseif dball_data.sushi_quest_awkward ~= 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Oh. Hello again. Did you, umm...remember to bring the sushi this time?\n\n")
	else
		term.save()
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Hello, again! Mr. Satan adores his admirers. Please feel free to drool in awe of Mr. Satan's masculine prowess. But please don't drool on the floor. Here's a paper cup to catch it in.\n\n")
		paper_cup = true
	end

	if dball_data.sushi_quest_awkward == 0 then
		dialogue.helper("Thank you, Miss Piiza. I'll just look around on my own, thanks.", "a")
		dialogue.helper("I'd like to sign up for classes.", "b")
		if quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_TAKEN then
			dialogue.helper("I'm here to deliver an order of saba from the sushi bar.", "c")
		end
	else
		dialogue.helper("Yes. Here it is, with my apologies for the delay.", "c")
		dialogue.helper("Sushi? What sushi?", "d")
	end
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
		if paper_cup == true then
			dball.reward(create_object(TV_MISC, SV_PAPER_CUP))
		end
	elseif ans == "b" then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Yes, I'm sure you would. But please understand that Mr. Satan is a very busy, terribly important man, and he can't be bothered to train just anybody.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("What do I have to do to be accepted as a student?\n\n")
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Well, honestly, there's probably nothing you can do. he's very picky. But, you're welcome to try to run the gauntlet, if you'd like.\n\n")
		dialogue.conclude()
		term.load()
		term.save()
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("The gauntlet?\n\n")
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Yes. This mansion is a massive, five story training hall. Since Mr. Satan is too busy to actively teach classes, his students train themselves by constantly fighting on the various levels. The higher you go, the more dangerous your opponents will become. If you can reach the top level, Mr. Satan might grace you with a few words, but don't count on it. Just be grateful you get to practice being a punching bag for his students.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Umm, right. Thank you.\n\n")
		dialogue.conclude()
		term.load()
	elseif ans == "c" then
		-- Check for saba
		local item
		local obj
		for i = 1, player.inventory_limits(INVEN_INVEN) do
			obj = player.inventory[INVEN_INVEN][i]
			if obj and obj.k_idx == lookup_kind(TV_SUSHI, SV_SUSHI_SABA) then
				item = i
			end
		end
		-- End check for saba

		if not item then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
			term.text_out("Oh! Thank you, Mr. Satan does so enjoy his sushi. Umm...where is it?\n\n")
			term.text_out("(You realize that you don't have the sushi with you.)\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...I. Umm, guess I must have misplaced it.\n\n")
			term.text_out("(There is an awkward moment, and Miss Piiza looks at you strangely.)\n\n")
			dialogue.conclude()
			term.load()
			dball_data.sushi_quest_awkward = 1
		else
			term.save()
			term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
			if dball_data.sushi_quest_awkward ~= 0 then
				term.text_out("Thank you for the delivery. I will see to it that Mr. Satan gets it.\n\n")
			else
				term.text_out("Oh! You must be the new delivery boy. I hear the last one decided to become a delinquent, and has been associating with some very unpleasant characters on that little island southeast of here. Very sad.\n\n")
				term.text_out("Thank you for the delivery. I will see to it that Mr. Satan gets it.\n\n")
			end
			dialogue.conclude()
			term.load() 
			item_increase(item, -1)
			item_describe(item)
			item_optimize(item)
			change_quest_status(QUEST_AKIRA_SUSHI, QUEST_STATUS_COMPLETED)
			dball_data.sushi_quest_awkward = 0
		end
	elseif ans == "d" then
		term.save()
		term.text_out("Miss Piiza scratches the back of her head and laughs politely.\n\n")
		term.text_out(color.LIGHT_BLUE, "Miss Piiza: ")
		term.text_out("Oh! How very silly of me! I thought you were to delivery boy. Please accept my apologies. Now, if you'll excuse me, I have some things to attend to.\n\n")
		dialogue.conclude()
		term.load()
	end
end

function dialogue.MR_SATAN()
	local fall_through = 0	-- 1=marry videl

	if dball_data.married == FLAG_MARRIED_VIDEL then
		message("Hello, " .. player_name())
		return
	end
	if dball.current_location() == "World Tournament" then
		if dball_data.married == FLAG_MARRIED_VIDEL then
			message("Sorry, " .. player_name() .. ". I won't go easy on you just because you're family.")
		else
			monster_random_say
				{
					"No, I'm sorry you can't have an autograph right now.",
					"Give up while you still have your dignity!",
					"I'm the greatest!",
				}
			return
		end
	end

	if dball_data.satan_state == 0 or dball_data.satan_state == 1 then
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		if dball_data.satan_state == 0 then
			term.text_out("I'm sorry, I'm not giving out autographs today. I'm too busy training!\n\n")
		elseif dball_data.satan_state == 1 then
			term.text_out("I remember you! Thanks for stopping by, but today's really not good. I'm training for the World Tournament, you know!\n\n")
		end
		dialogue.helper("Oh. I'm sorry. I'll go, then.", "a")
		if quest(QUEST_BRIEFS_SATAN_DELIVERY).status == QUEST_STATUS_TAKEN then
			dialogue.helper("I'm here to deliver your muscle stimulator. Dr. Briefs has repaired it.", "b")
		end
		if quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_TAKEN then
			dialogue.helper("I'm here to deliver your order of saba from the sushi bar.", "c")
		end
		if quest(QUEST_VIDEL_LONELY).status == QUEST_STATUS_TAKEN and dball_data.videl_never_marry == 0 then
			dialogue.helper("I'm here to challenge you for your daughters hand in marriage.", "d")
			if dball.persuade(15) then
				dialogue.helper("(Persuade 15) I met your daughter. Wow! She's almost as incredible as you are!", "e")
			end
		end
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
			return
		elseif ans == "b" then
			dball_data.satan_state = 1
			term.load()
			term.save()
			dialogue.prep()
			-- Begin check
			local item
			local obj
			for i = 1, player.inventory_limits(INVEN_INVEN) do
				obj = player.inventory[INVEN_INVEN][i]
				if obj and obj.k_idx == lookup_kind(TV_ELECTRONICS, SV_MUSCLE_STIMULATOR) then
					item = i
				end
			end
			-- End check

			if not item then
				-- We don't have the stimulator! Oh no!
				quest(QUEST_BRIEFS_SATAN_DELIVERY).status = QUEST_STATUS_FAILED
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Ahhh! Yes, my electronic muscle stimulator. I've been waiting for that for days! It's great that it's fixed! Where is it?\n\n")
				term.text_out("You fumble through your things, but realize that you don't have it on you.)\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("What? You LOST my muscle stimulator?!?!! Do you have any idea how hard those are to come by!?!? What did you do with it?\n\n")
				dialogue.helper("I guess I must have misplaced it.", "a")
				dialogue.helper("Hmm. I think I sold it to Lazarus at the Pawnshop.", "b")
				if get_skill(SKILL_DISASSEMBLY) > 0 then
					dialogue.helper("It's possible I may have dismantled it for parts.", "c")
				end
				if dball.persuade(15) then
					dialogue.helper("(Persuade 15) Why, I threw it away! Surely a man as powerful and great as you doesn't need silly little trinkets like that! You are Mr. Satan! You're the greatest martial artists alive! That silly thing was just holding you back!", "d")
				end
				ans = dialogue.answer()
				if ans == "d" then
					dball_data.persuades = dball_data.persuades + 1
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("Of course! That explains why I was having trouble bending that steel girder with my bare hands last week! Not that anyone else has ever done it, but I figured if anyone could, it would be ME! Yes, that fool device was holding me back! Why, it's a good thing you threw it away! That was the worst hundred thousand zeni I ever spent! I like you! You're all right!\n\n")
					dball_data.satan_comic_state = 3
					dialogue.conclude()
					term.load()
					return
				else
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("You did what!?!?!??! You...! Get out of my sight!\n\n")
					dball_data.satan_state = 2
					dialogue.conclude()
					term.load()
					return
				end
			else
				obj = player.inventory[INVEN_INVEN][item]
				item_increase(item, -1)
				item_describe(item)
				item_optimize(item)
				-- Clear the hard coded item change response above
				term.load()
				term.save()
				quest(QUEST_BRIEFS_SATAN_DELIVERY).status = QUEST_STATUS_COMPLETED
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Ahhh! Very good! I've been waiting for days to get this back, and a man as important as me sure don't like waiting for things. So, you're a buddy of Dr. Briefs, right? In that case, I've got something for you. ")
				if dball.dragonballs_left() > 0 then
					term.text_out("Not sure what it does, but it looks like one of them things his daughter always talks about, so I figure it must be some sort of techno-gizmo of some kind. I figure it'll be up your alley. Here you go. Anyway, I got me some important stuff to attend to, so if you'll excuse me.\n\n")
					dball.reward(dball.request_dragonball())
				else
					term.text_out("Here you go! A genuine, authentic, autograph! Signed and notarized by none other than ME! Hold on to that. You could pass it on to your children, some day.\n\n")
					dball.reward(create_object(TV_MISC, SV_AUTOGRAPH))
				end
				dball_data.satan_comic_state = 4
				dialogue.conclude()
				term.load()
			end

		elseif ans == "c" then
			dball_data.satan_state = 1
			term.load()
			term.save()
			dialogue.prep()

			-- Check for saba
			local item
			local obj
			for i = 1, player.inventory_limits(INVEN_INVEN) do
				obj = player.inventory[INVEN_INVEN][i]
				if obj and obj.k_idx == lookup_kind(TV_SUSHI, SV_SUSHI_SABA) then
					item = i
				end
			end
			-- End check for saba

			if not item then
				-- We don't have the saba! Oh no!
				quest(QUEST_AKIRA_SUSHI).status = QUEST_STATUS_FAILED
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Ahhh! Very good! There's nothing I like more than a tasty piece of mackeral wrapped around some rice! Akira sure has got a great sushi place. I don't remember seeing you before, though. I guess his old delivery boy must have moved on to better and brighter things. Last I heard he was spendin' time with that old blue feller in the castle east of here. Anyway, I'm mighty hungry for that there mackeral! Where is it?\n\n")
				term.text_out("(You fumble through your things and realize that you don't have any saba to give him.)")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("What'd you do with my saba?!!?\n\n")
				dialogue.helper("Looks like I misplaced it.", "a")
				dialogue.helper("I think I sold it to Lazarus at the Pawnshop.", "b")
				dialogue.helper("I guess I must have eaten it.", "c")
				if dball.persuade(12) then
					dialogue.helper("(Persuade 12) Wow! It must have been SO fresh...that it squirmed its way out of my pocket, and found its way back to the ocean! Akira sure does make great sushi, doesn't he?", "d")
				end
				ans = dialogue.answer()
				if ans == "d" then
					dball_data.persuades = dball_data.persuades + 1
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("Hmm. You're right, it must of been awful fresh! Wow...I'm sorry I missed out on it. Probably would of been the best sushi I ever had. Oh well. Next time, I guess.\n\n")
					dialogue.conclude()
					term.load()
					return
				else
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("You did what!?!?!??! You...! Get out of my sight!\n\n")
					dball_data.satan_state = 2
					dialogue.conclude()
					term.load()
					return
				end
			else
				-- Fixme Implement: what does this do?
				obj = player.inventory[INVEN_INVEN][item]
				-- 

				item_increase(item, -1)
				item_describe(item)
				item_optimize(item)
				-- Clear the hard coded item change response above
				term.load()
				term.save()
				quest(QUEST_AKIRA_SUSHI).status = QUEST_STATUS_FINISHED
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("I ordered sushi? Oh. I mean...well, of COURSE I ordered sushi! I love sushi! Especially sa...sa...whatever it was that you said. Give it here!\n\n")
				term.text_out("(You hand him the pair of beautifully wrapped pieces of mackeral. He scrutinizes them very carefully as if he has no idea what he's looking at. He looks up at you quizzically for a moment, and you explain that it's fish, and that he's supposed to eat it.)\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Of COURSE! Everybody knows that! I was just testing you! Yes! Testing you! Testing to see if you were WORTHY to give sushi to the great MR SATAN! I'm the greatest martial artist in the WHOLE WORLD, you know! I can't have just anybody giving me shusi...I mean shooti...I mean...umm...\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Sushi.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Right! Shusi! That's what I said!\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out("(He looks at it again, pauses, and then quickly throws both pieces in his mouth and chews them vigorously with his eyes closed tightly shut, as tears begin streaming down the sides of his face.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("*gag* *cough* aahhhhgggg.....*choke*.....ahhh! That was GREAT! Wow! *cough* That was absolutely great! That was so great *gasp* it was good enough EVEN FOR ME! *choke*\n\n")
				dialogue.helper("I'm glad you liked it. Bye, now. (leave)", "a")
				dialogue.helper("Hey...you know, I happen to study martial arts. Since I'm here, would you teach me a trick or two?", "b")
				if quest(QUEST_VIDEL_LONELY).status == QUEST_STATUS_TAKEN then
					dialogue.helper("Well, then. Now that that's out of the way...I spoke with your daughter briefly on the way in. She happened to mention that you won't allow her to marry until she can find someone who can defeat you in combat. I just met the girl, but...well, I've never been one to turn down an opportunity to duel. So, I'd like to challenge you for her hand.", "c")
				end
				if dball.persuade(13) then
					dialogue.helper("(Persuade 13) Wow! You're so amazing you're even impressive when you eat! May I have your autograph please!?!?!?!", "d")
				end
				if dball.persuade(14) and ability(AB_SUSHI).acquired == false then
					dialogue.helper("(Persuade 14) Wow...that was an impressive display of, umm, your impressive martial arts eating technique! Never have I seen such power and grace!", "e")
				end
				ans = dialogue.answer()
				if ans == "a" then
					return
				elseif ans == "b" then
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("You study martial arts! That's GREAT! Ordinary folks just can't understand...it takes a real martial artist to appreciate just how GREAT I am! Here...let me show you my secret, special punching technique!!!\n\n")
					term.text_out("(You politely watch as he spends the next three or four minutes adjusting his uniform, tightening his belt, puffing out his chest and generally making making a big production of things. Then, right as you think he's never going to get around to it, he rather suddenly brings one hand to his waist, puts the other up in the air on an imaginary target, clears his throat and bellows:)\n\n")
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("KIIIIIYYAAAHHHHHHH!!!!\n\n")
					term.text_out("(The punch itself is rather unimpressive.)\n\n")
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("Well, then! Wasn't that a GREAT punch! I bet you've studied all your life, and never ever once saw a punch as great as that! Now, if you'll excuse me, a man as IMPORTANT as me has real important stuff to attend to. Be sure and practice what you learned today. Might just save your life someday!\n\n")
					dialogue.conclude()
					dball_data.satan_comic_state = 1
					term.load()
				elseif ans == "c" then
					fall_through = 1
				elseif ans == "d" then
					dball_data.persuades = dball_data.persuades + 1
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("Well, alright" .. gendernouns.demeaning .. ". I suppose I have to take care of my loyal fans. ")
					-- term.text_out("\n\n(Received autograph)\n\n")
					-- term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("There you go! Now, excuse me while I get back to my very important training! Be sure an' watch this years World Tournament! I'm gonna win it for the fourth year running!\n\n")
					dialogue.conclude()
					term.load()
					dball.reward(create_object(TV_MISC, SV_AUTOGRAPH))
				elseif ans == "e" then
					dball_data.persuades = dball_data.persuades + 1
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("Ahhhh!!! You saw that, huh! You've got a good eye, " .. gendernouns.demeaning .. "! I've got a hundred wanna-be's who hang out here and none of them good enough to see what you just saw! Why...I practiced that technique for two whole days before I mastered it! Of course, it'd take an ordinary man years even to grasp the basics of it, but I can tell you're not so ordinary! Tell you what. I like you! So, I'm gonna teach you ")
					term.text_out("that technique! You never know when a special technique like that might save your life!\n\n")
					term.text_out("(You spend the next few hours with Mr. Satan, and he teaches you his special eating technique.)\n\n")
					dball.learn(AB_SUSHI)
					dialogue.conclude()
					term.load()
					term.save()
					term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
					term.text_out("Very good! I knew I liked you! Of course, it's probably only because it was ME teaching you, but I think you've got the basics down. If you just practice on your own a bit, I think you'll do ok! Well, it's been great fun, " .. gendernouns.demeaning .. ", but I got a whole laundry load of important stuff to get to, so I'm gonna have to let you go. See ya!\n\n")
					dialogue.conclude()
					term.load()
					dball_data.satan_comic_state = 2
				end
			end

		elseif ans == "d" then
			term.load()
			dball_data.satan_state = 1
			fall_through = 1
		elseif ans == "e" then
			-- Easy persuade to marry Videl
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("You noticed that, huh? Not many people come through here are as perceptive as that. Oh, sure...ah get people tellin' me all the time that she's real purty, smart, gorgeous, or best lookin' gal they ever met. You know, rubbish compliments like that. But 'almost as good as me?' Why...I don't think I've ever heard higher praise for my daughter! Hey, I think I like you! I sure do wish Videl could settle down with a guy as smart as you. Most of her suitors are just worthless ol' doctors, millionnaires an' maybe a foo-foo olympic gymnast every now and then.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Really? That's terrible! Still, it seems fitting that a man of your greatness would be saddled with such a burden. No lesser man could make it through, day to day.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("Yeah, it gets hard sometimes, even for me.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Oh, I'm not worried. You're a smart man. You'll find a way.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("Hmm. Say...I think I've got an idea comin' to me right now! You married?\n\n")
			if dball_data.married == 0 then
				dialogue.helper("Me...? No. Why do you ask?", "a")
				dialogue.helper("Why, yes. Yes I am. (lie)", "b")
			else
				dialogue.helper("Yes.", "b")
			end
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Hey! I've got me a great idea! Videl! Get yourself in here!\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("Yes, father?\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Videl, I'd like you to meet " .. player_name() .. "! He's gonna marry you an' be your husband!\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("Yes, we've already met... --- HE WHAT!?!?\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Yep! He's a nice boy an' I think he's just our type.\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("...but...you didn't fight, or anything!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Oh, well, that's ok. Fact is, no one's ever gonna beat me, so I figure there's no sense in stickin' to that silly ol' idea anyway. Why don't you two love birds get to know each other a bit, and I'll go make arrangements.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out("Mr Satan heads over to the phone, leaving you two 'love birds' staring blankly at one another.\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("...but...but...\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("But what?\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("I don't know! Just 'but!' I'm only 17! I'm not ready to get married!\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Well, it sure beats being an old maid, right?\n\n")
				term.text_out("She giggles at that, then suddenly turns bright red with embarrassment that she did. Her face is covered in panic, but much as she tries she can't take her eyes off of yours, which simply look into hers with a smile.\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("...I...\n\n")
				term.text_out("She melts.\n\n")
				term.text_out(color.LIGHT_BLUE, "Videl: ")
				term.text_out("Yes. I think it does.\n\n")
				dialogue.conclude()
				term.load()
				dialogue.MARRY_VIDEL()
				return
			elseif ans == "b" then
				dball_data.videl_never_marry = 1
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Ahh, well that's too bad. Still, like you say, I'm sure I'll figure out a way to get her married to somebody worth my while.\n\n")
				dialogue.conclude()
				term.load()
				return
			end
		end
	elseif dball_data.satan_state == 1 then -- polite done
		-- Is this used anymore?
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		if dball_data.satan_comic_state == 3 then
			term.text_out("Hello! Thanks again for throwing away that lousy hundred thousand zeni stimulator. Why, I feel stronger already!\n\n")
		else
			term.text_out("Ahhh...come to admire me again? Yes, only the best can truly appreciate my greatness, so you must be ok then\n\n")
		end
		dialogue.conclude()
		term.load()
	elseif dball_data.satan_state == 2 then -- aggressive
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		term.text_out("What are you doing here! Get out of my training hall!")
	elseif dball_data.satan_state == 3 then -- Pending WT challenge
		if dball_data.tourny_registered == 5 then
			-- Won!
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Well, I did it.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("You sure did! Looks like the student has finally surpassed the master, and I'm awful proud of you!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...hmm?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("Yep! Sure was a good thing I gave you all that trainin' before the Tournament or you'd of never stood a chance! But, you listened to everything I taught you and you did good! Made your master proud. Why...it brings tears to my eyes!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Uh huh. Ok. So...about Videl?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("Yep! You're gonna be my son!\n\n")
			dialogue.conclude()
			term.load()
			dialogue.MARRY_VIDEL()
		elseif dball_data.tourny_registered == 0 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
			term.text_out("What are you doin' wastin' your time here! Get to training! At least go register for the Tournament!\n\n")
			dialogue.conclude()
			term.load()
		elseif dball_data.tourny_registered == 1 then
			-- Still fighting
			if tourny_uniques[RACE_MR_SATAN] == 1 then
				term.save()
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("I defeated you in the Tournament.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Look, lad, I hate to break it to you, but I let you win.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Excuse me?!?!\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Yep. I felt so sorry for you, and how bad I was gonna trounce you that I...let you win. Yep. So it doesn't prove a thing. But, I tell you what. If you can go ahead and win the Tournament, you and Videl can get married like we said. Yep. I did it for my little girl. She's quite taken with you, and she can't get married until the right man comes along. There was no way you were gonna beat me, but a man like me...you have to understand, pride is everything, but my little girl is even more important. You understand? So, you couldn't beat me, but maybe you can beat those other bozos out there, and make my daughter very happy. So get out there and do it!\n\n")
				dialogue.conclude()
				term.load()
			else
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("I appreciate your determination, but you're not gonna win.")
			end
		else
			-- Lost or Disqualified
			if dball_data.satan_defeated == 1 then
				term.save()
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Well, you were right. I didn't win. But I did beat you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("You didn't beat me! I tripped! That's what happened! I was feeling sorry for how badly I was beating you, and got distracted and tripped over my own feet. Doesn't count, and besides, the deal was you had to win the Tournament. You'll just have to try again next year.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.satan_state = 1
				dball_data.videl_never_marry = 1
			else
				term.save()
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Well, you were right. I didn't win.\n\n")
				term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
				term.text_out("Oh...don't feel so bad. You just have to understand that a regular Joe like you can't compete against against a terrific fighter like me. There are people ho train real hard, and then there's people with natural talent. And then there's me. I'm in a class of my own. But, here...I appreciate that you had the courage to stand up for yourself, so just to show you there are no hard feelings, I'm gonna give you an autograph! See? It all turned out pretty good for you after all. Here you go! Keep on trainin' and maybe you'll be lucky enough to lose to me next year!\n\n")
				dialogue.conclude()
				term.load()
				dball.reward(create_object(TV_MISC, SV_AUTOGRAPH))
				dball_data.satan_state = 1
				dball_data.videl_never_marry = 1
			end
		end

	end

	-- Marry Videl
	-- Is a fall through necessary? Isn't this only accessed by one path?
	if fall_through == 1 then
		dball_data.satan_state = 3
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		term.text_out("A scrawny little wimp like you is gonna challenge ME?!!??! Why...I'm the greatest fighter in the world! Don't you know that?\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("You may have won the Tournament last year...and the two years before...but I'm determined to win your daughters hand, so I'M going to win the Tournament this year.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		term.text_out("Hahahaha! Hahaha! Haha! Why, that's the funniest thing I ever heard! I bet you don't last two rounds! I'll tell you what! You're a pathetic little wimp, but I like you! If you win the Tournament this year, you and Videl can get married! Why, I'm so certain you won't, I'll even let you come in here to train! I'll tell the gate guard to let you in.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Thank you.\n\n")
		term.text_out(color.LIGHT_BLUE, "Mr. Satan: ")
		term.text_out("Yeah, I can't stand to see a buffoon like you get his pants handed to him in a fight, so at least this way you won't embarrass yourself out there.\n\n")
		dialogue.conclude()
		term.load()
	end

end

function dialogue.MARRY_VIDEL()
	term.save()
	term.text_out("The next few days are an absolute blur, as you race through, yet find yourself rather enjoying what is probably the most expensive shotgun wedding of all time, followed by two weeks in Milan, compliments of Videl's father. Obviously you weren't in this for the money, but having a wife who's father happens to be extremely rich is sort of convenient. And, as it turns out, Videl is honest, loyal, feminine, and of course, extremely attractive.\n\n")
	term.text_out(color.LIGHT_BLUE, "Videl: ")
	term.text_out("I'm sorry, this really isn't how I expected things to turn out, but...I think I've fallen in love with you.\n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("Don't apologize. Just, be beautiful, be loving, and be mine.\n\n")
	term.text_out(color.LIGHT_BLUE, "Videl: ")
	term.text_out("Yes, sir.\n\n")
	term.text_out("And, since Videl is still only 17, and still in school, that leaves you with plenty of time to continue on your adventures.\n\n")
	dialogue.conclude()
	term.load()

	if quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_TAKEN then
		quest(QUEST_AKIRA_SUSHI).status = QUEST_STATUS_FINISHED
	end
	if quest(QUEST_BRIEFS_SATAN_DELIVERY).status == QUEST_STATUS_TAKEN then
		quest(QUEST_BRIEFS_SATAN_DELIVERY).status = QUEST_STATUS_FINISHED
	end
	quest(QUEST_VIDEL_LONELY).status = QUEST_STATUS_FINISHED
	dball_data.married = FLAG_MARRIED_VIDEL
	local obj = create_artifact(ART_RING_VIDEL)
	make_item_fully_identified(obj)
	dball.reward(obj)

	flag_empty(cave(16, 20).flags)
	cave_set_feat(16, 20, FEAT_SHAFT_UP)
	cave(16, 20).flags[FLAG_LEVEL_CHANGER] = 4
	-- cave(16, 20).flags[FLAG_TERRAIN_NAME] = "Exit"
end

function dialogue.FANLADY()
	-- Do we have a valid corpse?
	local found = {}
	-- local material_check = 0

	for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
		function(obj, i, j, item)
			if obj.tval == TV_CORPSE then
				if obj.sval == SV_CORPSE_CORPSE then
					--race_info(obj.flags[FLAG_MONSTER_IDX]).flags[FLAG_I_AM_A_BIRD] then
					local race = r_info[1 + get_flag(obj, FLAG_MONSTER_IDX)]
					if has_flag(race, FLAG_I_AM_A_BIRD) then
						-- %material_check = 1
						%found.obj  = obj
						%found.item = item
						return
					end
				end
			elseif obj.tval == TV_BULK_MATERIAL and obj.sval == SV_STEEL then
				%found.obj  = obj
				%found.item = item
				return
			end
		end)

	if not found.obj then
		term.save()
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "The Fan Lady: ")
		term.text_out("Hello. I make beautiful fans. If you can find some nice bird feathers, or some other appropriate material to work with, I'll make you a nice fan to keep you cool for only 100 zeni. \n\n")
		dialogue.conclude()
		term.load()
		if quest(QUEST_FAN_LADY).status == QUEST_STATUS_UNTAKEN then
			change_quest_status(QUEST_FAN_LADY, QUEST_STATUS_TAKEN)
		end
		return
	end

	-- We have a bird
	term.save()
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "The Fan Lady: ")
	term.text_out("Hello. Would you like me to make a fan for you, for only 100 zeni? They're really beautiful!\n\n")
	if player.au > 99 then
		dialogue.helper("Yes, please.", "a")
	else
		dialogue.helper("I'm sorry, I haven't 100 zeni.", "b")
	end
	dialogue.helper("No, thank you.", "c")
	if dball_data.alignment < 0 then
	--	dialogue.helper("Yes, I would like a fan. (But refuse to pay)", "d")
	end
	local ans = dialogue.answer()

	term.load()

	if ans == "a" or ans == "d" then

		local ret, item = get_item("Make a fan from what?",
			"You don't have any suitable materials.",
			USE_INVEN | USE_EQUIP,
			function(o)
				local race = r_info[1 + get_flag(o, FLAG_MONSTER_IDX)]
				if has_flag(race, FLAG_I_AM_A_BIRD) then
					return true
				elseif o.tval == TV_BULK_MATERIAL and o.sval == SV_STEEL then
					return true
				else
					return false
				end
			end)

		if not ret or not item then
			return
		end

		-- Does this create a memory leak?
		local race = r_info[1 + get_flag(get_object(item), FLAG_MONSTER_IDX)]

		-- Remove the bird
		item_increase(item, -1)
		item_describe(item)
		item_optimize(item)

		-- Do we need to make_fully_id'd?
		if has_flag(race, FLAG_I_AM_A_BIRD) and has_flag(race, FLAG_UNIQUE) then
			dball.reward(create_artifact(ART_BASHO_FAN))
		elseif has_flag(race, FLAG_I_AM_A_BIRD) then
			dball.reward(create_object(TV_MISC, SV_FAN))
		else
			dball.reward(create_object(TV_SMALLARM, SV_IRON_FAN))
		end

		-- Deduct zeni
		player.au = player.au - 100
		player.redraw[FLAG_PR_BASIC] = true

		-- dialogue
		term.text_out(color.LIGHT_BLUE, "The Fan Lady: ")
		term.text_out("There you go!")
		quest(QUEST_FAN_LADY).status = QUEST_STATUS_FINISHED

	elseif ans == "b" then
		term.text_out(color.LIGHT_BLUE, "The Fan Lady: ")
		term.text_out("I completely understand.")
	end

end

-- I only hope some Dragonball fan actually trips this quest
function dialogue.TRUNKS_EARLY()
	reincarnation.trunks_early = reincarnation.trunks_early + 1
	term.save()

	term.text_out(color.YELLOW, "You are engulfed in the midst of a ball of energy!")

	for i = 1, 12 do
		fire_cloud(dam.TIME_TRAVEL, 0, 0, 5, 0, player.speed()) --Speed? What's that for?
	end

	term.load()

	dball.place_monster(player.py - 1, player.px, "Trunks")

	term.save()

	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "Trunks: ")
	term.text_out("NOOOOOO!!!! STOP! I WON'T LET YOU DO IT!!!\n\n")
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out("Following the scream, you turn to see a teenage boy with platinum blonde hair, and wearing a large sword on his back, rushing towards you.\n\n")
	term.text_out(color.LIGHT_BLUE, "Trunks: ")
	term.text_out("You monster! How could you do this?!?!?!\n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("What are you talking about? Do what?\n\n")
	term.text_out(color.LIGHT_BLUE, "Trunks: ")
	term.text_out("Don't play dumb! I know you stepped into that one way time machine and I know you're here to use Briefs' time machine to bring your android friends here to destroy the world!\n\n")
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("Time machine? Android friends? What are you talking about?\n\n")
	term.text_out(color.LIGHT_BLUE, "Trunks: ")
	term.text_out("Don't play dumb! You're a time traveller and I know perfectly well you're here to repair Dr. Briefs' time machine! I bet you even have the materials on you right now to do it!\n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("What, these? Sure, I have some wire and solder...but how does that make me a time traveller?\n\n")
	term.text_out(color.LIGHT_BLUE, "Trunks: ")
	term.text_out("Aha! So you admit it! You've never even spoken to Dr Briefs, or seen his time machine! So how could you know exactly what's needed to repair it if you're not a time traveller?!?!?\n\n")
	local notevil = "Ok, I guess you've got me there."
	if dball_data.alignment >= 0 then
		notevil = notevil .. "..but I'm not evil. Really!"
	end
	dialogue.helper(notevil, "a")
	if reincarnation.trunks_early > 0 then
		dialogue.helper("Hahahah! Yes! Bring them on! Androids! Androids!", "b")
	end
	local ans = dialogue.answer()
	term.load()
	term.save()
	if ans == "a" then
		term.text_out(color.LIGHT_BLUE, "Trunks: ")
		term.text_out("This is it for you!\n\n")
		term.text_out("Trunks draws his sword.\n\n")
		dialogue.helper("No, we don't need to fight. I don't really want to bring the androids here.", "a")
		dialogue.helper("Ok. I'll fight you, blondie.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("You...don't...?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("No.\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("That's a relief. I wasn't certain I could beat you. From what I've been told about you, you're a very powerful android. Though...I wouldn't have known it from looking at you. You look awfully weak. I guess you must be supressing your power to blend in.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...umm...right.\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("You really don't want to bring the other androids to the past?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Nope. Not one bit.\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("I'm not sure I believe you, but if you really don't want to bring your friends here then my mission is done. All I had to do was stop you. Tell you what...if you're really serious about not wanting to destroy the earth, then help me talk to my grandfather.\n\n")
			dialogue.conclude()
			term.load()
				-- Implement: Any way to do this now, rather than after the dialogue is finished?
				dball.dungeon_teleport("Dr. Briefs' Laboratory")
				dun_level = 1
				player.py = 4
				player.px = 10
				player.leaving = true
			term.save()
			-- Begin: This is copied from Briefs dialogue, with only minor edits
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("Dr. Briefs!\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Oh. Hello, youngster. What can I do for you?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("You can destroy your time machine!\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Destroy my...whatever for?\n\n")
			term.text_out("Trunks glances at you.\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("I know this is going to be difficult to explain, but I'm...your grandson. Me and " .. player_name() .. " here are both from the future.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out("Over the next few hours Trunks explains a very complicated tale. It seems that he is from a future timeline in which you, " .. player_name() .. ", are an adventurer who was transformed into a biomechanical android by the evil genius behind the Red Ribbon army, Dr Gero. Under his control, you and two other androids ran rampant across the globe, killing people in all corners of the world.\n\n")
			term.text_out("Eventually earths greatest fighter rose together to oppose you, and destroyed the other two of your trio. Enraged, but unable to defeat them on your own, you swore to travel to an earlier time and bring your android friends with you to destroy the earth before the fighters who eventually defeated you had been born.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wait. I'm confused. If that's what happens, why would I be here now?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("We tracked you down after that last battle, the time machine that you used wasn't portable. It could only be set to a specific time, and once you went in, it was a one way trip. We checked the date you went to, now, and realized you must have come to repair and steal Dr Brief's time machine, to use to recover the other Androids.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("So you came after me?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("Yes. I figured I could destroy the time machine myself, but now that you've changed your mind and don't want to use it, I can use it myself to travel back to my own time.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wait...you stepped into that time machine right after I did, right?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("Well...I'm not sure, exactly. The machine was set to relative, not absolute time, so anyone who stepped into it would be sent back 17 years, three days, five hours back. But, we didn't know exactly when you went in, so there was no way to know exactly what time you were sent to. So we just subtracted a couple days and figured I'd get here before you did. Since you had already managed to gather the materials to repair the time machine when I got here, I guess we miscalculated.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("This is not good.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I'm not the android you're after.\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("...what?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Remeber that there had to have been a 'me' before I was transformed by Dr Gero? I'm that me! I haven't even met Dr Gero!\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("So that means...\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("That other 'me' android is stil out there someplace!\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("Maybe " .. gendernouns.heshe .. " hasn't arrived yet. Trunks, how many days back did you set the time machine before you used it?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("Umm...I'm not sure. I was standing in the chamber when Piccolo adjusted the controls.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...Piccolo...?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("Yes. He said 'a couple days' but I didn't ask exactly how many. We were kind of in a rush.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("So how many is 'a couple?' Two? Three? Seven?\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("Yeah...something like that.\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("So in 'two or three to seven days' an evil nasty " .. player_name() .. " android is going to show up and try to fix and steal my time machine.\n\n")
			term.text_out("He pulls out a short wave atomitizer and makes fast work of what's left of his time machine.\n\n")
			term.text_out(color.LIGHT_BLUE, "Trunks: ")
			term.text_out("...but what about me!?!?\n\n")
			term.text_out(color.LIGHT_BLUE, "Dr Briefs: ")
			term.text_out("I'm sorry. I know you were counting on this to get you back, but the fate of the entire planet is at stake.\n\n")
			term.text_out("Trunks is silent.\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_ANDROID_YOU, QUEST_STATUS_TAKEN)
			change_quest_status(QUEST_RETURN_TRUNKS, QUEST_STATUS_TAKEN)
			dball_data.ttq_tripped = 2	-- (Cause of trigger) (Double check this! Is this correct?)
			dball_data.ttq_day_tripped = dball.dayofyear()
			trainer[FLAG_ENROLL_TRUNKS] = 1
		elseif ans == "b" then
			dball_data.trunks_hunt = 1	-- Trunks may now randomly appear as an aggressive
			for_each_monster(function(m_idx, monst)
				if monst.r_idx == RACE_TRUNKS then
					monst.ai = ai.DBT_DEFAULT
					monst.faction = FACTION_DUNGEON
				end
			end)
		end
	elseif ans == "b" then
		dball.chalign(-10000)
		term.text_out(color.LIGHT_BLUE, "Trunks: ")
		term.text_out("NO!!! I won't let it happen! Not again!\n\n")
		dialogue.conclude()
		term.load()
		dball_data.trunks_hunt = 1	-- Trunks may now randomly appear as an aggressive
		for_each_monster(function(m_idx, monst)
			if monst.r_idx == RACE_TRUNKS then
				monst.ai = ai.DBT_DEFAULT
				monst.faction = FACTION_DUNGEON
			end
		end)
	end
end

function dialogue.CAPSULE_CORP()
	term.gotoxy(0, 0)
	term.save()
	term.text_out(color.LIGHT_BLUE, "\nCapsule Corporation:\n")
	term.text_out("Capsule Corporation is the world's leading producer of both civilian and military transportation, and the sole manufacturer of the 'capsule.' Hyperdimensional stasis fields in the form of small, easily portable devices small enough to be carried in a shirt pocket. No matter the size and mass of the object placed in a capsule, the capsule wlil always appear to weigh about a tenth of a pound. In fact, objects placed in capsules are not truly 'inside' them at all, but rather connected via the hyperdimensional chamber within them. You may move a capsule all you want, but its contents never move at all! And, since they are maintained in stasis, they will remain in pristine, untarnished condition forever! Metal will not rust, food will not spoil...it's the miracle of Capsule Corporation. Thank you for your visit.\n\n")
	dialogue.conclude()
	term.load()
end

function dialogue.YAMCHA()
	term.blank_print("", 0, 0) -- To place the cursor
	-- Get everything we need to know
	local ima_yamcha = dball.get_midx_of(RACE_YAMCHA)
	local girls_in_party = party.girls_in_party()
	local yamcha_state = dball_data.yamcha_state

	if yamcha_state == 0 then
		-- Base state: bandit
		if girls_in_party > 0 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Yamcha: ")
			term.text_out("Ahhh....hello! Welcome to my desert home, good sir! As you can - OH NO!!! It's one of THEM!!! \n\n")
			term.text_out(color.LIGHT_RED, "AAAAAAARRRRRRRGGGGHHHHH!!!!!! HELP! HELP! HELP!!!! EEEK!!! AAAHHHH!!!\n\n")
			term.text_out("He runs off, screaming. You look behind you, but you don't see anything out of the ordinary. How very strange.\n\n")
			dialogue.conclude()
			term.load()
			dball_data.yamcha_state = 1
		else
			term.save()
			term.text_out(color.LIGHT_BLUE, "Yamcha: ")
			term.text_out("Hello, traveller. Allow me to introduce myself. I am Yamcha, lone hyena of the desert. This desert. My desert. And you have trespassed on my land. If you wish to live, then hand over all your money and any capsules you have and I will allow you to leave in peace.\n\n")
			if player.au == 0 and dball.player_has_capsules() < 1 then
				dialogue.helper("I'm sorry. I have neither money nor capsules to give you.", "e")
			else
				dialogue.helper("...oh dear. I'm sorry. yes, here you go. All of my money and capsules.", "a")
			end
			dialogue.helper("Wait...are you trying to rob me?", "b")
			dialogue.helper("No, I don't think so.", "c")
			dialogue.helper("Enough of this. (Attack!)", "d")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.save()
				term.text_out("You give Yamcha all of your money and capsules.\n\n")
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Very good. Thank you. It was a pleasure doing business with you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Puar: ")
				term.text_out("Come again, soon!\n\n")
				dialogue.conclude()
				term.load()
				player.au = 0
				player.redraw[FLAG_PR_GOLD] = true
				dball_data.yamcha_state = 1 -- Leave
			elseif ans == "b" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Puar: ")
				term.text_out("This one's not very bright, is he, Yamcha?\n\n")
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Doesn't look that way. No, I'm not 'trying' to rob you. I AM robbing you. Now hand it over. I don't want to have to hurt you.\n\n")
				dialogue.helper("Oh. Ok, then. I'm not looking for trouble. Here you go.", "a")
				dialogue.helper("But I don't really want to give you anything. Why don't you two find a better way to make money?", "b")
				dialogue.helper("I'm not giving you a thing, and you two don't look strong enough to take it.", "c")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					term.save()
					term.text_out("You give Yamcha all of your money and capsules.\n\n")
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Very good. Thank you. It was a pleasure doing business with you.\n\n")
					term.text_out(color.LIGHT_BLUE, "Puar: ")
					term.text_out("Come again, soon!\n\n")
					dialogue.conclude()
					term.load()
					player.au = 0
					player.redraw[FLAG_PR_GOLD] = true
					dball_data.yamcha_state = 1 -- Leave
				elseif ans == "b" then
					term.save()
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Why? What's wrong with banditry? It suits my schedule. Gives me lots of time to think.\n\n")
					term.text_out(color.LIGHT_BLUE, "Puar: ")
					term.text_out("Yep! And it's fun!\n\n")
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Right! So hand it over!\n\n")
					term.text_out(color.LIGHT_BLUE, "Puar: ")
					term.text_out("Yeah! Or else!\n\n")
					dialogue.helper("Ok, you win. Here you go.", "a")
					dialogue.helper("No, sorry guys. I just don't feel intimidated by you two.", "b")
					local ans = dialogue.answer()
					term.load()
					if ans == "a" then
						term.save()
						term.text_out("You give Yamcha all of your money and capsules.\n\n")
						term.text_out(color.LIGHT_BLUE, "Yamcha: ")
						term.text_out("Very good. Thank you. It was a pleasure doing business with you.\n\n")
						term.text_out(color.LIGHT_BLUE, "Puar: ")
						term.text_out("Come again, soon!\n\n")
						dialogue.conclude()
						term.load()
						player.au = 0
						player.redraw[FLAG_PR_GOLD] = true
						dball_data.yamcha_state = 1 -- Leave
					elseif ans == "b" then
						term.save()
						term.text_out(color.LIGHT_BLUE, "Puar: ")
						term.text_out("Not intimidated? But...I'm scary! Raaawwwwrrr!!! Quick, Yamcha! Grab his stuff whie he's cowering in terror!\n\n")
						dialogue.conclude()
						term.load()
					end

				elseif ans == "c" then
					term.save()
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Well, then. Let's find out, shall we?\n\n")
					term.text_out(color.LIGHT_BLUE, "Puar: ")
					term.text_out("Rob him blind, Yamcha!\n\n")
					dialogue.conclude()
					term.load()
					dball_data.yamcha_state = 2 -- Rob then run
				end
			elseif ans == "c" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("You don't 'think' so? Well then, I suggest you stop thinking so much, and start handing stuff over. Or else I'm gonna take it. It's up to you.\n\n")
				term.text_out(color.LIGHT_BLUE, "Puar: ")
				term.text_out("Yeah! Don't mess with us! We're tough!\n\n")
				dialogue.helper("Bring it on.", "a")
				dialogue.helper("Ahhh...ok, I don't want any trouble. Here you go.", "b")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					term.save()
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Ahh...pity.\n\n")
					term.text_out(color.LIGHT_BLUE, "Puar: ")
					term.text_out("They sure don't make victims like they used to, huh Yamcha?\n\n")
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Nope. Guess not. Hyyyaaa!!!\n\n")
					dialogue.conclude()
					term.load()
					dball_data.yamcha_state = 2 -- Rob then run
				elseif ans == "b" then
					term.save()
					term.text_out("You give Yamcha everything you have of value.")
					dialogue.conclude()
					term.load()
					player.au = 0
					player.redraw[FLAG_PR_GOLD] = true
					dball_data.yamcha_state = 1 -- Leave
				end
			elseif ans == "d" then
				dball_data.yamcha_state = 2 -- Rob then run
			elseif ans == "e" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Oh? Wandering the desert with nothing? Puar, check him out.\n\n")
				term.text_out(color.LIGHT_BLUE, "Puar: ")
				term.text_out("Yes, Yamcha!\n\n")
				term.text_out("(Puar flies over and quickly looks through your belongings.\n\n")
				term.text_out(color.LIGHT_BLUE, "Puar: ")
				term.text_out("He's telling the truth. Nothing that we want.\n\n")
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Hmm. Ok. You may go.\n\n")
				dball_data.yamcha_state = 1 -- Leave
				dialogue.conclude()
				term.load()
			end
		end


	elseif yamcha_state == 1 then
		-- Running away
		if girls_in_party > 0 then
			term.text_out(color.LIGHT_BLUE, "Yamcha: ")
			term.text_out("Aaaarrrrrggghhhhh!!!")
		else
			message("Yamcha is far more interested in leaving than chatting.")
		end

	elseif yamcha_state == 2 then
		term.text_out(color.LIGHT_BLUE, "Yamcha: ")
		term.text_out("Hayaaaaa!!!")

	elseif yamcha_state == 3 then
		-- Allied with player
		message("Hey buddy!")

	elseif yamcha_state == 4 then
		-- Already robbed
		term.save()
		term.text_out(color.LIGHT_BLUE, "Yamcha: ")
		term.text_out("Hmm? What do you want? Go away, I have stuff to do.\n\n")
		dialogue.conclude()
		term.load()

	end



--[[
	if dball_data.yamcha_state == 0 then
		message("Tricky player! trying to cheat around the Yamcha dialogue! Naughty, naughty!")
		dball_data.yamcha_state = 1
		return
	elseif dball_data.yamcha_state > 0 then
		term.save()
		if player.get_sex() == "Female" then
			term.text_out(color.LIGHT_BLUE, "Yamcha: ")
			term.text_out("Ahhh....hello! Welcome to my bridge, good sir! As you can - OH NO!!! It's one of THEM!!! \n\n")
			term.text_out(color.LIGHT_RED, "AAAAAAARRRRRRRGGGGHHHHH!!!!!! HELP! HELP! HELP!!!! EEEK!!! AAAHHHH!!!\n\n")
			term.text_out("He runs off, screaming. You look behind you, but you don't see anything out of the ordinary. How very strange.\n\n")
			dialogue.conclude()
			dball_data.yamcha_state = 4
			term.load()
			if quest(QUEST_BRIDGE_BOY).status == QUEST_STATUS_UNTAKEN then
				change_quest_status(QUEST_BRIDGE_BOY, QUEST_STATUS_TAKEN)
			end
			for_each_monster(function(m_idx, monst)
				if monst.r_idx == RACE_YAMCHA then
					monst.ai = ai.DBT_RUN_AWAY
				end
			end)
			return
		else
			term.text_out(color.LIGHT_BLUE, "Yamcha: ")
			if dball_data.yamcha_state == 1 then
				term.text_out("Ahhh....hello! Welcome to my bridge, good sir! As you can see, it is a sturdy, well-built bridge. In fact, this bridge has stood here resiliently for just over two centuries! Can you imagine! What vision! What engineering! Yes, it really is a most fantastic bridge, if I do say so myself. In fact, when I first stumbled upon it nearly three months ago, I was so amazing with the wonderful marvel here, all alone in the woods, that I thought to myself, 'Yamcha, you should really make people understand what a great bridge this is!' And so, I have spent these past three months aspiring to the most noble purpose of my life...seeing that people respect this bridge. And, what better way for people to respect it than to have to pay to cross it! Ingenius, no? Sometimes I amaze even myself. And so, good sir...since, as I can see in your eyes, you are a good man. A kind man. A WISE man. Surely you will pay the trifling 100 zeni I ask as a toll to cross this magnificent bridge?\n\n")
				dball_data.yamcha_state = 2
			else
				term.text_out("Hello again! I see you have come back to admire this fine bridge. How marvelous! It warms my heart to see such appreciation for the finer things. Please understand though, it would be an insult to the craftsmen for me to offer a repeat-business discount, but as dignified and mannerly a gentleman as you obviously are, I'm sure you'd be offended by paying anything less than the premium. So let us speak no more of it. 100 zeni to cross.\n\n")
			end
			if player.au > 99 then
				if dball_data.yamcha_state == 1 then
					dialogue.helper("Certainly. Never have I seen a finer bridge. A hundred zeni is a small price to pay for the honor of crossing it. (pay)", "a")
				else
					dialogue.helper("Of course! The pleasure is all mine! (pay)", "a")
				end
			else
				dialogue.helper("Hmm. Much as I'd like to, I'm afraid I haven't 100 zeni.", "b")
			end
			dialogue.helper("100 zeni? No, I don't think so.", "c")
			if dball_data.alignment < 0 then
				dialogue.helper("Yes, quite a fine bridge, indeed. And I respect your entrepenuerial enthusiasm for collecting tolls. But I don't recall authorizing it. It might make the boys a bit unhappy to find out about it. But, I'm a kind soul...maybe if you cut me in for a percentage, I won't have to break your legs. Know what I mean?", "d")
			end
			if dball_data.yamcha_robbed == 1 then
				dialogue.helper("You robbed me! I didn't cross, but you took my money anyway!", "e")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				message("You pay, and Yamcha let's you cross.")
				player.au = player.au - 100
				player.redraw[FLAG_PR_BASIC] = true
				if player.py > 51 then
					teleport_player_to(47, 15)
				else
					teleport_player_to(55, 15)
				end
				if quest(QUEST_BRIDGE_BANDIT).status == QUEST_STATUS_UNTAKEN then
					change_quest_status(QUEST_BRIDGE_BANDIT, QUEST_STATUS_TAKEN)
				end
				return
			elseif ans == "b" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Yes, my assistant has already informed me. I understand, completely. Please do come again when you're able to pay.\n\n")
				dialogue.conclude()
				term.load()
				if player.au > 0 then
					timed_effect.inc(timed_effect.ROBBED, 7)
					dball_data.yamcha_robbed = 1
				end
				return
			elseif ans == "c" then
				term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Oh, but sir! Never will you have the opportunity to cross a bridge as fine as this one! Look at the elegant, graceful curve as it gently slides over the water! Touch the stone, do you feel how smooth it is? Inhale the fresh, cool air carried across it by the gentle wind! Yes, a most excellent bridge this is, and I really must insist that you pay 100 zeni to cross it.\n\n")
				if player.au > 99 then
					dialogue.helper("Hmm. I suppose you're right. It is a very nice bridge, and I wouldn't want to offend it. (pay)", "a")
				else
					dialogue.helper("I suppose you're right, but I just don't have the money.", "d")
				end
				dialogue.helper("No. Not going to happen.", "b")
				dialogue.helper("Enough of this nonsense. (attack)", "c")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
					message("You pay, and Yamcha let's you cross.")
					player.au = player.au - 100
						player.redraw[FLAG_PR_BASIC] = true
					if player.py > 51 then
						teleport_player_to(47, 15)
					else
						teleport_player_to(55, 15)
					end
					change_quest_status(QUEST_BRIDGE_BANDIT, QUEST_STATUS_TAKEN)
				elseif ans == "b" then
					term.save()
					dialogue.prep()
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("That's quite alright! I understand competely, sir. We can't all appreciate the finer things in life. Good day to you, then.\n\n")
					dialogue.conclude()
					term.load()
					if player.au > 0 then
						timed_effect.inc(timed_effect.ROBBED, 7)
						dball_data.yamcha_robbed = 1
					end
					if quest(QUEST_BRIDGE_BANDIT).status == QUEST_STATUS_UNTAKEN then
						change_quest_status(QUEST_BRIDGE_BANDIT, QUEST_STATUS_TAKEN)
					end
				elseif ans == "c" then
					if quest(QUEST_BRIDGE_BANDIT).status == QUEST_STATUS_UNTAKEN then
						change_quest_status(QUEST_BRIDGE_BANDIT, QUEST_STATUS_TAKEN)
					end
					for_each_monster(function(m_idx, monst)
						if monst.r_idx == RACE_YAMCHA then
							monst.ai = ai.ZOMBIE
							monst.faction = FACTION_DUNGEON
						end
					end)
					return
				elseif ans == "d" then
					term.save()
					term.text_out(color.LIGHT_BLUE, "Yamcha: ")
					term.text_out("Yes, I understand, completely. Please do come again when you're able to pay.\n\n")
					dialogue.conclude()
					term.load()
					if player.au > 0 then
						timed_effect.inc(timed_effect.ROBBED, 7)
						dball_data.yamcha_robbed = 1
					end
					return
				end
			elseif ans == "d" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("...ummm...I...yeah. Sure. That seems reasonable to me. Here...umm, here's all the money I've collected today, and - oh! I just remembered that I have some errands I still need to finish....so, I'll just be going now. G'bye!\n\n")
				term.text_out("(He quickly scampers off)\n\n")
				dialogue.conclude()
				term.load()
				dball.chalign(-50)
				player.au = player.au + rng(200,300)
				player.redraw[FLAG_PR_BASIC] = true
				return
			elseif ans == "e" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Yamcha: ")
				term.text_out("Oh dear! Why, I did no such thing! It must have been my assistant, Puar. He doesn't occasionally become overzealous about these things, and I'm afraid he isn't entirely human, and he never did quite catch on to the concept of a 'refund.' I'm very sorry. All I can suggest is that you bring enough money to pay the toll next time you visit...so that there will be more further 'misunderstandings.'\n\n")
				dialogue.conclude()
				term.load()
			end
		end
	elseif dball_data.yamcha_state == 4 then
		message("Eeek! Eeek! Help! Help! (Leave the poor boy alone! He's not implemented yet!)")
	end
]]


end

function dialogue.TOXIC()
	dialogue.prep()
	term.gotoxy(0, 0)

	if dball_data.toxic_state == 0 then
		term.text_out(color.LIGHT_BLUE, "\nCustomer Relations: ")
		term.text_out("Hello! Thank you for your interest in our company! We are the largest supplier of widgets in this region, and our manufacturign processes are extremely high-tech! We are fully certified by both the national emmissions and environmental protection agencies to be an A-class non-polluter! That means that our products are completely safe, and cause absolutely no harm to the environment!\n\n")
		dialogue.helper("Ok. Thanks.", "a")
		dialogue.helper("What's a widget?", "b")
		if quest(QUEST_TOXIC_RIVER).status == QUEST_STATUS_TAKEN then
			if dball_data.splinter_story == 1 then
				if dball.player_has_kidx(lookup_kind(TV_POTION, SV_NUCLEAR_WASTE)) then
					dialogue.helper("There are mutants in the sewers who claim that your nuclear waste canisters are responsible for their mutation. And this canister is clearly labeled as belonging to you.", "c")
				else
					dialogue.helper("I have proof of the hazards of your pollution! I found a mutant rat and some turtles in the sewers.", "d")
				end
			elseif dball.player_has_kidx(lookup_kind(TV_POTION, SV_NUCLEAR_WASTE)) then
				dialogue.helper("I found a nuclear waste canister in the sewers.", "e")
			else
				dialogue.helper("Do you realize there's a river of toxic sludge leading from your factory into the sewers?", "f")
			end
		end
		local ans = dialogue.answer()
		if ans == "a" then
		elseif ans == "b" then
			dialogue.store_hack(15)
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("I'm glad you asked! Widgets are our number one, best selling product! They come in a variety of colors, and at this particular plant we manufacture all twelve of the major varieties!\n\n")
			dialogue.helper("Oh. Thank you.", "a")
			dialogue.helper("Ok...but what is one?", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				dball_data.toxic_quest_desc = 3
			elseif ans == "b" then
				dialogue.store_hack(15)
				--term.save()
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
				term.text_out("What's a widget, you ask? Why...widgets are the most absolutely useful devices ever mass produced! Every household and small business should have at least three or four on hand. How many widgets do you own?\n\n")
				dialogue.helper("Me? I don't own any widgets.", "a")
				dialogue.helper("Oh, gee...I don't know, it's hard to keep track of how many I have.", "b")
				-- Implement: dialogue.helper("You're not answering my question. WHAT'S A WIDGET!?!?", "c")
				local ans = dialogue.answer()
				--term.load()
				if ans == "a" then
					dialogue.store_hack(15)
					dialogue.prep()
					term.text_out("(He looks aghast)\n\n")
					term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
					term.text_out("You don't own a widget!?!? Not one? Oh dear, you poor " .. gendernouns.boygirl .. "! No wonder you came here today. Here...since we here at Widget Co. care so deeply for our customers, let me sell you one of our floor models at the heavily discounted price of 100 zeni.\n\n")
					if player.au > 99 then
						dialogue.helper("Ok.", "a")
					else
						dialogue.helper("Gee, I'd love to, but I haven't 100 zeni on me right now.", "b")
					end
	
					dialogue.helper("No, thank you.", "c")
					local ans = dialogue.answer()
					if ans == "a" then
						dialogue.store_hack(15)
						-- term.save()
						player.au = player.au - 100
						local obj_wid = create_object(TV_MISC, SV_WIDGET)
						dball.reward(obj_wid)
						term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
						term.text_out("Excellent! Please come again soon!\n")
						dialogue.conclude()
					elseif ans == "b" then
						dialogue.store_hack(15)
						-- term.save()
						term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
						term.text_out("Ahh...well, I'm sorry, you'll have to just stare with empty longing and yearning through the display window...feeling the emptiness consume you as your heart and soul wrack in the agony of not owning a widget. I feel for you. I really do.\n\n")
						dialogue.conclude()
					elseif ans == "c" then
						dialogue.store_hack(15)
						term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
						term.text_out("No? Are you sure you're feeling ok? Not wanting to buy a widget is...well, sort of peculiar. Are you a terrorist or something?\n\n")
						dialogue.conclude()
					end
				elseif ans == "b" then
					dialogue.store_hack(15)
					dialogue.prep()
					term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
					term.text_out("Oh, how marvelous! Yes, we do so love customers like you! Please feel free to stop by anytime!\n\n")
					dialogue.conclude()
				elseif ans == "c" then
					-- Implement angry what's a widget path
				end
			end
		elseif ans == "c" then
			local bribe = player.stat(A_CHR) * 1000
			dialogue.store_hack(15)
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("I...you...umm, really? Huh. Maybe...maybe we can come to an understanding over this? You're a busy " .. gendernouns.manwoman .. " and I'm sure you have more important things to do than turn us in to the authorities. Of course, it must be inconvenient having important things to do...but lacking the funds to do them, right?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Are you trying to bribe me?")
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("Me? Bribe?!?! Why...'bribe' is such an unpleasant word. Call it just payment for your efforts to bring to our attention something we really didn't know about! Yes. Yes, that's it. Thank you so much! You've really done us a greaty service, and it would only be proper for us to reward you, say...umm, how does " .. bribe .. " sound?\n\n")
			dialogue.helper("No. I'm turning you in.", "a")
			dialogue.helper("Yes, I think we understand each other. " .. bribe .. " is a suitable reward.", "a")
			if dball.persuade(20) then
				dialogue.helper("(Persuade 20) I think " .. bribe * 2 .. " is really an insignificant sum to stay in business. Don't you?", "c")
			end
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
				term.text_out("Wait! Can't we come to an arrangement?!!??\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Absolutely! Our arrangement is that I'm reporting you and you're going out of business. There will be no more radioactive waste in my local sewer.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.toxic_state = 10
			elseif ans == "b" then
				player.au = player.au + bribe
				term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
				term.text_out("Excellent! I assume cash will be acceptable?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Absolutely. It's been a pleasure doing business with you.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.toxic_state = 11
			elseif ans == "c" then
				player.au = player.au + bribe * 2
				term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
				term.text_out("I suppose you're right. Very well.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Thank you. It's been a pleasure doing business with you.\n\n")
				dialogue.conclude()
				term.load()
				dball_data.toxic_state = 11
			end			

			change_quest_status(QUEST_TOXIC_SLUDGE, QUEST_STATUS_FINISHED)
			
		elseif ans == "d" then
			dialogue.store_hack(15)
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("Mutant rat? Turtles? What does that have to do with us? There are a number of perfectly natural causes for mutation. Why, maybe the sewer creatures are merely evolving! \n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("You're joking, right?\n\n")
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("Not at all! Why...I feel for those poor creatures, I really do! Thousands and thousands of years of crawling on their bellies, and now that they're finally starting to evolve into intelligent bipeds, here you come and try to pretend that they didn't do it on their own! That they had to have some sort of 'magic' help from some sort of fantasy nuclear waste products! You really are a rude and despicable person. Please leave. I just can't deal with how inconsiderate you are.\n\n")
			dialogue.conclude()
			term.load()
			if dball_data.toxic_quest_desc < 6 then
				dball_data.toxic_quest_desc = 5
			end
		elseif ans == "e" then
			dialogue.store_hack(15)
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("Nuclear waste? Nonsense! Our only by prodicts are the perfetly legal-oh. You have it with you? Let me see. Ahh. Hmm. Yes, this does appear to be ours. BUT! You see how it is in a perfetly secure container? This just proves how responsible our company is, going to such great lengths to protect the environment! Why, there's aren't ANY federal regulations requiring nuclear waste dumped in the sewers to be tightly secured like this!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Probably because you're not suposed to do it at all.")
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("That's totally besides the point. Here we are going above and beyond the call of duty to keep our products safe, and you're accusing uf os some sort of malfeasence? Don't you care about the environment?!!? I feel bad for you. I really do.\n\n")
			dialogue.conclude()
			term.load()
			if dball_data.toxic_quest_desc < 5 then
				dball_data.toxic_quest_desc = 4
			end
		elseif ans == "f" then
			dialogue.store_hack(15)
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
			term.text_out("Toxic sludge? What toxic sludge? Oh! You mean our clean-air disposal process! That's not toxic sludge! That's environmentally-friendly manfacturing residue, certified by two separate federal entities to be acceptably benign and reasonably free of harmful contaminants! We at Widget Co. pride ourselves on our policy to absolutely conform to government regulations and our ability to surpass even the strictest requirements!\n\n")
			dialogue.helper("Hmm. Ok, I guess that's ok then.", "a")
			dialogue.helper("Look...I took poison damage just from walking through the stuff. Can you imagine what tons of that stuff sitting around for years in the open air is going to do?", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				dball_data.toxic_quest_desc = 3
			elseif ans == "b" then
				dialogue.store_hack(15)
				dialogue.prep()
				term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
				term.text_out("Look, federal regulations say we're not allowed to discharge waste with more than 500 radioactive, toxic, or biologically active parts per thousand. Our by-products are only 498 parts per thousand. You know what the rest is? WATER! Water is totally harmless! You drink it every day, your own body is MADE of the stuff. Do you realize that YOU are roughly seventy percent water? That means our manufacturing by-products are only twenty percent away from matching the water concentration of your body! You could probably drink the stuff and it would be perfectly safe!\n\n")
				term.text_out("(He suddenly realizes something...and his eyes narrow)\n\n")
				term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
				term.text_out("Wait...did you say that you WALKED in it?\n\n")
				dialogue.helper("Yes.", "a")
				dialogue.helper("Me? No, you must have misheard me.", "b")
				local ans = dialogue.answer()
				if ans == "a" then
					dialogue.store_hack(15)
					dialogue.prep()
					term.text_out("(He backs up with a look of horror on his face, and quickly covers his mouth)\n\n")
					term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
					term.text_out("Contamination alert! I need security here NOW!\n\n")
					term.text_out("(Within seconds, three burly guards wearing full body radiation suits burst into the room, grab you and throw you outside.)\n\n")
					term.text_out("(Or at least they will...as soon as I figure out a way to remove you from the store myself. In the meantime though, if you could just press 'escape' a couple times that would be very helpful. Thank you.)\n\n")
					dialogue.conclude()
					dball_data.toxic_quest_desc = 1
				elseif ans == "b" then
					dialogue.prep()
					term.text_out(color.LIGHT_BLUE, "Customer Relations: ")
					term.text_out("Good. Because the entire area surrounding the plant is private property. We could easily have you arrested and thrown away for a very long time if you were to trespass. Now, I suggest you get out of here before I have security throw you out. And kindly don't come back with these slanderous lies and ridiculous accusations.\n\n")
					dialogue.conclude()
					dball_data.toxic_quest_desc = 2
				end
			end
		end		
	elseif dball_data.toxic_state == 10 then
		term.text_out(color.LIGHT_BLUE, "\nCustomer Relations: ")
		term.text_out("We're ruined because of you!\n\n")
		dialogue.conclude()
	elseif dball_data.toxic_state == 11 then
		term.text_out(color.LIGHT_BLUE, "\nCustomer Relations: ")
		term.text_out("Good day, sir.\n\n")
		dialogue.conclude()
	else
		message("Unknown dball_data.toxic_state!")
	end
end

function dialogue.GEORGE()
	dialogue.store_hack(15)
	-- Redundant?
	term.gotoxy(0, 0)

	-- First check second quest status
	if quest(QUEST_DESTROY_THE_FOOT).status == QUEST_STATUS_TAKEN then
		message("Please hurry! I'm losing money every day those ninja stay in operation!")
	elseif quest(QUEST_DESTROY_THE_FOOT).status == QUEST_STATUS_COMPLETED then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "George: ")
		term.text_out("Hello! I just received my first shipment in months! You really did it! Thank you so much! Here, let me me pay in full all the money I agreed to give you. Now that I actually have something to sell, I should be able to get my business running again. ")
		term.text_out(color.YELLOW, "Of course, I hope it doesn't run so fast I can't catch it! ")
		term.text_out("Hehe...that's a little joke. In any case, thank you for your help!")
		dialogue.conclude()
		jokes[0] = 1
		player.au = player.au + dball_data.goods_total_reward
		change_quest_status(QUEST_DESTROY_THE_FOOT, QUEST_STATUS_FINISHED)
	elseif quest(QUEST_DESTROY_THE_FOOT).status == QUEST_STATUS_FINISHED then
		message("Thank you again for putting me back in business!")

	-- Next, check first quest status
	elseif quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_UNTAKEN then
		dialogue.prep()
		term.text_out(color.LIGHT_BLUE, "George: ")
		term.text_out("Business has been tough lately. Half of my shipments are being hijacked en route. I have insurance, but I still need to have merchandise to sell! I don't know much about what's going on, but I'd pay a pretty penny to anyone who could find out.\n\n")
		dialogue.conclude()
		change_quest_status(QUEST_STOLEN_GOODS, QUEST_STATUS_TAKEN)

	elseif quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_TAKEN then
		dialogue.prep()

		term.text_out(color.LIGHT_BLUE, "George: ")
		term.text_out("Have you any new information for me on who's been hijacking my shipments?\n\n")
		dialogue.helper("No, nothing yet.", "a")
		-- If shredder dead...
		-- if taken over leadershop of Foot...
		if dball_data.goods_lazarus == 1 then
			dialogue.helper("Lazarus, the owner of the Pawnshop says he's been buying electronics from a group of people who show up dressed head to toe in black. He figures the stuff he's buying is probably stolen.", "c")
		end
		if dball_data.goods_akira == 1 then
			dialogue.helper("Akira, the chef at the sushi bar says the pattern of the crimes greatly resembles a crime wave that hit Japan several years ago. It that case, it turned out to be a band of ninja who were responsible.", "d")
		end
		if dball_data.goods_warehouse == 1 then
			dialogue.helper("There's a group of ninja who have some sort of operation going on that island just northeast of here. A bunch of juviniles, and I found lots of electronics goods still in their original packaging. That can't be a coincidence.", "e")
		end
		if dball_data.goods_splinter == 1 then
			dialogue.helper("I've spoken with a mutant in the sewers who says the whole operation is being carried out by a Ninja Master by the name of Oroku Saki. He's recently come from japan and is attempting to establish an evil empire here, similar to the one he had in Japan many years ago. He's the one responsible for all the problems you've been having.", "f")
		end
		local ans = dialogue.answer()
		if ans == "a" then
			return
		elseif ans == "b" then
			-- reserved for 'taken control of the Foot'
			-- should be two spaces reserved...another for defeated shredder (yes, actually completed the quest)
		elseif ans == "c" then
			dialogue.store_hack(15)
			dball_data.goods_lazarus = 2
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "George: ")
			term.text_out("Lazarus! That rat! I should have known he'd be mixed up in this. You'd think anyone who's been around as long as he has would have learned to play nice by now. ")
			if dball_data.goods_splinter == 2 then
				term.text_out("'Men in black' huh? That certainly would corroborate the story your rat friend gave us. I know we're on the right track, but I still don't have enough that I could go to the police with. What am I going to tell them? Some random mutant who's a ninja, but isn't bad, says that the guys who Lazarus is buying stuff from are also ninja...but are bad? I still need more.\n\n")
			elseif dball_data.goods_akira == 2 then
				term.text_out("'Men in black?' Hmm. I guess that would make sense if the ninja Akira mentioned have set up shop here. Oh dear...this sounds like it may be a lot more than just a bunch of thieves like I suspected. Still, so far it's all just speculation. Men in black...an event from years ago in Japan...you're doing well, but I really need something more substantial.\n\n")
			else
				term.text_out("Still...we have no idea who's actually responsible. 'Men in black' isn't exactly very helpful. I need more information than that.\n\n")
			end
			dialogue.conclude()
		elseif ans == "d" then
			dialogue.store_hack(15)
			dball_data.goods_akira = 2
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "George: ")
			if dball_data.goods_splinter == 2 then
				term.text_out("Hmm. I know Akira. He's a good man. And what he's saying does go along with the ninja story your rat gave you. Look, maybe I'm convinced...but we still don't have the kind of solid evidence I need if I were to go to the police. I need more.\n\n")
			elseif dball_data.goods_lazarus == 2 then
				term.text_out("Ninja? I guess that would explain the 'men in black' that Lazarus said he was buying from. So far, this is all just speculation though. I need something solid.\n\n")
			else
				term.text_out("So you're saying that ninja are responsible for this? Sorry...I have a tough time buying that. Sure...some crazy stuff goes on in this world, but it seems to me there are far simpler explanations. Occam's Razor, and all. Look...let's pretend for a moment it really is ninja who are responsible. I need something substantial to prove it. I can't just go to the police and say 'Hey! Some random Japanese guy says this kind of resembled something that happened years ago in Japan! Go arrest somebody!' It just doesn't work that way. At this point, I'm losing so much money I really wouldn't care if it were ninja, you or the Easter Bunny responsible, but whomever it is, I need proof.\n\n")
			end
			dialogue.conclude()
		elseif ans == "e" then
			dialogue.store_hack(15)
			dball_data.goods_warehouse = 2
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "George: ")
			term.text_out("You actually saw ninja running around with boxes of electronics? Wow...maybe we're really on to something here. But what am I going to do about a band of ninja thieves? I don't think the police will be able to deal with this. ")
			if quest(QUEST_CRIMINAL).status == QUEST_STATUS_TAKEN then
				term.text_out("I hear they can't even catch that crazy " .. gendernouns.guygirl .. " who threatened Sakura. Poor girl. ")
			end
			local how_well = dball_data.goods_lazarus + dball_data.goods_akira + dball_data.goods_warehouse + dball_data.goods_splinter
			local reward_money = how_well * 10 * player.stat(A_CHR)
			term.text_out("Well...I did promise you a reward for finding out what was going on, and you've ")
			if how_well > 6 then
				term.text_out("completely surpassed my expecations.")
			elseif how_well > 4 then
				term.text_out("done rather well.")
			elseif how_well > 2 then
				term.text_out("discovered some good information.")
			else
				term.text_out("done ok, I guess.")
			end
			term.text_out(" Here's " .. reward_money .. " zeni right now. You've earned it.\n\n")
			term.text_out("(Received " .. reward_money .. " zeni)\n\n")
			player.au = player.au + reward_money
			term.text_out("Unfortunately, even knowing who's responsible doesn't help me all that much. The police aren't going to buy our story, my shipments are still being hijacked, and I'm losing money every day. So let me make you a deal. If you can completely put a stop to their operation, I'll give you double what I've already given you. That's " .. reward_money * 2 .. " zeni on top of what I've already paid you. You interested?\n\n")

			dialogue.helper("That's a good offer. Alright. I'll see what I can do.", "a")
			if dball.persuade(12) then
				dialogue.helper("(Persuade 12) Gee, I don't know. The money's ok, I guess, but we're talking an entire ninja clan...and like you say, you're losing money every day, and the police aren't going to help you. Is " .. reward_money * 2 .. " really all it's worth to you to stay in business?", "b")
			end
			dialogue.helper("No, I was happy to play detective for you, but I'm not about to take on an entire ninja clan", "c")
			local ans = dialogue.answer()
			if ans == "a" then
				dialogue.store_hack(20)
				dball_data.goods_total_reward = reward_money * 2
				term.text_out(color.LIGHT_BLUE, "George: ")
				term.text_out("Great! If things didn't get better soon, I probably would have had to close my shop, but once those shipments start coming again, I'll be back in business! Let me know as soon as those ninja are gone. The money will be as good as yours!\n\n")
				dialogue.conclude()
				change_quest_status(QUEST_STOLEN_GOODS, QUEST_STATUS_FINISHED)
				change_quest_status(QUEST_DESTROY_THE_FOOT, QUEST_STATUS_TAKEN)
			elseif ans == "b" then
				dball_data.persuades = dball_data.persuades + 1
				dialogue.store_hack(20)
				dball_data.goods_total_reward = reward_money * 4
				term.text_out(color.LIGHT_BLUE, "George: ")
				term.text_out("Well, I guess you're right. It's either you or...bankruptcy. Ok. I'll double my offer. That's " .. reward_money * 4 .. "zeni. That's really the best I can do. Let me know when they're gone. If things don't improve soon I'm going to have to close down my shop.\n\n")
				dialogue.conclude()
				change_quest_status(QUEST_STOLEN_GOODS, QUEST_STATUS_FINISHED)
				change_quest_status(QUEST_DESTROY_THE_FOOT, QUEST_STATUS_TAKEN)
			elseif ans == "c" then
				dialogue.store_hack(20)
				dball_data.goods_store_closed = 1
				term.text_out(color.LIGHT_BLUE, "George: ")
				term.text_out("I...understand. Honestly, I wouldn't go near them myself. I'm sorry I can't offer you more money, but I'm just about broke from all this. I guess I'll just have to close up shop. Maybe I'll relocate to a safer area. Alright, well...thanks for your help. I appreciate it. I just wish things had turned out better.\n\n")
				dialogue.conclude()
				quest(QUEST_STOLEN_GOODS).status = QUEST_STATUS_FINISHED
			end
		elseif ans == "f" then
			dialogue.store_hack(15)
			dball_data.goods_splinter = 2
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "George: ")
			if dball_data.goods_lazarus == 2 then
				term.text_out("Ninja? Wow...that would explain the whole 'men in black' thing that Lazarus was talking about. We still don't have any real evidence though. Besides...this rat you met in the sewers was a ninja himself. How do you know he's not lying to you just to make his rivals look bad? We really need more evidence than this.\n\n")
			elseif dball_data.goods_akira == 2 then
				term.text_out("That corroborates the story Akira gave. Wow. Ninja. I think it's going to be awfully difficult to convince the police that ninja are hijacking my shipments. I'm sorry...I really need more evidence. I think I believe you myself, but nobody else will. I need something more concrete.\n\n")
			else
				term.text_out("Excuse me? And what exactly made you think to look in the sewers for answers to my hijacking problems? No...don't answer that. I don't want to know. Look...at this point, I don't care if it's the tooth fairy stealing my stuff, I just need it to stop. If what this rat says is true...ok, great. But I'm going to have to have proof.\n\n")
			end
			dialogue.conclude()
		end

	elseif quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_FINISHED then
		if dball_data.goods_store_closed == 1 then
			message("Yeah...I'm packing my things. What's left anyway. I'll be leaving soon.")
		else
			message("Thanks again for helping me out!")
		end
	else
		message("Unexpected quest status in dialogue.GEORGE")
	end
end

function dialogue.LAZARUS()
	term.gotoxy(0, 0)
	if quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_TAKEN then
		if dball_data.goods_lazarus < 1 then
			term.text_out(color.LIGHT_BLUE, "\nLazarus: ")
			term.text_out("Ok! Ok! I confess! I've been buying goods from these people...they show up dressed head to toe in black and sell me stuff still in the original box for cheap! Yeah, I figured it was probably stolen, but what point was there in looking a gift hose in the mouth?\n\n")
			dialogue.conclude()
			dball_data.goods_lazarus = 1
		else
			message("What? I already told you everything.")
		end
	elseif quest(QUEST_DESTROY_THE_FOOT).status == QUEST_STATUS_FINISHED or quest(QUEST_KILL_SHREDDER).status == QUEST_STATUS_FINISHED then
		message("It sure has been tough finding good merchandise lately.")
	else
		message("Yes, there's a pool hall around here someplace.")
	end
end

-- Various Juviniles in the Foot Lair
function dialogue.JUVINILE()
	monster_random_say
		{
			"The juvinile says 'sup?'",
			"He nods noncommitally at you.",
			"The juvinile says 'Hey dude.'",
			"The juvinile says 'I like your duds.'",
		}
end

function dialogue.WHINY_ARU()
	term.save()
	dialogue.prep()
	term.text_out(color.LIGHT_BLUE, "Aru Villagess: ")
	local aru_which = rng(1,3)

	if dball_data.oolong_resolution > 2 or quest(QUEST_OOLONG).status == QUEST_STATUS_COMPLETED then
		term.load()
		if aru_which == 1 then
			term.text_out("Oh no! Who are we going to mooch off of now??!?!")
		elseif aru_which == 2 then
			term.text_out("*sigh* I guess I didn't expect the gravy train to last forever.")
		elseif aru_which == 3 then
			term.text_out("At least I got some good jewelery out of all this.")
		end
		return

	elseif player.get_sex() == "Female" then
		if aru_which == 1 then
			term.text_out("Oh look...another bimbo here to mooch off of Oolong. Sorry missy...there are too many of us as it is. Get lost.\n\n")
		elseif aru_which == 2 then
			term.text_out("...what, another one? Look here, we can't have any more getting in on this! Oolong's rich, but if there are too any of us, sooner or later he's going to catch on. I say, we were here first. So get lost.\n\n")
		elseif aru_which == 3 then
			term.text_out("We know why you're here! Get lost! Sooner or later the camel's back is going to break, and every one of you newbies who come in make it all the more difficult for the rest of us. Go away! We dont want you here!\n\n")
		end
	else
		if aru_which == 1 then
			term.text_out("At last! It's been HOURS since we ordered! What took you so- ...oh. You're not the caterer. You don't look like a manicurist, either. Oolong doesn't have any friends, so you're not here to see him...who are you? What are you doing here?\n\n")
		elseif aru_which == 2 then
			term.text_out("Hey...hey you! Servant! I need new bedsheets! Some idiot left a pea under my bed! ...what? What are you looking at me like that for?\n\n")
		elseif aru_which == 3 then
			term.text_out("Well, it's about time you showed up! You didn't really expect me to make my own bed, did you! Get to it! Lazy servants. Why...I should have you fired!\n\n")
		end
	end
	dialogue.helper("...hi. I'm just exploring...saw the castle, thought I'd check it out.", "a")
	if quest(QUEST_OOLONG).status == QUEST_STATUS_TAKEN then
		dialogue.helper("Actually, I'm here to rescue you. Marcos from Aru said that Oolong was kidnapping village girls.", "b")
	end
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Aru Villagess: ")
		term.text_out("Eeeewwww! An adventurer? What a buzz kill! How yucky! Go away! We don't want you here!\n\n")
		dialogue.conclude()
		term.load()
	elseif ans == "b" then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Aru Villagess: ")
		term.text_out("WHAT!?!? Marcos...that...grr! Of course, he's so stupid, he probably even believes that! Every girl in the village would give her right arm to be here. Well, most of us anyway. Oolong is one rich pig! A wimpy little pushover, too, and we can get anything we want out of him! No, we're all doing very well thank you, so just go back home and tell Marcos to deal with it! Why...even if it weren't for Oolong, no girl in her right mind would be interested in such a self-involved, arogant nerf-herder like him anyway!\n\n")
		if dball_data.oolong_quest_helper == 0 then
			dball_data.oolong_quest_helper = 1
		end
		dialogue.conclude()
		term.load()
	end
end

function dialogue.FOOT_HELPER()
	if dball_data.foot_clan_rapport < 2 then
		message("The ninja is silent, like all good ninja should be.")
	elseif dball_data.foot_clan_rapport < 5 then
		message("The Foot ninja nods in acknowledgement.")
	elseif dball_data.foot_clan_rapport == 5 then
		message("Your minion bows respectfully.")
	elseif dball_data.foot_clan_rapport == 999 then
		message("The ninja is silent, like all good ninja should be.")
	else
		message("Error: Unknown foot clan rapport state. State is: " .. dball_data.foot_clan_rapport)
	end
end

-- Bob, the Welcome Ninja explains what's going on when you arrive
-- on the Inner Sanctum level of the Ninja Warehouse
function dialogue.NINJA_GREETER()
	quest(QUEST_BEING_WATCHED).status = QUEST_STATUS_COMPLETED
	if dball_data.foot_clan_rapport == 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Foot Ninja: ")
		term.text_out("Greetings, " .. player_name() .. ". You have done well to have found our secret lair. You have slain many of our kindred on your way, but we are not your enemy. Only a fierce warrior such as yourself could have made it this far, and we of The Foot respect strength. You have earned our respect. If you do not attack us, we will not attack you.\n\n")
		term.text_out("Our Master has watched your progress, and now that you have made it to our Inner Sanctum, he would like to speak with you. If you choose to hear his words, I will arrange it. If you do not wish to hear him, then leave our sacred hall now, and the Foot Clan Ninja will leave you forever in peace.\n\n")
		dialogue.helper("I will speak with your master.", "a")
		dialogue.helper("I will leave.", "b")
		dialogue.helper("I am here to detroy your clan.", "c")
		local ans = dialogue.answer()
		term.load()
			term.save()
		if ans == "a" then
			dball_data.foot_clan_rapport = 1
			term.text_out(color.LIGHT_BLUE, "Ninja: ")
			term.text_out("This pleases us. Follow the lighted path to reach our Master. Please do not stray into the unlit area. As Ninja, there are secrets we hold that none may know.\n\n")
			dialogue.conclude()
			cave_set_feat(20, 3, FEAT_FLOOR)
			term.load()
		elseif ans == "b" then
			term.save()
			dball_data.foot_clan_rapport = 4
			term.text_out(color.LIGHT_BLUE, "Ninja: ")
			term.text_out("Very well. We will no longer interfere in your affairs. Do not interfere any longer with ours.\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "c" then
			dball.faction_annoy(FACTION_FOOT)
			dball_data.foot_clan_rapport = 3
			term.text_out(color.LIGHT_RED, "Foot Ninja: ")
			term.text_out("Very well. Strength cannot be argued with. If you are the stronger, you shall prevail. If not...you shall die.\n\n")
			dialogue.conclude()
			term.load()
		end
		
	elseif dball_data.foot_clan_rapport == 1 then
		term.save()
		term.text_out(color.LIGHT_RED, "Foot Ninja: ")
		term.text_out("Greetings, " .. player_name() .. ". If you wish to speak with our Master, follow the lighted path. Do not stray from it.\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.foot_clan_rapport == 2 then
		message("The Foot Ninja nods respectfully to you.")
	elseif dball_data.foot_clan_rapport == 3 then
		message("The time for words has passed.")
	elseif dball_data.foot_clan_rapport == 4 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Ninja: ")
		term.text_out("Greetings, " .. player_name() .. ". Why have you returned? (implement branch)\n\n")
		dialogue.conclude()
		term.load()
	elseif dball_data.foot_clan_rapport == 5 then
		-- Player is the leader of the Clan
	else
	end
end

function dialogue.SPLINTER()
	local leonardo = dball.how_many_exist(RACE_LEONARDO)
	local donatello = dball.how_many_exist(RACE_DONATELLO)
	local michaelangelo = dball.how_many_exist(RACE_MICHAELANGELO)
	local raphael = dball.how_many_exist(RACE_RAPHAEL)
	local turtle_count = leonardo + donatello + michaelangelo + raphael

--if dball_data.goods_splinter == 1 then

	term.save()
	term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
	if dball_data.splinter_state == 0 then
		dball_data.splinter_state = 1
		-- First contact
		term.text_out("Greetings, my child. Welcome to our hidden home below the ground.\n\n")
		if player.stat(A_CHR) > 9 then
			dialogue.helper("Hello. My name is " .. player_name() .. ". Who are you?", "a")
		else
			dialogue.helper("Umm...what are you?", "a")
		end
		if quest(QUEST_KILL_SPLINTER).status == QUEST_STATUS_TAKEN then
			if dball_data.alignment < 0 then
				dialogue.helper("I am here to kill you for the Ninja Master, Oroku Saki.", "b")
			else
				dialogue.helper("The Ninja Master, Oroku Saki, has asked me to kill you.", "b")
			end
		end
		if enrollments[FLAG_NINJUTSU] > 0 then
			-- dialogue.helper("You are ninja.", "c")
		end
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			if player.stat(A_CHR) > 9 then
				term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
				term.text_out("Welcome, " .. player_name() .. ". As you are the first from above to find our sacred training hall, I believe it is fate that has brought you here.\n\n")
				if michaelangelo > 0 then
					term.text_out(color.YELLOW, "Michaelangelo: ")
					term.text_out("Whoa! Fate! That's totally awesome!\n\n")
				end
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Sacred training hall? What do you train?\n\n")
				if leonardo > 0 then
					term.text_out(color.LIGHT_BLUE, "Leonardo: ")
					term.text_out("Ninjutsu!\n\n")
				end
				term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
				term.text_out("The art of invisibility.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				local which_resp = "Well, it's been a pleasure to have met the five of you."
				if enrollments[FLAG_NINJUTSU] > 0 then
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("I can tell from your body language that you too, are a practioner of our art.\n\n")
					term.text_out(color.LIGHT_RED, "Raphael: ")
					term.text_out("Are you sayin' " .. gendernouns.heshe .. "'s one of us?\n\n")
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("That remains to be seen.\n\n")
				else
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Wow! You can turn invisible?\n\n")
					term.text_out(color.LIGHT_RED, "Raphael: ")
					term.text_out("Heh. Not so bright.\n\n")
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("Raphael! Be courteous to our guest!\n\n")
					term.text_out(color.LIGHT_RED, "Raphael: ")
					term.text_out("...ok. Sorry.\n\n")
					if michaelangelo > 0 then
						term.text_out(color.YELLOW, "Michaelangelo: ")
						term.text_out("Hehe...Raphie wiped out!\n\n")
					end
					dialogue.conclude()

					term.load()
					term.save()
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("The art of ninja, is the art of being unseen. When mind, heart, and body work together as one, anything is possible.\n\n")
					term.text_out(color.YELLOW, "Michaelangelo: ")
					term.text_out("Dude, all this talking is making me hungry. I think I'm gonna order some pizza.\n\n")
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("Only through this union can the spirit be as one.\n\n")
					term.text_out(color.VIOLET, "Donatello: ")
					term.text_out("I want mushroom and pepperoni on mine!\n\n")
					term.text_out(color.YELLOW, "Michaelangelo: ")
					term.text_out("I'm on it!\n\n")
					which_resp = which_resp .. " I'm sure I'll be seeing you...or 'not' seeing you, again."
				end

				dialogue.helper(which_resp, "a")
				if dball_data.splinter_story == 0 then
					dialogue.helper("I don't mean to be rude, but what exactly are you?", "b")
				end
				if dball.persuade(16) then
					dialogue.helper("(Persuade 16) You say it is fate that brought me here. And I agree. I have been brought here to train with you.", "c")
				else
					dialogue.helper("May I train with you?", "d")
				end
				local ans = dialogue.answer()
				term.load()

				-- We're assuming it's not possible to have already trained with Shredder at this point, yes?

				if ans == "a" then
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("Indeed. Take care, my child.")
				elseif ans == "b" then
					term.save()
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					dialogue.SPLINTER_STORY()
				elseif ans == "c" then
					term.save()
					term.text_out(color.LIGHT_BLUE, "Leonardo: ")
					term.text_out("We're going to have new training parter!\n\n")
					term.text_out(color.YELLOW, "Michaelangelo: ")
					term.text_out("Awesome!\n\n")
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("It seems my students have taken a liking to you. Very well. You may study with us.")
					dialogue.conclude()
					term.load() 
					dball.enroll(FLAG_ENROLL_SPLINTER)
					dball_data.splinter_state = 2
				elseif ans == "d" then
					term.save()
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("No. Not at this time. I am dedicated to my current pupils, and they are not ready to ontinue on their own without my undivided attention.\n\n")
					term.text_out(color.LIGHT_RED, "Raphael: ")
					term.text_out("Yeah. We don't need some new " .. gendernouns.guygirl.. " messin' with our training.\n\n")
					term.text_out(color.YELLOW, "Michaelangelo: ")
					term.text_out("Dude...but it would be so awesome to have a new sparring partner!\n\n")
					term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
					term.text_out("Perhaps in the future. But not now, my child.\n\n")
					dialogue.conclude()
					term.load()
				end


			else
				term.text_out("Do not be surprised by our form. Yes, you are speaking to a rat. ")
				dialogue.SPLINTER_STORY()
			end

		elseif ans == "b" then
			dialogue.SPLINTER_THREATEN()
		elseif ans == "c" then
			-- you are ninja
		end

	elseif dball_data.splinter_state == 1 then
		term.text_out("Hello again, " .. player_name() .. ". What brings you once again to our hidden home?\n\n")
		dialogue.helper("Just visiting.", "a")
		if dball_data.splinter_story == 0 then
			-- dialogue.helper("Curiosity. Would you tell me how the five of you came to be here?", "b")
		end
		if dball_data.splinter_story == 0 then
			dialogue.helper("Curiosity. I don't mean to be rude, but what exactly are you?", "c")
		end
		if quest(QUEST_KILL_SPLINTER).status == QUEST_STATUS_TAKEN then
			if dball_data.alignment < 0 then
				dialogue.helper("I am here to kill you for the Ninja Master, Oroku Saki.", "d")
			else
				dialogue.helper("The Ninja Master, Oroku Saki, has asked me to kill you.", "d")
			end
		end
		if dball_data.goods_splinter == 0 and quest(QUEST_STOLEN_GOODS).status == QUEST_STATUS_TAKEN then
			dialogue.helper("Do you know anything about the thefts that have been going on?", "e")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
		elseif ans == "b" then
			--
		elseif ans == "c" then
			dialogue.SPLINTER_STORY()
		elseif ans == "d" then
			dialogue.SPLINTER_THREATEN()
		elseif ans == "e" then
			dialogue.SPLINTER_THEFTS()
		end
	elseif dball_data.splinter_state == 1 then
		term.text_out("Welcome, my pupil. Have you come for more training?\n\n")
		dialogue.helper("No, I was just in the area and thought I'd say hello.", "a")
		dialogue.helper("Yes, please.", "b")
		if dball_data.splinter_story == 0 then
			dialogue.helper("I do appreciate the training, but would you tell me how the five of you came to be here? You're really quite the mystery.", "c")
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
			term.text_out("You company is most welome.")
		elseif ans == "b" then
			dball.enroll(FLAG_ENROLL_SPLINTER)
		elseif ans == "c" then
			term.save()
			term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
			dialogue.SPLINTER_STORY()
		end
	elseif dball_data.splinter_state == 999 then
		-- Hostile
	else
	end

end

function dialogue.SPLINTER_STORY()
	dball_data.splinter_story = 1
	term.text_out("Yes, perhaps I should tell you the tale of how we came to be here. Many years ago I was a rat of ordinary size. The pet, of the Ninja Master Hamato Yoshi. My cage was kept in his training hall, and from my earliest years I watched Master Yoshi during his training sessions.\n\n")
	term.text_out("Seven years ago, Master Yoshi was assassinated in his home by the leader of a rival ninja clan known as The Foot. During the fight, my cage was broken, and I was freed. For days I wandered alone, and hungry, until I came here to these sewers. It was here that I found four baby turtles crawling in a strange, glowing ooze from a broken canister.\n\n")
	term.text_out(color.YELLOW, "Michaelangelo: ")
	term.text_out("That was us!\n\n")
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
	term.text_out("But, strangely, over the days that followed, all five of us began to change...to grow. Both in size, as well as intellect. I do not know what brought about our change, but fate is not to be frowned upon. And so, I began training the turtles you see here before you in the art of Ninja. We have made a home for ourselves here in these sewers, venturing up to the surface only on occassion.\n\n")
	if quest(QUEST_TOXIC_RIVER).status == QUEST_STATUS_TAKEN then
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("A strange, glowing ooze? Hmm. The container...what did it look like?\n\n")
		term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
		term.text_out("It was a cylinder, perhaps one foot long, bearing the letters 'Widget' on it. I do not know what this means.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("I do. It's the name of the manufacturing plant near here. Sounds to me like they're dumping radioactive waste into the sewers here.\n\n")
		term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
		term.text_out("From the look on your face, I see this is a matter of great import. Yet, in our case, it seems that the end result has not been entirely unfortunate.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Maybe.\n\n")
	else
	end
	dialogue.conclude()
	term.load()
end

function dialogue.SPLINTER_THEFTS()
	term.save()
	term.text_out(color.YELLOW, "Michaelangelo: ")
	term.text_out("Yep! It's those foot dudes. They totally need to chill out.\n\n")
	term.text_out(color.LIGHT_BLUE, "Splinter: ")
	term.text_out("Indeed. The Foot ninja clan finances their organization by hijacking goods in shipment, and reselling them on the black market.\n\n")
	dialogue.conclude()
	term.load()
end
function dialogue.SPLINTER_THREATEN()
	local leonardo = dball.how_many_exist(RACE_LEONARDO)
	local donatello = dball.how_many_exist(RACE_DONATELLO)
	local michaelangelo = dball.how_many_exist(RACE_MICHAELANGELO)
	local raphael = dball.how_many_exist(RACE_RAPHAEL)
	local turtle_count = leonardo + donatello + michaelangelo + raphael

	if michaelangelo ~= 0 then
		term.text_out(color.YELLOW, "Michaelangelo: ")
		term.text_out("Whoa, dude! This is not cool!\n\n")
	end
	if leonardo ~= 0 then
		term.text_out(color.LIGHT_BLUE, "Leonardo: ")
		term.text_out("Keep away from master Splinter!\n\n")
	end
	if turtle_count == 4 then
		term.text_out(color.LIGHT_BLUE, "Leonardo: ")
		term.text_out("\n\n")
		term.text_out(color.LIGHT_BLUE, "Splinter: ")
		term.text_out("Hold, my pupils. No blood has been drawn, and for the moment this newcomer appears content to talk. Well, then...you have our attention. What have you to say?\n\n")
		dialogue.helper("I am distrustful of Saki. I would like to hear your side of things before I decide which side is more deserving of my help.", "a")
		dialogue.helper("I have not chosen a side. I have not even decided I want to be involved. However, I perceive more honor in clearly making these things known.", "b")
		dialogue.helper("Oh, nothing. I just wanted you to know before I killed you, is all. (attack)", "c")
		ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Splinter: ")
			term.text_out("As with most things, there are more 'sides' than merely two. I cannot say which is best for you to to support, however, speaking for myself, I would not gladly accept the help of anyone who would so casually kill simply to promote the cause of one they believed more most worthy. I cannot say if this means you would be best serving the side of Saki, or not. But, it is clear that you lack the moral character that might otherwise have allowed you to serve ours.\n\nDo as you will.\n\n")
			dialogue.conclude()
			term.load()
			dball.data_splinter_state = 4
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Splinter: ")
			term.text_out("There is wisdom in your words. Each of us must strive to do what we know in our hearts to be best. I cannot decide what is best for another, each must make that decision himself.")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Why does Saki want you dead?\n\n")
			term.text_out(color.LIGHT_BLUE, "Splinter: ")
			term.text_out("Why would you kill a stranger merely because another wishes it?")
			dialogue.helper("You didn't answer my question.", "a")
			-- dialogue.helper("I wouldn't, necessarily. That's why I'm talking to you and asking you questions instead of fighting right now.", "b")
			dialogue.helper("Ok. You annoy me. I'm going to kill you after all. (attack)", "b")
			local ans = dialogue.answer()
			term.load()
			if ans == "a" then
				term.save()
				term.text_out(color.LIGHT_BLUE, "Splinter: ")
				term.text_out("That is true. Very well. I shall answer you.\n\nOroku Saki is the leader of The Foot ninja clan. His students engage in regular thefts throughout the city in order to fund his clan. We oppose their misdeeds. We have killed none of his students, however we have interfered on many occassions, and I do not doubt that our interferance has caused substantial financial loss to his clan.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("So you are also a ninja master?\n\n")
				term.text_out(color.LIGHT_BLUE, "Splinter: ")
				term.text_out("Suffice it to say that we study the martial arts, and we do interfere with the illegal actions of his clan.\n\n")
				dialogue.helper("This sounds like warfare between two ninja clans. I don't think I want to be involved in this.", "a")
				if enrollments[FLAG_NINJUTSU] > 0 then
					dialogue.helper("I see. Very well then. For reasons I will not disclose, I must remain neutral in this fued.", "b")
				end
				dialogue.helper("So you are interfering with his clan. That's good enough reason for me. Thank you for explaining. I'm going to kill you now. (attack)", "c")
				local ans = dialogue.answer()
				term.load()
				if ans == "a" then
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Splinter: ")
					term.text_out("I understand.\n\n")
					term.text_out(color.YELLOW, "Michaelangelo: ")
					term.text_out("Whoa! Dude, is " .. gendernouns.heshe .. " a ni-\n\n")
					term.text_out(color.LIGHT_BLUE, "Splinter: ")
					term.text_out("Michaelangelo! Allow our guest some courtesy.\n\n")
					dialogue.conclude()
					term.load()
				elseif ans == "c" then
					dball.data_splinter_state = 999
					dball.faction_annoy(FACTION_TURTLES)
				end					
			elseif ans == "b" then
			elseif ans == "c" then
				dball.data_splinter_state = 999
				dball.faction_annoy(FACTION_TURTLES)
			end
		elseif ans == "c" then
			term.load()
			dball.data_splinter_state = 999
			dball.faction_annoy(FACTION_TURTLES)
		end
	elseif turtle_count > 0 then
		term.text_out(color.LIGHT_BLUE, "Splinter: ")
		term.text_out("I see. And why do you stop to tell me this? \n\n")
		dialogue.helper("Some turtles killed path not implemented", "a")
	else
		term.text_out(color.LIGHT_UMBER, "Master Splinter: ")
		term.text_out("Sent you to kill me, perhaps to join my disciples? My children? I will not fear death, when it comes...but do not think that I shall embrace it easily.\n\n")
		dialogue.conclude()
		dball.faction_annoy(FACTION_TURTLES)
		-- Turnout the lights
		term.load()
		return
	end
end

function dialogue.TRUNKS()
	term.save()

	term.text_out(color.LIGHT_BLUE, "Trunks: ")
	term.text_out("I hate waiting! We should be doing somthing, not just sitting here!!!\n\n")
	dialogue.helper("Yes, please excuse me. I must train more before the androids arrive.", "a")
	dialogue.helper("Would you help me train?", "b")
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
	elseif ans == "b" then
		dball.enroll(FLAG_ENROLL_TRUNKS)
	end

	-- ???
	if dball_data.trunks_state == 0 then
	end
end

function dialogue.LUNCH()
	if dball_data.rosshi_girl == RACE_LUNCH then
		if dball_data.lunch_state == 0 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("La, la la! Cooking is so fun! Yay for me! Happy, happy, yay for me!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Hello, Lunch. Good to see you're doing so well.\n\n")
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Oh, yes! Very much so. Thank you so much for introducing me to Mr. Rosshi. I've been so very comfortable here.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Really? He hasn't...umm, done anything...well, you know?\n\n")
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Oh, goodness no! Mr. Rosshi? Why, he's been a perfect gentleman to me! And I get to play house all day long, baking cookies, and running the kitchen any way I please! It's been such a delightful dream!\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Of course, I suppose when you're at the stove, you're probably paying more attention to what you're doing than what he's doing.\n\n")
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Oh, I suppose I do get lost in my chores, but Mr. Rosshi is never far. He loves to watch me. He says it brings him great joy to see a young girl who appreciates the domestic life. \n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I think there may be more to it than that, but so long as you're both happy with the arrangement.\n\n")
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Oh! The browines are done! Excuse me, please.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Certainly. Take care, Lunch. I'm glad you've found your happiness.\n\n")
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("It's all thanks to you, " .. player_name() .. " I am forever grateful. Thank you so much. :)\n\n")
			dialogue.conclude()
			term.load()
		else
			term.save()
			term.text_out(color.LIGHT_RED, "Lunch: ")
			term.text_out("Hey, I remember you! You're that slimeball who stranded me on this God forsaken island with that old geezer!\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("...I, umm...\n\n")
			term.text_out(color.LIGHT_RED, "Lunch: ")
			term.text_out("Lock and load!")
			dialogue.conclude()
		end
		return
	end


	-- If married to Oolong, she's running rampant, yes?

	-- If she's in the party
	if party.is_partied(RACE_LUNCH) > 0 then
		if dball_data.lunch_state == 0 then
		term.save()
			local lunchness = dball.pick_one({
				"Hello! Isn't today beautiful!",
				"...hello! Do you hear the lovely birds singing? Maybe if we're really quiet they'll close close and we can watch!",
				"Hello! Isn't the sky pretty, today?",
				"Goodness! That cloud looks just like a teddy bear! Do you see it in the sky right there? Isn't it adorable?"
			
			})
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out(lunchness .. "\n\n")
		 	dialogue.helper("I just wanted to check to make sure you're ok. You don't feel like sneezing, do you?","a")
		 	dialogue.helper("It's been nice having you along, Lunch. But maybe we should part ways for a while.","b")
			local ans = dialogue.answer()
			term.load()
			term.save()
			if ans == "a" then
				party.party(RACE_LUNCH)
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("Oh, thank you. No. I feel fine. Not like sneezing at ah...ahhh....\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("...uh oh...\n\n")
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("...at all. Thank you so much for being so concerned about me. It feels so wonderful to have you caring for me like this.\n\n")
			elseif ans == "b" then
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("I understand. I'm sorry I'm so much trouble. I want to thank you for keeping me company for so long. I've really enjoyed our time together. I hope I get to see you again some time.\n\n")
			end
			dialogue.conclude()
			term.load()
		else
			-- Can't talk to Lunch while she's being...muzukashi.
			local lunchness = dball.pick_one({
				"Grraaaaghgghgghhg!!!!",
				"DIE!!!",
				"Whaddya lookin' at?!?!?!",
				"I don' feel like talkin'!"
			
			})
			term.text_out(color.LIGHT_RED, "Lunch: ")
			term.text_out(lunchness)
		end
		return
	end		
	
	if dball_data.lunch_state < 3 then
		if dball_data.lunch_sneeze == 1 then
			monster_random_say
				{
				"She seems more interesting in mayhem than talking.",
				"Lunch screams 'Grraaaaghgghgghhg!!!!'",
				"Lunch shouts 'Die!'",
				"Lunch snarls at you!",
			}
			return
		end
		
		term.save()
		if dball_data.lunch_state == 0 then
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Hello! Isn't today such a wonderful, beautiful day? Aren't the singing birds lovely?\n\n")
			dball_data.lunch_state = 1
		else
			local lunchness = dball.pick_one({
				"Hello! Isn't today beautiful!",
				"...hello! Do you hear the lovely birds singing? Maybe if we're really quiet they'll close close and we can watch!",
				"Hello! Isn't the sky pretty, today?",
				"Goodness! That cloud looks just like a teddy bear! Do you see it in the sky right there? Isn't it adorable?"
			
			})
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out(lunchness .. "\n\n")
		end

		dialogue.helper("Yes. Very nice. Nice chatting with you.", "a")
		dialogue.helper("Are you....ok?", "b")
		if dball.persuade(15) then
			dialogue.helper("(Persuade (15) Yes! Beautiful and lovely all at once. Would you like to come for a walk with me? We could see more beautiful things together.", "c")
		end
		if quest(QUEST_OOLONG_LONELY).status == QUEST_STATUS_TAKEN then
			dialogue.helper("Wow...you seem like such a sweet, kind, loving girl. Wait...did I say 'sweet, kind and loving?' Hmm. You know, there's someone I think I'd like to introduce you to.", "d")
		end
		
		if dball_data.lunch_state == 2 then
			if quest(QUEST_ROSSHI_LONELY).status == QUEST_STATUS_TAKEN then
				dialogue.helper("I know someone I'd like to introduce to you. I think he'd appreciate your personality. Half of it anyway. And he's strong enough he might be able to avoid getting killed by the other half.", "e")
			end
		end
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("You too!")
		elseif ans == "b" then
			dball_data.lunch_state = 2
			term.save()
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Oh dear. If you're asking me that, I must have done something bad, have I?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Ahh....well, I suppose you might say something...kind of like that. Maybe. But you seem ok now.\n\n")
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("I'm terribly sorry. Please let me explain. Whenever I sneeze my personality and my appearance both change. Sometimes I'm like this, and other times I'm...well, I don't know, really. I never remember what happens.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Let's just say you become a mildly antisocial.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("I'm sorry. I don't doubt it. Yes. I often wake up with whiskey, automatic weapons and large bundles of cash. Oh...I feel so awful! I really don't want to be this way. \n\n")
			if rng(1, 2) == 1 then
				term.text_out("But whenever I...ahh....ahh....\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("Yes?\n\n")
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("...ahhh....CHOOO!\n\n")
				dball_data.lunch_sneeze = 1
			else
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("I understand. It sounds terribly inconvenient.\n\n")
				term.text_out(color.LIGHT_BLUE, "Lunch: ")
				term.text_out("It is. But I feel so much worse for the people I hurt. As inconvenient as it is for me, it's all the more horrible that I impose on other people and do bad things. I don't want to be a bad person!\n\n")
				dialogue.helper("That's really too bad. You seem like a nice girl. I'm sorry I can't help you, but maybe it would be best if I didn't stay too close?", "a")
				dialogue.helper("Maybe you should travel with me? That way I could keep an eye on you and maybe keep you from accidentally hurting anyone.", "b")
				if quest(QUEST_DRAGONBALLS).status == QUEST_STATUS_TAKEN then
					dialogue.helper("I have an idea! How about I use the dragonballs to wish you to stay normal?", "c")
				end
				local ans = dialogue.answer()
				term.load()
				term.save()
				if ans == "a" then
					term.text_out(color.LIGHT_BLUE, "Lunch (Sadly): ")
					term.text_out("Yes. Maybe that would be best.\n\n")
				elseif ans == "b" then
					term.text_out(color.LIGHT_BLUE, "Lunch: ")
					term.text_out("That's would be very kind of you, but I would hate to be such a burden!\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("It's no trouble. Well, ok, maybe it is a little trouble, but I'm an adventurer and having you along will definately be adventuresome. Besides, if you're with me at least we'll know that you're not troubling anyone else.\n\n")
					term.text_out(color.LIGHT_BLUE, "Lunch: ")
					term.text_out("Then, please forgive me if I accept. Oh, how wonderful! It will be so nice to have a friend! Thank you so much!\n\n")
					party.party(RACE_LUNCH)
				elseif ans == "c" then
					term.text_out(color.LIGHT_BLUE, "Lunch: ")
					term.text_out("Dragonballs? I'm not sure what those are, but if you can do anything to help me that would be wonderful! Thank you so much!\n\n")
				end
			end
			dialogue.conclude()
			term.load()
		elseif ans == "c" then
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("I would be delighted!")
			party.party(RACE_LUNCH)
		elseif ans == "d" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("You'd like to introduce me to someone? How wonderful! I don't have very many friends. I'd be delighted.\n\n")
			dialogue.conclude()
			term.load()
			party.party(RACE_LUNCH)
		elseif ans == "e" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Lunch: ")
			term.text_out("Oh! That sounds wonderful. I'd be delighted to meet him. You lead the way, and I'll follow you.\n\n")
			dialogue.conclude()
			term.load()
			party.party(RACE_LUNCH)
		end

	
	else
		-- Does Lunch use any other dialogue states?		
		message("Unknown dialogue state for Lunch?")				
	end
end

function dialogue.CHICHI()
	if dball_data.rosshi_girl == RACE_CHICHI then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Chichi: ")
		term.text_out("Hello, " .. player_name() .. ". It's so nice to see you again.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("How is Rosshi treating you?\n\n")
		term.text_out(color.LIGHT_BLUE, "Chichi: ")
		term.text_out("Oh. He's, well...changed a bit from how I remember him when I was a little girl.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("I don't know about that. I didn't know him when you were a little girl, but I've a sneaking suspicion that he was exactly the same sort of person back then...but rather, it's you who have changed.\n\n")
		term.text_out(color.LIGHT_BLUE, "Chichi: ")
		term.text_out("...yes. That could be.\n\n")
		term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
		term.text_out("Well, in any case, I'm glad to hear you're doing well. I'll talk to you again some other time. Take care.\n\n")
		dialogue.conclude()
		term.load()
		

	elseif dball_data.chichi_state == 2 then
		monster_random_say
			{
			"Hentai!",
			"Die, pervert!",
			"Chichi glares at you with sheer hatred.",
			}
	elseif dball_data.chichi_state == 4 then
		-- Dinner
		monster_random_say
			{
			"Chichi avoids your gaze",
			"Chichi looks at you awkwardly",
			}
	else
		message("Implement my dialogue!")
	end
end

function dialogue.CHICHI_NAKED()
	term.save()
	term.text_out(color.LIGHT_GREEN, "You ")
	term.text_out("step into the room and are instantly struck by a piercing scream, followed by something hard in the face. Through the pain you manage to make out the form of a teenage girl clutching a wet towel to her chest and brandishing some sort of weapon in the other.\n\n")
	term.text_out(color.LIGHT_RED, "Chichi: ")
	term.text_out("You PERVENT! GET OUT OF MY BEDROOM!!!\n\n")
	dialogue.conclude()
	term.load()
	take_hit(100, "Never annoy Chichi")
end

function dialogue.NO_NAMEKS_DRAGONBALL()
	term.save()
	term.text_out(color.LIGHT_GREEN, "You ")
	term.text_out("gather the seven dragonballs together, and shout out: \n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("Dragon! I summon you! I command you to come forth and grant my wish!\n\n")
	dialogue.conclude()
	term.load()
	term.save()
	term.text_out("But, nothing happens.\n\n")
	dialogue.conclude()
	term.load()
end

function dialogue.SUMMON_PORUNGA()
	message(color.YELLOW, "Takkarapt Popporunga Pupiritparo!")

	term.inkey_scan = FALSE
	term.inkey()

	term.save()
	term.clear()
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.RED, "The sky darkens...", 10, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.LIGHT_BLUE, "Lightning strikes above you...", 11, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.LIGHT_GREEN, "The earth rumbles.", 14, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)

	term.putch(0, 0, color.DARK, 32)
	term.inkey_scan = FALSE
	term.inkey()
	term.load()
end

function dialogue.SUMMON_SHENRON()
	term.save()
	term.text_out(color.LIGHT_GREEN, "You ")
	term.text_out("gather the seven dragonballs together, and shout out: \n\n")
	term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
	term.text_out("Dragon! I summon you! I command you to come forth and grant my wish!\n\n")
	dialogue.conclude()
	term.load()

	-- term.inkey_scan = FALSE
	-- term.inkey()

	term.save()
	term.clear()
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.RED, "The sky darkens...", 10, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.LIGHT_BLUE, "Lightning strikes above you...", 11, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.LIGHT_GREEN, "The earth rumbles.", 14, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)

	term.putch(0, 0, color.DARK, 32)
	term.inkey_scan = FALSE
	term.inkey()
	term.load()
	term.save()
	term.clear()

	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.RED, "You feel motion all around you...", 10, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.LIGHT_BLUE, "From a direction like none you recognize...", 11, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.GREEN, "And then all of the sudden...", 13, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.DARK, "------------------------------------------------------------", 1, 0)
	term.drop_text_left(color.YELLOW, "Shenron appears", 15, 0)

	term.putch(0, 0, color.DARK, 32)
	term.inkey_scan = FALSE
	term.inkey()

	term.load()
end

function dialogue.SHENRON()
	term.save()
	term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
	term.text_out("I respond, oh summoner, and I shall grant you any single wish that is within my power. What say you?\n\n")
	dialogue.prep()
	dialogue.helper("How exactly does this work? It's been a lot of effort gathering up the dragonballs. I'd like to do this right.", "a")
	dialogue.helper("I am ready to make my wish.", "b")
	local ans = dialogue.answer()
	if ans == "a" then
		term.load()
		term.save()
		term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
		term.text_out("You are wise to ask such a question. Many who have preceeded you have not asked this simple thing. Very well, I will answer:\n\n")
		term.text_out("Wishes must begin with 'I wish'. I advise you to speak clearly, and to not garble your words. Understand that wishes are intelligent, and it is best to allow them to handle the details. Do not ask for specific numbers of anything. Your wish need not be simply for a physical object, though you may wish for such if it pleases you. Only one wish will be granted, and attempting to make multiple wishes through clever phrasing will generally result in disappointment. For a properly phrased wish, however, very little is beyond my power, but those few things which are may not be wished for. In particular I cannot cause anyone to die, and I cannot compell the hearts or minds of conscious beings against their will. Anything else is within my domain. Are you ready?\n\n")
		dialogue.prep()
		dialogue.helper("I am ready.", "a")
		--dialogue.helper("Not yet. I still have more questions.", "b")
		local ans = dialogue.answer()
		if ans == "a" then
			term.load()
		elseif ans == "b" then
			term.load()
			term.save()
			term.text_out("(Shenron looks a little annoyed)\n\n")
			term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
			term.text_out("Very well, mortal, but make haste. I do not relish my compulsory sojourns to this insubstantial realm. What would you ask of me?\n\n")
			dialogue.conclude()
			term.load()
		end
	elseif ans == "b" then
		term.load()
	end

	-- Auto-fallthrough to the wish!

	local shenron_rage = 5
	local wish_str = ""

	local wish_granted = FLAG_WISH_UNKNOWN			-- From flags above
	local wish_message = "You shouln't see this"	-- If approved, what shall we say?
	local wish_confirm = "You shouln't see this"	-- Confirmation string
	local wish_quality = 0					-- Some wishes annoy Shenron
	local wish_wishfct					-- function containing the results of the wish

	while shenron_rage > 0 do
		wish_str = get_string("Make your wish: ")

		if not wish_str then
			wish_str = ""
		end

		wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct = dball.wish(wish_str)

		-- wish_quality, wish_granted, result_message, special_case = dball.wish(wish_str)

		if wish_granted == FLAG_WISH_GRANTED then
			term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
			term.text_out("Granted")
			return
		elseif wish_granted == FLAG_WISH_CONFIRM then
			term.save()
			term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
			term.text_out(wish_confirm .. "\n\n")
			dialogue.prep()
			dialogue.helper("Yes.", "a")
			dialogue.helper("No, that's not what I meant.", "b")
			local ans = dialogue.answer()
			if ans == "a" then
				-- Grant the wish
				term.text_out(color.LIGHT_GREEN, "\nShenron, the Eternal Dragon of the Earth: ")
				term.text_out(wish_message .. "\n\n")
				dialogue.conclude()
				wish_wishfct()
				player.calc_bonuses()
				player.redraw[FLAG_PR_BASIC] = true
				-- player.window = player.window | PW_PLAYER
				term.load()
				return
			elseif ans == "b" then
				if shenron_rage > 2 then
					term.text_out(color.LIGHT_GREEN, "\nShenron, the Eternal Dragon of the Earth: ")
					term.text_out("Very well.\n\n")
				else
					term.text_out(color.LIGHT_GREEN, "\nShenron, the Eternal Dragon of the Earth: ")
					term.text_out("My patience is growing thin. Make your wish and be done with it.\n\n")
				end
				dialogue.conclude()
				term.load()
			end
		elseif wish_granted == FLAG_WISH_FAILURE then
			if wish_quality then
				shenron_rage = shenron_rage + wish_quality
			end
			term.save()
			term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
			term.text_out(wish_message .. "\n\n")
			dialogue.conclude()
			term.load()
		else
			-- Shenron doesn't like having his time wasted with confusing wishes
			shenron_rage = shenron_rage - 1
			term.save()
			if shenron_rage > 2 then
				term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
				term.text_out("I am uncertain what you are asking for. Try rephrasing it.\n\n")
			else
				term.text_out(color.LIGHT_GREEN, "Shenron, the Eternal Dragon of the Earth: ")
				term.text_out("I grow weary of this.\n\n")
			end
			dialogue.conclude()
			term.load()
		end
	end

	-- Shenron is Eternal, but not very patient. Go figure.
	term.save()
	term.text_out(color.LIGHT_RED, "Shenron, the Eternal Dragon of the Earth: ")
	term.text_out("Enough of this nonsense! I shall waste my time with you no longer.\n\n")
	dialogue.conclude()
	term.load()
end


-- RVac Hack
function dialogue.STORE_HACK()
	local state_tracker = 0

	while not nil do
		term.save()
		if state_tracker == 0 then
			term.text_out(color.YELLOW, "Note: I am a TEMPORARY feature to make it easier to playtest Technomancers. Do not get attahced. I won't be here forever.\n\n")
		end
		term.text_out(color.LIGHT_BLUE, "Man in Trenchcoat: ")
		if state_tracker == 0 then
			term.text_out("Psst. Ya wanna buy some sometin?\n")
		elseif state_tracker == -1 then
			term.text_out("'Dat looks to be jus' a lil' bit outta you's price range. Know what I mean?\n")
		else
			term.text_out("We appreciates yous bizness. Anytin' else I can do's for ya?\n")
		end
		term.text_out("(You have " .. player.au .. " zeni)\n\n")

		state_tracker = 1

		dialogue.prep()
		dialogue.helper("No, thank you.", "a")
		dialogue.helper("I would like to buy a resistor, please. (25 zeni)", "b")
		dialogue.helper("I would like to buy a capacitor, please. (25 zeni)", "c")
		dialogue.helper("I would like to buy a circuit board, please. (25 zeni)", "d")
		dialogue.helper("I would like to buy a spool of wire, please. (25 zeni)", "e")
		dialogue.helper("I would like to buy a spool of solder, please. (25 zeni)", "f")
		dialogue.helper("I would like to buy an eprom, please. (25 zeni)", "g")
		dialogue.helper("I would like to buy a mechanical toolkit, please. (600 zeni)", "h")
		dialogue.helper("I would like to buy an electrical toolkit, please. (600 zeni)", "i")
		dialogue.helper("I would like to buy a chemistry set, please. (2500 zeni)", "j")
		dialogue.helper("I would like to buy a lathe, please. (7500 zeni)", "k")

		local ans = dialogue.answer()

		if ans == "a" then
			term.load()
			return
		elseif ans == "b" then
			if player.au > 24 then
				player.au = player.au - 25
				dball.reward(create_object(TV_CIRCUITRY, SV_RESISTER))
			else
				state_tracker = -1
			end
		elseif ans == "c" then
			if player.au > 24 then
				player.au = player.au - 25
				dball.reward(create_object(TV_CIRCUITRY, SV_CAPACITOR))
			else
				state_tracker = -1
			end
		elseif ans == "d" then
			if player.au > 24 then
				player.au = player.au - 25
				dball.reward(create_object(TV_CIRCUITRY, SV_CIRCUIT_BOARD))
			else
				state_tracker = -1
			end
		elseif ans == "e" then
			if player.au > 24 then
				player.au = player.au - 25
				dball.reward(create_object(TV_CIRCUITRY, SV_SPOOL_OF_WIRE))
			else
				state_tracker = -1
			end
		elseif ans == "f" then
			if player.au > 24 then
				player.au = player.au - 25
				dball.reward(create_object(TV_CIRCUITRY, SV_SPOOL_OF_SOLDER))
			else
				state_tracker = -1
			end
		elseif ans == "g" then
			if player.au > 24 then
				player.au = player.au - 25
				dball.reward(create_object(TV_CIRCUITRY, SV_EPROM))
			else
				state_tracker = -1
			end
		elseif ans == "h" then
			if player.au > 599 then
				player.au = player.au - 600
				dball.reward(create_object(TV_ELECTRONICS, SV_MECHANICAL_TOOLKIT))
			else
				state_tracker = -1
			end
		elseif ans == "i" then
			if player.au > 599 then
				player.au = player.au - 600
				dball.reward(create_object(TV_ELECTRONICS, SV_ELECTRICAL_TOOLKIT))
			else
				state_tracker = -1
			end
		elseif ans == "j" then
			if player.au > 2499 then
				player.au = player.au - 2500
				dball.reward(create_object(TV_ELECTRONICS, SV_CHEMISTRY_KIT))
			else
				state_tracker = -1
			end
		elseif ans == "k" then
			if player.au > 7499 then
				player.au = player.au - 7500
				dball.reward(create_object(TV_ELECTRONICS, SV_LATHE))
			else
				state_tracker = -1
			end
		end

		term.load()
	end
end

function dialogue.TAMA()
	monster_random_say
		{
		"Tama looks at you wide eyed",
		"Tama blinks at you",
		"Tama nuzzles Dr Briefs",
		}

--[[
	if quest(QUEST_LITTER_BOX).status ~= QUEST_STATUS_FINISHED then
		if rng(1, 3) == 1 then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Tama: ")
			term.text_out("I am so very sad! I am such a sad kitty! Woe is me! No one has cleaned my litter box in days! What am I to do?\n<pout> <sniff> <cry>\n\n")
			dialogue.conclude()
			term.load()
			change_quest_status(QUEST_LITTER_BOX, QUEST_STATUS_TAKEN)
		else
		monster_random_say
			{
			"Tama peers at you, looking slightly forlorn.",
			"Tama ignores you.",
			"Tama seems to be sulking for some reason.",
			}
		end
	else
		monster_random_say
			{
			"Tama purrs happily as you pet her.",
			"You scratch Tama behind the ears",
			"Tama rubs up against your leg affectionately.",
			}
		return
	end
]]
end

function dialogue.ANDROID_INCEPTION()
	local which_dial = rng(1, 3)
	term.save()
	if which_dial == 1 then
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("Look...another human.\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("And " .. gendernouns.heshe .. " doesn't seem to be running in terror like the rest of them.\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("...interesting...\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("Not really. Just kill " .. gendernouns.himher .. " and be done with it.\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("Ok.\n\n")
	elseif which_dial == 2 then
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("I think I'm getting bored, 17.\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("Are you serious? How could ever get bored of this! Killing humans is fun!\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("I don't know. Maybe if they weren't so helpless and pathetic it would be more intersting.\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("What about that one over there?\n\n")
		term.text_out("They look at you.\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("Yeah, " .. gendernouns.heshe .. " looks fun. Come on, let's try " .. gendernouns.himher .. "out.\n\n")
	else
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("Hahahahahaha!!!! That's it! That one puts me at 117 points! I'm in the lead!\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("Only by one points. All I have to do is kill a single measly human and we're tried again.\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("Yeah, but where are you going to find one? I think we're starting to run out.\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("What about that one over there?\n\n")
		term.text_out("They look at you.\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("Oh, I see " .. gendernouns.heshe .. ". I bet I can kill " .. gendernouns.heshe .." first!\n\n")
		term.text_out(color.LIGHT_RED, "Android 16: ")
		term.text_out("I bet I can get " .. gendernouns.heshe .. " first. How about whomever gets this one first, wins?\n\n")
		term.text_out(color.LIGHT_RED, "Android 17: ")
		term.text_out("You're on.\n\n")
	end
	dialogue.conclude()
	term.load()
end

--[[
	dball_data.namek_elder1 = 0
	dball_data.namek_elder2 = 0
	dball_data.namek_elder3 = 0
	dball_data.namek_elder4 = 0
	dball_data.namek_elder5 = 0
	dball_data.namek_elder6 = 0
	dball_data.namek_elder7 = 0
	dball_data.namek_know_db = 0	-- Does the player know about the Dragonballs on Namek?
	dball_data.namek_know_aj = 0	-- Does the player know about the Ajisa plant?
	dball_data.namek_know_gr = 0	-- Does the player know about the Great Elder?
	dball_data.namek_know_fr = 0	-- Does the player know about Freeza on Namek?
	dball_data.namek_general_state = 0 -- For random Nameks: See dialogue
]]


function dialogue.NAMEK_ELDER(which)
	local elder = "Elder"
	if which == 7 then
		elder = "Great Elder"
	end
	local greeting_first
	local greeting_return
	local greeting_angry
	local elder_data = {}
	elder_data[1] = dball_data.namek_elder1
	elder_data[2] = dball_data.namek_elder2
	elder_data[3] = dball_data.namek_elder3
	elder_data[4] = dball_data.namek_elder4
	elder_data[5] = dball_data.namek_elder5
	elder_data[6] = dball_data.namek_elder6
	elder_data[7] = dball_data.namek_elder7

	-- No elders are friendly if the player has killed any Nameks
	-- Disagreement! 2 or 999?!?!?!
	if dball_data.namek_general_state == 999 then
		for i = 1, 7 do
			elder_data[i] = 2
		end
	end

	-- If this is our first contact on Namek, mark that we've made contact
	if dball_data.namek_general_state == 0 then
		dball_data.namek_general_state = 1
	end

	local q_ptr = {}
	q_ptr[1] = QUEST_NAMEK_WATER
	q_ptr[2] = QUEST_NAMEK_POLLINATION
	q_ptr[3] = QUEST_NAMEK_SEEDS
	q_ptr[4] = QUEST_NAMEK_AJISA
	q_ptr[5] = QUEST_NAMEK_ISOLATION
	q_ptr[6] = QUEST_NAMEK_LEVIATHAN
	q_ptr[7] = QUEST_NAMEK_GREAT_ELDER
	local db_quest_answer = {}
	db_quest_answer[1] = "I have filled the well with water."
	db_quest_answer[2] = "I have carried all six ajisa plants to the other villages"
	db_quest_answer[3] = "I have returned with ajisa seeds from neighboring villages"
	db_quest_answer[4] = "I have succesfully brought an ajisa plant to bloom"
	db_quest_answer[5] = "I have found a suitable replacement for you."
	db_quest_answer[6] = "I have slain a Namekkian Leviathan"
	db_quest_answer[7] = "I have all six dragonballs from the villages"

	local foo = rng(1,6)
	if foo == 1 then
		greeting_first = "I bid you welcome. I trust that you have come in peace? What may I do for you?"
		greeting_return = "You have returned."
		greeting_angry = "Vile betrayer! Why have you returned?"
	elseif foo == 2 then
		greeting_first = "Welcome to our village, offworlder. What can this Elder of Namek do for you?"
		greeting_return = "I thought that you would return."
		greeting_angry = "Treacherous villain! We do not want you here. Leave, now!"
	elseif foo == 3 then
		greeting_first = "Please forgive our caution, stranger. Many do not share our love of peace. Why have you come?"
		greeting_return = "We meet again."
		greeting_angry = "Namek is a place of peace. We have no place for you here."
	elseif foo == 4 then
		greeting_first = "Welcome, stranger. What brings you to our planet?"
		greeting_return = "Once again, our paths have crossed."
		greeting_angry = "You have the audacity to return to the place you have desecrated? Whatever have we done to deserve your treachery?"
	elseif foo == 5 then
		greeting_first = "Hello, and welcome to our village. I am the Elder here. Why have you sought me out?"
		greeting_return = "I see you have found your way back to our village."
		greeting_angry = "Foul wretch! Begone from this village! Begone from this planet! Leave, and retrun to whatever foul hole you crawled out of!"
	elseif foo == 6 then
		greeting_first = "You are clearly not from this planet. We welcome you. What brings you to Namek?"
		greeting_return = "I trust that you have returned in peace?"
		greeting_angry = "You! Why have you returned?"
	end


	local have_we_looped_yet = 0	-- Does this exist inside the while loop?

	while not nil do
		term.save()
		term.text_out(color.LIGHT_GREEN, elder .. ": ")
		if have_we_looped_yet > 0 then
			term.text_out("What else would you ask of me?\n\n")
		elseif elder_data[which] == 0 then
			term.text_out(greeting_first .. "\n\n")
			elder_data[which] = 1
		elseif elder_data[which] == 1 then
			term.text_out(greeting_return .. "\n\n")
		elseif elder_data[which] == 2 then
			term.text_out(greeting_angry .. "\n\n")
		end

		dialogue.helper("Thank you for your time.", "a")
		if which ~= 7 then	-- Guru can not be asked to get the initial _db state
			if dball_data.namek_know_db == 1 then
				if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_UNTAKEN then
					dialogue.helper("You have dragonballs here on Namek? How strange! We have the same thing back on Earth!", "j")
				else
					dialogue.helper("Dragonballs?", "j")
				end
				-- dialogue.helper("", "b")
			elseif dball_data.namek_know_db == 2 then	-- Nameks Dragonballs
				if quest(q_ptr[which]).status == QUEST_STATUS_UNTAKEN and dball_data.alignment >= 0 then
					dialogue.helper("I would like to ask for you to give me the dragonball you have in your posession.", "b")
				elseif quest(q_ptr[which]).status == QUEST_STATUS_TAKEN then
					dialogue.helper(db_quest_answer[which], "c")
				end
			end
		end
		if dball_data.namek_know_aj > 0 then	-- Ajisa
			dialogue.helper("What can you tell me about the ajisa plant?", "d")
		end
		if dball_data.namek_know_gr > 0 then	-- Great Elder
			if which == 7 then
				dialogue.helper("So you're the Great Elder of Namek?", "e")
			else
				dialogue.helper("Would you tell me about your Great Elder?", "e")
			end
		end
		if dball_data.namek_know_fr > 0 then	-- Freeza
			dialogue.helper("Did you know there's a super powerful maniac running loose on Namek? His name is Freeza, and here's here to kill you all and steal the dragonballs.", "f")
		end
		dialogue.helper("What can you tell me of your people?", "g")
		dialogue.helper("What can you tell me about this planet?", "h")
		if dball_data.alignment < 1 and dball_data.namek_know_db == 2 then
			dialogue.helper("Gimme your dragonball or I'll splatter you like a grease spot.", "i")
		end

		-- Quest requests
		-- "j" used above for Dragonballs question! Clean this up!
		if which ~= 1 and quest(QUEST_NAMEK_WATER).status == QUEST_STATUS_TAKEN then
			dialogue.helper("One of the other villages needs water. Do you have any advice?", "k")
		end
		if which ~= 2 and quest(QUEST_NAMEK_POLLINATION).status == QUEST_STATUS_TAKEN then
			dialogue.helper("The second Elder asked me to give you this ajisa plant for cross pollination", "l")
		end
		if which ~= 3 and quest(QUEST_NAMEK_SEEDS).status == QUEST_STATUS_TAKEN then
			dialogue.helper("A nearby village has run out of ajisa seeds. Do you have any to spare?", "m")
		end
		if which ~= 4 and quest(QUEST_NAMEK_AJISA).status == QUEST_STATUS_TAKEN then
			dialogue.helper("I've been asked to plant an ajisa tree, but I don't know anything about them. Any advice?", "n")
		end
		if which ~= 5 and quest(QUEST_NAMEK_ISOLATION).status == QUEST_STATUS_TAKEN then
			dialogue.helper("The Elder of the island village is dying, and seeks a successor. Do you konw of anyone suitable?", "o")
		end
		if which ~= 6 and quest(QUEST_NAMEK_LEVIATHAN).status == QUEST_STATUS_TAKEN then
			dialogue.helper("I've been tasked to slay a leviathan. Do you know where I might find one?", "p")
		end
		if which ~= 7 and quest(QUEST_NAMEK_GREAT_ELDER).status == QUEST_STATUS_TAKEN then
		end

		local ans = dialogue.answer()
		term.load()
		term.save()
		have_we_looped_yet = have_we_looped_yet + 1

		if ans == "a" then
			term.load()
			break
		elseif ans == "b" then
			term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
			local which_quest
			if which == 1 then
				term.text_out("You wish to have the dragonball I guard? Very well. I am willing to part with it, but you must first render a service to my village. Two weeks ago, our well ran completely dry. Our village is in no danger from it, we're able to fly to water for ourselves, and carry in back in small quantities, but it is difficult to carry enough water for our fields. If you can find a way to restore water to our wells, I will give you the dragonball in my posession.\n\n")
			elseif which == 2 then
				term.text_out("Hmm. Perhaps I would be willing. But, would you be willing to perform a service for me in return? It is only a very small thing that I ask. Our most recent growth season was unusually strong, and we have prepared a number of potted ajisa plants to be carried to the other villages across Namek for cross-fertilization. Deliver all six plants and return here, and I will give the dragonball that I guard.\n\n")
			elseif which == 3 then
				term.text_out("Oh...you believe you are deserving of a wish? Very well. It happens that my village has recently suffered a number of distressing botanical disasters, and we have been left completely bereft of ajisa seeds for our next planting season. We have time left to resolve it, but it would be a great service if you could collect a number of seeds for us. Twenty should be enogh for the next planting. Do this, and I will give you the dragonball that I keep in my custody.\n\n")
			elseif which == 4 then
				term.text_out("You are attempting to gather the dragonballs? Interesting. Very well. It is custom that anyone making such a request must prove themselves by performing a task to demonstrate a particular virtue. In practice, this usually means solving some problem that the Elder has not been able to resolve. However, everything has been spendid in our village for years, and I have no tasks to give you worthy of awarding you with a dragonball should you succeed. However...do you know about the ajisa plant?\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
				term.text_out("Indeed.\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
				term.text_out("The ajisa is our most sacred and beautiful plant. In the years since our near destruction, we have cared for them and struggled to spread them across our lands once again.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("I can tell you value them a great deal.\n\n")
				term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
				term.text_out("Yes. Almost as much as we value the dragonballs. And if I am to give to you our greatest prize, it is important that you understand us, understand our ways...and understand the ajisa.\n\n")
				term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
				term.text_out("What do you want me to do?\n\n")
				dialogue.conclude()
				term.load()
				term.save()
				term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
				term.text_out("Take this ajisa seed. Plant it. Care for it. Help it to grow. Bring it to fullness, and when you have done this, return to me and I will give you the dargonball entrusted to me.\n\n")
			elseif which == 5 then
				term.text_out("You seek the dragonballs? Forgive me...but your timing is most convenient. Our village is in need of a hero to perform a task. I have become...old. Too old to properly care for my village, and I fear that it is time for me to step down. Sadly, we have no warriors at our village, and none of us are able to fly any longer. Yes, I know...it is a sad state of affairs. Go to the neighboring villages and find a suitable master to replace me. If you do this, I will gladly give you the dragonball that I watch over.\n\n")
			elseif which == 6 then
				term.text_out("I would give the dragonball freely to any who can prove themselves a deserving warrior. Are you a warrior? Are you willing to prove it? If so, find and do battle with a Leviathan. Defeat it and return me. If you are able to do this I will give you my dragonball.\n\n")
				dball_data.namek_lev_check = 1
			elseif which == 7 then
				term.text_out("Implement path!n\n")
			end
			dialogue.conclude()
			term.load()
			change_quest_status(q_ptr[which], QUEST_STATUS_TAKEN)

			-- Give any items associated with the quest
			if which == 2 then
				local obj = create_object(TV_MISC, SV_NAM_AJASA_PLANT)
				obj.number = 6
				make_item_fully_identified(obj)
				dball.reward(obj)
			elseif which == 3 then
				local obj = create_object(TV_MISC, SV_NAM_AJASA_SEED)
				make_item_fully_identified(obj)
				dball.reward(obj)
			end

			break
		elseif ans == "c" then
			-- check quest completion
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			if q_ptr[which] == QUEST_NAMEK_WATER then
				if quest(QUEST_NAMEK_WATER).status == QUEST_STATUS_COMPLETED then
					term.text_out("So you have! In truth, I thought I had given you an impossible task. Surely it should have taken years to transport that much water from so far. But you have done what we could not. For this I award you with the dragonball in my possession. Please use it wisely.\n\n")
					dialogue.conclude()
					term.load()
					dball.reward(create_artifact(ART_NAMEK_DRAGONBALL1))
					quest(QUEST_NAMEK_WATER).status = QUEST_STATUS_COMPLETED
				else
					term.text_out("The well is still dry. But please don't trouble yourself uneccesarily over us. You are an outsider, and we do not expect you to worry yourself over our troubles.\n\n")
					dialogue.conclude()
				end
			elseif q_ptr[which] == QUEST_NAMEK_POLLINATION then
			elseif q_ptr[which] == QUEST_NAMEK_SEEDS then
				local seed_qty = dball.player_has_item_with_flag(FLAG_AJISA_SEED)
				if dball_data.namek_seeds_deliver + seed_qty >= 20 then
					term.text_out(color.LIGHT_GREEN, elder .. ": ")
					term.text_out("Ahh! You have enough seeds for our harvest! How wonderful. You have proven yourself, and in return for these seeds I will give you the dragonball in my possession.\n\n")
					dialogue.helper("Thank you.", "a")
					dialogue.helper("I...umm, forgot about something. I can't give you these just yet. I'm sorry. I'll come back soon.", "b")
					local ans = dialogue.answer()
					term.load()
					if ans == "a" then
						term.save()
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Thank you. You have done my village a great service. I give you my dragonball to do with as you please. Though, I fear it will be of little use to you.\n\n")
						dialogue.conclude()
						dball_data.namek_seeds_deliver = dball_data.namek_seeds_deliver + dball.remove_items_with_flag(FLAG_AJISA_SEED, 20 - dball_data.namek_seeds_deliver)
						quest(QUEST_NAMEK_LEVIATHAN).status = QUEST_STATUS_FINISHED
						local obj = create_artifact(ART_NAMEK_DRAGONBALL3)
						make_item_fully_identified(obj)
						dball.reward(obj)
					elseif ans == "b" then
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Hmm. Very well. We can wait a little longer.\n\n")
						dialogue.conclude()
					end
				else
					if seed_qty > 0 then
						local still_needed = "at least twenty"
						if dball_data.namek_seeds_deliver > 0 then
							still_needed = tostring(20 - dball_data.namek_seeds_deliver) .. " more"
						end
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("You have " .. seed_qty .. " seeds? This is very helpful, but it is not enough. I will happily accept them, but we will need " .. still_needed .. " seeds for the harvest.\n\n")
						dialogue.helper("That's ok. Take these and I'll go find more.", "a")
						dialogue.helper("Ok. I just hold on to these until I've collected the rest.", "b")
						local ans = dialogue.answer()
						if ans == "a" then
							term.text_out(color.LIGHT_GREEN, elder .. ": ")
							term.text_out("Thank you.\n\n")
							dialogue.conclude()
							dball_data.namek_seeds_deliver = dball_data.namek_seeds_deliver + dball.remove_items_with_flag(FLAG_AJISA_SEED, seed_qty)
						elseif ans == "b" then
						end
					else
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("You don't have any ajisa seeds with you. Please don't tell me you lost them?\n\n")
						dialogue.conclude()
					end
				end
			elseif q_ptr[which] == QUEST_NAMEK_AJISA then
				if dball_data.namek_ajasa_total > 0 then
				else
				end
			elseif q_ptr[which] == QUEST_NAMEK_ISOLATION then
			elseif q_ptr[which] == QUEST_NAMEK_LEVIATHAN then
				-- This method is archaic as of alpha17
				-- implement something simpler, please
				local found = {}
				for_inventory(player, INVEN_INVEN, INVEN_TOTAL,
					function(obj, i, j, item)
						if obj.tval == TV_CORPSE then
							if obj.sval == SV_CORPSE_CORPSE then
								local race = r_info[1 + get_flag(obj, FLAG_MONSTER_IDX)]
								if has_flag(race, FLAG_I_AM_A_LEVIATHAN) then
									%found.obj  = obj
									%found.item = item
									return
								end
							end
						end
					end)

				if found.obj then
					term.text_out(color.LIGHT_GREEN, elder .. ": ")
					term.text_out("So you have. You have proven your strength. I will give you the dragonball in my keeping. Though I fear it will do you no good.\n\n")
					term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
					term.text_out("Thank you. What shall I do with this carcass?\n\n")
					term.text_out(color.LIGHT_GREEN, elder .. ": ")
					term.text_out("Take it with you, please.\n\n")
					dialogue.conclude()
					term.load()
					term.save() -- for while end friendliness
					quest(QUEST_NAMEK_LEVIATHAN).status = QUEST_STATUS_FINISHED
					local obj = create_artifact(ART_NAMEK_DRAGONBALL6)
					make_item_fully_identified(obj)
					dball.reward(obj)
				else
					-- Quest has been issued
					if dball_data.namek_lev_check == 1 then
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("I don't believe you.\n\n")
						dialogue.conclude()
					elseif dball_data.namek_lev_check == 2 then
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Have you? It's possible you may have slain a leviathan, but you clearly have brought no evidence of such.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("What exactly do you want me to do, bring back the carcass?\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Yes, that would do.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("WHAT!?!? Are you serious? Those things have to weigh twenty tons!\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("You say that as if it were too difficult for you. You don't really expect me to give my dragonball to just anybody, do you?\n\n")
						dialogue.conclude()
					else
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Curious. You should never be able to reach this dialogue path.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("Really? Why's that?\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Because this dialogue involves a variable that should never default out of its if else block.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("Whoa! You're serious?!?!\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Extremely. Please report this as a bug.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("If I do will you give me your dragonball?\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Umm...probably not. But it will be good karma.\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("Ok. I'll report it.\n\n")
						dialogue.conclude()
					end
			
				end
			elseif q_ptr[which] == QUEST_NAMEK_GREAT_ELDER then

				if dball.dragonballs_carried(FLAG_NAMEK_DRAGONBALL) == 6 then
					-- == 6 should be correct if there are no bugs
					term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
					term.text_out("So you have. Very well, I shall give you the seventh, and final dragonball. I am curious. Now that you have, what do you intend to do with them?\n\n")
					if dball_data.summoned_shenron == 0 then
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("I'm going to summon the dragon to grant me a wish.\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
						term.text_out("I see. Very well, then. \n\n")
					else
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("I'm going to Summon the eternal dragon, Shenron, so that he may grant me a wish.\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
						term.text_out("...Shenron?\n\n")
						term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
						term.text_out("Yes, the eternal dragon of...oh. Of earth. I guess you have a different dragon here on Namek?\n\n")
						term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
						term.text_out("For an offworlder you seem to know a great deal about our dragonballs, and yet, some of what you know may not be as true here as it is from where you come. Remember this. Other surprises may yet await you.\n\n")
					end
					dialogue.conclude()
				else
					term.text_out(color.LIGHT_GREEN, elder .. which .. ": ")
					term.text_out("The six Elders have each given you their dragonball? Very well. Bring them here to me and I will give you the final dragonball.\n\n")
					dialogue.conclude()
				end
			else
				term.text_out(color.GREEN, "Error! Unknown Namek quest!\n\n")
				dialogue.conclude()
			end

		elseif ans == "d" then
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("Ahhh...the ajisa. It is the eternal symbol of beauty of Namek. The lovely tree in its myriad shades of purple. \n\n")
			dialogue.conclude()
		elseif ans == "e" then
			if which == 7 then
				term.text_out(color.LIGHT_GREEN, elder .. ": ")
				term.text_out("My children have named me such. I am the oldest surviving member of our race, and am father to all who still live. A hundred years ago a terrible meteor shower tore through our atmosphere and killed nearly every living thing on Namek. I alone amongst our race, survived. All the Nameks alive on Namek today were either hatched by me, or my direct offspring.\n\n")
			else
				term.text_out(color.LIGHT_GREEN, elder .. ": ")
				term.text_out("Our Great Elder is the only living Namek to have survived the catastrophe of a hundred years ago. Every Namek you see today was hatched by him personally. It is he who created the Dragonballs of Namek, though we have rarely used them even in times of the greatest calamity. The Great Elder watches over us from his hermitage, along with his aide, Nail.\n\n")
				dball_data.namek_know_db = 1
			end
			dialogue.conclude()
		elseif ans == "f" then
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("Implement path!\n\n")
			dialogue.conclude()
		elseif ans == "g" then
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("We Nameks are a proud, but peaceful race. Our warriors are amongst the most powerful in the galaxy, but we do not revel in war. To us combat is a beautiful art and a means to insure peace. We prefer to live in harmony with nature. Tending to the ajisa plants instead of making war, we are quite content.\n\n")
			dialogue.conclude()
			dball_data.namek_know_aj = 1
		elseif ans == "h" then
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("A hundred years ago Namek was the most beautiful planet in this part of the galaxy. Sadly, it was met with an atmospheric catastrophe that nearly destroyed the entire surface of the planet, and threatened to nearly obliterate our race. Having no interest in conquest, few of our number have strayed from home. When the crisis occurred, only a single Namekkian on the planet survived: the Great Elder. It is from he that all the hundred or so living Nameks on this planet were hatched. And, collectively we have all lived with but a single purpose: to restore our beloved Namek to its former beauty. That is why we toil every day to sow our fields with the ajisa plant. We do not eat them. No, we simply long to once again see their beauty from horizon to horizon. That is the true Namek. The Namek we love.\n\n")
			dball_data.namek_know_gr = 1
			dialogue.conclude()
		elseif ans == "i" then
			dball.chalign(-500)
			if which == 7 then
				term.text_out(color.LIGHT_GREEN, elder .. ": ")
				term.text_out("I am saddened by your lust for blood and power. But I shall not relent. Our race has faced extinction in the past, and fate granted us our survival. Perhaps we will be spared from yoru wrath as well. Or, perhaps not. But, we would sonoer die with honor than help an evil worm such as yourself.\n\nDo as you will. Whether you succeed or not, the secret of the dragonballs will never be yours.\n\n")
			else
				term.text_out(color.LIGHT_GREEN, elder .. ": ")
				local response = rng(1, 5)
				if response == 1 then
					term.text_out("Hmph. Take it, if you can. You may find it will not be so easy as you think.\n\n")
				elseif response == 1 then
					term.text_out("No. I will not give it to you. Please leave.\n\n")
				elseif response == 1 then
					term.text_out("We of Namek shall never submit to the will of an evil-doer such as yourself. I must ask you to leave now.\n\n")
				elseif response == 1 then
					term.text_out("Never! We would sooner die than give up our mosts acred to treasure to one who would take such things by force!\n\n")
				else
					term.text_out("The dragonballs are not for you. Only the righteous may use them, and you are certainly not that. Please leave.\n\n")
				end
			end
			dialogue.conclude()
			dball.faction_annoy(FACTION_NAMEK)
			break
		elseif ans == "j" then
			dball_data.namek_know_db = 2
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			if quest(QUEST_DRAGONBALLS).status ~= QUEST_STATUS_UNTAKEN then
				term.text_out("Oh? How interesting. The power of manifestation is unique to our race, and only a very few of us are able to create such artifacts as the dragonballs. Ours were created by our Great Elder.\n\n")
			else
				term.text_out("Yes, the Dragonballs. Seven mystic orbs created by our Great Elder, and guarded by the Elder of each of our seven villages. Together they may be used to summon the great Dragon of Love, Porunga, who will grant his summoner any wish.\n\n")
				term.text_out("They are a great treasure, the Dragonballs, and as such we guard them very well.\n\n")
			end
			dialogue.conclude()
		elseif ans == "k" then	-- quest 1: water
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("Yes, the Dragonballs. Seven mystic orbs created by our Great Elder, and guarded by the Elder of each of our seven villages. Together they may be used to summon the great Dragon of Love, Porunga, who will grant his summoner any wish.\n\n")
			term.text_out("They are a great treasure, the Dragonballs, and as such we guard them very well.\n\n")
		elseif ans == "l" then	-- quest 2: pollination
		elseif ans == "m" then	-- quest 3: seed retreival
			if which == 7 then -- Great Elder does not give seeds
				term.text_out(color.LIGHT_GREEN, elder .. ": ")
				term.text_out("Ahh...a most charitable thing you are doing. Sadly, however, we do not plant the ajisa plant here on this mountain, and I have no seeds to give you. I suggest visiting the other Elders. They are likely to help you.\n\n")
			else
				if namek_seeds[which] == 0 then
					if quest(q_ptr[1]).status == QUEST_STATUS_FINISHED or namek_pollinate[which] ~= 0 then
						-- Elders only give seeds out to players after they've
						-- completed the quest for, or delivered plants to
						-- the elder in question
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Ahh...this is a most helpful things you are doing. Yes, I will help you. Here. I have four seeds with me. Take them and deliver them to the Elder, with my blessing.\n\n")
						dialogue.conclude()
						namek_seeds[which] = 4
						local obj = create_object(TV_MISC, SV_NAM_AJASA_SEED)
						obj.number = 4
						make_item_fully_identified(obj)
						dball.reward(obj)
					else
						term.text_out(color.LIGHT_GREEN, elder .. ": ")
						term.text_out("Hmm. Forgive me. I do not mean to be rude, but you are still a stranger and the ajisa is one of our most cherished blessings. I do not feel comfortable giving away seeds to you.\n\n")
					end
				else
					term.text_out(color.LIGHT_GREEN, elder .. ": ")
					term.text_out("I have already given you ajisa seeds. Please tell me you have not misplaced them.\n\n")
				end
			end
		elseif ans == "n" then	-- quest 4: plant a tree
		elseif ans == "o" then	-- quest 5: successor
		elseif ans == "p" then	-- quest 6: leviathan
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("A Leviathan...? That is the traditional test of a warrior after half a lifetime of training with an elder! How is it that you've been tasked with this after such a short time on Namek?\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("I'm attempting to gather the dragonballs together. One of the elders said he would give me his dragonball if I could do it.\n\n")
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("Ahh. I understand. Yes, that is an appropriate task. Very, well. I will help you. But be forewarned this is not a task to be taken lightly. The Leviathan is a solitary hunter of deeper water. It is rare for them to surface except when stalking prey. If you truly wish to face a Leviathan, my advice would be to head out into the middle of the ocean in the northeast corner of Namek.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Head to the ocean? Ok. Then what?\n\n")
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("Look tasty.\n\n")
			dialogue.conclude()
			term.load()
			term.save()
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Uh huh. Ok. I think I get the picture.\n\n")
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("The Leviathan will usually not suface until it is near it's prey. You may not see it until it is nearly upon you. Also, remember these are sea creatures. It will be folly to fly over the wayer and hope to find one. Instead, you must get into the water, and allow yourself to be found. \n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Great. Do you have any good news for me?\n\n")
			term.text_out(color.LIGHT_GREEN, elder .. ": ")
			term.text_out("They are too large to comfortably approach close to land. If you are injured, try to return to shallow water. They may give up chase.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("That's good to know. Alright. Thank you.\n\n")
			dialogue.conclude()
		elseif ans == "q" then	-- quest 7: Great Elder
			-- Unused, right?
		end
		term.load()
	end


	-- Ehh...
	dball_data.namek_elder1 = elder_data[1]
	dball_data.namek_elder2 = elder_data[2]
	dball_data.namek_elder3 = elder_data[3]
	dball_data.namek_elder4 = elder_data[4]
	dball_data.namek_elder5 = elder_data[5]
	dball_data.namek_elder6 = elder_data[6]
	dball_data.namek_elder7 = elder_data[7]
end

function dialogue.NAMEK_GENERIC()
	term.gotoxy(0, 0)
	-- namek_general_state
	-- 0 = no contact
	-- 1 = 

	term.save()

	if dball_data.namek_general_state == 0 then
		dball_data.namek_general_state = 1
		term.text_out(color.LIGHT_GREEN, "Namek: ")
		term.text_out("An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?\n\n")
		dialogue.helper("A friend, I think. Who are you? Where am I?", "a")
		dialogue.helper("I am an explorer. I'm sorry...but why do I feel so heavy? It's difficult for me to even walk!", "b")
		if dball_data.namek_know_db == 1 then
			if dball_data.alignment > 0 then
				-- dialogue.helper("Hello, friend Namek! I'm here searching for the Dragonballs.", "c")
			else
				-- dialogue.helper("I'm here searching for the Dragonballs.", "d")
			end
		end
		if dball_data.alignment > 0 then
			dialogue.helper("Hey, slug! I'm here to kill you all. I guess that makes me a 'foe' huh?", "e")
		end
		-- saiyajin thread
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_GREEN, "Namek: ")
			term.text_out("This is the planet Namek, and I am a native of this planet. If you would be our friend, then you are most welcome.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Thank you. Charming place. The colors here are lovely.\n\n")
			term.text_out(color.LIGHT_GREEN, "Namek: ")
			term.text_out("And thank you, stranger. But perhaps I am not the most suitable contact for you. May I recommend that you visit one of our village Elders? I'm sure they'll be able tell you far more about our world than I could.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Village Elder? Alright. Thank you. I think I'll do that.\n\n")
		elseif ans == "b" then
			term.text_out(color.LIGHT_GREEN, "Namek: ")
			term.text_out("Heavy? Ahh...you must come from a world with lighter gravity than ours. Yes, it can be difficult. I myself have never been off this planet, so I cannot say I have experienced what you describe. But, I have heard stories of other worlds.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("It...is difficult...yes. Please don't think me rude. I am an explorer, and I am glad to be here...but I didn't expect this.\n\n")
			term.text_out(color.LIGHT_GREEN, "Namek: ")
			term.text_out("I understand. Perhaps you should speak to one of our Elders. We occassionally have guests from other worlds, and they may be able to help you. Or at least offer you a comfortable place to rest.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Oh? Where might I find them?\n\n")
			term.text_out(color.LIGHT_GREEN, "Namek: ")
			term.text_out("Each of our villages have an Elder. Look for yurts carved of stone.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Thank you.\n\n")

		elseif ans == "c" then
			-- know dragonballs on namek
			term.load()
		elseif ans == "d" then
			term.text_out(color.LIGHT_GREEN, "Namek: ")
			term.text_out("I see. We of Namek have dealt with your kind before. And I do not believe you will be the last. Flee from this world while you're still able!\n\n")
			dball_data.namek_general_state = 999
		elseif ans == "e" then
			-- Saiajin thread?
		end
	elseif dball_data.namek_general_state == 999 then
		local foo = {"Foul betrayer!", "Have you not outstayed your welcome?", "Why have you not left?", "You are not welcome on this planet."}
		term.text_out(color.LIGHT_GREEN, "Namek: ")
		term.text_out(foo(rng(1, getn(foo))) .. "\n\n")
	else
		term.text_out(color.LIGHT_GREEN, "Namek: ")
		term.text_out("Hello, " .. player_name() .. ".\n\n")
	end

	dialogue.conclude()
	term.load()
end

function dialogue.NAMEK_DENDE()
	-- If this is our first contact on Namek, mark that we've made contact
	term.text_out(color.LIGHT_GREEN, "Dende: ")
	if dball_data.namek_general_state == 0 then
		dball_data.namek_general_state = 1
	end

	if dball_data.dende_state == 0 then

	else

	if quest(QUEST_NAMEK_ISOLATION).status == QUEST_STATUS_TAKEN then
	end
	if player.stat(A_CHR) > 15 then
	end

	if dball.may_i_party(RACE_DENDE) == FLAG_PARTY_ALLOWED then

				term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
				term.text_out("Certainly. I'm always happy to help a fellow brother in Crane.\n\n")
				dialogue.conclude()
				party.party(RACE_DENDE)
			else
				term.text_out(color.LIGHT_BLUE, "Tenshinhan: ")
				term.text_out("I'm sorry. I am at a critical moment of my training, and I cannot abandon it now.\n\n")
				dialogue.conclude()
			end
	end

	term.text_out("An offworlder! Hail, stranger. What brings you to Namek? Are you here as a friend, or foe?\n\n")
	dialogue.helper("A friend, I think. Who are you? Where am I?", "a")



end

function dialogue.NAMEK_NAIL()
	-- If this is our first contact on Namek, mark that we've made contact
	if dball_data.namek_general_state == 0 then
		dball_data.namek_general_state = 1
	end
	message("Implement me!")
end

function dialogue.MIA()
	if party.is_partied(RACE_MIA) > 0 then
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mia: ")
		term.text_out("Wow!!! It's so -=FUN=- being in a party with you!!! Thank you so much!\n\n")
		dialogue.helper("I'm glad you're having fun. Let's go explore some more, shall we?", "a")
		dialogue.helper("It was nice having you around, but I think it's time for me to move on.", "b")
		local ans = dialogue.answer()
		term.load()
		term.save()
		if ans == "a" then
			term.text_out(color.LIGHT_BLUE, "Mia: ")
			term.text_out("Yuppers!!!\n\n")
			dialogue.conclude()
			term.load()
		elseif ans == "b" then
			term.text_out(color.LIGHT_BLUE, "Mia: ")
			term.text_out("Ok! I'll go do something else exciting for a while! Come back if you want to play some more! :)\n\n")
			dialogue.conclude()
			term.load()
			party.unparty(RACE_MIA)
		end
	else
		term.save()
		term.text_out(color.LIGHT_BLUE, "Mia: ")
		term.text_out("HELLO!!!!!! :) :) :)\n\n")
		term.text_out("I wanna join your party!!!! May I? May I? Please?!!?!?\n\n")
		dialogue.helper("Sure.", "a")
		dialogue.helper("No chance.", "b")
		local ans = dialogue.answer()
		term.load()
		if ans == "a" then
			term.save()
			term.text_out(color.LIGHT_BLUE, "Mia: ")
			term.text_out("Yay! Yay for me! I get to be in a party, yay! I am a happy Mia!!! :)\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("Wow. You're really into this, huh? Do you have anything useful to offer other than exhuberance?\n\n")
			term.text_out(color.LIGHT_BLUE, "Mia: ")
			term.text_out("Yuppers! You can press 'p' to access the party command menu.\n\n")
			term.text_out(color.LIGHT_BLUE, player_name() .. ": ")
			term.text_out("That's good to know.\n\n")
			term.text_out(color.LIGHT_BLUE, "Mia: ")
			term.text_out("Thank you! I aim to please. :)\n\n")
			dialogue.conclude()
			term.load()
			party.party(RACE_MIA)
		elseif ans == "b" then
		end
	end
end

--[[
function dialogue.PLAYTEST()
	term.save()

	term.text_out(color.LIGHT_BLUE, "Character Build:  "
	if dball_data.playtest_build == 0 then
		term.text_out("Default\n\n")
	elseif dball_data.playtest_build == 1 then
		term.text_out("Barehand\n\n")
	elseif dball_data.playtest_build == 2 then
		term.text_out("Weapons\n\n")
	elseif dball_data.playtest_build == 3 then
		term.text_out("Technomancer\n\n")
	elseif dball_data.playtest_build == 4 then
		term.text_out("Chi\n\n")
	elseif dball_data.playtest_build == 5 then
		term.text_out("Marksman\n\n")
	end
	term.text_out(color.LIGHT_BLUE, "Game Progression: "
	if dball_data.playtest_level == 0 then
		term.text_out("Default\n\n")
	elseif dball_data.playtest_level == 1 then
		term.text_out("Early game\n\n")
	elseif dball_data.playtest_level == 2 then
		term.text_out("Middle game\n\n")
	elseif dball_data.playtest_level == 3 then
		term.text_out("Late game\n\n")
	elseif dball_data.playtest_level == 4 then
		term.text_out("God Mode\n\n")
	end
	
	dball_data.playtest_level = 0

	term.text_out(color.LIGHT_GREEN, "Playtest Device: "
	term.text_out("Hello! What would you like to do?\n\n")
	dialogue.helper("Nothing at this time.", "a")
	dialogue.helper("Change my build", "b")
	dialogue.helper("Change my general level and skillset", "c")
	dialogue.helper("Reset school enrollments", "d")
	local ans = dialogue.answer()
	term.load()
	if ans == "a" then
	elseif ans == "b" then
		term.save()
		term.text_out(color.LIGHT_GREEN, "Playtest Device: "
		term.text_out("Which build?\n\n")
		dialogue.helper("Barehanded", "a")
		dialogue.helper("Weapons", "b")
		dialogue.helper("Technomancer", "c")
		dialogue.helper("Chi", "d")
		dialogue.helper("Marksman", "e")
	elseif ans == "c" then
	elseif ans == "d" then
	end	

dball.drop_everything()

	term.text_out(color.GREEN, "Done!")
end
]]








