#!/usr/bin/env bash
set -euo pipefail

command -v rofi >/dev/null 2>&1 || exit 0
theme="${HOME}/.config/rofi/themes/system-utility.rasi"

send_paste_shortcut() {
  # Prefer Wayland-native key injection when available.
  if command -v wtype >/dev/null 2>&1; then
    sleep 0.08
    wtype -M ctrl v -m ctrl >/dev/null 2>&1 && return 0
  fi

  # Fallback: ydotool (requires ydotoold).
  if command -v ydotool >/dev/null 2>&1; then
    sleep 0.08
    ydotool key 29:1 47:1 47:0 29:0 >/dev/null 2>&1 && return 0
  fi

  return 1
}

if ! command -v cliphist >/dev/null 2>&1; then
  notify-send -a "clipboard" "cliphist missing" "Install cliphist to use clipboard history launcher."
  exit 0
fi

if ! command -v wl-copy >/dev/null 2>&1; then
  notify-send -a "clipboard" "wl-copy missing" "Install wl-clipboard to copy selected entries."
  exit 0
fi

if command -v wl-paste >/dev/null 2>&1; then
  pgrep -f "wl-paste --type text --watch cliphist store" >/dev/null || \
    (wl-paste --type text --watch cliphist store >/dev/null 2>&1 &)
  pgrep -f "wl-paste --type image --watch cliphist store" >/dev/null || \
    (wl-paste --type image --watch cliphist store >/dev/null 2>&1 &)
fi

history="$(cliphist list || true)"
if [[ -z "${history}" ]]; then
  notify-send -a "clipboard" -r 991021 "Clipboard history is empty" \
    "Copy something first. If this persists, restart Hyprland (exec-once cliphist watcher)."
  exit 0
fi

rofi_cmd=(rofi -dmenu -i -p "Clip")
[[ -f "$theme" ]] && rofi_cmd+=(-theme "$theme")
rofi_cmd+=(-theme-str 'entry { placeholder: "Search"; } listview { lines: 8; }')
selection="$(printf '%s\n' "$history" | "${rofi_cmd[@]}" || true)"

[[ -z "${selection}" ]] && exit 0

if cliphist decode <<<"$selection" | wl-copy; then
  if send_paste_shortcut; then
    notify-send -a "clipboard" -r 991021 "Clipboard" "Pasted selected entry"
  else
    notify-send -a "clipboard" -r 991021 "Clipboard" \
      "Copied selected entry (install wtype for auto-paste)"
  fi
else
  notify-send -a "clipboard" -r 991021 "Clipboard" "Failed to decode selected entry"
fi
