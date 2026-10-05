-- dialogue.ABBOT, once the ringleader is dead. He teaches after the temple is safe.

local function openTraining(player)
	player.abbot_student = true
	local q = player.quests and player.quests.temple
	if q and q.status == "completed" then q.status = "finished" end
	game:loadTraining()
	local Trainer = require "mod.dialogs.Trainer"
	game:registerDialog(Trainer.new("ABBOT", player))
end

newChat{ id="welcome",
	text = function(npc, player)
		if player.abbot_student then
			return [[You have returned. Shall we continue?]]
		end
		local q = player.quests and player.quests.temple
		if q and (q.status == "completed" or q.status == "finished") then
			return [[Ahh...the situation has resolved itself, I see. Excellent.

You are not a monk of this temple. Still, you have done us a service. I will teach you, if you wish to learn.]]
		end
		return [[No? Then why have you released me? I gave explicit instruction that I was to be kept here until the situation was resolved. If it is not, then I must resume my meditations.]]
	end,
	answers = {
		{"Teach me.", action=openTraining, cond=function(npc, player)
			if player.abbot_student then return true end
			local q = player.quests and player.quests.temple
			return q and (q.status == "completed" or q.status == "finished")
		end},
		{"I'll deal with them.", cond=function(npc, player)
			local q = player.quests and player.quests.temple
			return not player.abbot_student and not (q and (q.status == "completed" or q.status == "finished"))
		end},
		{"Leave."},
	},
}

return "welcome"
