if [ "$(uname)" = "Darwin" ]; then
  export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python2.7/site-packages:$PYTHONPATH
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin:${PATH}

  alias ls='ls -G'

  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

# Some environment setup
export EDITOR=vi
export PAGER=less

# Spelling correction for directory names
shopt -s cdspell

# Notify about exited processes immediately
set -o notify

# Standard aliases
alias grep='grep --color=always'

# git aliases
alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'
alias gstatus='git status'

PS1="\[\e[01;31m\]{\[\e[00;33m\]\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\";  fi )\[\e[01;31m\]} \[\e[00;32m\]\u\[\e[00;34m\]@\H \[\e[01;31m\][\[\e[00;33m\]\W\$(__git_ps1 '\[\e[00;34m\]{%s}')\[\e[01;31m\]] \[\e[01;34m\]\306\222 = \[\e[0m\]"

# bash history related stuff
HISTCONTROL=ignorespace:erasedups

[[ -f ~/.bashrc ]] && . ~/.bashrc
