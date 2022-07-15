#https://xmonad.org/INSTALL.html
#https://www.youtube.com/watch?v=XvKAiR403O0
# Make sure you are in ~/  use pwd to see it
# Get this script via: git clone https://github.com/Oliver1300/auto-xmonad-repo
# NOTES: Installs git

# xmonad installation, following steps from https://xmonad.org/INSTALL.html

# install xmonad dependencies
sudo pacman -S git xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf git

# xmonad preparation (dotfiles)
mkdir -p ~/.config/xmonad
mv ~/auto-xmonad-repo/xmonad.hs ~/.config/xmonad
cd ~/.config/xmonad
clear
ls
# AUTOMATE THIS WITH GREP
echo 'You should see now xmonad.hs printed'
sleep 5

git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
# add ~/.local/bin to $PATH in zsh
if [ echo $0 == "zsh" ] ; then

else
  echo 'Not found zsh shell, could lead to an error in the future'
  echo 'Continuing in 10 seconds'
  sleep 10
fi
source ~/.zshrc

# build xmonad using Stack
# installing stack
sudo pacman -S stack
sleep 1
stack upgrade
stack init