-- Fencing School, from DBT/data/maps/d_fence.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(",", "FLOOR")
defineTile("-", "CARPET_GREEN")
defineTile("d", "DOOR")
defineTile(".", "FLOOR")
defineTile("<", "UP_DOJO")
defineTile("w", "WALL")
defineTile("a", "FLOOR", nil, "RACE_JACQUE")

startx = 2
starty = 6
endx = 2
endy = 6

return [[***************************
*XXXXXXXXXXXXXXXXXXXXXXXXX*
*X,,,,,X-----------------X*
*X,,,,,d-...............-X*
*X,,,,,X-...............-X*
*XXXXXXX-...............-X*
*X<X,,,w-....a..........-X*
*X,X,,,w-...............-X*
*X,X,,,w-...............-X*
*X,XX,XX-...............-X*
*X,,,,,d-----------------X*
*XXXXXXXXXXwwwwwwwwwwwwXXX*
*XXXXXXXXXX............XXX*
*XXXXXXXXXX............XXX*
*XXXXXXXXXXXXXXXXXXXXXXXXX*
***************************]]
