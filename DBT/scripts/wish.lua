-- Dragonball T: Wishing

new_flag("WISH_GRANTED")	-- Note: GRANTED wishes require no wish_message, as they get a standard response
new_flag("WISH_CONFIRM")
new_flag("WISH_UNKNOWN")
new_flag("WISH_FAILURE")

function dball.wish(wish_str)
	local wish_granted = FLAG_WISH_UNKNOWN		-- From flags above
	local wish_message = "You shouln't see this"	-- If approved, what shall we say?
	local wish_confirm = "You shouln't see this"	-- Confirmation string
	local wish_quality = 0					-- Some wishes annoy Shenron
	local wish_wishfct					-- function containing the results of the wish

	local wish_blanket = 0	-- Internal checking here. Shenron doesn't use this.

	-- First, let's be picky about proper form

	wish_str = strlower(wish_str)

	if not starts_with(wish_str, "i wish ") then
		return FLAG_WISH_FAILURE, "That is not the proper form. Wishes must begin with 'I wish'."

	-- Does it look like an item request?
	elseif dball.wish_for_item(wish_str) then
		return FLAG_WISH_GRANTED

	-- Is it obviously a travel wish? (must occur before number checking, to allow travel to Planet 79)
	elseif strfind(wish_str, " travel to") or strfind(wish_str, " be sent to") or strfind(wish_str, " send me to") or strfind(wish_str, " teleport to") or strfind(wish_str, " to go ") or strfind(wish_str, " return to") then
		if dball.wish_for_travel(wish_str) then
			local woz_joke = "Granted."
			if strfind(wish_str, " home") and dball_data.ruby_slippers == 0 and rng(1, 3) then
				local woz_joke = "Granted, Dorothy."
				dball.reward(create_artifact(ART_DOROTHY))
			end
			return FLAG_WISH_GRANTED
		else
			wish_granted = FLAG_WISH_FAILURE
			wish_message = "Hmm. I am certainly capable of sending you to anywhere in the universe, but I do not recognize the location you are asking for. (Dungeon teleport wishes have not been implemented yet)"
			wish_quality = 0
		end

	-- Does it appear to be a request to have a corruption removed?
	-- elseif strfind(wish_str, " remove ") then

	-- is it a request to have ALL corruptions removed?
	-- elseif strfind(wish_str, " be fully human ") then

	-- Does it appear to be a wish for a house?
	elseif strfind(wish_str, " house") or strfind(wish_str, " home") then
		if strfind(wish_str, " namek") then
			if dball_data.wishhouse_namek == 1 then
				return FLAG_WISH_FAILURE, "You already have a wish-house on Namek. Perhaps you mispoke?"
			else
				wish_granted = FLAG_WISH_CONFIRM
				wish_message = "Very well. I shall conjure up the stones on Namek to form a home for you there."
				wish_confirm = "You wish to have a house on the planet Namek? (NOT IMPLEMENTED)"
				wish_wishfct = function() dball_data.wishhouse_namek = 1 end
				return wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct
			end
		else
			if dball_data.wishhouse_earth == 1 then
				return FLAG_WISH_FAILURE, "You already have a wish-house on earth. Perhaps you mispoke?"
			else
				wish_granted = FLAG_WISH_CONFIRM
				wish_message = "Very well. I shall conjure up the stones to form a home for you."
				wish_confirm = "You wish to have a house?"
				wish_wishfct =	function()
								dball_data.wishhouse_earth = 1
								if dball.current_location == "Earth, SW" then
									dball.place_wishhouse("Earth")
								end
							end
				return wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct
			end
		end

	-- Does it appear to be a transformation wish?
	elseif (strfind(wish_str, " to be a") or strfind(wish_str, " transform")) and (strfind(wish_str, " girl") or strfind(wish_str, " woman") or strfind(wish_str, " female")) then
			if dball_data.p_sex ~= "Female" then
				if dball_data.married == 0 then
					wish_granted = FLAG_WISH_CONFIRM
					wish_message = "Very well. I will grant your request."
					wish_confirm = "You wish to be made a female of your race?"
					wish_wishfct = function() dball_data.p_sex = "Female" end
					return wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct
				else
					return FLAG_WISH_FAILURE, "Gender changing wishes while married are not yet implemented, due to the dialogue implications they'll have on your spouse. It's on the to-do list, though."
				end
			else
				return FLAG_WISH_FAILURE, "You appear to be female already. Perhaps you mispoke?"
			end
	elseif (strfind(wish_str, " to be a") or strfind(wish_str, " transform")) and (strfind(wish_str, " boy") or strfind(wish_str, " man") or strfind(wish_str, " guy")) then
			if dball_data.p_sex ~= "Male" then
				if dball_data.married == 0 then
					wish_granted = FLAG_WISH_CONFIRM
					wish_message = "Very well. I will grant your request."
					wish_confirm = "You wish to be made a male of your race?"
					wish_wishfct = function() dball_data.p_sex = "Male" end
					return wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct
				else
					return FLAG_WISH_FAILURE, "Gender changing wishes while married are not yet implemented, due to the dialogue implications they'll have on your spouse. It's on the to-do list, though."
				end
			else
				return FLAG_WISH_FAILURE, "You appear to be male already. Perhaps you mispoke?"
			end

	elseif wish_str == "i wish to die" or wish_str == "i wish to be dead" or strfind(wish_str, "kill me") then
		if dball_data.immortality == 0 then
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "Very well. Since you wish it for yourself."
			wish_confirm = "You wish for your life to end?"
			wish_wishfct = 	function()
							message(color.RED, "You die.")
							kill_player("a foolish wish")
						end
		else
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "It shall be so."
			wish_confirm = "Yes, I see that your spirit is permanently trapped in this form. You wish to be released from the bindings of immortality, that your spirit may move on?"
			wish_wishfct = 	function()
							-- message(color.RED, "You die.")
							dball_data.immortality = 0
							take_hit(50000, "spiritual release")
							-- take_hit(player.chp(), "spiritual release")
						end
		end
		return wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct

	-- Next, refuse some disallowed request types
	elseif strfind(wish_str, " dragonball") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Once you have made your wish the dragonballs will be once again scattered across the earth. You may look for them again as you please."
		wish_quality = -1
	elseif strfind(wish_str, " points") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Your wish is unclear. What are these 'points' you speak of? If you desire something, speak it in clear language."
		wish_quality = -1
	elseif strfind(wish_str, " level") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Your wish is unclear. What is this 'level' you speak of? If you desire something, speak it in clear language."
		wish_quality = -1
	elseif strfind(wish_str, "0") or strfind(wish_str, "1") or strfind(wish_str, "2") or strfind(wish_str, "3") or strfind(wish_str, "4") or strfind(wish_str, "5") or strfind(wish_str, "6") or strfind(wish_str, "7") or strfind(wish_str, "8") or strfind(wish_str, "9") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Your wish is unclear. What are these numbers you speak of? If you desire something, speak it in clear language."
		wish_quality = -1
	elseif strfind(wish_str, "to die") or strfind(wish_str, "to kill") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Impertinent fool! I, the Eternal Dragon of the Earth will not violate free will, and yet you ask me to kill?"
		wish_quality = -99
	elseif strfind(wish_str, "all skill") or strfind(wish_str, "all abilit") or strfind(wish_str, " and ") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "This is an unnacceptable wish. You may wish only for a single thing."
		wish_quality = -1


	-- Next, let's look for some simple key phrases


	elseif strfind(wish_str, "healed") or strfind(wish_str, "cured") or strfind(wish_str, "rejuvenated") or strfind(wish_str, "heal me") or strfind(wish_str, "cure me") or strfind(wish_str, "for healing") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish for your body to be restored to full health?"
		wish_wishfct = 	function()
						dball.cure_cond()
						player.calc_bonuses()
						player.calc_hitpoints()
						counter.state(counter.LIFE, "silent", true)
						player.chp(player.mhp())
					end
	elseif strfind(wish_str, " rich") or strfind(wish_str, " wealth") or strfind(wish_str, " money") or strfind(wish_str, " zeni") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "You humans never cease to amaze me with your petty foolishness. For a single moment you have the boundless power of the heavens at your command, and yet you wish for mere money? Very well. I will grant your request."
		wish_confirm = "You wish for material wealth? You wish to be rich?"
		wish_wishfct = 	function()
						player.au = player.au + 1000000
					end
	elseif strfind(wish_str, "pot of gold") or strfind(wish_str, "crock of gold") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "A common, if somewhat misguided request. Very well."
		wish_confirm = "You wish to have a pot of gold?"
		wish_wishfct = 	function()
						drop_near(create_object(TV_MISC, SV_CROCK_OF_GOLD), -1, player.py, player.px)
					end
	elseif strfind(wish_str, "be tall") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall make it so."
		wish_confirm = "You wish to be tall?"
		wish_wishfct = 	function()
						-- Do nothing
					end
	elseif strfind(wish_str, "world peace") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "That is a wise and generous wish. Unfortunately it is beyond my power to grant. For that to come to pass, humans must choose it for themselves."
		wish_quality = 1
	elseif strfind(wish_str, "the nile") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "The Nile river? I think that is a wish more suitably granted by a Djinn."
		wish_quality = -1
	elseif strfind(wish_str, "happiness") or strfind(wish_str, "be happy") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "A very wise wish. Know that happiness is a thing which must come from within. He who is rich, famous, popular, or possessing of wordly goods may be happy, or not. So too, may he who lacks these things be equally happy...or not. In each case it is the desires and willingness to allow and accept their condition in life that brings happiness. I respect your wish, however, I cannot grant it. What you ask for may very well be within your power, but it is beyond mine."
		wish_quality = 0
	elseif strfind(wish_str, " love") or strfind(wish_str, "snuggle") or strfind(wish_str, "cuddle") or strfind(wish_str, "affection") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Hmm. I feel the desire in your heart, but that is a wish I cannot grant. No wish is powerful enough to compell a heart to love against its will. To find love, you will need to seek it out on your own. Try playing silly games like this less, too. That might help."
		wish_quality = -1
	elseif strfind(wish_str, " sex") or strfind(wish_str, " get laid") or strfind(wish_str, " like me") or strfind(wish_str, " friend") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Hmm. If this is truly what you desire, may I suggest you spend less time playing games like this and get outside more?"
		wish_quality = -1
	elseif strfind(wish_str, "rule the world") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Hmmph. A common request. But, very vague, not probably not grantable. What do you mean 'rule the world?' Do you mean to have power over others? Do you wish for people to love, fear or obey you? Or do you simply wish for others to acknowledge you by some ridiculous wordly title? Whichever it is you seek, I cannot grant it, for it would require the imposition of free will, something I cannot, and will not do."
		wish_quality = -4
	elseif strfind(wish_str, " the one ring") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "Hmm. An unusual request. I feel this ring you speak of...it is in a universe somewhat adjacent to ours. Curiously, it seems to possess a will of its own, and I cannot violate free will, whether it is possessed in a living, or non-living form."
		wish_quality = -1
	elseif strfind(wish_str, " pet ") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "That is an improper wish. I cannot compell any conscious being to be, or act contrary to their will."
		wish_quality = -1
	elseif strfind(wish_str, "for peace") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "An honorable request. However, what you ask for is beyond my power to grant. Know that internal peace of the soul comes from within."
		wish_quality = 0
	elseif strfind(wish_str, "know everything") or strfind(wish_str, "identify") or strfind(wish_str, "auto id") or strfind(wish_str, "know item") then
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "Very well. It is a reasonable wish. I will grant it."
			wish_confirm = "You wish to know everything about items and equipment? To be able to merely look at things and know their usefulness?"
			wish_wishfct = 	function()
							dball_data.wish_autoid = 1
						end
	elseif strfind(wish_str, "be resistant to") or strfind(wish_str, "to resist ") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "An acceptable request. Unfortunately wishing for resistance has not implemented yet."
		wish_quality = 0
	elseif strfind(wish_str, "be immune to") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "This may be an acceptable request. Unfortunately wishing for immunity has not implemented yet."
		wish_quality = 0
	elseif strfind(wish_str, "win the world tournament") then
		if quest(QUEST_TOURNAMENT).status == QUEST_STATUS_TAKEN then
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "Hmmph. Very well. Your request is not an honorable one, but I shall grant it."
			wish_confirm = "You wish me to intervene on your behalf, and cause you to win the World Tournament? (Only very partially implemented)"
			wish_wishfct = 	function()
							dball_data.win_world_tournament = 1
						end
		else
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "Very well. I shall see that you win the 23rd World Tournament...should you live to see it."
			wish_confirm = "You wish to to be made to win next year's World Tournament?"
			wish_wishfct = 	function()
							-- Implement me!
						end
		end

	-- Ressurections
	elseif strfind(wish_str, "ressurect") or strfind(wish_str, "back to life") or strfind(wish_str, " alive") or strfind(wish_str, " not dead") or strfind(wish_str, "not be dead") then
		if dball_data.alive ~= 0 then
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "Very well. It is done."
			wish_confirm = "You wish once again to inhabit a physical vessel? To be 'brought back to life?'"
			wish_wishfct = 	function()
							dball_data.alive = 0
							--dball.cure_cond()
							--player.calc_bonuses()
							--player.calc_hitpoints()
							--counter.state(counter.LIFE, "silent", true)
							--player.chp(player.mhp())
							player.calc_bonuses()
							player.redraw[FLAG_PR_BASIC] = true
						end
		else
			wish_granted = FLAG_WISH_FAILURE
			wish_message = "Yes, I can bring the dead back to life, provided they are willing to return. However, this has not been implemented yet."
			wish_quality = 0
		end

	-- Vague, but reasonable
	elseif strfind(wish_str, " energy") or strfind(wish_str, "chi practitioner") or strfind(wish_str, "chi power") or strfind(wish_str, "mental power") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well, I shall grant you knowledge of the finer energies."
		wish_confirm = "You wish to generally become a more powerful practitioner of the various Chi arts?"
		wish_wishfct = 	function()
						dball.wish_littlestat_helper(SKILL_INTELLIGENCE)
						dball.wish_littlestat_helper(SKILL_CHI)
						dball.wish_littlestat_helper(SKILL_CHI_OFFENSE)
						dball.wish_littlestat_helper(SKILL_CHI_DEFENSE)
						dball.wish_littlestat_helper(SKILL_CHI_GUNG)
						dball.wish_littlestat_helper(SKILL_CHI_REGENERATION)
					end
	elseif strfind(wish_str, " fighter") or strfind(wish_str, " power") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well, I shall grant you knowledge of the combatative arts and enhance your physical body."
		wish_confirm = "You wish to generally become a more skillful fighter?"
		wish_wishfct = 	function()
						dball.wish_littlestat_helper(SKILL_STRENGTH)
						dball.wish_littlestat_helper(SKILL_DEXTERITY)
						dball.wish_littlestat_helper(SKILL_CONSTITUTION)
						dball.wish_littlestat_helper(SKILL_MARTIALARTS)
						dball.wish_littlestat_helper(SKILL_HAND)
						dball.wish_littlestat_helper(SKILL_WEAPONS)
					end
	elseif strfind(wish_str, " technical") or strfind(wish_str, " technomanc") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well, I shall convey to you knowledge of the technical arts."
		wish_confirm = "You wish to generally become a more knowledgable Technomancer?"
		wish_wishfct = 	function()
						dball.wish_littlestat_helper(SKILL_TECHNOLOGY)
						dball.wish_littlestat_helper(SKILL_CONSTRUCTION)
						dball.wish_littlestat_helper(SKILL_DISASSEMBLY)
					end

	-- The Vegita wish!
	elseif strfind(wish_str, "be immortal") or strfind(wish_str, "immortality") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I question the wisdom of your request, but since you wish it for yourself, I shall make it so."
		wish_confirm = "Immortality? You mean you wish for your soul to be forever entrenched in this physical form it now inhabits? To be forever denied the glory of the spiritual realms that lie beyond this simple, transitory state you now find yourself in? Are you certain of this?"
		wish_wishfct = 	function()
						dball_data.immortality = 1
					end
