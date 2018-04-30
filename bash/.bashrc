# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PS1="\[\e[0;32m\][\u]\[\e[0;34m\]@[\H] \[\e[1;31m\][\[\e[0;33m\]\W\$(if [[ \$GIT_PROMPT_LOADED -eq '1' ]]; then __git_ps1 '\[\e[0;34m\]{%s}'; fi)\[\e[1;31m\]] \[\e[1;34m\]\$\[\e[0m\] "

# Start gnome keyring
# eval $(keychain --eval -Q --quiet id_ed25519.1)

# Redefine vi
alias vi="nvim"

# set variables
TERM='xterm-256color'
TERMINAL='termite'
EDITOR='nvim'
editor='nvim'
LANG='en_US.UTF-8'
export LANG
export EDITOR
export editor

