#----------------------#
# GREETER              #
#----------------------#

function fish_greeting

  #Needs lm-sensors

  set lt_green   addc10
  set med_green  189303
  set dk_green   0c4801

  set lt_red     C99
  set med_red    ce000f
  set dk_red     600

  set slate_blue 255e87

  set lt_orange  f6b117
  set med_orange fd8d1b
  set dk_orange  3a2a03

  set med_yellow f0fd1b

  set dk_grey    000
  set med_grey   999
  set lt_grey    ccc


  #border
  set_color $med_green
  printf "┏━┱%s┐" (for i in (seq (math $COLUMNS-4)); printf '─'; end)
  printf "┃ "

  #lastlogin
  set_color normal
  set greeter_lastlogin (last -R $USER |head -n1|awk '{print $3,$4,$5,$6}')
  printf "Last Login..:%"(math $COLUMNS-17)"s" $greeter_lastlogin
  set_color $med_green
  printf " │\n┃ "
 
  #Uptime
  set_color normal
  printf "Uptime......:%"(math $COLUMNS-17)"s" (uptime | awk '{print substr($5, 0, length($5)-1)}')
  set_color $med_green
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
  printf "%"(math $COLUMNS-18)"s%%" $greeter_dusage
  set_color $med_green
  printf " │\n┃ "

  #SSH Logins
  set_color normal
  set greeter_sshc (ps -A x |grep "[s]shd: .* \[priv\]"|wc -l)
  printf "SSH Logins..:%"(math $COLUMNS-17)"s" $greeter_sshc
  set_color $med_green
  printf " │\n┃ "

  #Processes
  set_color normal
  set greeter_pcount (echo (ps ax|wc -l) "("(ps|wc -l)")")
  printf "Processes...:%"(math $COLUMNS-17)"s" $greeter_pcount
  set_color $med_green
  printf " │\n┃ "

  #Avg- load
  set_color normal
  printf "Avg-load....:"
 
  #colorpicker
  set greeter_uptime (printf "%.0f" (math (uptime | awk '{print $12}')\*100))
  if [ $greeter_uptime -gt 50 ]
      set_color $med_red
  else if [ $greeter_uptime -gt 30 ]
      set_color $med_orange
  else if [ $greeter_uptime -gt 15 ]
      set_color $med_yellow
  else
      set_color $med_green
  end
  printf "%"(math $COLUMNS-18)"s%%" $greeter_uptime
  set_color $med_green
  printf " │\n┃ "

  #Temperature
  set_color normal
  printf "Temperature.:"

  #colorpicker
  set greeter_temp (sensors | awk '/Physical id 0/ {print substr($4, 2, length($4)-5)}')
  if [ $greeter_temp -gt 80 ]
      set_color $med_red
  else if [ $greeter_temp -gt 60 ]
      set_color $med_orange
  else if [ $greeter_temp -gt 50 ]
      set_color $med_yellow
  else
      set_color $med_green
  end
  printf "%"(math $COLUMNS-17)"s" (sensors | awk '/Physical id 0/ {print $4}')

  #border
  set_color $med_green
  printf " │\n┗━┹%s┘" (for i in (seq (math $COLUMNS-4)); printf '─'; end)
end
