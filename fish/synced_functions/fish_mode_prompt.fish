function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo -en (util.encloseInParentheses 'N')
    case insert
      set_color --bold green
      echo -en (util.encloseInParentheses 'I')
    case replace_one
      set_color --bold green
      echo -en (util.encloseInParentheses 'R')
    case visual
      set_color --bold brmagenta
      echo -en (util.encloseInParentheses 'V')
    case '*'
      set_color --bold red
      echo -en (util.encloseInParentheses '?')
  end
  echo -en " "
  set_color normal
end
