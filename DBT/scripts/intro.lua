-- Dragonball T: Intro gong

local foo = date()
foo = strsub(foo, 16, 17)
foo = tonumber(foo)
if (not foo) then
	foo = 1
end

if foo < 21 then
	sound.load_sample("intro1")
	sound.play_sample("intro1")
elseif foo < 41 then
	sound.load_sample("intro2")
	sound.play_sample("intro2")
else
	sound.load_sample("intro3")
	sound.play_sample("intro3")
end


--	sound.load_sample("intro4")
--	sound.play_sample("intro4")
