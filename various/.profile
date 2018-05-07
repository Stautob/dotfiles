if [ -d "$HOME/bin" ] ; then
  export PATH="$PATH:$HOME/bin"
fi

echo $PATH >> /tmp/path.profile

export TERMINAL=/usr/bin/termite
export SHELL=/usr/bin/fish
