# Ferrero Hunt

A chocolate-themed memory advergame built with **Godot 4.6** (GDScript). Version 2 of [this game](https://github.com/kaeri-gg/chocolate-game) Memorize where the chocolates appear on a 4x4 grid, then click the correct tiles before time runs out to earn discounts!
- Designed & developed by Kathleen.
- Game title by Alicja
- Kinder kid asset by Pariya.
- Game concept inspired by: Brain Buddies.
- Sound Effect by <a href="https://pixabay.com/users/aberrantrealities-38952538/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=412050">Jordan Garner</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=412050">Pixabay</a>
- Sound Effect by DRAGON-STUDIO from Pixabay
- Some part of images from Freepik

## [Play Here](https://kaeri-gg.github.io/ferrero-advergame/release)
> *For educational purposes only.*

<img width="1918" height="1072" alt="image" src="https://github.com/user-attachments/assets/471e52e8-6668-4a3e-b00d-4be8134434f2" />

---

## Gameplay            

1. **Start** - Press *Play* on the main menu.
2. **Countdown** - A 3-second countdown plays before the round begins.
3. **Selection** - Product selection for brand awareness.
3. **Memorize** - Chocolate sticker icons briefly flash on random tiles in the 4x4 grid.
4. **Recall** - Click the tiles where the chocolates appeared.
    - **Correct round** - All chocolates found = bonus points (`chocolate_count * streak`).
    - **Wrong click** - The round resets; you still earn points for each correct click made before the mistake.
5. **Difficulty ramp** - Every 3 consecutive correct rounds, an extra chocolate is added to the grid.
6. **Timer** - You have **60 seconds**. When time's up the game transitions to the results screen.
7. **Discount** - Your final score is converted to a percentage discount (up to 100%) on your next purchase.

## Scoring

| Event | Points |
|---|---|
| Correct round | `chocolate_count * streak_count` |
| Wrong click (partial) | `+1` per correctly clicked tile |
| Discount formula | `min(score / 1500 * 100, 100)%` |

---

## Project Structure

```
ferrero-advergame/
|-- assets/             # Images, fonts, and sound effects
|   |-- font/           # LuckiestGuy, PoetsenOne
|   |-- sounds/         # BGM, click, correct/wrong, countdown, winning
|   +-- stickers/       # Chocolate sticker icons (7 real + 3 dummy)
|-- scene/              # Godot scene files (.tscn)
|   |-- game_menu.tscn  # Main menu / start screen
|   |-- main_scene.tscn # Core gameplay (4x4 grid, timer, score)
|   |-- winning_scene.tscn  # Game over / discount results
|   |-- bg_music.tscn       # Background music (autoload)
|   +-- sound_manager.tscn  # SFX manager (autoload)
|-- script/             # GDScript source files
|   |-- main_scene.gd   # Game loop, grid logic, scoring, timer
|   |-- start_button.gd # Start button with fade transition
|   |-- feedback.gd     # Correct/wrong visual feedback panel
|   |-- sound_manager.gd# Play/stop named AudioStreamPlayer2D nodes
|   |-- utils.gd        # Utility helpers (timeout, fade_in/out, slide_in)
|   +-- winning_scene.gd# Results screen, discount calculation, replay
|-- theme/              # Godot theme resources (.tres)
|-- release/            # Web export output (HTML5)
|-- project.godot       # Godot project configuration
+-- export_presets.cfg  # Export preset (Web)
```

## Autoloads

| Name | Scene/Script | Purpose |
|---|---|---|
| `utils` | `script/utils.gd` | Async timeout, fade-in/out, slide-in helpers |
| `BgMusic` | `scene/bg_music.tscn` | Background music player |
| `sound_manager` | `scene/sound_manager.tscn` | Named SFX playback |

---

## Getting Started

### Prerequisites

- [Godot 4.6](https://godotengine.org/download) (Forward+ renderer)

### Run Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/ferrero-advergame.git
   ```
2. Open `project.godot` in Godot 4.6.
3. Press **F5** (or *Play*) to run.

### Export for Web

The project includes a Web export preset ("Ferrero Hunt"):

1. In Godot, go to **Project > Export**.
2. Select the **Ferrero Hunt** preset.
3. Click **Export Project** — output goes to `release/index.html`.

> The HTML shell injects `<base href="/ferrero-advergame/release/">` for hosting under a subpath. Adjust `html/head_include` in `export_presets.cfg` if your deployment path differs.

