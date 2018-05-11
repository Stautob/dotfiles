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

# load promptsourcefish
source {$ConfigDir}prompt.fish

# load functionssourcefish
source {$ConfigDir}functions.fish

# load displayfunctions
source {$ConfigDir}functions_display.fish

# load greetersourcefish
# source {$ConfigDir}greeter.fish

# load keymanagement
source {$ConfigDir}keymanagement.fish

# Debug setup
set debug_buffer ""
set debug_key ""

function fish_debug -a key line --on-event print_debug
  echo "key: $key line: $line debug_key: $debug_key"
  if test "$key" != "$debug_key"
    if test -n "$debug_buffer[1]"
      flush_fish_debug
    end
    set debug_key $key
    set debug_buffer "-------------[$debug_key]--------------"
  end
  set debug_buffer $debug_buffer $line
end

function flush_fish_debug -a file --on-event flush_debug
  if test -z $file
    set file "/tmp/fish_debug.log"
  end
  for line in $debug_buffer
    echo $line >> $file
  end
  set debug_buffer ""
  set debug_key ""
end
