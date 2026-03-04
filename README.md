# Godot Game Workshop

Turn game ideas into playable prototypes using an LLM coding agent + Godot. Two modes
depending on what you're testing.

## Setup (One-Time)

- **Godot 4.3+** on your PATH — test: `godot --version`
- **A coding agent** that can read files, write files, and run shell commands.
  Configure it with a system prompt that includes:
  *"At the start of every session, read the file `AGENT.md` in the project root
  and follow its instructions."*

```bash
cp -r godot-game-workshop ~/projects/godot-workshop
cd ~/projects/godot-workshop
# Start your agent in this directory
```

## Two Modes

### Quick Prototype: "Make a prototype:"

For testing a single mechanic. Fast, disposable, colored rectangles.

```
> Make a prototype: a game where you're a magnet that attracts metal
> objects but grows bigger and slower as you collect them
```

- Creates a standalone Godot project in `prototypes/<n>/`
- 1 scene, 1-3 scripts. Playable in under 5 minutes.
- Run: `godot --path prototypes/<n>`

### Advanced Game: "Build a game:"

For prototyping games with multiple interacting systems (RTS, sim, roguelike, etc.)

```
> Build a game: a Majesty-style kingdom sim where you place buildings
> that spawn autonomous heroes. You don't control the heroes directly —
> you place bounties to influence where they go. Enemies attack in waves.
```

- Creates a standalone Godot project in `projects/<n>/`
- Multiple scenes, scripts, autoload systems. Built system-by-system.
- The agent outlines the system breakdown and asks for approval before starting.
- Playable after each system is added.
- Run: `godot --path projects/<n>`

## Playing and Testing

```bash
# Quick prototypes
godot --path prototypes/magnet_collect

# Advanced games
godot --path projects/kingdom_sim

# Open in editor instead of running
godot --editor --path projects/kingdom_sim
```

Every prototype and project is a standalone Godot project. You can open
multiple in separate editor windows, zip one up to share, or delete
one without affecting the others.

## File Structure

```
godot-game-workshop/
├── AGENT.md                  ← Agent reads this at session start
├── README.md                 ← You are here
├── prompt_guide.md           ← Tips for describing game ideas
├── shared/                   ← Reference material (agent reads, copies into projects)
│   ├── PATTERNS.md           ← Code snippets (movement, shake, score)
│   ├── ADVANCED.md           ← Architecture guide for "Build a game" mode
│   ├── colors.gd             ← Color palette constants
│   ├── debug_overlay.gd      ← FPS counter + debug values
│   └── proto_utils.gd        ← Screen shake, popup text, flash
├── assets/                   ← Shared asset pool
│   ├── ASSETS.md             ← Asset manifest (describe every file here)
│   ├── sprites/
│   ├── tilesets/
│   └── audio/
├── prototypes/               ← Quick prototypes ("Make a prototype:")
│   └── magnet_collect/
│       ├── project.godot
│       ├── main.tscn
│       └── main.gd
└── projects/                 ← Advanced games ("Build a game:")
    └── kingdom_sim/
        ├── project.godot
        ├── main.tscn
        ├── scenes/
        ├── systems/
        └── resources/
```

## Adding Art & Sound

Works the same in both modes:

1. Drop files into `assets/sprites/`, `assets/tilesets/`, or `assets/audio/`
2. Describe them in `assets/ASSETS.md` (the agent can't see images)
3. Say: *"Skin the kingdom_sim project with the assets I added"*

The agent copies relevant assets into the project and swaps rectangles for sprites.

## Agent Setup Notes

This kit is agent-agnostic. The instructions in `AGENT.md` are written for any
LLM coding agent that can read/write files and run shell commands. To use it:

1. Point your agent at this directory as its working directory
2. Ensure your agent's system prompt tells it to read `AGENT.md` on startup
3. If your agent has its own instruction file convention (e.g., `CLAUDE.md` for
   Claude Code, `.cursorrules` for Cursor), you can symlink or copy:
   ```bash
   # For Claude Code
   ln -s AGENT.md CLAUDE.md

   # For Cursor
   ln -s AGENT.md .cursorrules
   ```

## Tips

- **Name by the mechanic**: `magnet_collect`, `bounty_rts` — not `cool_game_3`
- **Playtest early**: After each system in advanced mode, run the game and give feedback
- **Be specific about what feels wrong**: "units feel too slow" beats "it's not fun"
- **Export variables**: Tweak `@export` values in the Inspector during play
- **Course-correct early**: In advanced mode, it's better to scrap a system that
  isn't fun after 2 systems than after 6

See `prompt_guide.md` for detailed tips on writing effective game descriptions.
