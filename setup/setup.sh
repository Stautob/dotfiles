#!/bin/bash
# Script to install and configure necessary applications

DotfilesPath=`sed -n 's/\/$//p' <<< $(grep -o '.*/' <<< $(dirname $(realpath $0)))`
ScriptPath="${DotfilesPath%/*}/scripts"
DefaultvarsPath="${DotfilesPath}/fish/default_vars.fish"
DotfilescriptPath="${DotfilesPath}/setup/dotfilescript.sh"
DefaultappsConfigPath="${DotfilesPath}/setup/.defaultapps.conf"
DotfilesURL="https://bitbucket.org/stautob/dotfiles.git"
KeyPath="~/.ssh/id_rsa.mk"

installApps () {
  cat $DefaultappsConfigPath | xargs -L1 sudo pacman --noconfirm -S
}

configureApps () {
  # Syntax: configureApps [def_hostname] [def_username]
  c_createFishDefaultVars $2 $3
  c_createFstabEntries
  c_getDotfiles
  c_linkDotfiles
  c_makeKey
}

c_createFishDefaultVars () {
  touch $DefaultvarsPath
  echo "set -g default_host $1" >> $DefaultvarsPath
  echo "set -g default_user $2" >> $DefaultvarsPath
  echo "set -gx SCRIPTPATH $ScriptPath" >> $DefaultvarsPath
  echo "Created ${DefaultvarsPath##*/}"
}

c_createFstabEntries () {
  echo "Created fstab entries"
}

c_getDotfiles () {
  echo "Getting Dotfiles"
  #TODO: implement better handling of already existent
  git clone --recursive $DotfilesURL $ScriptPath
}

c_linkDotfiles () {
  echo "Linking dotfiles"
  ${DotfilesPath}/dotfilescript.sh
}

c_makeKey () {
  ssh-keygen -b 4096 -t rsa -N $1 -f $KeyPath
}

printhelp () {
  echo "Usage: $0 -h                                   show this message"
  echo "       $0 -i                                   install software"
  echo "       $0 -c [def_hostname] [def_username]     configure system"
}

# Main
case $1 in
  "") printhelp ; exit 0 ;;
  -h) printhelp ; exit 0 ;;
  -i) installApps ; exit 0 ;;
  -c) configureApps $@ ; exit 0 ;;
  *) ;;
esac

# TODO:
#       fstab entry for hsr-dfs

