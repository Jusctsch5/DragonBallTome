-- Technomancy system
-- Built by LordBucket for Dragonball T for the T-Engine

-- Note:
-- I've worked on this subsystem across the spectrum of my learning
-- how to use LUA. Consequently, some of the methods in here are
-- possibly somewhat obscure. The tech recipes are stored in a
-- ONE DIMENSIONAL array. See technomancy.init() to see what's
-- going on.

-- Description:
-- For all it's trappings, this is basically a recreation of the T2
-- alchemy system, with a few quirks:
-- 1) Multiple source/essence types can be associated with each item.
-- 2) Anything can be a source, whether or not it's even
--    a technomancy item. 
-- 3) Recipes are semi-randomized based on flags
-- 4) 'Magic' pluses are entirely determined by skill
-- 5) 'Ego' types are completely ignored

-- Skills
-- This system assumes that three skills exist:
-- Technology
-- Construction
-- Disassembly
-- However, it would take very little effort to modify it
-- to not need them. Just look for the related references
-- in technology.dismantle() and technology.build() and
-- replace them with whatever you'd like.

-- Item Ingredient Definition flags
-- Each techno-item can be made by up to four different ingredients.
-- Technomancy expects fixed ingredients to be in the form of TVAL
-- from which it will randomly select a specific SVAL.
-- NOTE: Total number of flags is flexible. I've used four for DBT,
-- but it could very easily be made any number, with only minimal
-- changes. However, there is NO checking anywhere to ensure that
-- all items are connected in the same tree. They may not be. The more
-- and greater variety of INGRED flags that you ACTUALLY USE in your
-- item definitions, the smaller the likelihood of having disconnected
-- trees. Disconnected ingredient trees are not neccesarily a bad thing.
-- In fact, you might specifically want them, but depending on your game
-- environment, it might be extremely bad for the player. Depending on
-- how you set up your data, it is extremely possible to have isolated
-- item types which require ingredients that are not made available by
-- any other item in the tree. Again, maybe good, maybe bad.
-- flags =
--	{
--		FLAG_INGRED1_WHAT = function() return lookup_kind(TV_BULK_MATERIAL, SV_STEEL) end
--		FLAG_INGRED1_QTY = 2
--		FLAG_INGRED2_WHAT = TV_CHEMISTRY
--		FLAG_INGRED2_QTY = function() return rng(1,4) end
--	}
--
-- An item with these flags will require
-- 2 sheets of steel, and a random 1-4 of a random chemistry item
-- (There is currently no checking for duplicate svals)
--
-- All items subject to the technomancy system may be defined, with their POSSIBLE ingredients
-- specified in their definitions. Technomancy will go through and assign ACTUAL ingredients
-- with each new game. 

-- Item flag declarations
new_flag("INGRED1_WHAT")
new_flag("INGRED2_WHAT")
new_flag("INGRED3_WHAT")
new_flag("INGRED4_WHAT")
new_flag("INGRED1_QTY")
new_flag("INGRED2_QTY")
new_flag("INGRED3_QTY")
new_flag("INGRED4_QTY")

-- Newly created items with these flags will receive combat bonuses
-- A better craftsman will build better equipment
new_flag("TECHNO_GAIN_TH")
new_flag("TECHNO_GAIN_TD")
new_flag("TECHNO_GAIN_AC")

-- For blueprints that teach how to build things
new_flag("TECHNO_PLANS")	-- k_idx that this blueprint teaches how to build
new_flag("TECHNO_AVAILABLE")	-- Default value

-- To describe items scavenged from disassembly
new_flag("OBJ_FOUND_DISASSEMBLED")

-- For items that may explode if construction fails
new_flag("TECHNO_EXPLODE")

-- 'Technomancy' items for use by 'Technomancers'
-- For example, nailguns use this flag to ignore the marksmanship requiment to
-- equip nailguns.
new_flag("TECHNOMANCE")

declare_globals {
	"technomancy",		-- The various functions related to Technomancy
	"tech_recipes",		-- Array that stores actual ingredients for everything you can build
	"tech_known",		-- Boolean array for which recipes are known to the player
	"tech_ego",			-- Boolean array for which ego types are known to the player
}

technomancy = {}
tech_recipes = {}
tech_known = {}
tech_ego = {}

