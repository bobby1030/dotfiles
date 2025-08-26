.PHONY: all mkdirs install-stow install-zsh zsh install-uv install-tmux tmux clean

# Home directory
HOME ?= ~
# Installation prefix
PREFIX ?= $(HOME)/.local
# Source directory for downloaded packages
SRC ?= $(HOME)/.local/src
# Search PATH for executables
export PATH := $(PREFIX)/bin:$(PATH)

# Whether to install zsh into local directory
INSTALL_ZSH ?= $(if $(shell which zsh),0,1)

# Whether to install tmux to local directory
INSTALL_TMUX ?= $(if $(shell which tmux),0,1)

all: mkdirs install-stow install-uv zsh tmux

mkdirs:
	mkdir -p $(SRC)
	mkdir -p $(PREFIX)

    # Add $(PREFIX)/bin to PATH in .profile if not already present
	if ! grep -q "$(PREFIX)/bin" $(HOME)/.profile 2>/dev/null; then \
		echo 'export PATH="$(PREFIX)/bin:$$PATH"' >> $(HOME)/.profile; \
	fi

install-stow: mkdirs
ifeq ($(shell which stow),)
		@echo "Installing GNU stow..."
		wget "http://ftpmirror.gnu.org/gnu/stow/stow-2.4.1.tar.gz" -O $(SRC)/stow-2.4.1.tar.gz
		tar -xf $(SRC)/stow-2.4.1.tar.gz -C $(SRC)
		cd $(SRC)/stow-2.4.1 && ./configure --prefix=$(PREFIX) && make && make install
    else
		@echo "GNU stow is already installed."
    endif

$(HOME)/.antidote:
    # Install antidote
	@echo "Installing zsh/antidote..."
	git clone --depth=1 "https://github.com/mattmc3/antidote.git" $(HOME)/.antidote

install-zsh:
    # Build and install zsh
ifeq ($(INSTALL_ZSH),1)
		@echo "zsh not found, building and installing from source..."
		wget "https://github.com/zsh-users/zsh/archive/refs/tags/zsh-5.9.0.2-test.tar.gz" -O $(SRC)/zsh-5.9.0.2-test.tar.gz
		tar -xf $(SRC)/zsh-5.9.0.2-test.tar.gz -C $(SRC)
		cd $(SRC)/zsh-zsh-5.9.0.2-test && ./Util/preconfig && ./configure --prefix=$(PREFIX) && make && make install.bin install.modules install.fns
    else
		@echo "zsh is already installed."
    endif

zsh: $(HOME)/.antidote install-stow install-zsh
    # Stow zsh configs
	stow --target=$(HOME) zsh

    # Build antidote cache
	echo "source $(HOME)/.antidote/antidote.zsh; antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh" | zsh

    # Tips for changing the login shell to zsh
	@echo "To change your login shell to zsh, run the following command:" \
	"\n  chsh -s $$(which zsh)" \
	"\n\nOR put the following line in your ~/.profile to launch zsh on login:" \
	"\n  [ -f $$(which zsh) ] && exec $$(which zsh) -l"

install-uv:
ifeq ($(shell which uv),)
	wget -O - https://astral.sh/uv/install.sh | sh
    endif

install-tmux:
    # Build and install tmux
ifeq ($(INSTALL_TMUX),1)
		@echo "tmux not found, installing static build of tmux from mjakob-gh/build-static-tmux..."
		wget "https://github.com/mjakob-gh/build-static-tmux/releases/download/v3.5d/tmux.linux-amd64.stripped.gz" -O $(SRC)/tmux.gz
		gunzip -c $(SRC)/tmux.gz > $(SRC)/tmux && chmod +x $(SRC)/tmux && mv $(SRC)/tmux $(PREFIX)/bin/tmux
    else
		@echo "tmux is already installed."
    endif

~/.tmux/plugins/tpm:
    # Install tmux plugin manager
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux: install-stow install-tmux install-uv ~/.tmux/plugins/tpm
    # Stow tmux configs
	stow --target=$(HOME) tmux

    # Install powerline
	uv tool install powerline-status

clean:
    # Remove source files
	rm -rf $(SRC)/*
    # Remove antidote directory
	rm -rf $(HOME)/.antidote
    # Remove stow symlinks
	stow --target=$(HOME) -D zsh
	stow --target=$(HOME) -D tmux