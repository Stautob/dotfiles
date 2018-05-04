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

printWithTilde () {
  echo -e "${1//$HOME/\~}"
}; export -f printWithTilde

linking () {
  relativePathToFile=$1;pathToLink=$2

  set +f; shopt -s dotglob
  for dotFile in ${APPSPATH}${relativePathToFile} ; do
    printWithTilde " -> link ${pathToLink}${dotFile##*/} to ${APPSPATH}${dotFile##*/}"
    ln -s -b ${APPSPATH}${relativePathToFile} $pathToLink
  done
}; export -f linking

checkexists () {
  sourcePath=$1

  programname=${sourcePath%/*}
  if ( (command -v $programname > /dev/null 2>&1) || [[ $APPEXCLUDE =~ $programname ]] ); then
    echo -e "Proceeding handling links for $programname"; return 0
  else
    echo -e "No $programname installation found"; return 1
  fi
}; export -f checkexists

createLink () {
  relativePathToFile=$1;pathToLink=$2

  if checkexists $relativePathToFile; then
    mkdir -p ${pathToLink%/*}
    linking $relativePathToFile $pathToLink
  fi
}; export -f createLink

listApps () {
  functionName=$1;shift;args=$@

  xargs -L1 -I {} bash -c "set -f ; $functionName {} $args" < $APPFILE
}

remove () {
  relativePathToFile=$1;pathToLink=$2;suffix=$3

  set +f; shopt -s dotglob
  if checkexists $relativePathToFile; then
    for dotFile in ${APPSPATH}${relativePathToFile} ; do
      printWithTilde " -> unlink ${pathToLink}${dotFile##*/}$suffix"
      unlink ${pathToLink}${dotFile##*/}$suffix 2> /dev/null
    done
  fi
}; export -f remove

printHelp () {
  echo "Usage: $0           create links to the dotfiles"
  echo "       $0 -h        show this message"
  echo "       $0 -rb       remove backups"
  echo "       $0 -u        remove links"
}


# Main

case $1 in
  -c|--create-links) listApps "createLink" ; exit 0 ;;
  -h|--help) printHelp ; exit 0 ;;
  -rb|--remove-backups) listApps "remove" "\~" ; exit 0 ;;
  -r|--remove-links) listApps "remove" ""; exit 0 ;;
  *) printHelp ; exit 0;;
esac
