# Important to go first, so we can source homebrew
if [ Darwin = `uname` ]; then
  source "$XDG_CONFIG_HOME/zsh/init-macos.zsh"
fi

if [ Linux = `uname` ]; then
  source "$XDG_CONFIG_HOME/zsh/init-linux.zsh"
fi

# Load zinit for plugin management
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load zsh completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Completion styling
# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

if command -v nvim &> /dev/null; then
  export EDITOR='nvim'
elif command -v vim &> /dev/null; then
  export EDITOR='vim'
fi

export PATH="$HOME/bin:$PATH"