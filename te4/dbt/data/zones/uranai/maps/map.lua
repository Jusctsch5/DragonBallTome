-- Uranai Baba's house, from the ToME 3 uranai.map.
-- The basement stair and tentacle-demon quest are not in this slice.

defineTile('*', "MAP_BORDER")
defineTile('X', "WALL")
defineTile('.', "FLOOR")
defineTile(',', "FLOOR_ALT")
defineTile('|', "LAMP")
defineTile('d', "DOOR")
defineTile('<', "UP_EARTH")
defineTile('a', "PLACARD")
defineTile('b', "FLOOR", nil, "URANAI_BABA")
defineTile('c', "FLOOR")

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
