#-----------------------#
# CONFIG                #
#-----------------------#

set -g fish_greeting ""

# set vars
set -g default_host "stautobt430"
set -g default_user "tstauber"
set -g theme_display_user "yes"
set -gx docfolder "/home/tstauber/syncthing/FS15/"
set -gx TERM xterm-256color

# load prompt.fish
. ~/.config/fish/prompt.fish

# load functions.fish
. ~/.config/fish/functions.fish

# load greeter.fish
. ~/.config/fish/greeter.fish

