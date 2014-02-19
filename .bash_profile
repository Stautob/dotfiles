UNAME_PLATFORM=$(uname)

if [ $UNAME_PLATFORM = "Darwin" ]; then # We are on OS X

  # Preprend the homebrew installation directories to the PATH
  export PATH=/usr/local/bin:/usr/local/sbin:${PATH}

  BREW_PREFIX=$(brew --prefix 2> /dev/null)

  if [ "$BREW_PREFIX" != "" ]; then
    # Add the homebrew PYTHONPATH as well (for 2.7 and 3)
    export PYTHONPATH=${PYTHONPATH}:$BREW_PREFIX/lib/python2.7/site-packages
    export PYTHONPATH=${PYTHONPATH}:$BREW_PREFIX/lib/python3.3/site-packages

    # Load bash completion if available
    if [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
      . "$BREW_PREFIX/etc/bash_completion"

      if [ -f "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ]; then
        . $BREW_PREFIX/etc/bash_completion.d/git-prompt.sh
        GIT_PROMPT_LOADED=1
      fi
    fi
  fi

  # Load the git-prompt function when available
  if [[ ! $GIT_PROMPT_LOADED -eq "1" && -d /Library/Developer/CommandLineTools ]]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
    GIT_PROMPT_LOADED=1
  fi

elif [ $UNAME_PLATFORM = "NetBSD" ]; then # We are on NetBSD

  export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R7/bin:/usr/X11R6/bin:/usr/pkg/bin:/usr/pkg/sbin:/usr/games:/usr/local/bin:/usr/local/sbin
  export ENV=$HOME/.shrc

else

  if [[ "$COLORTERM" == "gnome-terminal" || "$COLORTERM" == "mate-terminal" ]]
  then
    TERM=xterm-256color
  fi

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

if $(ls --color > /dev/null 2>&1); then
  alias ls='ls --color=auto'
elif $(ls -G > /dev/null 2>&1); then
  alias ls='ls -G'
fi

alias ll='ls -l'

# git aliases
alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'
alias gstatus='git status'

PS1="\[\e[00;32m\]\u\[\e[00;34m\]@\H \[\e[01;31m\][\[\e[00;33m\]\W\$(if [[ \$GIT_PROMPT_LOADED -eq '1' ]]; then __git_ps1 '\[\e[00;34m\]{%s}'; fi)\[\e[01;31m\]] \[\e[01;34m\]\306\222 = \[\e[0m\]"

# bash history related stuff
HISTCONTROL=ignorespace:erasedups

[[ -f ~/.bashrc ]] && . ~/.bashrc
