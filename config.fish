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
set PATH "/opt/android-studio/bin/" $PATH

# set Xinput
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.40

# load prompt.fish
. ~/.config/fish/prompt.fish

# load functions.fish
. ~/.config/fish/functions.fish

# load greeter.fish
. ~/.config/fish/greeter.fish

