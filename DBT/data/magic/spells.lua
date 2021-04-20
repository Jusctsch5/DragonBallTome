-- Dragonball T uses its own 'magic' system handling
-- for the character, but the standard system for
-- monsters

function player.spell_chance_get_fails(stat)
	local fail_adj = 5
	local fail_min = 5
	return fail_adj, fail_min
end

-- Monster spells
load_spells("monster.lua")

