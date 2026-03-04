# Prompt Guide: Describing Game Ideas for Rapid Prototyping

## The Golden Rule

Describe **what the player DOES**, not what the game looks like.

"The player is a square that jumps between platforms" → slow to prototype, focused on form.
"The player has a double-jump but the second jump goes in whatever direction they're holding" → fast, focused on the interesting mechanic.

---

## The Template

You don't need all of these, but hitting 3-4 of them gives the agent enough to build something playable:

```
Game idea: [one sentence — the elevator pitch]

Core mechanic: [what does the player DO on a moment-to-moment basis?]

Tension: [what makes it hard / interesting / forces decisions?]

Win/lose: [how does a round end?]

Reference: [optional — "like X but with Y", or "the movement from X meets the scoring of Y"]
```

### Example: Good Prompt

```
Game idea: A top-down game where you're a magnet trying to collect metal
objects, but collecting makes you bigger and slower.

Core mechanic: Move with WASD. Metal objects are attracted to you from a
short range — you don't pick them up, they drift toward you. The more you
collect, the larger your collision area grows and the slower you move.

Tension: Enemy "demagnetizers" patrol the arena. If they touch you, you
lose half your collected objects. You need to reach a score target before
time runs out.

Win/lose: Collect 50 objects to win. Timer is 60 seconds. Touching a
demagnetizer doesn't kill you but drops your count.
```

### Example: Too Vague

```
Make me a fun platformer.
```

This will produce something generic. Even adding one constraint makes it
dramatically better: "Make me a platformer where the floor is constantly
rising like lava, and you climb upward on procedurally spawning platforms."

---

## Power Moves (Things That Supercharge Prototypes)

### 1. Name the interesting constraint
The fun in most games comes from a limitation or tradeoff. Name it explicitly:
- "You can only shoot while standing still"
- "Jumping costs health"
- "You control two characters simultaneously with the same inputs"
- "Gravity flips every 5 seconds"

### 2. Ask for tuning knobs
Say: "Expose the key variables so I can tweak them while playtesting."
This gets you `@export` variables that show up in the Godot editor, so you
can adjust gravity, speed, spawn rates, etc. without touching code.

### 3. Request a difficulty ramp
Say: "Make it get harder over time." This forces a timer or wave system,
which instantly makes even a simple mechanic feel like a game.

### 4. Ask for juice
Say: "Add screen shake on hit, flash on collect, and a score popup."
Three lines of code each, but they make the prototype 10x more readable
when playtesting.

### 5. Describe what you want to LEARN
The whole point is testing whether an idea is fun. Tell the agent:
- "I want to find out if the magnetic attraction radius feels good"
- "I'm testing whether simultaneous control of two characters is fun or frustrating"
This helps the agent put the tuning knobs in the right places.

---

## Iteration Prompts (After First Playtest)

Once you've played the prototype, these are good follow-up prompts:

- "The player feels too floaty. Increase gravity by 50% and reduce jump height."
- "The enemies are too predictable. Make them occasionally speed up randomly."
- "This is fun but too easy. Add a second enemy type that moves faster but is smaller."
- "The core loop works. Now add a simple 3-level progression where each level
  adds one new element."
- "Scrap the enemy system, it's not fun. Replace it with a timer countdown
  and environmental hazards."
- "I like the movement but the scoring is boring. What if collecting objects
  filled a meter and you could 'spend' the meter on a dash ability?"

---

## Anti-Patterns (Things That Slow You Down)

| Don't say                           | Say instead                                              |
|-------------------------------------|----------------------------------------------------------|
| "Make it look like Celeste"         | "Tight platforming with a dash and coyote time"          |
| "Add beautiful particle effects"    | "Flash the screen white on big hits"                     |
| "Create a full menu system"         | "R to restart, Escape to quit" (already in the template) |
| "Use this sprite sheet I found"     | "Use colored rectangles" (always, for prototyping)       |
| "Make it multiplayer"               | "Two players on one keyboard (WASD + arrows)"            |
| "Implement save/load"               | Skip it — prototypes don't need persistence              |

---

## Adding Assets to a Prototype

### When to Add Assets

Assets are for **phase 2** of prototyping. The flow is:

1. Build with colored shapes → test if the mechanic is fun
2. If it's fun, drop in some sprites/sounds → test if the *vibe* works
3. If the vibe works, you've got a prototype worth developing further

