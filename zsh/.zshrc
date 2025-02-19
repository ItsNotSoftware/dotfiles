if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

. "$HOME/.local/bin/env"
export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker copyfile)


source $ZSH/oh-my-zsh.sh
source ~/.pyenv/bin/activate

alias wm_class="xprop | grep 'WM_CLASS'"
alias ls="eza --icons"
alias la="eza -la --icons"
alias usettings="export XDG_CURRENT_DESKTOP=GNOME && gnome-control-center && XDG_CURRENT_DESKTOP=i3"
alias mm="xrandr --output eDP-1 --auto --output HDMI-1-0 --auto --left-of eDP-1"
alias restart_lm="xrandr --output eDP-1 --off && xrandr ''output eDP-1 --auto"
alias kbl='function _kbl() { echo $1 | sudo tee /sys/class/leds/platform::kbd_backlight/brightness; }; _kbl'
alias unreal="~/Applications/Linux_Unreal_Engine_5.5.1/Engine/Binaries/Linux/UnrealEditor &"
alias blender="~/Applications/blender-4.3.2/blender &"
alias matlab="/usr/local/MATLAB/R2025a/bin/matlab &"



