# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems (should install on e.g. Ubuntu as well for many tools, config and aliases etc).

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew, Caskroom and Node.js, latest Zsh + GNU Utils
- Oh my zsh
- Updated macOS defaults
- Well-organized and easy to customize
- The installation and runcom setup is
  [tested weekly on real Ubuntu and macOS machines](https://github.com/webpro/dotfiles/actions)
  (Big Sur/11, Monterey/12) using [a GitHub Action](./.github/workflows/dotfiles-installation.yml)
  (currently on Ventura/13 myself)
- Supports both Apple Silicon (M1) and Intel chips

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./installManifest/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./installManifest/Caskfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./installManifest/npmfile))
- Latest Git, zsh, Python, GNU coreutils, curl, Ruby
<!-- - [Mackup](https://github.com/lra/mackup) (sync application settings) -->
<!-- - `$EDITOR` is [GNU nano](https://www.nano-editor.org) (`$VISUAL` is `code` and Git `core.editor` is `code --wait`) -->

## Installation

On a sparkling fresh installation of macOS:

```zsh
sudo softwareupdate -i -a
xcode-select --install
```

The Xcode Command Line Tools includes `git` (not available on stock macOS). Now there are two options:

1. Install this repo with `curl` available:

```zsh
zsh -c "`curl -fsSL https://raw.githubusercontent.com/jacob-roberts/dotfiles/main/remote-install.sh`"
```

This will clone or download this repo to `~/.dotfiles` (depending on the availability of `git`, `curl` or `wget`).

1. Alternatively, clone manually into the desired location:

```zsh
git clone https://github.com/jacob-roberts/dotfiles.git ~/.dotfiles
```

Use the [setup.sh](./setup.sh) to install the [packages listed above](#packages-overview), and symlink
[zsh](./zsh) and [config](./config) files (using `ln -s`):

```zsh
cd ~/.dotfiles
./setup.sh
```

## Customize

To customize the dotfiles to your likings, fork it and make sure to modify the locations above to your fork.

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
