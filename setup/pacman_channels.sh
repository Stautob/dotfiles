#!/usr/bin/bash
# Adds additional channels to pacman

# sublime-text
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf

