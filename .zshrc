source ~/antigen/antigen.zsh

# Load the prezto's library.
antigen use prezto 

antigen bundle sorin-ionescu/prezto modules/helper
antigen bundle sorin-ionescu/prezto modules/utility
antigen bundle sorin-ionescu/prezto modules/editor
antigen bundle sorin-ionescu/prezto modules/git
antigen bundle sorin-ionescu/prezto modules/completion
antigen bundle sorin-ionescu/prezto modules/fasd
antigen bundle sorin-ionescu/prezto modules/autosuggestions
antigen bundle sorin-ionescu/prezto modules/prompt

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle soimort/you-get

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
DEFAULT_USER=bobbyho
