#!/bin/bash

# update system
sudo pacman -Syu

# install xmonad dependencies
sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf
# xnomad preparation
mkdir -p ~/.config/xmonad
mv ~/auto-xmonad-repo/xmonad.hs ~/.config/xmonad
cd ~/.config/xmonad
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
# add ~/.local/bin to $PATH in zsh
echo '# set PATH so it includes user local bin if it exists' >> ~/.zshrc
echo 'if [ -d $HOME/.local/bin ]; then' >> ~/.zshrc
echo '  PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc
source ~/.zshrc

# build xmonad using Stack
echo 'Building xmonad using Stack...'
sleep 3

# installing stack
sudo pacman -S stack
sleep 5
stack upgrade
stack init
# build xnomad
stack install
sleep 1
echo 'Xmonad is installed.'
cd ~/
