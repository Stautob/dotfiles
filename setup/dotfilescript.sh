#!/bin/bash
# Script to create the links to the dotfiles

APPEXCLUDE="various"
export APPEXCLUDE
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
APPSPATH=${SCRIPTPATH%/*}/
export APPSPATH
APPFILE="${SCRIPTPATH}/.apps.conf"
export APPFILE


linking () {
  # Syntax: linking LINKTARGETPATH, LINKPATH
  shopt -s dotglob
  ln -s -b -t $2 ${APPSPATH}${1}/*
}

export -f linking

checkexists () {
  # Syntax: checkexists PROGRAMMNAME
  if ( (command -v $1 > /dev/null 2>&1) || [[ $APPEXCLUDE =~ $1 ]] ); then
    echo -e "Proceeding creating links for $1"; return 0
  else
    echo -e "No $1 installation found"; return 1
  fi
}

export -f checkexists

createLink () {
  # TODO enable named links
  if checkexists $1; then
    mkdir -p $2
    linking ${1} $2
 fi
}

export -f createLink

listApps () {
  # Syntax: listApps FUNCTIONNAME ARGS
  xargs -L1 -I {} echo "$1 {}" < $APPFILE
  #xargs -L1 -I {} bash -c "$1 {} $2" < $APPFILE
}

remove () {
  # Syntax: removeBackups NAME TARGETPATH SUFFIX
  shopt -s dotglob
  if checkexists $1; then
    for d in ${APPSPATH}${1}/* ; do
      unlink ${2}${d##*/}$3 2> /dev/null
    done
  fi
}

export -f remove

printhelp () {
  echo "Usage: $0           create links to the dotfiles"
  echo "       $0 -h        show this message"
  echo "       $0 -rb       remove backups"
  echo "       $0 -u        remove links"
}


# Main

case $1 in
  "") listApps "createLink" ; exit 0 ;;
  -h) printhelp ; exit 0 ;;
  -rb) listApps "remove" "\~" ; exit 0 ;;
  -u) listApps "remove" ""; exit 0 ;;
  *) ;;
esac
