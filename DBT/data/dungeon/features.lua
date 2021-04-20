-- Dragonball T: Terrain FEATures

new_feature_type
{
	define_as = "FEAT_SOFT_WALL"
	name = "granite wall"
	display = strchar(127) color = color.WHITE
	flags =
		{
		SUBST_ROCK=true
		WALL=1 NO_WALK=1 NO_VISION=1 SUPPORT_LIGHT=1
		DONT_NOTICE_RUNNING=1
		CAN_PASS=getter.flags(define_features.pass_granite_wall)
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			if has_ability(AB_TAMESHIWARI) and game_options.tameshiwari_mode == true then
				if skill(SKILL_HAND).value >= 40 then
					cave_set_feat(y, x, FEAT_RUBBLE)
					message(color.YELLOW, "You smash through the stone as if it were cardboard")
				else
					message(color.YELLOW, "You strike the wall, but it does not crumble")
					energy_use = 480 -- ?? implement??
				end
			end
		end
	}
}

new_feature_type
{
	define_as = "FEAT_PERMA_WALL"
	name = "permanent wall"
	display = strchar(127) color = color.WHITE
	flags =
	{
		WALL=1 NO_WALK=1 NO_VISION=1 SUPPORT_LIGHT=1
		DONT_NOTICE_RUNNING=1
		NO_TUNNEL_MSG="Sorry. No tunneling through map borders."
	}
}
new_feature_type
{
	define_as = "FEAT_BUILDING"
	name = "building"
	display = strchar(127) color = color.WHITE
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		else
			return false
		end
	end
	flags =
	{
		WALL=1 NO_WALK=1 SUPPORT_LIGHT=1 NO_VISION=true 
		DONT_NOTICE_RUNNING=1 REMEMBER=true
		NO_TUNNEL_MSG="Reinforced concrete is a bit tough to dig through."
	}
}
-- Next two are just color cosmetic for the Kame House
new_feature_type
{
	define_as = "FEAT_KAME_WALL"
	name = "permanent wall"
	display = strchar(127) color = color.PINK
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		else
			return false
		end
	end
	flags =
	{
		WALL=1 NO_WALK=1 NO_VISION=1 SUPPORT_LIGHT=1
		DONT_NOTICE_RUNNING=1
		NO_TUNNEL_MSG="It would be very impolite to dig holes in Rosshi's house."
	}
}
new_feature_type
{
	define_as = "FEAT_KAME_ROOF"
	name = "permanent wall"
	display = strchar(127) color = color.LIGHT_RED
	flags =
	{
		WALL=1 NO_WALK=1 NO_VISION=1 SUPPORT_LIGHT=1
		DONT_NOTICE_RUNNING=1
		NO_TUNNEL_MSG="It would be very impolite to dig holes in Rosshi's house."
	}
}

new_feature_type
{
	define_as = "FEAT_DBT_SECRETDOOR"
	name = "secret door"
	display = strchar(127) color = color.WHITE
	priority = 10
	flags =
	{
		WALL=true NO_WALK=true NO_VISION=true DOOR=true
		SECRET=FEAT_DOOR
		DONT_NOTICE_RUNNING=true
		CAN_PASS=getter.flags(define_features.door_pass)
	}
}
new_feature_type
{
	define_as = "FEAT_LEVER"
	name = "a lever"
	display = '//' color = color.LIGHT_RED
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true -- Hmm. Maybe we should allow players to destroy these?
	}
}
new_feature_type
{
	define_as = "FEAT_STEAM_VENT"
	name = "steam vent"
	display = '\\' color = color.LIGHT_RED
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
	}
}

new_feature_type
{
	define_as = "FEAT_GUARD_TOWER"
	name = "guard tower"
	display = strchar(127) color = color.LIGHT_DARK
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		end
	end
	flags =
	{
		NO_WALK=1 PERMANENT=1 SUPPORT_LIGHT=1
		DONT_NOTICE_RUNNING=1 NOTICE=true 
		NO_TUNNEL_MSG="The tower is too sturdy to dig through"
	}
}

new_feature_type
{
	define_as = "FEAT_KARIN_TOWER"
	name = "Karin Tower"
	display = '|' color = color.WHITE
	can_enter = function(mode)
		return true
	end
	flags =
	{
		WALL=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
		NO_TUNNEL_MSG="You can't even scratch it"
		-- LAVA=1 --??
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			if dball.player_flying() == true then

			elseif dir ~= 2 and dir ~= 8 then
				message("You must start from the base of the tower.")
				return true, false
			else
				message("It is an exhausting climb!")
				take_hit(rng(1,4), "exhaustion")
			end
		end
	}
	attacks =
	{
		[{dam.PURE, 1}] = { 1,3 }
	}
}
new_feature_type
{
	define_as = "FEAT_KARIN_TOWER_EXT"
	name = "Karin Tower"
	display = '|' color = color.WHITE
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
		MOVE_POST_DEST = function()
			message("You stand in the shadow cast by Karin tower")
		end
	}
}

new_feature_type
{
	define_as = "FEAT_LAMP"
	name = "lamp"
	display = '|' color = color.ANTIQUE_WHITE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
		end
	}
}

-- Ox King's House
new_feature_type
{
	define_as = "FEAT_LADDER_RIGHT"
	name = "ladder or stairs"
	display = '/' color = color.LIGHT_UMBER
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true NO_VISION=true
		MOVE_POST_DEST=function(oy, ox, dir, do_pickup, run, disarm)
			if dball.current_location() == "Mount Frypan" then
				if ox < player.px then
					message("You climb up into the battlements")
				else
					message("You descend into the courtyard")
				end
			elseif dball.current_location() == "Foot Lair" then
				if oy > player.py then
					message("You walk down a dark stairwell")
				else
					message("You climb back up the stairs.")
				end
			elseif dball.current_location() == "Duel vs Sumo" then
				if ox > player.px then
					message("You go back down the stairs")
				else
					message("You climb the wooden stairs")
				end
			end
		end
	}
}

new_feature_type
{
	define_as = "FEAT_LADDER_LEFT"
	name = "wire rung ladder"
	display = '\\' color = color.LIGHT_UMBER
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true NO_VISION=true
		MOVE_POST_DEST=function(oy, ox, dir, do_pickup, run, disarm)
			if dball.current_location() == "Mount Frypan" then
				if ox < player.px then
					message("You descend into the courtyard")
				else
					message("You climb up into the battlements")
				end
			elseif dball.current_location() == "Foot Lair" then
				if dun_level == 12 then
					-- juvinile.map
					if oy > player.py then
						message("You climb to the top of the skateboard ramp")
					else
						message("You climb back down.")
					end
				else
					-- Inner sanctum
					if oy > player.py then
						message("You climb back down the ladder.")
					else
						message("You climb up a hidden ladder in the wall.")
					end
				end
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_DRAWBRIDGE"
	name = "a large lever"
	display = '=' color = color.RED
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
		MOVE_POST_DEST=function(oy, ox, dir, do_pickup, run, disarm)
			-- 0=nevertouched
			-- 1=lowered
			-- 2=has been lowered, but is currently raised
			if dball_data.oxking_drawbridge < 1 then
				dball_data.oxking_drawbridge = 1
				message("You lower the drawbridge.")
			else
				dball_data.oxking_drawbridge = -1
				message("You raise the drawbridge.")
			end
		end
	}
}
-- End Ox King's House

