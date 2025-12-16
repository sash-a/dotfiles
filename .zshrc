#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Clone antidote if necessary.
if [[ ! -d $HOME/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Load plugins
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

export TERM="xterm-256color" # This sets up colors properly
export SHELL=/usr/bin/zsh
export EDITOR=nvim
source ~/.profile

# Activate homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Point to the correct ZSH otherwise it picks /usr/bin/zsh
SHELL=/home/linuxbrew/.linuxbrew/bin/zsh

# History suggestion options
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt appendhistory
setopt share_history          # share command history data
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
# setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# Up/Down search history given current entered text
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
# Correct delete key behaviour
bindkey "^[[3~" delete-char

# nvim alias
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias nv="nvim ."
alias lg="lazygit"
alias ca="conda activate"

# git dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# cli tools
alias cat="bat"
alias ll="eza --icons=always -1"
eval "$(zoxide init zsh --cmd=cd)"
source <(fzf --zsh)

# shortcuts
# alias sv="source .venv/bin/activate"
sv() {
    source "${1:-.venv}/bin/activate"
}
alias se="source .env"

# Sync using mutagen - assumes that directory structure is the same on this and other PC and you want to sync the current directory
# For safety you can only sync folders within ~/Documents/
# Example `msync homepc` or `msync 127.0.0.1`
# Requires that mutagen is installed: https://mutagen.io/documentation/introduction/
# And device is on the same tailscale network: https://login.tailscale.com/admin/machines
# `sudo tailscale up`
msync() {
    if [[ "$PWD" != "$HOME/Documents/"* ]]; then
        echo "⛔️ Safety Lock Engaged"
        echo "   You are currently in: $PWD"
        echo "   Allowed: Only subfolders inside ~/Documents (e.g., ~/Documents/MyProject)"
        return 1
    fi

    # 1. Get the current folder name for the session ID
    local folder="${PWD##*/}"

    # 2. Convert absolute path to tilde path for the remote
    local path="${PWD/#$HOME/~}"

    # 3. Run Mutagen
    /home/linuxbrew/.linuxbrew/bin/mutagen sync create --name="$folder" "$path" "$1:$path"
}

# Terminate mutagen session in current folder
mterm() {
    local folder="${PWD##*/}"
    /home/linuxbrew/.linuxbrew/bin/mutagen sync terminate "$folder"
    echo "Terminated mutagen session $folder"
}

# fzf-tab completion
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always -1 $realpath'
 
# Home/end/forward/back word is blocked by one of the plugins
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# swap capslock and escape
# /usr/bin/setxkbmap -option "caps:swapescape"

# JAX
# XLA_PYTHON_CLIENT_PREALLOCATE=false
# XLA_PYTHON_CLIENT_MEM_FRACTION=.6


# Secrets
source ~/.env

# PATH
export PATH=$PATH:~/bin:~/.local/bin
export EZA_CONFIG_DIR=~/.config/eza/
export NVM_DIR="$HOME/.nvm"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/var/home/sash/google-cloud-sdk/path.zsh.inc' ]; then . '/var/home/sash/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/var/home/sash/google-cloud-sdk/completion.zsh.inc' ]; then . '/var/home/sash/google-cloud-sdk/completion.zsh.inc'; fi

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
