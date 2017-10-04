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
  if [[ $2 == */ ]]; then
    ln -s -b -t $2 ${APPSPATH}${1}/*
  else
    ln -s -b -t $2 ${APPSPATH}${1}
  fi
}

export -f linking

checkexists () {
  # Syntax: checkexists PROGRAMNAME

  programname=${1%/*}
  if ( (command -v $programname > /dev/null 2>&1) || [[ $APPEXCLUDE =~ $programname ]] ); then
    echo -e "Proceeding creating links for $programname"; return 0
  else
    echo -e "No $programname installation found"; return 1
  fi
}

export -f checkexists

createLink () {
  if checkexists $1; then
    mkdir -p ${2%/*}
    linking ${1} $2
 fi
}

export -f createLink

listApps () {
  # Syntax: listApps FUNCTIONNAME ARGS
  xargs -L1 -I {} bash -c "$1 {}" < $APPFILE
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
