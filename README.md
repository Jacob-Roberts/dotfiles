# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems (should install on e.g. Ubuntu as well for many tools, config and aliases etc).

.zshenv is used for non-synced config

To install, clone the repo to `$HOME/.dotfiles` and then run `stow --no-folding zsh`, `stow --no-folding git`, `stow --no-folding ghostty`, `stow --no-folding zed`, etc.

To remove a symlink, run `stow -D zsh` or `stow -D git`
