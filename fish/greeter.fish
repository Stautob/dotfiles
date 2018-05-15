#----------------------#
# GREETER              #
#----------------------#

function fish_greeting -d "Prints fish-greeting"

  ILTIS_is_remote; or return 0

  set med_green  189303
  set med_red    ce000f
  set med_orange fd8d1b
  set med_yellow f0fd1b

  sleep 0.2 # Needed for terminal to open
  set columns $COLUMNS


  #border
  set_color green
  printf "┏━┱%s┐" (for i in (seq (math $columns-4)); printf '─'; end)
  printf "┃ "; set_color red --bold; printf "WELCOME TO %s %"(math $columns-15-(string length (hostname)))"s" (hostname)
  set_color green
  printf "│┠─╂%s┤" (for i in (seq (math $columns-4)); printf '─'; end)
  printf "┃ "

  #lastlogin
  set_color normal
  set greeter_lastlogin (last -R $USER |head -n1|awk '{print $3,$4,$5,$6}')
  printf "Last Login..:%"(math $columns-17)"s" $greeter_lastlogin
  set_color green
  printf " │\n┃ "

  #Uptime
  set_color normal
  printf "Uptime......:%"(math $columns-17)"s" (uptime | awk '{print substr($5, 0, length($5)-1)}')
  set_color green
  printf " │\n┃ "

  #Disk Usage
  set_color normal
  printf "Disk Usage..:"

  #colorpicker
  set greeter_dusage (df -k /home| awk '{print substr($5, 0, length($5)-1)}'|tail -n1)
  if [ $greeter_dusage -gt 50 ]
      set_color $med_red
  else if [ $greeter_dusage -gt 30 ]
      set_color $med_orange
  else if [ $greeter_dusage -gt 15 ]
      set_color $med_yellow
  else
      set_color $med_green
  end
  printf "%"(math $columns-18)"s%%" $greeter_dusage
  set_color green
  printf " │\n┃ "

  #SSH Logins
  set_color normal
  set greeter_sshc (ps -A x |grep "[s]shd: .* \[priv\]"|wc -l)
  printf "SSH Logins..:%"(math $columns-17)"s" $greeter_sshc
  set_color green
  printf " │\n┃ "

  #Processes
  set_color normal
  set greeter_pcount (echo (ps ax|wc -l) "("(ps|wc -l)")")
  printf "Processes...:%"(math $columns-17)"s" $greeter_pcount
  set_color green
  printf " │\n┃ "

  #Avg- load
  set_color normal
  printf "Avg-load....:"

  #colorpicker
  set greeter_uptime (printf "%.0f" (math (uptime | awk '{print $NF}')\*100))
  if [ $greeter_uptime -gt 50 ]
      set_color $med_red
  else if [ $greeter_uptime -gt 30 ]
      set_color $med_orange
  else if [ $greeter_uptime -gt 15 ]
      set_color $med_yellow
  else
      set_color $med_green
  end
  printf "%"(math $columns-18)"s%%" $greeter_uptime
  set_color green

  #border
  set_color green
  printf " │\n┗━┹%s┘" (for i in (seq (math $columns-4)); printf '─'; end)
end
