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

WORDCHARS=''

# -------------------------------------------
# chpwd Hook - Run Commands on Directory Change
# -------------------------------------------
# NOTE: Only one chpwd hook can be defined at once
# To merge them, use add-zsh-hook which is mentioned below

# Example: List directory contents on cd
chpwd() {
  # Define the directories you want to ignore
  local ignore_dirs=("$HOME/Downloads" "$HOME/src/github.com/monzo/wearedev")

  # Check if the current directory is in the list
  for dir in "${ignore_dirs[@]}"; do
    if [[ "$PWD" == "$dir" ]]; then
      return
    fi
  done

  [[ "$PWD" == $HOME/src/github.com/monzo/* ]] && return
  
  ls
}
