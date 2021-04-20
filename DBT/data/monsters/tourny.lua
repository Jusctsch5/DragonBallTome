-- Wilderness monsters

new_monster_races
{
	--------------------------- PEOPLE --------------------------
	['p'] =	{
		defaults = {
			sleep  = 0

			body = default_body.humanoid
			flags = {
				DROP_CORPSE=true
				DROP_THEME = getter.flags { THEME_PLAIN=50 THEME_TREASURE=50 }
			}
		} -- defaults
		[1] =
		{
			define_as = "RACE_WT_TICKET_GIRL"
			name = "Ticket Girl"
			level = 1 rarity = 100
			desc = "It's the World Tournament Ticket Girl!"
			color = color.RED
			speed = 0 life = {1,4} ac = 1
			aaf = 10 sleep = 0
			exp = 1
			weight = 120
			blows = {}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.RUN_AWAY
				FEMALE=true
				FACTION=FACTION_GOOD
				KARMA=-10
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH=function(name)
					message("You killed the ticket girl. Something bad should happen to you, or something.") 
				end
				DBTCHAT=function()

					if dball_data.alive ~= 0 then
						message("Eeek! A ghost! Eeek! Eeek!")
					elseif dball_data.tourny_registered == 4 then
						message("That was awfully lousy of you to try to cheat like that.")
					elseif dball_data.tourny_registered > 1 then
						message("Sorry you lost. Come again next year?")
					elseif dball_data.tourny_registered == 0 then
						if player.au >= 100 then
							message("Admission is free to watch. 100zeni to register. ")
							local ret, raw_key, key
							ret, raw_key = get_com("Are you here to fight? (y/n)")

							if not ret then

							else
								key = strlower(strchar(raw_key))
								if key == "y" then
									player.au = player.au - 100
									dball_data.tourny_registered = 1
									player.redraw[FLAG_PR_GOLD] = true
									term.save()
									term.text_out(color.LIGHT_BLUE, "Ticket Girl: ")
									term.text_out("Congratulations! You're now Registered for the 22nd World Tournament! Here's a brochure with the Tournamnet rules. I recommend you read them. Whenever you're ready to start, go through that door to the east and speak to the Backstage Organizer. He'll take you from there.\n\n")
									dialogue.conclude()
									term.load()
									local obj = create_object(TV_PARCHMENT, SV_WT_GUIDE)
									dball.reward(obj)
								end
							end
						else
							message("Welcome to the Tournament. Admission is free for the audience, it's 100zn to register.")
						end
					elseif dball_data.tourny_round > 5 then
						if player.get_sex() == "Female" then
							monster_random_say{
							"The ticket girl says 'Wow! You really inspire me!'",
							"The ticket girl smiles happily to see you.",}
						else
							monster_random_say{
							"The ticket girl blushes and smiles coyly at you.",
							"The ticket girl stutters '...hi...umm, you're...ummm...wow!",}
						end
					elseif dball_data.tourny_round > 0 then
						monster_random_say{
						"The ticket girl says 'Wow! I didn't think you'd make it this far. Err...no, I didn't mean..umm....nevermind.'",
						"The ticket girl says 'Congratulations. Not many people can survive out there, you know.'",}
					else
						message("The ticket girl says 'When you're ready, head backstage. Go through the door to the east.'")
					end
				 end
			}
		}
		[2] =
		{
			define_as = "RACE_WT_GUARD"
			name = "Backstage Guard"
			level = 17 rarity = 100
			desc = {
				"This guy guards the backstage area to make sure nobody pesters the fighters with demands",
				"for autographs. He obviously lifts weights, but given the nature of the event, but given",
				"the nature of the event, it's not like he really has to guard anything. Nobody is going",
				"to try to bust into the backroom where the worlds greatest fighters are warming up, are",
				"they?",
			}
			color = color.UMBER
			speed = 7 life = {10,10} ac = 100
			aaf = 10 sleep = 0
			exp = 1
			weight = 2100
			blows =
				{
					{"PUNCH","CRUSH",{8,8}},
				}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				NO_FEAR=true
				MALE=true
				FACTION=FACTION_GOOD
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH=function(name)
					message("You killed the bouncer. I bet some people are going to be annoyed with you.") 
				end
				DBTCHAT=function()
					if dball_data.tourny_registered == 4 then
						message("The guard just shakes his head at you.")
					elseif dball_data.tourny_registered > 1 then
						message("The backstage guard says 'I respect anyone who fights in something like this, win or lose.'")
					elseif dball_data.tourny_registered == 0 then
						monster_random_say{
						"The backstage guard says 'Get outta here. Fighters only.'",
						"The backstage guard stares at you.",}
					elseif dball_data.tourny_round > 5 then
						monster_random_say{
						"The backstage guard gives you a high-five.",
						"The backstage guard nods respectfully at you.",}
					elseif dball_data.tourny_round > 0 then
						monster_random_say{
						"The backstage guard says 'Congratulations. You're doing well.'",
						"The backstage guard shrugs and says 'Ehh...you're doing ok, but it's still early.'",}
					else
						monster_random_say{
						"The backstage guard says 'Good luck.'",
						"The backstage guard says 'Try not to get killed out there.'",}
					end
				 end
			}
		}
		[3] =
		{
			define_as = "RACE_WT_AUDIENCE_BLUE"
			name = "audience member"
			level = 1 rarity = 100
			desc = "A random audience member."
			color = color.LIGHT_BLUE
			speed = 0 life = {1,4} ac = 1
			aaf = 10 sleep = 0
			exp = 1
			weight = 120
			blows = {}
			flags = {
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				MALE=true
				FACTION=FACTION_GOOD
				KARMA=-10
				ON_DEATH=function(name)
					message("Ooohhh...killing audience members. That's got to be bad karma, or something")
				end
				DBTCHAT=function(name)
					if dball_data.tourny_registered == 4 then
						message("Oh, look! That's the guy who cheated!")
					elseif dball_data.tourny_registered > 1 then
						if dball_data.tourny_round == 0 then
							message("Oh, look! There's the clumsy idiot who couldn't even qualify!")
						else
							message("Oh, look! That's the one who lost in round ".. dball_data.tourny_round .."!")
						end
					elseif dball_data.tourny_round > 5 then
						monster_random_say{
						"He begs for your autograph",
						"He exclaims 'Wow! I think you're going to win!'",}
					elseif dball_data.tourny_round > 0 then
						monster_random_say{
						"He says 'Hey...I recognize you!'",
						"He says 'You're a fighter! Wow!'",}
					else
						monster_random_say{
						"He says 'I'm so excited!'",
						"He exclaims 'Wow! Isn't this great!'",
						"He asks 'Don't you wish you could be a fighter?'",}
					end
				 end
			}
		}
		[4] =
		{
			define_as = "RACE_WT_AUDIENCE_GREEN"
			name = "audience member"
			level = 1 rarity = 100
			desc = "A random audience member."
			color = color.GREEN
			speed = 0 life = {1,4} ac = 1
			aaf = 10 sleep = 0
			exp = 1
			weight = 120
			blows = {}
			flags = {
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				MALE=true
				FACTION=FACTION_GOOD
				KARMA=-10
				GOOD=true
				ON_DEATH=function(name)
					message("Ooohhh...killing audience members. That's got to be bad karma, or something")
				end
				DBTCHAT=function(name)
					if dball_data.tourny_registered == 4 then
						message("Oh, look! That's the guy who cheated!")
					elseif dball_data.tourny_registered > 1 then
						message("Wow, if you were going to lose that badly, why'd you even sign up?")
					elseif dball_data.tourny_round > 5 then
						monster_random_say{
						"He begs for your autograph",
						"He exclaims 'Wow! I think you're going to win!'",}
					elseif dball_data.tourny_round > 0 then
						monster_random_say{
						"He says 'Hey...I recognize you!'",
						"He says 'You're a fighter! Wow!'",}
					else
						monster_random_say{
						"He says 'I'm so excited!'",
						"He exclaims 'Wow! Isn't this great!'",
						"He asks 'Don't you wish you could be a fighter?'",}
					end
				 end
			}
		}
		[5] =
		{
			define_as = "RACE_WT_AUDIENCE_YELLOW"
			name = "audience member"
			level = 1 rarity = 100
			desc = "A random audience member."
			color = color.YELLOW
			speed = 0 life = {1,4} ac = 1
			aaf = 10 sleep = 0
			exp = 1
			weight = 120
			blows = {}
			flags = {
				AI=ai.DBT_RANDOM
				DBT_AI=ai.RUN_AWAY
				MALE=true
				FACTION=FACTION_GOOD
				GOOD=true
				KARMA=-10
				ON_DEATH=function(name)
					message("Ooohhh...killing audience members. That's got to be bad karma, or something")
				end
				DBTCHAT=function(name)
					if dball_data.tourny_registered == 4 then
						message("Oh, look! That's the guy who cheated!")
					elseif dball_data.tourny_registered > 1 then
						message("Loser!")
					elseif dball_data.tourny_round > 5 then
						monster_random_say{
						"He begs for your autograph",
						"He exclaims 'Wow! I think you're going to win!'",}
					elseif dball_data.tourny_round > 0 then
						monster_random_say{
						"He says 'Hey...I recognize you!'",
						"He says 'You're a fighter! Wow!'",}
					else
						monster_random_say{
						"He says 'I'm so excited!'",
						"He exclaims 'Wow! Isn't this great!'",
						"He asks 'Don't you wish you could be a fighter?'",}
					end
				 end
			}
		}
		[6] =
		{
			define_as = "RACE_WT_BACKSTAGE_GUY"
			name = "Backstage Organizer"
			level = 5 rarity = 100
			desc = "This is the backstage coordinator. Talk to him when you're ready for your next match."
			color = color.ORANGE
			speed = 0 life = {10,10} ac = 100
			aaf = 10 sleep = 0
			exp = 1
			weight = 120
			blows = {}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.DBT_ZOMBIE
				MALE=true
				FACTION=FACTION_GOOD
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH=function(name)
					message("Hmm. Killing the backstage organizer is not very nice.")
				end
				DBTCHAT=function(name)
					dialogue.WT_BACKSTAGE()
				end
			}
		}
		[7] =
		{
			define_as = "RACE_WT_MEDIC"
			name = "Medic"
			level = 1 rarity = 999
			desc =
				{
				"This volunteer EMT sits on the sidelines, eagerly watching the fights. You notice that",
				"she screams in thrilled anticipation every time she sees blood, and periodically holds up",
				"score cards to rate especially satisfying knockouts. You understand that as an EMT she",
				"must see an awful lot of injuries and bloodshed, but you wonder if maybe she's a bit behind",
				"on her sensitivity refresher courses.",
				}
			color = color.RED
			speed = 0 life = {1,4} ac = 1
			aaf = 10 sleep = 0
			exp = 1
			weight = 120
			blows = {}
			flags = {
				AI=ai.DBT_NEVER_MOVE
				DBT_AI=ai.RUN_AWAY
				FEMALE=true
				FACTION=FACTION_GOOD
				GOOD=true
				GOTO_HEAVEN=true
				ON_DEATH=function(name)
					monster_random_say{
					"You killed the medic. That probably wasn't wise.",
					"You splattered her pretty good. Pity she's not alive to see it.",}
				end
				DBTCHAT=function(name)
					dialogue.WT_MEDIC()
				end
			}
		}
	}
}
