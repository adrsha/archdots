set -U fish_greeting
export DISPLAY=:0
export ACCENT_COLOR=4A4541
export RUST_BACKTRACE=full
export MOZ_ENABLE_WAYLAND=1
export BACKGROUND_COLOR=000000
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
fish_add_path path $HOME/Scripts/
fish_add_path path $HOME/.config/emacs/bin
export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config
export SKIM_DEFAULT_OPTIONS=" --color=bg+:-1,spinner:5,fg:15,header:1,info:13,pointer:5,marker:1,prompt:13,fg+:5,border:0"
export FZF_DEFAULT_OPTS=" --color=bg+:-1,spinner:5,fg:15,header:1,info:13,pointer:5,marker:1,prompt:13,fg+:5,border:0"


if status is-interactive
	# Commands to run in interactive sessions can go here
	#  * Create missing directories in path when calling `mkdir`
	alias mkdir='mkdir -pv'
	alias rmm='rm -rvI'
	alias cpp='cp -R'
	alias cp='cp -i'
	alias o='~/Scripts/launch'
	alias mv='mv'
	alias fs='df -h -x squashfs -x tmpfs -x devtmpfs'
	
	# Other Simple aliases
	alias n='nvim'
	alias fc='nvim ~/.config/fish/config.fish'
	alias hc='nvim ~/.config/hypr/hyprland.conf'
	alias ac='nvim ~/.config/alacritty/alacritty.toml'
	alias f='cd (fd | fzf)'
	alias yay='yay --color=auto'
  alias pyv='python venv ./bin/activate.fish'
	alias ins='yay --color=auto -S'
	alias upd='yay --color=auto -Syu'
	alias calc='~/Codes/SHARKalculator/target/release/rustCalc'
	alias uni='yay --color=auto -Rcns'
	alias ls='lsd'
	alias nr='sudo systemctl restart NetworkManager --now'
	alias nm='nmtui'
	alias nc='ping google.com'
	alias ll='lsd -l'
	alias l='lsd -l'
	alias t='n ~/Notes/Todo.norg'
  alias fs='sudo du -h -d 2 | sort -rh'
	alias la='lsd -A'
	alias lf='lsd --tree --depth=1'
	alias lt='lsd --tree --depth=2'
	alias gitt='cat ~/Documents/gittoken | wl-copy'
  alias gpush='cat ~/Documents/gittoken | wl-copy; git push origin $(git branch --show-current)'
end

zoxide init fish --cmd c| source
