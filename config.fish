# empty greeter
set -g fish_greeting ""


# set vars
set -g default_host "stautobt430"
set -g default_user "tstauber"
set -g theme_display_user "yes"
set -gx TERM xterm-256color

# load prompt.fish
. ~/.config/fish/prompt.fish


# aliases

function sudop
  sudo -i fish
end

function ll
  ls -alGh --color=auto $argv
end

function ud -d "Opens Unidoc folder"
  if [ (count $argv) = 1 ]
    cd /home/tstauber/syncthing/FS15/$argv[1]
  else
    cd /home/tstauber/syncthing/FS15/
  end
end

function mcdir
  if [ (count $argv) > 0 ]
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        mkdir $argv[(count $argv)] -p
        cd $argv[(count $argv)]
        return
    end
  else
    echo "Usage: mcdir <path/to/new/folder>"
  end
end

function g++
  clang++ $argv
end

function haei -d "Mounts HSR dfs"
  sh /home/tstauber/scripts/mh.sh
end

function -
  cd -
end
