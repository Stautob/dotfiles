
set POETRY_FILE "pyproject.toml"

set GLOBAL_OPTS "-h" "-q" "-v" "-V" "-n" "--help" "--quiet" "--verbose" "--version" "--ansi" "--no-ansi" "--no-interaction"
set COMMANDS about add build cache check config debug env export help init install lock new publish remove run search self shell show update version




function __fish_poetry_needs_command
  set -l cmd (commandline -opc)
  if not test -f $PWD/$POETRY_FILE
    echo "No Poetry file"
    return 1
  end
  for i in $cmd
    if not contains $i $GLOBAL_OPTS
      return 1
    end
  end
  return 0
end

function __fish_poetry_takes_global_opt
  set -l cmd (commandline -opc)
  for i in $cmd
    if not contains $i $GLOBAL_OPTS
      return 1
    end
  end
  return 0
end

function __fish_poetry_using_command -a current_command
  set -l cmd (commandline -opc)
  #TODO test if only one in COMMANDS and rest in GLOBAL_OPTS
  test (count $cmd) -ge 2; and test $current_command = $cmd[2]
end

function __fish_poetry_arg_number -a number
  set -l cmd (commandline -opc)
  test (count $cmd) -eq $number
end

function __fish_poetry_list_scripts
  sed -n '1,/\[tool\.poetry\.scripts\]/d;/^\s*$/q;p' $PWD/$POETRY_FILE | sed -r -n 's/^[[:blank:]]*([^[:blank:]=]*).*$/\1/p'
end

# Global Options
complete -c poetry -n '__fish_poetry_needs_command' -f -s h -l help -d 'Display the help message'
complete -c poetry -n '__fish_poetry_needs_command' -f -s q -l quiet -d 'Do not output any message'
complete -c poetry -n '__fish_poetry_needs_command' -f -s v -l verbose -d 'Increase the verbosity of messages: "-v" for normal output, "-vv" for more verbose output and "-vvv" for debug"'
complete -c poetry -n '__fish_poetry_needs_command' -f -s V -l version -d 'Display this application version'
complete -c poetry -n '__fish_poetry_needs_command' -f -l ansi -d 'Force ANSI output'
complete -c poetry -n '__fish_poetry_needs_command' -f -l no-ansi -d 'Disable ANSI output'
complete -c poetry -n '__fish_poetry_needs_command' -f -s n -l no-interaction -d 'Do not ask any interactive questions'

# Available Commands
complete -f -c poetry -n '__fish_poetry_needs_command' -a  about   -d "Shows information about Poetry."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  add     -d "Adds a new dependency to pyproject.toml."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  build   -d "Builds a package, as a tarball and a wheel by default."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  cache   -d "Interact with Poetry's cache"

complete -f -c poetry -n '__fish_poetry_needs_command' -a  check   -d "Checks the validity of the pyproject.toml file.'"

complete -f -c poetry -n '__fish_poetry_needs_command' -a  config  -d "Manages configuration settings."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  debug   -d "Debug various elements of Poetry."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  env     -d "Interact with Poetry's project environments."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  export  -d "Exports the lock file to alternative formats."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  help    -d "Display the manual of a command"

complete -f -c poetry -n '__fish_poetry_needs_command' -a  init    -d "Creates a basic pyproject.toml file in the current directory."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  install -d "Installs the project dependencies."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  lock    -d "Locks the project dependencies."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  new     -d "Creates a new Python project at <path>."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  publish -d "Publishes a package to a remote repository."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  remove  -d "Removes a package from the project dependencies."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  run     -d "Runs a command in the appropriate environment."
complete -f -c poetry -n '__fish_poetry_using_command run; and __fish_poetry_arg_number 2' -a '(__fish_poetry_list_scripts)'

complete -f -c poetry -n '__fish_poetry_needs_command' -a  search  -d "Searches for packages on remote repositories."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  self    -d "Interact with Poetry directly."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  shell   -d "Spawns a shell within the virtual environment."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  show    -d "Shows information about packages."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  update  -d "Update the dependencies as according to the pyproject.toml file."

complete -f -c poetry -n '__fish_poetry_needs_command' -a  version -d "Shows the version of the project or bumps it when a valid bump rule is provided."