add_loadsave("tech_recipes", {})
add_loadsave("tech_known", {})
add_loadsave("tech_ego", {})

-- This is number of general categories used by technomancy. Disciplines
-- correspond roughly to spell 'schools' but are used largely for
-- convenience of categorization. You may set up as much overlap in
-- actual construction ingredients as you want between disciplines,
-- these simply determine which end products will be grouped together
-- for the player. In the case of Dragonball T, the disciplines are
-- accessed through tool usage. If the player attempts to 'u'se a
-- mechanical toolkit, he'll be given a list of items that require a
-- mechanical tollkit to build, and not, for example, things that require
-- a chemistry kit. You may or may not want to use disciplines. If you
-- don't, then simply ignore this flag. It is not actually used by
-- Technomancy, it's just being made available by technomancy for any
-- module that does.
-- NOTE: Disciplines may be assigned in any way you like. I personally
-- am using 'magic numbers' in Dragonball T because I am comfortable
-- with them. Honestly, I don't like the 'flag' way of thinking about
-- things. Really, both methods are the same thing, a flag is just a
-- pointer to a 'magic number' the difference is in who keeps track of
-- the number. Me, or the compiler. I like to keep track of it myself.
-- Call it aesthetics. Also, it's much easier to do a loop for a range
-- of numbers than it is for a range of flags. If you prefer to work with
-- flags, do so. The subsystem shouldn't care, either way.
new_flag("DISCIPLINE")

-- Initialize a new recipe set with every new game
hook(hook.GAME_START, function(new)
	if new == true then
		technomancy.init()
	end
end)


-- To be run once at startup
-- Assigns ACTUAL ingredients to each item
function technomancy.init()

	local ti_position = 0
	local i

	for i = 1, max_k_idx - 1 do
		local item = k_info[i+1]

		if item.name and item.flags[FLAG_DISCIPLINE] then

			-- We start not knowing any recipes
			tech_known[i] = false

			ti_position = (i * 9) - 8

			tech_recipes[ti_position] = item.flags[FLAG_DISCIPLINE]

			if item.flags[FLAG_INGRED1_WHAT] then
				tech_recipes[ti_position+1] = technomancy.pick_ingred(item.flags[FLAG_INGRED1_WHAT])
				tech_recipes[ti_position+2] = item.flags[FLAG_INGRED1_QTY]
			else
				tech_recipes[ti_position+1] = 0
				tech_recipes[ti_position+2] = 0
				error("Warning: Item with k_idx: " .. i .. " shows as technomancable, but no valid ingredient!")
			end
			if item.flags[FLAG_INGRED2_WHAT] then
				tech_recipes[ti_position+3] = technomancy.pick_ingred(item.flags[FLAG_INGRED2_WHAT])
				tech_recipes[ti_position+4] = item.flags[FLAG_INGRED2_QTY]
			else
				tech_recipes[ti_position+3] = 0
				tech_recipes[ti_position+4] = 0
			end
			if item.flags[FLAG_INGRED3_WHAT] then
				tech_recipes[ti_position+5] = technomancy.pick_ingred(item.flags[FLAG_INGRED3_WHAT])
				tech_recipes[ti_position+6] = item.flags[FLAG_INGRED3_QTY]
			else
				tech_recipes[ti_position+5] = 0
				tech_recipes[ti_position+6] = 0
			end
			if item.flags[FLAG_INGRED4_WHAT] then
				tech_recipes[ti_position+7] = technomancy.pick_ingred(item.flags[FLAG_INGRED4_WHAT])
				tech_recipes[ti_position+8] = item.flags[FLAG_INGRED4_QTY]
			else
				tech_recipes[ti_position+7] = 0
				tech_recipes[ti_position+8] = 0
			end
		end
	end

end

-- This is a helper function that takes a TVAL
-- and returns the k_idx of a random SVAL of
-- that type.
-- Would somebody please tell me a way to do this
-- that isn't dumb?
function technomancy.pick_ingred(which)
	if which < 0 then
