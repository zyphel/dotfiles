# ----- zshrc -------------------------------------------------------

export TERMINAL=alacritty
export EDITOR=/usr/bin/nvim

neofetch --source ~/Documents/neofetch.ascii

# Ignore case completion
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' 

# ----- modern completion system (from https://github.com/theteachr)

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

typeset -A ZSH_HIGHLIGHT_STYLES

# ----- cache directory history -------------------------------------

REPORTTIME=3
HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
#setopt CORRECT_ALL

# ----- lfcd where you landed ---------------------------------------

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# ----- fzf - fuzzy search ------------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----- fzf - open file in nvim --------------------------------------

bindkey -s '^o' 'nvim $(fzf)^M'

# ----- alias -------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias cdd='cd && clear'
alias cm='cmatrix -u 10'
alias ct='crontab -e'
alias aconf='nvim ~/.config/alacritty/alacritty.yml'
alias btm='btm --color gruvbox'
alias ee='espanso edit'
alias er='espanso restart'
alias fe='cd ~/SynologyDrive/LaTeX/fe-draft/ && ls'
alias ff='fastfetch'
alias hcd='cd ~/zyphel && hugo server -D'
alias latex='cd ~/Dropbox/LaTeX'
alias lf='lfcd'
alias ls='ls --color=auto'
alias lsblk='lsblk -e 7'
alias n='cd ~/SynologyDrive/NOTES'
alias neofetch='neofetch --source ~/Documents/neofetch.ascii'
alias nf='neofetch --source ~/Documents/neofetch.ascii'
alias q='exit'
alias rm='rm -i'	# make rm safe - will ask are you sure?
alias smith='cd /run/media/jeff/smith/'
alias update='yay'
alias v='nvim'
alias vbib='nvim ~/SynologyDrive/LaTeX/references.bib'
alias vfe='nvim ~/SynologyDrive/LaTeX/fe-draft/fe-draft.tex'
alias vjrnl='nvim ~/SynologyDrive/jrnl/journal.txt'
alias vtasks='nvim ~/SynologyDrive/TASKS/todo.txt'

# ----- config alias ------------------------------------------------

alias iconf='nvim ~/.config/i3/config'
alias jconf='nvim ~/.config/jrnl/jrnl.yaml'
alias kconf='nvim ~/.config/kitty/kitty.conf'
alias pconf='nvim ~/.config/polybar/config.ini'
alias rconf='nvim ~/.config/rofi/config.rasi'
alias sconf='nvim ~/.config/starship.toml'
alias xconf='nvim ~/.config/sxhkd/sxhkdrc'
alias vconf='nvim ~/.config/nvim/init.vim'
alias zconf='nvim ~/.zshrc'

# ----- Starship prompt ---------------------------------------------

eval "$(starship init zsh)"
