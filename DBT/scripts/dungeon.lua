-- Dragonball T: Save level maintenance

constant("dungeons", {})

function dungeons.maintain_decaying_level(loaded_turn, decayed_monsters, decayed_objects, decayed_effects)
	-- Realloc some monsters
	if decayed_monsters > 0 and not level_flags.flags[FLAG_NO_NEW_MONSTER] then
		local alloc_m = decayed_monsters + rng(-decayed_monsters / 2, decayed_monsters / 2)
		for i = 1, alloc_m do alloc_monster(0, true) end
	end

	-- All saved monsters are healed while the player is away.
	for_each_monster(function(m_idx, monst)
		monst.hp = monst.maxhp
	end)

end
