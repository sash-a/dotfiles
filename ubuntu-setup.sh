#!/usr/bin/env bash
#
# Ubuntu setup script — installs everything described in README.md.
#
# Idempotent: safe to re-run. Each step checks whether it's already done.
# Usage:  bash ~/ubuntu-setup.sh
#
set -uo pipefail

# ----------------------------------------------------------------------------
# helpers
# ----------------------------------------------------------------------------
BLUE='\033[1;34m'; GREEN='\033[1;32m'; YELLOW='\033[1;33m'; RED='\033[1;31m'; NC='\033[0m'
log()  { echo -e "${BLUE}==>${NC} $*"; }
ok()   { echo -e "${GREEN}  ok${NC} $*"; }
warn() { echo -e "${YELLOW}  !!${NC} $*"; }
err()  { echo -e "${RED} err${NC} $*"; }
have() { command -v "$1" >/dev/null 2>&1; }

BREWFILE="$HOME/Brewfile"

# Keep sudo alive for the duration of the script.
log "Requesting sudo (cached for the rest of the run)"
sudo -v
while true; do sudo -n true; sleep 50; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &

# ----------------------------------------------------------------------------
# 1. base system: update + build tools + common utils
# ----------------------------------------------------------------------------
base_system() {
  log "Updating apt and installing build tools / common utils"
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y \
    build-essential procps curl file git wget unzip ca-certificates gnupg \
    software-properties-common apt-transport-https \
    pkg-config libssl-dev python3 python3-pip python3-venv \
    htop tree jq fontconfig
  ok "base system packages installed"
}

# ----------------------------------------------------------------------------
# 2. zsh + make it the default shell
# ----------------------------------------------------------------------------
setup_zsh() {
  log "Installing zsh"
  sudo apt-get install -y zsh
  if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$(command -v zsh)" ]; then
    log "Setting zsh as default shell (may prompt for password)"
    sudo chsh -s "$(command -v zsh)" "$USER"
  fi
  ok "zsh ready (log out/in for the shell change to take effect)"
}

# ----------------------------------------------------------------------------
# 3. flatpak + flathub
# ----------------------------------------------------------------------------
setup_flatpak() {
  log "Installing flatpak + flathub remote"
  sudo apt-get install -y flatpak gnome-software-plugin-flatpak
  sudo flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
  ok "flatpak ready"
}

# ----------------------------------------------------------------------------
# 4. tailscale
# ----------------------------------------------------------------------------
setup_tailscale() {
  if have tailscale; then ok "tailscale already installed"; return; fi
  log "Installing tailscale"
  curl -fsSL https://tailscale.com/install.sh | sh
  warn "Run 'sudo tailscale up' manually to authenticate"
}

# ----------------------------------------------------------------------------
# 5. ghostty (terminal) via PPA
# ----------------------------------------------------------------------------
setup_ghostty() {
  if have ghostty; then ok "ghostty already installed"; return; fi
  log "Installing ghostty from PPA"
  sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
  sudo apt-get update -y
  sudo apt-get install -y ghostty
  ok "ghostty installed"
}

# ----------------------------------------------------------------------------
# 6. VS Code (Microsoft apt repo) — also gives us the `code` CLI that
#    `brew bundle` needs to install the vscode extensions in the Brewfile.
# ----------------------------------------------------------------------------
setup_vscode() {
  if have code; then ok "vscode already installed"; return; fi
  log "Installing VS Code from Microsoft apt repo"
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | sudo tee /etc/apt/keyrings/packages.microsoft.gpg >/dev/null
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
  sudo apt-get install -y apt-transport-https
  sudo apt-get update -y
  sudo apt-get install -y code
  ok "vscode installed"
}