-- Used to turn off the various systems
new_feature_type
{
	define_as = "FEAT_CONTROL_SYSTEM"
	name = "computer"
	display = '=' color = color.RED
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
		MOVE_POST_DEST=function(oy, ox, dir, do_pickup, run, disarm)
			-- Handled in map files
		end
	}
}

-- Used by the Room of Spirit and Time
new_feature_type
{
	define_as = "FEAT_VOID"
	name = "void"
	display = ' ' color = color.DARK
	flags =
	{
		FLOOR=true
	}
}

-- Generic for furniture. Use on_walk in maps to designate
new_feature_type
{
	define_as = "FEAT_FURNITURE"
	name = "furniture"
	display = '=' color = color.LIGHT_UMBER
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
	}
}
new_feature_type
{
	define_as = "FEAT_KAIO_CAR"
	name = "cadillac"
	display = '&' color = color.RED
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
	}
}
new_feature_type
{
	define_as = "FEAT_BUDDHA"
	name = "giant statue of Buddha"
	on_block = "a statue of Buddha blocking the way. Ironic, huh?"
	display = 'B' color = color.GOLD
	flags =
	{
		WALL=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
	}
}
new_feature_type
{
	define_as = "FEAT_SATAN_TROPHY"
	name = "furniture"
	display = '~' color = color.YELLOW
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
		MOVE_POST_DEST=function()
			message("A trophy won by Mr. Satan in a tournament.")
		end
	}
}
new_feature_type
{
	define_as = "FEAT_TELEVISION"
	name = "television"
	display = '=' color = color.LIGHT_BLUE
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true
	}
}

--[[
-- Tama's Litterbox
new_feature_type
{
	define_as = "FEAT_LITTERBOX"
	name = "litter box"
	display = '=' color = color.UMBER
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		PERMANENT=true NO_VISION=true
		MOVE_POST_DEST=function()
			if quest(QUEST_LITTER_BOX).status == QUEST_STATUS_UNTAKEN then
				if dball_data.tama_litterbox > 10 then
					message("Tama's litter box smells foul, and is making the entire room reek.")
				elseif dball_data.tama_litterbox > 5 then
					message("Tama's litter box is overdue to be cleaned.")
				elseif dball_data.tama_litterbox > 2 then
					message("Tama's litter box could probably use a good cleaning.")
				elseif dball_data.tama_litterbox > 0 then
					message("Tama's litter box is relatively clean.")
				else
					message("Tama's litter box is clean.")
				end
			else
				message("You take a few moments and clean Tama's litterbox. She purrs, gratefully.")
				dball_data.tama_litterbox = 0
				if quest(QUEST_LITTER_BOX).status == QUEST_STATUS_TAKEN then
					change_quest_status(QUEST_LITTER_BOX, QUEST_STATUS_FINISHED)
					dball_data.seduce_buruma = dball_data.seduce_buruma + 1
				end
			end
		end
	}
}
]]

new_feature_type
{
	define_as = "FEAT_WT_BLOCKER"
	name = "floor"
	on_walk = "You push through the door."
	display = '+' color = color.LIGHT_UMBER
	can_enter = function(mode)
		return true
	end
	flags =
	{
		DONT_NOTICE_RUNNING=true CAN_RUN=true WALL=true NO_VISION=true
	}
}
-- This is to keep Tourny opponent from exiting the ring when afraid
-- DOES THIS WORK NOW THAT FLOOR=TRUE IS BACK?!?!? (For tailwhips and throws)
new_feature_type
{
	define_as = "FEAT_WT_RING_BORDER"
	name = "floor"
	display = '.' color = color.WHITE
	can_enter = function(mode)
		return true
	end
	flags =
	{
		FLOOR=true
		-- CAN_PASS=getter.flags{CAN_FLY=1}
		MONST_CAN_ENTER = function(y, x, do_attack, monst)
			if has_flag(monst, FLAG_CAN_FLY) then
				return true
			else
				return false
			end
		end
		MOVE_POST_DEST=function()
			if dball_data.tourny_now ~= 1 then
			else
				if dball.tourny_disqualify() then
					message(color.YELLOW, "You have left the ring! The match is lost!")
					dball_data.tourny_registered = 3 -- Disqualified
				end
			end
		end
	}
}

new_feature_type
{
	define_as = "FEAT_WT_FAKE_DOOR"
	name = "door"
	on_walk = "You push through the door."
	on_block = "a door blocking the way."
	display = '+' color = color.LIGHT_UMBER
	can_enter = function(mode)
		if dball_data.tourny_registered > 0 then
			return true
		end
	end
	flags =
	{
		DONT_NOTICE_RUNNING=true CAN_RUN=true NO_VISION=true WALL=true
	}
}
new_feature_type
{
	define_as = "FEAT_IMPASSABLE_DOOR"
	name = "steel blastdoor"
	on_block = "a steel blastdoor blocking the way."
	display = '+' color = color.LIGHT_UMBER
	flags =
	{
		DONT_NOTICE_RUNNING=true CAN_RUN=true NO_VISION=true WALL=true NOTICE=true
	}
}

--[[
-- Main Entrance to Mr. Satan's Estate
new_feature_type
{
	define_as = "FEAT_SE_FAKE_DOOR"
	name = "door"
	display = '+' color = color.LIGHT_UMBER
	can_enter = function(mode)
		if dball_data.alive ~= 0 then
			message("You walk through the gate.")
			return true
		elseif dball_data.married == FLAG_MARRIED_VIDEL then
			return true
		elseif dball_data.leaving_satan_estate == 1 then
			message("The guard lets you through")
			dball_data.leaving_satan_estate = 0
			return true
		elseif quest(QUEST_BRIEFS_SATAN_DELIVERY).status == QUEST_STATUS_TAKEN then
			message("You explain your delivery from Dr. Briefs, and the guard lets you in")
			return true
		elseif quest(QUEST_AKIRA_SUSHI).status == QUEST_STATUS_TAKEN then
			message("You mention sushi delivery, and the guard lets you in.")
			return true
		elseif dball_data.satan_state == 3 then
			message("The guard lets you in to train.")
			return true
		else
			if player.stat(A_CHR) > 15 then
				message("You (persuade) the guard to let you in")
				return true
			else
				message("You ring for admittance at the gate, but no one answers.")
				return false
			end
		end
	end
	flags =
	{
		DONT_NOTICE_RUNNING=true CAN_RUN=true NO_VISION=true WALL=true REMEMBER=true NOTICE=true 
	}
}
]]

new_feature_type
{
	define_as = "FEAT_FAKE_DOOR"
	name = "door"
	on_block = "a door blocking the way."
	display = '+' color = color.LIGHT_UMBER
	flags =
	{
		DONT_NOTICE_RUNNING=true CAN_RUN=true NO_VISION=true WALL=true
	}
}

