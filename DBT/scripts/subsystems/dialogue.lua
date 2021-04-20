-- Dialogue Subsystem
-- Created by Bucket Man for the Dragonball T module for the T-Engine
-- lordbucket@hotmail.com

-- This subsystem is primarily intended for heavy duty, intensive,
-- long and complicated dialogue trees

-- Note: The sample included in this file is not complete. For examples
-- of this system in use, please see scripts/dialogue.lua

-- Note: THIS version of the subsystem includes changes from Bard's Tale
-- and is not exactly as originally, nor as ultimately...intended. Call
-- it a work in process.

-- Strengths of this system:
--  Very flexible. It can do anything. For example:
--   Colors and display easy to tweak
--   Multiple answers may be made to correspond to single results
--   Inidividual NPC speech portions may be selected randomly/specifically from a list
--   Multiple speakers may participate in a conversation
--   NPC's may be given the 'last word' in a conversation
--   Non-dialogue narration can easily be added
--   Possible to have multiple pages of display between responses
--   Multiple answers may be made to lead to the same response
--   Multiple consective threads are possible withina single dialogue
--  Each dialogue is its own function, so you can easily call it from
--   anywhere you want and feed/get from it any data you want
--  Even heavily nested Dialogue functions are generally easy to read
--  Easy to comment out dialogue portions for bugtesting
--  'Answers' may be tracked and used elsewhere
--
-- Weaknesses of this system:
--  Not space efficient. Since the module writer handles all dialogue
--   display and response logic, dialogue functions will typically be
--   twice the size of dialogs using the original ToME dialog system.
--  Not as 'simple.' More understanding is probably required from a
--   module writer to use this, though personally I find it far more
--   visually intuitive. It's much easier to quickly see what's going on.
--  Incorrect term.load() or term.save() placement will break the display

-- NOTE: By default players can NOT press escape to exit a dialogue!
-- This is EXTREMELY by design. If you want them to be able to, you will
-- have to create an answer condition for it

-- Used to store the various dialogue states
declare_globals {
	"dialogue_data",
}

-- dialogue_data is for keeping track of random dialogue state information
dialogue_data = {}
add_loadsave("dialogue_data", {})

-- Gender pronouns for the various dialogues assigned in calc.lua
constant("gendernouns", {})

constant("dialogue", {})		-- The dialogue functions

dialogue.tally = 0	-- Number of dialogue responses
dialogue.r = {}		-- Array containing the reponses

-- For bugtesting. Typographical errors in the scripts will often
-- cause the entire file containing a dialogue to not load, but
-- just because your dialogue doesn't work doesn't mean that
-- this has happened.
-- If you want to check for this, executing: dialogue.test()
-- from wizard mode will generate a reponse if the file itself
-- is loading properly.
function dialogue.test()
	message("Hello! Dialogue exists!")
end

-- Basic initialization between dialogue portions.
-- This will need to execute between EVERY set of
-- dialogue/response exchanges
function dialogue.prep()
	dialogue.tally = 0
	dialogue.r = {}
end

-- Registers and displays a single response from the player
-- and associates what the script expects with what the player sees
-- Will need to execute for every possible response, every time
function dialogue.helper(txt, expect)
	dialogue.tally = dialogue.tally + 1
	dialogue.r[dialogue.tally] = expect
	term.text_out(color.LIGHT_GREEN, strchar(dialogue.tally + 96))
	local out_text = ") " .. txt .. "  \n"
	term.text_out(out_text)
end

-- Gets a response from the player, from the list of
-- responses that have been registered above
function dialogue.answer()
	if dialogue.tally == 0 then
		message("Error! No dialogue answers! Proceeding would generate a perma-loop! Breaking out...")
		return
	end
	while not nil do
		local key = term.inkey()
		key = strchar(key)
		for i = 1, dialogue.tally do
			if key == strchar(i + 96) then -- dialogue.r[i] then
				local foo = dialogue.r[i]
				dialogue.prep()
				return foo
			end
		end
	end
