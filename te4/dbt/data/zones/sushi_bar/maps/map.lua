-- Sushi Bar, from sushi.map.

defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("<", "UP_EARTH")
defineTile("w", "GLASS")
defineTile("a", "FLOOR", nil, "RACE_AKIRA")
defineTile("b", "FLOOR")

startx = 9
starty = 1
endx = 9
endy = 1

return [[XXXXXXXXXXXXXXXXXX
X........<.......X
X................X
X................X
X................X
X......wwwwwwwwwwX
X...........a....X
X......X.b.b.b.b.X
XXXXXXXXXXXXXXXXXX]]