-- Used to direct allowable monster movements in special levels
new_feature_type
{
	define_as = "FEAT_BLOCKADE"
	name = "floor"
	display = '.' color = color.YELLOW
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		CAN_PASS=getter.flags{PASS_BLOCKADE=true}
	}
}

new_feature_type
{
	define_as = "FEAT_SIGNPOST"
	name = "a signpost"
	display = 'T' color = color.ORANGE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true PERMANENT=true NOTICE=true REMEMBER=true 
	}
}
new_feature_type
{
	define_as = "FEAT_TONKAN"
	name = "business directory"
	display = 'T' color = color.ORANGE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true PERMANENT=true NOTICE=true 
		MOVE_POST_DEST=function()
			term.save()
			term.text_out(color.LIGHT_BLUE, "Tonkan Commercial Leasing\n\n")
			term.text_out(" Directory (From left to right)\n")
			if c_schools[FLAG_KARATE] == FLAG_SCHOOL_OPEN then
				term.text_out(" Suite 100: Nakamura's Karate Dojo\n")
			else
				term.text_out(" Suite 100: Vacant\n")
			end
			if c_schools[FLAG_KICKBOXING] == FLAG_SCHOOL_OPEN then
				term.text_out(" Suite 101: Bob's Kickboxing Gym\n")
			else
				term.text_out(" Suite 101: Vacant\n")
			end
			if c_schools[FLAG_JUDO] == FLAG_SCHOOL_OPEN then
				term.text_out(" Suite 102: Yawara's Judo Dojo\n")
			else
				term.text_out(" Suite 102: Vacant\n")
			end
			if c_schools[FLAG_SUMO] == FLAG_SCHOOL_OPEN then
				term.text_out(" Suite 103: Honda's Sumo Dojo\n")
			else
				term.text_out(" Suite 103: Vacant\n")
			end
			if c_schools[FLAG_KUNGFU] == FLAG_SCHOOL_OPEN then
				term.text_out(" Suite 104: Fong-Sai Yuk's Kung Fu school\n")
			else
				term.text_out(" Suite 104: Vacant\n")
			end
			if c_schools[FLAG_FENCING] == FLAG_SCHOOL_OPEN then
				term.text_out(" Suite 105: Escrime Universite Du Jacque\n\n")
			else
				term.text_out(" Suite 105: Vacant\n")
			end
			dialogue.conclude()
			term.load()
		end
	}
}

