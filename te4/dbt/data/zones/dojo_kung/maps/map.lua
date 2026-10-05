-- Kung Fu School, from DBT/data/maps/d_kung.map.

defineTile("*", "MAP_BORDER")
defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("m", "WALL")
defineTile("-", "CARPET_BLUE")
defineTile("a", "CARPET_BLUE", nil, "RACE_FONG_SAI_YUK")
defineTile("w", "WALL")
defineTile("d", "DOOR")
defineTile("L", "WALL")
defineTile("A", "SIGN_Supplies")
defineTile("B", "SIGN_Men_s_Changing_Room")
defineTile("C", "SIGN_Women_s_Changing_Room")
defineTile("<", "UP_DOJO")

startx = 26
starty = 18
endx = 26
endy = 18

return [[***********************************
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
*X.....X.mmmmmmmmmmmmmmmmmmmmm...X*
*X.......---------------------...X*
*X.....X.---------------------...X*
*XXX.XXX.-------------a-------...X*
*X-----..---------------------...X*
*X-----..---------------------...X*
*X-----..........................X*
*X-----....Xwww.wwwww.wwww.......X*
*X.---.....X.....................X*
*X.---.XXXdXXXXXXXXXXXXXXXX.XXXXXX*
*X-----..X.....X.......X..X.X....X*
*X-----.mX.....X.......X..LA.....X*
*X-----.mX.....X....XXXXXXX.X....X*
*X-----.mX.....X....X....d..XXXXXX*
*X-----.mXdXXXXXXXdXXwwwww..X....X*
*X-----...B.......C..............X*
*Xmmmmm..XXXXXXXXXXXX.....<.X....X*
*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*
***********************************]]
