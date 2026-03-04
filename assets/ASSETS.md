# Asset Manifest

The coding agent cannot see images — it relies on this file to know what assets exist
and how to use them. **Keep this file updated whenever you add or remove assets.**

For each asset, provide:
- **Path**: relative to project root (e.g., `assets/sprites/player.png`)
- **What it depicts**: describe it plainly
- **Dimensions**: width × height in pixels
- **Sprite sheet info** (if applicable): frame size, columns (hframes), rows (vframes)
- **Intended role**: what it should be used for in a prototype

---

## Sprites

_No sprites yet. Drop .png files into `assets/sprites/` and describe them here._

<!--
Example entry — copy and fill in:

### player_idle.png
- **Path**: `assets/sprites/player_idle.png`
- **Depicts**: 32×32 pixel art knight, idle stance, facing right
- **Dimensions**: 32×32 (single frame)
- **Role**: Player character, idle state

### player_run.png
- **Path**: `assets/sprites/player_run.png`
- **Depicts**: 32×32 pixel art knight running right, 6 frames
- **Dimensions**: 192×32 (6 columns × 1 row)
- **Frame size**: 32×32, hframes: 6, vframes: 1
- **Role**: Player character, run animation

### enemy_slime.png
- **Path**: `assets/sprites/enemy_slime.png`
- **Depicts**: 24×24 green slime, 4-frame bounce loop
- **Dimensions**: 96×24 (4 columns × 1 row)
- **Frame size**: 24×24, hframes: 4, vframes: 1
- **Role**: Basic enemy
-->

## Tilesets

_No tilesets yet. Drop tileset .png files into `assets/tilesets/` and describe them here._

<!--
Example entry:

### dungeon_tiles.png
- **Path**: `assets/tilesets/dungeon_tiles.png`
- **Depicts**: Dungeon tileset — stone walls, floors, doors, torches
- **Dimensions**: 160×160 (10×10 grid)
- **Tile size**: 16×16
- **Layout**:
  - Row 0: floor variants (stone, dirt, cracked)
  - Row 1: wall tops and faces
  - Row 2: doors (open, closed), crates, barrels
  - Row 3: decoration (torches, moss, bones)
- **Role**: TileMap source for dungeon/cave prototypes
-->

## Audio

_No audio yet. Drop .wav or .ogg files into `assets/audio/` and describe them here._

<!--
Example entry:

### jump.wav
- **Path**: `assets/audio/jump.wav`
- **Description**: Short 8-bit jump sound, ~0.2s
- **Role**: Player jump SFX

### hit.ogg
- **Path**: `assets/audio/hit.ogg`
- **Description**: Punchy impact sound, ~0.3s
- **Role**: Damage/collision SFX

### music_loop.ogg
- **Path**: `assets/audio/music_loop.ogg`
- **Description**: Upbeat chiptune loop, ~30s, seamlessly loopable
- **Role**: Background music
-->
