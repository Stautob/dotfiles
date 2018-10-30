#!/usr/bin/bash
# Adds additional channels to pacman

CONFIG_FILE="/etc/pacman.conf"

function loadIfNotLoaded() {
if ! grep -q $1 $CONFIG_FILE; then
  echo -e "\n[$1]\nServer = $2" | sudo tee -a $CONFIG_FILE
fi
}

# ADDITIONAL CHANNELS BELLOW

# sublime-text
loadIfNotLoaded "sublime-text" "https://download.sublimetext.com/arch/stable/x86_64"


