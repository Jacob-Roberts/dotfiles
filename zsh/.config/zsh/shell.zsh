# Ignoring specific Infisical CLI commands
DEFAULT_HISTIGNORE=$HISTIGNORE
export HISTIGNORE="*infisical secrets set*:$DEFAULT_HISTIGNORE"

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt appendhistory          # append to history file instead of overwriting
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_all_dups   # delete all previous duplicates of a command when adding a new entry
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_save_no_dups      # don't write duplicates to history file
setopt hist_find_no_dups      # don't display duplicates in history search
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
