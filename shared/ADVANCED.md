# Advanced Prototype Guide

Read this when the user says **"Build a game:"**. This mode is for prototypes with
multiple interacting systems (RTS, sim, roguelike, etc.) that need more structure
than a single scene and a couple of scripts.

**The same core rule still applies: work incrementally.** But the increments are
larger — one system at a time instead of one file at a time.

---

## Workflow: System-by-System

**The game must be playable (or at least runnable) after EVERY system you add.**
Never write 10 scripts before testing. The loop is:

1. **Outline the systems** — List 4-8 core systems in 1-2 sentences each.
   Show this to the user before writing code. Ask if the breakdown looks right.
2. **Build System 1** — Write its scripts and scenes. Validate. Tell the user to test.
3. **Build System 2** — Wire it into what exists. Validate. Test.
4. **Repeat** until all core systems are in.
5. **Tuning pass** — Expose the most important knobs across all systems.

### Choosing System Order

Build in dependency order, but front-load the *fun*:
- Start with whatever the player interacts with most directly
- Then add the primary feedback loop (economy, scoring, progression)
- Then add AI / enemies / challenge
- Then add UI / polish / secondary systems

Example for a Majesty-style kingdom sim:
1. **World + Camera** — Scrollable map, basic terrain grid
2. **Buildings** — Place buildings on the map, spend gold
3. **Units** — Buildings spawn units that wander autonomously
4. **Economy** — Gold generation, building costs, unit upkeep
5. **Enemies** — Spawn from edges, threaten buildings
6. **Bounty system** — Player places flags, units respond to bounties
7. **Combat** — Units and enemies fight when they meet
8. **Win/Lose** — Survive N waves, or lose if castle is destroyed

After step 1, the user can scroll around a map.
After step 3, they can see units moving.
After step 5, there's something at stake.
Each step is testable.

---

## Project Structure

Advanced prototypes live in `projects/<snake_case_name>/`:

```
projects/kingdom_sim/
├── project.godot
├── main.tscn                  # Entry scene — sets up the world
├── main.gd
├── scenes/                    # Reusable scene files
│   ├── buildings/
│   │   ├── building.tscn
│   │   └── building.gd
│   ├── units/
│   │   ├── unit.tscn
│   │   └── unit.gd
│   ├── enemies/
│   │   ├── enemy.tscn
│   │   └── enemy.gd
│   └── ui/
│       ├── hud.tscn
│       └── hud.gd
├── systems/                   # Autoload singletons and managers
│   ├── game_manager.gd        # Game state, win/lose conditions
│   ├── economy.gd             # Gold, costs, income
│   └── spawner.gd             # Enemy wave spawning
├── resources/                 # Godot Resource files (.tres)
│   ├── building_data/         # Building type definitions
│   └── unit_data/             # Unit type definitions
└── assets/                    # (optional) sprites, audio
```

### Naming Conventions
- Folders: `snake_case`
- Scripts: `snake_case.gd` matching the node/class they serve
- Scenes: `snake_case.tscn` matching the script
- Resources: `snake_case.tres`
- Classes: `PascalCase` via `class_name`

---

## Architecture Patterns

### Autoload Singletons (for global systems)

Use autoloads for systems that need to be accessible everywhere.
Register them in `project.godot`:

```ini
[autoload]
GameManager="*res://systems/game_manager.gd"
Economy="*res://systems/economy.gd"
```

Keep autoloads small — they manage state and emit signals, they don't contain
game logic or node trees. Other nodes connect to their signals.

```gdscript
# systems/economy.gd
extends Node

signal gold_changed(new_amount: int)
signal insufficient_funds()

var gold: int = 100

func spend(amount: int) -> bool:
    if gold >= amount:
        gold -= amount
        gold_changed.emit(gold)
        return true
    insufficient_funds.emit()
    return false

func earn(amount: int) -> void:
    gold += amount
    gold_changed.emit(gold)
```

### Custom Resources (for data-driven design)

Use Godot Resources for entity definitions. This makes it easy to create
variants (different building types, unit types, etc.) without new scripts.

```gdscript
# resources/building_data.gd
class_name BuildingData
extends Resource

@export var name: String = ""
@export var cost: int = 50
@export var build_time: float = 3.0
@export var spawns_unit: bool = false
@export var unit_spawn_rate: float = 10.0
@export var color: Color = Color.WHITE  # for prototype visuals
```

Create instances as `.tres` files or in code:
```gdscript
var barracks = BuildingData.new()
barracks.name = "Barracks"
barracks.cost = 100
barracks.spawns_unit = true
```

### Signal Bus (for decoupled communication)

For complex games, an event bus prevents spaghetti dependencies.
Make it an autoload:

```gdscript
# systems/events.gd
extends Node

signal building_placed(building, position)
signal unit_spawned(unit)
signal enemy_killed(enemy)
signal bounty_placed(position, reward)
signal game_over(won: bool)
```

