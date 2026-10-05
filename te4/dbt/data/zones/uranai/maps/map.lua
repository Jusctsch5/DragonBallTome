-- Uranai Baba's house, from the ToME 3 uranai.map.
-- Tile c stays floor until the tentacle quest is taken, then it becomes the basement stair.

defineTile('*', "MAP_BORDER")
defineTile('X', "WALL")
defineTile('.', "FLOOR")
defineTile(',', "FLOOR_ALT")
defineTile('|', "LAMP")
defineTile('d', "DOOR")
defineTile('<', "UP_EARTH")
defineTile('a', "PLACARD")
defineTile('b', "FLOOR", nil, "URANAI_BABA")
defineTile('c', "URANAI_CELLAR")

startx = 10
starty = 2
endx = 10
endy = 2

return [[
********************
*XXXXXXXXXXXXXXXXXX*
*XXXXXXXXX<XXXXXXXX*
*XXXXXXXXX,XXXXXXXX*
*XXXXXXXXX,XXXXXXXX*
*XXXXXXXXX,aXXXXXXX*
*XXXXXXXXXdXXXXXXXX*
*X,,,..........,,,X*
*X,|,..........,|,X*
*X,,,..........,,,X*
*X................X*
*X........b.....c.X*
*X................X*
*X,,,..........,,,X*
*X,|,..........,|,X*
*X,,,..........,,,X*
*XXXXXXXXXXXXXXXXXX*
********************]]
