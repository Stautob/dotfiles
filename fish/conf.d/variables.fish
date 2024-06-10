#---------------------#
# VARIABLES AND PATHS #
#---------------------#

# Shared

set -g fish_greeting ""
set -g theme_display_user "true"
set -gx TERMINAL "alacritty"
set -gx TERM "xterm-256color"
set -gx editor "nvim"
set -gx EDITOR "nvim"
set -gx Editor "nvim"
#!/usr/bin/fish

switch (uname)
    case Darwin
        # do things for macOS
	set -gx SHELL "/opt/homebrew/bin/fish"
	set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
    case Linux
        # do things for Linux
	set -gx SHELL "/usr/bin/fish"
    case '*'
        # do things for other OSs
end

