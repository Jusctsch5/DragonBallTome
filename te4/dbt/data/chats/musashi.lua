-- dialogue.MUSASHI. He will not speak to a fighter below 40 Weapons.
-- The line that makes him teach needs Charisma 17.

local function openTraining(player)
	player.musashi_student = true
	player.musashi_state = 2
	game:loadTraining()
	local Trainer = require "mod.dialogs.Trainer"
	game:registerDialog(Trainer.new("MUSASHI", player))
end

newChat{ id="welcome",
	text = function(npc, player)
		if player.musashi_student then
			return [[You have returned.]]
		end
		if (player.musashi_state or 0) == 0 then
			return [[You see an old, balding Japanese swordsman sitting in seiza. He is wearing a sword on either side of his waist, one short and one long, with the handles crossed in front of his stomahce.

His eyes are closed, and he is clearly in a deep, meditative state.]]
		end
		return [[You have returned once again to the meditative retreat of Miyamoto Musashi.

His eyes are closed, and he is clearly in a deep, meditative state.]]
	end,
	answers = {
		{"I wish to train.", action=openTraining, cond=function(npc, player) return player.musashi_student end},
		{"Wait.", jump="wait", cond=function(npc, player) return not player.musashi_student end},
		{"Wake him.", jump="wake", cond=function(npc, player) return not player.musashi_student end},
		{"Leave."},
	},
}

newChat{ id="wait",
	text = [[Time passes.]],
	answers = { {"Leave."} },
}

newChat{ id="wake",
	text = function(npc, player)
		if player:skillLevel("weapons") < 40 then
			return [[In the fraction of an instant after opening your mouth, but before any sound comes out, his eyes suddenly open. For about two seconds he looks you over, examining your body language.

Apparantly his conclusion is that you are not yet skilled enough even to bother speaking to: he closes his eyes without saying a word, and resumes his meditation.]]
		end
		if (player.musashi_state or 0) == 0 then
			return [[In the fraction of an instant after opening your mouth, but before any sound comes out, his eyes suddenly open. For about two seconds he looks you over, examining your body language.

Your posture is weak, and lacks discipline. I see no strength in your eyes. You appear worthless as a fighter. Why are you here?]]
		end
		return [[In the fraction of an instant after opening your mouth, but before any sound comes out, his eyes suddenly open. For about two seconds he looks you over, examining your body language.

You again?]]
	end,
	answers = {
		{"Just exploring. Sorry to bother you.", jump="shrug",
			cond=function(npc, player) return player:skillLevel("weapons") >= 40 and (player.musashi_state or 0) == 0 end},
		{"I would like to train with you.", jump="ten",
			cond=function(npc, player) return player:skillLevel("weapons") >= 40 end},
		{"Leave.", cond=function(npc, player) return player:skillLevel("weapons") < 40 end},
	},
}

newChat{ id="shrug",
	text = [[He shrugs, closes his eyes without a further word, and resumes his meditation.]],
	answers = { {"Leave.", action=function(npc, player) player.musashi_state = 1 end} },
}

newChat{ id="ten",
	text = function(npc, player)
		if (player.musashi_state or 0) == 0 then
			return [[And I would like to acheive enlightenment. Yet, I have been sitting here in this cave for ten years, attempting it. Perhaps I shall make you wait ten years before I train you?]]
		end
		return [[It has not been ten years. Why have you come?]]
	end,
	answers = {
		{"Ok. I'll come back in ten years.", action=function(npc, player) player.musashi_state = 1 end},
		{"I would prefer not to wait that long.", jump="nor"},
		{"(Persuade 17) You have sat here for ten years, and not gained enlightenment. Do you really wish to sit here for twenty, and not gain enlightenment?", jump="accept",
			cond=function(npc, player) return player:effStat("chr") >= 17 end},
	},
}

newChat{ id="nor",
	text = [[Nor would I.]],
	answers = { {"Leave.", action=function(npc, player) player.musashi_state = 1 end} },
}

newChat{ id="accept",
	text = [[Musashi considers that for a moment.

Very well. I will train you.]],
	answers = { {"Thank you.", action=openTraining} },
}

return "welcome"
