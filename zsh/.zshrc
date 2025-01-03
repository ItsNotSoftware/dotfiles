
. "$HOME/.local/bin/env"

source .pyenv/bin/activate

alias wm_class="xprop | grep "WM_CLASS"" 
alias ls="eza --icons"
alias la="eza -la --icons"
alias usettings="export XDG_CURRENT_DESKTOP=GNOME && gnome-control-center && XDG_CURRENT_DESKTOP=i3" 
alias monitor_arrange="xrandr --output eDP-1 --auto --output HDMI-1-0 --auto --left-of eDP-1"
alias restart_lm="xrandr --output eDP-1 --off && xrandr ''output eDP-1 --auto"

clear
neofetch 

