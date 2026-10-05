-- dbt-generated-talk dialogue.GOZMEZ_PAYUP
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	player.demon_comic_dialogue = 999
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		arm_n0(player)
		return [=[Goz: ]=] .. [=[YES!!! Ten seconds! Gimmee 1000 zeni!

]=] .. [=[Mez: ]=] .. [=[Darn it! Stupid human had to live. <sigh>

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
