# Defined in /home/tstauber/.config/fish/greeter.fish @ line 45
function functional.reduce --argument base fun
	for i in $argv[3..-1]
        set base (eval (util.replaceParams $fun $base $i))
    end
    echo $base
end
