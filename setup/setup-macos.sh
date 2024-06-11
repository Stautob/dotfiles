echo "Setting up MacOS"


xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Fishshell is done via standard configuration

# TERMINAL
brew install alacritty 
brew install fish
brew install neovim

# PROGRAMMING
brew install pipx
brew install poetry
brew install jetbrains-toolbox
brew install openjdk@17
#
#openjdk@17 is keg-only, which means it was not symlinked into /opt/homebrew,
#because this is an alternate version of another formula.
#
#If you need to have openjdk@17 first in your PATH, run:
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
#
#For compilers to find openjdk@17 you may need to set:
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"



brew install docker
brew install colima

# Online Tools
brew install firefox
brew install --cask onedrive
#brew install all-in-one-messenger

# Convenience Tools
brew install rectangle

brew tap homebrew/cask-fonts
brew install font-jetbrains-mono

# MULTI MEDIA
brew install tidal


# TODO improve 
sudo cp us-altgr-intl.keylayout /Library/Keyboard\ Layouts


mkdir -p ~/repos/{stautob,gnice,other}/

mkdir -p ~/.config/git/
echo .DS_Store >> ~/.config/git/ignore

cd ~/repos/stautob/
git clone git@github.com:Stautob/dotfiles.git


# Think about editing the dock acordingly automatically
defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///path/to/file%20name.pdf</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>32</integer></dict><key>tile-type</key><string>file-tile</string></dict>"; killall Dock
