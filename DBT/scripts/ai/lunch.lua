-- Lunch is something of a multiple personality case. One personality
-- is all sweetnes and light, the other is a hard core drinker who
-- carries an uzi and robs banks.
--
-- ...she switches every time she sneezes...

ai.new
{
	name	= "LUNCH"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)

		local sneeze_chance = 2
		if dball.current_location() == "Castle Oolong" then
			sneeze_chance = 0
		end
		if (monst.hp * 100) / monst.maxhp < 30 then
			if dball_data.lunch_sneeze == 1 then
				sneeze_chance = 50
			end
		end

		if rng.percent(sneeze_chance) then
			if los(player.py, player.px, monst.fy, monst.fx) then
				message(color.YELLOW, "Lunch sneezes!")
			else
				message("You hear someone sneeze in the distance.")
			end
			if dball_data.lunch_sneeze == 1 then
				dball_data.lunch_sneeze = 0
				monst.color = color.LIGHT_BLUE
				if dball_data.lunch_faction ~= 0 then
					factions.set_friendliness(FACTION_PLAYER, FACTION_LUNCH, -1)
					factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, 0)
				else
					factions.set_friendliness(FACTION_PLAYER, FACTION_LUNCH, 0)
					factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, 0)
				end

			else
				dball_data.lunch_sneeze = 1
				monst.color = color.RED
				if party.is_partied(RACE_LUNCH) > 0 then
					if rng(1,3) == 1 then
						factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, -1)
					else
						factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, 0)
					end
				else
					factions.set_friendliness(FACTION_PLAYER, FACTION_LUNCH, -1)
					factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, -1)
				end
			end
		end

		-- Party


		if dball_data.lunch_sneeze == 0 then -- Nice
			if rng(1,9) == 1 then
				if los(player.py, player.px, monst.fy, monst.fx) then
					monster_random_say{
						"Lunch smiles demurely.",
						"Lunch hums sweetly to herself.",
						"Lunch leaves some seeds for the birds to find.",
					}
				end
			end
			if party.is_partied(RACE_LUNCH) > 0 then
				ai.exec(ai.PARTY, m_idx, monst)
			else
				ai.exec(ai.DBT_RANDOM, m_idx, monst)
			end
		else	-- Naughty
			if rng(1,9) == 1 then
				if los(player.py, player.px, monst.fy, monst.fx) then
					monster_random_say{
						"Lunch shrieks 'Bwaahahhahahaha!!!!!! AAAAAAIIEEEEE!'",
						"Lunch reloads her uzi and grins maniacally.",
						"Lunch takes a swig from a bottle of whisky then hurls it at you!",
					}
				end
			end
			if party.is_partied(RACE_LUNCH) > 0 then
				local foo = rng(1, 10)
				if foo == 1 then
					if (wizard) then message("(Wizard) Evil Lunch's mood swings to less friendly") end
					factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, -1)
					monst.target = 0
				elseif foo > 4 then
					if (wizard) then message("(Wizard) Evil Lunch's mood swings to more friendly") end
					factions.set_friendliness(FACTION_LUNCH, FACTION_PLAYER, 0)
					local t_idx, y, x = party.get_target(m_idx)
					monst.target = t_idx
				end

			end
			ai.exec(ai.DBT_DEFAULT, m_idx, monst)
		end
	end
}