--...just doesn't work...
--		-- is an exact kind, stored as a negative number
--		return -which
		return 1
	else
		-- is a TVAL
		local r = rng(1, 6)
		if which == TV_CIRCUITRY then
			if r == 1 then
				return lookup_kind(TV_CIRCUITRY, SV_RESISTER)
			elseif r == 2 then
				return lookup_kind(TV_CIRCUITRY, SV_CAPACITOR)
			elseif r == 3 then
				return lookup_kind(TV_CIRCUITRY, SV_CIRCUIT_BOARD)
			elseif r == 4 then
				return lookup_kind(TV_CIRCUITRY, SV_SPOOL_OF_WIRE)
			elseif r == 5 then
				return lookup_kind(TV_CIRCUITRY, SV_SPOOL_OF_SOLDER)
			elseif r == 6 then
				return lookup_kind(TV_CIRCUITRY, SV_EPROM)
			else
			error("Invalid r in pick_ingred?")
			end
		elseif which == TV_CHEMISTRY then
			if r == 1 then
				return lookup_kind(TV_CHEMISTRY, SV_IRON)
			elseif r == 2 then
				return lookup_kind(TV_CHEMISTRY, SV_SULPHUR)
			elseif r == 3 then
				return lookup_kind(TV_CHEMISTRY, SV_SODIUM_PERMANGANATE)
			elseif r == 4 then
				return lookup_kind(TV_CHEMISTRY, SV_HYDROGEN_TETRACHLORIDE)
			elseif r == 5 then
				return lookup_kind(TV_CHEMISTRY, SV_ALUMINUM_DIOXIDE)
			elseif r == 6 then
				return lookup_kind(TV_CHEMISTRY, SV_ASSORTED_HYDROCARBONS)
			else
			error("Invalid r in pick_ingred?")
			end
		elseif which == TV_BULK_MATERIAL then
			if r == 1 then
				return lookup_kind(TV_BULK_MATERIAL, SV_STEEL)
			elseif r == 2 then
				return lookup_kind(TV_BULK_MATERIAL, SV_ALUMINUM)
			elseif r == 3 then
				return lookup_kind(TV_BULK_MATERIAL, SV_TITANIUM)
			elseif r == 4 then
				return lookup_kind(TV_BULK_MATERIAL, SV_PLASTIFORM)
			elseif r == 5 then
				return lookup_kind(TV_BULK_MATERIAL, SV_FIBERGLASS)
			elseif r == 6 then
				return lookup_kind(TV_BULK_MATERIAL, SV_TUBING)
			else
				error("Invalid r in pick_ingred?")
			end
		elseif which == TV_HIGH_TECH_COMPONENTS then
			if r == 1 then
				return lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_PARTICLE_ACCELERATOR)
			elseif r == 2 then
				return lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_PLASMA_DIODE)
			elseif r == 3 then
				return lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_MAGLEV_TUBE)
			elseif r == 4 then
				return lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_CONTAINER_OF_NANITES)
			elseif r == 5 then
				return lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_TACHYON_STREAMER)
			elseif r == 6 then
				return lookup_kind(TV_HIGH_TECH_COMPONENTS, SV_POSITRONIC_RELAY)
			else
				error("Invalid r in pick_ingred?")
			end
		else
			error("Unknown TVAL in pick_ingred")
		end
	end
end

-- Dismantle an item to attempt to learn how to build it
-- as well as how to scavenge for parts
-- NOTE: In order to be friendly for other module writers
-- I'm leaving this fairly stripped, and letting all the
-- object getting and delivering to be handled elsewhere.
-- In Dragonball T, this subsystem is associated with
-- device use, but I figure most other module writers
-- will probably use this system via an mkey, so I'm
-- trying to leave things generally friendly to that.

