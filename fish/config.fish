#-----------------------#
# CONFIG                #
#-----------------------#
set -g ConfigDir ~/.config/fish/

# set vim mode
fish_vi_key_bindings

# load colors
source {$ConfigDir}colors.fish

# set vars and path
source {$ConfigDir}vars.fish

# set default vars
#source {$ConfigDir}default_vars.fish

# load prompt
source {$ConfigDir}prompt.fish

# load functions
source {$ConfigDir}functions.fish

# load displayfunctions
source {$ConfigDir}functions_display.fish

# load greetersourcefish
source {$ConfigDir}greeter.fish

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