-- Redundant, yes?
--[[
	-- The Oolong wish! (Won't this be redundant once item requests work?
	elseif strfind(wish_str, " panties") then
		drop_near(create_object(TV_MISC, SV_PAIR_OF_PANTIES), -1, player.py, player.px)
		return 0, true, "This is an acceptable wish. I will grant it."
]]

	-- Stat requests
	elseif strfind(wish_str, " strength") or strfind(wish_str, " strong") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to be made phsyically stronger?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_STRENGTH)
					end
	elseif strfind(wish_str, " intelligent") or strfind(wish_str, " smart") or strfind(wish_str, "understand") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become more intelligent?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_INTELLIGENCE)
					end
	elseif strfind(wish_str, " willpower") or strfind(wish_str, " willed") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish for your will to be strengthened?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_WILLPOWER)
					end
	elseif strfind(wish_str, " dexterity") or strfind(wish_str, " dextrous") or strfind(wish_str, " limber") or strfind(wish_str, " coordinated") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to be made physically more graceful and coordinated?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_DEXTERITY)
					end
	elseif strfind(wish_str, " tough") or strfind(wish_str, " sturdy") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish for your physical body to be made sturdier?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CONSTITUTION)
					end
	elseif strfind(wish_str, " charisma") or strfind(wish_str, " persuasive") or strfind(wish_str, "charismatic") or strfind(wish_str, "likeable") or strfind(wish_str, " be cute") or strfind(wish_str, " be pretty") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become a friendlier, kinder, more gentle person, and thus better able to relate to people and put them at ease?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CHARISMA)
					end
	elseif strfind(wish_str, " speed") or strfind(wish_str, " fast") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become quicker, and lighter in your motions?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_SPEED)
					end

