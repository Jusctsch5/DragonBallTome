# ToME 4 port plan

Port the playable ToME 3 game onto engine `te4-1.7.6`. Each phase stays launchable. Unfinished ToME 3 stubs stay stubs.

The slice in `te4/dbt` is phase 0 and is done: gender birth, a small Earth 1 map, bump melee, Uranai Baba's house, her opening line, save and load.

## Constraints

- New module only. `DBT/` is the content source and is not edited. `.tome/` is runtime data and is not edited.
- Do not vendor the engine. `engine = {1,7,6,"te4"}`. `short_name` is `dbt`.
- ASCII is the default display. The game boots and is playable with no sprite files present.
- Music and effects use the samples that already ship with Dragonball T. Do not add a new soundtrack.
- Do not write the quests and dialogues marked "Implement me" in `DBT/todo.txt`.

## Options

One module options screen, stored in the save and in `config.settings.dbt`:

- Tiles: off by default. On uses `resources/dbz.png` and `resources/blasts.png` when those files exist. If either file is missing, Tiles stays off and the game stays ASCII.
- Music: on by default.
- Effects: on by default.

Both audio options follow a volume slider. Off, or volume 0, plays nothing. A missing sample is skipped. It does not error.

Tiles and audio are independent. ASCII with sound is valid. Tiles with sound off is valid.

## Audio

There is no music folder. `DBT/media/music/music.lua` only turns ambient music on and leaves the battle track commented out. Startup "music" is the three intro samples, chosen the same way as `DBT/scripts/intro.lua` (`intro1`, `intro2`, `intro3`).

Effects to port, from `DBT/media/sound/sound.lua` and the calls in `DBT/scripts/`:

- `intro1`, `intro2`, `intro3` at game start
- `gong` in the tournament
- `kintocall` for the Flying Nimbus
- `ominous` on the zones that already play it
- `dbbwarp` and `radarblip` on the warp and radar events
- `smash` when a blow connects
- `bird1` only if a call site exists; the file is in the runtime module and is not loaded by `sound.lua`

Samples live in the runtime module (`.tome/3.0/modules/dbt/media/sound/`), not under `DBT/media/sound/` except `sound.lua`. Copy them into `te4/dbt/data/sound/` as part of this port.

## Tiles

`resources/` is gitignored. `dbz.png` is a character sprite sheet. `blasts.png` is a ki-blast sheet. Both are third-party and stay optional.

- Slice the sheets into `te4/dbt/data/gfx/` only when Tiles is implemented. Do not require them to launch.
- Assign images on actors, terrains, and blasts. With Tiles off, those entities keep their ASCII `display`.
- The options toggle flips `Map.tiles.use_images` and reloads the current map. The choice survives save and load.

## Work

### 1. Options, sound, tile switch

- [ ] Options screen: Tiles, Music, Effects, both volumes.
- [ ] Intro samples play on a new game when Music is on.
- [ ] `smash` plays on a melee hit when Effects are on.
- [ ] Tiles on with both sheets present shows sprites. Tiles on with a sheet missing stays ASCII. Tiles off stays ASCII.
- [ ] Turning a channel off mid-game silences it. Save and load keep the settings.

### 2. Earth you can travel

- [ ] Replace the sample outdoor map with the real Earth maps (`DBT/data/maps/earth1.map` through `earth9.map`, plus the town maps those link to).
- [ ] A converter from ToME 3 `.map` files to ToME 4 static maps. Hand-fix scripts the converter cannot carry.
- [ ] Dungeon entrances on those maps change zone. Return stairs come back to the entrance tile.
- [ ] Save and load keep every visited Earth zone.

### 3. Inventory and the early item set

- [ ] Pickup, drop, wear, take off. Birth kit is real worn objects, not a side table.
- [ ] Early Earth stores and the items they actually sell.
- [ ] Identification and ego items wait until a shop or drop needs them.

### 4. Stats and combat

- [ ] Stats from the ToME 3 base descriptor: Strength, Intelligence, Willpower, Dexterity, Constitution, Charisma, Speed.
- [ ] Barehand, weapon, and firearm from `DBT/scripts/combat.lua`, as engine attacks.
- [ ] Hostile AI still closes and strikes. Armor and the kubotan change the numbers.

### 5. Trainers

- [ ] Skills are not bought at level-up. The birth rule stays: find a trainer.
- [ ] Enrollment from `DBT/scripts/enroll.lua` for the trainers that exist on early Earth.
- [ ] A trained skill changes combat or chi. An untrained skill does not.

### 6. Chi

- [ ] Chi as hotkeyed talents, from `DBT/data/magic/chi_constant.lua` and the spells the early game actually grants.
- [ ] A blast uses a frame from `blasts.png` only when Tiles is on. ASCII uses a projectile glyph.
- [ ] Fusion waits until both chi and the fusion quests are in.

### 7. Implemented Earth content

- [ ] Dialogues that do something. Functions that only say "Implement me" stay a one-line refusal.
- [ ] Uranai's implemented branches, the dojo quests, the tournament (including the gong), Rosshi, and the temple, in that order.
- [ ] Quest state saves.

### 8. The rest of the implemented world

- [ ] Remaining dungeon types in `DBT/data/dungeon/dungeons.lua` (52 `define_as` entries) and the special maps under `DBT/data/maps/`.
- [ ] Towns beyond Earth: Namek, Planet 79, Plant, Kaio, Babidi.
- [ ] Quest files that already have a status machine: `gero`, `namek`, `ninja`, `evil`, `endgame`, `timetravel`, `challenge`, `briefs`, `uniques`, `misc`, `chi`.
- [ ] Party, hunger, throwing, technomancy, firearms beyond the basic attack, and wishes, each only where the ToME 3 code runs.

## Out of scope

- Finishing `DBT/todo.txt` (Kami, the Freeza tree, Buu, Babidi's ship, and the other lines marked not implemented).
- A new soundtrack. The commented `battle101` track is not in the repo.
- Requiring `resources/dbz.png` or `resources/blasts.png` to start the game.
- Editing `DBT/` or vendoring T-Engine.

## Acceptance

- [ ] A new ASCII game, with the sprite sheets absent, can be played through the content the ToME 3 module actually implements.
- [ ] Music plays an intro sample. Effects play on their events. Each channel can be turned off without a restart.
- [ ] Tiles can be turned on when both sheets exist, and turned off again. A missing sheet does not crash.
- [ ] Save and load keep the character, quests, zone, and the three options.
