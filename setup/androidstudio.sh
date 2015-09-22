#!/bin/bash

enableMultilib () {
  # Enables multilib and updates the system
  sudo sed -i 's/^\#\[multilib\]/\[multilib]/g' /etc/pacman.conf
  sudo sed -i '/\[multilib\]/{n;s/#//}' /etc/pacman.conf
  sudo pacman -Syu --noconfirm
}

installLib32 () {
  sudo pacman -S --noconfirm lib32-mesa lib32-libxrender lib32-fontconfig
}

installYaourt () {
  curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
  tar -xvzf package-query.tar.gz
  cd package-query
  sudo makepkg -si

  cd ..
  curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
  tar -xvzf yaourt.tar.gz
  cd yaourt
  sudo makepkg -si
}

installAndroidStudio () {
  enableMultilib
  installLib32
  installYaourt
  sudo yaourt -S --noconfirm android-studio

}
printhelp () {
  echo "Usage: $0         install android-studio"
  echo "       $0 -h      show this message"
}

# Main
case $1 in
  "") installAndroidStudio ; exit 0 ;;
  -h) printhelp ; exit 0 ;;
  *) ;;
esac
