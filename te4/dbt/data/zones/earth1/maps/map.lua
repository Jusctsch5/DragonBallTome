-- Earth 1 outdoor slice. Grass, trees, road, water, a building, and the path to Uranai Baba.
-- Player start is grass west of the road. The down stair is on the road.

defineTile('.', "GRASS")
defineTile('=', "ROAD")
defineTile('T', "TREE")
defineTile('~', "WATER")
defineTile('^', "MOUNTAIN")
defineTile('#', "BUILDING")
defineTile('>', "DOWN_URANAI")
defineTile('w', "GRASS", nil, "WOLF")
defineTile('h', "GRASS", nil, "THUG")

startx = 8
starty = 7
endx = 13
endy = 7

return [[
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
^TTTTTT.....===..............TTTTTT^
^TTTTTT.....===..............TTTTTT^
^TTTTTT.....===..............TTTTTT^
^...........===.......#######......^
^...........===.......#######......^
^...........===.......#######......^
^...........=>=.......#######......^
^...........===....................^
^~~~~~~.....===....................^
^~~~~~~.....===.....w..............^
^~~~~~~.....===.................w..^
^~~~~~~.....===...............h....^
^~~~~~~.....===....................^
^...........===....................^
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^]]
