#!/bin/bash
set -e

mkdir -p "$HOME/.local/bin"
cd /tmp

sudo apt update
sudo apt install -y git kitty wl-clipboard curl ripgrep

wget -q https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz

rm -rf "$HOME/.local/nvim"
mv nvim-linux-x86_64 "$HOME/.local/nvim"

ln -sf "$HOME/.local/nvim/bin/nvim" "$HOME/.local/bin/nvim"

grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

rm -rf "$HOME/.config/nvim"
git clone https://github.com/thequantumcog/nvim-lab-script.git \
  "$HOME/.config/nvim" --depth=1


# Swap Caps Lock and Escape (GNOME / Wayland safe)
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"


gsettings set org.gnome.desktop.peripherals.keyboard delay 250
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 33
export PATH="$HOME/.local/bin:$PATH"

mkdir -p ~/.config/kitty/
mv ~/.config/nvim/kitty.conf ~/.config/kitty/

mkdir -p "$HOME/.local/share/fonts"
cd "$HOME/.local/share/fonts"

wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.tar.xz
tar -xJf FiraCode.tar.xz
rm FiraCode.tar.xz

fc-cache -vf
cd -


echo "Done. Restart terminal or log out for key swap to fully apply."

