# Defined in /home/tstauber/.config/fish/greeter.fish @ line 52
function functional.map --argument fun
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
