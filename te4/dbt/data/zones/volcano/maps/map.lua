-- Volcano, from phoenix.map.

defineTile("#", "WALL")
defineTile("X", "LAVA_WALL")
defineTile(".", "LAVA")
defineTile("P", "SAND", nil, "RACE_PHOENIX")
defineTile("<", "UP_HOUSE")

startx = 28
starty = 10
endx = 28
endy = 10

return [[###############################
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXX#
#XXXXXXXXXX.........XXXXXXXXXX#
#XXXXXXX...............XXXXXXX#
#XXXXX...................XXXXX#
#XXXX.....................XXXX#
#XXX.......................XXX#
#XX.........XXXXXXX.........XX#
#XX........XX.....XX........XX#
#X.........X.......XX........X#
#X.........X...P............<X#
#X.........X.......XX........X#
#XX........XX.....XX........XX#
#XX.........XXXXXXX.........XX#
#XXX.......................XXX#
#XXXX.....................XXXX#
#XXXXX...................XXXXX#
#XXXXXXX...............XXXXXXX#
#XXXXXXXXXX.........XXXXXXXXXX#
#XXXXXXXXXXXXXXXXXXXXXXXXXXXXX#
###############################]]
