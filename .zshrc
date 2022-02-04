#source <(antibody init)

#antibody bundle < ~/.zsh_plugins

source ~/.zsh_plugins.sh

# Load the oh-my-zsh library
# antigen use ohmyzsh/ohmyzsh 

# antigen bundle git
# antigen bundle npm
# antigen bundle z
# antigen bundle command-not-found
# antigen bundle sudo

# antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle zsh-users/zsh-syntax-highlighting

# # Load the theme.
# antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure

# # Tell antigen that you're done.
# antigen apply

# Load TMUX automatically
tmux attach &> /dev/null

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

# Aliases
alias dl="cd ~/Downloads"

# Theme Configs
DEFAULT_USER=bobbyho

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH=~/.yarn/bin:$PATH

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin

export PATH="/usr/local/stata14:$PATH"

export VISUAL="nano"
export EDITOR="nano"

export PATH=$PATH:$HOME/Android/Sdk/platform-tools
export PATH=$PATH:$HOME/Android/Sdk/emulator
export PATH="$PATH:$HOME/.spicetify"
