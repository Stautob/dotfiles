
switch (uname)
    case Darwin
        # do things for macOS
	eval (/opt/homebrew/bin/brew shellenv)
	fish_add_path "/Users/tstauber/.dotnet/tools"
	fish_add_path "/Users/tstauber/Library/Application Support/JetBrains/Toolbox/scripts"

	if test -d "~/.jetbrains.vmoptions.fish"
  	   source ~/.jetbrains.vmoptions.fish 
	end
    case Linux
        # do things for Linux
    case '*'
        # do things for other OSs
end
