-- dbt-generated-talk dialogue.YAMCHA
-- Do not edit by hand.

local shown_n0 = nil
local function arm_n0(player)
	if shown_n0 ~= nil then return shown_n0 end
	if true then
		shown_n0 = [=[1]=]
		return shown_n0
	end
	if true then
		shown_n0 = [=[2]=]
		return shown_n0
	end
	player.yamcha_state = 1
	shown_n0 = [=[]=]
	return shown_n0
end
newChat{ id=[=[n0]=],
	text = function(npc, player)
		local which = arm_n0(player)
		if which == [=[1]=] then return [=[Yamcha: ]=] .. [=[Hello, traveller. Allow me to introduce myself. I am Yamcha, lone hyena of the desert. This desert. My desert. And you have trespassed on my land. If you wish to live, then hand over all your money and any capsules you have and I will allow you to leave in peace.

]=] end
		if which == [=[2]=] then return [=[Yamcha is far more interested in leaving than chatting.]=] end
		if which == [=[]=] then return [=[Yamcha: ]=] .. [=[Ahhh....hello! Welcome to my desert home, good sir! As you can - OH NO!!! It's one of THEM!!! 

]=] .. [=[AAAAAAARRRRRRRGGGGHHHHH!!!!!! HELP! HELP! HELP!!!! EEEK!!! AAAHHHH!!!

]=] .. [=[He runs off, screaming. You look behind you, but you don't see anything out of the ordinary. How very strange.

]=] .. [=[Yamcha: ]=] .. [=[Aaaarrrrrggghhhhh!!!]=] .. [=[Yamcha: ]=] .. [=[Hayaaaaa!!!]=] .. [=[Hey buddy!]=] .. [=[Yamcha: ]=] .. [=[Hmm? What do you want? Go away, I have stuff to do.

]=] end
		return "..."
	end,
	answers = {
		{[=[I'm sorry. I have neither money nor capsules to give you.]=], jump=[=[n0_g0_e]=], action=function(npc, player) player.yamcha_state = 1 end, cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Wait...are you trying to rob me?]=], jump=[=[n0_g0_b]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[No, I don't think so.]=], jump=[=[n0_g0_c]=], cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{[=[Enough of this. (Attack!)]=], jump=[=[n0_g0_d]=], action=function(npc, player) player.yamcha_state = 2 end, cond=function(npc, player) return arm_n0(player) == [=[1]=] end},
		{"[Leave]"},
	},
}

local shown_n0_g0_a = nil
local function arm_n0_g0_a(player)
	if shown_n0_g0_a ~= nil then return shown_n0_g0_a end
	player.yamcha_state = 1
	shown_n0_g0_a = [=[]=]
	return shown_n0_g0_a
end
newChat{ id=[=[n0_g0_a]=],
	text = function(npc, player)
		arm_n0_g0_a(player)
		return [=[You give Yamcha all of your money and capsules.

]=] .. [=[Yamcha: ]=] .. [=[Very good. Thank you. It was a pleasure doing business with you.

]=] .. [=[Puar: ]=] .. [=[Come again, soon!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b]=],
	text = [=[Puar: ]=] .. [=[This one's not very bright, is he, Yamcha?

]=] .. [=[Yamcha: ]=] .. [=[Doesn't look that way. No, I'm not 'trying' to rob you. I AM robbing you. Now hand it over. I don't want to have to hurt you.

]=],
	answers = {
		{[=[Oh. Ok, then. I'm not looking for trouble. Here you go.]=], jump=[=[n0_g0_b_a]=], action=function(npc, player) player.yamcha_state = 1 end},
		{[=[But I don't really want to give you anything. Why don't you two find a better way to make money?]=], jump=[=[n0_g0_b_b]=]},
		{[=[I'm not giving you a thing, and you two don't look strong enough to take it.]=], jump=[=[n0_g0_b_c]=], action=function(npc, player) player.yamcha_state = 2 end},
		{"[Leave]"},
	},
}

local shown_n0_g0_b_a = nil
local function arm_n0_g0_b_a(player)
	if shown_n0_g0_b_a ~= nil then return shown_n0_g0_b_a end
	player.yamcha_state = 1
	shown_n0_g0_b_a = [=[]=]
	return shown_n0_g0_b_a
end
newChat{ id=[=[n0_g0_b_a]=],
	text = function(npc, player)
		arm_n0_g0_b_a(player)
		return [=[You give Yamcha all of your money and capsules.

]=] .. [=[Yamcha: ]=] .. [=[Very good. Thank you. It was a pleasure doing business with you.

]=] .. [=[Puar: ]=] .. [=[Come again, soon!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b]=],
	text = [=[Yamcha: ]=] .. [=[Why? What's wrong with banditry? It suits my schedule. Gives me lots of time to think.

]=] .. [=[Puar: ]=] .. [=[Yep! And it's fun!

]=] .. [=[Yamcha: ]=] .. [=[Right! So hand it over!

]=] .. [=[Puar: ]=] .. [=[Yeah! Or else!

]=],
	answers = {
		{[=[Ok, you win. Here you go.]=], jump=[=[n0_g0_b_b_a]=], action=function(npc, player) player.yamcha_state = 1 end},
		{[=[No, sorry guys. I just don't feel intimidated by you two.]=], jump=[=[n0_g0_b_b_b]=]},
		{"[Leave]"},
	},
}

local shown_n0_g0_b_b_a = nil
local function arm_n0_g0_b_b_a(player)
	if shown_n0_g0_b_b_a ~= nil then return shown_n0_g0_b_b_a end
	player.yamcha_state = 1
	shown_n0_g0_b_b_a = [=[]=]
	return shown_n0_g0_b_b_a
end
newChat{ id=[=[n0_g0_b_b_a]=],
	text = function(npc, player)
		arm_n0_g0_b_b_a(player)
		return [=[You give Yamcha all of your money and capsules.

]=] .. [=[Yamcha: ]=] .. [=[Very good. Thank you. It was a pleasure doing business with you.

]=] .. [=[Puar: ]=] .. [=[Come again, soon!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_b_b_b]=],
	text = [=[Puar: ]=] .. [=[Not intimidated? But...I'm scary! Raaawwwwrrr!!! Quick, Yamcha! Grab his stuff whie he's cowering in terror!

]=],
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_b_c = nil
local function arm_n0_g0_b_c(player)
	if shown_n0_g0_b_c ~= nil then return shown_n0_g0_b_c end
	player.yamcha_state = 2
	shown_n0_g0_b_c = [=[]=]
	return shown_n0_g0_b_c
end
newChat{ id=[=[n0_g0_b_c]=],
	text = function(npc, player)
		arm_n0_g0_b_c(player)
		return [=[Yamcha: ]=] .. [=[Well, then. Let's find out, shall we?

]=] .. [=[Puar: ]=] .. [=[Rob him blind, Yamcha!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

newChat{ id=[=[n0_g0_c]=],
	text = [=[Yamcha: ]=] .. [=[You don't 'think' so? Well then, I suggest you stop thinking so much, and start handing stuff over. Or else I'm gonna take it. It's up to you.

]=] .. [=[Puar: ]=] .. [=[Yeah! Don't mess with us! We're tough!

]=],
	answers = {
		{[=[Bring it on.]=], jump=[=[n0_g0_c_a]=], action=function(npc, player) player.yamcha_state = 2 end},
		{[=[Ahhh...ok, I don't want any trouble. Here you go.]=], jump=[=[n0_g0_c_b]=], action=function(npc, player) player.yamcha_state = 1 end},
		{"[Leave]"},
	},
}

local shown_n0_g0_c_a = nil
local function arm_n0_g0_c_a(player)
	if shown_n0_g0_c_a ~= nil then return shown_n0_g0_c_a end
	player.yamcha_state = 2
	shown_n0_g0_c_a = [=[]=]
	return shown_n0_g0_c_a
end
newChat{ id=[=[n0_g0_c_a]=],
	text = function(npc, player)
		arm_n0_g0_c_a(player)
		return [=[Yamcha: ]=] .. [=[Ahh...pity.

]=] .. [=[Puar: ]=] .. [=[They sure don't make victims like they used to, huh Yamcha?

]=] .. [=[Yamcha: ]=] .. [=[Nope. Guess not. Hyyyaaa!!!

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_c_b = nil
local function arm_n0_g0_c_b(player)
	if shown_n0_g0_c_b ~= nil then return shown_n0_g0_c_b end
	player.yamcha_state = 1
	shown_n0_g0_c_b = [=[]=]
	return shown_n0_g0_c_b
end
newChat{ id=[=[n0_g0_c_b]=],
	text = function(npc, player)
		arm_n0_g0_c_b(player)
		return [=[You give Yamcha everything you have of value.]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_d = nil
local function arm_n0_g0_d(player)
	if shown_n0_g0_d ~= nil then return shown_n0_g0_d end
	player.yamcha_state = 2
	shown_n0_g0_d = [=[]=]
	return shown_n0_g0_d
end
newChat{ id=[=[n0_g0_d]=],
	text = function(npc, player)
		local which = arm_n0_g0_d(player)
		if which == [=[]=] then return [=[...]=] end
		return "..."
	end,
	answers = {
		{"[Leave]"},
	},
}

local shown_n0_g0_e = nil
local function arm_n0_g0_e(player)
	if shown_n0_g0_e ~= nil then return shown_n0_g0_e end
	player.yamcha_state = 1
	shown_n0_g0_e = [=[]=]
	return shown_n0_g0_e
end
newChat{ id=[=[n0_g0_e]=],
	text = function(npc, player)
		arm_n0_g0_e(player)
		return [=[Yamcha: ]=] .. [=[Oh? Wandering the desert with nothing? Puar, check him out.

]=] .. [=[Puar: ]=] .. [=[Yes, Yamcha!

]=] .. [=[(Puar flies over and quickly looks through your belongings.

]=] .. [=[Puar: ]=] .. [=[He's telling the truth. Nothing that we want.

]=] .. [=[Yamcha: ]=] .. [=[Hmm. Ok. You may go.

]=]
	end,
	answers = {
		{"[Leave]"},
	},
}

return "n0"
