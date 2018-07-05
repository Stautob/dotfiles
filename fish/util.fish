
function util.replaceParams -a command -d "Replaces \"{n}\" in \$command with the (n+1)th argument passed to the function"
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

function util.percentualColor -a percentage high medium low -d "Returns a color for a specific percentage"

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

function functional.orElse -a value else
    if [ -z "$value" ]
        echo $else
    else
        echo $value
    end
end

function functional.reduce -a base fun -d "Reduces a list of values using \$fun. The base value is passed in \$base"
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

