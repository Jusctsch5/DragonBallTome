-- Buddhist Temple, from DBT/data/maps/temple.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(">", "DOWN_HOUSE")
defineTile("D", "TEMPLE_LOCK")
defineTile("E", "TEMPLE_LOCK")
defineTile(".", "FLOOR")
defineTile("h", "FLOOR", nil, "RACE_MEDITATING_MONK")
defineTile(",", "FLOOR")
defineTile("i", "FLOOR", nil, "RACE_KRILLAN")
defineTile("+", "DOOR")
defineTile("|", "SIGN_This_old_lantern_provides_some_illuminat")
defineTile("-", "GRASS")
defineTile("T", "TREE")
defineTile("<", "UP_EARTH")

startx = 20
starty = 24
endx = 20
endy = 24

return [[*******************************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXX>DE.........X*
*XXXXXXXXXXXXXXXXXX...XXXXXXXXXXXXXXXXXX.X*
*XXXXXXXXXXXXXXXXX.XXX.XXXXXXXXXXXXXXXXX.X*
*X...XX...XX...XX.XXXXX.XX...XX...XX...X.X*
*X.h.XX...XX...XX.XXXXX.XX...XX...XX...X.X*
*X...XX...XX...X,,,i..,,,X...XX...XX...X.X*
*XX+XXXX+XXXX.XX,|,...,|,XX.XXXX+XXXX+XX.X*
*X..............,,,...,,,................X*
*XX+XXXX+XXXX+XX.........XX+XXXX+XXXX+XXXX*
*X...XX...XX...X,,,...,,,X...XX...XX...XXX*
*X...XX...XX.h.XX|,...,|XX.h.XX...XX.h.XXX*
*X...XX...XX...XX,,...,,XX...XX...XX...XXX*
*XXXXXXXXXXXXXXXXX.....XXXXXXXXXXXXXXXXXXX*
*X-------------XXX,...,XXX---------------X*
*X-------------XX|,...,|XX---T-----------X*
*X-----T----T--XXX,...,XXX---------------X*
*X--------------X.......X-------------T--X*
*X--------------+,,...,,+-----T----------X*
*X--------------X|,...,|X----------------X*
*X--T----------XXX,...,XXX---------T-----X*
*X--------T----XXX.....XXX---T-----------X*
*X-------------XXX.....XXX---------------X*
*XXXXXXXXXXXXXXXXXX.<.XXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*******************************************]]
