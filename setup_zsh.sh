#!/bin/bash

# Update + upgrade system
echo "[*] Updating system..."
sudo apt update && sudo apt -y upgrade

# Ensure zsh is installed
echo "[*] Installing zsh if not present..."
sudo apt install -y zsh

# Configure ~/.zshrc with custom prompt
echo "[*] Configuring Zsh prompt..."
cat << 'EOF' >> ~/.zshrc

# ─── Custom Hacker Prompt ────────────────────────────────
if [[ \$EUID -eq 0 ]]; then
    # Root prompt (all red, dir in yellow for contrast)
    PROMPT=$'%F{red}┌──(%n㉿%m)-[%F{yellow}%~%F{red}]\n└─[%D{%Y-%m-%d %H:%M:%S}] %# %f'
else
    # Normal user prompt (white, dir in yellow)
    PROMPT=$'┌──(%n㉿%m)-[%F{yellow}%~%f]\n└─[%D{%Y-%m-%d %H:%M:%S}] %# '
fi
# ─────────────────────────────────────────────────────────

EOF

echo "[*] Done! Reloading zsh..."
exec zsh
