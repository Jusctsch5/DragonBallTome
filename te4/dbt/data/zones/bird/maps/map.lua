-- Bird Cave, from birdcave.map.

defineTile("X", "DIRT")
defineTile(".", "DIRT")
defineTile("a", "DIRT", nil, "RACE_HIKUI_BIRD")
defineTile("<", "TO_frypan")

startx = 2
starty = 18
endx = 2
endy = 18

return [[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXX....XXXXXXXXXXX......XXXX
XXXXX.........XXXXXXX..........XX
XXX..........XXXXXX.........a...X
XX..........XXXX................X
XXXX....XXXXXXX..XX.............X
XXXXXXX...XXXXXX..XXXXXX.......XX
XXXXXXXXX.....XXX..XXXX.......XXX
XXX...XXX..XX..XXX.XXX...XXXXXXXX
XX..X..XXX..XX.....XXX.XXXX....XX
X..XXX.XXXX..XXXXXXXXX..XX..XX..X
X.XXXX..XXXX..XXXXXXXXX....X...XX
X..XXXX...XX..XXXXXXXXXXX.X..XXXX
XX..XXXXX....XXX.......XXXXX...XX
XXX..XXXXXXXXX..........XXXXXX..X
XXX..XXXXXXX.............XXXXXX.X
XX..XXXXXXX................XXX..X
X.......XXX..X.........XX..XX..XX
X.<...X..X..XXXXX.....XXXX....XXX
X...XXXX...XXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]]
