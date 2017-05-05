#-----------------------#
# CONFIG                #
#-----------------------#
set -g ConfigDir ~/.config/fish/

# set vars and path
source {$ConfigDir}vars.fish

# set default vars
source {$ConfigDir}default_vars.fish

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
