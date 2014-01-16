export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PATH=${PATH}:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin

export EDITOR=vi

# git aliases
alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '

# bash history related stuff
HISTCONTROL=ignorespace:erasedups

[[ -f ~/.bashrc ]] && . ~/.bashrc