function technomancy.dismantle(obj, kidx)
	-- local kidx = obj.k_idx -- <--WHY DOES THIS NOT WORK?!?!?!?!??!?!?!
	local ti_qty = 0
	local message_check = 0
	local amt = 1

	-- Chance to recover each possible part is:
	-- base 20% + diassembly skill, minus the 'use' difficulty of the item
	local adj_diff = 20 + get_skill(SKILL_DISASSEMBLY)

	-- Note: 'adj_diff' is actually 'percent chance of success' should be renamed
	--if obj.flags[FLAG_DIFFICULTY] then
	--	adj_diff = adj_diff - obj.flags[FLAG_DIFFICULTY]
	--end
	--local result_message = ""


	local weirdness = get_object(obj)
	-- Option for more than one
	if weirdness.number > 1 then
		-- Get a quantity
		amt = get_quantity(nil, weirdness.number)

		-- Allow user abort
		if amt <= 0 then return end
	end


	-- (Adding ego's to technomancy retroactively...
	-- things might wind up in odd places.)
	-- Check to see if we learned how to make an ego

	-- Gah! 'obj' isn't an object!
	local obj_for_ego = get_object(obj)

	local ego_message = "None"
	if obj_for_ego.ego_id[1] and obj_for_ego.ego_id[1] ~= 0 then
		if tech_ego[obj_for_ego.ego_id[1]] ~= true and (adj_diff >= rng(100)) then
			tech_ego[obj_for_ego.ego_id[1]] = true
			-- Would be nicer to specify learned type by name
			ego_message = "You think you could enhance things in a similar way"
		end
	end
	if obj_for_ego.ego_id[2] and obj_for_ego.ego_id[2] ~= 0 then
		if tech_ego[obj_for_ego.ego_id[2]] ~= true and (adj_diff >= rng(100)) then
			tech_ego[obj_for_ego.ego_id[2]] = true
			-- Would be nicer to specify learned type by name
			ego_message = "You think you could enhance things in a similar way"
		end
	end


	-- Remove the disassembled item, we don't need it anymore
	item_increase(obj, -amt)
	item_describe(obj)
	item_optimize(obj)

	-- Now, what parts do we give the character?
	local ti_position = ((kidx * 9) - 8)
	for i = 0, 3 do
		ti_qty = 0

		-- How many parts do we salvage?
		if tech_recipes[ti_position + ((i * 2) + 1)] ~= 0 then
			-- Iterate for each obj being dismantled
			for k = 1, amt do
				for j = 1, tech_recipes[ti_position + ((i * 2) + 2)] do
					if adj_diff >= rng(100) then
						ti_qty = ti_qty + 1
						message_check = message_check + 1
					end
				end
			end
			if ti_qty > 0 then
				local obj = technomancy.create(tech_recipes[ti_position + ((i * 2) + 1)])
				obj.number = ti_qty
				technomancy.give_item(obj)
			end
		end
	end

	-- Did we salvage anything?
	if message_check > 0 then
		message("You recover " .. message_check .. " parts. ")
	else
		message("You fail to salvage any usable parts.")
	end

	-- Do we learn how to build them?
	if tech_known[kidx] == false then
		-- message("Difficulty was: " .. adj_diff)
		for i = 1, amt do
			if adj_diff >= rng(100) then
				tech_known[kidx] = true
			end
		end
		if tech_known[kidx] == true then
			message("You think you could build a new one.")
		end
	end

	-- Followup hack for ego learning
	if ego_message ~= "None" then
		message(color.YELLOW, ego_message)
	end
end

-- Is this being used anymore?
function technomancy.view_recipe(kidx)
	if not tech_recipes[kidx] then
		message("Error! No recipe exists for requested item kind in technomancy!")
		return
	end
	message("Discipline:" .. tech_recipes[kidx][1] .. " Item1:" .. tech_recipes[kidx][2] .. "," .. tech_recipes[kidx][3])
end

function technomancy.file()
	local fff=fs.open("/technomancy.log", "a+")
	local i, ti_position
	local s = " "
	for i = 1, max_k_idx - 1 do
		ti_position = (i * 9) - 8
		if tech_recipes[ti_position] then
			s = "k_idx: " .. i .. " Discipline:" .. tech_recipes[ti_position] .. " Item1:" .. tech_recipes[ti_position+1] .. "," .. tech_recipes[ti_position+2].. " Item2:" .. tech_recipes[ti_position+3] .. "," .. tech_recipes[ti_position+4].. " Item3:" .. tech_recipes[ti_position+5] .. "," .. tech_recipes[ti_position+6].. " Item4:" .. tech_recipes[ti_position+7] .. "," .. tech_recipes[ti_position+8]
			-- s = "k_idx: " .. i .. " Discipline:" .. tech_recipes[ti_position]
			fs.write(fff, "Test" .. "\n")
		end
	end
	fs.close(fff)
end

-- General function to put something in inventory
-- or drop it nearby if inventory is full
function technomancy.give_item(obj)
	local available_room = true
	for i = 1, player.inventory_limits(INVEN_INVEN) - 1 do
		if not player.inventory[INVEN_INVEN][i] or player.inventory[INVEN_INVEN][i].k_idx == 0 then available_room = false break end
	end
	if available_room then
		drop_near(obj, -1, player.py, player.px)
	else
		inven_carry(obj, false)
	end
