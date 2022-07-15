# NOTES: Installs git

# xmonad installation, following steps from https://xmonad.org/INSTALL.html
### installs xmonad dependencies
sudo pacman -S git xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf git
sleep 1
### xmonad preparation (dotfiles)
mkdir -p ~/.config/xmonad && cd ~/.config/xmonad
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
sleep 1
# build xmonad using Stack
## installing stack
sudo pacman -S stack
sleep 1
stack upgrade
sleep 1
stack init
sleep 2
