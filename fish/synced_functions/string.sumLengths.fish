# Defined in /home/tstauber/.config/fish/greeter.fish @ line 10
function string.sumLengths
	echo (functional.reduce 0 "math -- {1} + (string length \"{2}\")" $argv)
end
