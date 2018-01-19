#!/bin/bash
# Script to install and configure necessary applications

DotfilesPath=`sed -n 's/\/$//p' <<< $(grep -o '.*/' <<< $(dirname $(realpath $0)))`
AURGitLink="https://github.com/gavinhungry/packer.git"
ScriptPath="${DotfilesPath%/*}/scripts"
DefaultvarsPath="${DotfilesPath}/fish/default_vars.fish"
DotfilescriptPath="${DotfilesPath}/setup/dotfilescript.sh"
DefaultappsConfigPath="${DotfilesPath}/setup/.defaultapps.conf"
DotfilesURL="https://bitbucket.org/stautob/dotfiles.git"
KeyPath="~/.ssh/id_rsa.1"

installApacman () {
  pacman --noconfirm -S fakeroot jshon expac wget make gcc
  git clone $AURGitLink
  ./packer/packer --noedit --noconfirm -S packer-git
  rm -rf ./packer
}

setup () {
  # install ui stuff and edit /etc/pam.d/lightdm
  installPacker
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
  # Test if apacman is installed else use pacman
  command -p apacman --noedit --noconfirm -S $@ || pacman --noconfirm -S $@
  echo "----------------------------------------------------------------------------------------"
}

installApps () {
  install $(< $DefaultappsConfigPath)
}

configureApps () {
  # Syntax: configureApps [def_hostname] [def_username]
  c_setGitDefaultCredStore
  c_createFishDefaultVars $2 $3
  c_linkDotfiles
  c_install_ycm
}

c_setGitDefaultCredStore () {
  git config --global credential.helper /usr/lib/git-core/git-credential-gnome-keyring
}

c_createFishDefaultVars () {
  touch $DefaultvarsPath
  echo "#!/bin/fish" > $DefaultvarsPath
  echo "set -g default_host $1" >> $DefaultvarsPath
  echo "set -g default_user $2" >> $DefaultvarsPath
  echo "set -gx SCRIPTPATH $ScriptPath" >> $DefaultvarsPath
  echo "Created ${DefaultvarsPath##*/}"
}

c_linkDotfiles () {
  echo "Linking dotfiles"
  ${DotfilesPath}/setup/dotfilescript.sh
}

c_install_ycm () {
  ${DotfilesPath}/vim/.vim/bundle/YouCompleteMe/install.py --clang-completer
}

printhelp () {
  echo "Usage: $0 -h                                   show this message"
  echo "       $0 -s [def_hostname] [def_username]     setup (install and configure)"
  echo "       $0 -i                                   install software"
  echo "       $0 -c [def_hostname] [def_username]     configure system"
}

# Main
case $1 in
  "") printhelp ; exit 0 ;;
  -h) printhelp ; exit 0 ;;
  -s) setup ; exit 0 ;;
  -i) installApps ; exit 0 ;;
  -c) configureApps $@ ; exit 0 ;;
  *) ;;
esac

# TODO:
#       fstab entry for hsr-dfs

