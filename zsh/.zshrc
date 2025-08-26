source ${ZDOTDIR:-~}/.antidote/antidote.zsh
#antidote load
source ~/.zsh_plugins.zsh

# Aliases
alias dl="cd ~/Downloads"

# Theme Configs
DEFAULT_USER=bobbyho

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH=~/.yarn/bin:$PATH

# Go Path
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin

# Stata Path
export PATH="/usr/local/stata17:$PATH"

# Rust cargo path
export PATH=$PATH:$HOME/.cargo/bin

export VISUAL="nano"
export EDITOR="nano"

export PATH=$PATH:$HOME/Android/Sdk/platform-tools
export PATH=$PATH:$HOME/Android/Sdk/emulator

# Load TMUX automatically
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ] && [ -z "${VSCODE_TERMINAL}" ]; then
    tmux attach || tmux >/dev/null 2>&1
fi

# URL decode
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/home/bobbyho/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bobbyho/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bobbyho/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/bobbyho/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bobbyho/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/bobbyho/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
export PATH="/home/bobbyho/.pixi/bin:$PATH"