# ----------------------------------------------------------------------------
# 7. Homebrew
# ----------------------------------------------------------------------------
setup_homebrew() {
  if ! have brew; then
    log "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    ok "homebrew already installed"
  fi
  # Put brew on PATH for the rest of this script and for future shells.
  local brew_bin=/home/linuxbrew/.linuxbrew/bin/brew
  [ -x "$brew_bin" ] || brew_bin="$HOME/.linuxbrew/bin/brew"
  if [ -x "$brew_bin" ]; then
    eval "$("$brew_bin" shellenv)"
    local line="eval \"\$($brew_bin shellenv)\""
    grep -qxF "$line" "$HOME/.zprofile" 2>/dev/null || echo "$line" >> "$HOME/.zprofile"
  fi
}

# ----------------------------------------------------------------------------
# 8. Claude Code
# ----------------------------------------------------------------------------
setup_claude() {
  if have claude; then ok "claude code already installed"; return; fi
  log "Installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash
}

# ----------------------------------------------------------------------------
# 9. Nerd Fonts (JetBrainsMono + FiraCode)
# ----------------------------------------------------------------------------
setup_nerd_fonts() {
  log "Installing Nerd Fonts"
  local font_dir="$HOME/.local/share/fonts"
  mkdir -p "$font_dir"
  local base="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"
  for font in JetBrainsMono FiraCode; do
    if ls "$font_dir"/*"${font}"* >/dev/null 2>&1; then
      ok "$font Nerd Font already present"; continue
    fi
    log "  downloading $font Nerd Font"
    local tmp; tmp="$(mktemp -d)"
    if curl -fsSL "$base/${font}.zip" -o "$tmp/${font}.zip"; then
      unzip -oq "$tmp/${font}.zip" -d "$font_dir" -x "*.txt" "*.md"
    else
      warn "failed to download $font Nerd Font"
    fi
    rm -rf "$tmp"
  done
  fc-cache -f "$font_dir" >/dev/null 2>&1 || true
  ok "nerd fonts installed"
}

# ----------------------------------------------------------------------------
# 10. Install everything in the Brewfile
# ----------------------------------------------------------------------------
install_packages() {
  [ -f "$BREWFILE" ] || { err "no Brewfile at $BREWFILE — skipping"; return; }
  have brew || { err "brew not on PATH — skipping brew bundle"; return; }
  log "Running brew bundle"
  brew bundle install --file="$BREWFILE" || warn "brew bundle had failures"
}

# ----------------------------------------------------------------------------
# 11. dotfiles (bare repo) — optional, needs an SSH key registered with GitHub
# ----------------------------------------------------------------------------
setup_dotfiles() {
  if [ -d "$HOME/dotfiles" ]; then ok "dotfiles repo already present"; return; fi
  log "Cloning dotfiles bare repo (requires GitHub SSH access)"
  grep -qxF 'dotfiles' "$HOME/.gitignore" 2>/dev/null || echo "dotfiles" >> "$HOME/.gitignore"
  if git clone --bare git@github.com:sash-a/dotfiles.git "$HOME/dotfiles/"; then
    git --git-dir="$HOME/dotfiles/" --work-tree="$HOME" checkout -f
    ok "dotfiles checked out"
  else
    warn "dotfiles clone failed — set up your GitHub SSH key, then run:"
    warn "  git clone --bare git@github.com:sash-a/dotfiles.git \$HOME/dotfiles/"
    warn "  git --git-dir=\$HOME/dotfiles/ --work-tree=\$HOME checkout"
  fi
}

# ----------------------------------------------------------------------------
# main
# ----------------------------------------------------------------------------
mkdir -p /etc/apt/keyrings 2>/dev/null || sudo mkdir -p /etc/apt/keyrings

base_system
setup_zsh
setup_flatpak
setup_tailscale
setup_ghostty
setup_vscode
setup_homebrew
setup_claude
setup_nerd_fonts
install_packages
# setup_dotfiles   # uncomment once your GitHub SSH key is configured

log "Final apt cleanup"
sudo apt-get autoremove -y

echo
ok "Done! Next steps:"
echo "   - Restart your shell (or log out/in) to pick up zsh + brew on PATH"
echo "   - Run 'sudo tailscale up' to authenticate tailscale"
echo "   - Set up your GitHub SSH key, then run setup_dotfiles (uncomment in script)"
