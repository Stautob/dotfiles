UNAME_PLATFORM=$(uname)


USRH_PATH=~/.bin
USRL_PATH=/usr/local/bin:/usr/local/sbin
GAME_PATH=/usr/games:/usr/local/games
USRP_PATH=/usr/pkg/bin:/usr/pkg/sbin
SYST_PATH=/bin:/sbin:/usr/bin:/usr/sbin

[[ -f $HOME/.bashrc ]] && . ~/.bashrc

if [ $UNAME_PLATFORM = "Darwin" ]; then

  if [ -z $PATD_PATH ]; then
    for i in /etc/paths.d/*; do PATD_PATH=$(cat $i):${PATD_PATH}; done
  fi
  export PATH=${USRH_PATH}:${USRL_PATH}:${SYST_PATH}:${GAME_PATH}:${PATD_PATH/%:/}:${CUST_PATH}

  BREW_PREFIX=$(brew --prefix 2>/dev/null)

  if [ "$BREW_PREFIX" != "" ]; then
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

  if [[ -f "/usr/pkg/share/bash-completion/bash_completion" ]]; then
    . "/usr/pkg/share/bash-completion/bash_completion"
  fi

  PATH=${USRH_PATH}:${USRL_PATH}:${USRP_PATH}:${SYST_PATH}:/usr/X11R7/bin:/usr/X11R6/bin:${GAME_PATH}:${CUST_PATH}
  export ENV=$HOME/.shrc

  if which gls &>/dev/null; then
    alias ls='gls --color=auto'
  fi

elif [[ "$UNAME_PLATFORM" == "Linux" ]]; then

  export PATH=${USRH_PATH}:${URSL_PATH}:${SYST_PATH}:${GAME_PATH}:${CUST_PATH}

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

export EDITOR=vi
export PAGER=less

shopt -s cdspell

set -o notify

alias grep='grep --color=always'

alias ll='ls -l'

alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'
alias gstatus='git status'

if [[ $GIT_PROMPT_LOADED -eq '1' ]]; then
  PS1='\[\e[0;32m\]\u\[\e[0;34m\]@\H \[\e[1;31m\][\[\e[0;33m\]\W\[\e[0;34m\]$(__git_ps1 "{%s}")\[\e[1;31m\]] \[\e[1;34m\]\$\[\e[m\] '
else
  PS1="\[\e[0;32m\]\u\[\e[0;34m\]@\H \[\e[1;31m\][\[\e[0;33m\]\W\[\e[1;31m\]] \[\e[1;34m\]\$\[\e[0;0m\] "
fi

HISTCONTROL=ignorespace:erasedups
