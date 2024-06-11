#!/bin/sh


if [ $(uname -s) = "Darwin" ]; then
  # Run MacOs scripts
  echo "MACOS"
  source ./setup-macos.sh
  exit 0
fi
if uname -r | grep -q arch; then
  # Run Archlinux scripts
  echo "ArchLinux" 
  source ./setup-archlinux.sh
  exit 0
fi

# Not supported
exit -1
