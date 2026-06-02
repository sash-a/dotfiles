# Automated install (Ubuntu)

Instead of running the steps above by hand, run:
```bash
bash ~/ubuntu-setup.sh
```
This is idempotent (safe to re-run) and does everything above + VS Code + build
tools/common utils + an apt update/upgrade + `brew bundle install`.

Notes:
- After it finishes: restart your shell, run `sudo tailscale up`, and (once your
  GitHub SSH key is set up) uncomment `setup_dotfiles` in the script to pull dotfiles.

# Manual install:
## Bare github repo
```bash
cd ~
echo "dotfiles" >> .gitignore
git clone --bare git@github.com:sash-a/dotfiles.git $HOME/dotfiles/
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dotfiles checkout
```

## Flatpaks
Visit: https://flatpak.org/setup/

## Packages needed not in brewfile
- zsh
- tailscale
- ghostty
- homebrew

### zsh
```
sudo apt install zsh
chsh -s /bin/zsh
```

### tailscale
```
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

### ghostty
```
sudo add-apt-repository ppa:mkasberg/ghostty-ubuntu
sudo apt update
sudo apt install ghostty
```

### homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### claude code
```
curl -fsSL https://claude.ai/install.sh | bash
```

## Install all other apps

```
brew bundle install
```

## Nerd fonts

Installed by `ubuntu-setup.sh` (JetBrainsMono + FiraCode, from the nerd-fonts releases).
