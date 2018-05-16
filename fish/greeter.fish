#----------------------#
# GREETER              #
#----------------------#

function math.sum
    echo (functional.reduce 0 "math {1} + {2}" $argv)
end


function string.sumLengths
  echo (functional.reduce 0 "math -- {1} + (string length \"{2}\")" $argv)
end

function util.replaceParams -a command
    for i in (seq 1 (count $argv[2..-1]))
        if string match -q "*{$i}*" $command
            set argvindex (math $i + 1)
            set command (string replace "{$i}" $argv[(math $i + 1)] $command)
        else
            echo "No param {$i} found!"
            return 1
        end
    end
    echo $command
end

function util.percentualColor -a percentage high medium low

    set med_green 189303
    set med_red ce000f
    set med_orange fd8d1b
    set med_yellow f0fd1b

    if [ $percentage -gt $high ]
        echo $med_red
    else if [ $percentage -gt $medium ]
        echo $med_orange
    else if [ $percentage -gt $low ]
        echo $med_yellow
    else
        echo $med_green
    end
end

function functional.reduce -a base fun
    for i in $argv[3..-1]
        set base (eval (util.replaceParams $fun $base $i))
    end
    echo $base
end

function functional.map -a fun
    for i in $argv[2..-1]
        if string match -r -q ".*{\d+}.*" $fun
            if set command (util.replaceParams $fun $i)
                echo (eval $command)
            else
                echo "Parameter replacement failed: $command"
                return 1
            end
        else
            echo (eval $fun $i)
        end
    end
end

function __g1_color_print -a text color
  set_color $color; echo $text; set_color normal
end

function __g1_print_padded -a width pref_color prefix key_color key padding_color padding_char value_color value suffix_color suffix
    set_color $pref_color; echo -en $prefix
    set_color $key_color; echo -en $key
    set_color $padding_color; echo -en (string repeat --count (math \( $width-(string.sumLengths $prefix $key $value $suffix) \) / (string length "$padding_char")) $padding_char )
    set_color $value_color; echo -en $value
    set_color $suffix_color; echo -en $suffix
end

function fish_greeting -d "Prints fish-greeting"

    ILTIS_is_remote; or return 0

    set med_green 189303
    set med_red ce000f
    set med_orange fd8d1b
    set med_yellow f0fd1b

    sleep 0.2 # Needed for terminal to open
    set columns $COLUMNS

    #border and title
    set dusage (df -k /home| awk '{print substr($5, 0, length($5)-1)}'|tail -n1)
    set avgLoad (printf "%.0f" (math (uptime | awk '{print $NF}')\*100))

    __g1_print_padded $columns green "┏━┱" normal "" green "─" normal "" green "┐"
    __g1_print_padded $columns green "┃ " red "WELCOME TO "(hostname) normal " " normal "" green "│"
    __g1_print_padded $columns green "┠─╂" normal "" green "─" normal "" green "┤"
    __g1_print_padded $columns green "┃ " normal "Last Login..:" normal " " normal (last -R $USER |head -n1|awk '{print $3,$4,$5,$6}') green "│"
    __g1_print_padded $columns green "┃ " normal "Uptime......:" normal " " normal (uptime | awk '{print substr($5, 0, length($5)-1)}') green "│"
    __g1_print_padded $columns green "┃ " normal "Disk Usage..:" normal " " (util.percentualColor $dusage 50 30 15) "$dusage%" green "│"
    __g1_print_padded $columns green "┃ " normal "SSH Logins..:" normal " " normal (ps -A x |grep "[s]shd: .* \[priv\]"|wc -l) green "│"
    __g1_print_padded $columns green "┃ " normal "Processes...:" normal " " normal (echo (ps ax|wc -l) "(U:"(ps|wc -l)")") green "│"
    __g1_print_padded $columns green "┃ " normal "Avg-Load....:" normal " " (util.percentualColor $avgLoad 50 30 15) "$avgLoad%" green "│"
    __g1_print_padded $columns green "┗━┹" normal "" green "─" normal "" green "┘"
end
