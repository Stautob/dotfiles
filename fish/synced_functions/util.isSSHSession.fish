function util.isSSHSession
  return (test -n "$SSH_CLIENT" -o -n "$SSH_TTY")
end
