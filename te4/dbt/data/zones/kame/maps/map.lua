-- Kame House, from DBT/data/maps/rosshi.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile("w", "GLASS")
defineTile(".", "FLOOR")
defineTile(",", "FLOOR")
defineTile("W", "FLOOR")
defineTile("c", "FURNITURE")
defineTile("+", "DOOR")
defineTile("=", "KAME_TV")
defineTile("q", "KAME_TV")
defineTile("a", "FLOOR", nil, "RACE_ROSSHI")
defineTile("t", "SIGN_a_toilet")
defineTile("p", "SIGN_there_seems_to_be_a_peephole_in_the_wall")
defineTile("C", "SIGN_a_kitchen_countertop")
defineTile("U", "FLOOR", nil, "RACE_UMIGAME")
defineTile("T", "SIGN_a_dinner_table")
defineTile("b", "SIGN_a_bed")
defineTile("R", "SIGN_a_refridgerator")
defineTile("<", "UP_EARTH")

startx = 10
starty = 11
endx = 10
endy = 11

return [[*********************
*XXXwwwXXXXXwwwXXXXX*
*X..,,,.W...,,,.X..X*
*X....c.W.......+..X*
*X=qa.c.W.......X..X*
*X....c.W.......X.tX*
*X......W.......X.pX*
*XXX...XX...XXX+XXXX*
*wCU....X...X.....pX*
*wC...TTX...X......X*
*X....TTX...X...bbbX*
*XR...TTX.<.X...bbbX*
*XXXXXXXXXXXXXXXwwwX*
*********************]]
