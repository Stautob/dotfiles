#!/usr/bin/fish

#---------------------#
# FUNCTIONS AND ALIAS #
#---------------------#

#---------------------#
# Abbreviations

if test (abbr --list | wc -l) -eq 0
  abbr --add ll ls -1av --color=auto
  abbr --add gst git status
  abbr --add ip ip -c
  abbr --add vi nvim
end

#---------------------#
# Alias

alias g++="clang++"
alias vi="nvim"
alias diff="diff --color=auto"
alias grep="grep --color=auto -n"
alias dmesg="dmesg --color=always"
alias pacman="pacman --color=always"


#---------------------#
# Functions

function ILTIS_is_remote
  return (test -n "$SSH_CLIENT" -o -n "$SSH_TTY")
end

function mcdir -a path -d "Creates a directory inclusive parents and changes into the new directory"
  if [ -n path ]
      mkdir $path -p; and cd $path
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

function append-to-path -a dir -d 'Adds the given directory to the front of the PATH'
    if test -n $dir -a -d $dir
        set dir (realpath $dir)

        # If this path is already in the PATH array, remove all occurrences
        # and add it to the head
        for i in (seq (count $PATH) 1)
            if test $PATH[$i] = $dir
                set -e PATH[$i]
            end
        end
        set PATH $PATH $dir
    else
        echo "Dir $dir does not exist?"
    end
end

function prepend-to-path -a dir -d 'Adds the given directory to the front of the PATH'
    if test -n $dir -a -d $dir
        set dir (realpath $dir)

        # If this path is already in the PATH array, remove all occurrences
        # and add it to the head
        for i in (seq (count $PATH) 1)
            if test $PATH[$i] = $dir
                set -e PATH[$i]
            end
        end
        set PATH $dir $PATH
    else
        echo "Dir $dir does not exist?"
    end
end

