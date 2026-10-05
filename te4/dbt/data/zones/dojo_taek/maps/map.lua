-- Tae Kwon Do, from d_taek.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile("m", "WALL")
defineTile(".", "FLOOR")
defineTile("-", "CARPET_BLUE")
defineTile("a", "CARPET_BLUE", nil, "RACE_MASTER_LEE")
defineTile("w", "GLASS")
defineTile("<", "UP_EARTH")

startx = 10
starty = 16
endx = 10
endy = 16

return [[******************
*XXXXXXXXXXXXXXXX*
*Xm.............X*
*Xm........X.X..X*
*XmXXXXXXXXX.XXXX*
*Xm-------------X*
*Xm-------------X*
*Xm-------------X*
*Xm--a----------X*
*Xm-------------X*
*Xm-------------X*
*Xm-------------X*
*Xm---------X---X*
*XXwwwwww...XXXXX*
*X..........X...X*
*X..............X*
*X........<.X...X*
*XXXXXXXXXXXXXXXX*
******************]]
