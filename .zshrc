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

# Autosuggestion options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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
alias sv="source .venv/bin/activate"
alias se="source .env"

# fzf-tab completion
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always -1 $realpath'

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
