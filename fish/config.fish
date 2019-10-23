#-----------------------#
# CONFIG                #
#-----------------------#
set -g ConfigDir ~/.config/fish/
#echo $fish_function_path (dirname (status --current-filename))/synced_functions (dirname (readlink -m (status --current-filename)))/synced_functions
set fish_function_path (dirname (status --current-filename))/synced_functions/ $fish_function_path
set fish_complete_path (dirname (status --current-filename))/synced_completions/ $fish_complete_path

# set vim mode
fish_vi_key_bindings

# load colors
source {$ConfigDir}colors.fish

# set vars and path
source {$ConfigDir}variables.fish

# load abbreviations
source {$ConfigDir}abbreviations.fish

# load aliases
source {$ConfigDir}aliases.fish

# load keymanagement
source {$ConfigDir}keymanagement.fish

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
