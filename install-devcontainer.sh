#!/bin/sh

rm $HOME/.zshrc
rm $HOME/.zprofile

stow --no-folding git
stow --no-folding nvim
stow --no-folding opencode
stow --no-folding ssh
stow --no-folding zsh