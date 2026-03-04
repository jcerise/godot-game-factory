# Godot Game Workshop

## Two Modes

This workspace supports two workflows based on the opener:

### "Make a prototype:" → Quick Prototype Mode
- Small, fast, disposable. Test one mechanic.
- 1 scene, 1-3 scripts, colored rectangles.
- Created in `prototypes/<snake_case_name>/`
- Instructions below.

### "Build a game:" → Advanced Prototype Mode
- Larger, multi-system game. Multiple scenes, scripts, entity types.
- Created in `projects/<snake_case_name>/`
- **Read `shared/ADVANCED.md` FIRST** for architecture and workflow instructions.
- Still incremental — build system by system, not all at once.

---

## CRITICAL: Work Incrementally (Both Modes)

**Do NOT plan everything before writing code.**
Write one file at a time. After each file, briefly state what you wrote and what's next.
The user should see output within seconds, not minutes.

---

## Quick Prototype Mode ("Make a prototype:")

Workflow:
1. State in 1-2 sentences what you're building and the core mechanic
2. Create the prototype folder with its own `project.godot` (see template below)
3. Write the main script (.gd)
4. Write the scene file (.tscn)
5. Run `godot --headless --path prototypes/<n> --editor --quit` to validate
6. Tell the user it's ready: `godot --path prototypes/<n>`

Do steps 2-4 as **separate file writes**, not one giant block.

Rules:
- **Godot 4.x, GDScript, 2D only**
- **Each prototype is its own Godot project** in `prototypes/<snake_case_name>/`
- Must contain its own `project.godot` and a `main.tscn` entry scene
- **Visuals**: ColorRect and Polygon2D. No external assets unless the user provides them.
- **Always include**: R to restart, Escape to quit, `@export` on tuning variables
- **Keep it small**: 1 scene, 1-3 scripts. The goal is testing a mechanic, not building a game.

### project.godot Template

```ini
[application]
config/name="Prototype Name"
run/main_scene="res://main.tscn"
config/features=PackedStringArray("4.3", "GL Compatibility")

[display]
window/size/viewport_width=1280
window/size/viewport_height=720
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"

[rendering]
renderer/rendering_method="gl_compatibility"
renderer/rendering_method.mobile="gl_compatibility"
```

---

## Reference Files (read only when needed)

- `shared/PATTERNS.md` — Code snippets for movement, screen shake, score, etc.
- `shared/ADVANCED.md` — Architecture guide for "Build a game:" mode. **Read this when using that mode.**
- `shared/colors.gd` — Color palette constants (copy values into prototypes as needed).
- `shared/proto_utils.gd` — Utility functions (copy into prototypes as needed).
- `assets/ASSETS.md` — Asset manifest. Read only when user mentions assets.

Each prototype/project is a standalone Godot project. Copy any shared code or assets
into its folder — don't reference paths outside the project.

## Tuning Knob Convention (Both Modes)

```gdscript
## --- Tuning ---
@export var speed: float = 300.0
@export var gravity: float = 1200.0
@export var spawn_rate: float = 1.5
## --- End Tuning ---
```
