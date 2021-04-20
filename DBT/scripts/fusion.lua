--[[
-- Fusion handling
function dball.fusion(whom, m_idx)
	local r_ptr = r_info[whom]
	if r_ptr.flags[FLAG_FUSION_GAIN] then
		-- This is all we need to do.
		-- Fusion is handled in calc.lua
		dball_data.fusion = whom
	end
	player.calc_bonuses()

	-- Now delete the monster
	if m_idx and m_idx > 0 then
		delete_monster_idx(m_idx)
	else
		for_each_monster(function(m_idx, monst)
			if monst.r_idx == %whom then
				-- CAREFUL when calling this function!
				-- Fusions with generic monsters MUST specify m_idx
				-- or every instance of the monster will be removed!
				delete_monster_idx(m_idx)
			end
		end)
	end
end
function dball.fusioff()
	dball_data.fusion = 0
end
function dball.fusion_gain(which)
	if fusion_memory[which] == FLAG_FUSION_AB_UNKNOWN then
		fusion_memory[which] = FLAG_FUSION_AB_TEMP
		ability(which).hidden = false
		ability(which).acquired = true
	end
end
function dball.fusion_lose(which)
	if fusion_memory[which] == FLAG_FUSION_AB_TEMP then
		ability(which).hidden = true
		ability(which).acquired = false
	end
end
]]
