#!/usr/bin/env bash
#
# Fedora setup script — installs everything described in README.md.
# (Fedora port of ~/setup.sh, which targets CachyOS/Arch.)
#
# Idempotent: safe to re-run. Each step checks whether it's already done.
# Usage:  bash ~/setup-fedora.sh
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
DNF_Y=(sudo dnf install -y)

# Keep sudo alive for the duration of the script.
log "Requesting sudo (cached for the rest of the run)"
sudo -v
while true; do sudo -n true; sleep 50; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &

# Enable a COPR repo, installing whichever dnf plugin package provides `copr`.
copr_enable() {
  local repo="$1"
  if ! sudo dnf copr list 2>/dev/null | grep -q "$repo"; then
    sudo dnf install -y dnf-plugins-core >/dev/null 2>&1 || \
      sudo dnf install -y dnf5-plugins >/dev/null 2>&1
    sudo dnf copr enable -y "$repo" || return 1
  fi
}

# ----------------------------------------------------------------------------
# 1. base system: update + build tools + common utils
# ----------------------------------------------------------------------------
base_system() {
  log "Updating system and installing development tools / common utils"
  # Upgrade everything already installed
  sudo dnf upgrade -y

  # @development-tools is Fedora's base-devel equivalent.
  # util-linux-user provides chsh (not installed by default on Fedora).
  "${DNF_Y[@]}" @development-tools
  "${DNF_Y[@]}" \
    gcc-c++ make procps-ng curl file git wget unzip ca-certificates \
    pkgconf-pkg-config openssl openssl-devel python3 python3-pip \
    htop tree jq fontconfig util-linux-user
  ok "base system packages installed"
}

# ----------------------------------------------------------------------------
# 2. zsh + make it the default shell
# ----------------------------------------------------------------------------
setup_zsh() {
  log "Installing zsh"
  "${DNF_Y[@]}" zsh
  if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$(command -v zsh)" ]; then
    log "Setting zsh as default shell (may prompt for password)"
    sudo chsh -s "$(command -v zsh)" "$USER" || \
      sudo usermod -s "$(command -v zsh)" "$USER"
  fi
  ok "zsh ready (log out/in for the shell change to take effect)"
}

# ----------------------------------------------------------------------------
# 3. flatpak
# ----------------------------------------------------------------------------
setup_flatpak() {
  log "Installing flatpak"
  "${DNF_Y[@]}" flatpak
  sudo flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
  # Fedora ships flathub pre-filtered to a subset — unfilter it.
  sudo flatpak remote-modify --no-filter --enable flathub 2>/dev/null || true
  ok "flatpak ready"
}

# ----------------------------------------------------------------------------
# 4. tailscale
# ----------------------------------------------------------------------------
setup_tailscale() {
  if have tailscale; then ok "tailscale already installed"; return; fi
  log "Installing tailscale via the official install script"
  curl -fsSL https://tailscale.com/install.sh | sh || { err "tailscale install failed"; return; }
  sudo systemctl enable --now tailscaled
  warn "Run 'sudo tailscale up' manually to authenticate"
}

# ----------------------------------------------------------------------------
# 5. ghostty (terminal)
# ----------------------------------------------------------------------------
setup_ghostty() {
  if have ghostty; then ok "ghostty already installed"; return; fi
  log "Installing ghostty"
  # In Fedora's repos on recent releases; COPR otherwise.
  if "${DNF_Y[@]}" ghostty; then
    ok "ghostty installed from Fedora repos"
  elif copr_enable scottames/ghostty && "${DNF_Y[@]}" ghostty; then
    ok "ghostty installed from COPR (scottames/ghostty)"
  else
    warn "ghostty install failed — install it manually"
  fi
}

# ----------------------------------------------------------------------------
# 6. VS Code (official Microsoft yum repo)
# ----------------------------------------------------------------------------
setup_vscode() {
  if have code; then ok "vscode already installed"; return; fi
  log "Installing VS Code from the Microsoft repo"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
    sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'REPO'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
REPO
  fi
  "${DNF_Y[@]}" code && ok "vscode installed"
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
# 11. dotfiles (bare repo)
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
# 12. keyd — remap caps<->escape, caps acts as control when held.
# ----------------------------------------------------------------------------
setup_keyd() {
  if ! have keyd; then
    log "Installing keyd"
    if ! "${DNF_Y[@]}" keyd; then
      copr_enable alternateved/keyd && "${DNF_Y[@]}" keyd
    fi
  else
    ok "keyd already installed"
  fi
  have keyd || { warn "keyd not installed — skipping config"; return; }
  if [ ! -f "$HOME/.config/keyd/default.conf" ]; then
    warn "no ~/.config/keyd/default.conf (comes from dotfiles) — skipping config"
    return
  fi
  log "Installing keyd config to /etc/keyd/default.conf"
  sudo mkdir -p /etc/keyd
  sudo cp "$HOME/.config/keyd/default.conf" /etc/keyd/default.conf
  sudo systemctl enable keyd
  sudo systemctl restart keyd
  ok "keyd active (caps=esc/ctrl, esc=caps)"
}

# ----------------------------------------------------------------------------
# 13. cleanup — ensure ~/.env exists (sourced by .zshrc)
# ----------------------------------------------------------------------------
cleanup() {
  if [ ! -f "$HOME/.env" ]; then
    log "Creating empty ~/.env (required by .zshrc)"
    touch "$HOME/.env"
  fi
  ok "~/.env present"
}

# ----------------------------------------------------------------------------
# main
# ----------------------------------------------------------------------------
base_system
setup_zsh
setup_flatpak
setup_tailscale
setup_ghostty
setup_vscode
setup_dotfiles
setup_homebrew
setup_claude
setup_nerd_fonts
install_packages
setup_keyd
cleanup

log "Final package manager cleanup"
# Drops cached packages to save space
sudo dnf clean packages

echo
ok "Done! Next steps:"
echo "   - Restart your shell (or log out/in) to pick up zsh + brew on PATH"
echo "   - Run 'sudo tailscale up' to authenticate tailscale"
echo "   - Set up your GitHub SSH key, then re-run this script to fetch dotfiles"
