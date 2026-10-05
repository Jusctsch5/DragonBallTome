-- Spaceport, from spaceport.map.

defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("R", "FLOOR", nil, "RACE_RADDITZ")
defineTile("d", "WALL")
defineTile("<", "UP_EARTH")
defineTile("V", "FLOOR", nil, "RACE_VEGITA")

startx = 14
starty = 6
endx = 14
endy = 6

return [[XXXXXXXXXXXXXXXXX
X...............X
X...............X
X...............X
X...........XXXXX
X...R.......X...X
X...........d.<.X
X...V.......X...X
X...........XXXXX
X...............X
X...............X
X...............X
XXXXXXXXXXXXXXXXX]]
