#!/bin/sh

# if stow is installed, use it to install the dotfiles
if command -v stow >/dev/null 2>&1; then
    stow --no-folding ghostty
    stow --no-folding git
    stow --no-folding nvim
    stow --no-folding opencode
    stow --no-folding ssh
    stow --no-folding uwsm
    stow --no-folding vscodium
    stow --no-folding zed
    stow --no-folding zsh
else
    echo "stow is not installed"
fi