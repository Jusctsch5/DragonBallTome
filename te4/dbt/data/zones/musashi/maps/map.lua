-- Musashi's Cave, from DBT/data/maps/musashi.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "DIRT")
defineTile(".", "DIRT")
defineTile("<", "UP_EARTH")
defineTile("a", "DIRT", nil, "RACE_MUSASHI")

startx = 2
starty = 8
endx = 2
endy = 8

return [[*************************
*XXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXX.....XXXXXXXXXXX*
*XXXX...........XXXXXXXX*
*XXX....XX..........XXXX*
*XX....XX............XXX*
*X....XX...............X*
*X<..XXX...............X*
*X...XXXX.........a....X*
*XXXXXXXX..............X*
*XXXXXXXXXX............X*
*XXXXXXXXXXXX.........XX*
*XXXXXXXXXXXXXXXXXXXXXXX*
*XXXXXXXXXXXXXXXXXXXXXXX*
*************************]]
