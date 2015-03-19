# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PS1="\[\e[0;32m\][\u]\[\e[0;34m\]@[\H] \[\e[1;31m\][\[\e[0;33m\]\W\$(if [[ \$GIT_PROMPT_LOADED -eq '1' ]]; then __git_ps1 '\[\e[0;34m\]{%s}'; fi)\[\e[1;31m\]] \[\e[1;34m\]\$\[\e[0m\] "

# set variables
TERM='xterm-256color'
TERMINAL='terminator'
LANG='en_US.UTF-8'
export LANG


alias ll='ls -la --color=auto'
alias g++='clang++ -std=c++11'
alias g++03='g++ -std=c++03'
