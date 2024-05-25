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


plugins=(zsh-autosuggestions git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# TILIX
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# nvim alias
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias nv="nvim ."
alias lg="lazygit"
alias ca="conda activate"

# git dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# swap capslock and escape
/usr/bin/setxkbmap -option "caps:swapescape"

# MUJOCO
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/sasha/.mujoco/mujoco200/bin
# export MUJOCO_KEY_PATH=/home/sasha/.mujoco/mjkey.txt
# export MUJOCO_PY_MJPRO_PATH=/home/sasha/.mujoco/mjpro131
# export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libGLEW.so

# Tensorflow datasets
export TFDS_DATA_DIR=~/tensorflow_datasets
# JAX
XLA_PYTHON_CLIENT_PREALLOCATE=false
# XLA_PYTHON_CLIENT_MEM_FRACTION=.6
# PATH
export PATH=$PATH:~/bin:~/.local/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sash/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sash/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sash/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sash/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/home/sash/.ghcup/env" ] && source "/home/sash/.ghcup/env" # ghcup-env

