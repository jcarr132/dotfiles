# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups

export PATH=$DOTFILES/scripts:$PATH
export PATH=$DOTFILES/scripts/todo.txt:$PATH
export PATH=$HOME/go/bin:/usr/local/go/bin:$PATH
export PATH=$HOME/.poetry/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=/home/jc/.local/bin:$PATH

export EDITOR=/usr/bin/nvim
export BROWSER=firefox
export DOTFILES=$HOME/dotfiles
export VIMWIKI=$HOME/cloud/vimwiki
export VIM_CMD=/usr/bin/nvim-qt
export GOPATH=$HOME/go
export CLOUD=$HOME/cloud

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_QPA_PLATFORMTHEME=gtk2
export QT_QPA_PLATFORMTHEME=gtk2

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
set -o vi
export KEYTIMEOUT=1
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
           [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
             [[ ${KEYMAP} == viins ]] ||
             [[ ${KEYMAP} = '' ]] ||
             [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# import things
source ~/.sh_aliases

# plugins
source ~/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle agkozak/zsh-z
antigen bundle hlissner/zsh-autopair
antigen bundle peterhurford/up.zsh
antigen bundle mafredri/zsh-async
antigen bundle subnixr/minimal
antigen bundle ohmyzsh/ohmyzsh path:plugins/git-auto-fetch

antigen theme nord
antigen apply

# start tmux
[[ $TERM != "screen" ]] && exec tmux

export PATH="$HOME/.poetry/bin:$PATH"
