-- dbt-generated-talk dialogue.GERO_REMOTE_STOP
-- Do not edit by hand.

newChat{ id=[=[n0]=],
	text = [=[Dr Gero: ]=] .. [=[Awake, my creation! Hahaha! I have some marvelous news for you. I have planted a remote controlled bomb inside your brain. From now on you will obey me, or I will press this little red button on this device here in my hand, and you will die! Hahahah! Oh, I suppose I should mention, unfortuantely I had to remove a rather large section of your brain to make room for the bomb. It's ok, you weren't using it. I've installed a powerful computer in its place, and downloaded your memories into it. You'll hardly notice the difference. So...my minion, are you ready to do my bidding?

]=],
	answers = {
		{[=[I hear and obey, master.]=], jump=[=[n0_a]=]},
		{[=[I...I shall do as you say...for now, but do not believe for a second that you have conquered me.]=], jump=[=[n0_b]=]},
		{[=[Never! (Attempt to rush him before he can activate the device)]=], jump=[=[n0_c]=]},
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_a]=],
	text = [=[Dr Gero: ]=] .. [=[Very good.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_b]=],
	text = [=[Dr Gero: ]=] .. [=[Hahahah! So be it. Now, let us get down to business.]=],
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_c]=],
	text = [=[Dr Gero: ]=] .. [=[*sigh* (He presses the button.) (Not implemented)]=],
	answers = {
		{"[Leave]"},
	},
}

return "n0"
