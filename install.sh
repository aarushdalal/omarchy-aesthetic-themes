#!/usr/bin/env bash
# ==============================================================================
# All-in-One Installer for Omarchy Aesthetic Themes & Video Wallpapers
# Safely copies theme palettes, static wallpapers, live videos, scripts & systemd units.
# Supports --dry-run and timestamped backups.
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/themes"
VIDEOS_TARGET="${XDG_DATA_HOME:-$HOME/.local/share}/omarchy/wallpapers/videos"
BIN_TARGET="${XDG_BIN_HOME:-$HOME/.local/bin}"
SYSTEMD_TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
BACKUP_BASE="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy/backups/aesthetic-themes/$(date +%Y%m%d_%H%M%S)"

DRY_RUN=0
for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=1
done

run_cmd() {
  if (( DRY_RUN )); then echo "[DRY-RUN] $*"; else "$@"; fi
}

check_deps() {
  echo "Checking dependencies for Omarchy Aesthetic Themes & Live Video..."
  local missing=0
  if command -v omarchy >/dev/null 2>&1; then
    echo "  [OK] Omarchy CLI is available"
  else
    echo "  [WARN] Omarchy CLI not found in PATH"
  fi

  if command -v mpvpaper >/dev/null 2>&1 || [[ -x "$BIN_TARGET/mpvpaper" ]]; then
    echo "  [OK] mpvpaper is available"
  else
    echo "  [FAIL] mpvpaper is required for live video wallpapers (install via pacman/AUR)."
    missing=1
  fi

  if command -v mpv >/dev/null 2>&1; then
    echo "  [OK] mpv is installed"
  else
    echo "  [FAIL] mpv is required."
    missing=1
  fi
  return $missing
}

