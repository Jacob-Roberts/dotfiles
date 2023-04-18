# Set PATH, MANPATH, etc., for Homebrew.
if [[ "$OSTYPE" =~ ^darwin ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
