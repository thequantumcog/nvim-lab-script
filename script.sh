#!/bin/bash
set -e

mkdir -p "$HOME/.local/bin"
cd /tmp

sudo apt update
sudo apt install -y git kitty wl-clipboard curl

wget -q https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz

rm -rf "$HOME/.local/nvim"
mv nvim-linux-x86_64 "$HOME/.local/nvim"

ln -sf "$HOME/.local/nvim/bin/nvim" "$HOME/.local/bin/nvim"

grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

rm -rf "$HOME/.config/nvim"
git clone https://github.com/nvim-lua/kickstart.nvim.git \
  "$HOME/.config/nvim" --depth=1


# Swap Caps Lock and Escape (GNOME / Wayland safe)
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"


sed -i 's/^\s*--\s*clangd = {}/  clangd = {}/' ~/.config/nvim/init.lua
sed -i "/'stylua',/a\        'clangd'," ~/.config/nvim/init.lua
sed -i "/'stylua',/ {x;d;}; x" ~/.config/nvim/init.lua
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 33
export PATH="$HOME/.local/bin:$PATH"
echo "Done. Restart terminal or log out for key swap to fully apply."

