# Common Patterns for Godot Prototypes

Reference file. Read specific sections as needed — don't load this whole file upfront.

## Player Movement (Top-Down)
```gdscript
extends CharacterBody2D

## --- Tuning ---
@export var speed: float = 300.0
## --- End Tuning ---

func _physics_process(delta):
    var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    velocity = input * speed
    move_and_slide()
```

## Player Movement (Platformer)
```gdscript
extends CharacterBody2D

## --- Tuning ---
@export var speed: float = 300.0
@export var jump_force: float = -600.0
@export var gravity: float = 1200.0
## --- End Tuning ---

func _physics_process(delta):
    velocity.y += gravity * delta
    if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
        velocity.y = jump_force
    velocity.x = Input.get_axis("ui_left", "ui_right") * speed
    move_and_slide()
```

## Screen Shake
```gdscript
func shake(camera: Camera2D, intensity: float = 10.0, duration: float = 0.2):
    var tween = create_tween()
    for i in range(int(duration / 0.05)):
        tween.tween_property(camera, "offset",
            Vector2(randf_range(-1,1), randf_range(-1,1)) * intensity, 0.05)
    tween.tween_property(camera, "offset", Vector2.ZERO, 0.05)
```
Also available via: `ProtoUtils.shake_camera(camera, intensity, duration)`

## Simple Score Display
```gdscript
var score: int = 0
@onready var label = $ScoreLabel

func add_score(amount: int):
    score += amount
    label.text = "Score: %d" % score
```

## Restart / Quit (include in every prototype)
```gdscript
func _unhandled_input(event):
    if event.is_action_pressed("ui_cancel"):
        get_tree().quit()
    if event is InputEventKey and event.pressed and event.keycode == KEY_R:
        get_tree().reload_current_scene()
```

## Spawn Timer (for enemies, obstacles, pickups)
```gdscript
## --- Tuning ---
@export var spawn_rate: float = 1.5
## --- End Tuning ---

var spawn_timer: float = 0.0

func _process(delta):
    spawn_timer += delta
    if spawn_timer >= spawn_rate:
        spawn_timer = 0.0
        _spawn_thing()

func _spawn_thing():
    pass # create and add_child here
```

## Random Screen Position
```gdscript
func random_position() -> Vector2:
    var vp = get_viewport_rect().size
    return Vector2(randf_range(0, vp.x), randf_range(0, vp.y))

func random_edge_position() -> Vector2:
    var vp = get_viewport_rect().size
    var side = randi() % 4
    match side:
        0: return Vector2(randf_range(0, vp.x), 0)          # top
        1: return Vector2(randf_range(0, vp.x), vp.y)       # bottom
        2: return Vector2(0, randf_range(0, vp.y))           # left
        3: return Vector2(vp.x, randf_range(0, vp.y))       # right
    return Vector2.ZERO
```

## Simple State Machine
```gdscript
enum State { IDLE, MOVING, ATTACKING, DEAD }
var state: State = State.IDLE

func _physics_process(delta):
    match state:
        State.IDLE: _state_idle(delta)
        State.MOVING: _state_moving(delta)
        State.ATTACKING: _state_attacking(delta)
        State.DEAD: pass
```

## Loading a Sprite (when assets are available)
```gdscript
# Single sprite — dimensions from ASSETS.md
var sprite = Sprite2D.new()
sprite.texture = preload("res://assets/sprites/player_idle.png")

# Sprite sheet — hframes from ASSETS.md
var sprite = Sprite2D.new()
sprite.texture = preload("res://assets/sprites/player_run.png")
sprite.hframes = 6
# Animate: sprite.frame = (sprite.frame + 1) % sprite.hframes

# Sound
var sfx = AudioStreamPlayer2D.new()
sfx.stream = preload("res://assets/audio/jump.wav")
add_child(sfx)
sfx.play()
```

## Area2D Collision Detection (for pickups, triggers)
```gdscript
# On the pickup/trigger node:
func _ready():
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player"):
        # do something
        queue_free()
```

## Color Palette Reference
Available via `ProtoColors.<name>`:
- PLAYER (teal), PLAYER_ALT (dark teal)
- ENEMY (coral red), HAZARD (orange)
- GOAL (gold yellow), PICKUP (mint green)
- WALL (dark blue-gray), FLOOR (very dark blue), BACKGROUND (deep navy)
- TEXT (off-white), TEXT_ACCENT (gold)
