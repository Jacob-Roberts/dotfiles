SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)
OS := $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
SHELLS := /private/etc/shells
BASH_BIN := $(HOMEBREW_PREFIX)/bin/bash
BREW_BIN := $(HOMEBREW_PREFIX)/bin/brew
CARGO_BIN := $(HOMEBREW_PREFIX)/bin/cargo
FNM_BIN := $(HOMEBREW_PREFIX)/bin/fnm
STOW_BIN := $(HOMEBREW_PREFIX)/bin/stow
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link

linux: core-linux link

core-macos: brew bash git npm ruby rust

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps node-packages

link:
	for FILE in $$(\ls -A zsh); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) zsh
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	$(STOW_BIN) --delete -t $(HOME) zsh
	$(STOW_BIN) --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

bash: brew
ifdef GITHUB_ACTION
	if ! grep -q $(BASH_BIN) $(SHELLS); then \
		$(BREW_BIN) install bash bash-completion@2 pcre && \
		sudo append $(BASH_BIN) $(SHELLS) && \
		sudo chsh -s $(BASH_BIN); \
	fi
else
	if ! grep -q $(BASH_BIN) $(SHELLS); then \
		$(BREW_BIN) install bash bash-completion@2 pcre && \
		sudo append $(BASH_BIN) $(SHELLS) && \
		chsh -s $(BASH_BIN); \
	fi
endif

git: brew
	$(BREW_BIN) install git

npm: brew-packages
	$(FNM_BIN) install --lts

brew-packages: brew
	$(BREW_BIN) bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	$(BREW_BIN) bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done
	xattr -d -r com.apple.quarantine ~/Library/QuickLook

node-packages: npm
	eval $$(fnm env); npm install -g $(shell cat install/npmfile)


