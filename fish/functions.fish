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
# Functions

function ud -d "Opens Unidoc folder"
  if [ (count $argv) -eq 1 ]
    cd $docfolder$argv[1]
  else
    cd $docfolder
  end
end

complete -f -c ud -a "(ls $docfolder/*)" -d "Completion for ud"

function mcdir
  if [ (count $argv) -gt 0 ]
      mkdir $argv[(count $argv)] -p
      cd $argv[(count $argv)]
  else
    echo "Usage: mcdir <path/to/new/folder>"
  end
end

function hsr-sync -d "Syncs hsr-folders"
  bash ~/git/hsrhkkers/Shell Sync/shell-scripts/hsr-sync.sh $argv
end

function mntNAS -d "Mounts Tobias-NAS"
  bash {$SCRIPTPATH}/mount_NAS.sh $argv
end

function mntHSR -d "Mounts HSR dfs"
  bash {$SCRIPTPATH}/mount_HSR.sh $argv
end
