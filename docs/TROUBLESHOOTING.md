# Troubleshooting & Emergency Recovery

## Emergency Stop

If video decoding stutters or you need to immediately stop the live wallpaper:

```bash
# Option 1: Using the helper
omarchy-live-wallpaper stop

# Option 2: Direct emergency kill
pkill -9 mpvpaper 2>/dev/null || true
systemctl --user stop omarchy-live-wallpaper.service 2>/dev/null || true

# Restore static wallpaper:
omarchy theme bg refresh
```

## High CPU or GPU Temperature

1. Check hardware decoding in `mpvpaper`:
   In `~/.config/systemd/user/omarchy-live-wallpaper.service`, ensure `hwdec=auto-safe` is present.
2. For AMD GPUs, verify VA-API driver:
   ```bash
   vainfo
   ```
3. Enable auto-pause: `mpvpaper` with `-p` ensures video decoding pauses whenever active application windows cover the screen.
