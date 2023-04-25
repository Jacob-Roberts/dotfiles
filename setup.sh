#!/bin/bash

set -e
set -u

DOTFILES_DIR=$HOME/dotfiles
if [ $USER == "codespace" ]; then
  DOTFILES_DIR=/workspaces/.codespaces/.persistedshare/dotfiles
fi
if [ $(git remote get-url origin) == "https://github.com/Jacob-Roberts/dotfiles" ]; then
  DOTFILES_DIR=$(pwd)
fi

PATH=${DOTFILES_DIR}/bin:${PATH}
OS=$(bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX=$(bin/is-supported bin/is-macos $(bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
SHELLS=/private/etc/shells
BASH_BIN=${HOMEBREW_PREFIX}/bin/bash
BREW_BIN=${HOMEBREW_PREFIX}/bin/brew
CARGO_BIN=${HOMEBREW_PREFIX}/bin/cargo
FNM_BIN=${HOMEBREW_PREFIX}/bin/fnm
STOW_BIN=${HOMEBREW_PREFIX}/bin/stow
export XDG_CONFIG_HOME=${HOME}/.config

########## Variables

files="bashrc vimrc vim zshrc oh-my-zsh private scrotwm.conf Xresources"    # list of files/folders to symlink in homedir

##########


link () {
# create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $(\ls -A zsh); do 
    if [ -f ${HOME}/$file -a ! -h ${HOME}/$file ]; then
      echo "backing up $file"
      mv -v ${HOME}/$file{,.bak};
    fi
    echo "Creating symlink to $file in home directory."
    ln -sf $DOTFILES_DIR/zsh/$file ~/$file
done

    echo "Creating ${XDG_CONFIG_HOME} directory"
    mkdir -p ${XDG_CONFIG_HOME}
    for folder in $(\ls -A config); do
      echo "Creating symlink from $DOTFILES_DIR/config/$folder to ${XDG_CONFIG_HOME}/$folder directory"
      ln -sf $DOTFILES_DIR/config/$folder ${XDG_CONFIG_HOME}/$folder
    done
}

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then

    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    # echo "==========================================================="
    # echo "             cloning oh-my-zsh                  "
    # echo "-----------------------------------------------------------"   
    # if [[ ! -d $HOME/dotfiles/oh-my-zsh/ ]]; then
    #     git clone http://github.com/robbyrussell/oh-my-zsh.git
    # else 
    #   echo "========================== done ==========================="
    # fi
    # echo ""

    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"   
    if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/ ]]; then          
      git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else 
      echo "========================== done ==========================="
    fi
    echo ""

    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        echo "Setting the default shell to zsh"
        sudo chsh "$(id -un)" --shell "$(which zsh)"
        echo "Default shell is now zsh"
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

brew() {
  is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
  eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
  echo "$(brew --version)"
}

brew_packages () {
  brew
  

}

packages () {
  brew_packages
  node_packages
}

core_macos () {
  brew
  git
  npm
}

# Actual install script
install_zsh

platform=$(uname);
if [[ $platform == "Linux" ]]; then
  # packages
  link
elif [[ $platform == "Darwin" ]]; then
  core_macos
  packages
  cask_apps
  link
fi


