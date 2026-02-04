# Ignoring specific Infisical CLI commands
DEFAULT_HISTIGNORE=$HISTIGNORE
export HISTIGNORE="*infisical secrets set*:$DEFAULT_HISTIGNORE"

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