new_feature_type
{
	define_as = "FEAT_WINDOW"
	name = "window"
	on_block = "a heavy glass window blocking your way"
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		else
			return false
		end
	end
	display = ' ' color = color.DARK
	flags =
	{
		WALL=true NO_WALK=true NO_VISION=true PERMANENT=true
		DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_MIRROR"
	name = "mirror"
	on_block = "a wall-mounted mirror blocking your way"
	display = '. ' color = color.LIGHT_BLUE
	flags =
	{
		NO_WALK=true WALL=true PERMANENT=true NOTICE=true DONT_NOTICE_RUNNING=true
	}
}

new_feature_type
{
	define_as = "FEAT_JAPANESE_BATH"
	name = "a Japanese bath"
	display = '~' color = color.LIGHT_BLUE
	priority = 20
	shimmers = { color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.BLUE, }
	flags =
	{
		ATTR_MULTI=true FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true
		WATER=true NOTICE=true
		MOVE_POST_DEST=function()
			if dball_data.alive ~= 0 then
				message("Ahhh...so sad. You're dead. You can't bathe.")
			elseif dball_data.showered == 1 then
				message("Ahhh! Relaxing!")
			else
				message("You're supposed to shower before bathing! What...are you a barbarian!?!?")
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_SHOWER"
	name = "a small shower"
	display = '=' color = color.LIGHT_BLUE
	priority = 20
	flags =
	{
		FLOOR=true CAN_FLY=1 SUPPORT_LIGHT=true NOTICE=true
		MOVE_POST_DEST=function()
			if dball_data.alive ~= 0 then
				message("Ahhh...so sad. You're dead. You can't shower.")
			else
				dball_data.showered = 1
				message("You shower and scrub yourself clean")
			end
		end
	}
}

new_feature_type
{
	define_as = "FEAT_FIGHTING_RING"
	name = "fighting ring"
	display = strchar(127) color = color.RED
	flags =
	{
		FLOOR=true PERMANENT=true NOTICE=true REMEMBER=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_DISQUALIFIED"
	name = "outside of the ring"
	display = '.' color = color.WHITE
	can_enter = function(mode)
		return true
	end
	flags =
	{
		FLOOR=true 
		PERMANENT=true
		MOVE_POST_DEST=function()
			if dball_data.tourny_now > 0 then
				if dball.tourny_disqualify() then
					message(color.YELLOW, "You have left the ring! The match is lost!")
					dball_data.tourny_registered = 3 -- Disqualified by ring-out
				end
			elseif dball.current_location() == "Duel vs Sumo" then
				if dball.how_many_exist(RACE_HONDA) > 0 and quest(QUEST_CHALLENGE_SUMO).status == QUEST_STATUS_TAKEN then
					message(color.YELLOW, "You have left the ring! The match is lost!")
					dball_data.fled_sumo = 2
					dball.delete_monster(RACE_HONDA)
				end
			end
		end
	}
}


-- Is this used anymore?
new_feature_type
{
	define_as = "FEAT_DEEP_SPACE"
	name = "Deep Space"
	display = '*' color = color.BLUE
	shimmers = { color.DARK, color.LIGHT_DARK, color.SLATE, color.LIGHT_DARK, color.SLATE, color.DARK, color.DARK, }
	can_enter = function(mode)
		return true
	end
	flags =
	{
		ATTR_MULTI=true WALL=true NO_WALK=true NO_VISION=true PERMANENT=true
		SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true
		-- If we can see it, we've already passed the checks, so just allow travel
	}
}
new_feature_type
{
	define_as = "FEAT_MAP_BORDER"
	name = "Map Edge"
	display = ' ' color = color.DARK
	on_block = "a map edge here. Go away! :P"
	can_enter = function(mode)
		return false
	end
	flags =
	{
		WALL=true NO_WALK=true NO_VISION=true PERMANENT=true
		SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true
	}
}
--[[ 
new_feature_type
{
	define_as = "FEAT_PLANET_BORDER"
	name = "Planet Map Edge"
	display = ' ' color = color.DARK
	can_enter = function(mode)
		-- return false
	end
	flags =
	{
		NO_VISION=true PERMANENT=true
		SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			dball.planet_edge()
		end
	}
}
]]
new_feature_type
{
	define_as = "FEAT_SERPENT_PATH"
	name = "Serpent's Path"
	-- display = strchar(127) color = color.ANTIQUE_WHITE
	display = '.' color = color.ANTIQUE_WHITE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}

new_feature_type
{
	define_as = "FEAT_SERPENT_CLOUD"
	name = "strange, fluffy clouds"
	display = strchar(127) color = color.ORANGE
	shimmers = { color.ORANGE, color.ORANGE, color.ORANGE, color.SANDY_BROWN color.ORANGE, color.ORANGE, color.ORANGE, }
	can_enter = function(mode)
		return true
	end
	flags =
	{
		ATTR_MULTI=true
		DONT_NOTICE_RUNNING=true CAN_RUN=true
		SUPPORT_LIGHT=true 
		MOVE_POST_DEST=function()
			if dball.player_flying() == false then
				message(color.YELLOW, "You fall off the path!")
				dball.dungeon_teleport("Hell")
			end
		end
	}
}

new_feature_type
{
	define_as = "FEAT_AESTHETIC_SPACE"
	name = "Just Space"
	can_enter = function(mode)
		if dball_data.chi_flight_setting == 1 then
			return true
		end
	end
	display = '*' color = color.BLUE
	shimmers = { color.DARK, color.DARK, color.SLATE, color.DARK, color.DARK, color.DARK, color.DARK, }
	flags =
	{
		ATTR_MULTI=true
		SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true
	}
}

-- Sky Backgrounds
new_feature_type
{
	define_as = "FEAT_SKY"
	name = "sky"
	display = strchar(127) color = color.LIGHT_BLUE
	can_enter = function(mode)
		return true
	end
	flags =
	{
		NO_VISION=true SUPPORT_LIGHT=true  CAN_RUN=true
		DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			if dball.player_flying() == false then
				if dball.current_location() == "Heaven" then
					local where_to = "Earth"
					-- This is incorrect for Earth-9! Implement me!
					--[[
					if player.py < cur_hgt / 2 and player.px < cur_wid / 2 then
						where_to = "Earth, NW"
					elseif player.py < cur_hgt / 2 and player.px > cur_wid / 2 then
						where_to = "Earth, NE"
					elseif player.py > cur_hgt / 2 and player.px > cur_wid / 2 then
						where_to = "Earth, SE"
					end
					]]
					local new_y = rescale(player.py, cur_hgt, 66)
					local new_x = rescale(player.px, cur_wid, 180)
					dball.planetary_teleport_helper(where_to)
					message("You float gently down.")
					-- player.py = new_y
					-- player.px = new_x
					player.leaving=true
				elseif dball.current_location() == "Land of Karin" then
					if dun_level == 1 then
						message("You fall off the tower!")
						local fall_height = 1
						local move_y = player.py
						while (cave(move_y, player.px).feat == FEAT_SKY) or (cave(move_y, player.px).feat == FEAT_CLOUD) do
							move_y = move_y + 1
							fall_height = fall_height + 1
						end
						local falling_damage = fall_height * 5
						local death_mess = "falling off Karin Tower"
						take_hit(falling_damage, death_mess)
						teleport_player_to(move_y, player.px)
					else
						-- On the roof or Kami's Lookout
						message("You fall off the edge")
						local falling_damage = 500 + rng.number(500)
						local death_mess = "falling off Karin Tower"
						if dun_level == 3 then
							falling_damage = falling_damage * 2
							death_mess = "falling from Kami's Lookout"
						end
						dun_level = 0
						player.py = 18
						player.px = 62
						player.leaving=true
						take_hit(falling_damage, death_mess)
					end
				else
					-- Where else is there sky?
					message(color.YELLOW, "You fall off the edge!")
					dball.dungeon_teleport("Hell")
				end
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_CLOUD"
	name = "cloud"
	display = strchar(127) color = color.LIGHT_WHITE
	shimmers = { color.LIGHT_WHITE, color.WHITE, color.LIGHT_BLUE, color.LIGHT_WHITE, color.WHITE, color.LIGHT_WHITE, color.WHITE, }
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true ATTR_MULTI=true
		CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_RECEPTACLE"
	name = "green carpet"
	display = '#' color = color.GREEN
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true 
		MOVE_POST_DEST=function()
			if quest(QUEST_CURIOUS_HOLE).status == QUEST_STATUS_UNTAKEN then
				change_quest_status(QUEST_CURIOUS_HOLE, QUEST_STATUS_TAKEN)
			end
		end
	}
}

new_feature_type
{
	define_as = "FEAT_NYOIBO"
	name = "Nyoi-bo"
	display = '|' color = color.RED
	on_walk = "You climb the Nyoi-bo"
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true 
	}
}

new_feature_type
{
	define_as = "FEAT_TRAP"
	name = "trap"
	display = '^' color = color.WHITE
	flags =
	{
		FLOOR=true NOTICE=true REMEMBER=true
	}
}

--------------------------------------------------------------------------
-----        Things that should be migrated to MOVE_POST_DEST        -----
--------------------------------------------------------------------------
-- Trap Door to Buyon's Lair
new_feature_type
{
	define_as = "FEAT_BUYON_TRAP"
	name = "floor"
	display = '.' color = color.WHITE
	can_enter = function(mode)
		return true
	end
	flags =
	{
		DONT_NOTICE_RUNNING=true CAN_RUN=true
		SUPPORT_LIGHT=true 
		-- CAN_PASS=getter.flags{PASS_BLOCKADE=true}
		MOVE_POST_DEST=function()
			-- Only activate the trap if Buyon still lives
			if race_info_idx(RACE_BUYON, 0).max_num ~= 0 then
				if dball.player_flying() == false then
					dialogue.BUYON_TRAP()
					-- dball.dungeon_teleport("Buyon's Lair")
					-- dialogue.BUYON_LAIR()
				else
					-- Activate, but no effect
					dialogue.BUYON_TRAP_FAIL()
				end
			end
		end
	}
}


-- Helper FEAT's for the Serpent's Path Stariways
new_feature_type
{
	define_as = "FEAT_KAMI_TO_SERPENT"
	name = "interdimensional portal"
	display = 'O' color = color.LIGHT_GREEN
	shimmers = { color.LIGHT_RED, color.RED, color.LIGHT_BLUE, color.BLUE, color.VIOLET, color.YELLOW, color.GREEN, }
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		ATTR_MULTI=true
		MOVE_POST_DEST=function()
			term.save()
			term.text_out(color.LIGHT_GREEN, "Before ")
				term.text_out("lies the shimmering portal into the afterworld. \n\nWould you like to enter? (y/n)")
			
			local key = term.inkey()
			term.load()
			if strchar(key) == "y" then
				dball_data.serpert_teleport = 1
				dball.dungeon_teleport("The Serpent's Path")
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_KAIO_TO_SERPENT"
	name = "trampoline"
	display = 'O' color = color.UMBER
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		MOVE_POST_DEST=function()
			term.save()
			term.text_out(color.LIGHT_GREEN, "There ")
				term.text_out("is a really big trampoline here. With a big enough jump you could probably get enough speed to leave this small planet. \n\nWould you like to try? (y/n)")
			
			local key = term.inkey()
			term.load()
			if strchar(key) == "y" then
				dball_data.serpert_teleport = 2
				dball.dungeon_teleport("The Serpent's Path")
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_SERPENT_KAIO"
	name = "an object in the sky"
	display = 'o' color = color.LIGHT_GREEN
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true NOTICE=true
		MOVE_POST_DEST=function()
			term.save()
			term.text_out(color.LIGHT_GREEN, "Amidst ")
			term.text_out("a pink sky line above the orange clouds you see a large object hovering above you. Looking closely, it appears to be a large sphere, or perhaps a small planet? Curiously, you feel a strong pull coming from it, and even though it is several hundred feet away, you think you could jump, and allow yourself to be pulled across the distance.\n\nWould you like to try? (y/n)")
			
			local key = term.inkey()
			term.load()
			if strchar(key) == "y" then
				dball.planetary_teleport_helper("Kaio via Serpent")
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_SERPENT_EARTH"
	name = "exit"
	on_walk = "an exit"
	display = '<' color = color.WHITE
	priority = 20
	flags =
	{
		FLOOR=true REMEMBER=true NOTICE=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			-- local ret, key = get_com("This stairway descends farther than you can see. Descend? (y/n)")
			-- if not ret then return end
			-- if strchar(key) == "y" then
			-- 	dball.planetary_teleport_helper("Earth via Serpent")
			-- end
		end
	}
}
-- Spaceport: The monsters can't enter, and as long as you're inside
-- the monsters ignore you
new_feature_type
{
	define_as = "FEAT_SPACEPORT"
	name = "spaceport"
	display = '.' color = color.WHITE
	priority = 20
	can_enter = function(mode)
		return true
	end
	flags =
	{
		SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		WALL=true
		MOVE_POST_DEST=function()
			for_each_monster(function(m_idx, monst)
				monst.ai = ai.DBT_RANDOM
			end)
		end
	}
}
-- But...step outside, and you're fair game
new_feature_type
{
	define_as = "FEAT_DESERT"
	name = "desert"
	display = '.' color = color.YELLOW
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			for_each_monster(function(m_idx, monst)
				monst.ai = ai.ZOMBIE
			end)
		end
	}
}
-- Yamcha's Bridge
new_feature_type
{
	define_as = "FEAT_YAMCHA_BRIDGE"
	name = "bridge"
	display = '.' color = color.WHITE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			if dball_data.yamcha_state == 0 then
				dialogue.YAMCHA_BRIDGE_HELPER()
			elseif dball_data.yamcha_state == 4 then
				-- Hack...but should be correct 99% of the time
				if cave(51, 15).m_idx ~= 0 then
					message("Yamcha sees you, and runs off screaming!")
					for_each_monster(function(m_idx, monst)
						if monst.r_idx == RACE_YAMCHA then
							monst.ai = ai.DBT_RUN_AWAY
						end
					end)
				end
			end
		end
	}
}

