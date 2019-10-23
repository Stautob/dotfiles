# Defined in /home/tstauber/.config/fish/greeter.fish @ line 27
function util.percentualColor --argument percentage high medium low
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
