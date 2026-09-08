# Live Video Wallpaper Running Guide

This guide details how the live wallpaper engine functions and how to operate it smoothly.

## Prerequisites

Ensure `mpv` and `mpvpaper` are installed:

```bash
# Arch Linux:
sudo pacman -S mpv
# If mpvpaper is not in pacman, install via AUR or check ~/.local/bin/mpvpaper:
which mpvpaper || yay -S mpvpaper
```

## How It Operates

The live wallpaper engine uses `mpvpaper` with hardware video acceleration (`hwdec=auto-safe`), bound to the Wayland layer-shell beneath your windows (`layer=bottom`).

1. **Persistent Service**: Runs via systemd user unit `omarchy-live-wallpaper.service`.
2. **0ms IPC Hot-Swap**: When switching themes or videos, `omarchy-live-wallpaper` sends a `loadfile` command over Unix domain socket `/tmp/mpvpaper-ipc.sock`. The video transitions seamlessly without restarting the player or causing screen flicker.
3. **Smart Power Saving**: Runs with `--auto-pause` (`-p`), automatically pausing video decoding when windows cover the background or during fullscreen games/videos to save CPU and battery.

---

## Common Commands

### 1. Launch / Switch Video Wallpaper
```bash
# By theme name:
omarchy-live-wallpaper start solo-leveling-monarch
omarchy-live-wallpaper start gojo-infinity
omarchy-live-wallpaper start sukuna-fuga

# Or by direct video filename:
omarchy-live-wallpaper start sung-jin-woo-beru-solo-leveling-moewalls-com.mp4
```

### 2. Open Floating HUD Selector
Press your designated shortcut or run:
```bash
omarchy-menu-live-wallpapers
```

### 3. Toggle Play / Pause
```bash
omarchy-live-wallpaper toggle
```

### 4. Check Status
```bash
omarchy-live-wallpaper status
```

### 5. Stop Live Player (Revert to Static Wallpaper)
```bash
omarchy-live-wallpaper stop
omarchy theme bg refresh
```

---

## Automatic Theme Synchronization

To automatically sync the live video wallpaper whenever you run `omarchy theme set <theme-name>`, you can add a one-line hook:

Create `~/.config/omarchy/hooks/theme-set.d/20-live-wallpaper.sh`:
```bash
#!/usr/bin/env bash
theme_name="$1"
omarchy-live-wallpaper start "$theme_name" 2>/dev/null || true
```
Make it executable:
```bash
chmod +x ~/.config/omarchy/hooks/theme-set.d/20-live-wallpaper.sh
```
Now, whenever you switch themes via the Omarchy top bar, terminal, or hotkey, the video wallpaper transitions simultaneously!