-- TTQ1: 'Forewarning'
new_feature_type
{
	define_as = "FEAT_TTQ1"
	name = "dirt"
	display = '.' color = color.LIGHT_UMBER
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			if dball.forewarning() then
				message("...you feel a strange tension in the air...")
				dball.ttq_forewarning = 1
			end
		end
	}
}
-- TTQ2: 'Trigger'
new_feature_type
{
	define_as = "FEAT_TTQ2"
	name = "dirt"
	display = '.' color = color.LIGHT_UMBER
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			if dball.ttq_forewarning == 1 then
				dball.ttq_forewarning = 2
				dialogue.TRUNKS_EARLY()
			end
		end
	}
}

-- Foot Lair Electronics
new_feature_type
{
	define_as = "FEAT_FOOT_ELECTRONICS"
	name = "floor"
	display = '.' color = color.WHITE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		MOVE_POST_DEST=function()
			if dball_data.goods_warehouse == 0 then
				message(color.YELLOW, "These goods are all in their original packaging.")
				dball_data.goods_warehouse = 1
				quest(QUEST_BEING_WATCHED).status = QUEST_STATUS_TAKEN
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_HELL_SIGN"
	name = "escalator"
	display = '<' color = color.LIGHT_RED
	priority = 20
	flags =
	{
		FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true NOTICE=true
		MOVE_POST_DEST=function()
			message(color.YELLOW, "There is an escalator here, but it seems to be out of order.")
			dball_data.hell_escalator_state = 1
		end
	}
}
new_feature_type
{
	define_as = "FEAT_HELL_ESCALATOR"
	name = "escalator"
	display = '<' color = color.LIGHT_RED
	priority = 20
	flags =
	{
		FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true NOTICE=true
		MOVE_POST_DEST=function()
			message(color.YELLOW, "You climb the escalator! ...wonder where it goes...?")
			dball.dungeon_teleport("The Serpent's Path")
			player.py = 17
			player.px = 48
			player.leaving = true
		end
	}
}
-----------------------------------------------------------------------------
-----       End-Things that should be migrated to MOVE_POST_DEST        -----
-----------------------------------------------------------------------------

------------------------------------------
-----     Damaging terrain types     -----
------------------------------------------
new_feature_type
{
	define_as = "FEAT_DEEP_LAVA"
	name = "the fires of hell"
	on_walk = "You move across the deep lava."
	display = '.' color = color.LIGHT_RED
	priority = 20
	can_enter = function(mode)
		if not mode then return true
		else
			-- In the overhead map
			return player.resists[dam.FIRE] >= 33
		end
	end
	flags =
	{
		FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true
		LAVA=2
	}
	attacks =
	{
		[{dam.FIRE, 1}] = { 10,1 }
	}
}
new_feature_type
{
	define_as = "FEAT_SHAL_LAVA"
	name = "stream of shallow lava"
	on_walk = "You move across the shallow lava."
	display = '.' color = color.RED
	priority = 20
	flags =
	{
		FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true
		LAVA=true
	}
	attacks =
	{
		[{dam.FIRE, 1}] = { 5,-1 }
	}
}
new_feature_type
{
	define_as = "FEAT_VOLC_LAVA"
	name = "stream of volcanic lava"
	on_walk = "You move across the lava."
	display = '^' color = color.RED
	priority = 20
	flags =
	{
		FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true
		LAVA=true NOTICE=true
	}
	attacks =
	{
		[{dam.FIRE, 1}] = { 10,-1 }
	}
}
----------------------------------------------
-----     End-Damaging terrain types     -----
----------------------------------------------

---------------------------------------
-----     Walls and Obstacles     -----
---------------------------------------
new_feature_type
{
	define_as = "FEAT_WALL_OF_FIRE"
	name = "massive grease fire"
	on_walk = "You walk through the wall of flames"
	display = strchar(127) color = color.RED
	shimmers = { color.LIGHT_RED, color.LIGHT_RED, color.RED, color.RED, color.LIGHT_RED, color.YELLOW, color.LIGHT_RED, }
	priority = 20
	flags =
	{
		ATTR_MULTI=true FLOOR=true CAN_FLY=1 REMEMBER=true SUPPORT_LIGHT=true NOTICE=true
	}
	attacks =
	{
		[{dam.FIRE, 1}] = { 10,8 }
	}
}

-------------------------------------------------
-----        Walkable floor terrains        -----
-------------------------------------------------
new_feature_type
{
	define_as = "FEAT_RED_CARPET"
	name = "red carpet"
	display = strchar(127) color = color.RED
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_GREEN_CARPET"
	name = "green carpet"
	display = strchar(127) color = color.GREEN
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}

