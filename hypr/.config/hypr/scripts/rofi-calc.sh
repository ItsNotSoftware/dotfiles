#!/usr/bin/env bash
set -euo pipefail

theme="${HOME}/.config/rofi/themes/system-utility.rasi"
inline_theme='window { width: 560px; }
listview { lines: 8; }
inputbar { children: [ "prompt", "entry" ]; }
entry { placeholder: "2+2"; }'

have_rofi_calc_mode() {
  command -v rofi >/dev/null 2>&1 || return 1
  rofi -help 2>&1 | grep -Eq '(^|[[:space:]])calc([[:space:]]|$)'
}

if have_rofi_calc_mode; then
  # Arch rofi-calc installs a plugin (.so), so detect the mode via rofi itself.
  rofi_cmd=(rofi -show calc -modi calc -display-calc " " -no-sort)
  [[ -f "$theme" ]] && rofi_cmd+=(-theme "$theme")
  rofi_cmd+=(-theme-str "$inline_theme")
  exec "${rofi_cmd[@]}"
fi

if command -v qalc >/dev/null 2>&1; then
  if command -v rofi >/dev/null 2>&1; then
    rofi_prompt_cmd=(rofi -dmenu -p "=")
    [[ -f "$theme" ]] && rofi_prompt_cmd+=(-theme "$theme")
    rofi_prompt_cmd+=(-theme-str 'window { width: 560px; } listview { lines: 1; } entry { placeholder: "2+2"; }')
    expr="$(printf '' | "${rofi_prompt_cmd[@]}" || true)"
  else
    expr=""
  fi
  [[ -z "${expr}" ]] && exit 0
  result="$(qalc -t "$expr" 2>/dev/null | tail -n1 || true)"
  [[ -n "$result" ]] && notify-send -a "calc" -r 991022 "Result" "$result"
  exit 0
fi

notify-send -a "calc" "Calculator unavailable" "Install rofi-calc (plugin mode) or qalc."
