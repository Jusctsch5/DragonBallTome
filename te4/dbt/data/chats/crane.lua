-- dialogue.CRANE_HERMIT. He takes a student after the white wolf is dead.

local function openTraining(player)
	player.crane_student = true
	player.crane_state = 2
	local q = player.quests and player.quests.white_wolf
	if q and q.status == "taken" then q.status = "completed" end
	game:loadTraining()
	local Trainer = require "mod.dialogs.Trainer"
	game:registerDialog(Trainer.new("CRANE_HERMIT", player))
end

newChat{ id="welcome",
	text = function(npc, player)
		if player.rosshi_student then
			return [[Ahhh...the student of my nemesis, Rosshi. Come to change over to the right side? No? Well, you are a fool. Rosshi's art is nothing compared to mine! May you suffer a lifetime of adequecy for your foolish decision to study with him. Hahahaha!!!]]
		end
		if player.crane_student then
			return [[You have returned. Shall we continue?]]
		end
		if (player.crane_state or 0) >= 1 then
			if player.white_wolf == "slain" then
				return [[Ahhh! You have slain the white wolf!

Yay! I'll order a pizza to celebrate!

You have proven your value to me as a student.]]
			end
			return [[Return to me after you have slain the white wolf!]]
		end
		return [[Ahhh...have you come to train with the great Tsuru Seni'nin? I am accepting students who are able to prove their worth to me.]]
	end,
	answers = {
		{"Train me.", action=openTraining, cond=function(npc, player) return player.crane_student end},
		{"What can you tell me about your style?", jump="style",
			cond=function(npc, player) return not player.rosshi_student and not player.crane_student and (player.crane_state or 0) < 1 end},
		{"Yes, I would like to train with you.", jump="prove",
			cond=function(npc, player) return not player.rosshi_student and not player.crane_student and (player.crane_state or 0) < 1 end},
		{"No, sorry. Just exploring the area.",
			cond=function(npc, player) return not player.rosshi_student and not player.crane_student and (player.crane_state or 0) < 1 end},
		{"I have slain the wolf.", action=openTraining,
			cond=function(npc, player) return not player.crane_student and (player.crane_state or 0) >= 1 and player.white_wolf == "slain" end},
		{"Leave.", cond=function(npc, player) return not (not player.crane_student and (player.crane_state or 0) >= 1 and player.white_wolf == "slain") end},
	},
}

newChat{ id="style",
	text = [[I teach the fighting style of the Crane! It is from the crane, most beautiful, that I have acquired my namesake: the Crane Hermit. Crane emphasizes grace and elegance over brute strength. Crane stylists often choose to study the weapon arts as well, as a sword is nothing more than an extension of one's own body, much like the elegant neck of the crane.]],
	answers = {
		{"Yes, I would like to study Crane style.", jump="prove"},
		{"Hmm. No, that sounds all well and good, but 'brute strength' is more my style."},
	},
}

newChat{ id="prove",
	text = [[I am pleased to hear it. But first you must prove your worth to me. Somewhere in the mountains near here there is a white wolf who has been preying upon travellers.

Including the pizza delivery man.

It is most distressing.

Especially if you're a pizza delivery man.

Do you have any idea how difficult it is to get Rusty's pizza kitchen to deliver out here?

Return to me after you have slain this beast and I will train you in the art of Crane.]],
	answers = {
		{"I'll find the wolf.", action=function(npc, player)
			player.crane_state = 1
			player:ensureQuests()
			player.quests.white_wolf = {
				name = "The White Wolf",
				desc = "Tsuru Seni'nin will teach Crane once you have slain the white wolf in the mountains.",
				status = player.white_wolf == "slain" and "completed" or "taken",
			}
		end},
	},
}

return "welcome"