end
-- Stores handle the screen differently, and regularly term.(save/load/clear)'s
-- don't work as they do elsewhere. This function wipes an arbitrary number of lines
-- from the display, and places the cursor back up top.
function dialogue.store_hack(lines_to_wipe)
	for i = 0, (lines_to_wipe or 24) do
		term.blank_print("                                                                                ",i,0)
	end
	--reposition the cursor
	term.blank_print("",1,0)
end

-- To end a dialogue with no possible response
function dialogue.conclude()
	term.text_out(color.ORANGE, "(Press space) ")
	local key
	while key ~= 32 do
		key = term.inkey()
	end
	return
end

function dialogue.quickie(say)
	term.save()
	term.gotoxy(0, 0)
	term.text_out(say .. "\n\n")
	dialogue.conclude()
	term.load()
end

-- To allows dialogue to use the correct gender pronoun
-- Updates whenever the character state is updated
-- in case the characters gender changes. Feel free to
-- add to this and use as desired. Should be friendly to
-- more-than-two genders as well.
hook(hook.CALC_BONUS, function ()
	if player.get_sex() == "Female" then
		gendernouns.heshe = "she"
		gendernouns.himher = "her"
		gendernouns.hisher = "her"
		gendernouns.guygirl = "girl"
		gendernouns.boygirl = "girl"
		gendernouns.manwoman = "man"
		gendernouns.ladlass = "lass"
		gendernouns.demeaning = "little girl"
		if dball_data.married ~= 0 then
			gendernouns.french = "mademoiselle"
		else
			gendernouns.french = "madame"
		end
	else
		gendernouns.heshe = "he"
		gendernouns.himher = "him"
		gendernouns.hisher = "his"
		gendernouns.guygirl = "guy"
		gendernouns.boygirl = "boy"
		gendernouns.manwoman = "woman"
		gendernouns.ladlass = "lad"
		gendernouns.demeaning = "kid"
		gendernouns.french = "monsieur"
	end

end)

-- Sample dialogue
-- To see it in action, uncomment it, enter wizard mode
-- and execute: dialogue.SAMPLE()

--[[
function dialogue.SAMPLE()
	-- If we've already spoken with Mr Sample, just say hi
	if dialogue_data.sample_firstcontact == 1 then -- First contact
		term.text_out(color.LIGHT_BLUE, "Mr Sample: ")
		term.text_out("Hello! Nice to see you again!")
		return
	end
	
	-- Note that we've spoken with Mr Sample
	dialogue_data.sample_firstcontact = 1

		-- Save the terminal state. Must do this religiously, will break the display if you're careless!
		term.save()

		-- Clear the various dialogue arrays. Don't HAVE to do this, but the dialogue answer keys that
		-- the player sees will continue to increment until you do, so you'll probably want to
		dialogue.prep()

		-- Display the actual dialogue
		term.text_out(color.LIGHT_BLUE, "Mr Sample: ")
		term.text_out("Hello! I'm Mr Sample! I'm here to give you a quick run-through os some of the neat stuff Lord Bucket's dialogue subsystem can do!\n\n")
		term.text_out(color.LIGHT_RED, "Miss Sample-ette: ")
		term.text_out("And I'm Miss Sample, his sidekick. You'll notice multiple people can converse in a single dialogue, and that my name shows up in a different color. Isnt that exciting!\n\n")

		-- Give the player some possible answers to choose from
		dialogue.helper("Wow! This is really great!", 1)
		dialogue.helper("Umm...somebody had way too much spare time on their hands.", 2)

		-- Get an answer from the available options
		local ans = dialogue.answer()

		-- Respond based on which answer the player gave
		if ans == 1 then
			-- Temporarily keep track of how enthusiastic the player is
			local player_is_thrilled = 1

			-- Clear the previous dialogue, then save the screen again, and prep for the next response
			-- Yes, it is inefficient to do this every time, and could very easily be combined into
			-- a general 'prep' function, but in reality you won't want to do all three of these things
			-- every time
			term.load()
			term.save()
			dialogue.prep()
			term.text_out(color.LIGHT_BLUE, "Mr Sample: ")
			term.text_out("")
		elseif ans == 2 then
			local player_is_thrilled = 0
		else
			message("Error checking shouldn't be necessary, but you can if you want.")
		end






end
]]