-- Shooting Range, from d_marks.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("a", "FLOOR", nil, "RACE_CHARLETON")
defineTile("c", "FURNITURE")
defineTile("L", "WALL")
defineTile("<", "UP_EARTH")

startx = 7
starty = 11
endx = 7
endy = 11

return [[********************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X....a.......................X*
*X...c.c.c.c.c.c.c.c.c.c.c.c..X*
*X..cccccccccccccccccccccccccLX*
*X.cc.........................X*
*X..c.....XX..XX..XX..XX..XX..X*
*X.cc.....XX..XX..XX..XX..XX..X*
*X..c.....XX..XX..XX..XX..XX..X*
*X.cc.....XX..XX..XX..XX..XX..X*
*X..c.....XX..XX..XX..XX..XX..X*
*XXXX..<......................X*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
********************************]]
