-- Turtles' lair, from DBT/data/maps/turtles.map.

defineTile(".", "MUD")
defineTile("X", "WALL")
defineTile("<", "UP_SEWER")
defineTile("w", "GLASS")
defineTile("d", "DOOR")
defineTile("S", "MUD", nil, "SPLINTER")
defineTile("L", "MUD", nil, "LEONARDO")
defineTile("M", "MUD", nil, "MICHAELANGELO")
defineTile("R", "MUD", nil, "RAPHAEL")
defineTile("D", "MUD", nil, "DONATELLO")

startx = 4
starty = 2
endx = 4
endy = 2

return [[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
X.......X.......X.......X.......XX
X.......X.......X.......X.......XX
X.......X.......X.......X.......XX
X.......X.......X.......X.......XX
XXXX.XXXXXXX.XXXXXXX.XXXXXXX.XXXXX
XXXX.............................X
XXXXXXXXXXXXX....................X
XXXXXXXXXXXXXXX..........LRMDS...X
X...XXXXXXXXXXXXX................X
X.X.X...XXXXXXXXXXX..............X
X.X.X.X.X...XXXXXXXXX............X
X.X.X.X.X.X.X...XXXXXXX..........X
X.X.X.X.X.X.X.X.X...XXXXX........X
X.X.X.X.X.X.X.X.X.X.X...XXXwX....X
X<X...X...X...X...X...X.....d....X
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]]
