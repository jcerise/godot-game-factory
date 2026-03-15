# Plan: Add a Majesty-style per-building research and upgrade system. Each building has research options organized by building level. Researching all options at a level unlocks a level-up upgrade. Research costs gold and takes time. Unlocked research enables new hero abilities, equipment tiers, and building functionality.

**Status:** 🎉 Complete — All 7 steps finished  
**Last Updated:** 2026-03-07T00:04:02.239Z

---

## Steps

### Step 1: ResearchData resource and ResearchRegistry ✅

> Create ResearchData resource (name, description, cost, time, building_key, level, effects). Create ResearchRegistry defining all research items per building per level: Blacksmith (weapons/armor/accessories x3 tiers), Marketplace (potions/trade routes/caravans), Guilds (3 hero upgrades each), Temple (blessings/resurrection/sanctuary), Castle (tax office/royal guard/fortifications).

**Completed:** Created ResearchData resource class and ResearchRegistry with 45 research items across 7 buildings (Blacksmith, Warriors/Rogues/Rangers Guilds, Marketplace, Temple, Castle), each with 3 levels of 3 research options. Includes helper methods for querying by building/level and level-up costs.

---

### Step 2: Building research state and level tracking ✅

> Add building_level (1-3), completed_research array, active_research with progress timer to Building. When all research at a level is done, Level Up option appears. Leveling costs gold, increases HP, unlocks next research tier. Add max_level to BuildingData.

**Completed:** Added building_level, completed_research, active_research with progress timer, and level-up system to Building class. Buildings can now start research (costs gold, takes time), complete it (applies effects), and level up when all research at current level is done. New heroes inherit all completed research bonuses. Added registry_key and max_level to BuildingData.

---

### Step 3: Research UI panel ✅

> Create ResearchPanel that opens on building click. Shows building level, available research with costs/status, progress bar for active research, and Level Up button when ready. Player clicks to start research (gold cost paid upfront, takes time).

**Completed:** Rebuilt BuildingInfoPanel with research UI: shows building level, completed research list, research buttons with cost/time/status, progress indicators for active research, and a Level Up button when all research at current level is complete. Added research_completed and building_leveled_up signals to Events.

---

### Step 4: Blacksmith research effects ✅

> Gate equipment behind research. Blacksmith starts empty. Research unlocks weapon/armor/accessory tiers. Add accessory slot (ring/amulet) to heroes. Update hero shopping to check what the blacksmith has researched. Tiers 1-3 match building levels 1-3.

**Completed:** Equipment is now gated behind blacksmith research. Blacksmith starts with nothing available — must research Basic Weapons/Armor/Accessories to unlock tier 1, then level up to unlock tier 2, etc. Added accessory slot (rings/amulets with stat bonuses) to heroes with 6 accessories across 3 tiers. Hero shopping checks blacksmith research before purchasing.

---

### Step 5: Guild research effects (hero abilities) ✅

> Warriors: Battle Training (+ATK), War Cry (AoE fear), Shield Wall (+DEF near allies). Rogues: Stealth (harder to detect), Poison Blades (DoT), Lockpicking (bonus gold). Rangers: Tracking (detection range), Eagle Eye (attack range), Herbal Lore (HP regen). Heroes check home_building for unlocked abilities.

**Completed:** Implemented guild ability system. Heroes check home_building for researched abilities. Warriors: Battle Training (+ATK stat), War Cry (AoE fear cooldown), Shield Wall (+4 DEF near warriors), Berserker Rage (+50% dmg at low HP), Ironclad (+3 DEF), Rallying Cry. Rogues: Stealth (enemies detect 50% less), Poison Blades (4s DoT), Lockpicking (+50% gold), Backstab (double first hit), Evasion (20% dodge), Assassinate (+100% dmg on low HP enemies), Master Thief (2x gold), Vanish (untargetable at <20% HP). Rangers: Tracking (+50% detection), Eagle Eye (+50% range), Herbal Lore (HP regen), Camouflage, Multi-Shot, Master Archer, Pathfinder, Nature's Blessing.

---

### Step 6: Marketplace, Temple and Castle research ✅

> Marketplace: Healing Potions (heroes auto-heal), Trade Routes (more income), Caravans (income per building). Temple: Blessings (stat buff on visit), Resurrection (revive chance), Sanctuary Aura (AoE heal). Castle: Tax Office (faster collector), Royal Guard (2nd collector), Fortifications (HP + income). Wire effects into existing systems.

**Completed:** Implemented Marketplace (healing potions heroes auto-use at low HP, trade caravans income per building, haggling discount), Temple (sanctuary aura AoE heal, ascension map-wide heal), and Castle research (tax office faster spawns, royal guard 2nd collector, elite guard 3rd collector with HP bonus, fortifications/treasury for HP and income, kingdom banner global hero buff). Castle is now clickable with its own research panel. All effects wired into existing systems.

---

### Step 7: Visual polish and validation ✅

> Building level badge in _draw. Research-in-progress visual indicator. Update building info panel with level and completed research. Update README with research tree docs. Headless validate, commit and push.

**Completed:** Added visual polish: building level badge (stars), pulsing blue glow with progress bar during research, level shown in building name label. Updated README with full research tree table. Headless and runtime validation pass. All changes committed and pushed.

---

