source "$XDG_CONFIG_HOME/zsh/oh-my-zsh"
source "$XDG_CONFIG_HOME/zsh/aliases"
[[ -r "$XDG_CONFIG_HOME/zsh/secrets" ]] && source "$XDG_CONFIG_HOME/zsh/secrets"

if [ Darwin = `uname` ]; then
  source "$XDG_CONFIG_HOME/zsh/macos"
fi

if [ Linux = `uname` ]; then
  source "$XDG_CONFIG_HOME/zsh/linux"
fi

# Work specific configs
if [ -f "$HOME/.monzozshrc" ] && [ "$USE_MONZO" = true ]; then
    source $HOME/.monzozshrc
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

