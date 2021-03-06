#!/bin/bash

# https://youtu.be/JmPLbZQRgas?t=371

# update system
sudo pacman -Syu --noconfirm
# install dialog for displaying dialog boxes
sudo pacman -S --noconfirm dialog os-prober
clear

dialog --backtitle "Automate script" --title "PREREQUISITES: git, zsh configured" --msgbox "This script automates the process for installing programs like xorg dependencies, nitrogen, picom, nano, alacritty, xmonad, lightdm" 16 40 # section
clear
dialog --backtitle "Automate script" --title "Options" --msgbox "You can select what to install during the process." 10 20 # section
read -p "To start press ENTER."
clear

function skip_asking_basic_stuff()  {
  sudo pacman -S --needed --noconfirm nano vim nitrogen picom alacritty firefox htop ranger pcmanfm-gtk3 gedit
  sudo pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings xmonad xmonad-contrib xmobar dmenu lightdm lightdm-gtk-greeter xdg-user-dirs xdg-utils
  sudo pacman -S --needed --noconfirm cups neofetch piper lxsession nm-connection-editor network-manager-applet volumeicon trayer zenity #ffplay
  # TODO: Check Network Manager is installed
  sudo pacman -S --needed --noconfirm lxappearance nemo ark
  
  #cups
  sudo systemctl enable cups.service
  # xmonad
  cd ~
  mkdir .xmonad
  cp ~/auto-arch-repo/xmonad.hs ~/.xmonad/
  cp ~/auto-arch-repo/xmobar ~/.xmobarrc
  # lightdm
  sudo systemctl enable lightdm
  # if resolution goes wrong see https://youtu.be/JmPLbZQRgas?t=249
  # TODO: Check that it works, network manager
  sudo systemctl enable NetworkManager
  # startup config
  cd ~
  touch .xprofile
  echo '# Wallpaper' >> .xprofile
  echo 'nitrogen --restore &' >> .xprofile
  echo '# Compositor' >> .xprofile
  echo 'picom -f &' >> .xprofile
  echo 'lxsession' >> .xprofile
  # see https://youtu.be/JmPLbZQRgas?t=370 to disable vsync
  # user directories
  xdg-users-dirs-update
}

function install_yay()  {
  sudo pacman -S --needed --noconfirm base-devel git go
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  sleep 1
  cd ~
  rm -rf yay
}

function cleanup()  {
  # move keybindings help text for xmonad
  mv ~/auto-arch-repo/help.txt ~/.keybindings.txt
  # delete orphan packages
  sudo pacman -S --noconfirm pacman-contrib
  paccache -r
}

function add_nitrogen_background()  {
  cd ~
  mkdir -p ~/Backgrounds
  mv ~/auto-arch-repo/background01.jpg ~/Backgrounds
  mkdir -p ~/.config
  mkdir -p ~/.config/nitrogen
}

function config_themes()  {
  # gtk themes
  sudo cp -r ~/auto-arch-repo/themes/monokai-gtk /usr/share/themes
  mkdir -p ~/.themes
  cp -r ~/auto-arch-repo/themes/monokai-gtk ~/.themes
  sudo cp -r ~/auto-arch-repo/themes/Fluent-round-Dark-compact /usr/share/themes
  cp -r ~/auto-arch-repo/themes/Fluent-round-Dark-compact ~/.themes
  # set monokai as active
  cp ~/auto-arch-repo/settings/.gtkrc-2.0 ~/
  cp ~/auto-arch-repo/settings/.gtkrc-2.0.mine ~/
  mkdir -p ~/.config/gtk-3.0
  cp -r ~/auto-arch-repo/settings/settings.ini ~/.config/gtk-3.0/

  # download nerd-fonts-complete
  yay -Syu
  yay -S ttf-jetbrains-mono
  yay -S nerd-fonts-jetbrains-mono
  yay -S noto-fonts

  # set system font to this
  # change font in the file in monokai theme?
  #/usr/share/fonts/TTF

  # config alacritty
}

function reboot()  {
  dialog --backtitle "Script has finished" --title "Reboot" --msgbox "You should know have all the packages and configuration let's reboot" 10 15 # section
  sudo reboot
}

# unmaintained.
function selection()  {
  clear
  read -p "Install most of the programs? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    skip_asking_basic_stuff
  fi
  clear
  read -p "Install yay (AUR Helper) [y/n]? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    install_yay
  fi
  # TODO: MAKE ZSH DEFAULT SHELL
  clear
  # nitrogen
  read -p "Configure nitrogen [y/n]? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    add_nitrogen_background
  fi
  clear
  read -p "Try to cleanup [y/n]? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    cleanup
  fi

  config_themes
}
function no_selection()  {
  dialog --backtitle "Complete installation" --title "Message" --msgbox "Once you press to continue the script will skip for asking what to install" 10 20 # section
  skip_asking_basic_stuff
  install_yay
  add_nitrogen_background
  cleanup
  config_themes
  reboot
}

# init
read -p "Enable selection during the process [y/n]? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
  then
    no_selection
  else
    no_selection
fi
