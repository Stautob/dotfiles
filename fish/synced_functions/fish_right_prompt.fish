function fish_right_prompt -d "Write out the right prompt"
    if test "$dirstack[1]"
        test (count $dirstack) -gt 1
        and set more " +"

        function __util_pretty_path -a path
            echo -n (string replace "$HOME" "~" $path | string replace --all --regex "(?'short'\.?[^/])[^/]*/" "\$short/")
        end

        __util_color_print (__util_enclose_in_brackets (__util_pretty_path "$dirstack[1]$more")) green --bold
    end
end