end

-- General function to create an object by k_idx
-- instead of TV/SV, and while we're here, *ID*
-- it as well
function technomancy.create(kidx)
 	local obj = new_object()
	object_prep(obj, kidx)
	make_item_fully_identified(obj)
	-- obj.found = OBJ_FOUND_SELFMADE
	return (obj)
end


-- Been a while since I've touched Technomancy...
-- Nov 28

--[[
function technomancy.ttt(discipline)
	term.save()
	term.clear()

	local d_count = 1
	local d_horiz = 1
	local d_vertmod = 0

	for i = 1, max_k_idx - 1 do
		local item = k_info[i+1]

		if has_flag(item, FLAG_DISCIPLINE) and item.flags[FLAG_DISCIPLINE] == discipline then
			if d_count > 13 then
				d_horiz = 35
				d_vertmod = -13
			end
			-- term.text_out(color.WHITE, item.name .. "\n")
			term.blank_print(color.WHITE, strchar(d_count + 96) .. ") " .. item.name, d_count + d_vertmod, d_horiz)

			d_count = d_count + 1
		end
	end
end
]]

function technomancy.gen_known_recipe_list(discipline)
	local recipe_list = {}
	local ti_position = 1

	for i = 1, max_k_idx - 1 do
		local item = k_info[i+1]

		if item.name and item.flags[FLAG_DISCIPLINE] then
			-- It's a technomancy item
			if item.flags[FLAG_DISCIPLINE] == discipline then
				if tech_known[i] == true or wizard then
					-- Yep. Add it to the array to be displayed.
					recipe_list[ti_position] = i
					ti_position = ti_position + 1
				end
			end
		end
	end

	return recipe_list

end

function technomancy.show_known_recipes(discipline)
	local recipe_list = technomancy.gen_known_recipe_list(discipline)
	local zoom_mode = 0
	local looking_at = 0

	if getn(recipe_list) < 1 then
		message("You don't know how to build anything with that.")
		return 0
	end

	while not nil do
		term.save()
		term.clear()

		-- Rebuild it every time
		local obj = new_object()

		if zoom_mode == 0 then
			term.blank_print("Press a letter for ingredients, or enter when done", 0, 0)
			local d_count = 1
			local d_horiz = 1
			local d_vertmod = 0

			for i = 1, getn(recipe_list) do
				local item = k_info[ recipe_list[i] + 1 ]
				-- local desc = object_desc(item, false, 0)

				if has_flag(item, FLAG_DISCIPLINE) and item.flags[FLAG_DISCIPLINE] == discipline then
					if d_count > 13 then
						d_horiz = 35
						d_vertmod = -13
					end
					term.blank_print(color.WHITE, strchar(d_count + 96) .. ") " .. item.name, d_count + d_vertmod, d_horiz)

					d_count = d_count + 1
				end
			end


		else
			local item = k_info[ recipe_list[looking_at] + 1 ]
			object_prep(obj, recipe_list[looking_at])
			obj.number = 1

			term.text_out("Press enter for previous menu\n")
			-- term.text_out("Building THIS will require:\n")
			 term.text_out("Building " .. object_desc(obj) .. " will require:\n")

			delete_object(obj)

			local ti_position = (recipe_list[looking_at] * 9) - 8

			if item.flags[FLAG_INGRED1_WHAT] then
				local ingred = new_object()
				object_prep(ingred, tech_recipes[ti_position+1])
				ingred.number = tech_recipes[ti_position+2]
				term.text_out( " * " .. ingred.number .. " " .. object_desc(ingred) .. "\n")
				delete_object(ingred)
			end
			if item.flags[FLAG_INGRED2_WHAT] then
				local ingred = new_object()
				object_prep(ingred, tech_recipes[ti_position+3])
				ingred.number = tech_recipes[ti_position+4]
				term.text_out( " * " .. ingred.number .. " " .. object_desc(ingred) .. "\n")
				delete_object(ingred)
			end
			if item.flags[FLAG_INGRED3_WHAT] then
				local ingred = new_object()
				object_prep(ingred, tech_recipes[ti_position+5])
				ingred.number = tech_recipes[ti_position+6]
				term.text_out( " * " .. ingred.number .. " " .. object_desc(ingred) .. "\n")
				delete_object(ingred)
			end
			if item.flags[FLAG_INGRED4_WHAT] then
				local ingred = new_object()
				object_prep(ingred, tech_recipes[ti_position+7])
				ingred.number = tech_recipes[ti_position+8]
				term.text_out( " * " .. ingred.number .. " " .. object_desc(ingred) .. "\n")
				delete_object(ingred)
			end

			term.text_out("\n")

		end

		local key = term.inkey()
		term.load()
 
		if zoom_mode == 1 then
			zoom_mode = 0
		elseif key > 96 and key <= getn(recipe_list) + 96 then
			looking_at = key - 96
			zoom_mode = 1
		elseif strchar(key) == "\r" or key == ESCAPE then
			if zoom_mode == 1 then
				looking_at = 0
				zoom_mode = 0
			else
				return
			end
		end
	end

	return getn(recipe_list)
