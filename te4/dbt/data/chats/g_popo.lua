-- dbt-generated-talk dialogue.POPO
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if (player.popo_state or 0) == 0 then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if (player.popo_state or 0) == 1 then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	if (player.popo_state or 0) == 2 then
		shown_n0 = [=[3]=]
		return shown_n0
	end
	if (player.popo_state or 0) == 3 then
		shown_n0 = [=[4]=]
		return shown_n0
	end
	if (player.popo_state or 0) == 4 then
		shown_n0 = [=[5]=]
		return shown_n0
	end
	if (player.popo_state or 0) == 999 then
		shown_n0 = [=[6]=]
		return shown_n0
	end
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[...]=] end
		if which == [=[2]=] then return [=[Mr. Popo: ]=] .. (player.name or "you") .. [=[ come back?

]=] end
		if which == [=[3]=] then return [=[Mr. Popo: ]=] .. (player.name or "you") .. [=[ not defeat Mr. Popo.

]=] end
		if which == [=[4]=] then return [=[...]=] end
		if which == [=[5]=] then return [=[Mr. Popo: ]=] .. [=[Hello ]=] .. (player.name or "you") .. [=[.

]=] end
		if which == [=[6]=] then return [=[Mr. Popo: ]=] .. [=[You are bad. You go away.]=] end
		return "..."
	end,
	answers = {
		{[=[Don't mind me. I'm just here to enjoy the garden.]=], jump=[=[n0_g1_a]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[I would like to challenge you to a duel.]=], jump=[=[n0_g1_b]=], cond=function(npc, player) return arm_n0(player) == [=[2]=] end},
		{[=[Hello, Mr. Popo. Nice to see you again.]=], jump=[=[n0_g4_a]=], cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{[=[Would you train with me?]=], jump=[=[n0_g4_b]=], action=function(npc, player) player.trainers = player.trainers or {} 		player.trainers.POPO = true 		if dbt_schools and dbt_schools.POPO then 			game:loadTraining() 			local Trainer = require "mod.dialogs.Trainer" 			game:registerDialog(Trainer.new("POPO", player)) 		end end, cond=function(npc, player) return arm_n0(player) == [=[5]=] end},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_a]=],
	text = [=[Mr. Popo: ]=] .. [=[Mr. Popo not mind.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g1_b]=],
	text = [=[Mr. Popo: ]=] .. [=[Ok. Mr. Popo accept. Fight when you ready.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_a]=],
	text = [=[Mr. Popo: ]=] .. [=[Mr Popo not mind.

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g3_b = nil
local function arm_n0_g3_b(player)
	if shown_n0_g3_b ~= nil then return shown_n0_g3_b end
	player.trainers = player.trainers or {}
			player.trainers.POPO = true
			if dbt_schools and dbt_schools.POPO then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("POPO", player))
			end
	shown_n0_g3_b = [=[]=]
	return shown_n0_g3_b
end
newChat{ id=[=[n0_g3_b]=],
	text = function(npc, player)
		arm_n0_g3_b(player)
		return [=[Mr. Popo: ]=] .. [=[Mr Popo help you.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g3_c]=],
	text = [=[Mr. Popo: ]=] .. [=[Mr Popo not believe you. But Mr Popo appreciate diligence.

]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g4_a]=],
	text = function(npc, player)
		return [=[Mr. Popo: ]=] .. [=[Nice see you too ]=] .. (player.name or "you")
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g4_b = nil
local function arm_n0_g4_b(player)
	if shown_n0_g4_b ~= nil then return shown_n0_g4_b end
	player.trainers = player.trainers or {}
			player.trainers.POPO = true
			if dbt_schools and dbt_schools.POPO then
				game:loadTraining()
				local Trainer = require "mod.dialogs.Trainer"
				game:registerDialog(Trainer.new("POPO", player))
			end
	shown_n0_g4_b = [=[]=]
	return shown_n0_g4_b
end
newChat{ id=[=[n0_g4_b]=],
	text = function(npc, player)
		local which = arm_n0_g4_b(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
