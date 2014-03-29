UNAME_PLATFORM=$(uname)

if [ $UNAME_PLATFORM = "Darwin" ]; then

  ##### MAC OS X CONFIGURATION BELOW #####

  # Preprend the homebrew installation directories to the PATH
  export PATH=/usr/local/bin:/usr/local/sbin:${PATH}

  BREW_PREFIX=$(brew --prefix 2>/dev/null)

  if [ "$BREW_PREFIX" != "" ]; then
    # Load bash completion if available
    if [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
      . "$BREW_PREFIX/etc/bash_completion"

      if [ -f "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ]; then
        . $BREW_PREFIX/etc/bash_completion.d/git-prompt.sh
        GIT_PROMPT_LOADED=1
      fi
    fi
  fi

  alias ls='ls -G'

elif [ $UNAME_PLATFORM = "NetBSD" ]; then

  ##### NETBSD CONFIGURATION BELOW #####

  if [[ -f "/usr/pkg/share/bash-completion/bash_completion" ]]; then
    . "/usr/pkg/share/bash-completion/bash_completion"
  fi

  export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R7/bin:/usr/X11R6/bin:/usr/pkg/bin:/usr/pkg/sbin:/usr/games:/usr/local/bin:/usr/local/sbin
  export ENV=$HOME/.shrc

  if which gls &>/dev/null; then
    alias ls='gls --color=auto'
  fi

elif [[ "$UNAME_PLATFORM" == "Linux" ]]; then

  ##### LINUX CONFIGURATION BELOW #####

  if [[ "$COLORTERM" == "gnome-terminal" || "$COLORTERM" == "mate-terminal" ]]
  then
    TERM=xterm-256color
  fi

  if [ -f "/etc/profile.d/bash-completion.sh" ]; then
    . "/etc/profile.d/bash-completion.sh"

    if [[ -f "/usr/share/bash-completion/git-prompt" || -f "/usr/share/bash-completion/git-prompt.sh" ]]; then
      . /usr/share/bash-completion/git-prompt*
      GIT_PROMPT_LOADED=1
    fi
  fi

  alias ls='ls --color=auto'

fi

# Append the users .bin directory to the path
export PATH=${PATH}:~/.bin

# Some environment setup
export EDITOR=vi
export PAGER=less

# Spelling correction for directory names
shopt -s cdspell

# Notify about exited processes immediately
set -o notify

# Standard aliases
alias grep='grep --color=always'

alias ll='ls -l'

# git aliases
alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'
alias gstatus='git status'

if [[ $GIT_PROMPT_LOADED -eq '1' ]]; then
  PS1='\[\e[0;32m\]\u\[\e[0;34m\]@\H \[\e[1;31m\][\[\e[0;33m\]\W\[\e[0;34m\]$(__git_ps1 "{%s}")\[\e[1;31m\]] \[\e[1;34m\]\$\e[m\] '
else
  PS1="\[\e[0;32m\]\u\[\e[0;34m\]@\H \[\e[1;31m\][\[\e[0;33m\]\W\[\e[1;31m\]] \[\e[1;34m\]\$\e[0;0m\] "
fi

# bash history related stuff
HISTCONTROL=ignorespace:erasedups

#[[ -f ~/.bashrc ]] && . ~/.bashrc
