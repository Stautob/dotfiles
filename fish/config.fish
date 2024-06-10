#-----------------------#
# CONFIG                #
#-----------------------#
set -g ConfigDir ~/.config/fish/
#echo $fish_function_path (dirname (status --current-filename))/synced_functions (dirname (readlink -m (status --current-filename)))/synced_functions
set fish_function_path (dirname (status --current-filename))/synced_functions/ $fish_function_path
set fish_complete_path (dirname (status --current-filename))/synced_completions/ $fish_complete_path

# set vim mode
fish_vi_key_bindings

# Debug setup
set debug_buffer ""

function fish_debug -a key line --on-event print_debug
  if test "$PRINT_DEBUG" = "true"
    if test -z "$key"
      echo "A key must be provided"
    end
    set debug_buffer $debug_buffer "$key"$line
  end
end

function flush_fish_debug -a key file --on-event flush_debug
  if test "$PRINT_DEBUG" = "true"
    if test -z "$file"
      set file "/tmp/fish_debug.log"
    end
    if test -z "$key"
      echo "A key must be provided"
    end
    echo "-------------[$key]--------------" >> $file
    for i in (seq (count $debug_buffer) 1)
      if set lines (sting match $key $debug_buffer[$1])
        echo $lines[2] >> $file
        set -e $debug_buffer[i]
      end
    end
  end
end


#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

eval (ssh-agent -c)

#source /usr/local/opt/asdf/libexec/asdf.fish

#eval (direnv hook fish)
