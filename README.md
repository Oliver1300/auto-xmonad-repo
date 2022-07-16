### This repo is for automating installing programs on one of my arch systems. Is broken. Do not try it.
## Steps
- Install Arch Linux with a minimal installation with Xorg and add the packages: [git, zsh]
- In the arch live medium run:
```
archinstall
```
- Once installed, clone this repo:
```
cd ~/ && git clone https://github.com/USER/auto-xmonad-repo
```
- Run the custom script
```
bash auto-xmonad-repo/automationsteps.sh
```
