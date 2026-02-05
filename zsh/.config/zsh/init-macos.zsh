# Homebrew loads from different places on x86 and arm
if [ arm64 = `uname -m` ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
[ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh

export PATH="$HOME/.docker/bin:$PATH"

# bun
BUN_INSTALL="$HOME/.bun"
case ":$PATH:" in
  *":$BUN_INSTALL/bin:"*) ;;
  *) export PATH="$BUN_INSTALL/bin:$PATH" ;;
esac
# bun end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jacobroberts/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jacobroberts/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jacobroberts/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jacobroberts/google-cloud-sdk/completion.zsh.inc'; fi
