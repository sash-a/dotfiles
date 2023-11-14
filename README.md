## Setup on new system
```bash
cd ~
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:sash-a/dotfiles.git $HOME/dotfiles/
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dotfiles checkout
```
