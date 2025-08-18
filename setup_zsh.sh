#!/bin/bash

# ================================
# Kali Setup Script with Troubleshooting
# ================================

# --- Section 1: Troubleshooting / Pre-checks ---

echo "==> Checking network connectivity..."
if ping -c 2 google.com >/dev/null 2>&1; then
    echo "Network: OK"
else
    echo "Network: FAILED - check your connection!"
fi

echo "==> Checking DNS resolution..."
if host google.com >/dev/null 2>&1; then
    echo "DNS: OK"
else
    echo "DNS: FAILED - fixing /etc/resolv.conf"
    sudo rm -f /etc/resolv.conf
    echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" | sudo tee /etc/resolv.conf
    sudo chattr +i /etc/resolv.conf
    echo "DNS fixed to 8.8.8.8 and 1.1.1.1"
fi

# --- Section 2: System Update & Packages ---

echo "==> Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y

echo "==> Installing flameshot..."
sudo apt install -y flameshot git

# --- Section 3: Clone PEASS-ng repository ---

PEASS_DIR="$HOME/PEASS-ng"
if [ -d "$PEASS_DIR" ]; then
    echo "PEASS-ng directory already exists at $PEASS_DIR. Pulling latest changes..."
    git -C "$PEASS_DIR" pull
else
    echo "Cloning PEASS-ng repository..."
    git clone https://github.com/peass-ng/PEASS-ng.git "$PEASS_DIR"
fi

# --- Section 4: Zsh Prompt Setup ---

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.bak_$(date +%Y%m%d_%H%M%S)"
echo "==> Backing up existing .zshrc to $BACKUP"
cp "$ZSHRC" "$BACKUP" 2>/dev/null

echo "==> Applying custom Zsh prompt..."
cat << 'EOF' >> "$ZSHRC"

# --- Custom Hacker Prompt ---
autoload -U colors && colors
setopt PROMPT_SUBST

# Red text for user/root, yellow for directories, date before $
PROMPT='%F{red}%n%f@%m-[%F{yellow}%~%f]
%F{white}[%D{%Y-%m-%d %H:%M:%S}]%f $ '

EOF

echo "Setup complete! Restart your terminal or run 'source ~/.zshrc' to apply prompt."
