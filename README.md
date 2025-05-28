## Setup on new system
```bash
cd ~
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:sash-a/dotfiles.git $HOME/dotfiles/
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dotfiles checkout
```
## logind.conf

`logind.conf` should live in `/etc/systemd/logind.conf`. I configured it to suspend after 30 minutes.