Don't start with assets. They slow you down and bias you toward "it looks nice"
instead of "it feels good."

### How to Add Assets

1. Drop files into `assets/sprites/`, `assets/tilesets/`, or `assets/audio/`
   (or into a prototype's own `prototypes/<name>/assets/` folder)
2. Open `assets/ASSETS.md` and describe each file (see the template for format)
3. Tell the agent: "Skin the magnet_collect prototype with the assets I added"

### What to Describe in ASSETS.md

The agent can't see your images. It needs you to be specific:

**Good description:**
```
### player_run.png
- Path: assets/sprites/player_run.png
- Depicts: 32×32 pixel art fox running right, 6-frame animation
- Dimensions: 192×32 (6 columns × 1 row)
- Frame size: 32×32, hframes: 6
- Role: Player character run cycle
```

**Bad description:**
```
### player_run.png
- A sprite sheet for the player
```

The more detail you give (dimensions, frame count, what it looks like), the better
the agent can wire it up correctly on the first try.

### Useful Asset Prompts

- "Skin this prototype with the assets I added to ASSETS.md"
- "Use the knight sprite for the player but keep rectangles for everything else"
- "Add the jump.wav sound effect when the player jumps"
- "Switch the TileMap to use the dungeon tileset I added"
- "The player sprite is 32x32 but the collision feels too big — shrink it to 24x24"

### Where to Find Quick Assets for Prototyping

Free assets that work great for this kind of rapid prototyping:
- **Kenney.nl** — huge library of free, public domain game assets (sprites, tiles, sounds)
- **OpenGameArt.org** — community-contributed free game art
- **itch.io asset packs** — search for "free pixel art" or "free game assets"
- **sfxr / jsfxr** — generate retro sound effects in seconds (jsfxr.frozenfrog.com)

---

## Advanced Mode: "Build a game:" Prompts

When you want to prototype something with multiple interacting systems, use the
"Build a game:" opener instead of "Make a prototype:".

### The Template

```
Build a game: [one sentence — the genre and core fantasy]

Player role: [what does the player control / decide?]

Core systems: [list the 3-5 things that make it tick]

Reference: [optional — "like X but with Y"]

What I want to test: [what question are you trying to answer?]
```

### Example: Good Prompt

```
Build a game: a Majesty-style kingdom sim where you manage a fantasy settlement.

Player role: You place buildings and set bounties. You never control units
directly — they're autonomous heroes with their own priorities.

Core systems:
- Economy (gold from taxes, spent on buildings and bounties)
- Buildings (different types: tavern spawns rogues, barracks spawns warriors)
- Autonomous units (heroes wander, respond to bounties, fight, return to heal)
- Enemy waves (spawn from map edges, increasing difficulty)
- Bounty system (place a flag with a gold reward, heroes decide whether it's worth it)

Reference: Majesty: The Fantasy Kingdom Sim, but simplified to the core loop.

What I want to test: Is the indirect control (bounties instead of commands)
fun, or just frustrating? How much gold should bounties cost to feel meaningful?
```

### Why "What I want to test" Matters

This is the most important line for advanced prototypes. It tells the agent which
systems to build first and where to put the tuning knobs. If you're testing
whether indirect control is fun, the agent should prioritize the bounty system and
unit AI over polishing the economy or wave spawning.

### Iteration Prompts for Advanced Mode

Between systems, the agent will ask what to build next. Good responses:

- "The units feel lifeless. Before adding enemies, give them idle behaviors —
  they should wander to the tavern, interact with each other, feel alive."
- "Economy is too easy to ignore right now. Make buildings cost more and add
  an upkeep cost per unit."
- "Skip the wave spawner for now. I want to focus on whether placing buildings
  feels good. Add a second building type."
- "This is getting complex. Can you add a debug overlay that shows each unit's
  current state and target?"
- "The core loop works. Add a simple win condition: survive 5 waves."

### Anti-Patterns for Advanced Mode

| Don't say                                  | Say instead                                         |
|--------------------------------------------|-----------------------------------------------------|
| "Make it like Majesty but better"          | Describe the specific systems and what you're testing |
| "Add all the systems at once"              | Let the agent build one at a time, test between each  |
| "Make the AI really smart"                 | "Units should prioritize nearby bounties over far ones" |
| "Add a tech tree"                          | Save for later — test the core loop first           |
| "Make it look good"                        | "I'll add art later. Keep shapes."                  |

