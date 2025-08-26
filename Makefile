.PHONY: mkdirs install-stow zsh clean

# Home directory
HOME ?= ~
# Installation prefix
PREFIX ?= $(HOME)/.local
# Source directory for downloaded packages
SRC ?= $(HOME)/.local/src

all: mkdirs install-stow zsh

mkdirs:
	mkdir -p $(SRC)
	mkdir -p $(PREFIX)

    # Add $(PREFIX)/bin to PATH
	if ! echo "$$PATH" | grep -q "$(PREFIX)/bin"; then \
		echo 'export PATH="$(PREFIX)/bin:$$PATH"' >> $(HOME)/.profile; \
	fi

install-stow: mkdirs
	@echo "Installing GNU stow..."
	wget "http://ftpmirror.gnu.org/gnu/stow/stow-latest.tar.gz" -O $(SRC)/stow-latest.tar.gz
	tar -xf $(SRC)/stow-latest.tar.gz -C $(SRC)
	cd $(SRC)/stow-* && ./configure --prefix=$(PREFIX) && make && make install

$(HOME)/.antidote:
    # Install antidote
	@echo "Installing zsh/antidote..."
	git clone --depth=1 "https://github.com/mattmc3/antidote.git" $(HOME)/.antidote

zsh: $(HOME)/.antidote install-stow
    # Build and install zsh
ifeq ($(shell which zsh),)
		@echo "zsh not found, building and installing from source..."
		wget "https://github.com/zsh-users/zsh/archive/refs/tags/zsh-5.9.0.2-test.tar.gz" -O $(SRC)/zsh-5.9.0.2-test.tar.gz
		tar -xf $(SRC)/zsh-5.9.0.2-test.tar.gz -C $(SRC)
		cd $(SRC)/zsh-zsh-* && ./Util/preconfig && ./configure --prefix=$(PREFIX) && make && make install
    else
		@echo "zsh is already installed."
    endif

    # Stow zsh configs
	stow --target=$(HOME) zsh

    # Build antidote cache
	echo "source $(HOME)/.antidote/antidote.zsh; antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh" | zsh

    # Tips for changing the login shell to zsh
	@echo "To change your login shell to zsh, run the following command:" \
	"\n  chsh -s $(shell which zsh)" \
	"\n\nOR put the following line in your ~/.profile to launch zsh on login:" \
	"\n  [ -f $(PREFIX)/bin/zsh ] && exec $(PREFIX)/bin/zsh -l"
	
clean:
    # Remove source files
	rm -rf $(SRC)/*
    # Remove antidote directory
	rm -rf $(HOME)/.antidote
    # Remove stow symlinks
	stow --target=$(HOME) -D zsh