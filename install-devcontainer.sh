#!/bin/sh

rm $HOME/.zshrc
rm $HOME/.zprofile

stow -t $HOME --no-folding git
stow -t $HOME --no-folding nvim
stow -t $HOME --no-folding opencode
stow -t $HOME --no-folding ssh
stow -t $HOME --no-folding zsh