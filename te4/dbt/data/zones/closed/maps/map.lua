-- Placeholder for a dungeon whose interior is not ported yet.
-- The up stair returns to the Earth entrance the player came from.

defineTile('#', "WALL")
defineTile('.', "FLOOR")
defineTile('<', "UP_EARTH")

startx = 1
starty = 2
endx = 1
endy = 2

return [[
#######
#.....#
#<....#
#.....#
#######]]
