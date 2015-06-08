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
  else
    echo "No fish installation found"
  fi

  # tmux
  if checkexists tmux; then
    linking .tmux.conf ~/
  else
    echo "No tmux installation found"
  fi

  # vim
  if checkexists vim; then
    linking .vimrc ~/
    linking .vim/ ~/
  else
    echo "No vim installation found"
  fi

  # eclim
  if checkexists eclipse; then
    linking .eclimrc ~/
  else
    echo "No eclipse installation found"
  fi

  # i3
  if checkexists i3; then
    mkdir -p ~/.i3/
    linking .i3/config ~/.i3/
  else
    echo "No i3 installation found"
  fi
}

function linking () {
  # Syntax: linking LINKTARGET, LINKPATH
  ln -s -b -t ${SCRIPTPATH}$1 $2
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

