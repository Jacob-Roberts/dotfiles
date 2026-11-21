[[ -r "$XDG_CONFIG_HOME/zsh/shell.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/shell.zsh"
[[ -r "$XDG_CONFIG_HOME/zsh/key-bindings.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/key-bindings.zsh"
[[ -r "$XDG_CONFIG_HOME/zsh/secrets.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/secrets.zsh"
# Work specific configs (put USE_XXX in /etc/zshenv)
if [ -r "$XDG_CONFIG_HOME/zsh/monzo.zsh" ] && [ "$USE_MONZO" = true ]; then
    source $XDG_CONFIG_HOME/zsh/monzo.zsh
fi
if [ -r "$XDG_CONFIG_HOME/zsh/oracle.zsh" ] && [ "$USE_ORACLE" = true ]; then
    source $XDG_CONFIG_HOME/zsh/oracle.zsh
fi
[[ -r "$XDG_CONFIG_HOME/zsh/init-shared.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/init-shared.zsh"
[[ -r "$XDG_CONFIG_HOME/zsh/aliases.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