--[[
	-- Only check abilities if we think there's reason to
	elseif strfind(wish_str, " ability") or strfind(wish_str, " power to") or strfind(wish_str, "know how") then
		if dball.wish_ability(wish_str) then
			return 0, true, "Very well, I shall teach you."
		end
]]

	-- Technologist recipe requests
	elseif strfind(wish_str, "how to build") or strfind(wish_str, "how to make") or strfind(wish_str, "how to assemble") or strfind(wish_str, "how to construct") then
		wish_granted = FLAG_WISH_FAILURE
		wish_message = "An acceptable request. Unfortuantely wishing for knowledge of tech recipes has not been implemented yet."
		wish_quality = 0


	-- Skill requests



	elseif strfind(wish_str, " martial art") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to gain broad knowlegde of the Martial Arts?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_MARTIALARTS)
					end
	elseif strfind(wish_str, " barehand") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become a better Barehanded fighter?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_HAND)
					end
	elseif strfind(wish_str, " dodge") or strfind(wish_str, "dodging")  then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become a better able to Dodge the blows of your opponents?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_DODGE)
					end
	elseif strfind(wish_str, " stealth") or strfind(wish_str, "silent") or strfind(wish_str, "quiet") or strfind(wish_str, "sneak") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become a more Stealthy?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_STEALTH)
					end
	elseif strfind(wish_str, " weapons") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become a more proficient Weapons fighter?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_WEAPONS)
					end
	elseif strfind(wish_str, " parry") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become more proficient at Parrying?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_PARRYING)
					end
	elseif strfind(wish_str, " paired") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become more skilled in the use of Paired weapons?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_PAIRED)
					end
	elseif strfind(wish_str, " marksman") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become a more skilled Marksman?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_MARKSMANSHIP)
					end
	elseif strfind(wish_str, " chi offense") or strfind(wish_str, " offensive chi") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to refine your ability to direct your Chi Offensively?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CHI_OFFENSE)
					end
	elseif strfind(wish_str, " chi defense") or strfind(wish_str, " defensive chi") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to refine your skill at defending yourself with Chi?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CHI_DEFENSE)
					end
	elseif strfind(wish_str, " chi regeneration") or strfind(wish_str, " regenerate chi") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to widen the channel of your regenerative mental energies, thus able to more quickly replenish them?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CHI_REGENERATION)
					end
	elseif strfind(wish_str, " chi gung") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to gain knowledge of Chi Gung?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CHI_GUNG)
					end
	elseif strfind(wish_str, " chi") then
		-- After other chi skills
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to enhance your Chi capacity?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CHI)
					end
	elseif strfind(wish_str, " technol") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to gain knowledge of the use of Technological devices?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_TECHNOLOGY)
					end
	elseif strfind(wish_str, " construction") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become more skillful at the art of constructing technological devices?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_CONSTRUCTION)
					end
	elseif strfind(wish_str, " disassemb") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to become more skillful at the art of disassembling technological devices?"
		wish_wishfct = 	function()
						dball.wish_bigstat_helper(SKILL_DISASSEMBLY)
					end
	elseif strfind(wish_str, " augment") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well."
		wish_confirm = "You wish to generally augment your physical and mental abilities?"
		wish_wishfct = 	function()
						skill(SKILL_STRENGTH).value = skill(SKILL_STRENGTH).value + rng(1000, 3000)
						skill(SKILL_INTELLIGENCE).value = skill(SKILL_INTELLIGENCE).value + rng(1000, 3000)
						skill(SKILL_WILLPOWER).value = skill(SKILL_WILLPOWER).value + 1000
						skill(SKILL_DEXTERITY).value = skill(SKILL_DEXTERITY).value + rng(1000, 3000)
						skill(SKILL_CONSTITUTION).value = skill(SKILL_CONSTITUTION).value + rng(1000, 3000)
						skill(SKILL_CHARISMA).value = skill(SKILL_CHARISMA).value + rng(1000, 3000)
						skill(SKILL_SPEED).value = skill(SKILL_SPEED).value + rng(1000, 3000)
					end
	elseif strfind(wish_str, " skill") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "That is a reasonable request. I shall grant it."
		wish_confirm = "You wish to be filled with the energies of insight, which will assist you to more quickly learn skills of your choosing at a later date?"
					-- Does this need to be different by skillmode?
		wish_wishfct = 	function()
						player.skill_points = player.skill_points + rng(1, 10) + 10
					end

	elseif strfind(wish_str, " experience") then
		if (player.exp < PY_MAX_EXP) then
			wish_granted = FLAG_WISH_CONFIRM
			wish_message = "Very well. I shall bestow upon you knowledge and wisdom directly from the celestial spheres."
			wish_confirm = "You wish to gain the benefit of life experience?"
			wish_wishfct = 	function()
							gain_exp(100000)
						end
		else
			wish_granted = FLAG_WISH_FAILURE
			wish_message = "Hmm. That is a reasonable request, but there is very little which you could learn in this way."
			wish_quality = 0
		end
