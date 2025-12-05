source "$XDG_CONFIG_HOME/zsh/shell"
source "$XDG_CONFIG_HOME/zsh/init"
source "$XDG_CONFIG_HOME/zsh/aliases"
[[ -r "$XDG_CONFIG_HOME/zsh/secrets" ]] && source "$XDG_CONFIG_HOME/zsh/secrets"

# Work specific configs
if [ -f "$XDG_CONFIG_HOME/zsh/monzo" ] && [ "$USE_MONZO" = true ]; then
    source $XDG_CONFIG_HOME/zsh/monzo
fi

# Preferred editor for local and remote sessions
export EDITOR='vim'
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='zed --wait'
# fi
# export EDITOR="code --wait"

# Appease Monzo ios autosetup scripts. This is included in $XDG_CONFIG_HOME/zsh/monzo
# eval "$(rbenv init -)"
# Activate Mise
# eval "$(mise activate zsh)"

