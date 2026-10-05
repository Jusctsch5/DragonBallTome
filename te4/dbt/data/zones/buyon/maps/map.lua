-- Buyon's Lair, from buyon.map.

defineTile("X", "WALL")
defineTile(".", "FLOOR")
defineTile("a", "FLOOR", nil, "RACE_BUYON")

startx = 12
starty = 1
endx = 12
endy = 1

return [[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXX.......XXXXXXXXXXX
XXXXXXX................XXXXXXX
XXXXX....................XXXXX
XXXX......................XXXX
XXX..........XXXXX.........XXX
XX.........XXXXXXXXX........XX
XX........XXXXXXXXXXX.......XX
X........XXXXXXXXXXXXX.......X
X........XXXXXXXXXXXXX.......X
X........XXXXXXXXXXXXX.......X
XX........XXXXXXXXXXX.......XX
XX.........XXXXXXXXX........XX
XXX..........XXXXX.........XXX
XXXX...........a..........XXXX
XXXXX....................XXXXX
XXXXXXX................XXXXXXX
XXXXXXXXXXXX.......XXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]]