new_feature_type
{
	define_as = "FEAT_BLUE_CARPET"
	name = "blue carpet"
	display = strchar(127) color = color.LIGHT_BLUE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_ROAD"
	name = "road"
	display = '.' color = color.WHITE
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true REMEMBER=true
	}
}
new_feature_type
{
	define_as = "FEAT_DIRT"
	name = "dirt"
	display = '.' color = color.LIGHT_UMBER
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_ASPHALT"
	name = "asphalt"
	display = '.' color = color.LIGHT_DARK
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_ROADSTRIPE_VERT"
	name = "road stripe"
	display = '|' color = color.YELLOW
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_ROADSTRIPE_HORZ"
	name = "road stripe"
	display = '-' color = color.YELLOW
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_FENCE_VERT"
	name = "white picket fence"
	display = '|' color = color.WHITE
	priority = 20
	flags =
	{
		SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_FENCE_HORZ"
	name = "white picket fence"
	display = '-' color = color.WHITE
	priority = 20
	flags =
	{
		SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_SIDEWALK"
	name = "sidewalk"
	display = '.' color = color.WHITE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_SNOW"
	name = "snow"
	display = '.' color = color.WHITE
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_MUSHROOM"
	name = "a large mushroom"
	on_walk = "You pass underneath the mushroom"
	display = 'T' color = color.PINK
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_GRASS"
	name = "patch of grass"
	display = '.' color = color.LIGHT_GREEN
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
        info =
        {
                CAVE_ICKY = true
        }
}


new_feature_type
{
	define_as = "FEAT_SAND"
	name = "sand"
	display = '.' color = color.YELLOW
	priority = 20
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true
	}
}
new_feature_type
{
	define_as = "FEAT_ASH"
	name = "ash"
	display = '.' color = color.SLATE
	priority = 20
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true
	}
}
new_feature_type
{
	define_as = "FEAT_MUD"
	name = "mud"
	display = '.' color = color.UMBER
	priority = 20
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true
	}
}

-----------------------------------------------
-----     End Walkable floor terrains     -----
-----------------------------------------------


new_feature_type
{
	define_as = "FEAT_ICE_WALL"
	name = "ice wall"
	on_block = "an ice wall blocking your way"
	display = '#' color = color.LIGHT_WHITE
	flags =
	{
		WALL=true NO_WALK=true NO_VISION=true SUPPORT_LIGHT=true
		DONT_NOTICE_RUNNING=true 
		CAN_PASS=getter.flags{PASS_ICE=true, PASS_INCORP=1}
	}
}
new_feature_type
{
	define_as = "FEAT_GLACIER"
	name = "glacier"
	on_block = "an ice wall blocking your way"
	display = strchar(127) color = color.LIGHT_BLUE
	flags =
	{
		WALL=true NO_WALK=true NO_VISION=true SUPPORT_LIGHT=true
		DONT_NOTICE_RUNNING=true PERMANENT=true
	}
}

-- Why is this so unintuitive?
features.trees_pass = {
	PASS_TREES=1
	PASS_INCORP=1
	PASS_GASEOUS=1
	PASS_LIQUID=1
	PASS_CLIMB=1
}

