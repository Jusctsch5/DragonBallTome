-- Dr. Gero's Lab, from gerolair.map.

defineTile("*", "WALL")
defineTile("X", "WALL")
defineTile("c", "FLOOR", nil, "RACE_DEATH_ORB")
defineTile(".", "FLOOR")
defineTile("b", "FLOOR", nil, "RACE_WHIRLIGIG")
defineTile(">", "FLOOR")
defineTile("d", "FLOOR", nil, "RACE_EXTERMINATOR")
defineTile("a", "FLOOR", nil, "RACE_DR_GERO")
defineTile("D", "WALL")
defineTile("<", "UP_EARTH")

startx = 19
starty = 12
endx = 19
endy = 12

return [[***********************
*XXXXXXXXXXXXXXXXXXXXX*
*Xc.................cX*
*X..b....b.....b....>X*
*X..................cX*
*X.......XXXXXXXXXXXXX*
*Xd......X..b.......cX*
*X.a.....D...........X*
*Xd......X..b........X*
*X.......XXXXXXXXX...X*
*X..............cX...X*
*X..b...b....b...X...X*
*Xc.............cX.<.X*
*XXXXXXXXXXXXXXXXXXXXX*
***********************]]
