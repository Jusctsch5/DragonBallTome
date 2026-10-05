-- White Wolf's Cave, from DBT/data/maps/wolfcave.map.

defineTile("X", "DIRT")
defineTile(".", "DIRT")
defineTile("a", "DIRT", nil, "RACE_WHITE_WOLF")
defineTile(",", "SNOW")
defineTile("<", "UP_EARTH")

startx = 1
starty = 10
endx = 1
endy = 10

return [[XXXXXXXXXXXXXXXXXXXXXXX
XX....XXXXXXXXXXXXXXXXX
X.......XXXXXXXX...XXXX
X....XX.XXXXXX....a.XXX
XX.XXX..XXXX.........XX
XXXXX..XXXX..XXX....XXX
XXX,..XXXXXX..XXXXXXXXX
XX..XXXXXXXX..XXXX...XX
X,,XX..,..X..XXX......X
X,,,.,XXX...XXX.......X
X<,XXXXXXXXXXXX.......X
X,,,,XXXXXXXXXXX.....XX
XXXX,,.,...........XXXX
XXXXXXXXXXXXXXXXXXXXXXX]]