new_feature_type
{
	define_as = "FEAT_DEAD_TREE"
	name = "dead tree"
	on_block = "a tree blocking your way"
	display = 'T' color = color.LIGHT_DARK
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	priority = 20
	flags =
	{
		SUBST_TREE=true
		CAN_FLY=3 WALL=true NO_WALK=true NO_VISION=true
		NOTICE=true DONT_NOTICE_RUNNING=true
		CAN_PASS=getter.flags(features.trees_pass)
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			if player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_CHAINSAW] then
				cave_set_feat(y, x, FEAT_DIRT)
				message(color.YELLOW, "You mow down the tree with your chainsaw")
			elseif has_ability(AB_TAMESHIWARI) and game_options.tameshiwari_mode == true then
				if skill(SKILL_HAND).value >= 25 then
					cave_set_feat(y, x, FEAT_DIRT)
					message(color.YELLOW, "You knock down the tree with a mighty blow")
				else
					message(color.YELLOW, "You strike the tree, but it does not fall")
					energy_use = 480 -- ?? implement??
				end
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_TREES"
	name = "tree"
	on_block = "a tree blocking your way"
	display = 'T' color = color.LIGHT_GREEN
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	priority = 20
	flags =
	{
		SUBST_TREE=true
		CAN_FLY=3 SUPPORT_LIGHT=true WALL=true NO_WALK=true
		NO_VISION=true DONT_NOTICE_RUNNING=true 
		CAN_PASS=getter.flags(features.trees_pass)
		DEAD_TREE_FEAT=FEAT_DEAD_TREE
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			if player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_CHAINSAW] then
				cave_set_feat(y, x, FEAT_DIRT)
				message(color.YELLOW, "You mow down the tree with your chainsaw")
			elseif has_ability(AB_TAMESHIWARI) and game_options.tameshiwari_mode == true then
				if skill(SKILL_HAND).value >= 25 then
					cave_set_feat(y, x, FEAT_DIRT)
					message(color.YELLOW, "You knock down the tree with a mighty blow")
				else
					message(color.YELLOW, "You strike the tree, but it does not fall")
					energy_use = 480 -- ?? implement??
				end
			end
		end
	}
}
-- Easier to do this
new_feature_type
{
	define_as = "FEAT_RRA_SNOW"
	name = "snow"
	display = '.' color = color.WHITE
	can_enter = function(mode)
		return true
	end
	priority = 20
	flags = 
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		-- WHY doesn't this work?!!?
		CAN_PASS=getter.flags{RED_RIBBON=3, CAN_FLY=1}
	}
}
new_feature_type
{
	define_as = "FEAT_RRA_TREES"
	name = "tree"
	on_block = "a tree blocking your way"
	display = 'T' color = color.LIGHT_GREEN
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	priority = 20
	flags =
	{
		SUBST_TREE=true
		CAN_FLY=3 SUPPORT_LIGHT=true WALL=true NO_WALK=true
		DONT_NOTICE_RUNNING=true 
		CAN_PASS=getter.flags(features.trees_pass)
		DEAD_TREE_FEAT=FEAT_DEAD_TREE
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			if player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_CHAINSAW] then
				cave_set_feat(y, x, FEAT_DIRT)
				message(color.YELLOW, "You mow down the tree with your chainsaw")
			elseif has_ability(AB_TAMESHIWARI) and game_options.tameshiwari_mode == true then
				if skill(SKILL_HAND).value >= 25 then
					cave_set_feat(y, x, FEAT_DIRT)
					message(color.YELLOW, "You knock down the tree with a mighty blow")
				else
					message(color.YELLOW, "You strike the tree, but it does not fall")
					energy_use = 480 -- ?? implement??
				end
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_DECAYING_TREES"
	name = "decaying tree"
	on_block = "a decaying tree blocking your way"
	display = 'T' color = color.OLIVE_DRAB
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	priority = 20
	flags =
	{
		SUBST_TREE=true
		CAN_FLY=3 SUPPORT_LIGHT=true WALL=true NO_WALK=true
		NO_VISION=true DONT_NOTICE_RUNNING=true 
		CAN_PASS=getter.flags(features.trees_pass)
		DEAD_TREE_FEAT=FEAT_DEAD_TREE
		MOVE_PRE_DEST = function(y, x, dir, do_pickup, run, disarm)
			if player.inventory[INVEN_TOOL][1] and player.inventory[INVEN_TOOL][1].flags[FLAG_CHAINSAW] then
				cave_set_feat(y, x, FEAT_DIRT)
				message(color.YELLOW, "You mow down the tree with your chainsaw")
			elseif has_ability(AB_TAMESHIWARI) and game_options.tameshiwari_mode == true then
				if skill(SKILL_HAND).value >= 25 then
					cave_set_feat(y, x, FEAT_DIRT)
					message(color.YELLOW, "You knock down the tree with a mighty blow")
				else
					message(color.YELLOW, "You strike the tree, but it does not fall")
					energy_use = 480 -- ?? implement??
				end
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_MOUNTAIN"
	name = "mountain chain"
	on_block = "a hard stone block blocking your way"
	display = '^' color = color.LIGHT_UMBER
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	priority = 20
	flags =
	{
		CAN_CLIMB=true CAN_FLY=15 SUPPORT_LIGHT=true WALL=true NO_WALK=true
		NO_VISION=true DONT_NOTICE_RUNNING=true PERMANENT=true
		CAN_PASS=getter.flags{
			PASS_STONE=15
			PASS_MOUNTAIN=15
			PASS_CLIMB=15
			PASS_INCORP=1
		}
	}
}
new_feature_type
{
	define_as = "FEAT_SNOWY_PEAK"
	name = "snow-covered mountain"
	display = '^' color = color.WHITE
	attacks =
	{
		[{dam.COLD, 1}] = { 10,1 }
	}
	on_block = "a snow covered mountain blocking your way"
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	flags =
	{
		WALL=true NO_WALK=true NO_VISION=true SUPPORT_LIGHT=true
		DONT_NOTICE_RUNNING=true PERMANENT=true CAN_FLY=30
		CAN_PASS=getter.flags{
			PASS_STONE=30
			PASS_MOUNTAIN=30
			PASS_CLIMB=30
			PASS_INCORP=1
		}
	}
}
new_feature_type
{
	define_as = "FEAT_GROTTO"
	name = "cave grotto"
	on_block = "a hard stone block blocking your way"
	display = '^' color = color.LIGHT_UMBER
	priority = 20
	flags =
	{
		SUPPORT_LIGHT=true WALL=true NO_WALK=true
		NO_VISION=true DONT_NOTICE_RUNNING=true PERMANENT=true
	}
}
new_feature_type
{
	define_as = "FEAT_MARKER"
	name = "open floor"
	display = '.' color = color.WHITE
	flags =
	{
		FLOOR=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_MON_TRAP"
	name = "monster trap"
	display = ';' color = color.VIOLET
	flags =
	{
		FLOOR=true
	}
}
new_feature_type
{
	define_as = "FEAT_LAVA_WALL"
	name = "lava wall"
	on_block = "a lava wall blocking your way"
	display = '#' color = color.LIGHT_RED
	shimmers = { color.LIGHT_RED, color.LIGHT_RED, color.RED, color.RED, color.LIGHT_UMBER, color.UMBER, color.LIGHT_RED, }
	flags =
	{
		ATTR_MULTI=true WALL=true NO_WALK=true NO_VISION=true
		DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_SHAL_WATER"
	name = "stream of shallow water"
	display = '~' color = color.LIGHT_BLUE
	priority = 20
	shimmers = { color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.LIGHT_BLUE, color.BLUE, }
	flags =
	{
		ATTR_MULTI=true FLOOR=true CAN_FLY=1 REMEMBER=true
		SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		WATER=true
	}
}

-- Damage handled by process_world
new_feature_type
{
	define_as = "FEAT_DROWNING_WATER"
	name = "water"
	display = '~' color = color.BLUE
	priority = 20
	flags =
	{
		FLOOR=true REMEMBER=true
		SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
		WATER=true
	}
}
new_feature_type
{
	define_as = "FEAT_DEEP_WATER"
	name = "deep water"
	display = '~' color = color.BLUE
	priority = 20
	on_block = "water too deep to walk through and too far to swim blocking your way"
	shimmers = { color.BLUE, color.BLUE, color.BLUE, color.BLUE, color.BLUE, color.BLUE, color.LIGHT_BLUE, }
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif has_ability(AB_SWIMMING) then
			return true
		elseif dball_data.chi_flight_setting == 1 then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		elseif dball.player_needs_air() == false then
			return true
		else
			return false
		end
	end
	flags =
	{
		ATTR_MULTI=true CAN_FLY=1 REMEMBER=true
		SUPPORT_LIGHT=true
		WATER=2
		CAN_PASS=getter.flags{AQUATIC=true, PASS_INCORP=1}
		-- Note: Damage done by process_world to incur damage whlie resting
		MOVE_POST_DEST=function()
			if dball.player_flying() == true then
				message("You fly over the water")
			elseif has_ability(AB_SWIMMING) then
				message("You swim through the water. It is very tiring.")
			end
		end
		MONST_CAN_ENTER = function(y, x, do_attack, monst)
			if has_flag(monst, FLAG_CAN_SWIM) then
				return true
			elseif has_flag(monst, FLAG_CAN_FLY) then
				return true
			else
				return false
			end
		end
	}
}
new_feature_type
{
	define_as = "FEAT_COUNTER"
	name = "display case"
	on_block = "a display case blocking the way"
	display = '.' color = color.LIGHT_BLUE
	flags =
	{
		NO_WALK=true PERMANENT=true NOTICE=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_GLASS_WALL"
	name = "glass wall"
	on_block = "a glass wall blocking your way"
	display = '.' color = color.LIGHT_BLUE
	flags =
	{
		NO_WALK=true WALL=true PERMANENT=true NOTICE=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_TOWN"
	name = "town"
	display = '*' color = color.LIGHT_BLUE
	flags =
	{
		FLOOR=true NOTICE=true
	}
}

new_feature_type
{
	define_as = "FEAT_SWAMP_POOL"
	name = "toxic sludge"
	display = '~' color = color.GREEN
	attacks =
	{
		[{dam.POIS, 1}] = { 1,1 }
	}
	flags =
	{
		FLOOR=true CAN_LEVITATE=true CAN_FLY=true REMEMBER=true SUPPORT_LIGHT=true
		MOVE_POST_DEST=function()
			if dun_level == 0 then
				if quest(QUEST_TOXIC_RIVER).status == QUEST_STATUS_UNTAKEN then
					change_quest_status(QUEST_TOXIC_RIVER, QUEST_STATUS_TAKEN)
				end
			end
		end
	}
}

-- Not sure why or where this is being used...but removing it generates LUA errors in birth
new_feature_type
{
	define_as = "FEAT_FLOWER"
	name = "grass with flowers"
	display = ';' color = color.LIGHT_GREEN
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true
	}
}

---------------------------
---- Namek ----------------
---------------------------
new_feature_type
{
	define_as = "FEAT_NAMEK_GROUND"
	name = "ground"
	display = '.' color = color.LIGHT_UMBER
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_NAMEK_GRASS"
	name = "ground"
	display = '-' color = color.LIGHT_GREEN
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_NAMEK_MOUNTAIN"
	name = "high ground"
	on_block = "a hard stone block blocking your way"
	display = '^' color = color.LIGHT_UMBER
	can_enter = function(mode)
		if dball.player_flying() == true then
			return true
		elseif player.has_intrinsic(FLAG_PASS_CLIMB) then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		end
	end
	priority = 20
	flags =
	{
		CAN_CLIMB=true CAN_FLY=15 SUPPORT_LIGHT=true WALL=true NO_WALK=true
		NO_VISION=true DONT_NOTICE_RUNNING=true PERMANENT=true
		CAN_PASS=getter.flags{
			PASS_STONE=15
			PASS_MOUNTAIN=15
			PASS_CLIMB=15
			PASS_INCORP=1
		}
	}
}
new_feature_type
{
	define_as = "FEAT_AJASA"
	name = "ajasa plants"
	display = ';' color = color.VIOLET
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true NOTICE=true
	}
}
new_feature_type
{
	define_as = "FEAT_NAMEK_EMPTY_WELL"
	name = "a well"
	display = 'o' color = color.WHITE
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true NOTICE=true
		MOVE_POST_DEST=function()
			message("The well is dry.")
		end
	}
}
new_feature_type
{
	define_as = "FEAT_NAMEK_WELL"
	name = "a well"
	display = 'o' color = color.WHITE
	flags =
	{
		FLOOR=true DONT_NOTICE_RUNNING=true CAN_RUN=true NOTICE=true
		MOVE_POST_DEST=function()
			message("There is plenty of water in this well.")
		end
	}
}
new_feature_type
{
	define_as = "FEAT_NAMEK_WATER"
	name = "namekkian water"
--	display = '~' color = color.GREEN
	display = '~' color = color.BLUE
	priority = 20
	on_block = "water too deep to walk through and too far to swim blocking your way"
--	shimmers = { color.GREEN, color.LIGHT_GREEN, color.LIGHT_GREEN, color.GREEN, color.LIGHT_GREEN, color.LIGHT_GREEN, color.LIGHT_GREEN, }
	shimmers = { color.BLUE, color.BLUE, color.BLUE, color.BLUE, color.BLUE, color.BLUE, color.LIGHT_BLUE, }
	can_enter = function(mode)
		if has_ability(AB_SWIMMING) then
			return true
		elseif dball_data.chi_flight_setting == 1 then
			return true
		elseif dball_data.alive ~= 0 then
			return true
		elseif player.inventory[INVEN_TOOL][1] then
				if player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL_REQUIRE] and player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL_REQUIRE] == FLAG_OXYGEN_TANK then
					if player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL] > 0 then
						player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL] = player.inventory[INVEN_TOOL][1].flags[FLAG_FUEL] - 1
						return true
					end
				end
		else
			return false
		end
	end
	flags =
	{
		ATTR_MULTI=true CAN_FLY=1 REMEMBER=true
		SUPPORT_LIGHT=true
		WATER=2
		CAN_PASS=getter.flags{AQUATIC=true, PASS_INCORP=1}
		MOVE_POST_DEST=function()
			if dball.player_flying() == true then
				message("You fly over the water")
			elseif has_ability(AB_SWIMMING) then
				message("You swim through the water. It is very tiring.")
			end
		end
		MONST_CAN_ENTER = function(y, x, do_attack, monst)
			if has_flag(monst, FLAG_CAN_SWIM) then
				return true
			elseif has_flag(monst, FLAG_CAN_FLY) then
				return true
			else
				return false
			end
		end
	}
}
---------------------------
---- End Namek ------------
---------------------------




