#!/bin/bash
# Script to install necessary applications
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`/

DEFAULTAPPSCONFIG=${SCRIPTPATH}".defaultapps.conf"

function checkexists () {
  if (command -v $1 > /dev/null 2>&1); then
    echo "Found $1 installation allready installed"
    return 0
  else
    echo "No $1 installation found"
    return 1
  fi
}

function install () {
  case $1 in
    arch )
      cat $DEFAULTAPPSCONFIG | xargs -L1 sudo pacman --noconfirm -S ;;
    fedora )
      cat $DEFAULTAPPSCONFIG | xargs -L1 sudo yum -y install ;;
    # extend in case of other cases
  esac
}

function makeKey () {
  ssh-keygen -b 4096 -t rsa -N $1 -f ~/.ssh/id_rsa.mk
}

install arch


