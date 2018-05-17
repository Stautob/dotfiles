UNAME_PLATFORM=$(uname)

USRH_PATH=~/.bin
OPT_PATH=/opt/rabbitMQ:/opt/android-studio/bin:
USRL_PATH=/usr/local/bin:/usr/local/sbin
GAME_PATH=/usr/games:/usr/local/games
USRP_PATH=/usr/pkg/bin:/usr/pkg/sbin
SYST_PATH=/bin:/sbin:/usr/bin:/usr/sbin

[[ -f $HOME/.bashrc ]] && . ~/.bashrc


# If of NetBSD
if [ $UNAME_PLATFORM = "NetBSD" ]; then

  if [[ -f "/usr/pkg/share/bash-completion/bash_completion" ]]; then
    . "/usr/pkg/share/bash-completion/bash_completion"
  fi

  PATH=${USRH_PATH}:${USRL_PATH}:${USRP_PATH}:${SYST_PATH}:/usr/X11R7/bin:/usr/X11R6/bin:${GAME_PATH}:${CUST_PATH}
  export ENV=$HOME/.shrc

  if which gls &>/dev/null; then
    alias ls='gls --color=auto'
  fi


# If on LINUX
elif [[ "$UNAME_PLATFORM" == "Linux" ]]; then

  export PATH=${USRH_PATH}:${URSL_PATH}:${OPT_PATH}:${SYST_PATH}:${GAME_PATH}:${CUST_PATH}

  if [[ "$COLORTERM" == "termite" || "$COLORTERM" == "terminator" || "$COLORTERM" == "mate-terminal" ]]
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

echo $PATH > /tmp/path1

export EDITOR=nvim
export PAGER=less

shopt -s cdspell

set -o notify

alias grep='grep --color=always'

alias ll='ls -1a --color=auto'
alias la='ls -la --color=auto'

alias gpush='git push'
alias gpull='git pull'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheckout='git checkout'
alias gclone='git clone'
alias gst='git status'

if [[ $GIT_PROMPT_LOADED -eq '1' ]]; then
  PS1='\[\e[0;32m\]\u\[\e[0;34m\]@\H \[\e[1;31m\][\[\e[0;33m\]\W\[\e[0;34m\]$(__git_ps1 "{%s}")\[\e[1;31m\]] \[\e[1;34m\]\$\[\e[m\] '
else
  PS1="\[\e[0;32m\]\u\[\e[0;34m\]@\H \[\e[1;31m\][\[\e[0;33m\]\W\[\e[1;31m\]] \[\e[1;34m\]\$\[\e[0;0m\] "
fi

HISTCONTROL=ignorespace:erasedups

export SHELL=/usr/bin/fish
