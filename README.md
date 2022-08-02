### Unmaintained repo for automating installing programs on one of my arch systems. Is broken. Do not try it.
## Steps
- Install Arch Linux with a minimal installation with Xorg and add the packages: [git, zsh]
- In the arch live medium run:
```
archinstall
```
- Once installed `reboot`
- Setup the `zsh` shell
```
zsh
```
- Clone this repo:
```
cd ~/ && git clone https://github.com/USER/auto-arch-repo
```
- Run the custom script
```
bash auto-xmonad-repo/automate.sh
```
- Setup nitrogen background, press MOD + P and type:
> nitrogen
- Go to *Preferences*, *Add Directory* and select ~/Backgrounds
