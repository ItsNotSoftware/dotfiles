#!/usr/bin/env sh

state_file="${XDG_CACHE_HOME:-$HOME/.cache}/hypridle-disabled"

set_state() {
    if [ "$1" = "off" ]; then
        mkdir -p "$(dirname "$state_file")"
        touch "$state_file"
    else
        rm -f "$state_file"
    fi
}

print_status() {
    if [ -f "$state_file" ]; then
        echo true
    else
        echo false
    fi
}

case "${1:-toggle}" in
    status)
        print_status
        ;;
    on)
        set_state on
        ;;
    off)
        set_state off
        ;;
    toggle)
        if [ -f "$state_file" ]; then
            set_state on
        else
            set_state off
        fi
        ;;
    *)
        echo "usage: $0 [status|on|off|toggle]" >&2
        exit 1
        ;;
esac
