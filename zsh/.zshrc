source ${ZDOTDIR:-~}/.antidote/antidote.zsh
source ~/.zsh_plugins.zsh

# Load TMUX automatically
if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && [ -z "${VSCODE_TERMINAL}" ]; then
    tmux attach || tmux >/dev/null 2>&1
fi

# Editor configs
export VISUAL="nano"
export EDITOR="nano"

# Aliases
alias dl="cd ~/Downloads"

# Theme Configs
DEFAULT_USER=bobbyho

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Stata Path
export PATH="/usr/local/stata17:$PATH"

# Rust cargo path
export PATH=$PATH:$HOME/.cargo/bin

# uv autocomplete
if [ -x "$(command -v uv)" ]; then
    eval "$(uv generate-shell-completion zsh)"
fi

# URL decode
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/bobbyho/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# Pixi Path
export PATH="/home/bobbyho/.pixi/bin:$PATH"
