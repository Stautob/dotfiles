#!/bin/bash
# Script to create the links to the dotfiles

function checkdir {
  SCRIPT=`realpath $0`
  SCRIPTPATH=`dirname $SCRIPT`/
}

function install {
  # bash
  linking .bashrc ~/
  linking .bash_profile ~/

  # fish
  if checkexists fish; then
    mkdir -p ~/.config/fish
    linking config.fish ~/.config/fish/
    linking greeter.fish ~/.config/fish/
    linking functions.fish ~/.config/fish/
    linking prompt.fish ~/.config/fish/
  fi

  # tmux
  if checkexists tmux; then
    linking .tmux.conf ~/
  fi

  # vim
  if checkexists vim; then
    linking .vimrc ~/
    linking .vim/ ~/
  fi

  # eclim
  if checkexists eclipse; then
    linking .eclimrc ~/
  fi

  # i3
  if checkexists i3; then
    mkdir -p ~/.i3/
    linking .i3/config ~/.i3/
  fi
}

function linking () {
  # Syntax: linking LINKTARGET, LINKPATH
  ln -s -b -t $2 ${SCRIPTPATH}$1
  echo "Linked $1"
}

function checkexists () {
  # Syntax: checkexists PROGRAMMNAME
  if (command -v $1 > /dev/null 2>&1); then
    echo "Found $1 installation, creating links"
    return 0
  else
    echo "No $1 installation found"
    return 1
  fi
}

checkdir
install

