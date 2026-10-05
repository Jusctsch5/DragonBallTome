-- dbt-generated-talk dialogue.KAIO_JOKE_CHECK
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = "...",
	answers = {
		{[=[I don't know any jokes.]=], jump=[=[n0_a]=]},
		{[=[...]=], jump=[=[n0_a]=]},
		{"[Leave]"},
	},
}

local shown_n0_a = nil
local function arm_n0_a(player)
	if shown_n0_a ~= nil then return shown_n0_a end
	if not (player.quests and player.quests.kaio_laugh) then
		player:takeQuest("kaio_laugh", "taken")
		player.kaio_state = 2
		player.trainers = player.trainers or {}
				player.trainers.NORTH_KAIO = true
				if dbt_schools and dbt_schools.NORTH_KAIO then
					game:loadTraining()
					local Trainer = require "mod.dialogs.Trainer"
					game:registerDialog(Trainer.new("NORTH_KAIO", player))
				end
		shown_n0_a = [=[1]=]
		return shown_n0_a
	end
	shown_n0_a = [=[]=]
	return shown_n0_a
end
newChat{ id=[=[n0_a]=],
	text = function(npc, player)
		local which = arm_n0_a(player)
		if which == [=[1]=] then return [=[The North Kaio: ]=] .. [=[I don't know.

]=] .. (player.name or "you") .. [=[: ]=] .. [=[The North Kaio: ]=] .. [=[Pffff...hmm....hehe....hahaahaha!!! That's hilarious! Hahahaha!

]=] .. (player.name or "you") .. [=[: ]=] .. [=[Heh. I'm glad you liked it. So, you'll train me now?

]=] .. [=[The North Kaio: ]=] .. [=[Absolutely!

]=] end
		if which == [=[]=] then return [=[The North Kaio: ]=] .. [=[Well, I won't train you until you make me laugh.

]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