do_install() {
  check_deps || exit 1

  echo ""
  echo "1. Installing 15 theme palettes and static backgrounds..."
  run_cmd mkdir -p "$THEMES_TARGET"
  for tdir in "$SCRIPT_DIR/themes"/*; do
    if [[ -d "$tdir" ]]; then
      local tname="$(basename "$tdir")"
      local dest="$THEMES_TARGET/$tname"
      if [[ -d "$dest" ]]; then
        run_cmd mkdir -p "$BACKUP_BASE/themes"
        run_cmd cp -r "$dest" "$BACKUP_BASE/themes/" 2>/dev/null || true
      fi
      run_cmd mkdir -p "$dest"
      run_cmd cp -r "$tdir"/* "$dest/"
      echo "  Installed theme: $tname"
    fi
  done

  echo ""
  echo "2. Installing live video wallpapers (15 MP4 files)..."
  run_cmd mkdir -p "$VIDEOS_TARGET"
  for vfile in "$SCRIPT_DIR/wallpapers/videos"/*.mp4; do
    if [[ -f "$vfile" ]]; then
      run_cmd cp "$vfile" "$VIDEOS_TARGET/"
      echo "  Installed video: $(basename "$vfile")"
    fi
  done

  echo ""
  echo "3. Installing CLI utilities..."
  run_cmd mkdir -p "$BIN_TARGET"
  if [[ -f "$SCRIPT_DIR/bin/omarchy-live-wallpaper" ]]; then
    run_cmd cp "$SCRIPT_DIR/bin/omarchy-live-wallpaper" "$BIN_TARGET/"
    run_cmd chmod +x "$BIN_TARGET/omarchy-live-wallpaper"
    echo "  Installed $BIN_TARGET/omarchy-live-wallpaper"
  fi
  if [[ -f "$SCRIPT_DIR/bin/omarchy-menu-live-wallpapers" ]]; then
    run_cmd cp "$SCRIPT_DIR/bin/omarchy-menu-live-wallpapers" "$BIN_TARGET/"
    run_cmd chmod +x "$BIN_TARGET/omarchy-menu-live-wallpapers"
    echo "  Installed $BIN_TARGET/omarchy-menu-live-wallpapers"
  fi

  echo ""
  echo "4. Installing systemd user unit..."
  run_cmd mkdir -p "$SYSTEMD_TARGET"
  if [[ -f "$SCRIPT_DIR/systemd/omarchy-live-wallpaper.service" ]]; then
    run_cmd cp "$SCRIPT_DIR/systemd/omarchy-live-wallpaper.service" "$SYSTEMD_TARGET/"
    if (( ! DRY_RUN )); then
      systemctl --user daemon-reload 2>/dev/null || true
    fi
    echo "  Installed $SYSTEMD_TARGET/omarchy-live-wallpaper.service"
  fi

  echo ""
  echo "=============================================================================="
  echo "✅ All 15 Themes and Live Video Wallpapers installed successfully!"
  echo "=============================================================================="
  echo "How to run:"
  echo "  1. Apply a theme palette:  omarchy theme set solo-leveling-monarch"
  echo "  2. Start live wallpaper:   omarchy-live-wallpaper start solo-leveling-monarch"
  echo "  3. Open floating menu HUD: omarchy-menu-live-wallpapers"
  echo "  4. Check status:           omarchy-live-wallpaper status"
  echo "  5. Stop live player:       omarchy-live-wallpaper stop"
  echo ""
  echo "See docs/RUN-GUIDE.md and docs/PLACEMENT-GUIDE.md for complete details."
}

do_status() {
  echo "=== Omarchy Aesthetic Themes & Video Status ==="
  local tcount=0
  if [[ -d "$THEMES_TARGET" ]]; then
    tcount=$(find "$THEMES_TARGET" -mindepth 1 -maxdepth 1 -type d | wc -l)
  fi
  echo "  Themes installed in $THEMES_TARGET: $tcount"

  local vcount=0
  if [[ -d "$VIDEOS_TARGET" ]]; then
    vcount=$(find "$VIDEOS_TARGET" -name "*.mp4" | wc -l)
  fi
  echo "  Videos installed in $VIDEOS_TARGET: $vcount"

  if pgrep -f "mpvpaper" >/dev/null 2>&1; then
    echo "  Live Video Player: ACTIVE (Running)"
  else
    echo "  Live Video Player: INACTIVE (Static wallpaper active)"
  fi
}

do_stop() {
  echo "Stopping live video wallpaper..."
  pkill -9 -f "mpvpaper" 2>/dev/null || true
  systemctl --user stop omarchy-live-wallpaper.service 2>/dev/null || true
  echo "Stopped."
}

do_uninstall() {
  do_stop
  echo "Removing installed theme palettes and videos..."
  for tdir in "$SCRIPT_DIR/themes"/*; do
    local tname="$(basename "$tdir")"
    if [[ -d "$THEMES_TARGET/$tname" ]]; then
      run_cmd rm -rf "$THEMES_TARGET/$tname"
    fi
  done
  for vfile in "$SCRIPT_DIR/wallpapers/videos"/*.mp4; do
    local vname="$(basename "$vfile")"
    if [[ -f "$VIDEOS_TARGET/$vname" ]]; then
      run_cmd rm -f "$VIDEOS_TARGET/$vname"
    fi
  done
  run_cmd rm -f "$BIN_TARGET/omarchy-live-wallpaper"
  run_cmd rm -f "$BIN_TARGET/omarchy-menu-live-wallpapers"
  run_cmd rm -f "$SYSTEMD_TARGET/omarchy-live-wallpaper.service"
  echo "Uninstallation complete."
}

case "${1:-check}" in
  check) check_deps ;;
  install) do_install ;;
  update) do_install ;;
  status) do_status ;;
  stop) do_stop ;;
  uninstall) do_uninstall ;;
  *)
    echo "Usage: $0 {check|install|update|status|stop|uninstall} [--dry-run]"
    exit 1
    ;;
esac
