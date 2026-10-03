-- Opening of dialogue.URANAI_BABA when she has not been spoken to yet.
-- Quest branches stay out of this slice.

newChat{ id="welcome",
	text = [[Go away! I've had a lousy day and I don't feel like having uninvited guests!]],
	answers = {
		{"Oh. Sorry. (leave)"},
	},
}

return "welcome"
