#############
### MONZO ###
#############

alias listemulators='~/Library/Android/sdk/emulator/emulator -list-avds'
alias openemulator='~/Library/Android/sdk/emulator/emulator -avd Pixel_8_API_34'
alias emulator='openemulator'

# Monzo Setup
export GOPATH=$HOME
export GOROOT="/opt/homebrew/opt/go/libexec"
export PATH="/opt/homebrew/opt/go/bin:$PATH"

[ -f ${GOPATH}/src/github.com/monzo/starter-pack/zshrc ] && source $GOPATH/src/github.com/monzo/starter-pack/zshrc

# Android Studio setup
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$PATH:${HOME}/Library/Android/sdk/platform-tools"
# ANDROID_HOME is used by gradle when an sdk path is not specified in another way
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator":"$ANDROID_HOME/tools":"$ANDROID_HOME/platform-tools":$PATH

# Added by Toolbox App
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# Created by `pipx` on 2024-06-02 21:39:55
export PATH="$PATH:$HOME/.local/bin"

alias tg='mise x -- tuist generate'
alias ti='mise x -- tuist install'
alias ss="gh pr list -A "@me" -s all | fzf | awk '{print $1}' | xargs shipper deploy --s101"
alias sp="gh pr list -A "@me" -s all | fzf | awk '{print $1}' | xargs shipper deploy --prod"
alias lintwearedev="$GOPATH/bin/lint"

function git-go-test-all-changed-services() {
  local services=`git diff master --name-only  | cut -d'/' -f1 | uniq`
  echo Testing: $services
  echo $services | xargs -I % go test ./%/...
}
alias gt=git-go-test-all-changed-services

function updatexcode() {
  echo "Should be run from ios-app directory"
  LATEST_VALID_XCODE=$(xcodes list | grep -v Beta | grep -v Candidate | grep -v GM | grep -F $TUIST_XCODE_VERSION | tail -n1 | awk '{print $1}')
  echo "Latest valid Xcode version: $LATEST_VALID_XCODE"
  xcodes install "$LATEST_VALID_XCODE" --experimental-unxip
  xcodes select $LATEST_VALID_XCODE
}

rpcmap-all() {
  $XDG_CONFIG_HOME/zsh/rpcmap-all --diff
}

worktree() {
        # This shell function is provided by Monzo's Worktree tool.
        # It wraps the 'worktree' command to change the shell's working
        # directory.
        #
        # github.com/monzo/wearedev/tools/worktree

        if [[ "$1" == "path" ]] && ! [ -x "$(command -v worktree)" ]; then
                # Worktree should be installed by Monzo Developer Tools but I
                # imagine it's possible to depend on 'worktree path wearedev'
                # before it's installed. This path is hard coded to the path
                # set by the engineering onboarding scripts, and attempts to
                # use the project argument, or "wearedev" if none is given.
                echo "$GOPATH/src/github.com/monzo/${2:-wearedev}"
                return $?
        fi

    case "$1" in
        path|shell)
            # These commands never require the tmp file so don't bother creating it.
            # Especially a concern for the path command as it's used so frequently.
            command worktree "$@"
            return $?;;
    esac

    local tempfile=$(mktemp "${TMPDIR:-/tmp/}worktree.XXXXXX")
    command worktree "$@" --tmp-output="$tempfile"
    local exit_code=$?

    if [[ $exit_code -eq 0 && -e $tempfile ]]; then
        local worktree_path=$(command head -1 "$tempfile")
        cd "$worktree_path"
    fi

    return $exit_code
}
