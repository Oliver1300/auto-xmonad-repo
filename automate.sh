#!/bin/bash

# https://youtu.be/JmPLbZQRgas?t=371

# update system
sudo pacman -Syu
# install dialog for displaying dialog boxes
sudo pacman -S --noconfirm dialog os-prober
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
    sudo pacman -S --noconfirm cups
    sudo systemctl enable cups.service
    clear
  fi
  read -p "Install nano vim nitrogen picom alacritty firefox? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # TODO ADD OPTION IN PCMANFM TO OPEN AS ROOT, OPEN IN TERMINAL
    sudo pacman -S --noconfirm nano vim nitrogen picom alacritty firefox htop ranger pcmanfm-gtk3 gedit
    clear
  fi
  read -p "Check and install nvidia drivers? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
    clear
  fi
  
  read -p "Install xmonad? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm xmonad xmonad-contrib xmobar dmenu
    cd ~
    mkdir .xmonad
    cp ~/auto-xmonad-repo/xmonad.hs ~/.xmonad/
    cp ~/auto-xmonad-repo/xmobar ~/.xmobarrc
    clear
  fi
  
  read -p "Install lightdm and configure it? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
    sudo systemctl enable lightdm
    # if resolution goes wrong see https://youtu.be/JmPLbZQRgas?t=249
    cd ~
    touch .xprofile
    echo '# Wallpaper' >> .xprofile
    echo 'nitrogen --restore &' >> .xprofile
    echo '# Compositor' >> .xprofile
    echo 'picom -f &' >> .xprofile
    # see https://youtu.be/JmPLbZQRgas?t=370 to disable vsync
    clear
  fi
  read -p "Create user default directories? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm xdg-user-dirs xdg-utils
    xdg-users-dirs-update
    clear
  fi
}

function install_yay()  {
  read -p "Install yay (AUR Helper)? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    sleep 1
    cd ~
    rm -rf yay
    clear
  fi
}

function cleanup()  {
  read -p "Try to cleanup? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    sudo pacman -S --noconfirm pacman-contrib
    paccache -r
  fi
}

function config_nitrogen_background()  {
  read -p "Configure nitrogen? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    mkdir -p ~/Backgrounds
    mv ~/auto-xmonad-repo/background01.jpg ~/Backgrounds
    mkdir -p ~/.config
    mkdir -p ~/.config/nitrogen
    touch bg-saved.cfg
  
    echo '[xin_-1]' >> bg-saved.cfg
    echo file=$HOME/Backgrounds/background01.jpg >> bg-saved.cfg
    echo 'mode=4' >> bg-saved.cfg
    echo 'bgcolor=#000000' >> bg-saved.cfg
  
    cd ~
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
  config_nitrogen_background
  clear
  cleanup
}
selection
