#!/bin/bash
# Enables multilib repo, installs lib's, yaourt and android-studio

sudo sed -i 's/^\#\[multilib\]/\[multilib]/g' /etc/pacman.conf
sudo sed -i '/\[multilib\]/{n;s/#//}' /etc/pacman.conf

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm lib32-mesa lib32-libxrender lib32-fontconfig

curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xvzf package-query.tar.gz
cd package-query
makepkg -si
cd ..

curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xvzf yaourt.tar.gz
cd yaourt
makepkg -si
cd ..

yaourt -S --noconfirm android-studio android-tools
