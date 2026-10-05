-- Land of Karin, from lookout.map.

defineTile("*", "MAP_BORDER")
defineTile(" ", "SKY")
defineTile("c", "CLOUD")
defineTile(".", "FLOOR")
defineTile("T", "TREE")
defineTile("X", "WALL")
defineTile("K", "SIGN_The_entrance_is_impassable")
defineTile("p", "FLOOR", nil, "RACE_MR_POPO")
defineTile("<", "UP_HOUSE")

startx = 58
starty = 23
endx = 58
endy = 23

return [[******************************************************************************************************************
*                                                                                                                *
*                                                        ccc                                                     *
*                                                       ccccc                                                    *
*      ccc                                                cc                           cccc                      *
*     ccccc                                                                           ccccccc                    *
*       cc                                               ...                            ccc                      *
*                                                    ...........                                                 *
*                                                  ...............                                               *
*                                                ..T.X.XXXXXXX.X.T..                                             *
*                ccc                            ..T....XXXXXXX....T..                                            *
*               cccccc                         ..T...X.XXXXXXX.X...T..                                           *
*                 ccc                         ..T......TTXKXTT......T..                                          *
*                                             .........................                                          *
*                                            ..............p............                                         *
*                                            ...........................         ccc                             *
*                                             .........................         ccccc                            *
*                                             .T.....................T.           cc                   cc        *
* ccc                                          .T........T.T........T.                                ccccc      *
*ccccc                                          .T.......T.T.......T.                                   cc       *
*  cc                                            ..T.....T.T.....T..                                             *
*                                                  ..T...T.T...T..                                               *
*                                                    ...........       cc                                        *
*                            cc                          .<.          ccccc                                      *
*                           cccc                                        cc                                       *
*                            ccc                                                                                 *
*                                                                                                                *
******************************************************************************************************************]]
