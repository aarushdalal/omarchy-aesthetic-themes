# File Placement Guide

This guide explains the exact directory structure and where each component is installed on your Linux system.

## Overview of System Paths

| Component | Source Path in Repository | Target Location on System | Purpose |
|---|---|---|---|
| **Theme Palettes & Images** | `themes/<slug>/` | `~/.config/omarchy/themes/<slug>/` | Contains `colors.toml`, `backgrounds/`, and `preview.png` for Omarchy theme switching. |
| **Live MP4 Videos** | `wallpapers/videos/*.mp4` | `~/.local/share/omarchy/wallpapers/videos/` | High-definition (1080p/4K) looped videos decoded by `mpvpaper`. |
| **CLI Wallpaper Daemon** | `bin/omarchy-live-wallpaper` | `~/.local/bin/omarchy-live-wallpaper` | Main controller script for starting, stopping, and 0ms hot-swapping live wallpapers. |
| **Interactive Menu HUD** | `bin/omarchy-menu-live-wallpapers` | `~/.local/bin/omarchy-menu-live-wallpapers` | Floating modal selector (`omarchy-menu-select`) for selecting wallpapers with one keystroke. |
| **Systemd Service** | `systemd/omarchy-live-wallpaper.service` | `~/.config/systemd/user/omarchy-live-wallpaper.service` | Manages background video rendering across system reboots and sleep/wake cycles. |

---

## Manual Placement Instructions

If you prefer to install files manually without running `./install.sh install`:

### Step 1: Copy Theme Palettes & Wallpapers
```bash
mkdir -p ~/.config/omarchy/themes
cp -r themes/* ~/.config/omarchy/themes/
```

### Step 2: Copy Live Video Files
```bash
mkdir -p ~/.local/share/omarchy/wallpapers/videos
cp wallpapers/videos/*.mp4 ~/.local/share/omarchy/wallpapers/videos/
```

### Step 3: Install Executable Scripts
```bash
mkdir -p ~/.local/bin
cp bin/omarchy-live-wallpaper ~/.local/bin/
cp bin/omarchy-menu-live-wallpapers ~/.local/bin/
chmod +x ~/.local/bin/omarchy-live-wallpaper
chmod +x ~/.local/bin/omarchy-menu-live-wallpapers
```

### Step 4: Install Systemd User Unit
```bash
mkdir -p ~/.config/systemd/user
cp systemd/omarchy-live-wallpaper.service ~/.config/systemd/user/
systemctl --user daemon-reload
```
