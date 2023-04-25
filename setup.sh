#!/bin/bash

set -e
set -u

########## Variables

DOTFILES_DIR=$HOME/dotfiles
if [ $USER == "codespace" ]; then
  DOTFILES_DIR=/workspaces/.codespaces/.persistedshare/dotfiles
fi
if [ $(git remote get-url origin) == "https://github.com/Jacob-Roberts/dotfiles" ]; then
  DOTFILES_DIR=$(pwd)
fi

PATH=${DOTFILES_DIR}/bin:${PATH}
HOMEBREW_PREFIX=$(bin/is-supported bin/is-macos $(bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
export XDG_CONFIG_HOME=${HOME}/.config

##########


link () {
# create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
  for file in $(ls -A zsh); do 
    if [ -f ${HOME}/$file -a ! -h ${HOME}/$file ]; then
      echo "backing up $file"
      mv -v ${HOME}/$file{,.bak};
    fi
    echo "Creating symlink to $file in home directory."
    ln -sf $DOTFILES_DIR/zsh/$file ~/$file
  done

  echo "Creating ${XDG_CONFIG_HOME} directory"
  mkdir -p ${XDG_CONFIG_HOME}
  for folder in $(ls -A config); do
      mkdir -p ${XDG_CONFIG_HOME}/$folder
    for file in $(ls -A config/$folder); do
      if [ -f ${XDG_CONFIG_HOME}/$folder/$file -a ! -h ${XDG_CONFIG_HOME}/$folder/$file ]; then
        echo "backing up ${XDG_CONFIG_HOME}/$folder/$file"
        mv -v ${XDG_CONFIG_HOME}/$folder/$file{,.bak};
      fi
      echo "Creating symlink from $DOTFILES_DIR/config/$folder/$file to ${XDG_CONFIG_HOME}/$folder/$file"
      ln -sf $DOTFILES_DIR/config/$folder/$file $XDG_CONFIG_HOME/$folder/$file
    done
  done
}

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then

    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    echo "==========================================================="
    echo "             cloning oh-my-zsh                  "
    echo "-----------------------------------------------------------"   
    if [[ ! -d ${ZSH:-~/.oh-my-zsh} ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    else 
      echo "========================== done ==========================="
    fi
    echo ""

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

brew_install() {
  if is-executable brew ; then
    echo "brew is installed"
  else
    echo "==========================================================="
    echo "             installing homebrew                           "
    echo "-----------------------------------------------------------"   
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
    eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
    brew --version
  fi
}

git () {
  brew install git
}

npm () {
  fnm install --lts
}

brew_packages () {
  brew_install
  brew bundle --file=${DOTFILES_DIR}/installManifest/Brewfile
}

cask_apps () {
  brew bundle --file=${DOTFILES_DIR}/installManifest/Caskfile
}

node_packages () {
  npm install -g $(cat ${DOTFILES_DIR}/installManifest/npmfile)
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
  packages
  link
elif [[ $platform == "Darwin" ]]; then
  core_macos
  packages
  cask_apps
  link
fi


