# Defined in /home/tstauber/.config/fish/greeter.fish @ line 14
function fish_greeting --description 'Prints fish-greeting'
	util.isSSHSession; or return 0

    set med_green 189303
    set med_red ce000f
    set med_orange fd8d1b
    set med_yellow f0fd1b

    sleep 0.2 # Needed for terminal to open
    set columns $COLUMNS

    #border and title
    set dusage (df -k /home| awk '{print substr($5, 0, length($5)-1)}'|tail -n1)
    set avgLoad (printf "%.0f" (math (uptime | awk '{print $NF}')\*100))

    string.printPadded $columns green "┏━┱" normal "" green "─" normal "" green "┐"
    string.printPadded $columns green "┃ " red "WELCOME TO "(hostname) normal " " normal "" green "│"
    string.printPadded $columns green "┠─╂" normal "" green "─" normal "" green "┤"
    string.printPadded $columns green "┃ " normal "Last Login..:" normal " " normal (last -R $USER |head -n1|awk '{print $3,$4,$5,$6}') green "│"
    string.printPadded $columns green "┃ " normal "Uptime......:" normal " " normal (uptime | awk '{print substr($5, 0, length($5)-1)}') green "│"
    string.printPadded $columns green "┃ " normal "Disk Usage..:" normal " " (util.percentualColor $dusage 50 30 15) "$dusage%" green "│"
    string.printPadded $columns green "┃ " normal "SSH Logins..:" normal " " normal (ps -A x |grep "[s]shd: .* \[priv\]"|wc -l) green "│"
    string.printPadded $columns green "┃ " normal "Processes...:" normal " " normal (echo (ps ax|wc -l) "(U:"(ps|wc -l)")") green "│"
    string.printPadded $columns green "┃ " normal "Avg-Load....:" normal " " (util.percentualColor $avgLoad 50 30 15) "$avgLoad%" green "│"
    string.printPadded $columns green "┗━┹" normal "" green "─" normal "" green "┘"
end
