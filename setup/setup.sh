#!/bin/bash
# Script to install and configure necessary applications

DotfilesPath=`sed -n 's/\/$//p' <<< $(grep -o '.*/' <<< $(dirname $(realpath $0)))`
AURGitLink="https://aur.archlinux.org/aurman.git"
ScriptPath="${DotfilesPath%/*}/scripts"
DefaultvarsPath="~/.config/fish/default_vars.fish"
DotfilescriptPath="${DotfilesPath}/setup/dotfilescript.sh"
DefaultappsConfigPath="${DotfilesPath}/setup/.defaultapps.conf"
DotfilesURL="https://bitbucket.org/stautob/dotfiles.git"
KeyPath="~/.ssh/id_rsa.1"

installAurman () {
  pacman --noconfirm -S fakeroot jshon expac wget make gcc
  git clone $AURGitLink
  cd ./aurman/
  makepkg -si
  cd ..
  rm -rf ./aurman
}

installChannels () {
  source ${DotfilesPath}/setup/pacman_keys.sh
  source ${DotfilesPath}/setup/pacman_channels.sh
}

setup () {
  # install ui stuff and edit /etc/pam.d/lightdm
  installAurman
  installApps
  configureApps $2 $3
  setupUI
  setupOTHER
}

setupUI () {
  gsettings set org.gnome.desktop.interface icon-theme 'deepin'
  gsettings set org.gnome.desktop.interface cursor-theme 'deepin'
  sudo systemctl enable lightdm.service
}

setupOTHER () {
  sudo sed -ie "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers
  sudo systemctl enable NetworkManager.service
  sudo systemctl enable ntpd.service
}

install () {
  # Test if aurman is installed else use pacman
  installChannels
  command -p aurman --noedit --noconfirm -Syyu || sudo pacman --noconfirm -Syyu
  command -p aurman --noedit --noconfirm -S $@ || sudo pacman --noconfirm -S $@
  echo "----------------------------------------------------------------------------------------"
}

installApps () {
  install $(< $DefaultappsConfigPath)
}

configureApps () {
  # Syntax: configureApps [def_hostname] [def_username]
  c_setGitDefaultCredStore
  c_createFishDefaultVars $2 $3
  fish -c fisher
  c_linkDotfiles
  c_install_ycm
}

c_setGitDefaultCredStore () {
  git config --global credential.helper /usr/lib/git-core/git-credential-gnome-keyring
}

c_createFishDefaultVars () {
  touch $DefaultvarsPath
  echo "#!/bin/fish" > $DefaultvarsPath
  echo "set -g default_user $2" >> $DefaultvarsPath
  echo "set -gx SCRIPTPATH $ScriptPath" >> $DefaultvarsPath
  echo "Created $DefaultvarsPath"
}

c_linkDotfiles () {
  echo "Linking dotfiles"
  ${DotfilescriptPath} --create-links
}

c_install_ycm () {
  ${DotfilesPath}/vim/.vim/bundle/YouCompleteMe/install.py --clang-completer
}

printHelp () {
  echo "Usage: $0 -h | --help                                               show this message"
  echo "       $0 -s | --setup [def_hostname] [def_username]                setup (install and configure)"
  echo "       $0 -i | --install-apps                                       install software"
  echo "       $0 -c | --configure-apps [def_hostname] [def_username]       configure system"
  echo "       $0 -d | --create-default-vars [def_hostname] [def_username]  created default variables"
}

# Main
case $1 in
  "") printHelp ; exit 0 ;;
  -h|--help) printHelp ; exit 0 ;;
  -s|--setup) setup ; exit 0 ;;
  -i|--install-apps) installApps ; exit 0 ;;
  -c|--configure-apps) configureApps $@ ; exit 0 ;;
  -d|--create-default-vars) c_createFishDefaultVars $@ ; exit 0 ;;
  *) printHelp ; exit 0 ;;
esac

# TODO:
#       fstab entry for hsr-dfs

