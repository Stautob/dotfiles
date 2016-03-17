#!/usr/bin/fish

#---------------------#
# FUNCTIONS AND ALIAS #
#---------------------#

#---------------------#
# Alias

function sudop
  sudo -i fish $argv
end

function ll
  ls -1a --color=auto $argv
end

function gst
  git status $argv
end

function -
  cd -
end

function g++
  clang++ $argv
end

#---------------------#
# Independent Completions

complete -f -w pacman -c apacman

#---------------------#
# Functions

function ud -d "Opens Unidoc folder"
  if [ (count $argv) -eq 1 ]
    cd {$docfolder}/*/{$argv[1]}
  else
    cd $docfolder
  end
end

complete -f -c ud -a "(ls $docfolder/*)"

function mcdir
  if [ (count $argv) -gt 0 ]
      mkdir $argv[(count $argv)] -p
      cd $argv[(count $argv)]
  else
    echo "Usage: mcdir <path/to/new/folder>"
  end
end

function hsr-sync -d "Syncs hsr-folders"
  mntHSR
  bash ~/git/hsrhkkers/Shell\ Sync/shell-scripts/hsr-sync.sh $argv
  mntHSR -u
end

function mntNAS -d "Mounts Tobias-NAS"
  bash {$SCRIPTPATH}/mount_NAS.sh $argv
end

function mntHSR -d "Mounts HSR dfs"
  bash {$SCRIPTPATH}/mount_HSR.sh $argv
end

function baf -d "CD to BA directory"
  cd ~/git/hsr/dab-data/source
end

function pivotrandr
  xrandr --auto
  #xrandr --output LVDS1 --auto --pos 1200x1020 --output VGA1 --rotate left --pos 0x0
  xrandr --output VGA1 --rotate left --mode 1920x1200 --pos 0x0 --output LVDS1 --auto --pos 1200x1021
end
