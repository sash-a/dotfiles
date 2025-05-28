# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color" # This sets up colors properly

# set shell
export SHELL=/usr/bin/zsh
source ~/.profile

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

DISABLE_MAGIC_FUNCTIONS=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true

# Autosuggestion options
HISTSIZE=5000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# fzf-tab completion
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always -1 $realpath'

plugins=(zsh-autosuggestions git zsh-syntax-highlighting fzf-tab)

source $ZSH/oh-my-zsh.sh

# nvim alias
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias nv="nvim ."
alias lg="lazygit"
alias ca="conda activate"

# git dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# spotify
alias ncspot="flatpak run io.github.hrkfdn.ncspot"

# cli tools
alias cat="batcat"
alias ll="eza --icons=always -1"
eval "$(zoxide init zsh --cmd=cd)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# swap capslock and escape
# /usr/bin/setxkbmap -option "caps:swapescape"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# JAX
# XLA_PYTHON_CLIENT_PREALLOCATE=false
# XLA_PYTHON_CLIENT_MEM_FRACTION=.6

# PATH
export PATH=$PATH:~/bin:~/.local/bin
source ~/.env
export QTILE_DEVICE_TYPE=desktop
export EZA_CONFIG_DIR=~/.config/eza/


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/home/sash/.ghcup/env" ] && source "/home/sash/.ghcup/env" # ghcup-env

. "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/sash/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