Any script can emit: `Events.building_placed.emit(building, pos)`
Any script can listen: `Events.building_placed.connect(_on_building_placed)`

### Entity Pattern (for units, enemies, buildings)

Entities that share behavior should share a base structure:

```gdscript
# scenes/units/unit.gd
extends CharacterBody2D

## --- Tuning ---
@export var move_speed: float = 100.0
@export var attack_damage: int = 10
@export var max_health: int = 50
## --- End Tuning ---

@export var unit_data: UnitData  # resource defining this unit type

var health: int
var current_target: Node2D = null

enum State { IDLE, MOVING, ATTACKING, RETURNING, DEAD }
var state: State = State.IDLE

func _ready():
    health = max_health
    if unit_data:
        move_speed = unit_data.move_speed
        attack_damage = unit_data.attack_damage
        max_health = unit_data.max_health
        health = max_health

func _physics_process(delta):
    match state:
        State.IDLE: _find_something_to_do()
        State.MOVING: _move_toward_target(delta)
        State.ATTACKING: _attack(delta)
        State.RETURNING: _move_home(delta)
        State.DEAD: pass
```

---

## project.godot Template (Advanced)

```ini
[application]
config/name="Game Name"
run/main_scene="res://main.tscn"
config/features=PackedStringArray("4.3", "GL Compatibility")

[autoload]
GameManager="*res://systems/game_manager.gd"

[display]
window/size/viewport_width=1280
window/size/viewport_height=720
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"

[rendering]
renderer/rendering_method="gl_compatibility"
renderer/rendering_method.mobile="gl_compatibility"
```

Add autoload entries as you create new system scripts.

---

## Incremental Build Checklist

When building each system, follow this micro-loop:

1. **Create the script(s)** for this system
2. **Create or update scene(s)** that use the script
3. **Wire signals** to connect this system to existing systems
4. **Add autoload entry** to project.godot if it's a manager/singleton
5. **Validate**: `godot --headless --path projects/<n> --editor --quit`
6. **Tell the user** what was added and how to test it
7. **Wait for feedback** before building the next system

### Between Systems: Checkpoint Prompt

After each system, tell the user:
> "System N is in. Here's what you can do now: [describe testable actions].
> Run with: `godot --path projects/<name>`
> What should I build next, or do you want changes to what's there?"

This gives the user control over build order and lets them course-correct early.

---

## Visuals in Advanced Prototypes

Same rule as quick prototypes — **colored shapes first**. But you have more room:

- **Buildings**: Colored rectangles with a Label showing the building name
- **Units**: Small colored circles/squares. Different colors per type.
- **Enemies**: Different shape or color from friendly units (use `ProtoColors.ENEMY`)
- **UI**: Simple Labels and ColorRects for HUD panels. No custom themes needed.
- **Map/terrain**: Use a TileMap with colored cells, or just a large ColorRect background
- **Selection/interaction**: Draw circles or outlines with `_draw()` or Line2D

If the user provides assets later, swap visuals without changing game logic.
Keep visuals and logic cleanly separated — don't bury rendering in state machine code.

---

## Common Systems Reference

Brief patterns. Expand as needed — don't read this whole section upfront.

### Camera (Scrollable map)
```gdscript
extends Camera2D
@export var scroll_speed: float = 500.0
@export var edge_margin: float = 50.0  # pixels from screen edge to start scrolling

func _process(delta):
    var input = Vector2.ZERO
    var mouse = get_viewport().get_mouse_position()
    var vp = get_viewport_rect().size
    if mouse.x < edge_margin: input.x -= 1
    if mouse.x > vp.x - edge_margin: input.x += 1
    if mouse.y < edge_margin: input.y -= 1
    if mouse.y > vp.y - edge_margin: input.y += 1
    # Also support WASD/arrows
    input += Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    position += input.normalized() * scroll_speed * delta
```

### Click-to-Place
```gdscript
func _unhandled_input(event):
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        var world_pos = get_global_mouse_position()
        _place_thing_at(world_pos)
```

### Simple AI (Autonomous unit)
```gdscript
func _find_something_to_do():
    # Check for bounties first
    var bounty = _find_nearest_bounty()
    if bounty:
        current_target = bounty
        state = State.MOVING
        return
    # Otherwise wander
    current_target = _random_nearby_point()
    state = State.MOVING
```

### Wave Spawner
```gdscript
@export var wave_interval: float = 30.0
@export var enemies_per_wave: int = 5
@export var wave_growth: float = 1.5

var current_wave: int = 0
var wave_timer: float = 0.0

func _process(delta):
    wave_timer += delta
    if wave_timer >= wave_interval:
        wave_timer = 0.0
        current_wave += 1
        var count = int(enemies_per_wave * pow(wave_growth, current_wave - 1))
        _spawn_wave(count)
```