end

-- Color recipe based on whether we have
-- ingredients to actualy build it
function technomancy.get_col(recipe)
	if technomancy.ingred_check(recipe) then
		return color.GREEN
	else
		return color.RED
	end
end

-- Do we have the ingredients to make this?
function technomancy.ingred_check(kidx)
	local recipe = ((kidx * 9) - 8)

	local item_of_kidx_in_inv
	local ti_pos

	for i = 0, 3 do
		ti_pos = recipe + (i * 2) + 1
		if tech_recipes[ti_pos] and tech_recipes[ti_pos] ~= 0 then
			item_of_kidx_in_inv = technomancy.find_item_kidx(tech_recipes[ti_pos])
			if item_of_kidx_in_inv then
				if player.inventory[INVEN_INVEN][item_of_kidx_in_inv].number < tech_recipes[ti_pos + 1] then
					return false
				end
			else
				return false
			end
		end
	end
	return true
end

function technomancy.interface_to_build(discipline)
	local recipe_list = technomancy.gen_known_recipe_list(discipline)

	if getn(recipe_list) < 1 then
		message("You don't know how to build anything with that.")
		return 0
	end

	while not nil do
		term.save()
		term.clear()

		term.blank_print("Attempt to assemble which?", 0, 0)
		local d_count = 1
		local d_horiz = 1
		local d_vertmod = 0

		for i = 1, getn(recipe_list) do
			local item = k_info[ recipe_list[i] + 1 ]

			if has_flag(item, FLAG_DISCIPLINE) and item.flags[FLAG_DISCIPLINE] == discipline then
				if d_count > 13 then
					d_horiz = 35
					d_vertmod = -13
				end
				term.blank_print(technomancy.get_col(recipe_list[i]), strchar(d_count + 96) .. ") " .. item.name, d_count + d_vertmod, d_horiz)

				d_count = d_count + 1
			end
		end
		local key = term.inkey()
		term.load()
 
		if key > 96 and key <= getn(recipe_list) + 96 then
			local recipe = recipe_list[key - 96]
			if technomancy.ingred_check(recipe) then
				-- build it!
				-- technomancy.build(recipe_list[key - 96])
				technomancy.build(recipe)
				energy_use = get_player_energy(SPEED_USE)
				return
			else
				-- Character lacks proper ingredients 
			end
		elseif strchar(key) == "\r" or key == ESCAPE then
			-- No energy use
			return
		end
	end

	return getn(recipe_list)
end

