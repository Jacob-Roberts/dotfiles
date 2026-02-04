[[ -r "$XDG_CONFIG_HOME/zsh/init-shared.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/init-shared.zsh"
[[ -r "$XDG_CONFIG_HOME/zsh/aliases.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
[[ -r "$XDG_CONFIG_HOME/zsh/secrets.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/secrets.zsh"

# Work specific configs
if [ -r "$XDG_CONFIG_HOME/zsh/monzo.zsh" ] && [ "$USE_MONZO" = true ]; then
    source $XDG_CONFIG_HOME/zsh/monzo.zsh
fi

# Appease Monzo ios autosetup scripts. This is included in $XDG_CONFIG_HOME/zsh/monzo
# eval "$(rbenv init -)"
# Activate Mise
# eval "$(mise activate zsh)"
