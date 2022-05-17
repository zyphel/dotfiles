##### .zshrc #####

export TERMINAL=alacritty
export EDITOR=/usr/bin/nvim
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' # Ignore case completion

# History in cache directory
REPORTTIME=3
HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
#setopt CORRECT_ALL

# Autocompletion
autoload -U compinit
compinit

# lfcd where you landed
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

# fzf - fuzzy search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf - open file in vim
bindkey -s '^o' 'nvim $(fzf)^M'

alias ..='cd ..'
alias ...='cd ../..'
alias cm='cmatrix -u 10'
alias ct='crontab -e'
alias aconf='nvim ~/.config/alacritty/alacritty.yml'
alias btm='btm --color gruvbox'
alias iconf='nvim ~/.config/i3/config'
alias jconf='nvim ~/.config/jrnl/jrnl.yaml'
alias pconf='nvim ~/.config/polybar/config.ini'
alias rconf='nvim ~/.config/rofi/config.rasi'
alias sconf='nvim ~/.config/starship.toml'
alias vconf='nvim ~/.config/nvim/init.vim'
alias zconf='nvim ~/.zshrc'
alias ee='espanso edit'
alias er='espanso restart'
alias fe='cd ~/Dropbox/LaTeX/fe-draft/ && ls'
alias latex='cd ~/Dropbox/LaTeX'
alias lf='lfcd'
alias ls='ls --color=auto'
alias lsblk='lsblk -e 7'
alias n='cd ~/Dropbox/notes && clear'
alias nf='neofetch'
alias q='exit'
alias rm='rm -i' # make rm safe - will ask are you sure?
alias smith='cd /run/media/jeff/smith/'
alias update='yay'
alias v='nvim'
alias vbib='nvim ~/Dropbox/LaTeX/references.bib'
alias vfe='nvim ~/Dropbox/LaTeX/fe-draft/fe-draft.tex'
alias vjrnl='nvim ~/Dropbox/jrnl/journal.txt'

# Starship prompt
eval "$(starship init zsh)"