-- Actually build something, and
-- remove ingredients
function technomancy.build(recipe)
	local item_of_kidx_in_inv
	local ti_pos

	local weirdness_kidx_of_thing_to_create = recipe

	-- Hmm. Losing track of which is recipe and which is 'Technomancy Index Position'
	recipe = ((recipe * 9) - 8)

	-- We've already confirmed ingredients are available
	-- So, use them:
	for i = 0, 3 do
		ti_pos = recipe + (i * 2) + 1
		if tech_recipes[ti_pos] and tech_recipes[ti_pos] ~= 0 then
			item_of_kidx_in_inv = technomancy.find_item_kidx(tech_recipes[ti_pos])
			if item_of_kidx_in_inv then
				if player.inventory[INVEN_INVEN][item_of_kidx_in_inv].number < tech_recipes[ti_pos + 1] then
					error("Error! insufficient ingredients!")
					message("Error in Technomancy: Insufficient QTY of ingredient previously reported as ok. This is a known bug.")
					message("To avoid this, insure that you have sufficient ingredients when building items that have DUPLICATED ingredients.")
					return
				else
					-- We should have an 'option' to hide the describe line
					local lose_qty = -1 * tech_recipes[ti_pos + 1]
					item_increase(item_of_kidx_in_inv, lose_qty)
					item_describe(item_of_kidx_in_inv)
					item_optimize(item_of_kidx_in_inv)
				end
			else
				-- Note: Lack of duplicate checking in recipe creation makes this possible...
				error("Error! technomancy.build() could not find an ingredient!")
				message("Error in Technomancy: Insufficient QTY of ingredient previously reported as ok. This is a known bug.")
				message("To avoid this, insure that you have sufficient ingredients when building items that have DUPLICATED ingredients.")
				return
			end
		end
	end
	-- Ok...all ingredients have been removed.
	-- Now, do we succeed in building something?

	local obj = technomancy.create(weirdness_kidx_of_thing_to_create)
	obj.found = OBJ_FOUND_SELFMADE

	-- No free fuel
	if has_flag(obj, FLAG_FUEL_CAPACITY) then
		obj.flags[FLAG_FUEL_CAPACITY] = 0
	end

	-- Give combat bonuses based on skill where appropriate
	if has_flag(obj, FLAG_TECHNO_GAIN_TH) then
		obj.to_h = obj.to_h + (get_skill(SKILL_CONSTRUCTION) / 5)
	end
	if has_flag(obj, FLAG_TECHNO_GAIN_TD) then
		obj.to_d = obj.to_d + (get_skill(SKILL_CONSTRUCTION) / 5)
	end
	if has_flag(obj, FLAG_TECHNO_GAIN_AC) then
		obj.to_a = obj.to_a + (get_skill(SKILL_CONSTRUCTION) / 5)
	end

	-- Firearm/ammo issues?

	local success_chance = get_skill(SKILL_CONSTRUCTION) + 20
	if obj.flags[FLAG_DIFFICULTY] then
		success_chance = success_chance - obj.flags[FLAG_DIFFICULTY]
	end

	if rng(1, 100) <= success_chance then
		-- Yay!
		technomancy.give_item(obj)
		-- item_describe(obj) -- Oops...need to convert to inven slot number to do this
		message("Success!")
	else
		-- Boo!
		if has_flag(obj, FLAG_TECHNO_EXPLODE) and rng(1, 100) > success_chance then
			local dams = obj.flags[FLAG_TECHNO_EXPLODE]
			local typ = flag_max_key(dams)
			local explosive_dam = rng(flag_get(dams, typ), flag_get2(dams, typ))
			message("You fail in the attempt, and it explodes in your face!")
			-- Implement damage typing! Currently type is ignored, and damage is irresistable.
			take_hit(explosive_dam, "technical incompetance")
		else
			delete_object(obj)
			message("You fail in the attempt.")
		end
	end

end

-- Stolen from ToME alchemy
-- Also used, but not referenced by drbriefs.deliver_item()
function technomancy.find_item_kidx(kidx)
	for i=1,player.inventory[INVEN_INVEN][0] do
		local obj = player.inventory[INVEN_INVEN][i]
		if obj and obj.k_idx == kidx then
			return i
		end
	end
	return nil
end

-- Assign TECHNO_PLANS flag value to blueprints
-- Note: this could generate a perma-loop of death
-- if no objects match the requested difficulty range
function technomancy.make_bp(difficulty)
	local min_rng, max_rng
	if difficulty == -1 then
		-- Randomly generated easy blueprints
		min_rng = 1
		max_rng = 10
	elseif difficulty == -2 then
		-- Randomly generated medium blueprints
		min_rng = 10
		max_rng = 19
	elseif difficulty == -3 then
		-- Randomly generated complicated blueprints
		min_rng = 20
		max_rng = 29
	else
		-- ???
		min_rng = 30
		max_rng = 100
	end

	while not nil do
		local which_kidx = rng(1, max_k_idx - 1)
		local obj = k_info[which_kidx]
		if has_flag(obj, FLAG_DISCIPLINE) then
			if obj.level >= (min_rng) and obj.level <= (max_rng) then
				return which_kidx
			end
		end
	end
end