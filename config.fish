# define colors

set fish_color_error ff8a00
set -g c0 (set_color 0075cd)
set -g c1 (set_color 0075cd)
set -g c2 (set_color 009eff)
set -g c3 (set_color 6dc7ff)
set -g c4 (set_color ffffff)
set -g c5 (set_color yellow -o)
set -g c6 (set_color red -o)
set -g c7 (set_color purple -o)
set -g c8 (set_color green -o)
set -g c9 (set_color fa7500 -o)
set -g ce (set_color $fish_color_error)


# empty greeter

set -g fish_greeting ""

# set devicename

set -g this_device "stautobt430"


# set var

set -gx TERM xterm-256color
#set -g PATH $HOME
#set -g PATH $PATH /bin
#set -g PATH $PATH /usr/bin
#set -g PATH $PATH /usr/local/bin
#set -g PATH $PATH /opt/cevelop
#set -g PATH $PATH /opt/eclipse
#set -g PATH $PATH /opt/astah
#set -g PATH $PATH /opt/idea-IC-139.224.1/bin


# aliases

function ll
  ls -alGh --color=auto
end

function g++
  clang++ $argv
end

function haei -d "Mounts HSR dfs"
  sh /home/tstauber/scripts/mh.sh
end


# build Prompt

function fish_prompt -d "TobiPrompt"
    set -g read_host (hostname)
    if [ $read_host = $this_device ]
      set -g disp_host \u24c9
      set -g colmod c7
    else
      set -g disp_host $read_host
      set -g colmod c5
    end
    if [ (id -u) = 0 ]
      set -g user_identifier \#
    else
      set -g user_identifier \$
    end
    printf '%s[%s]%s[%s]%s[%s%s%s ]%s[%s|%s]%s[%s]%s%s%s ' $c2 (prnt_date) $c5 (whoami) $c7 $c5 $$colmod $disp_host $c4 (prnt_avload) (battery_state) $c8 (prnt_pwd) $c9 $user_identifier (set_color normal)
end

function battery_state -d "PrintB-State"
    echo (acpi |grep -o '[0-9][0-9]\%')
end

function prnt_date -d "Print_Date"
    echo (date "+%H$c4:$c2%M")
end

function prnt_avload -d "Print Load as float"
    echo (uptime | grep -o '[0-9]\+\.[0-9]\+' | head -n1)
end

function prnt_pwd -d "Print last folder from pwd-path"
    echo (pwd | sed 's!.*/!!')
end

