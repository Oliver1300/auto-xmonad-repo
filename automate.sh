#!/bin/bash

# https://youtu.be/JmPLbZQRgas?t=371

# update system
sudo pacman -Syu
# install dialog for displaying dialog boxes
sudo pacman -S --needed dialog os-prober cups
clear

dialog --backtitle "Automate script" --title "PREREQUISITES: git, zsh configured" --msgbox "This script automates the process for installing programs like xorg dependencies, nitrogen, picom, nano, alacritty, xmonad, lightdm" 16 40 # section
clear
dialog --backtitle "Automate script" --title "Options" --msgbox "You can select what to install during the process." 10 20 # section
read -p "To start press ENTER."
clear

function install_basic_stuff()  {
  read -p "Enable cups? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo systemctl enable cups.service
  fi
  read -p "Install nano vim nitrogen picom alacritty firefox? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --needed nano vim nitrogen picom alacritty firefox cronie
  fi
  read -p "Check and install nvidia drivers? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --needed nvidia nvidia-utils nvidia-settings
  fi
  
  read -p "Install xmonad 1st way? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm xmonad xmonad-contrib xmobar dmenu
    cd ~
    mkdir .xmonad
    mv ~/auto-xmonad-repo/xmonad.hs ~/.xmonad/
  fi
  
  read -p "Install lightdm and configure it? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S lightdm lightdm-gtk-greeter
    sudo systemctl enable lightdm
    # if resolution goes wrong see https://youtu.be/JmPLbZQRgas?t=249
    cd ~
    touch .xprofile
    echo '# Wallpaper' >> .xprofile
    echo 'nitrogen --restore &' >> .xprofile
    echo '# Compositor' >> .xprofile
    echo 'picom -f &' >> .xprofile
    # see https://youtu.be/JmPLbZQRgas?t=370 to disable vsync
    
    #read -p "We should now reboot to test if lightdm is working"
  fi
  read -p "Create user default directories? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm xdg-user-dirs xdg-utils
    xdg-users-dirs-update
  fi
}

function install_yay()  {
  read -p "Install yay (AUR Helper)? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    sleep 1
    cd ~
    clear
    which yay
    yay --version
  fi
}

#function install_xmonad_broken_way()  {
#  read -p "Install xmonad? " -n 1 -r
#  echo    # (optional) move to a new line
#  if [[ $REPLY =~ ^[Yy]$ ]]
#  then
#    # install xmonad dependencies
#    sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf
#    # xnomad preparation
#    mkdir -p ~/.config/xmonad
#    mv ~/auto-xmonad-repo/xmonad.hs ~/.config/xmonad
#    cd ~/.config/xmonad
#    git clone https://github.com/xmonad/xmonad
#    git clone https://github.com/xmonad/xmonad-contrib
#    # add ~/.local/bin to $PATH in zsh
#    echo '# set PATH so it includes user local bin if it exists' >> ~/.zshrc
#    echo 'if [ -d $HOME/.local/bin ]; then' >> ~/.zshrc
#    echo '  PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
#    echo 'fi' >> ~/.zshrc
#    source ~/.zshrc
#  
#    # build xmonad using Stack
#    echo 'Building xmonad using Stack...'
#    sleep 3
#  
#    # installing stack
#    sudo pacman -S stack
#    sleep 5
#    stack upgrade
#    stack init
#    # build xnomad
#    stack install
#    sleep 1
#    echo 'Xmonad is installed.'
#    cd ~
#  fi
#}

function cleanup()  {
  read -p "Try to cleanup? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -Sy pacman-contrib
    paccache -r
  fi
}

function selection()  {
  clear
  install_basic_stuff
  clear
  install_yay
  clear
  # TODO: MAKE ZSH DEFAULT SHELL
  clear
  cleanup
}
selection
