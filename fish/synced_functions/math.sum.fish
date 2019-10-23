# Defined in /home/tstauber/.config/fish/greeter.fish @ line 5
function math.sum
	echo (functional.reduce 0 "math {1} + {2}" $argv)
end