---------------------------------------------------
-----     Things up for possible deletion     -----
---------------------------------------------------
new_feature_type
{
	define_as = "FEAT_QUEST_DOWN"
	name = "quest down level"
	display = '>' color = color.RED
	flags =
	{
		FLOOR=true PERMANENT=true REMEMBER=true NOTICE=true CAN_RUN=true
	}
}
new_feature_type
{
	define_as = "FEAT_QUEST_UP"
	name = "quest up level"
	display = '<' color = color.RED
	flags =
	{
		FLOOR=true PERMANENT=true REMEMBER=true NOTICE=true CAN_RUN=true
	}
}
new_feature_type
{
	name = "field"
	display = ':' color = color.GREEN
	flags =
	{
		FLOOR=true PERMANENT=true NOTICE=true REMEMBER=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_ILLUS_WALL"
	name = "illusion wall"
	on_walk = "Looks like this wall is not so real."
	display = '#' color = color.WHITE
	flags =
	{
		FLOOR=true NO_VISION=true REMEMBER=true SUPPORT_LIGHT=true DONT_NOTICE_RUNNING=true
	}
}
new_feature_type
{
	define_as = "FEAT_SHORT_GRASS"
	name = "tuft of short grass"
	display = '.' color = color.DARK_KHAKI
	priority = 20
	flags =
	{
		FLOOR=true SUPPORT_LIGHT=true CAN_RUN=true DONT_NOTICE_RUNNING=true
	}
}

new_feature_type
{
	define_as = "FEAT_ICE"
	name = "ice"
	display = '.' color = color.LIGHT_WHITE
	priority = 20
	flags =
	{
		FLOOR=true NOTICE=true
		MOVE_PRE_DIR= function()
				if dball_data.alive ~= 0 then
					if not player.has_intrinsic(FLAG_FLY) and
						rng.percent(70 - player.lev) then
						message("You slip on the icy floor.")
						return rng(9)
					end
				end
			end
	}
	attacks =
	{
		[{dam.ICE, 50}] = { 1,20 }
	}
}
new_feature_type
{
	define_as = "FEAT_GLYPH"
	name = "glyph of warding"
	on_walk = "There is a mighty spell of protection here."
	display = ';' color = color.YELLOW
	flags =
	{
		FLOOR=true NOTICE=true SUPPORT_LIGHT=true CAN_RUN=true REMEMBER=true
	}
}
new_feature_type
{
	define_as = "FEAT_QUEST_ENTER"
	name = "quest entrance"
	display = '>' color = color.YELLOW
	flags =
	{
		FLOOR=true PERMANENT=true REMEMBER=true NOTICE=true CAN_RUN=true
		QUEST_CHANGER=true
	}
}
new_feature_type
{
	define_as = "FEAT_QUEST_EXIT"
	name = "quest exit"
	display = '<' color = color.YELLOW
	flags =
	{
		FLOOR=true PERMANENT=true REMEMBER=true NOTICE=true CAN_RUN=true
		QUEST_CHANGER=-1
	}
}
new_feature_type
{
	name = "town exit"
	display = '>' color = color.GREEN
	flags =
	{
		FLOOR=true PERMANENT=true REMEMBER=true NOTICE=true CAN_RUN=true
	}
}
------------------------------------------------------
-----    End Things up for possible deletion     -----
------------------------------------------------------
