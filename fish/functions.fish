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
  ls -1av --color=auto $argv
end

function gst
  git status $argv
end

function g++
  clang++ $argv
end

function dab
  cd /home/tstauber/git/hsr/dab-data
end

function ip
  /bin/ip -c $argv
end

function vi
  /bin/nvim $argv
end

#---------------------#
# Independent Completions

complete -f -w pacman -c apacman

#---------------------#
# Functions

function basheval -d "Evaluates Bash-syntax variables"
  for x in (seq (count $argv))
    eval (echo $argv[$x] | sed -r 's/:/\' \'/g; s/(.*)=("|\')?([^;]*)(;)?\2?/set --universal \1 \'\3\'\4/')
  end
end

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

set -xU LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")          # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set -xU LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline
