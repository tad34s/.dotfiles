# How to install

1. Clone repository
2. Download relevant packages, may need to download some fonts (see below)
    (You also may want to install oh-my-zsh for some zsh themes)
3. Use GNU Stow to create sym links

```bash
cd .dotfiles
stow -nv . # Check if stow takes correct actions
stow -v . # This will actaully do them
```

4. Create a sym link to the wallpaper picking script

```bash
 sudo ln -s path_to_repo/change_wallpaper.sh /usr/local/bin/wpC # set the command to be wpC you can change this if you want
```
If you want to change the wallpaper location do so by changing variables in the script.
You may also need to change the location used by feh when on startup.

# Packages used:
- `i3-wm, i3blocks,i3lock,i3status`
- `xterm`
- `zsh`
- `neovim`
- `ranger`
- `rofi`
- `stow`
- `flameshot`
- `polybar`
- `lightdm, lightdm-gtk-greeter`
- `picom`
- `volumeicom`
- `xclip`

## Some nice to have packages
- `neofetch`
- `ncspot`
- `vivaldi` (the best browser imho)
- `topgrade`
- `zoxide`
- `lxappearance`


# Fonts
- `noto-fonts`
- `noto-fonts-cjk`
- `noto-fonts-emoji`
- `noto-fonts-extra`
- `ttf-jetbrains-mono-nerd`
- `ttf-material-design-iconic-font` (for the work-laptop icons)
