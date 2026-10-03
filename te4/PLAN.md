# ToME 4 slice plan

First milestone of the port onto Tales of Maj'Eyal 1.7.6. Engine package `te4-1.7.6`. The full game stays later work.

## Constraints

- New module only. `DBT/` stays the ToME 3 content source and is not edited. `.tome/` is runtime data and is not edited.
- Do not vendor the engine. The module runs inside a local 1.7.6 install.
- `engine = {1,7,6,"te4"}`. The example module's `{1,1,5,"te4"}` does not load on 1.7.6.
- `short_name` is `dbt`. Copy `te4/dbt` to `<ToME 1.7.6>/game/modules/dbt`.
- ASCII only.
- Melee is the engine bump-attack. Chi, enrollment, hunger, technomancy, and the ToME 3 combat scripts stay out.

## Work

- [x] Module skeleton from the 1.7.6 example. `init.lua` targets `te4-1.7.6`. A new game starts on Earth 1.
- [x] Birth is gender only: base body, Male, Female. Starter kit is street clothes, a kubotan, shoes (tennis shoes or high heels), and a note that this is the ToME 4 slice. PlayTest mode waits.
- [x] Earth 1 is a small outdoor map in the style of `DBT/data/maps/earth1.map`: grass, trees, road, water, a building, a few melee hostiles, and a down-stair. `DUNGEON_URANAI` is the `a` entrance on that map. The full wilderness and the full earth1 map wait.
- [x] Uranai Baba's house is the static floor from `DBT/data/maps/uranai.map`: walls, door, floor, up-stair. Swamp levels and the tentacle-demon quest stay out.
- [x] Uranai Baba is neutral. Her chat is the opening of `dialogue.URANAI_BABA`: she has had a lousy day and wants the guest gone. Quest branches stay out.
- [x] `te4/dbt/README.md` documents copy and launch: `t-engine.exe -Mdbt -uTester -n`.

## Out of scope

Custom combat, chi, enrollment, hunger, technomancy, PlayTest mode, the full Earth wilderness, the full earth1 map, Uranai's swamp levels, the tentacle-demon quest, and every other dungeon, map, and dialogue.

## Acceptance

- [x] New game, pick a gender, spawn on Earth 1.
- [x] Hit a hostile.
- [x] Take the stair into the house.
- [x] Talk to Uranai Baba.
- [x] Return upstairs.
- [x] Save and load.

Played on a local 1.7.6 install. Walking, killing, and the stairs into the house worked.
