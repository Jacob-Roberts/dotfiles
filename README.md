# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems (should install on e.g. Ubuntu as well for many tools, config and aliases etc).

.zshenv is used for non-synced config

To install, clone the repo to `$HOME/.dotfiles` and then run `stow zsh`, `stow git`, `stow ghostty`, `stow zed`, etc.

To remove a symlink, run `stow -D zsh` or `stow -D git`

## Homebrew

`brew bundle install --file=./brew/Brewfile`

To create the brewfile

`brew bundle dump --describe --no-vscode`