----


	-- Abilities	(What are the implications of the 'Paired Weapon' ability vs the 'Paired' skill?
	elseif strfind(wish_str, " motorcycle") or strfind(wish_str, " riding") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to ride a motorcycle?"
		wish_wishfct = 	function()
						dball.learn(AB_MOTORCYLCLIST)
					end
	elseif strfind(wish_str, " skate") or strfind(wish_str, " skating") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "Hmm. It is difficult to find skates in my size, but I can teach you to skate by directly conveying the knowledge into your psyche, if you wish. Do you wish me to teach you to skate?"
		wish_wishfct = 	function()
						dball.learn(AB_SKATING)
					end
	elseif strfind(wish_str, " swim") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish me to teach you how to swim? Are you serious?"
		wish_wishfct = 	function()
						dball.learn(AB_SWIMMING)
					end
	elseif strfind(wish_str, " meditat") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of meditation, thus becoming able to restore your mental energies more quickly?"
		wish_wishfct = 	function()
						dball.learn(AB_MEDITATION)
					end
	elseif strfind(wish_str, " double attack") or strfind(wish_str, " with both hands") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of fighting with both hands interchangably?"
		wish_wishfct = 	function()
						dball.learn(AB_DOUBLE_ATTACK)
					end
	elseif strfind(wish_str, " paired weapon") or strfind(wish_str, " weapon in both hands") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of simultaneously wielding a melee weapon in each hand?"
		wish_wishfct = 	function()
						ability(AB_PAIRED_WEAPONS).hidden = false
					end
	elseif strfind(wish_str, " paired firearm") or strfind(wish_str, " paired gun") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of simultaneously wielding a firearm in each hand?"
		wish_wishfct = 	function()
						dball.learn(AB_PAIRED_FIREARMS)
					end
	elseif strfind(wish_str, " point blank") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of firing at point blank range with a firearm?"
		wish_wishfct = 	function()
						dball.learn(AB_POINT_BLANK)
					end
	elseif strfind(wish_str, " multi target") or strfind(wish_str, " multi-target") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how track multiplr targets, with a separate firearm in each hand?"		wish_wishfct = 	function()
						dball.learn(AB_MULTI_TARGET)
					end
	elseif strfind(wish_str, " acupuncture") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of acupuncture?"
		wish_wishfct = 	function()
						dball.learn(AB_ACUPUNCTURE)
					end
	elseif strfind(wish_str, " chi burst") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to direct your mental energies into a destructive, ranged burst?"
		wish_wishfct = 	function()
						dball.learn(AB_CHI_BURST)
					end
	elseif strfind(wish_str, " haste") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to speed your motions?"
		wish_wishfct = 	function()
						dball.learn(AB_HASTE)
					end
	elseif strfind(wish_str, " burst of speed") or strfind(wish_str, " blink") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to concentrate duractions of time into a single instant?"
		wish_wishfct = 	function()
						dball.learn(AB_BLINK)
					end
	elseif strfind(wish_str, " battle aura") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to project a battle aura?"
		wish_wishfct = 	function()
						dball.learn(AB_AURA)
					end
	elseif strfind(wish_str, " to fly") or strfind(wish_str, " flight") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to fly?"
		wish_wishfct = 	function()
						dball.learn(AB_FLIGHT)
					end
	elseif strfind(wish_str, " cure ") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to instantly cure your physical body of minor defects and pollutants?"
		wish_wishfct = 	function()
						dball.learn(AB_CURE)
					end
	elseif strfind(wish_str, " heal ") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of instant physical healing?"
		wish_wishfct = 	function()
						dball.learn(AB_HEAL)
					end
	elseif strfind(wish_str, " regenerate") or strfind(wish_str, " regeneration ability") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of phsysical regeneration?"
		wish_wishfct = 	function()
						dball.learn(AB_REGENERATION)
					end
	elseif strfind(wish_str, " absorbtion") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn how to absorb damage directly with your battle aura?"
		wish_wishfct = 	function()
						dball.learn(AB_ABSORBTION)
					end
	elseif strfind(wish_str, "telepath") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of telepathy?"
		wish_wishfct = 	function()
						dball.learn(AB_TELEPATHY)
					end
	elseif strfind(wish_str, " teleport") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of teleportation?"
		wish_wishfct = 	function()
						dball.learn(AB_TELEPORTATION)
					end
	elseif strfind(wish_str, " long range teleport") or strfind(wish_str, " planetary teleport") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of interplanetary teleportation?"
		wish_wishfct = 	function()
						dball.learn(AB_PLANETARY_TELEPORT)
					end
	elseif strfind(wish_str, " immovab") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of rendering your body immovable?"
		wish_wishfct = 	function()
						dball.learn(AB_IMMOVABILITY)
					end
	elseif strfind(wish_str, " throw") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of throwing your opponents?"
		wish_wishfct = 	function()
						dball.learn(AB_THROW)
					end
	elseif strfind(wish_str, " ultimate figh") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of fighting with bare hands, weapons and firarms interchangely?"
		wish_wishfct = 	function()
						dball.learn(AB_ULTIMATE)
					end
	elseif strfind(wish_str, " sushi eat") or strfind(wish_str, " speed eat") or strfind(wish_str, " fast eat") then
		wish_granted = FLAG_WISH_CONFIRM
		wish_message = "Very well. I shall teach you."
		wish_confirm = "You wish to learn the art of eating very quickly?"
		wish_wishfct = 	function()
						dball.learn(AB_SUSHI)
					end

----
	else
		wish_granted = FLAG_WISH_UNKNOWN
	end

	return wish_granted, wish_message, wish_confirm, wish_quality, wish_wishfct
end

function dball.wish_littlestat_helper(which_skill)
	local amt = rng(4, 6)
	skill(which_skill).value = skill(which_skill).value + (amt * 1000)
	skillcaps[which_skill] = skillcaps[which_skill] + amt
end

function dball.wish_bigstat_helper(which_skill)
	local amt = rng(9, 12)
	skill(which_skill).value = skill(which_skill).value + (amt * 1000)
	skillcaps[which_skill] = skillcaps[which_skill] + amt
end

-- Call the default wishing code for item requests
function dball.wish_for_item(wish_str)

	--Trim it down
	local wish_str_cleaned = strsub(wish_str, 8, strlen(wish_str))
	if starts_with(wish_str_cleaned, "to have an") then
		wish_str_cleaned = strsub(wish_str_cleaned, 11, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "to have a") then
		wish_str_cleaned = strsub(wish_str_cleaned, 10, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "to have") then
		wish_str_cleaned = strsub(wish_str_cleaned, 8, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "i had an ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 10, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "i had a ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 9, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "i had ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 7, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "for an ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 8, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "for a ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 7, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "for ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 5, strlen(wish_str_cleaned))
	end
	if starts_with(wish_str_cleaned, "the ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 5, strlen(wish_str_cleaned))
	end
--	if starts_with(wish_str_cleaned, "set of ") then
--		wish_str_cleaned = strsub(wish_str_cleaned, 8, strlen(wish_str_cleaned))
--	end
	if starts_with(wish_str_cleaned, "suit of ") then
		wish_str_cleaned = strsub(wish_str_cleaned, 9, strlen(wish_str_cleaned))
	end

	-- General cleanup
	if ends_with(wish_str_cleaned, ".") or ends_with(wish_str_cleaned, "!") then
		wish_str_cleaned = strsub(wish_str_cleaned, 1, strlen(wish_str_cleaned) - 1)
	end
	if ends_with(wish_str_cleaned, " please") then
		wish_str_cleaned = strsub(wish_str_cleaned, 1, strlen(wish_str_cleaned) - 7)
	end
	if ends_with(wish_str_cleaned, ",") then
		wish_str_cleaned = strsub(wish_str_cleaned, 1, strlen(wish_str_cleaned) - 1)
	end

	wish_str_cleaned = clean_whitespace(wish_str_cleaned)

	local ret_val
	local wish_types = {wish.for_corpse, dball.wish_artifact, wish.for_item}

	for j = 1, getn(wish_types) do
		local func = wish_types[j]

		ret_val = func(wish_str_cleaned)

		if ret_val == wish.GRANTED then
			return true
		end
		if ret_val == wish.DENIED then
			break
		end
	end

	if ret_val == wish.GRANTED then
		return true
	else
		return false
	end
end

function dball.wish_artifact(wish_str)
	local art_str = nil
	local art_idx = nil

	if starts_with(wish_str, "the ") == true then
		wish_str = strsub(wish_str, 5, strlen(wish_str))
	end

	local quoted_str = "'" .. wish_str .. "'"

	for i = 2, max_a_idx do
		local item = a_info[i]
		local name = item.name

		name = gsub(name, "& ", "")
		name = gsub(name, "~", "")

		-- If user wished for "FOO", and the name ends with
		-- "'FOO'", that's probably what the user wants.
		if (wish_str == name) or ends_with(name, quoted_str) then
			art_str = name
			art_idx = i - 1
			break
		end

		-- Was the user crazy enough to ask for a *plural* of
		-- an artifact?
		if wish.test_multiple_item(wish_str, item.name) == true then
			message(wish.ONE_ITEM_MSG)
			return wish.DENIED
		end
	end

	if not art_idx then
		return wish.UNGRANTED
	end

	local obj = create_artifact(art_idx)

	set_known(obj)
	set_aware(obj)

	obj.found = OBJ_FOUND_WISH

	-- drop_near(obj, -1, player.py, player.px)
	dball.reward(obj)

	return wish.GRANTED
end

function dball.wish_for_travel(wish_str)
	local already_there
	if strfind(wish_str, "earth") or strfind(wish_str, " home") then
		already_there = dball.planetary_teleport_helper("Earth")
	elseif strfind(wish_str, "namek") then
		already_there = dball.planetary_teleport_helper("Namek")
	elseif strfind(wish_str, "kaio") then
		already_there = dball.planetary_teleport_helper("Kaio")
	elseif strfind(wish_str, "plant") then
		already_there = dball.planetary_teleport_helper("Plant")
	elseif strfind(wish_str, "babidi") then
		already_there = dball.planetary_teleport_helper("Babidi")
	elseif strfind(wish_str, "79") then
		already_there = dball.planetary_teleport_helper("79")
	end

	-- Allow travel to dungeons?
	-- Allow travel to specific levels?

	return already_there
end
