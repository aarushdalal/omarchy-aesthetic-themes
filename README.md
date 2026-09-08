# Omarchy Aesthetic Themes & Live Video Wallpapers (`omarchy-aesthetic-themes`)

> **Unofficial / Community Suite**: Standalone, all-in-one repository bundling 15 handcrafted aesthetic themes, full-resolution static wallpapers, 15 synchronized live video wallpapers (1080p/4K MP4), floating menu HUD, and automated live wallpaper engine for Omarchy Hyprland.

---

## What is in this Repository?

Everything needed for a sensory, unified desktop transformation:
1. **15 Curated Themes**: Complete `colors.toml` color palettes tailored for Omarchy Quickshell, terminal emulators (Foot, Ghostty, Kitty, Alacritty), and application borders.
2. **15 Static Wallpapers**: Crisp PNG wallpapers placed in each theme's `backgrounds/` folder.
3. **15 Live Video Wallpapers**: 60 FPS animated MP4 video loops located in `wallpapers/videos/`.
4. **Live Wallpaper Engine**: `omarchy-live-wallpaper` daemon with zero-delay Unix domain socket hot-swapping (`/tmp/mpvpaper-ipc.sock`) and auto-pause battery saving.
5. **Interactive Floating HUD**: `omarchy-menu-live-wallpapers` for previewing and selecting themes and videos with a single hotkey.
6. **Automated User Installer**: Single `./install.sh install` command that configures all paths, services, and scripts.

---

## Theme Catalog & Video Index

| Theme | Accent | Background | Live Video (MP4) | Static Image (PNG) |
|---|---|---|---|---|
| **Solo Leveling: Shadow Monarch** | `#4361ee` | `#060714` | `sung-jin-woo-beru-solo-leveling-moewalls-com.mp4` | `sololeveling_monarch.png` |
| **Solo Leveling: Shadow Army Arise** | `#9d4edd` | `#080514` | `mylivewallpapers-com-Shadow-Army-Solo-Leveling-4K.mp4` | `sololeveling_shadow_army.png` |
| **Solo Leveling: God Statue Smile** | `#00d2ff` | `#030710` | `mylivewallpapers-com-Solo-Leveling-Smile-4K.mp4` | `sololeveling_smile.png` |
| **Jujutsu Kaisen: Sukuna Fūga** | `#ff4800` | `#0c0201` | `ryomen-sukuna-fuga-jujutsu-kaisen-wallpaperwaifu-com.mp4` | `sukuna_fuga.png` |
| **Jujutsu Kaisen: Malevolent Shrine** | `#e60026` | `#080102` | `ryomen-sukuna-jujutsu-kaisen-moewalls-com.mp4` | `sukuna_malevolent_shrine.png` |
| **Jujutsu Kaisen: Gojo Infinity** | `#ffffff` | `#000000` | `mylivewallpapers-com-Minimal-Circle-Gojo-4K.mp4` | `gojo_infinity.png` |
| **Jujutsu Kaisen: Yuta & Rika Dark Ocean** | `#00d2ff` | `#030814` | `yuta-x-rika-dark-ocean-jujutsu-kaisen-moewalls-com.mp4` | `yuta_rika_dark_ocean.png` |
| **Jujutsu Kaisen: Kenjaku Prison Realm** | `#06b6d4` | `#02070d` | `mylivewallpapers-com-Prison-Realm-Kenjaku-FHD.mp4` | `kenjaku_prison_realm.png` |
| **Chainsaw Man: Reze Bomb Devil** | `#c026d3` | `#050209` | `reze-bomb-devil-chainsaw-man-1-moewalls-com.mp4` | `reze_bomb_devil.png` |
| **Chainsaw Man: Denji Chainsaw Rage** | `#ff5500` | `#080405` | `mylivewallpapers-com-Chainsaw-Man-Rage-3440X1440.mp4` | `chainsaw_rage.png` |
| **Black Clover: Black Asta Demon Form** | `#d90429` | `#000000` | `black-asta-moewalls-com.mp4` | `black_asta.png` |
| **Hell's Paradise: Gabimaru Hollow Flame** | `#f5f5f5` | `#000000` | `gabimaru-hollow-flame.1920x1080.mp4` | `gabimaru_hollow_flame.png` |
| **Bleach: Ichigo Hollow Mask** | `#f97316` | `#07080c` | `ichigo-hollow-mask.1920x1080.mp4` | `ichigo_hollow.png` |
| **The Matrix: 4K Digital Rain** | `#ff2a6d` | `#020004` | `matrix-digital-moewalls-com.mp4` | `matrix_digital.png` |
| **BMW M4: Night Drive Neon Glow** | `#3a86ff` | `#03090e` | `BMW-M4.mp4` | `BMW_M4_night.png` |

