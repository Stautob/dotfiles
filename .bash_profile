if [ "$(uname)" = "Darwin" ]; then
  export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python2.7/site-packages:$PYTHONPATH
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin:${PATH}
fi

# Some environment setup
export EDITOR=vi
export PAGER=less

# Spelling correction for directory names
shopt -s cdspell

# Notify about exited processes immediately
set -o notify

# git aliases
alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'

PS1="\[\e[01;31m\]{\[\e[0m\]\[\e[00;33m\]\$?\[\e[0m\]\[\e[01;31m\]}\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;32m\]\u\[\e[0m\]\[\e[00;34m\]@\H\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;31m\][\[\e[0m\]\[\e[00;33m\]\W\[\e[0m\]\[\e[01;31m\]]\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;34m\]\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"

# bash history related stuff
HISTCONTROL=ignorespace:erasedups

[[ -f ~/.bashrc ]] && . ~/.bashrc
