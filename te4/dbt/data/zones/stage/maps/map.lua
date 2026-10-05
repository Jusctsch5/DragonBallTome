-- Stage, from stage.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("<", "UP_EARTH")
defineTile("g", "FLOOR", nil, "RACE_CUTE_LITTLE_GIRLMOUSE")
defineTile("b", "FLOOR", nil, "RACE_CUTE_LITTLE_BOYMOUSE")
defineTile("K", "FLOOR", nil, "RACE_KING_MOUSE")

startx = 14
starty = 2
endx = 14
endy = 2

return [[*****************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X............<............X*
*X.........................X*
*X.........................X*
*X....g...............g....X*
*X.........................X*
*X....g...............g....X*
*X.........................X*
*X....g...............b....X*
*X.........................X*
*X....g...............g....X*
*X............K............X*
*X.........................X*
*XXXXXXXXXXXXXXXXXXXXXXXXXXX*
*****************************]]
