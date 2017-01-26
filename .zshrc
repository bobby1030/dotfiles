source ~/antigen/antigen.zsh

# Load the prezto's library.
antigen use oh-my-zsh 

antigen bundle git
antigen bundle npm
antigen bundle fasd
antigen bundle command-not-found
antigen bundle sudo

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme agnoster/agnoster-zsh-theme agnoster

# Tell antigen that you're done.
antigen apply

# Load TMUX automatically
tmux attach &> /dev/null

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

export NVM_DIR="/home/bobbyho/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Aliases
alias dl="cd ~/Downloads"

# Theme Configs
DEFAULT_USER=bobbyho

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /home/bobbyho/.yarn-config/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /home/bobbyho/.yarn-config/global/node_modules/tabtab/.completions/yarn.zsh