---

## Quick Start (How to Place & Run)

### 1. Requirements
- **Arch Linux** with **Omarchy 4.0.2**
- **Wayland / Hyprland 0.56.2**
- **`mpv`** and **`mpvpaper`**:
  ```bash
  sudo pacman -S mpv
  which mpvpaper || yay -S mpvpaper
  ```

### 2. Automated Installation
Clone and run the installer:
```bash
git clone https://github.com/YOUR-USERNAME/omarchy-aesthetic-themes.git
cd omarchy-aesthetic-themes

# Check requirements
./install.sh check

# Preview without changing files
./install.sh install --dry-run

# Place all themes, wallpapers, videos, and scripts
./install.sh install
```

### 3. Running & Switching
- **Apply Theme Palette**:
  ```bash
  omarchy theme set solo-leveling-monarch
  ```
- **Launch Live Video Wallpaper**:
  ```bash
  omarchy-live-wallpaper start solo-leveling-monarch
  ```
- **Open Floating HUD Selector**:
  ```bash
  omarchy-menu-live-wallpapers
  ```
- **Stop Live Wallpaper**:
  ```bash
  omarchy-live-wallpaper stop
  ```

---

## Complete Guides

- 📂 [**File Placement Guide**](docs/PLACEMENT-GUIDE.md): Complete list of file locations, targets, and manual copy commands.
- 🚀 [**Live Running Guide**](docs/RUN-GUIDE.md): Operational architecture, IPC socket hot-swapping, and auto-sync hooks.
- 🎨 [**Themes Reference**](docs/THEMES-REFERENCE.md): In-depth color specifications, palettes, and media index.
- 🛠️ [**Troubleshooting & Recovery**](docs/TROUBLESHOOTING.md): Emergency stop commands and GPU hardware decoding.

---

## Showcase & Demonstrations

### Video Demonstration
A high-definition walkthrough demonstration (`omarchy_intro_showcase.mp4`) is available in `assets/showcase/`.

### Gallery Placeholders
![Solo Leveling — Shadow Monarch](assets/showcase/sololeveling_monarch.png)
![Solo Leveling — Shadow Army](assets/showcase/sololeveling_shadow_army.png)
![Solo Leveling — God Statue](assets/showcase/sololeveling_smile.png)
![Sukuna — Fūga](assets/showcase/sukuna_fuga.png)
![Sukuna — Malevolent Shrine](assets/showcase/sukuna_malevolent_shrine.png)
![Gojo — Infinity](assets/showcase/gojo_infinity.png)
![Yuta × Rika — Dark Ocean](assets/showcase/yuta_rika_dark_ocean.png)
![Kenjaku — Prison Realm](assets/showcase/kenjaku_prison_realm.png)
![Reze — Bomb Devil](assets/showcase/reze_bomb_devil.png)
![Chainsaw Man — Rage](assets/showcase/chainsaw_rage.png)
![Black Asta — Demon Form](assets/showcase/black_asta.png)
![Ichigo — Hollow Mask](assets/showcase/ichigo_hollow.png)
![Matrix — Digital Rain](assets/showcase/matrix_digital.png)
![BMW M4 — Night Drive](assets/showcase/BMW_M4_night.png)

---

## License

This repository is distributed under the [MIT License](LICENSE).
