-- Dragonball T: AI for the External Missile Turret
-- Defenses of the RRA Supreme Headquarters

-- This ai allows the missile turrets to fire on the player 
-- even though they are encased in trees, and lack LOS

ai.new
{
	name	= "RRA_SHQ_EXT"
	state	=
	{
	}
	init	= function(monst, state)
	end
	exec	= function(m_idx, monst, state)
		if dball_data.rra_shq_ext == 0 then
			if distance(monst.fy, monst.fx, player.py, player.px) < 9 then
				if cave(player.py, player.px).feat ~= FEAT_SNOW then
					-- Handle fire directly so as to avoid LOS issues
					if monster(m_idx).flags[FLAG_AMMO] > 0 then
						message("The missile turret fires a missile at you")
						local ddamage, rrad = 30 + rng(1,100), 2
						project(m_idx, rrad, player.py, player.px, ddamage, dam.SHARDS, PROJECT_JUMP | PROJECT_HIDE | PROJECT_HIDE_BLAST | PROJECT_STOP | PROJECT_KILL | PROJECT_NO_REFLECT)
						monster(m_idx).flags[FLAG_AMMO] = monster(m_idx).flags[FLAG_AMMO] - 1
					end
				end
			end
			monst.ai_action = ai.action.REST
		end
	end
}
