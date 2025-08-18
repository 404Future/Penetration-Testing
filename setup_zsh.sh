#!/bin/bash

# ─── System Update & Upgrade ─────────────────────────────
echo "[*] Updating system..."
sudo apt update && sudo apt -y upgrade

# ─── Install Zsh ───────────────────────────────────────
echo "[*] Installing Zsh if not present..."
sudo apt install -y zsh git curl

# ─── Install Flameshot ─────────────────────────────────
echo "[*] Installing Flameshot..."
sudo apt install -y flameshot

# ─── Configure Zsh Prompt ──────────────────────────────
echo "[*] Configuring Zsh prompt..."
cat << 'EOF' >> ~/.zshrc

# ─── Custom Hacker Prompt ────────────────────────────────
if [[ $EUID -eq 0 ]]; then
    # Root prompt (all red, dir in yellow for contrast)
    PROMPT=$'%F{red}┌──(%n㉿%m)-[%F{yellow}%~%F{red}]\n└─[%D{%Y-%m-%d %H:%M:%S}] %# %f'
else
    # Normal user prompt (white, dir in yellow)
    PROMPT=$'┌──(%n㉿%m)-[%F{yellow}%~%f]\n└─[%D{%Y-%m-%d %H:%M:%S}] %# '
fi
# ─────────────────────────────────────────────────────────

EOF

echo "[*] Setup complete! Reloading Zsh..."
exec zsh

